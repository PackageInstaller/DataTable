#include <algorithm>
#include <cstdint>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <optional>
#include <span>
#include <stdexcept>
#include <string>
#include <string_view>
#include <thread>
#include <utility>
#include <vector>

#include <fcntl.h>
#include <openssl/evp.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <zlib.h>

namespace fs = std::filesystem;

static constexpr std::string_view kMagic = "pixelneko filesystem";
static constexpr size_t kHdr = 0x19;
static constexpr size_t kLz4BlockOut = 0x8000;
static constexpr uint8_t kFlagRaw = 0;
static constexpr uint8_t kFlagLz4 = 2;

static constexpr uint8_t kChaChaKey[32] = {
    0xa5, 0x05, 0x7f, 0x03, 0xaa, 0x62, 0x82, 0x9a, 0xc7, 0xdc, 0x4c, 0x64, 0xf9, 0xf7, 0xf4, 0x28,
    0xb4, 0x14, 0xe7, 0x15, 0x16, 0xe2, 0xc3, 0xa8, 0xde, 0x9c, 0x77, 0xf9, 0x88, 0x0f, 0x2e, 0xd4};
static constexpr uint8_t kChaChaNonce[8] = {0x02, 0x00, 0x01, 0x09, 0x01, 0x00, 0x01, 0x00};

struct MMap
{
  const uint8_t *p = nullptr;
  size_t n = 0;
  int fd = -1;
  MMap() = default;
  MMap(const MMap &) = delete;
  MMap &operator=(const MMap &) = delete;
  MMap(MMap &&o) noexcept : p(o.p), n(o.n), fd(o.fd)
  {
    o.p = nullptr;
    o.n = 0;
    o.fd = -1;
  }
  MMap &operator=(MMap &&o) noexcept
  {
    if (this != &o)
    {
      this->~MMap();
      p = o.p;
      n = o.n;
      fd = o.fd;
      o.p = nullptr;
      o.n = 0;
      o.fd = -1;
    }
    return *this;
  }
  ~MMap()
  {
    if (p && p != MAP_FAILED)
      munmap(const_cast<uint8_t *>(p), n);
    if (fd >= 0)
      close(fd);
  }
  static std::optional<MMap> open_file(const fs::path &path)
  {
    MMap m;
    m.fd = ::open(path.c_str(), O_RDONLY);
    if (m.fd < 0)
      return std::nullopt;
    struct stat st{};
    if (fstat(m.fd, &st) || st.st_size <= 0)
      return std::nullopt;
    m.n = size_t(st.st_size);
    void *q = mmap(nullptr, m.n, PROT_READ, MAP_PRIVATE, m.fd, 0);
    if (q == MAP_FAILED)
      return std::nullopt;
    m.p = static_cast<const uint8_t *>(q);
    return m;
  }
  std::span<const uint8_t> span() const { return {p, n}; }
};

struct Cursor
{
  std::span<const uint8_t> data;
  size_t pos = 0;
  bool eof() const { return pos >= data.size(); }
  uint8_t u8()
  {
    if (eof())
      throw std::runtime_error("eof");
    return data[pos++];
  }
  std::span<const uint8_t> bytes(size_t n)
  {
    if (pos + n > data.size())
      throw std::runtime_error("eof");
    auto s = data.subspan(pos, n);
    pos += n;
    return s;
  }
};

static uint64_t read_varint(Cursor &c)
{
  uint64_t x = 0;
  int s = 0;
  for (;;)
  {
    uint8_t b = c.u8();
    x |= uint64_t(b & 0x7f) << s;
    if ((b & 0x80) == 0)
      return x;
    s += 7;
    if (s > 63)
      throw std::runtime_error("varint overflow");
  }
}

static uint32_t ror32(uint32_t x) { return (x >> 1) | (x << 31); }
static uint64_t ror64(uint64_t x) { return (x >> 1) | (x << 63); }
static uint64_t read_varint_ror64(Cursor &c) { return ror64(read_varint(c)); }
static uint32_t read_varint_ror32(Cursor &c) { return ror32(uint32_t(read_varint(c))); }

