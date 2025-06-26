-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerbattlemonstercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local TowerBattleMonsterCell = class("TowerBattleMonsterCell", Dialog)
TowerBattleMonsterCell.AssetBundleName = "ui/layouts.mainline"
TowerBattleMonsterCell.AssetName = "TowerEventBattleCell"
TowerBattleMonsterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerBattleMonsterCell
  ((TowerBattleMonsterCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TowerBattleMonsterCell.OnCreate = function(self)
  -- function num : 0_1
  self._monsterImg = self:GetChild("Monster")
  self._level = self:GetChild("Num")
  self._progress = self:GetChild("ProgressBack/Progress")
end

TowerBattleMonsterCell.OnDestroy = function(self)
  -- function num : 0_2
end

TowerBattleMonsterCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : cimagepath
  local recorder = cimagepath:GetRecorder((self._cellData).icon)
  ;
  (self._monsterImg):SetSprite(recorder.assetBundle, recorder.assetName)
  ;
  (self._progress):SetFillAmount((self._cellData).hp)
  ;
  (self._level):SetText((self._cellData).level)
end

return TowerBattleMonsterCell

