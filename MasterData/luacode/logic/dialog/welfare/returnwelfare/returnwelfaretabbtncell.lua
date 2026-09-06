local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ReturnWelfareTabBtnCell = class("ReturnWelfareTabBtnCell", Dialog)
ReturnWelfareTabBtnCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareTabBtnCell.AssetName = "ReturnWelfareGroupBtn"

function ReturnWelfareTabBtnCell:Ctor(...)
  ReturnWelfareTabBtnCell.super.Ctor(self, ...)
end

function ReturnWelfareTabBtnCell:OnCreate()
  self._btnImg = self:GetChild("GroupBtn")
  self._name = self:GetChild("GroupBtn/Text")
  self._redDot = self:GetChild("GroupBtn/RedDot")
  self._btnImg:Subscribe_PointerClickEvent(self.OnGroupBtnClicked, self)
  self._btnImg:Subscribe_PointerDownEvent(self.OnGroupBtnPointerDown, self)
  self._btnImg:Subscribe_PointerUpEvent(self.OnGroupBtnPointerUp, self)
  self._btnImg:Subscribe_PointerCancelEvent(self.OnGroupBtnPointerUp, self)
end

function ReturnWelfareTabBtnCell:OnDestroy()
end

function ReturnWelfareTabBtnCell:RefreshCell(data)
  self._redDot:SetActive(data.showRedDot)
  self._name:SetText(TextManager.GetText(data.record.name))
  local imageRecord
  if self._delegate._selectedTab == data.record.id then
    imageRecord = CImagePathTable:GetRecorder(data.record.tabImgSelected) or DataCommon.DefaultImageAsset
  else
    imageRecord = CImagePathTable:GetRecorder(data.record.tabImg) or DataCommon.DefaultImageAsset
  end
  self._btnImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function ReturnWelfareTabBtnCell:OnGroupBtnClicked()
  self._delegate:SetSelectedTab(self._cellData.record.id)
end

function ReturnWelfareTabBtnCell:OnEvent(eventName, arg)
  if eventName == "SelectedTab" then
    local imageRecord
    if self._delegate._selectedTab == self._cellData.record.id then
      imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImgSelected) or DataCommon.DefaultImageAsset
    else
      imageRecord = CImagePathTable:GetRecorder(self._cellData.record.tabImg) or DataCommon.DefaultImageAsset
    end
    self._btnImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  elseif eventName == "RefreshReddot" and arg.record.id == self._cellData.record.id then
    self._redDot:SetActive(arg.showRedDot)
  end
end

function ReturnWelfareTabBtnCell:RefreshImgByPointer(pointerDown)
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
end

function ReturnWelfareTabBtnCell:OnGroupBtnPointerDown()
  self:RefreshImgByPointer(true)
end

function ReturnWelfareTabBtnCell:OnGroupBtnPointerUp()
  self:RefreshImgByPointer(false)
end

return ReturnWelfareTabBtnCell
