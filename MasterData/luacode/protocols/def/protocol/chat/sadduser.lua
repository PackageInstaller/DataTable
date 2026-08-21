-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/sadduser.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddUser = dataclass("SAddUser", require("framework.net.protocol"))
SAddUser.ProtocolType = 1135
SAddUser.MaxSize = 65535
SAddUser.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddUser, _ENV
  ((SAddUser.super).Ctor)(self, client)
  self.user = ((require("protocols.bean.protocol.chat.otheruserinfo")).Create)()
end

SAddUser.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.user):Marshal(buffer) then
    return false
  end
  return true
end

SAddUser.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.user):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SAddUser

