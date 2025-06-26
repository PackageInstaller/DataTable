-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/crefreshsupportrolelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshSupportRoleList = dataclass("CRefreshSupportRoleList", require("framework.net.protocol"))
CRefreshSupportRoleList.ProtocolType = 1145
CRefreshSupportRoleList.MaxSize = 65535
CRefreshSupportRoleList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshSupportRoleList
  ((CRefreshSupportRoleList.super).Ctor)(self, client)
end

CRefreshSupportRoleList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshSupportRoleList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshSupportRoleList

