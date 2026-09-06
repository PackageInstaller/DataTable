local GridFrame = require("framework.ui.frame.grid.gridframe")
local PlayerLevelUpFunctionCell = class("PlayerLevelUpFunctionCell", Dialog)
PlayerLevelUpFunctionCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpFunctionCell.AssetName = "MagicLevelUpFunction"

function PlayerLevelUpFunctionCell:Ctor(...)
  PlayerLevelUpFunctionCell.super.Ctor(self, ...)
end

function PlayerLevelUpFunctionCell:OnCreate()
  self._unlockTxt = self:GetChild("Txt2")
end

function PlayerLevelUpFunctionCell:OnDestroy()
end

function PlayerLevelUpFunctionCell:RefreshCell(data)
  local str = TextManager.GetText(data.value)
  self._unlockTxt:SetText(str)
end

return PlayerLevelUpFunctionCell
