#include <unicorn/unicorn.h>
#include <unicorn/arm64.h>

#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <memory>
#include <optional>
#include <signal.h>
#include <stdexcept>
#include <string>
#include <string_view>
#include <sys/wait.h>
#include <unistd.h>
#include <unordered_map>
#include <unordered_set>
#include <vector>

namespace fs = std::filesystem;

static constexpr uint64_t BASE = 0x100000000ull;
static constexpr uint64_t HOOK_BASE = 0x200000000ull;
static constexpr uint64_t HEAP_BASE = 0x300000000ull;
static constexpr uint64_t HEAP_SIZE = 0x20000000ull; // 512 MiB
static constexpr uint64_t STACK_BASE = 0x400000000ull;
static constexpr uint64_t STACK_SIZE = 0x200000ull;
static constexpr uint64_t TLS_BASE = 0x500000000ull;
static constexpr uint64_t MAGIC_RET = 0x510000000ull;
static constexpr uint64_t CANARY = 0x1122334455667788ull;
static constexpr uint32_t BR_X30 = 0xD61F03C0u;
static constexpr uint64_t INIT_ARRAY = 0x268350;

static const char SPK_B64[] =
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCdn9nCXvQhZFz+AblPq2KRsQQC"
    "Uvkbn/pX6UKQRTxW2g/sL8c6P6OvmkyJ0k2lUNRlaslCOvf/5C6f1NM5i1QwASWQ"
    "cs8H+LlNrsqbR55bshoPY30LVUK4orSzyFnsor4OgS9YAg513xbHv0QhzM3XR34d"
    "63maMBrjrWzD11waewIDAQAB";

static const int XREGS[8] = {
    UC_ARM64_REG_X0,
    UC_ARM64_REG_X1,
    UC_ARM64_REG_X2,
    UC_ARM64_REG_X3,
    UC_ARM64_REG_X4,
    UC_ARM64_REG_X5,
    UC_ARM64_REG_X6,
    UC_ARM64_REG_X7,
};

static uint64_t align_up(uint64_t x, uint64_t a = 0x1000)
{
    return (x + a - 1) & ~(a - 1);
}

static uint8_t *alloc_pages(size_t n)
{
    n = align_up(n);
    void *p = nullptr;
    if (posix_memalign(&p, 0x1000, n) != 0 || !p)
        throw std::runtime_error("posix_memalign failed");
    std::memset(p, 0, n);
    return static_cast<uint8_t *>(p);
}

static std::string strip_ver(std::string s)
{
    auto p = s.find("@@");
    if (p != std::string::npos)
        s.resize(p);
    return s;
}

enum class Imp : uint8_t
{
    Realloc,
    Malloc,
    Calloc,
    Free,
    Memcpy,
    Memmove,
    Memset,
    Memchr,
    Memcmp,
    Strlen,
    Strcmp,
    Strncmp,
    Strchr,
    Strcpy,
    Strncpy,
    Time,
    ClockGettime,
    Gettimeofday,
    Setjmp,
    Longjmp,
    Abort,
    Getenv,
    Sysconf,
    Snprintf,
    Stub
};

static Imp classify(std::string_view n)
{
    if (n == "realloc")
        return Imp::Realloc;
    if (n == "malloc")
        return Imp::Malloc;
    if (n == "calloc")
        return Imp::Calloc;
    if (n == "free")
        return Imp::Free;
    if (n == "memcpy" || n == "__memcpy_chk")
        return Imp::Memcpy;
    if (n == "memmove" || n == "__memmove_chk")
        return Imp::Memmove;
    if (n == "memset" || n == "__memset_chk")
        return Imp::Memset;
    if (n == "memchr")
        return Imp::Memchr;
    if (n == "memcmp")
        return Imp::Memcmp;
    if (n == "strlen" || n == "__strlen_chk")
        return Imp::Strlen;
    if (n == "strcmp")
        return Imp::Strcmp;
    if (n == "strncmp")
        return Imp::Strncmp;
    if (n == "strchr")
        return Imp::Strchr;
    if (n == "strcpy")
        return Imp::Strcpy;
    if (n == "strncpy")
        return Imp::Strncpy;
    if (n == "time")
        return Imp::Time;
    if (n == "clock_gettime")
        return Imp::ClockGettime;
    if (n == "gettimeofday")
        return Imp::Gettimeofday;
    if (n == "setjmp" || n == "sigsetjmp")
        return Imp::Setjmp;
    if (n == "longjmp" || n == "siglongjmp")
        return Imp::Longjmp;
    if (n == "abort" || n == "__assert2" || n == "__stack_chk_fail" || n == "raise")
        return Imp::Abort;
    if (n == "getenv" || n == "uselocale" || n == "newlocale" || n == "__cxa_atexit")
        return Imp::Getenv;
    if (n == "sysconf")
        return Imp::Sysconf;
    if (n == "snprintf" || n == "sprintf" || n == "__snprintf_chk" || n == "__sprintf_chk")
        return Imp::Snprintf;
    return Imp::Stub;
}

struct JmpEnv
{
    uint64_t x[13]; // x19-x30 + sp  (x19..x30 = 12, +sp)
    uint64_t sp;
    uint64_t x30;
};

struct Loader
{
    uc_engine *uc = nullptr;
    uint8_t *so_host = nullptr;
    uint8_t *hook_host = nullptr;
    uint8_t *heap_host = nullptr;
    uint8_t *stack_host = nullptr;
    uint8_t *tls_host = nullptr;
    uint8_t *magic_host = nullptr;
    uint64_t so_size = 0;
    uint64_t hook_span = 0;

    uint64_t heap_ptr = HEAP_BASE + 0x1000;
    std::unordered_map<uint64_t, uint64_t> heap_sz;
    std::unordered_map<uint64_t, JmpEnv> jmps;

    std::vector<std::string> hooks;
    std::vector<Imp> imps;
    std::unordered_map<std::string, uint64_t> sym; // st_value (file VA)

    std::string last_import;
    std::string err;
    bool failed = false;
    bool spk_ok = false;
    uint64_t L = 0;
    std::unordered_map<std::string, int> stub_n;

    ~Loader() { close(); }

    void close()
    {
        if (uc)
        {
            uc_close(uc);
            uc = nullptr;
        }
        std::free(so_host);
        so_host = nullptr;
        std::free(hook_host);
        hook_host = nullptr;
        std::free(heap_host);
        heap_host = nullptr;
        std::free(stack_host);
        stack_host = nullptr;
        std::free(tls_host);
        tls_host = nullptr;
        std::free(magic_host);
        magic_host = nullptr;
    }

    uint8_t *host(uint64_t addr, uint64_t n = 1) const
    {
        auto in = [&](uint64_t b, uint64_t sz, uint8_t *h) -> uint8_t *
        {
            if (addr >= b && addr + n <= b + sz)
                return h + (addr - b);
            return nullptr;
        };
        if (auto *p = in(HEAP_BASE, HEAP_SIZE, heap_host))
            return p;
        if (auto *p = in(BASE, so_size, so_host))
            return p;
        if (auto *p = in(STACK_BASE, STACK_SIZE, stack_host))
            return p;
        if (auto *p = in(HOOK_BASE, hook_span, hook_host))
            return p;
        if (auto *p = in(TLS_BASE, 0x1000, tls_host))
            return p;
        if (auto *p = in(MAGIC_RET, 0x1000, magic_host))
            return p;
        return nullptr;
    }

    uint64_t rg(int reg) const
    {
        uint64_t v = 0;
        uc_reg_read(uc, reg, &v);
        return v;
    }
    void wg(int reg, uint64_t v) { uc_reg_write(uc, reg, &v); }
    uint64_t arg(int i) const { return rg(XREGS[i]); }
    void ret(uint64_t v) { wg(UC_ARM64_REG_X0, v); }

    uint8_t r8(uint64_t a) const
    {
        auto *p = host(a, 1);
        return p ? *p : 0;
    }
    int32_t i32(uint64_t a) const
    {
        auto *p = host(a, 4);
        int32_t v = 0;
        if (p)
            std::memcpy(&v, p, 4);
        return v;
    }
    uint64_t u64(uint64_t a) const
    {
        auto *p = host(a, 8);
        uint64_t v = 0;
        if (p)
            std::memcpy(&v, p, 8);
        return v;
    }
    void w64(uint64_t a, uint64_t v)
    {
        auto *p = host(a, 8);
        if (p)
            std::memcpy(p, &v, 8);
    }

    uint64_t malloc_(uint64_t n)
    {
        if (n == 0)
            n = 1;
        n = (n + 15) & ~15ull;
        uint64_t p = heap_ptr;
        if (p + n > HEAP_BASE + HEAP_SIZE)
        {
            failed = true;
            err = "heap full";
            uc_emu_stop(uc);
            return 0;
        }
        std::memset(heap_host + (p - HEAP_BASE), 0, n);
        heap_sz[p] = n;
        heap_ptr = p + n;
        return p;
    }

    uint64_t realloc_(uint64_t p, uint64_t n)
    {
        if (n == 0)
        {
            if (p)
                heap_sz.erase(p);
            return 0;
        }
        if (p == 0)
            return malloc_(n);
        uint64_t old = heap_sz.count(p) ? heap_sz[p] : 0;
        uint64_t q = malloc_(n);
        if (!q)
            return 0;
        if (old)
        {
            auto *s = host(p, old);
            auto *d = host(q, n);
            if (s && d)
                std::memcpy(d, s, std::min(old, n));
        }
        heap_sz.erase(p);
        return q;
    }

    std::string read_cstr(uint64_t addr, size_t cap = 4096)
    {
        if (!addr)
            return {};
        std::string out;
        out.reserve(64);
        for (size_t i = 0; i < cap; i++)
        {
            auto *p = host(addr + i, 1);
            if (!p)
                break;
            if (*p == 0)
                break;
            out.push_back(static_cast<char>(*p));
        }
        return out;
    }

