-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_role.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Role = class("BM_Role")
BM_Role.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._roleData = (NekoData.Data).role
end

BM_Role.GetRole = function(self, id)
  -- function num : 0_1 , upvalues : _ENV
  for i,onerole in ipairs(self._roleData) do
    if onerole.userid == id then
      return onerole
    end
  end
  return nil
end

return BM_Role

