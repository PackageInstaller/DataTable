-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceiveoldplayerwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveOldPlayerWelfare = dataclass("CReceiveOldPlayerWelfare", require("framework.net.protocol"))
CReceiveOldPlayerWelfare.ProtocolType = 2735
CReceiveOldPlayerWelfare.MaxSize = 65535
CReceiveOldPlayerWelfare.awardIndex = 0
CReceiveOldPlayerWelfare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveOldPlayerWelfare
  ((CReceiveOldPlayerWelfare.super).Ctor)(self, client)
end

CReceiveOldPlayerWelfare.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.awardIndex) then
    return false
  end
  return true
end

CReceiveOldPlayerWelfare.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveOldPlayerWelfare

