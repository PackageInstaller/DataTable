-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivewhitevalentinereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveWhiteValentineReward = dataclass("CReceiveWhiteValentineReward", require("framework.net.protocol"))
CReceiveWhiteValentineReward.ProtocolType = 2613
CReceiveWhiteValentineReward.MaxSize = 65535
CReceiveWhiteValentineReward.id = 0
CReceiveWhiteValentineReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveWhiteValentineReward
  ((CReceiveWhiteValentineReward.super).Ctor)(self, client)
end

CReceiveWhiteValentineReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveWhiteValentineReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWhiteValentineReward

