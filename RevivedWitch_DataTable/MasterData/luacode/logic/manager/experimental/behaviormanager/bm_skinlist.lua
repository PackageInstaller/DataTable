-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_skinlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_SkinList = class("BM_SkinList")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
BM_SkinList.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).skinlist
end

BM_SkinList.GetSkinList = function(self)
  -- function num : 0_1
  return (self._data).skinlist
end

BM_SkinList.GetCurrentSkinNum = function(self)
  -- function num : 0_2
  return (self._data).currentNum
end

BM_SkinList.GetSkinCollectTask = function(self)
  -- function num : 0_3
  return (self._data).taskstate
end

BM_SkinList.IsUnLockSkin = function(self, id)
  -- function num : 0_4
  do return ((self._data).skinlist)[id] == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_SkinList.IsUnLockSkinByItemId = function(self, id)
  -- function num : 0_5 , upvalues : CSkinItem, RoleSkin
  local skinIDCfg = CSkinItem:GetRecorder(id)
  local skinItem = (RoleSkin.Create)(skinIDCfg.Skinid)
  return self:IsUnLockSkin(skinItem:GetSkinId())
end

BM_SkinList.IsHasBoxReddot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs((self._data).taskstate) do
    if v == 1 then
      return true
    end
  end
  return 
end

BM_SkinList.GetProcessStr = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return tostring((self._data).currentNum) .. "/" .. tostring((self._data).totalskinNum)
end

return BM_SkinList

