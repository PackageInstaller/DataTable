-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sroleadd.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleAdd = dataclass("SRoleAdd", require("framework.net.protocol"))
SRoleAdd.ProtocolType = 1012
SRoleAdd.MaxSize = 65535
SRoleAdd.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleAdd, _ENV
  ((SRoleAdd.super).Ctor)(self, client)
  self.role = ((require("protocols.bean.protocol.login.role")).Create)()
end

SRoleAdd.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.role):Marshal(buffer) then
    return false
  end
  return true
end

SRoleAdd.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.role):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRoleAdd

