-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/crolelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRoleList = dataclass("CRoleList", require("framework.net.protocol"))
CRoleList.ProtocolType = 1010
CRoleList.MaxSize = 65535
CRoleList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRoleList
  ((CRoleList.super).Ctor)(self, client)
end

CRoleList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRoleList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRoleList

