-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/csearchuser.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSearchUser = dataclass("CSearchUser", require("framework.net.protocol"))
CSearchUser.ProtocolType = 1122
CSearchUser.MaxSize = 65535
CSearchUser.Keyword = ""
CSearchUser.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSearchUser
  ((CSearchUser.super).Ctor)(self, client)
end

CSearchUser.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.Keyword) then
    return false
  end
  return true
end

CSearchUser.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSearchUser

