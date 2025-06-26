-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/csysynchronizationrefreshnums.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSySynchronizationRefreshNums = dataclass("CSySynchronizationRefreshNums", require("framework.net.protocol"))
CSySynchronizationRefreshNums.ProtocolType = 2330
CSySynchronizationRefreshNums.MaxSize = 65535
CSySynchronizationRefreshNums.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSySynchronizationRefreshNums
  ((CSySynchronizationRefreshNums.super).Ctor)(self, client)
end

CSySynchronizationRefreshNums.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CSySynchronizationRefreshNums.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CSySynchronizationRefreshNums

