-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivetoweraward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveTowerAward = dataclass("CReceiveTowerAward", require("framework.net.protocol"))
CReceiveTowerAward.ProtocolType = 2454
CReceiveTowerAward.MaxSize = 65535
CReceiveTowerAward.id = 0
CReceiveTowerAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveTowerAward
  ((CReceiveTowerAward.super).Ctor)(self, client)
end

CReceiveTowerAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveTowerAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveTowerAward

