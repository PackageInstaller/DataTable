-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/crespondapplicant.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRespondApplicant = dataclass("CRespondApplicant", require("framework.net.protocol"))
CRespondApplicant.ProtocolType = 1133
CRespondApplicant.MaxSize = 65535
CRespondApplicant.userId = 0
CRespondApplicant.result = 0
CRespondApplicant.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRespondApplicant
  ((CRespondApplicant.super).Ctor)(self, client)
end

CRespondApplicant.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

CRespondApplicant.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRespondApplicant

