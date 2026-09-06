local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local CommonCell = class("CommonCell", Dialog)
CommonCell.AssetBundleName = "ui/layouts.welfare"
CommonCell.AssetName = "ActivityForesightDayCell"

function CommonCell:Ctor(...)
  CommonCell.super.Ctor(self, ...)
end

function CommonCell:OnCreate()
  self._title = self:GetChild("Cell/Title")
  self._itemRank = self:GetChild("Cell/Item/Rank")
  self._itemIcon = self:GetChild("Cell/Item/Icon")
  self._itemNum = self:GetChild("Cell/Item/Num")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._getMask = self:GetChild("Cell/Get")
  self._greyLock = self:GetChild("Cell/GreyLock")
  self._greyLockTxt = self:GetChild("Cell/GreyLock/Txt")
  self._playBtn = self:GetChild("Cell/PlayBtn")
  self._playBtn:Subscribe_PointerClickEvent(self.OnPlayBtnClicked, self)
  self._redDot = self:GetChild("Cell/PlayBtn/RedDot")
end

function CommonCell:OnDestroy()
  if self._refreshTimer then
    ServerGameTimer.RemoveTask(self._refreshTimer)
    self._refreshTimer = nil
  end
end

function CommonCell:RefreshCell(data)
  self._dm = NekoData.DataManager.DM_Foresight
  self._bm = NekoData.BehaviorManager.BM_Foresight
  self._data = data
  self._title:SetText(TextManager.GetText(self._data.cellTitle))
  self._item = Item.Create(self._data.itemId)
  local imageRecord = self._item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetShopPinJiBackGroundImage()
  self._itemRank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemNum:SetText(TextManager.GetText(CStringres:GetRecorder(1873).msgTextID, NumberManager.GetShowNumber(self._data.itemNum)))
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

function CommonCell:OnItemCellClicked()
  if self._data.isUnlock then
    local width, height = self._itemIcon:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
      tipsDialog:SetTipsPosition(width, height, self._itemIcon:GetLocalPointInUiRootPanel())
    end
  end
end

function CommonCell:OnPlayBtnClicked()
  if self._data.isUnlock then
    if not self._data.isGet then
      self._bm:SendCReceiveForesightAct(self._data.dayIndex)
      self._delegate._chatId = self._data.chatId
    else
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        dialog:SetDialogLibraryId(self._data.chatId, false, dialog.DialogType.Foresight)
      end
    end
  end
end

return CommonCell