    std::string read_str(uint64_t p)
    {
        if (!p)
            return {};
        uint8_t tt = r8(p + 8);
        uint64_t ln = 0;
        if (tt == 4)
            ln = r8(p + 0x0b);
        else if (tt == 0x14)
            ln = u64(p + 0x10);
        else
            return {};
        if (ln > (1ull << 20))
            return {};
        auto *s = host(p + 0x18, ln);
        if (!s)
            return {};
        return std::string(reinterpret_cast<char *>(s), reinterpret_cast<char *>(s) + ln);
    }

    void do_import(size_t idx)
    {
        Imp k = idx < imps.size() ? imps[idx] : Imp::Stub;
        last_import = idx < hooks.size() ? hooks[idx] : "?";
        switch (k)
        {
        case Imp::Realloc:
            ret(realloc_(arg(0), arg(1)));
            return;
        case Imp::Malloc:
            ret(malloc_(arg(0)));
            return;
        case Imp::Calloc:
        {
            uint64_t a = arg(0), b = arg(1);
            ret(malloc_(a * b));
            return;
        }
        case Imp::Free:
            if (arg(0))
                heap_sz.erase(arg(0));
            ret(0);
            return;
        case Imp::Memcpy:
        case Imp::Memmove:
        {
            uint64_t dst = arg(0), src = arg(1), ln = arg(2);
            if (ln)
            {
                auto *d = host(dst, ln);
                auto *s = host(src, ln);
                if (d && s)
                    std::memmove(d, s, ln);
                else
                {
                    failed = true;
                    err = "memcpy unmapped";
                    uc_emu_stop(uc);
                }
            }
            ret(dst);
            return;
        }
        case Imp::Memset:
        {
            uint64_t dst = arg(0), ln = arg(2);
            uint8_t c = static_cast<uint8_t>(arg(1));
            if (ln)
            {
                auto *d = host(dst, ln);
                if (d)
                    std::memset(d, c, ln);
            }
            ret(dst);
            return;
        }
        case Imp::Memchr:
        {
            uint64_t p = arg(0), ln = arg(2);
            uint8_t c = static_cast<uint8_t>(arg(1));
            auto *s = host(p, ln);
            if (!s)
            {
                ret(0);
                return;
            }
            auto *f = static_cast<uint8_t *>(std::memchr(s, c, ln));
            ret(f ? p + (f - s) : 0);
            return;
        }
        case Imp::Memcmp:
        {
            uint64_t a = arg(0), b = arg(1), ln = arg(2);
            auto *da = host(a, ln);
            auto *db = host(b, ln);
            if (!da || !db)
            {
                ret(0);
                return;
            }
            ret(static_cast<uint64_t>(static_cast<int64_t>(std::memcmp(da, db, ln))));
            return;
        }
        case Imp::Strlen:
            ret(read_cstr(arg(0), 1u << 20).size());
            return;
        case Imp::Strcmp:
        {
            auto a = read_cstr(arg(0)), b = read_cstr(arg(1));
            ret(a < b ? -1ull : a > b ? 1
                                      : 0);
            return;
        }
        case Imp::Strncmp:
        {
            size_t k = static_cast<size_t>(arg(2));
            auto a = read_cstr(arg(0)).substr(0, k);
            auto b = read_cstr(arg(1)).substr(0, k);
            if (a.size() > k)
                a.resize(k);
            if (b.size() > k)
                b.resize(k);
            ret(a < b ? -1ull : a > b ? 1
                                      : 0);
            return;
        }
        case Imp::Strchr:
        {
            auto s = read_cstr(arg(0));
            char ch = static_cast<char>(arg(1) & 0xff);
            auto i = s.find(ch);
            ret(i == std::string::npos ? 0 : arg(0) + i);
            return;
        }
        case Imp::Strcpy:
        {
            uint64_t dst = arg(0);
            auto s = read_cstr(arg(1));
            auto *d = host(dst, s.size() + 1);
            if (d)
            {
                std::memcpy(d, s.data(), s.size());
                d[s.size()] = 0;
            }
            ret(dst);
            return;
        }
        case Imp::Strncpy:
        {
            uint64_t dst = arg(0), ln = arg(2);
            auto s = read_cstr(arg(1));
            if (s.size() > ln)
                s.resize(ln);
            auto *d = host(dst, ln);
            if (d)
            {
                std::memset(d, 0, ln);
                std::memcpy(d, s.data(), s.size());
            }
            ret(dst);
            return;
        }
        case Imp::Time:
        {
            uint64_t t = static_cast<uint64_t>(std::time(nullptr));
            if (arg(0))
                w64(arg(0), t);
            ret(t);
            return;
        }
        case Imp::ClockGettime:
        case Imp::Gettimeofday:
        {
            uint64_t p = (k == Imp::ClockGettime) ? arg(1) : arg(0);
            timespec ts{};
            clock_gettime(CLOCK_REALTIME, &ts);
            if (p)
            {
                w64(p, static_cast<uint64_t>(ts.tv_sec));
                uint64_t ns = static_cast<uint64_t>(ts.tv_nsec);
                w64(p + 8, k == Imp::ClockGettime ? ns : ns / 1000);
            }
            ret(0);
            return;
        }
        case Imp::Setjmp:
        {
            JmpEnv e{};
            e.x[0] = rg(UC_ARM64_REG_X19);
            e.x[1] = rg(UC_ARM64_REG_X20);
            e.x[2] = rg(UC_ARM64_REG_X21);
            e.x[3] = rg(UC_ARM64_REG_X22);
            e.x[4] = rg(UC_ARM64_REG_X23);
            e.x[5] = rg(UC_ARM64_REG_X24);
            e.x[6] = rg(UC_ARM64_REG_X25);
            e.x[7] = rg(UC_ARM64_REG_X26);
            e.x[8] = rg(UC_ARM64_REG_X27);
            e.x[9] = rg(UC_ARM64_REG_X28);
            e.x[10] = rg(UC_ARM64_REG_X29);
            e.x30 = rg(UC_ARM64_REG_X30);
            e.sp = rg(UC_ARM64_REG_SP);
            jmps[arg(0)] = e;
            ret(0);
            return;
        }
        case Imp::Longjmp:
        {
            auto it = jmps.find(arg(0));
            if (it == jmps.end())
            {
                failed = true;
                err = "longjmp unknown env";
                uc_emu_stop(uc);
                return;
            }
            auto &e = it->second;
            uint64_t val = arg(1);
            if (!val)
                val = 1;
            wg(UC_ARM64_REG_X19, e.x[0]);
            wg(UC_ARM64_REG_X20, e.x[1]);
            wg(UC_ARM64_REG_X21, e.x[2]);
            wg(UC_ARM64_REG_X22, e.x[3]);
            wg(UC_ARM64_REG_X23, e.x[4]);
            wg(UC_ARM64_REG_X24, e.x[5]);
            wg(UC_ARM64_REG_X25, e.x[6]);
            wg(UC_ARM64_REG_X26, e.x[7]);
            wg(UC_ARM64_REG_X27, e.x[8]);
            wg(UC_ARM64_REG_X28, e.x[9]);
            wg(UC_ARM64_REG_X29, e.x[10]);
            wg(UC_ARM64_REG_X30, e.x30);
            wg(UC_ARM64_REG_SP, e.sp);
            ret(val);
            wg(UC_ARM64_REG_PC, e.x30);
            return;
        }
        case Imp::Abort:
            failed = true;
            err = "abort via " + last_import;
            uc_emu_stop(uc);
            return;
        case Imp::Getenv:
            ret(0);
            return;
        case Imp::Sysconf:
            ret(4096);
            return;
        case Imp::Snprintf:
            ret(0);
            return;
        case Imp::Stub:
        default:
        {
            auto &c = stub_n[last_import];
            if (c++ < 3)
                std::fprintf(stderr, "[emu] stub %s x0=%llx\n", last_import.c_str(),
                             (unsigned long long)arg(0));
            ret(0);
            return;
        }
        }
    }

    static void on_code(uc_engine * /*uc*/, uint64_t addr, uint32_t /*sz*/, void *user)
    {
        auto *self = static_cast<Loader *>(user);
        if (addr < HOOK_BASE)
            return;
        size_t idx = static_cast<size_t>((addr - HOOK_BASE) / 8);
        if (idx >= self->hooks.size())
            return;
        uint64_t lr = self->rg(UC_ARM64_REG_LR);
        self->do_import(idx);
        if (!self->failed)
            self->wg(UC_ARM64_REG_PC, lr);
    }

    static bool on_unmapped(uc_engine *uc, uc_mem_type type, uint64_t addr, int size,
                            int64_t /*value*/, void *user)
    {
        auto *self = static_cast<Loader *>(user);
        uint64_t pc = self->rg(UC_ARM64_REG_PC);
        const char *k = "x";
        if (type == UC_MEM_READ_UNMAPPED)
            k = "r";
        else if (type == UC_MEM_WRITE_UNMAPPED)
            k = "w";
        std::fprintf(stderr, "[emu] UNMAPPED %s addr=%llx size=%d pc=%llx last=%s\n", k,
                     (unsigned long long)addr, size, (unsigned long long)pc,
                     self->last_import.c_str());
        (void)uc;
        return false;
    }

