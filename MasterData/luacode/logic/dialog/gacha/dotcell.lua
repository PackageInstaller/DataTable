local DotCell = class("DotCell", Dialog)
DotCell.AssetBundleName = "ui/layouts.gacha"
DotCell.AssetName = "GachaMainPageDotsCell"

function DotCell:OnCreate()
  self._dotGrey = self:GetChild("Dot0")
  self._dotLight = self:GetChild("Dot1")
end

function DotCell:OnDestroy()
end

function DotCell:RefreshCell(data)
  if data == self._delegate._selectedPoolIndex then
    self._dotGrey:SetActive(false)
    self._dotLight:SetActive(true)
  else
    self._dotGrey:SetActive(true)
    self._dotLight:SetActive(false)
  end
end

function DotCell:OnEvent(eventName, arg)
  if eventName == "SetPageDot" then
    if self._cellData == self._delegate._selectedPoolIndex then
      self._dotGrey:SetActive(false)
      self._dotLight:SetActive(true)
    else
      self._dotGrey:SetActive(true)
      self._dotLight:SetActive(false)
    end
  end
end

return DotCell
