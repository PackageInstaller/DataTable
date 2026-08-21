local ssub = string.sub
local tinsert = table.insert
local tconcat = table.concat
local CStreamCache = {}
CStreamCache.__index = CStreamCache

function CStreamCache:new(maxCacheCount)
  local o = {}
  setmetatable(o, self)
  o:_init(maxCacheCount)
  return o
end

function CStreamCache:_init(maxCacheCount)
  self.m_mSendCache = {}
  self.m_iSendTop = 0
  self.m_iCacheBytes = 0
  self.m_iMaxCacheCount = maxCacheCount
end

function CStreamCache:insert(data)
  self.m_iSendTop = self.m_iSendTop + 1
  self.m_mSendCache[self.m_iSendTop] = data
  self.m_iCacheBytes = self.m_iCacheBytes + #data
  local tailIdx = self.m_iSendTop - self.m_iMaxCacheCount
  while self.m_mSendCache[tailIdx] do
    local pkg = self.m_mSendCache[tailIdx]
    self.m_mSendCache[tailIdx] = nil
    self.m_iCacheBytes = self.m_iCacheBytes - #pkg
    tailIdx = tailIdx - 1
  end
end

function CStreamCache:get(nbytes)
  if nbytes > self.m_iCacheBytes then
    return
  end
  local cache = self.m_mSendCache
  local idx = self.m_iSendTop
  local count = 0
  local ret = {}
  while nbytes > count do
    local v = cache[idx]
    if not v then
      return
    end
    local len = #v
    local n = len
    local vv = v
    if nbytes < count + len then
      local sub_n = nbytes - count
      local pos = len - sub_n
      local sub_v = ssub(v, pos + 1)
      n = sub_n
      vv = sub_v
    end
    tinsert(ret, 1, vv)
    count = count + n
    idx = idx - 1
  end
  return tconcat(ret)
end

function CStreamCache:cache_bytes()
  return self.m_iCacheBytes
end

function CStreamCache:clear()
  self.m_iCacheBytes = 0
  self.m_iSendTop = 0
  self.m_mSendCache = {}
end

return CStreamCache
