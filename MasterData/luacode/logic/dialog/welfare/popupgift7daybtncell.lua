local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CommonAwardStatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local PopUpGift7DayBtnCell = class("PopUpGift7DayBtnCell", Dialog)
PopUpGift7DayBtnCell.AssetBundleName = "ui/layouts.welfare"
PopUpGift7DayBtnCell.AssetName = "Promotions7DaysCell"

function PopUpGift7DayBtnCell:Ctor(...)
  PopUpGift7DayBtnCell.super.Ctor(self, ...)
end

function PopUpGift7DayBtnCell:OnCreate()
  self._button = self:GetChild("Day")
  self._lock_panel = self:GetChild("Day/Lock")
  self._lock_panel_day = self:GetChild("Day/Lock/Text (1)")
  self._unlock_panel = self:GetChild("Day/Normal")
  self._unlock_panel_day = self:GetChild("Day/Normal/Text (1)")
  self._select_panel = self:GetChild("Day/Select")
  self._select_panel_day = self:GetChild("Day/Select/Text (1)")
  self._redDot = self:GetChild("Day/RedDot")
  self._button:Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

function PopUpGift7DayBtnCell:OnDestroy()
end

function PopUpGift7DayBtnCell:RefreshCell(data)
  if data.status == CommonAwardStatus.LOCKED then
    self._lock_panel:SetActive(true)
    self._unlock_panel:SetActive(false)
  elseif data.status == CommonAwardStatus.UNLOCKED then
    self._lock_panel:SetActive(false)
    self._unlock_panel:SetActive(true)
  elseif data.status == CommonAwardStatus.FETCHED then
    self._lock_panel:SetActive(false)
    self._unlock_panel:SetActive(true)
  end
  self._select_panel:SetActive(data.id == self._delegate._selectId)
  self._select_panel_day:SetText(NekoData.BehaviorManager.BM_Message:GetString(2241, {
    data.record.days
  }))
  self._lock_panel_day:SetText(NekoData.BehaviorManager.BM_Message:GetString(2241, {
    data.record.days
  }))
  self._unlock_panel_day:SetText(NekoData.BehaviorManager.BM_Message:GetString(2241, {
    data.record.days
  }))
  self._redDot:SetActive(data.status == CommonAwardStatus.UNLOCKED)
end

function PopUpGift7DayBtnCell:OnBtnClicked()
  self._delegate:SetSelectId(self._cellData.id)
end

function PopUpGift7DayBtnCell:OnEvent(eventName, arg)
  if eventName == "SetSelectId" then
    self._select_panel:SetActive(self._cellData.id == self._delegate._selectId)
  end
end

function PopUpGift7DayBtnCell:RefreshImgByPointer(pointerDown)
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

return PopUpGift7DayBtnCell
