local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CallProgressCell = class("CallProgressCell", Dialog)
CallProgressCell.AssetBundleName = "ui/layouts.activitychristmascall"
CallProgressCell.AssetName = "ActivityChristmasCallTaskCell"

function CallProgressCell:Ctor(...)
  CallProgressCell.super.Ctor(self, ...)
end

function CallProgressCell:OnCreate()
  self._getBtnRoot = self:GetChild("GetBack")
  self._getBtn = self:GetChild("GetBack/GetBtn")
  self._haveGetBtnRoot = self:GetChild("Grey")
  self._haveGetBtn = self:GetChild("Grey/GetTxt")
  self._headItemPanel = self:GetChild("Item")
  self._itemIcon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  self._cellText = self:GetChild("ItemTxt")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._progressBar = self:GetChild("Loading/Loading/BackGround/Progress")
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  self._itemIcon:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function CallProgressCell:OnDestroy()
end

function CallProgressCell:RefreshCell(data)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID)
  self._data = data
  self._getBtnRoot:SetActive(not self._data.remoteData.isGet)
  self._haveGetBtnRoot:SetActive(self._data.remoteData.isGet)
  self._cellText:SetText(TextManager.GetText(self._data.localData.taskid))
  self._item = Item.Create(self._data.localData.rewardid)
  local imageRecord = self._item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCount:SetNumber(self._data.localData.rewardNum)
  self._getBtn:SetInteractable(not self._data.remoteData.isGet and self._data.remoteData.canGet)
  local imageID = 13845
  if self._data.localData.npcTalk ~= 0 then
    imageID = self._data.localData.npcHead
  end
  imageRecord = CImagePathTable:GetRecorder(imageID) or DataCommon.DefaultImageAsset
  self._headItemPanel:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._data.localData.endEvent == 0 then
    self._progressNum:SetText(TextManager.GetText(CStringRes:GetRecorder(1665).msgTextID, 1, 1))
    self._progressBar:SetFillAmount(1)
  else
    local nowShowProgress = math.min(self._data.localData.endEvent, self._data.remoteData.totalScore)
    self._progressNum:SetText(TextManager.GetText(CStringRes:GetRecorder(1665).msgTextID, nowShowProgress, self._data.localData.endEvent))
    self._progressBar:SetFillAmount(nowShowProgress / self._data.localData.endEvent)
  end
end

function CallProgressCell:OnGetBtnClick()
  if not self._data.remoteData.canGet then
    return
  end
  local awardType
  if self._data.localData.callType == 1 then
    awardType = self._bm:GetSChristmasSupportRedPointDef().STAGE
  else
    awardType = self._bm:GetSChristmasSupportRedPointDef().TOTAL_CALL
  end
  self._bm:SendCReceiveSupportReward(awardType, self._data.localData.id)
end

function CallProgressCell:OnCellClick()
  local width, height = self._itemIcon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemIcon:GetLocalPointInUiRootPanel())
  end
end

return CallProgressCell
