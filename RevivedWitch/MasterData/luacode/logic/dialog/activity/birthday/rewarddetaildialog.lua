-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/rewarddetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local RewardDetailDialog = class("RewardDetailDialog", Dialog)
RewardDetailDialog.AssetBundleName = "ui/layouts.activitylogin"
RewardDetailDialog.AssetName = "ActivityLoginReward"
RewardDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardDetailDialog
  ((RewardDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._rewardData = {}
end

RewardDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Title")
  self._detail = self:GetChild("Detail")
  self._backBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("ItemFrame")
  self._frame = (TableFrame.Create)(self._panel, self, false, false, false, false)
  self._confirmBtn = self:GetChild("GoBtn")
  self._confirmBtnText = self:GetChild("GoBtn/_Text")
  self._itemCell = self:GetChild("TaskCellItem")
  self._itemFrame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemCount = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:SetStatic()
end

RewardDetailDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

RewardDetailDialog.SetStatic = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(2088)).msgTextID))
  ;
  (self._detail):SetText((TextManager.GetText)((CStringRes:GetRecorder(2089)).msgTextID))
end

RewardDetailDialog.SetData = function(self, rewardID, rewardState, rewardItemLeft, rewardNumLeft, rewardItemRight, rewardNumRight)
  -- function num : 0_4 , upvalues : _ENV, CStringRes, Item
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._rewardID = rewardID
  self._rewardState = rewardState
  ;
  (self._confirmBtn):SetInteractable(self._rewardState == 1)
  if self._rewardState == 2 then
    (self._confirmBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1663)).msgTextID))
  elseif self._rewardState == 1 then
    (self._confirmBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1662)).msgTextID))
  else
    (self._confirmBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1662)).msgTextID))
  end
  self._itemLeft = (Item.Create)(rewardItemLeft)
  local imageRecord = (self._itemLeft):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._itemLeft):GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCount):SetNumber(rewardNumLeft)
  for key,_ in pairs(self._rewardData) do
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R13 in 'UnsetPending'

    (self._rewardData)[key] = nil
  end
  for key,value in ipairs(rewardItemRight) do
    (table.insert)(self._rewardData, {item = value, num = rewardNumRight[key]})
  end
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

RewardDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

RewardDetailDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return #self._rewardData
end

RewardDetailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.birthday.itemcell"
end

RewardDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._rewardData)[index]
end

RewardDetailDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_9
  if self._rewardState == 1 then
    (self._bm):SendCOpenBirthReward(self._rewardID)
    self:Destroy()
  end
end

RewardDetailDialog.OnItemCellClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._itemLeft})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

return RewardDetailDialog

