-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/ccheckphonecode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckPhoneCode = dataclass("CCheckPhoneCode", require("framework.net.protocol"))
CCheckPhoneCode.ProtocolType = 2253
CCheckPhoneCode.MaxSize = 65535
CCheckPhoneCode.code = ""
CCheckPhoneCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckPhoneCode
  ((CCheckPhoneCode.super).Ctor)(self, client)
end

CCheckPhoneCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.code) then
    return false
  end
  return true
end

CCheckPhoneCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPhoneCode

