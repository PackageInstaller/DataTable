-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/chat/supportrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SupportRole = dataclass("SupportRole")
SupportRole.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.role = ((require("protocols.bean.protocol.login.role")).Create)()
  self.user = ((require("protocols.bean.protocol.chat.otheruserinfo")).Create)()
end

SupportRole.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.role):Marshal(buffer) then
    return false
  end
  if not (self.user):Marshal(buffer) then
    return false
  end
  return true
end

SupportRole.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.role):Unmarshal(buffer) then
    return false
  end
  if not (self.user):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SupportRole