static void chacha20_xor(uint8_t *data, size_t len, uint64_t counter)
{
  for (size_t off = 0; off < len;)
  {
    uint8_t iv[16];
    for (int i = 0; i < 8; ++i)
      iv[i] = uint8_t((counter >> (8 * i)) & 0xff);
    std::memcpy(iv + 8, kChaChaNonce, 8);
    size_t chunk = std::min(size_t(64), len - off);

    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    if (!ctx)
      throw std::runtime_error("EVP_CIPHER_CTX_new");
    if (EVP_EncryptInit_ex(ctx, EVP_chacha20(), nullptr, kChaChaKey, iv) != 1)
    {
      EVP_CIPHER_CTX_free(ctx);
      throw std::runtime_error("EVP_EncryptInit_ex");
    }
    int outl = 0;
    if (EVP_EncryptUpdate(ctx, data + off, &outl, data + off, int(chunk)) != 1)
    {
      EVP_CIPHER_CTX_free(ctx);
      throw std::runtime_error("EVP_EncryptUpdate");
    }
    EVP_CIPHER_CTX_free(ctx);
    off += chunk;
    ++counter;
  }
}

struct CdBlock
{
  uint64_t x = 0;
  uint64_t y = 0;
};

struct CdEntry
{
  std::string name;
  uint8_t flags = 0;
  uint64_t uncomp = 0;
  uint64_t stored = 0;
  uint32_t crc = 0;
  uint64_t offset = 0;
  std::vector<CdBlock> blocks;
};

static std::vector<CdEntry> parse_central_directory(std::span<const uint8_t> file)
{
  if (file.size() < kHdr + 10 ||
      std::string_view(reinterpret_cast<const char *>(file.data()), kMagic.size()) != kMagic)
    throw std::runtime_error("invalid nekoData header");
  uint8_t window[10];
  std::memcpy(window, file.data() + file.size() - 10, 10);
  std::reverse(window, window + 10);

  Cursor fc{{window, 10}, 0};
  size_t before = fc.pos;
  uint32_t cd_size = read_varint_ror32(fc);
  size_t varint_len = fc.pos - before;
  if (cd_size == 0 || varint_len == 0 || varint_len > 5)
    throw std::runtime_error("bad central directory size");
  if (file.size() < kHdr + cd_size + varint_len)
    throw std::runtime_error("file too small for central directory");

  size_t cd_off = file.size() - varint_len - cd_size;
  if (cd_off < kHdr || cd_off + cd_size + varint_len != file.size())
    throw std::runtime_error("central directory bounds");

  std::vector<uint8_t> plain(file.begin() + ptrdiff_t(cd_off),
                             file.begin() + ptrdiff_t(cd_off + cd_size));
  chacha20_xor(plain.data(), plain.size(), cd_size);

  Cursor c{{plain.data(), plain.size()}, 0};
  uint64_t count = read_varint_ror64(c);
  if (count > 1'000'000)
    throw std::runtime_error("bad entry count");

  std::vector<CdEntry> out;
  out.reserve(size_t(count));
  for (uint64_t i = 0; i < count; ++i)
  {
    CdEntry e;
    uint32_t nlen = read_varint_ror32(c);
    if (nlen > 16384)
      throw std::runtime_error("name too long");
    auto nb = c.bytes(nlen);
    e.name.assign(reinterpret_cast<const char *>(nb.data()), nb.size());
    e.flags = c.u8();
    if (e.flags != kFlagRaw && e.flags != kFlagLz4)
      throw std::runtime_error("unknown flags in " + e.name);
    e.uncomp = read_varint_ror64(c);
    e.stored = e.flags ? read_varint_ror64(c) : e.uncomp;
    e.crc = uint32_t(read_varint(c));
    e.offset = read_varint(c);
    uint32_t nblk = read_varint_ror32(c);
    if (nblk > 100000)
      throw std::runtime_error("bad nblocks");
    e.blocks.resize(nblk);
    for (uint32_t b = 0; b < nblk; ++b)
    {
      e.blocks[b].x = read_varint_ror64(c);
      e.blocks[b].y = read_varint_ror64(c);
    }
    if (nblk == 0)
      e.blocks.push_back({0, 0});
    else if (e.blocks[0].x != 0 || e.blocks[0].y != 0)
      throw std::runtime_error("block table must start at (0,0): " + e.name);
    if (e.offset < kHdr || e.offset + e.stored > cd_off)
      throw std::runtime_error("entry out of range: " + e.name);
    out.push_back(std::move(e));
  }
  if (!c.eof())
    throw std::runtime_error("trailing central directory bytes");
  return out;
}