    void load_so(const std::string &path)
    {
        std::ifstream in(path, std::ios::binary);
        if (!in)
            throw std::runtime_error("cannot open " + path);
        std::vector<uint8_t> raw((std::istreambuf_iterator<char>(in)),
                                 std::istreambuf_iterator<char>());
        if (raw.size() < sizeof(Elf64_Ehdr))
            throw std::runtime_error("short elf");
        auto *eh = reinterpret_cast<Elf64_Ehdr *>(raw.data());
        if (std::memcmp(eh->e_ident, ELFMAG, SELFMAG) != 0)
            throw std::runtime_error("not elf");

        uint64_t max_va = 0;
        std::vector<Elf64_Phdr> loads;
        auto *ph = reinterpret_cast<Elf64_Phdr *>(raw.data() + eh->e_phoff);
        for (int i = 0; i < eh->e_phnum; i++)
        {
            if (ph[i].p_type != PT_LOAD)
                continue;
            loads.push_back(ph[i]);
            max_va = std::max(max_va, ph[i].p_vaddr + ph[i].p_memsz);
        }
        so_size = align_up(max_va + 0x10000);
        so_host = alloc_pages(so_size);
        for (auto &s : loads)
        {
            auto n = std::min<uint64_t>(s.p_filesz, raw.size() - s.p_offset);
            std::memcpy(so_host + s.p_vaddr, raw.data() + s.p_offset, n);
        }

        auto *sh = reinterpret_cast<Elf64_Shdr *>(raw.data() + eh->e_shoff);
        const char *shstr = reinterpret_cast<char *>(raw.data() + sh[eh->e_shstrndx].sh_offset);
        const Elf64_Shdr *dynsym = nullptr, *dynstr = nullptr, *rela_dyn = nullptr,
                         *rela_plt = nullptr;
        for (int i = 0; i < eh->e_shnum; i++)
        {
            const char *nm = shstr + sh[i].sh_name;
            if (!std::strcmp(nm, ".dynsym"))
                dynsym = &sh[i];
            if (!std::strcmp(nm, ".dynstr"))
                dynstr = &sh[i];
            if (!std::strcmp(nm, ".rela.dyn"))
                rela_dyn = &sh[i];
            if (!std::strcmp(nm, ".rela.plt"))
                rela_plt = &sh[i];
        }
        if (!dynsym || !dynstr)
            throw std::runtime_error("no dynsym");
        auto *syms = reinterpret_cast<Elf64_Sym *>(raw.data() + dynsym->sh_offset);
        size_t nsym = dynsym->sh_size / sizeof(Elf64_Sym);
        const char *strtab = reinterpret_cast<char *>(raw.data() + dynstr->sh_offset);
        for (size_t i = 0; i < nsym; i++)
        {
            if (!syms[i].st_name || !syms[i].st_value)
                continue;
            std::string name = strip_ver(strtab + syms[i].st_name);
            if (!name.empty())
                sym[name] = syms[i].st_value;
        }

        std::unordered_map<std::string, uint64_t> hook_of;
        auto apply = [&](const Elf64_Shdr *sec)
        {
            if (!sec)
                return;
            size_t n = sec->sh_size / sizeof(Elf64_Rela);
            auto *rel = reinterpret_cast<Elf64_Rela *>(raw.data() + sec->sh_offset);
            for (size_t i = 0; i < n; i++)
            {
                uint32_t typ = ELF64_R_TYPE(rel[i].r_info);
                uint32_t si = ELF64_R_SYM(rel[i].r_info);
                uint64_t off = rel[i].r_offset;
                int64_t add = rel[i].r_addend;
                auto *slot = reinterpret_cast<uint64_t *>(so_host + off);
                if (typ == 1027)
                { // RELATIVE
                    *slot = BASE + static_cast<uint64_t>(add);
                    continue;
                }
                if (typ != 257 && typ != 1025 && typ != 1026)
                    continue;
                std::string name;
                if (si < nsym && syms[si].st_name)
                    name = strip_ver(strtab + syms[si].st_name);
                uint64_t addr = 0;
                bool defined = si < nsym && syms[si].st_shndx != SHN_UNDEF &&
                               syms[si].st_value != 0;
                if (defined)
                    addr = BASE + syms[si].st_value + static_cast<uint64_t>(add);
                else
                {
                    if (!hook_of.count(name))
                    {
                        size_t idx = hooks.size();
                        hooks.push_back(name);
                        imps.push_back(classify(name));
                        hook_of[name] = HOOK_BASE + idx * 8;
                    }
                    addr = hook_of[name] + static_cast<uint64_t>(add);
                }
                if (name == "__stack_chk_guard")
                    addr = TLS_BASE + 0x28;
                *slot = addr;
            }
        };
        apply(rela_dyn);
        apply(rela_plt);

        hook_span = align_up(std::max<size_t>(hooks.size(), 1) * 8 + 0x1000);
        hook_host = alloc_pages(hook_span);
        for (size_t i = 0; i < hooks.size(); i++)
            std::memcpy(hook_host + i * 8, &BR_X30, 4);
    }

    void open_uc()
    {
        uc_err e = uc_open(UC_ARCH_ARM64, UC_MODE_ARM, &uc);
        if (e != UC_ERR_OK)
            throw std::runtime_error(uc_strerror(e));

        auto map = [&](uint64_t g, uint64_t sz, uint8_t *h, uint32_t prot)
        {
            e = uc_mem_map_ptr(uc, g, sz, prot, h);
            if (e != UC_ERR_OK)
                throw std::runtime_error(std::string("map ") + uc_strerror(e));
        };
        map(BASE, so_size, so_host, UC_PROT_ALL);
        map(HOOK_BASE, hook_span, hook_host, UC_PROT_ALL);
        heap_host = alloc_pages(HEAP_SIZE);
        map(HEAP_BASE, HEAP_SIZE, heap_host, UC_PROT_ALL);
        stack_host = alloc_pages(STACK_SIZE);
        map(STACK_BASE, STACK_SIZE, stack_host, UC_PROT_ALL);
        tls_host = alloc_pages(0x1000);
        map(TLS_BASE, 0x1000, tls_host, UC_PROT_ALL);
        magic_host = alloc_pages(0x1000);
        map(MAGIC_RET, 0x1000, magic_host, UC_PROT_ALL);
        std::memcpy(tls_host + 0x28, &CANARY, 8);
        std::memcpy(magic_host, &BR_X30, 4);

        uint64_t tpidr = TLS_BASE, sp = STACK_BASE + STACK_SIZE - 0x100, z = 0;
        uc_reg_write(uc, UC_ARM64_REG_TPIDR_EL0, &tpidr);
        uc_reg_write(uc, UC_ARM64_REG_SP, &sp);
        uc_reg_write(uc, UC_ARM64_REG_X18, &z);

        uc_hook h1, h2;
        uc_hook_add(uc, &h1, UC_HOOK_CODE, (void *)on_code, this, HOOK_BASE,
                    HOOK_BASE + hook_span);
        uc_hook_add(uc, &h2, UC_HOOK_MEM_UNMAPPED, (void *)on_unmapped, this, 1, 0);
    }

    uint64_t call_addr(uint64_t addr, const std::vector<uint64_t> &args,
                       size_t insn_limit)
    {
        failed = false;
        err.clear();
        for (int i = 0; i < 8; i++)
        {
            uint64_t v = i < (int)args.size() ? args[i] : 0;
            uc_reg_write(uc, XREGS[i], &v);
        }
        uint64_t lr = MAGIC_RET, tpidr = TLS_BASE;
        uc_reg_write(uc, UC_ARM64_REG_LR, &lr);
        uc_reg_write(uc, UC_ARM64_REG_PC, &addr);
        uc_reg_write(uc, UC_ARM64_REG_TPIDR_EL0, &tpidr);
        uc_err e = uc_emu_start(uc, addr, MAGIC_RET, 0, insn_limit);
        if (failed)
            throw std::runtime_error(err);
        if (e != UC_ERR_OK)
            throw std::runtime_error(std::string("unicorn ") + uc_strerror(e) +
                                     " pc=" + std::to_string(rg(UC_ARM64_REG_PC)) +
                                     " import=" + last_import);
        if (rg(UC_ARM64_REG_PC) != MAGIC_RET)
            throw std::runtime_error("did not return pc=" +
                                     std::to_string(rg(UC_ARM64_REG_PC)) +
                                     " import=" + last_import);
        return rg(UC_ARM64_REG_X0);
    }

    uint64_t call(const char *name, const std::vector<uint64_t> &args,
                  size_t insn_limit = 50'000'000)
    {
        auto it = sym.find(name);
        if (it == sym.end())
            throw std::runtime_error(std::string("missing ") + name);
        return call_addr(BASE + it->second, args, insn_limit);
    }

    uint64_t alloc_buf(const void *data, size_t n)
    {
        uint64_t p = malloc_(n + 1);
        auto *h = host(p, n + 1);
        if (h)
        {
            std::memcpy(h, data, n);
            h[n] = 0;
        }
        return p;
    }

    void run_ctors()
    {
        for (int i = 0; i < 32; i += 8)
        {
            uint64_t fn = u64(BASE + INIT_ARRAY + i);
            if (fn && fn != BASE)
            {
                try
                {
                    call_addr(fn, {}, 20'000'000);
                }
                catch (const std::exception &ex)
                {
                    std::fprintf(stderr, "[emu] ctor %llx failed %s\n",
                                 (unsigned long long)fn, ex.what());
                }
            }
        }
    }

    void install_spk(uint64_t Ls)
    {
        if (spk_ok)
            return;
        uint64_t spk = alloc_buf(SPK_B64, sizeof(SPK_B64) - 1);
        uint64_t rc = call("lua_spl", {Ls, spk, sizeof(SPK_B64) - 1}, 50'000'000);
        if (rc != 0)
            throw std::runtime_error("lua_spl failed");
        spk_ok = true;
    }

    uint64_t ensure_L()
    {
        if (L)
            return L;
        L = call("luaL_newstate", {}, 50'000'000);
        if (!L)
            throw std::runtime_error("luaL_newstate NULL");
        install_spk(L);
        return L;
    }
};

