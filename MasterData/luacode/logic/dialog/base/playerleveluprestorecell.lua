local GridFrame = require("framework.ui.frame.grid.gridframe")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local PlayerLevelUpRestoreCell = class("PlayerLevelUpRestoreCell", Dialog)
PlayerLevelUpRestoreCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpRestoreCell.AssetName = "MagicLevelUpRestore"

function PlayerLevelUpRestoreCell:Ctor(...)
  PlayerLevelUpRestoreCell.super.Ctor(self, ...)
end

function PlayerLevelUpRestoreCell:OnCreate()
  self._txt = self:GetChild("Txt2")
end

function PlayerLevelUpRestoreCell:OnDestroy()
end

function PlayerLevelUpRestoreCell:RefreshCell(data)
  self._txt:SetText(data.value)
end

return PlayerLevelUpRestoreCell