static std::vector<uint8_t> lz4_unit(std::span<const uint8_t> in, size_t uncomp)
{
  Cursor c{in, 0};
  std::vector<uint8_t> out;
  out.reserve(uncomp);
  auto need = [&](size_t n)
  {
    if (c.pos + n > c.data.size())
      throw std::runtime_error("lz4 eof");
  };
  while (out.size() < uncomp)
  {
    uint8_t tok = c.u8();
    int lit = tok >> 4;
    int mat = (tok & 0xf) + 4;
    if (lit == 0xf)
    {
      uint8_t e;
      do
      {
        e = c.u8();
        lit += e;
      } while (e == 0xff);
    }
    need(size_t(lit));
    auto lb = c.bytes(size_t(lit));
    out.insert(out.end(), lb.begin(), lb.end());
    if (out.size() >= uncomp)
      break;
    if (c.eof() || c.pos + 2 > c.data.size())
      break;
    need(2);
    auto ob = c.bytes(2);
    int off = int(ob[0]) | (int(ob[1]) << 8);
    if (mat == 0xf + 4)
    {
      uint8_t e;
      do
      {
        e = c.u8();
        mat += e;
      } while (e == 0xff);
    }
    if (off <= 0 || size_t(off) > out.size())
      throw std::runtime_error("lz4 bad match");
    size_t from = out.size() - size_t(off);
    for (int i = 0; i < mat; ++i)
      out.push_back(out[from + size_t(i)]);
  }
  if (out.size() > uncomp)
    out.resize(uncomp);
  if (out.size() != uncomp)
    throw std::runtime_error("lz4 size mismatch");
  return out;
}

static std::vector<uint8_t> lz4_decompress_blocks(std::span<const uint8_t> stored, size_t uncomp,
                                                  const std::vector<CdBlock> &blocks)
{
  std::vector<uint8_t> out;
  out.reserve(uncomp);
  const size_t n = blocks.size();
  for (size_t i = 0; i < n; ++i)
  {
    uint64_t x0 = blocks[i].x, y0 = blocks[i].y;
    uint64_t x1 = (i + 1 < n) ? blocks[i + 1].x : stored.size();
    uint64_t y1 = (i + 1 < n) ? blocks[i + 1].y : uncomp;
    if (x1 < x0 || y1 < y0 || x1 > stored.size() || y1 > uncomp)
      throw std::runtime_error("bad block extents");
    size_t want = size_t(y1 - y0);
    if (want > kLz4BlockOut)
      throw std::runtime_error("lz4 block too large");
    auto part = lz4_unit(stored.subspan(size_t(x0), size_t(x1 - x0)), want);
    out.insert(out.end(), part.begin(), part.end());
  }
  if (out.size() != uncomp)
    throw std::runtime_error("lz4 total size mismatch");
  return out;
}

struct Extracted
{
  std::string path;
  std::vector<uint8_t> data;
};

static std::vector<Extracted> extract_all(std::span<const uint8_t> file)
{
  auto entries = parse_central_directory(file);
  std::vector<Extracted> out;
  out.reserve(entries.size());
  for (auto &e : entries)
  {
    auto stored = file.subspan(size_t(e.offset), size_t(e.stored));
    if (uint32_t(crc32(0L, stored.data(), uInt(stored.size()))) != e.crc)
      throw std::runtime_error("crc mismatch: " + e.name);
    std::vector<uint8_t> data;
    if (e.flags == kFlagRaw)
    {
      data.assign(stored.begin(), stored.end());
    }
    else
    {
      data = lz4_decompress_blocks(stored, size_t(e.uncomp), e.blocks);
    }
    out.push_back({std::move(e.name), std::move(data)});
  }
  return out;
}