// ---- JSON writer ----------------------------------------------------------
struct Jw
{
    FILE *f;
    std::vector<uint8_t> first;
    void sep()
    {
        if (first.empty())
            return;
        if (!first.back())
            fputc(',', f);
        first.back() = 0;
    }
    void begin_obj()
    {
        sep();
        fputc('{', f);
        first.push_back(1);
    }
    void end_obj()
    {
        fputc('}', f);
        first.pop_back();
    }
    void begin_arr()
    {
        sep();
        fputc('[', f);
        first.push_back(1);
    }
    void end_arr()
    {
        fputc(']', f);
        first.pop_back();
    }
    void raw_token(const char *s)
    {
        sep();
        fputs(s, f);
    }
    void key(const char *k)
    {
        sep();
        fputc('"', f);
        fputs(k, f);
        fputs("\":", f);
        first.back() = 1; // next value is first in this "pair slot"
        // After key, the value should not emit an extra comma. Treat as first.
        // sep() for value: first.back() is 1 so no comma. Then first=0. Good.
    }
    void str(std::string_view s)
    {
        sep();
        fputc('"', f);
        for (unsigned char c : s)
        {
            switch (c)
            {
            case '"':
                fputs("\\\"", f);
                break;
            case '\\':
                fputs("\\\\", f);
                break;
            case '\b':
                fputs("\\b", f);
                break;
            case '\f':
                fputs("\\f", f);
                break;
            case '\n':
                fputs("\\n", f);
                break;
            case '\r':
                fputs("\\r", f);
                break;
            case '\t':
                fputs("\\t", f);
                break;
            default:
                if (c < 0x20)
                    std::fprintf(f, "\\u%04x", c);
                else
                    fputc(c, f);
            }
        }
        fputc('"', f);
    }
    void i64(int64_t v)
    {
        sep();
        std::fprintf(f, "%lld", (long long)v);
    }
    void u64hex(uint64_t v)
    {
        char buf[32];
        std::snprintf(buf, sizeof(buf), "0x%llx", (unsigned long long)v);
        str(buf);
    }
    void f64(double v)
    {
        sep();
        std::fprintf(f, "%.17g", v);
    }
    void hex(const uint8_t *p, size_t n)
    {
        sep();
        fputc('"', f);
        static const char *H = "0123456789abcdef";
        for (size_t i = 0; i < n; i++)
        {
            fputc(H[p[i] >> 4], f);
            fputc(H[p[i] & 0xf], f);
        }
        fputc('"', f);
    }
    void null_() { raw_token("null"); }
    void kv_str(const char *k, std::string_view v)
    {
        key(k);
        str(v);
    }
    void kv_i(const char *k, int64_t v)
    {
        key(k);
        i64(v);
    }
};

static void dump_const(Jw &j, Loader &ld, uint64_t tv)
{
    j.begin_obj();
    uint8_t tt = ld.r8(tv + 8) & 0x3f;
    j.kv_i("tt", tt);
    if (tt == 0)
    {
        j.kv_str("type", "nil");
    }
    else if (tt == 1)
    {
        j.kv_str("type", "false");
    }
    else if (tt == 2)
    {
        j.kv_str("type", "true");
    }
    else if (tt == 3)
    {
        j.kv_str("type", "integer");
        int64_t v = 0;
        auto *p = ld.host(tv, 8);
        if (p)
            std::memcpy(&v, p, 8);
        j.key("value");
        char buf[32];
        std::snprintf(buf, sizeof(buf), "%lld", (long long)v);
        j.str(buf);
    }
    else if (tt == 0x13)
    {
        j.kv_str("type", "float");
        double v = 0;
        auto *p = ld.host(tv, 8);
        if (p)
            std::memcpy(&v, p, 8);
        j.key("value");
        j.f64(v);
    }
    else if (tt == 4 || tt == 0x14)
    {
        j.kv_str("type", "string");
        j.kv_str("value", ld.read_str(ld.u64(tv)));
    }
    else
    {
        j.kv_str("type", "unknown");
        auto *p = ld.host(tv, 16);
        j.key("raw");
        if (p)
            j.hex(p, 16);
        else
            j.str("");
    }
    j.end_obj();
}

static void dump_proto(Jw &j, Loader &ld, uint64_t proto, int depth)
{
    if (!proto || depth > 32)
    {
        j.null_();
        return;
    }
    int32_t sizeupvalues = ld.i32(proto + 0x10);
    int32_t sizek = ld.i32(proto + 0x14);
    int32_t sizecode = ld.i32(proto + 0x18);
    int32_t sizelineinfo = ld.i32(proto + 0x1c);
    int32_t sizep = ld.i32(proto + 0x20);
    int32_t sizelocvars = ld.i32(proto + 0x24);
    int32_t sizeabs = ld.i32(proto + 0x28);
    int32_t sizep_bad = 0;
    if (sizep < 0 || sizep > 8192)
    {
        sizep_bad = sizep;
        sizep = 0;
    }
    j.begin_obj();
    j.key("protoPtr");
    j.u64hex(proto);
    j.kv_i("numparams", ld.r8(proto + 0x0a));
    j.kv_i("is_vararg", ld.r8(proto + 0x0b));
    j.kv_i("maxstacksize", ld.r8(proto + 0x0c));
    j.kv_i("sizeupvalues", sizeupvalues);
    j.kv_i("sizek", sizek);
    j.kv_i("sizecode", sizecode);
    j.kv_i("sizelineinfo", sizelineinfo);
    j.kv_i("sizep", sizep);
    if (sizep_bad)
        j.kv_i("sizepBad", sizep_bad);
    j.kv_i("sizelocvars", sizelocvars);
    j.kv_i("sizeabslineinfo", sizeabs);
    j.kv_i("linedefined", ld.i32(proto + 0x2c));
    j.kv_i("lastlinedefined", ld.i32(proto + 0x30));
    j.key("codePtr");
    j.u64hex(ld.u64(proto + 0x40));

    auto *ka = ld.host(proto + 0x78, 0x28);
    if (ka)
    {
        j.key("keyArea");
        j.hex(ka, 0x28);
    }
    auto *tb = ld.host(proto + 0x80, 0x400);
    if (tb)
    {
        j.key("tableHex");
        j.hex(tb, 0x400);
    }

    uint64_t code_ptr = ld.u64(proto + 0x40);
    j.key("codeHex");
    if (sizecode > 0 && code_ptr)
    {
        auto *c = ld.host(code_ptr, (uint64_t)sizecode * 4);
        if (c)
            j.hex(c, (size_t)sizecode * 4);
        else
            j.str("");
    }
    else
    {
        j.str("");
    }

    j.key("consts");
    j.begin_arr();
    uint64_t k_ptr = ld.u64(proto + 0x38);
    if (k_ptr && sizek > 0)
    {
        int n = std::min(sizek, 300000);
        for (int i = 0; i < n; i++)
            dump_const(j, ld, k_ptr + (uint64_t)i * 16);
    }
    j.end_arr();

    j.key("upvalues");
    j.begin_arr();
    uint64_t uv_ptr = ld.u64(proto + 0x50);
    int nuv = std::max(0, std::min(sizeupvalues, 256));
    if (uv_ptr)
    {
        for (int i = 0; i < nuv; i++)
        {
            uint64_t uv = uv_ptr + (uint64_t)i * 16;
            j.begin_obj();
            j.kv_str("name", ld.read_str(ld.u64(uv)));
            j.kv_i("instack", ld.r8(uv + 8));
            j.kv_i("idx", ld.r8(uv + 9));
            j.kv_i("kind", ld.r8(uv + 10));
            j.end_obj();
        }
    }
    j.end_arr();

    int nli = sizelineinfo;
    if (nli < 0 || nli > 2000000)
    {
        j.kv_i("sizelineinfoBad", nli);
        nli = 0;
    }
    j.key("lineinfoHex");
    uint64_t li_ptr = ld.u64(proto + 0x58);
    if (li_ptr && nli)
    {
        auto *p = ld.host(li_ptr, nli);
        if (p)
            j.hex(p, nli);
        else
            j.str("");
    }
    else
    {
        j.str("");
    }

    int nabs = sizeabs;
    if (nabs < 0 || nabs > 100000)
    {
        j.kv_i("sizeabslineinfoBad", nabs);
        nabs = 0;
    }
    j.key("abslineinfo");
    j.begin_arr();
    uint64_t ab_ptr = ld.u64(proto + 0x60);
    if (ab_ptr && nabs)
    {
        for (int i = 0; i < nabs; i++)
        {
            uint64_t ab = ab_ptr + (uint64_t)i * 8;
            j.begin_obj();
            j.kv_i("pc", ld.i32(ab));
            j.kv_i("line", ld.i32(ab + 4));
            j.end_obj();
        }
    }
    j.end_arr();

    int nloc = sizelocvars;
    if (nloc < 0 || nloc > 100000)
    {
        j.kv_i("sizelocvarsBad", nloc);
        nloc = 0;
    }
    j.key("locvars");
    j.begin_arr();
    uint64_t lv_ptr = ld.u64(proto + 0x68);
    if (lv_ptr && nloc)
    {
        for (int i = 0; i < nloc; i++)
        {
            uint64_t lv = lv_ptr + (uint64_t)i * 16;
            j.begin_obj();
            j.kv_str("name", ld.read_str(ld.u64(lv)));
            j.kv_i("startpc", ld.i32(lv + 8));
            j.kv_i("endpc", ld.i32(lv + 12));
            j.end_obj();
        }
    }
    j.end_arr();

    j.key("protos");
    j.begin_arr();
    uint64_t pp = ld.u64(proto + 0x48);
    if (pp && sizep > 0)
    {
        int n = std::min(sizep, 8192);
        for (int i = 0; i < n; i++)
            dump_proto(j, ld, ld.u64(pp + (uint64_t)i * 8), depth + 1);
    }
    j.end_arr();

    j.kv_str("source", ld.read_str(ld.u64(proto + 0x70)));
    j.end_obj();
}

// ---- in-memory proto / decrypt / luac -------------------------------------

enum class KType : uint8_t
{
    Nil,
    False,
    True,
    Int,
    Float,
    Str,
    Unknown
};

struct KConst
{
    KType type = KType::Unknown;
    uint8_t tt = 0;
    int64_t i = 0;
    double f = 0;
    std::string s;
    std::string raw;
};

struct UpvalDesc
{
    std::string name;
    uint8_t instack = 0, idx = 0, kind = 0;
};

struct AbsLI
{
    int32_t pc = 0, line = 0;
};

struct LocVar
{
    std::string name;
    int32_t startpc = 0, endpc = 0;
};

struct PNode
{
    uint8_t numparams = 0, is_vararg = 0, maxstacksize = 0;
    int32_t linedefined = 0, lastlinedefined = 0;
    int32_t sizeupvalues = 0, sizep_bad = 0;
    std::vector<uint8_t> table;
    std::vector<uint32_t> code;
    std::vector<KConst> consts;
    std::vector<UpvalDesc> upvalues;
    std::vector<uint8_t> lineinfo;
    std::vector<AbsLI> abslineinfo;
    std::vector<LocVar> locvars;
    std::vector<PNode> protos;
    std::string source;
};

