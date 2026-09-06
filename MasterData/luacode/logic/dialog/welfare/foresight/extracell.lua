local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local ExtraCell = class("ExtraCell", Dialog)
ExtraCell.AssetBundleName = "ui/layouts.welfare"
ExtraCell.AssetName = "ActivityForesightAwardCell"

function ExtraCell:Ctor(...)
  ExtraCell.super.Ctor(self, ...)
end

function ExtraCell:OnCreate()
  self._title = self:GetChild("Cell/Title")
  self._goodIcon = self:GetChild("Cell/Item/Icon")
  self._goodIcon:Subscribe_PointerClickEvent(self.OnGoodIconClicked, self)
  self._moneyIcon = self:GetChild("Cell/Money/Icon")
  self._moneyNum = self:GetChild("Cell/Money/Num")
  self._moneyIcon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._getMask = self:GetChild("Cell/Get")
  self._greyLock = self:GetChild("Cell/GreyLock")
  self._greyLockTxt = self:GetChild("Cell/GreyLock/Txt")
  self._redDot = self:GetChild("Cell/RedDot")
end

function ExtraCell:OnDestroy()
  if self._refreshTimer then
    ServerGameTimer.RemoveTask(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function ExtraCell:RefreshCell(data)
  self._dm = NekoData.DataManager.DM_Foresight
  self._bm = NekoData.BehaviorManager.BM_Foresight
  self._data = data
  self._title:SetText(TextManager.GetText(self._data.goodName))
  local imageRecord = CImagePathTable:GetRecorder(self._data.pictureId) or DataCommon.DefaultImageAsset
  self._goodIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._moneyItem = Item.Create(self._data.moneyType)
  imageRecord = self._moneyItem:GetIcon()
  self._moneyIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._moneyNum:SetText(NumberManager.GetShowNumber(self._data.price))
  self._getMask:SetActive(self._data.isGet)
  self._greyLock:SetActive(not self._data.isUnlock)
  if self._refreshTimer then
    ServerGameTimer.RemoveTask(self._refreshTimer)
    self._refreshTimer = nil
  end
  if not self._data.isUnlock then
    self._refreshTimer = ServerGameTimer.AddTask(0, 60, function()
      local timeAppendIndex = (self._data.dayIndex - self._bm:GetUnlockedDay() - 1) * 24 * 60 * 60 * 1000
      local leftTime = self._bm:GetCurLeftTime() + timeAppendIndex
      if 0 < leftTime then
        self._greyLockTxt:SetText(self._bm:GetRemainTimeStr(leftTime))
      elseif self._refreshTimer then
        ServerGameTimer.RemoveTask(self._refreshTimer)
        self._refreshTimer = nil
      end
    end)
  end
  self._redDot:SetActive(self._data.isUnlock and not self._data.isGet)
end

function ExtraCell:OnItemCellClicked()
  if self._data.isUnlock then
    local width, height = self._moneyIcon:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._moneyItem
      })
      tipsDialog:SetTipsPosition(width, height, self._moneyIcon:GetLocalPointInUiRootPanel())
    end
  end
end

function ExtraCell:OnGoodIconClicked()
  if self._data.isUnlock and not self._data.isGet then
    local dialog = DialogManager.CreateSingletonDialog("welfare.foresight.itembuydialog")
    if dialog then
      dialog:SetData(self._data)
    end
  end
end

return ExtraCell
