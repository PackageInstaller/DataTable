local BannerDotCell = class("BannerDotCell", Dialog)
BannerDotCell.AssetBundleName = "ui/layouts.basemainhud"
BannerDotCell.AssetName = "BaseMainHUDActivityDot"

function BannerDotCell:Ctor(...)
  BannerDotCell.super.Ctor(self, ...)
end

function BannerDotCell:OnCreate()
  self._dotGrey = self:GetChild("Dot0")
  self._dotLight = self:GetChild("Dot1")
end

function BannerDotCell:OnDestroy()
end

local function Refresh(self)
  if self._delegate._curActivityIndex and self._cellData.id == self._delegate._bannerList[self._delegate._curActivityIndex].id then
    self._dotGrey:SetActive(false)
    self._dotLight:SetActive(true)
  else
    self._dotGrey:SetActive(true)
    self._dotLight:SetActive(false)
  end
end

function BannerDotCell:RefreshCell(data)
  Refresh(self)
end

function BannerDotCell:OnEvent(eventName, arg)
  if eventName == "SetPageDot" then
    Refresh(self)
  end
end

return BannerDotCell