static KConst read_const_mem(Loader &ld, uint64_t tv)
{
    KConst c;
    c.tt = ld.r8(tv + 8) & 0x3f;
    if (c.tt == 0)
        c.type = KType::Nil;
    else if (c.tt == 1)
        c.type = KType::False;
    else if (c.tt == 2 || c.tt == 0x11)
        c.type = KType::True;
    else if (c.tt == 3)
    {
        c.type = KType::Int;
        auto *p = ld.host(tv, 8);
        if (p)
            std::memcpy(&c.i, p, 8);
    }
    else if (c.tt == 0x13)
    {
        c.type = KType::Float;
        auto *p = ld.host(tv, 8);
        if (p)
            std::memcpy(&c.f, p, 8);
    }
    else if (c.tt == 4 || c.tt == 0x14)
    {
        c.type = KType::Str;
        c.s = ld.read_str(ld.u64(tv));
    }
    else
    {
        c.type = KType::Unknown;
        auto *p = ld.host(tv, 16);
        if (p)
            c.raw.assign(reinterpret_cast<char *>(p), 16);
        if (c.raw.size() >= 16 && (uint8_t)c.raw[8] == 0x11)
            c.type = KType::True;
    }
    return c;
}

static PNode extract_proto(Loader &ld, uint64_t proto, int depth)
{
    PNode n;
    if (!proto || depth > 32)
        return n;
    n.numparams = ld.r8(proto + 0x0a);
    n.is_vararg = ld.r8(proto + 0x0b);
    n.maxstacksize = ld.r8(proto + 0x0c);
    n.sizeupvalues = ld.i32(proto + 0x10);
    int32_t sizek = ld.i32(proto + 0x14);
    int32_t sizecode = ld.i32(proto + 0x18);
    int32_t sizelineinfo = ld.i32(proto + 0x1c);
    int32_t sizep = ld.i32(proto + 0x20);
    int32_t sizelocvars = ld.i32(proto + 0x24);
    int32_t sizeabs = ld.i32(proto + 0x28);
    n.linedefined = ld.i32(proto + 0x2c);
    n.lastlinedefined = ld.i32(proto + 0x30);
    if (sizep < 0 || sizep > 8192)
    {
        n.sizep_bad = sizep;
        sizep = 0;
    }
    if (auto *tb = ld.host(proto + 0x80, 0x400))
        n.table.assign(tb, tb + 0x400);
    uint64_t code_ptr = ld.u64(proto + 0x40);
    if (sizecode > 0 && code_ptr)
    {
        auto *c = ld.host(code_ptr, (uint64_t)sizecode * 4);
        if (c)
        {
            n.code.resize(sizecode);
            std::memcpy(n.code.data(), c, (size_t)sizecode * 4);
        }
    }
    uint64_t k_ptr = ld.u64(proto + 0x38);
    if (k_ptr && sizek > 0)
    {
        int nk = std::min(sizek, 300000);
        n.consts.reserve(nk);
        for (int i = 0; i < nk; i++)
            n.consts.push_back(read_const_mem(ld, k_ptr + (uint64_t)i * 16));
    }
    uint64_t uv_ptr = ld.u64(proto + 0x50);
    int nuv = std::max(0, std::min(n.sizeupvalues, 256));
    if (uv_ptr)
    {
        n.upvalues.reserve(nuv);
        for (int i = 0; i < nuv; i++)
        {
            uint64_t uv = uv_ptr + (uint64_t)i * 16;
            n.upvalues.push_back({ld.read_str(ld.u64(uv)), ld.r8(uv + 8),
                                  ld.r8(uv + 9), ld.r8(uv + 10)});
        }
    }
    int nli = sizelineinfo;
    if (nli < 0 || nli > 2000000)
        nli = 0;
    uint64_t li_ptr = ld.u64(proto + 0x58);
    if (li_ptr && nli)
    {
        if (auto *p = ld.host(li_ptr, nli))
            n.lineinfo.assign(p, p + nli);
    }
    int nabs = sizeabs;
    if (nabs < 0 || nabs > 100000)
        nabs = 0;
    uint64_t ab_ptr = ld.u64(proto + 0x60);
    if (ab_ptr && nabs)
    {
        n.abslineinfo.reserve(nabs);
        for (int i = 0; i < nabs; i++)
        {
            uint64_t ab = ab_ptr + (uint64_t)i * 8;
            n.abslineinfo.push_back({ld.i32(ab), ld.i32(ab + 4)});
        }
    }
    int nloc = sizelocvars;
    if (nloc < 0 || nloc > 100000)
        nloc = 0;
    uint64_t lv_ptr = ld.u64(proto + 0x68);
    if (lv_ptr && nloc)
    {
        n.locvars.reserve(nloc);
        for (int i = 0; i < nloc; i++)
        {
            uint64_t lv = lv_ptr + (uint64_t)i * 16;
            n.locvars.push_back(
                {ld.read_str(ld.u64(lv)), ld.i32(lv + 8), ld.i32(lv + 12)});
        }
    }
    uint64_t pp = ld.u64(proto + 0x48);
    if (pp && sizep > 0)
    {
        int np = std::min(sizep, 8192);
        n.protos.reserve(np);
        for (int i = 0; i < np; i++)
            n.protos.push_back(extract_proto(ld, ld.u64(pp + (uint64_t)i * 8), depth + 1));
    }
    n.source = ld.read_str(ld.u64(proto + 0x70));
    return n;
}

static int tree_insns(const PNode &p)
{
    int n = (int)p.code.size();
    for (auto &c : p.protos)
        n += tree_insns(c);
    return n;
}

static int tree_protos(const PNode &p)
{
    int n = 1;
    for (auto &c : p.protos)
        n += tree_protos(c);
    return n;
}

struct Decryptor
{
    static constexpr uint64_t DEC_STACK = 0x200000000ull;
    static constexpr uint64_t DEC_STACK_SZ = 0x20000;
    static constexpr uint64_t DEC_PROTO = 0x300000000ull;
    static constexpr uint64_t DEC_PROTO_SZ = 0x4000;
    static constexpr uint64_t DEC_CODE = 0x310000000ull;
    static constexpr uint64_t DEC_TLS = 0x400000000ull;
    static constexpr uint64_t ENTRY = 0x162D5C;
    static constexpr uint64_t EPILOGUE = 0x1646C4;
    static constexpr uint64_t STACK_CHK = 0x164A9C;

    uc_engine *uc = nullptr;
    uint8_t *stack = nullptr, *proto = nullptr, *codeh = nullptr, *tls = nullptr;
    uint8_t *so_own = nullptr;
    uint64_t so_size = 0, code_map = 0;
    bool chk_fail = false;
    std::string last_err;

    ~Decryptor() { close(); }

    void close()
    {
        if (uc)
        {
            uc_close(uc);
            uc = nullptr;
        }
        std::free(stack);
        stack = nullptr;
        std::free(proto);
        proto = nullptr;
        std::free(codeh);
        codeh = nullptr;
        std::free(tls);
        tls = nullptr;
        std::free(so_own);
        so_own = nullptr;
    }

    static void on_chk(uc_engine *u, uint64_t /*addr*/, uint32_t /*sz*/, void *user)
    {
        auto *self = static_cast<Decryptor *>(user);
        self->chk_fail = true;
        uc_emu_stop(u);
    }

    void open_file(const std::string &path)
    {
        close();
        std::ifstream in(path, std::ios::binary);
        if (!in)
            throw std::runtime_error("无法打开解密用 so: " + path);
        in.seekg(0, std::ios::end);
        auto n = (size_t)in.tellg();
        in.seekg(0);
        so_size = align_up(n);
        so_own = alloc_pages(so_size);
        in.read(reinterpret_cast<char *>(so_own), (std::streamsize)n);
        uc_err e = uc_open(UC_ARCH_ARM64, UC_MODE_ARM, &uc);
        if (e != UC_ERR_OK)
            throw std::runtime_error(uc_strerror(e));
        e = uc_mem_map_ptr(uc, BASE, so_size, UC_PROT_ALL, so_own);
        if (e != UC_ERR_OK)
            throw std::runtime_error(std::string("dec so ") + uc_strerror(e));
        stack = alloc_pages(DEC_STACK_SZ);
        proto = alloc_pages(DEC_PROTO_SZ);
        tls = alloc_pages(0x1000);
        code_map = 0x1000000; // 16 MiB covers AvgDialog (~3.6 MiB)
        codeh = alloc_pages(code_map);
        auto map = [&](uint64_t g, uint64_t n, uint8_t *h)
        {
            e = uc_mem_map_ptr(uc, g, n, UC_PROT_ALL, h);
            if (e != UC_ERR_OK)
                throw std::runtime_error(std::string("dec map ") + uc_strerror(e));
        };
        map(DEC_STACK, DEC_STACK_SZ, stack);
        map(DEC_PROTO, DEC_PROTO_SZ, proto);
        map(DEC_CODE, code_map, codeh);
        map(DEC_TLS, 0x1000, tls);
        uc_hook h;
        uc_hook_add(uc, &h, UC_HOOK_CODE, (void *)on_chk, this, BASE + STACK_CHK,
                    BASE + STACK_CHK + 4);
    }

    void ensure_code(size_t nbytes)
    {
        size_t need = align_up(nbytes + 0x1000);
        if (need <= code_map)
            return;
        uc_mem_unmap(uc, DEC_CODE, code_map);
        std::free(codeh);
        code_map = need;
        codeh = alloc_pages(code_map);
        uc_err e = uc_mem_map_ptr(uc, DEC_CODE, code_map, UC_PROT_ALL, codeh);
        if (e != UC_ERR_OK)
            throw std::runtime_error(std::string("dec remap ") + uc_strerror(e));
    }

