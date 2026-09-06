local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ActivityListCell = class("ActivityListCell", Dialog)
ActivityListCell.AssetBundleName = "ui/layouts.activityhud"
ActivityListCell.AssetName = "ActivityListCell"

function ActivityListCell:Ctor(...)
  ActivityListCell.super.Ctor(self, ...)
end

function ActivityListCell:OnCreate()
  self._image = self:GetChild("Activity")
  self._reddot = self:GetChild("Activity/RedDot")
  self._reddot:SetActive(false)
  self._time = self:GetChild("Activity/Time")
  self._time:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function ActivityListCell:OnDestroy()
end

function ActivityListCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.record.bannerpicid) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._reddot:SetActive(data.showRedDot)
  self._time:SetActive(true)
  self._time:SetText(data.record.bannerTimeText)
end

function ActivityListCell:OnCellClick()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(self._cellData.id)
end

return ActivityListCell
