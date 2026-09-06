local PlayerLevelUpAfterCell = class("PlayerLevelUpAfterCell", Dialog)
PlayerLevelUpAfterCell.AssetBundleName = "ui/layouts.basemainhud"
PlayerLevelUpAfterCell.AssetName = "MagicLevelUpUnLock"

function PlayerLevelUpAfterCell:Ctor(...)
  PlayerLevelUpAfterCell.super.Ctor(self, ...)
end

function PlayerLevelUpAfterCell:OnCreate()
  self._txt = self:GetChild("Txt1")
end

function PlayerLevelUpAfterCell:OnDestroy()
end

function PlayerLevelUpAfterCell:RefreshCell(data)
  local str = TextManager.GetText(data.value)
  self._txt:SetText(str)
end

return PlayerLevelUpAfterCell