    bool decrypt(PNode &p)
    {
        if (p.table.size() < 0x400 || p.code.empty())
            return true;
        size_t nbytes = p.code.size() * 4;
        ensure_code(nbytes);
        std::memset(proto, 0, DEC_PROTO_SZ);
        std::memset(stack, 0, DEC_STACK_SZ);
        std::memset(tls, 0, 0x1000);
        std::memset(codeh, 0, (size_t)std::min<uint64_t>(code_map, nbytes + 0x1000));
        int32_t sc = (int32_t)p.code.size();
        std::memcpy(proto + 0x18, &sc, 4);
        uint64_t cp = DEC_CODE;
        std::memcpy(proto + 0x40, &cp, 8);
        std::memcpy(proto + 0x80, p.table.data(), 0x400);
        std::memcpy(codeh, p.code.data(), nbytes);
        std::memcpy(tls + 0x28, &CANARY, 8);
        uint64_t sp = DEC_STACK + DEC_STACK_SZ - 0x900;
        uint32_t f1 = 0x31, f2 = 0x64;
        std::memcpy(stack + (sp - DEC_STACK) + 0x24C, &f1, 4);
        std::memcpy(stack + (sp - DEC_STACK) + 0x250, &f2, 4);
        std::memcpy(stack + (sp - DEC_STACK) - 0x10, &CANARY, 8);
        auto wr = [&](int r, uint64_t v)
        { uc_reg_write(uc, r, &v); };
        wr(UC_ARM64_REG_X0, DEC_PROTO);
        wr(UC_ARM64_REG_X19, DEC_PROTO);
        wr(UC_ARM64_REG_SP, sp);
        wr(UC_ARM64_REG_X29, sp + 0x50);
        wr(UC_ARM64_REG_X30, DEC_TLS);
        for (int r : {UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X3, UC_ARM64_REG_X4,
                      UC_ARM64_REG_X5, UC_ARM64_REG_X6, UC_ARM64_REG_X7, UC_ARM64_REG_X8,
                      UC_ARM64_REG_X9, UC_ARM64_REG_X10, UC_ARM64_REG_X11, UC_ARM64_REG_X12,
                      UC_ARM64_REG_X13, UC_ARM64_REG_X14, UC_ARM64_REG_X15, UC_ARM64_REG_X16,
                      UC_ARM64_REG_X17, UC_ARM64_REG_X18, UC_ARM64_REG_X20, UC_ARM64_REG_X21,
                      UC_ARM64_REG_X22, UC_ARM64_REG_X23, UC_ARM64_REG_X24, UC_ARM64_REG_X25,
                      UC_ARM64_REG_X26, UC_ARM64_REG_X27, UC_ARM64_REG_X28})
            wr(r, 0);
        chk_fail = false;
        last_err.clear();
        uc_err e = uc_emu_start(uc, BASE + ENTRY, BASE + EPILOGUE, 0, 0);
        uint64_t pc = 0;
        uc_reg_read(uc, UC_ARM64_REG_PC, &pc);
        if (e != UC_ERR_OK || chk_fail || pc != BASE + EPILOGUE)
        {
            char b[160];
            std::snprintf(b, sizeof(b), "emu=%s chk=%d pc=0x%llx want=0x%llx n=%zu",
                          uc_strerror(e), (int)chk_fail, (unsigned long long)pc,
                          (unsigned long long)(BASE + EPILOGUE), p.code.size());
            last_err = b;
            return false;
        }
        std::memcpy(p.code.data(), codeh, nbytes);
        return true;
    }
};

static int decrypt_tree(Decryptor &d, PNode &p, std::string *err)
{
    int fail = 0;
    if (!p.table.empty() && !p.code.empty())
    {
        if (!d.decrypt(p))
        {
            fail++;
            if (err && err->empty())
                *err = "decrypt did not finish (" + p.source + "): " + d.last_err;
        }
    }
    for (auto &c : p.protos)
        fail += decrypt_tree(d, c, err);
    return fail;
}

static int8_t OP_MAP[84];
static void init_op_map()
{
    static bool once = false;
    if (once)
        return;
    once = true;
    for (int i = 0; i < 54; i++)
        OP_MAP[i] = (int8_t)i;
    OP_MAP[54] = -1;
    const int8_t rest[] = {
        54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,
        70, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82};
    // 55..83
    for (int i = 0; i < 29; i++)
        OP_MAP[55 + i] = rest[i];
}

static int32_t get_sj(uint32_t w)
{
    return (int32_t)((w >> 7) & 0x1FFFFFF) - 0xFFFFFF;
}
static uint32_t set_sj(uint32_t w, int32_t sj)
{
    uint32_t v = (uint32_t)(sj + 0xFFFFFF) & 0x1FFFFFF;
    return (w & 0x7F) | (v << 7);
}
static uint32_t get_bx(uint32_t w) { return (w >> 15) & 0x1FFFF; }
static uint32_t set_bx(uint32_t w, uint32_t bx)
{
    return (w & 0x7FFF) | ((bx & 0x1FFFF) << 15);
}
static int remap_pc(int pc, const std::vector<int> &keep)
{
    return (int)(std::lower_bound(keep.begin(), keep.end(), pc) - keep.begin());
}

static std::pair<std::vector<uint32_t>, std::vector<int>>
convert_instructions(std::vector<uint32_t> words, const std::string &name)
{
    init_op_map();
    std::vector<int> keep;
    keep.reserve(words.size());
    for (int i = 0; i < (int)words.size(); i++)
    {
        int op = words[i] & 0x7f;
        if (op < 0 || op > 83)
            throw std::runtime_error(name + ": unknown opcode " + std::to_string(op));
        if (OP_MAP[op] < 0)
            continue;
        if ((op == 19 || op == 79) && i + 1 < (int)words.size() &&
            (words[i + 1] & 0x7f) == 83)
            words[i] |= (1u << 15);
        keep.push_back(i);
    }
    auto remapped = words;
    for (int i : keep)
    {
        uint32_t w = remapped[i];
        int op = w & 0x7F;
        int ni = remap_pc(i, keep);
        if (op == 57)
        {
            int tgt = i + 1 + get_sj(w);
            int nsj = remap_pc(tgt, keep) - (ni + 1);
            remapped[i] = set_sj(w, nsj);
        }
        else if (op == 75)
        {
            int tgt = i + 2 + (int)get_bx(w);
            int nbx = remap_pc(tgt, keep) - ni - 2;
            remapped[i] = set_bx(w, (uint32_t)std::max(nbx, 0));
        }
        else if (op == 76)
        {
            int tgt = i + 1 + (int)get_bx(w);
            int nbx = remap_pc(tgt, keep) - ni - 1;
            remapped[i] = set_bx(w, (uint32_t)std::max(nbx, 0));
        }
        else if (op == 74 || op == 78)
        {
            int tgt = i + 1 - (int)get_bx(w);
            int nbx = ni + 1 - remap_pc(tgt, keep);
            remapped[i] = set_bx(w, (uint32_t)std::max(nbx, 0));
        }
    }
    std::vector<uint32_t> out;
    out.reserve(keep.size());
    for (int i : keep)
    {
        uint32_t w = remapped[i];
        int op = w & 0x7f;
        out.push_back((w & 0xFFFFFF80u) | (uint8_t)OP_MAP[op]);
    }
    return {out, keep};
}

struct Buf
{
    std::vector<uint8_t> b;
    void wb(uint8_t x) { b.push_back(x); }
    void wbytes(const void *p, size_t n)
    {
        auto *s = static_cast<const uint8_t *>(p);
        b.insert(b.end(), s, s + n);
    }
    void wsize(uint32_t x)
    {
        uint8_t g[8];
        int n = 0;
        if (x == 0)
            g[n++] = 0;
        else
            while (x)
            {
                g[n++] = x & 0x7f;
                x >>= 7;
            }
        for (int i = n - 1; i >= 0; i--)
        {
            uint8_t v = g[i];
            if (i == 0)
                v |= 0x80;
            wb(v);
        }
    }
    void wint(uint32_t x) { wsize(x); }
    void wstring(const std::string *s)
    {
        if (!s)
        {
            wsize(0);
            return;
        }
        wsize((uint32_t)s->size() + 1);
        wbytes(s->data(), s->size());
    }
    void wstring(const std::string &s) { wstring(&s); }
    void wnum(double d) { wbytes(&d, 8); }
    void wint64(int64_t v) { wbytes(&v, 8); }
};

static void write_const(Buf &w, const KConst &c)
{
    if (c.type == KType::Int)
    {
        w.wb(3);
        w.wint64(c.i);
        return;
    }
    if (c.type == KType::Float)
    {
        w.wb(0x13);
        w.wnum(c.f);
        return;
    }
    if (c.type == KType::Str)
    {
        w.wb(c.s.size() <= 40 ? 4 : 20);
        w.wstring(c.s);
        return;
    }
    if (c.type == KType::Nil)
    {
        w.wb(0);
        return;
    }
    if (c.type == KType::False)
    {
        w.wb(1);
        return;
    }
    if (c.type == KType::True)
    {
        w.wb(0x11);
        return;
    }
    if (c.tt == 3)
    {
        w.wb(3);
        w.wint64(c.i);
        return;
    }
    if (c.tt == 0x13)
    {
        w.wb(0x13);
        w.wnum(c.f);
        return;
    }
    w.wb(0);
}