static void write_files(const fs::path &out, std::vector<Extracted> &files)
{
  auto worker = [&](size_t b, size_t e)
  {
    for (size_t i = b; i < e; ++i)
    {
      auto &f = files[i];
      fs::path dest = out / f.path;
      std::error_code ec;
      fs::create_directories(dest.parent_path(), ec);
      std::ofstream ofs(dest, std::ios::binary);
      ofs.write(reinterpret_cast<const char *>(f.data.data()), std::streamsize(f.data.size()));
    }
  };
  size_t n = files.size();
  unsigned hw = std::max(1u, std::thread::hardware_concurrency());
  size_t jobs = std::min(n, size_t(std::min(hw, 16u)));
  if (jobs <= 1 || n < 32)
  {
    worker(0, n);
    return;
  }
  std::vector<std::thread> th;
  size_t chunk = (n + jobs - 1) / jobs;
  for (size_t t = 0; t < jobs; ++t)
  {
    size_t b = t * chunk, e = std::min(n, b + chunk);
    if (b >= e)
      break;
    th.emplace_back(worker, b, e);
  }
  for (auto &x : th)
    x.join();
}

static int extract_one(const fs::path &in, const fs::path &out)
{
  auto mm = MMap::open_file(in);
  if (!mm)
  {
    std::cerr << "open fail: " << in << "\n";
    return 1;
  }
  try
  {
    auto files = extract_all(mm->span());
    fs::create_directories(out);
    write_files(out, files);
    std::cerr << "extracting: " << in << " (" << files.size() << " files)\n";
    return 0;
  }
  catch (const std::exception &e)
  {
    std::cerr << "failed: " << in << ": " << e.what() << "\n";
    return 1;
  }
}

static void self_check()
{
  uint8_t zeros[64]{};
  uint8_t key0[32];
  uint8_t nonce0[8];
  for (int i = 0; i < 32; ++i)
    key0[i] = uint8_t(i);
  for (int i = 0; i < 8; ++i)
    nonce0[i] = uint8_t(i);
  uint8_t iv[16]{};
  std::memcpy(iv + 8, nonce0, 8);
  EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
  EVP_EncryptInit_ex(ctx, EVP_chacha20(), nullptr, key0, iv);
  uint8_t out[64];
  int outl = 0;
  EVP_EncryptUpdate(ctx, out, &outl, zeros, 64);
  EVP_CIPHER_CTX_free(ctx);
  static constexpr uint8_t expect[16] = {0xf7, 0x98, 0xa1, 0x89, 0xf1, 0x95, 0xe6, 0x69,
                                         0x82, 0x10, 0x5f, 0xfb, 0x64, 0x0b, 0xb7, 0x75};
  if (std::memcmp(out, expect, 16) != 0)
    throw std::runtime_error("chacha self-check failed");
}

int main(int argc, char **argv)
{
  try
  {
    self_check();
  }
  catch (const std::exception &e)
  {
    std::cerr << e.what() << "\n";
    return 1;
  }

  fs::path out = "output";
  std::vector<fs::path> inputs;
  for (int i = 1; i < argc; ++i)
  {
    std::string a = argv[i];
    if ((a == "-o" || a == "--output") && i + 1 < argc)
    {
      out = argv[++i];
    }
    else if (a == "-h" || a == "--help")
    {
      std::cerr << "usage: nekoextract -o OUTDIR file.nekodata...\n";
      return 0;
    }
    else
    {
      inputs.emplace_back(a);
    }
  }
  if (inputs.empty())
  {
    std::cerr << "usage: nekoextract -o OUTDIR file.nekodata...\n";
    return 2;
  }
  int rc = 0;
  for (auto &in : inputs)
  {
    if (fs::is_directory(in))
    {
      for (auto &e : fs::directory_iterator(in))
      {
        if (e.path().filename().string().ends_with(".nekodata"))
          rc |= extract_one(e.path(), out);
      }
    }
    else
    {
      rc |= extract_one(in, out);
    }
  }
  return rc;
}
