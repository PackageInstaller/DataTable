local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BannerCell = class("BannerCell", Dialog)
BannerCell.AssetBundleName = "ui/layouts.basemainhud"
BannerCell.AssetName = "BaseMainHUDActivityCell"

function BannerCell:Ctor(...)
  BannerCell.super.Ctor(self, ...)
end

function BannerCell:OnCreate()
  self._image = self:GetChild("Image")
  self._time = self:GetChild("Time")
  self._time:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function BannerCell:OnDestroy()
end

function BannerCell:RefreshCell(data)
  self._time:SetActive(true)
  self._time:SetText(data.record.bannerTimeText)
  local imageRecord = CImagePathTable:GetRecorder(data.record.bannerpicid) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function BannerCell:OnCellClick()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(self._cellData.id)
end

return BannerCell
