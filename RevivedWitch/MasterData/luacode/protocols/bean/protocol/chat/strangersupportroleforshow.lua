-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/strangersupportroleforshow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local StrangerSupportRoleForShow = dataclass("StrangerSupportRoleForShow")
StrangerSupportRoleForShow.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.roleInfo = ((require("protocols.bean.protocol.chat.supportroleforshow")).Create)()
  self.userInfo = ((require("protocols.bean.protocol.chat.otheruserinfo")).Create)()
end

StrangerSupportRoleForShow.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.roleInfo):Marshal(buffer) then
    return false
  end
  if not (self.userInfo):Marshal(buffer) then
    return false
  end
  return true
end

StrangerSupportRoleForShow.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.roleInfo):Unmarshal(buffer) then
    return false
  end
  if not (self.userInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return StrangerSupportRoleForShow

