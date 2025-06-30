-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceivewhitevalentinereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveWhiteValentineReward = dataclass("SReceiveWhiteValentineReward", require("framework.net.protocol"))
SReceiveWhiteValentineReward.ProtocolType = 2614
SReceiveWhiteValentineReward.MaxSize = 65535
SReceiveWhiteValentineReward.id = 0
SReceiveWhiteValentineReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveWhiteValentineReward
  ((SReceiveWhiteValentineReward.super).Ctor)(self, client)
end

SReceiveWhiteValentineReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

SReceiveWhiteValentineReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveWhiteValentineReward

