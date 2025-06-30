-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/copenmail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenMail = dataclass("COpenMail", require("framework.net.protocol"))
COpenMail.ProtocolType = 1411
COpenMail.MaxSize = 65535
COpenMail.uniqueId = 0
COpenMail.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenMail
  ((COpenMail.super).Ctor)(self, client)
end

COpenMail.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  return true
end

COpenMail.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenMail

