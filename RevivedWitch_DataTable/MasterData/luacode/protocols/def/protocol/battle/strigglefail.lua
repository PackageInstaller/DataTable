-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/strigglefail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local STriggleFail = dataclass("STriggleFail", require("framework.net.protocol"))
STriggleFail.ProtocolType = 1946
STriggleFail.MaxSize = 65535
STriggleFail.eventId = 0
STriggleFail.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : STriggleFail
  ((STriggleFail.super).Ctor)(self, client)
end

STriggleFail.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eventId) then
    return false
  end
  return true
end

STriggleFail.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STriggleFail

