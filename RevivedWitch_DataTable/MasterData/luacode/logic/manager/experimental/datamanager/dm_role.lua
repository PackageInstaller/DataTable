-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_role.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Role = class("DM_Role")
DM_Role.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._roleData = (NekoData.Data).role
end

DM_Role.SetRole = function(self, role)
  -- function num : 0_1 , upvalues : _ENV
  (table.insert)(self._roleData, role)
end

return DM_Role

