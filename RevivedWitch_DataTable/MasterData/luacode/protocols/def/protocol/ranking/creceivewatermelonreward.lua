-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/creceivewatermelonreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveWatermelonReward = dataclass("CReceiveWatermelonReward", require("framework.net.protocol"))
CReceiveWatermelonReward.ProtocolType = 3513
CReceiveWatermelonReward.MaxSize = 65535
CReceiveWatermelonReward.id = 0
CReceiveWatermelonReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveWatermelonReward
  ((CReceiveWatermelonReward.super).Ctor)(self, client)
end

CReceiveWatermelonReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveWatermelonReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWatermelonReward

