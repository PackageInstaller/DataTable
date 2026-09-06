local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local RewardDetailDialog = class("RewardDetailDialog", Dialog)
RewardDetailDialog.AssetBundleName = "ui/layouts.activitylogin"
RewardDetailDialog.AssetName = "ActivityLoginReward"

function RewardDetailDialog:Ctor(...)
  RewardDetailDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._rewardData = {}
end

function RewardDetailDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._detail = self:GetChild("Detail")
  self._backBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("ItemFrame")
  self._frame = TableFrame.Create(self._panel, self, false, false, false, false)
  self._confirmBtn = self:GetChild("GoBtn")
  self._confirmBtnText = self:GetChild("GoBtn/_Text")
  self._itemCell = self:GetChild("TaskCellItem")
  self._itemFrame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemCount = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:SetStatic()
end

function RewardDetailDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function RewardDetailDialog:SetStatic()
  self._title:SetText(TextManager.GetText(CStringRes:GetRecorder(2088).msgTextID))
  self._detail:SetText(TextManager.GetText(CStringRes:GetRecorder(2089).msgTextID))
end

function RewardDetailDialog:SetData(rewardID, rewardState, rewardItemLeft, rewardNumLeft, rewardItemRight, rewardNumRight)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._rewardID = rewardID
  self._rewardState = rewardState
  self._confirmBtn:SetInteractable(self._rewardState == 1)
  if self._rewardState == 2 then
    self._confirmBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1663).msgTextID))
  elseif self._rewardState == 1 then
    self._confirmBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1662).msgTextID))
  else
    self._confirmBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1662).msgTextID))
  end
  self._itemLeft = Item.Create(rewardItemLeft)
  local imageRecord = self._itemLeft:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._itemLeft:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCount:SetNumber(rewardNumLeft)
  for key, _ in pairs(self._rewardData) do
    self._rewardData[key] = nil
  end
  for key, value in ipairs(rewardItemRight) do
    table.insert(self._rewardData, {
      item = value,
      num = rewardNumRight[key]
    })
  end
  self._frame:ReloadAllCell()
end

function RewardDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

function RewardDetailDialog:NumberOfCell(frame, index)
  return #self._rewardData
end

function RewardDetailDialog:CellAtIndex(frame, index)
  return "activity.birthday.itemcell"
end

function RewardDetailDialog:DataAtIndex(frame, index)
  return self._rewardData[index]
end

function RewardDetailDialog:OnConfirmBtnClicked()
  if self._rewardState == 1 then
    self._bm:SendCOpenBirthReward(self._rewardID)
    self:Destroy()
  end
end

function RewardDetailDialog:OnItemCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemLeft
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

return RewardDetailDialog
