local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local WelfareTabBtnCell = class("WelfareTabBtnCell", Dialog)
WelfareTabBtnCell.AssetBundleName = "ui/layouts.welfare"
WelfareTabBtnCell.AssetName = "WelfareMainGroupBtnCell"

function WelfareTabBtnCell:Ctor(...)
  WelfareTabBtnCell.super.Ctor(self, ...)
end

function WelfareTabBtnCell:OnCreate()
  self._groupBtn = self:GetChild("GroupBtn")
  self._img = self:GetChild("Img")
  self._name = self:GetChild("GroupBtn/Text")
  self._redDot = self:GetChild("GroupBtn/RedDot")
  self._groupBtn:Subscribe_PointerClickEvent(self.OnGroupBtnClicked, self)
  self._groupBtn:Subscribe_PointerDownEvent(self.OnGroupBtnPointerDown, self)
  self._groupBtn:Subscribe_PointerUpEvent(self.OnGroupBtnPointerUp, self)
  self._groupBtn:Subscribe_PointerCancelEvent(self.OnGroupBtnPointerUp, self)
end

function WelfareTabBtnCell:OnDestroy()
end

function WelfareTabBtnCell:RefreshCell(data)
  self._name:SetText(TextManager.GetText(data.record.name))
  local imageRecord
  if self._delegate._selectedTab == data.record.id then
    self._groupBtn:SetSelected(true)
    imageRecord = CImagePathTable:GetRecorder(data.record.tabImgSelected) or DataCommon.DefaultImageAsset
  else
    self._groupBtn:SetSelected(false)
    imageRecord = CImagePathTable:GetRecorder(data.record.tabImg) or DataCommon.DefaultImageAsset
  end
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._redDot:SetActive(data.showRedDot)
end

function WelfareTabBtnCell:OnGroupBtnClicked()
  if self._cellData.record.id == DataCommon.Activities.AccumulateCost and not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.AccumulateCost) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100498)
    return
  else
    self._delegate:SetSelectedTab(self._cellData.record.id)
  end
end

function WelfareTabBtnCell:OnEvent(eventName, arg)
  if eventName == "SelectedTab" then
    local imageRecord
    if self._delegate._selectedTab == self._cellData.record.id then
      self._groupBtn:SetSelected(true)
      imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImgSelected) or DataCommon.DefaultImageAsset
    else
      self._groupBtn:SetSelected(false)
      imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImg) or DataCommon.DefaultImageAsset
    end
    self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if eventName == "RefreshRedDot" and arg.tabId == self._cellData.record.id then
    self._redDot:SetActive(arg.show)
  end
end

function WelfareTabBtnCell:RefreshImgByPointer(pointerDown)
  local imageRecord
  if pointerDown then
    if self._delegate._selectedTab == self._cellData.record.id then
      imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImgSelectedsmall) or DataCommon.DefaultImageAsset
    else
      imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImgsmall) or DataCommon.DefaultImageAsset
    end
  elseif self._delegate._selectedTab == self._cellData.record.id then
    imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImgSelected) or DataCommon.DefaultImageAsset
  else
    imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImg) or DataCommon.DefaultImageAsset
  end
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function WelfareTabBtnCell:OnGroupBtnPointerDown()
  self:RefreshImgByPointer(true)
end

function WelfareTabBtnCell:OnGroupBtnPointerUp()
  self:RefreshImgByPointer(false)
end

return WelfareTabBtnCell