static void write_proto_std(Buf &w, PNode &p, const std::string *parent_src)
{
    const std::string *src = p.source.empty() ? nullptr : &p.source;
    if (!src || (parent_src && *src == *parent_src))
        w.wstring(nullptr);
    else
        w.wstring(*src);
    w.wint((uint32_t)p.linedefined);
    w.wint((uint32_t)p.lastlinedefined);
    w.wb(p.numparams);
    w.wb(p.is_vararg);
    w.wb(p.maxstacksize);

    auto [out_words, keep] = convert_instructions(p.code, p.source.empty() ? "<proto>" : p.source);
    w.wint((uint32_t)out_words.size());
    for (uint32_t c : out_words)
        w.wbytes(&c, 4);

    w.wint((uint32_t)p.consts.size());
    for (auto &c : p.consts)
        write_const(w, c);

    auto upvals = p.upvalues;
    while ((int)upvals.size() < p.sizeupvalues)
        upvals.push_back({"", 1, 0, 0});
    w.wint((uint32_t)upvals.size());
    for (auto &u : upvals)
    {
        w.wb(u.instack);
        w.wb(u.idx);
        w.wb(u.kind);
    }

    w.wint((uint32_t)p.protos.size());
    for (auto &sub : p.protos)
        write_proto_std(w, sub, src);

    std::vector<uint8_t> li;
    li.reserve(keep.size());
    for (int i : keep)
        li.push_back(i < (int)p.lineinfo.size() ? p.lineinfo[i] : 0);
    while (li.size() < keep.size())
        li.push_back(0);
    w.wint((uint32_t)li.size());
    if (!li.empty())
        w.wbytes(li.data(), li.size());
    w.wint((uint32_t)p.abslineinfo.size());
    for (auto &a : p.abslineinfo)
    {
        int32_t pc = remap_pc(a.pc, keep);
        w.wint((uint32_t)pc);
        w.wint((uint32_t)a.line);
    }
    w.wint((uint32_t)p.locvars.size());
    for (auto &lv : p.locvars)
    {
        w.wstring(lv.name);
        w.wint((uint32_t)remap_pc(lv.startpc, keep));
        w.wint((uint32_t)remap_pc(lv.endpc, keep));
    }
    bool any_name = false;
    for (auto &u : upvals)
        if (!u.name.empty())
            any_name = true;
    if (any_name)
    {
        w.wint((uint32_t)upvals.size());
        for (auto &u : upvals)
            w.wstring(u.name);
    }
    else
        w.wint(0);
}

static std::vector<uint8_t> build_luac(PNode &tree)
{
    Buf w;
    const uint8_t hdr[] = {'\x1b', 'L', 'u', 'a', 0x54, 0x00, 0x19, 0x93,
                           '\r', '\n', 0x1a, '\n', 4, 8, 8};
    w.wbytes(hdr, sizeof(hdr));
    int64_t x = 0x5678;
    w.wbytes(&x, 8);
    w.wnum(370.5);
    w.wb((uint8_t)std::max(tree.sizeupvalues, (int32_t)tree.upvalues.size()));
    write_proto_std(w, tree, nullptr);
    return w.b;
}

static std::string chunk_relpath(std::string name)
{
    for (char &c : name)
        if (c == '\\')
            c = '/';
    while (!name.empty() && name.front() == '/')
        name.erase(name.begin());
    if (name.size() > 4 && name.substr(name.size() - 4) == ".lua")
        name.resize(name.size() - 4);
    if (name.empty())
        name = "chunk";
    return name;
}

static std::string lua_quote(const std::string &s)
{
    std::string o = "\"";
    for (unsigned char c : s)
    {
        if (c == '"' || c == '\\')
        {
            o += '\\';
            o += (char)c;
        }
        else if (c == '\n')
            o += "\\n";
        else if (c == '\r')
            o += "\\r";
        else if (c == '\t')
            o += "\\t";
        else
            o += (char)c;
    }
    o += '"';
    return o;
}

static int reconstruct_functable(const PNode &p, const fs::path &lua_path)
{
    fs::create_directories(lua_path.parent_path());
    std::ofstream out(lua_path);
    if (!out)
        return 0;
    out << "-- 从公式字符串还原。表项是预编译的战斗/配置公式：\n"
           "-- LoadFuncUtils.GetFunc(str) 查 DT.FuncTable[str]\n"
           "local FuncTable = {\n";
    int n = 0;
    for (auto &c : p.consts)
    {
        if (c.type != KType::Str)
            continue;
        std::string body = c.s;
        bool empty = true;
        for (char ch : body)
            if (ch != ' ' && ch != '\t')
            {
                empty = false;
                break;
            }
        if (empty)
            body = "nil";
        out << "  [" << lua_quote(c.s) << "] = function()\n    return " << body
            << "\n  end,\n";
        n++;
    }
    out << "}\nreturn FuncTable\n";
    return n;
}

static int run_cmd(const std::vector<std::string> &args, int timeout_sec)
{
    pid_t pid = fork();
    if (pid < 0)
        return 127;
    if (pid == 0)
    {
        int nfd = open("/dev/null", O_RDWR);
        if (nfd >= 0)
        {
            dup2(nfd, STDOUT_FILENO);
            dup2(nfd, STDERR_FILENO);
            if (nfd > 2)
                close(nfd);
        }
        std::vector<char *> argv;
        argv.reserve(args.size() + 1);
        for (auto &a : args)
            argv.push_back(const_cast<char *>(a.c_str()));
        argv.push_back(nullptr);
        execvp(argv[0], argv.data());
        _exit(127);
    }
    auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(timeout_sec);
    int status = 0;
    while (true)
    {
        pid_t r = waitpid(pid, &status, WNOHANG);
        if (r == pid)
            return WIFEXITED(status) ? WEXITSTATUS(status) : 1;
        if (std::chrono::steady_clock::now() > deadline)
        {
            kill(pid, SIGKILL);
            waitpid(pid, &status, 0);
            return 124;
        }
        usleep(40000);
    }
}

static std::string peek_head(const fs::path &p, size_t n = 16)
{
    std::ifstream in(p, std::ios::binary);
    std::string s(n, '\0');
    in.read(s.data(), (std::streamsize)n);
    s.resize((size_t)in.gcount());
    return s;
}

static std::string unluac_one(const fs::path &luac, const fs::path &lua, int nins)
{
    fs::create_directories(lua.parent_path());
    int to = std::max(300, std::min(1800, nins / 80 + 180));
    int rc = run_cmd({"unluac", "--rawstring", "--output", lua.string(), luac.string()}, to);
    if (rc == 0 && fs::exists(lua) && fs::file_size(lua) > 0)
    {
        auto h = peek_head(lua);
        if (h.rfind(".version", 0) != 0)
            return "反编译";
    }
    rc = run_cmd({"unluac", "--disassemble", "--nodebug", "--rawstring", "--output",
                  lua.string(), luac.string()},
                 to);
    if (rc == 0 && fs::exists(lua))
        return "反汇编";
    throw std::runtime_error("unluac 失败 rc=" + std::to_string(rc));
}

static std::string fmt_dur(double s)
{
    if (s < 0)
        s = 0;
    if (s < 10)
    {
        char b[32];
        std::snprintf(b, sizeof(b), "%.2fs", s);
        return b;
    }
    if (s < 60)
    {
        char b[32];
        std::snprintf(b, sizeof(b), "%.1fs", s);
        return b;
    }
    int m = (int)(s / 60);
    int sec = (int)s % 60;
    if (m < 60)
    {
        char b[32];
        std::snprintf(b, sizeof(b), "%dm%02ds", m, sec);
        return b;
    }
    int h = m / 60;
    m %= 60;
    char b[32];
    std::snprintf(b, sizeof(b), "%dh%02dm", h, m);
    return b;
}

struct DumpInfo
{
    int32_t sizecode = 0, sizek = 0, sizelineinfo = 0, sizelocvars = 0,
            sizeabs = 0;
    std::string source;
    uint64_t proto = 0;
};

static DumpInfo peek_info(Loader &ld, uint64_t proto)
{
    DumpInfo d;
    if (!proto)
        return d;
    d.sizecode = ld.i32(proto + 0x18);
    d.sizek = ld.i32(proto + 0x14);
    d.sizelineinfo = ld.i32(proto + 0x1c);
    d.sizelocvars = ld.i32(proto + 0x24);
    d.sizeabs = ld.i32(proto + 0x28);
    d.source = ld.read_str(ld.u64(proto + 0x70));
    d.proto = proto;
    return d;
}

static uint64_t load_chunk(Loader &ld, const uint8_t *data, size_t n, const std::string &name)
{
    uint64_t L = ld.ensure_L();
    std::memset(ld.stack_host, 0, STACK_SIZE);
    uint64_t sp = STACK_BASE + STACK_SIZE - 0x100;
    ld.wg(UC_ARM64_REG_SP, sp);
    uint64_t buf = ld.alloc_buf(data, n);
    uint64_t nb = ld.alloc_buf(name.data(), name.size());
    size_t lim = std::max<size_t>(800'000'000ull, n * 8000ull + 80'000'000ull);
    int64_t rc = static_cast<int64_t>(ld.call("luaL_loadbufferx", {L, buf, n, nb, 0}, lim));
    if (rc != 0)
    {
        uint64_t errp = ld.call("lua_tolstring", {L, 0xFFFFFFFFFFFFFFFFULL, 0});
        throw std::runtime_error(std::string("load rc=") + std::to_string(rc) + " " +
                                 ld.read_cstr(errp));
    }
    uint64_t func = ld.call("lua_topointer", {L, 0xFFFFFFFFFFFFFFFFULL});
    if (!func)
        throw std::runtime_error("null func");
    uint8_t ftt = ld.r8(func + 8) & 0x3f;
    if (ftt != 6)
        throw std::runtime_error("not lua closure");
    return ld.u64(func + 0x18);
}

static std::unique_ptr<Loader> new_loader(const std::string &so)
{
    auto ld = std::make_unique<Loader>();
    ld->load_so(so);
    ld->open_uc();
    ld->run_ctors();
    return ld;
}

static bool is_luat0(const fs::path &p)
{
    std::ifstream in(p, std::ios::binary);
    char mag[6]{};
    in.read(mag, 6);
    return in.gcount() == 6 && std::memcmp(mag, "\x1bLuaT0", 6) == 0;
}

static std::string json_name(const std::string &line)
{
    auto c = line.find("\"chunk\"");
    if (c == std::string::npos)
        return {};
    auto n = line.find("\"name\"", c);
    if (n == std::string::npos)
        return {};
    auto q = line.find('"', n + 6);
    q = line.find('"', q); // after key
    // "name": "VALUE"
    auto colon = line.find(':', n);
    auto q1 = line.find('"', colon);
    if (q1 == std::string::npos)
        return {};
    auto q2 = q1 + 1;
    std::string out;
    for (size_t i = q2; i < line.size(); i++)
    {
        if (line[i] == '\\' && i + 1 < line.size())
        {
            out.push_back(line[i + 1]);
            i++;
            continue;
        }
        if (line[i] == '"')
            break;
        out.push_back(line[i]);
    }
    return out;
}

