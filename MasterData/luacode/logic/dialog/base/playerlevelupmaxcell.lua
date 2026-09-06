local GridFrame = require("framework.ui.frame.grid.gridframe")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local PlayerLevelUpMaxCell = class("PlayerLevelUpMaxCell", Dialog)
PlayerLevelUpMaxCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpMaxCell.AssetName = "MagicLevelUpMax"

function PlayerLevelUpMaxCell:Ctor(...)
  PlayerLevelUpMaxCell.super.Ctor(self, ...)
end

function PlayerLevelUpMaxCell:OnCreate()
  self._spiritPre = self:GetChild("Txt2")
  self._spiritCur = self:GetChild("Txt3")
end

function PlayerLevelUpMaxCell:OnDestroy()
end

function PlayerLevelUpMaxCell:RefreshCell(data)
  local lv = self._delegate:GetLevel()
  self._spiritCur:SetText(data.value)
  local playerInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local recorder = CPlayerLevel:GetRecorder(lv - 1)
  local spiritPre = recorder.strengthLimit
  self._spiritPre:SetText(spiritPre)
end

return PlayerLevelUpMaxCell
