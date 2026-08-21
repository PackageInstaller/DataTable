local M = {}
M.C2ZS_RELIABLE_PROTOS = {}
M.ZS2C_RELIABLE_PROTOS = {}

function M.is_reliable_zs_proto(proto_name)
  return M.C2ZS_RELIABLE_PROTOS[proto_name] or M.ZS2C_RELIABLE_PROTOS[proto_name]
end

M.C2FS_RELIABLE_PROTOS = {c2gs_call_scene = 1}
M.FS2C_RELIABLE_PROTOS = {gs2c_call_scene = 1}

function M.is_reliable_fs_proto(proto_name)
  return M.C2FS_RELIABLE_PROTOS[proto_name] or M.FS2C_RELIABLE_PROTOS[proto_name]
end

local CProtoCache = {}
CProtoCache.__index = CProtoCache

function CProtoCache:new(capacity)
  local o = {}
  setmetatable(o, self)
  o:_init(capacity)
  return o
end

function CProtoCache:_init(capacity)
  self.m_lSendCacheQueue = {}
  self.m_iSendTop = 0
  self.m_iSendCapacity = capacity
  self.m_iSendNum = 0
  self.m_iRecvNum = 0
end

function CProtoCache:add_recv_num(val)
  self.m_iRecvNum = self.m_iRecvNum + val
end

function CProtoCache:get_recv_num()
  return self.m_iRecvNum
end

function CProtoCache:get_send_num()
  return self.m_iSendNum
end

function CProtoCache:push_send_pkg(pkg)
  self.m_iSendTop = self.m_iSendTop + 1
  self.m_lSendCacheQueue[self.m_iSendTop] = pkg
  self.m_iSendNum = self.m_iSendNum + 1
  self:_shrink_cache(self.m_iSendCapacity)
end

function CProtoCache:peer_recv_ack(iPeerRecvNum)
  if iPeerRecvNum > self.m_iSendNum then
    return false
  end
  local cacheSize = self.m_iSendNum - iPeerRecvNum
  self:_shrink_cache(cacheSize)
  return true
end

function CProtoCache:peek_unack_pkgs(iPeerRecvNum)
  if iPeerRecvNum > self.m_iSendNum then
    return false
  end
  local iNeedSize = self.m_iSendNum - iPeerRecvNum
  local lCache = {}
  local idx = self.m_iSendTop
  while self.m_lSendCacheQueue[idx] and not (iNeedSize <= #lCache) do
    lCache[#lCache + 1] = self.m_lSendCacheQueue[idx]
    idx = idx - 1
  end
  if iNeedSize > #lCache then
    return false
  end
  return true, lCache
end

function CProtoCache:_shrink_cache(cacheSize)
  local idx = self.m_iSendTop - cacheSize
  while self.m_lSendCacheQueue[idx] do
    self.m_lSendCacheQueue[idx] = nil
    idx = idx - 1
  end
end

function CProtoCache:peek_cache()
  local cache = {}
  local idx = self.m_iSendTop
  while self.m_lSendCacheQueue[idx] do
    cache[#cache + 1] = self.m_lSendCacheQueue[idx]
    idx = idx - 1
  end
  return cache
end

function CProtoCache:get_cache_size()
  local size = 0
  local idx = self.m_iSendTop
  while self.m_lSendCacheQueue[idx] do
    idx = idx - 1
    size = size + 1
  end
  return size
end

function CProtoCache:clear_cache()
  self.m_lSendCacheQueue = {}
  self.m_iSendTop = 0
end

function M.new_proto_cache(capacity)
  return CProtoCache:new(capacity)
end

return M