static bool is_functable_name(const std::string &rel)
{
    static const std::string suf = "FuncTable.lua";
    return rel.size() >= suf.size() &&
           rel.compare(rel.size() - suf.size(), suf.size(), suf) == 0;
}

static void write_bytes(const fs::path &p, const uint8_t *data, size_t n)
{
    if (p.has_parent_path())
        fs::create_directories(p.parent_path());
    std::ofstream out(p, std::ios::binary);
    if (!out)
        throw std::runtime_error("无法写入 " + p.string());
    out.write(reinterpret_cast<const char *>(data), (std::streamsize)n);
    if (!out)
        throw std::runtime_error("write failed " + p.string());
}

static bool file_nonempty(const fs::path &p)
{
    std::error_code ec;
    return fs::exists(p, ec) && !ec && fs::file_size(p, ec) > 0 && !ec;
}

int main(int argc, char **argv)
{
    std::string so = "libxlua.so";
    std::string dir, one, jsonl;
    std::string luac_dir = "Luac";
    std::string master_dir = "MasterData";
    bool fresh = false, skip_lua = false;
    int limit = 0;
    for (int i = 1; i < argc; i++)
    {
        std::string a = argv[i];
        auto take = [&](std::string &d)
        {
            if (i + 1 >= argc)
                throw std::runtime_error("缺少参数: " + a);
            d = argv[++i];
        };
        if (a == "--dir")
            take(dir);
        else if (a == "--luac")
            take(luac_dir);
        else if (a == "--master")
            take(master_dir);
        else if (a == "--jsonl" || a == "--out")
            take(jsonl);
        else if (a == "--so")
            take(so);
        else if (a == "--fresh")
            fresh = true;
        else if (a == "--skip-lua")
            skip_lua = true;
        else if (a == "--limit")
        {
            if (i + 1 >= argc)
                throw std::runtime_error("缺少 --limit 参数");
            limit = std::atoi(argv[++i]);
        }
        else if (a == "-h" || a == "--help")
        {
            std::puts(
                "offline_undump_cpp --dir lua [--luac Luac] [--master MasterData]\n"
                "  [--so libxlua.so] [--fresh] [--skip-lua] [--jsonl 文件] [--limit N] [单个文件]\n"
                "  传入 LuaT0 目录：dump → 解密 → 导出 .luac 到 Luac/ → 反编译到 MasterData/");
            return 0;
        }
        else if (!a.empty() && a[0] != '-')
            one = a;
        else
            throw std::runtime_error("未知参数 " + a);
    }

    std::vector<std::pair<std::string, fs::path>> files;
    if (!one.empty())
    {
        files.push_back({one, one});
    }
    else if (!dir.empty())
    {
        for (auto &e : fs::recursive_directory_iterator(dir))
        {
            if (!e.is_regular_file())
                continue;
            if (is_luat0(e.path()))
            {
                auto rel = e.path().lexically_relative(fs::path(dir)).generic_string();
                files.push_back({rel, e.path()});
            }
        }
        std::sort(files.begin(), files.end(),
                  [](auto &a, auto &b)
                  { return a.first < b.first; });
    }
    else
    {
        std::fprintf(stderr, "请指定文件或 --dir\n");
        return 2;
    }
    if (limit > 0 && (int)files.size() > limit)
        files.resize(limit);

    fs::create_directories(luac_dir);
    fs::create_directories(master_dir);

    FILE *jf = nullptr;
    if (!jsonl.empty())
    {
        jf = std::fopen(jsonl.c_str(), fresh ? "w" : "a");
        if (!jf)
        {
            std::perror(jsonl.c_str());
            return 1;
        }
        setvbuf(jf, nullptr, _IOFBF, 1 << 20);
    }

    setvbuf(stdout, nullptr, _IONBF, 0);
    std::printf("[*] 共 %zu 个文件  输入=%s  Luac=%s  MasterData=%s  断点续传=%s  jsonl=%s\n",
                files.size(), dir.empty() ? "(单文件)" : dir.c_str(), luac_dir.c_str(),
                master_dir.c_str(), fresh ? "关" : "开", jsonl.empty() ? "-" : jsonl.c_str());

    Decryptor dec;
    dec.open_file(so);

    std::unique_ptr<Loader> ld;
    int vm_uses = 0;
    const int VM_RECYCLE = 80;
    int ok = 0, bad = 0, skip = 0, lua_ok = 0, lua_dis = 0, lua_ft = 0;
    auto reset = [&]()
    {
        ld = new_loader(so);
        vm_uses = 0;
    };

    using clock = std::chrono::steady_clock;
    auto t_all = clock::now();

    auto line_head = [&](size_t i) -> std::string
    {
        double pct = files.empty() ? 100.0 : 100.0 * (double)(i + 1) / (double)files.size();
        char b[80];
        std::snprintf(b, sizeof(b), "[%zu/%zu %.1f%%]", i + 1, files.size(), pct);
        return b;
    };
    auto eta_s = [&](size_t i) -> std::string
    {
        double elapsed = std::chrono::duration<double>(clock::now() - t_all).count();
        double left = 0;
        if (i + 1 > 0 && i + 1 < files.size())
            left = elapsed / (double)(i + 1) * (double)(files.size() - i - 1);
        return " | 已用 " + fmt_dur(elapsed) + "，剩余 " + fmt_dur(left);
    };

    for (size_t i = 0; i < files.size(); i++)
    {
        auto &rel = files[i].first;
        std::string stem = chunk_relpath(rel);
        fs::path luac_path = fs::path(luac_dir) / (stem + ".luac");
        fs::path lua_path = fs::path(master_dir) / (stem + ".lua");

        if (!fresh && file_nonempty(lua_path))
        {
            skip++;
            std::printf("%s %s 跳过（MasterData 已有）%s\n", line_head(i).c_str(),
                        rel.c_str(), eta_s(i).c_str());
            continue;
        }

        std::ifstream in(files[i].second, std::ios::binary);
        std::vector<uint8_t> blob((std::istreambuf_iterator<char>(in)),
                                  std::istreambuf_iterator<char>());
        std::printf("%s %s 处理中… (%zu 字节)\n", line_head(i).c_str(), rel.c_str(),
                    blob.size());
        if (!ld || vm_uses >= VM_RECYCLE ||
            (ld && ld->heap_ptr > HEAP_BASE + HEAP_SIZE - 0x4000000ull))
            reset();

        auto t0 = clock::now();
        double s_dump = 0, s_dec = 0, s_luac = 0, s_lua = 0;
        try
        {
            uint64_t proto = load_chunk(*ld, blob.data(), blob.size(), rel);
            s_dump = std::chrono::duration<double>(clock::now() - t0).count();

            if (jf)
            {
                Jw j{jf, {}};
                j.begin_obj();
                j.kv_str("type", "fullproto3");
                j.kv_str("stage", "offline");
                j.key("chunk");
                j.begin_obj();
                j.kv_i("size", (int64_t)blob.size());
                j.kv_str("name", rel);
                j.end_obj();
                j.key("proto");
                dump_proto(j, *ld, proto, 0);
                j.key("protoPtr");
                j.u64hex(proto);
                j.end_obj();
                fputc('\n', jf);
                fflush(jf);
            }

            auto t1 = clock::now();
            PNode tree = extract_proto(*ld, proto, 0);
            std::string dec_err;
            int nfail = decrypt_tree(dec, tree, &dec_err);
            s_dec = std::chrono::duration<double>(clock::now() - t1).count();
            if (nfail)
                throw std::runtime_error(dec_err.empty() ? "decrypt failed" : dec_err);

            auto t2 = clock::now();
            auto luac = build_luac(tree);
            write_bytes(luac_path, luac.data(), luac.size());
            s_luac = std::chrono::duration<double>(clock::now() - t2).count();

            std::string lua_mode = "跳过转换";
            if (!skip_lua)
            {
                auto t3 = clock::now();
                if (is_functable_name(rel) || tree.sizep_bad > 8192)
                {
                    int nfn = reconstruct_functable(tree, lua_path);
                    lua_mode = "公式表:" + std::to_string(nfn);
                    lua_ft++;
                }
                else
                {
                    lua_mode = unluac_one(luac_path, lua_path, tree_insns(tree));
                    if (lua_mode == "反编译")
                        lua_ok++;
                    else
                        lua_dis++;
                }
                s_lua = std::chrono::duration<double>(clock::now() - t3).count();
            }

            std::printf("%s %s dump=%s 解密=%s luac=%s 转换=%s (%s) 指令=%d%s\n",
                        line_head(i).c_str(), rel.c_str(), fmt_dur(s_dump).c_str(),
                        fmt_dur(s_dec).c_str(), fmt_dur(s_luac).c_str(),
                        fmt_dur(s_lua).c_str(), lua_mode.c_str(), tree_insns(tree),
                        eta_s(i).c_str());
            ok++;
            vm_uses++;
            try
            {
                ld->call("lua_settop", {ld->L, 0}, 5'000'000);
            }
            catch (...)
            {
            }
        }
        catch (const std::exception &ex)
        {
            std::printf("%s %s 失败 %s dump=%s%s\n", line_head(i).c_str(), rel.c_str(),
                        ex.what(), fmt_dur(s_dump).c_str(), eta_s(i).c_str());
            bad++;
            ld.reset();
            vm_uses = 0;
        }
    }
    if (jf)
        std::fclose(jf);
    std::printf("== 完成 成功=%d 失败=%d 跳过=%d 反编译=%d 反汇编=%d FuncTable=%d  Luac=%s  MasterData=%s\n",
                ok, bad, skip, lua_ok, lua_dis, lua_ft, luac_dir.c_str(), master_dir.c_str());
    return bad ? 1 : 0;
}
