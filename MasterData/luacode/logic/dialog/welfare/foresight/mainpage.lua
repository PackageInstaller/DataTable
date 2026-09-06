local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MainPage = class("MainPage", Dialog)
MainPage.AssetBundleName = "ui/layouts.welfare"
MainPage.AssetName = "ActivityForesightMain"

function MainPage:Ctor(...)
  MainPage.super.Ctor(self, ...)
  self._todayIndex = 0
  self._totalDayNum = 0
  self._dayData = {}
  self._chatId = 0
end

function MainPage:OnCreate()
  self._titleImage = self:GetChild("BackImage/Title")
  self._backImage = self:GetChild("BackImage")
  self._timeText1 = self:GetChild("BackImage/TxtFrame1/Time")
  self._timeText2 = self:GetChild("BackImage/TxtFrame2/Time")
  self._dayPanel = self:GetChild("BackImage/Frame")
  self._dayFrame = TableFrame.Create(self._dayPanel, self, false, true)
  self._endMask = self:GetChild("BackImage/Mask")
  self._endMaskText = self:GetChild("BackImage/Mask/Text")
  LuaNotificationCenter.AddObserver(self, self.RefreshTabCell, Common.n_OnSGeneralForesightAct, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  self:SetStaticRes()
end

function MainPage:SetStaticRes()
  self._endMaskText:SetText(TextManager.GetText(CStringres:GetRecorder(1878).msgTextID))
end

function MainPage:OnDestroy()
  if self._dayFrame then
    self._dayFrame:Destroy()
  end
end

function MainPage:RefreshTabCell()
  self._dm = NekoData.DataManager.DM_Foresight
  self._bm = NekoData.BehaviorManager.BM_Foresight
  for key, _ in pairs(self._dayData) do
    self._dayData[key] = nil
  end
  if self._bm:GetIsOpen() then
    self._endMask:SetActive(false)
    local allIDs = self._bm:GetCActivityForesightMain():GetAllIds()
    local tmpDayIndex = 0
    for _, id in ipairs(allIDs) do
      local recorder = self._bm:GetCActivityForesightMain():GetRecorder(id)
      if recorder.activityId == self._bm:GetActivityId() then
        tmpDayIndex = tmpDayIndex + 1
        self._dayData[tmpDayIndex] = {
          dayIndex = tmpDayIndex,
          chatId = recorder.chatId,
          imgTitleId = recorder.imgTitleId,
          imageBack = recorder.imageBack,
          textIds = recorder.textId,
          cellTitle = recorder.cellTitle,
          itemId = recorder.itemId,
          itemNum = recorder.itemNum,
          isUnlock = tmpDayIndex <= self._bm:GetUnlockedDay(),
          isGet = self._bm:GetReceiveAward()[tmpDayIndex] == true
        }
      end
    end
    self._totalDayNum = tmpDayIndex
    self._dayData[self._totalDayNum + 1] = {
      dayIndex = self._totalDayNum,
      goodId = self._bm:GetForesightGoodInfo().goodId,
      itemId = self._bm:GetForesightGoodInfo().itemId,
      itemSum = self._bm:GetForesightGoodInfo().itemSum,
      moneyType = self._bm:GetForesightGoodInfo().moneyType,
      price = self._bm:GetForesightGoodInfo().price,
      pictureId = self._bm:GetForesightGoodInfo().pictureId,
      goodName = self._bm:GetForesightGoodInfo().goodName,
      isUnlock = self._totalDayNum == self._bm:GetUnlockedDay(),
      isGet = self._bm:GetReceiveAward()[self._totalDayNum + 1] == true
    }
    if PrintTable then
      PrintTable(self._dayData, 3, "self._dayData")
    end
    self._todayIndex = self._bm:GetUnlockedDay()
    local imageRecord = CImagePathTable:GetRecorder(self._dayData[self._todayIndex].imgTitleId) or DataCommon.DefaultImageAsset
    self._titleImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = CImagePathTable:GetRecorder(self._dayData[self._todayIndex].imageBack) or DataCommon.DefaultImageAsset
    self._backImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._timeText1:SetText(TextManager.GetText(self._dayData[self._todayIndex].textIds[1]))
    self._timeText2:SetText(TextManager.GetText(self._dayData[self._todayIndex].textIds[2], self._bm:GetRemainTimeStr(self._bm:GetActLeftTime())))
  else
    self._endMask:SetActive(true)
  end
  local lastPos = self._dayFrame:GetCurrentPosition()
  self._dayFrame:ReloadAllCell()
  if lastPos then
    self._dayFrame:MoveToAssignedPos(lastPos)
  else
    self._dayFrame:MoveToTop()
  end
end

function MainPage:NumberOfCell(frame)
  return #self._dayData
end

function MainPage:CellAtIndex(frame, index)
  if index == self._totalDayNum + 1 then
    return "welfare.foresight.extracell"
  else
    return "welfare.foresight.commoncell"
  end
end

function MainPage:DataAtIndex(frame, index)
  return self._dayData[index]
end

function MainPage:OnSingletonDialogDestroy(notification)
  local needDialogsToNext = {
    "bag.itemaccountdialog",
    "gacha.gacharesultdialog",
    "shop.fashionbuyresultdialog"
  }
  if table.contain(needDialogsToNext, notification.userInfo._dialogName) and self._chatId and self._chatId > 0 then
    local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
    if dialog then
      dialog:SetDialogLibraryId(self._chatId, false, dialog.DialogType.Foresight)
      self._chatId = 0
    end
  end
end

return MainPage
