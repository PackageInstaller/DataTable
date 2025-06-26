-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/ssearchuser.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSearchUser = dataclass("SSearchUser", require("framework.net.protocol"))
SSearchUser.ProtocolType = 1123
SSearchUser.MaxSize = 65535
SSearchUser.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSearchUser, _ENV
  ((SSearchUser.super).Ctor)(self, client)
  self.users = ((require("protocols.bean.protocol.chat.otheruserinfo")).Create)()
end

SSearchUser.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.users):Marshal(buffer) then
    return false
  end
  return true
end

SSearchUser.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.users):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSearchUser

