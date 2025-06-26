-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/scheckphonecode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCheckPhoneCode = dataclass("SCheckPhoneCode", require("framework.net.protocol"))
SCheckPhoneCode.ProtocolType = 2254
SCheckPhoneCode.MaxSize = 65535
SCheckPhoneCode.result = 0
SCheckPhoneCode.num = ""
SCheckPhoneCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCheckPhoneCode
  ((SCheckPhoneCode.super).Ctor)(self, client)
end

SCheckPhoneCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.num) then
    return false
  end
  return true
end

SCheckPhoneCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckPhoneCode

