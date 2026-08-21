-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceivedbpaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceivedBpAward = dataclass("SReceivedBpAward", require("framework.net.protocol"))
SReceivedBpAward.ProtocolType = 2676
SReceivedBpAward.MaxSize = 65535
SReceivedBpAward.awardId = 0
SReceivedBpAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceivedBpAward
  ((SReceivedBpAward.super).Ctor)(self, client)
end

SReceivedBpAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.awardId) then
    return false
  end
  return true
end

SReceivedBpAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceivedBpAward

