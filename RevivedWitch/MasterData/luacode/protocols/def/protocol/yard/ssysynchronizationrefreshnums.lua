-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/ssysynchronizationrefreshnums.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSySynchronizationRefreshNums = dataclass("SSySynchronizationRefreshNums", require("framework.net.protocol"))
SSySynchronizationRefreshNums.ProtocolType = 2331
SSySynchronizationRefreshNums.MaxSize = 65535
SSySynchronizationRefreshNums.nums = 0
SSySynchronizationRefreshNums.leftRefreshTime = 0
SSySynchronizationRefreshNums.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSySynchronizationRefreshNums
  ((SSySynchronizationRefreshNums.super).Ctor)(self, client)
end

SSySynchronizationRefreshNums.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.nums) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftRefreshTime) then
    return false
  end
  return true
end

SSySynchronizationRefreshNums.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSySynchronizationRefreshNums

