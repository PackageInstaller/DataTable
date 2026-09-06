local GachaGMCell = class("GachaGMCell", Dialog)
GachaGMCell.AssetBundleName = "ui/layouts.gm"
GachaGMCell.AssetName = "GachaGMCell"

function GachaGMCell:Ctor(...)
  GachaGMCell.super.Ctor(self, ...)
end

function GachaGMCell:OnCreate()
  self._title = self:GetChild("Txt1")
  self._rateNum = self:GetChild("Num1")
end

function GachaGMCell:OnDestroy()
end

function GachaGMCell:RefreshCell(data)
  self._title:SetText(data.title)
  self._rateNum:SetText(tostring(data.num) .. "\t\t" .. tostring(data.rate) .. "%")
end

return GachaGMCell
