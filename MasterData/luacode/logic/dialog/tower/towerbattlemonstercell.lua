local Item = require("logic.manager.experimental.types.item")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
local TowerBattleMonsterCell = class("TowerBattleMonsterCell", Dialog)
TowerBattleMonsterCell.AssetBundleName = "ui/layouts.mainline"
TowerBattleMonsterCell.AssetName = "TowerEventBattleCell"

function TowerBattleMonsterCell:Ctor(...)
  TowerBattleMonsterCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TowerBattleMonsterCell:OnCreate()
  self._monsterImg = self:GetChild("Monster")
  self._level = self:GetChild("Num")
  self._progress = self:GetChild("ProgressBack/Progress")
end

function TowerBattleMonsterCell:OnDestroy()
end

function TowerBattleMonsterCell:RefreshCell()
  local recorder = cimagepath:GetRecorder(self._cellData.icon)
  self._monsterImg:SetSprite(recorder.assetBundle, recorder.assetName)
  self._progress:SetFillAmount(self._cellData.hp)
  self._level:SetText(self._cellData.level)
end

return TowerBattleMonsterCell
