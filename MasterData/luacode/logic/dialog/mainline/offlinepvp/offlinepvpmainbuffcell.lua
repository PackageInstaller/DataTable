local OffLinePvpMainBuffCell = class("OffLinePvpMainBuffCell", Dialog)
OffLinePvpMainBuffCell.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePvpMainBuffCell.AssetName = "OffLinePVPMainBuffCell"

function OffLinePvpMainBuffCell:Ctor(...)
  OffLinePvpMainBuffCell.super.Ctor(self, ...)
end

function OffLinePvpMainBuffCell:OnCreate()
  self._txt = self:GetChild("Txt")
end

function OffLinePvpMainBuffCell:OnDestroy()
end

function OffLinePvpMainBuffCell:RefreshCell(data)
  self._txt:SetText(TextManager.GetText(data))
end

return OffLinePvpMainBuffCell
