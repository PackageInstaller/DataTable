-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/ssendqueueinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendQueueInfo = dataclass("SSendQueueInfo", require("framework.net.protocol"))
SSendQueueInfo.ProtocolType = 1080
SSendQueueInfo.MaxSize = 65535
SSendQueueInfo.order = 0
SSendQueueInfo.queuelength = 0
SSendQueueInfo.minutes = 0
SSendQueueInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendQueueInfo
  ((SSendQueueInfo.super).Ctor)(self, client)
end

SSendQueueInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.order) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.queuelength) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.minutes) then
    return false
  end
  return true
end

SSendQueueInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendQueueInfo

