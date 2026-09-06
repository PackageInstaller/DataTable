local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MazeBlockHelper = require("logic.dialog.activity.giftoftime.mazeblockhelper")
local MazePage = class("MazePage", Dialog)
MazePage.AssetBundleName = "ui/layouts.battlepassnew"
MazePage.AssetName = "BattlePassNewMaze"
local cardStepTime = 0.75
local imgTextHelper = {
  [1] = CImagePathTable:GetRecorder(14726) or DataCommon.DefaultImageAsset,
  [2] = CImagePathTable:GetRecorder(14727) or DataCommon.DefaultImageAsset,
  [3] = CImagePathTable:GetRecorder(14728) or DataCommon.DefaultImageAsset,
  [4] = CImagePathTable:GetRecorder(14729) or DataCommon.DefaultImageAsset,
  [5] = CImagePathTable:GetRecorder(14730) or DataCommon.DefaultImageAsset,
  [6] = CImagePathTable:GetRecorder(14731) or DataCommon.DefaultImageAsset
}

function MazePage:Ctor(...)
  MazePage.super.Ctor(self, ...)
  self._selectCardIndex = 0
  self._blockData = {}
end

function MazePage:OnCreate()
  self._endTime = self:GetChild("EndTime")
  self._dailyTaskBtn = self:GetChild("DailyTask")
  self._dailyTaskBtn:Subscribe_PointerClickEvent(self.OnDailyBtnClicked, self)
  self._dailyTaskBtnTxt = self:GetChild("DailyTask/Text")
  self._dailyTaskBtnReddot = self:GetChild("DailyTask/Dot")
  self._tipBtn = self:GetChild("Tip")
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._currency1Cell = self:GetChild("MoneyCell")
  self._currency1Cell:Subscribe_PointerClickEvent(self.OnCurrency1IconClicked, self)
  self._currency1Icon = self:GetChild("MoneyCell/Icon")
  self._currency1Num1 = self:GetChild("MoneyCell/Num1")
  self._currency1Num2 = self:GetChild("MoneyCell/Num2")
  self._currency2Icon = self:GetChild("GoFrame/Count/Icon")
  self._currency2Icon:Subscribe_PointerClickEvent(self.OnCurrency2IconClicked, self)
  self._currency2Num = self:GetChild("GoFrame/Count/Num")
  self._centerTxt = self:GetChild("FrameOn/Txt")
  self._centerItem1Frame = self:GetChild("FrameOn/ItemCell01/_BackGround/Frame")
  self._centerItem1Icon = self:GetChild("FrameOn/ItemCell01/_BackGround/Icon")
  self._centerItem1Icon:Subscribe_PointerClickEvent(self.OnCenterItem1Clicked, self)
  self._centerItem1Count = self:GetChild("FrameOn/ItemCell01/_Count")
  self._centerItem2Frame = self:GetChild("FrameOn/ItemCell02/_BackGround/Frame")
  self._centerItem2Icon = self:GetChild("FrameOn/ItemCell02/_BackGround/Icon")
  self._centerItem2Icon:Subscribe_PointerClickEvent(self.OnCenterItem2Clicked, self)
  self._centerItem2Count = self:GetChild("FrameOn/ItemCell02/_Count")
  self._goBtn = self:GetChild("GoFrame/GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._goBtnText = self:GetChild("GoFrame/GoBtn/_Text")
  self._goBtnMask = self:GetChild("GoFrame/GoBtnClick")
  self._goBtnMask:Subscribe_PointerClickEvent(self.OnGoBtnMaskClicked, self)
  self._desText = self:GetChild("GoFrame/Text")
  self._card = {}
  for i = 1, 3 do
    self._card[i] = {}
    self._card[i].root = self:GetChild("GoFrame/NumImg0" .. tostring(i))
    self._card[i].root:Subscribe_PointerClickEvent(function()
      self:OnCardClicked(i)
    end, self)
    self._card[i].txt = self:GetChild("GoFrame/NumImg0" .. tostring(i) .. "/Txt")
    self._card[i].txtImg = self:GetChild("GoFrame/NumImg0" .. tostring(i) .. "/TxtImg")
    self._card[i].select = self:GetChild("GoFrame/NumImg0" .. tostring(i) .. "/Select")
    self._card[i].animator = AnimatorStaticFunctions.Get(self._card[i].root:GetUIObject())
  end
  self._block = {}
  for i = 1, 18 do
    self._block[i] = {}
    local tmpElement = self:GetChild("Frame/BattlePassNewMazeItemCell" .. tostring(i))
    self._block[i].root = tmpElement
    self._block[i].helper = MazeBlockHelper.Create(tmpElement, i)
  end
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self:SetStaticRes()
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_NewDreamSpiralRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshGoBtnState, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskReddot, Common.n_NewDreamSpiralTaskRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshBlockData, Common.n_OnSOpenLabyrinth, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCardData, Common.n_OnSOpenLabyrinth, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSRefreshMazeBlock, Common.n_OnSRefreshMazeBlock, nil)
end

function MazePage:SetStaticRes()
  self._dailyTaskBtnTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1948))
  self._centerTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1977))
  self._desText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2038))
  self._haveCurrencyNum1Item = Item.Create(DataCommon.TimeCrystal)
  local imageRecord = self._haveCurrencyNum1Item:GetIcon()
  self._currency1Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._haveCurrencyNum2Item = Item.Create(DataCommon.TimeDice)
  imageRecord = self._haveCurrencyNum2Item:GetIcon()
  self._currency2Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._centerItem1 = Item.Create(self._bm:GetCBPLabyrinthStartRewardCfg().itemID[1])
  imageRecord = self._centerItem1:GetIcon()
  self._centerItem1Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._centerItem1:GetPinJiImage()
  self._centerItem1Frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._centerItem1Count:SetText(self._bm:GetCBPLabyrinthStartRewardCfg().itemNum[1])
  self._centerItem2 = Item.Create(self._bm:GetCBPLabyrinthStartRewardCfg().itemID[2])
  imageRecord = self._centerItem2:GetIcon()
  self._centerItem2Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._centerItem2:GetPinJiImage()
  self._centerItem2Frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._centerItem2Count:SetText(self._bm:GetCBPLabyrinthStartRewardCfg().itemNum[2])
end

function MazePage:OnDestroy()
  if self._timeTimer then
    ServerGameTimer.RemoveTask(self._timeTimer)
    self._timeTimer = nil
  end
  if self._cardTimer then
    GameTimer.RemoveTask(self._cardTimer)
    self._cardTimer = nil
  end
  self._rewardData = nil
end

function MazePage:RefreshData()
  self:RefreshBlockData()
  self:RefreshCardData()
  self:RefreshCurrencyData()
  self:RefreshTaskReddot()
  self:RefreshGoBtnState()
  if self._timeTimer then
    ServerGameTimer.RemoveTask(self._timeTimer)
    self._timeTimer = nil
  end
  self._timeTimer = ServerGameTimer.AddTask(0, 60, function()
    self:RefreshEndTimeText()
  end)
end

function MazePage:RefreshBlockData()
  if self._cardTimer then
    GameTimer.RemoveTask(self._cardTimer)
    self._cardTimer = nil
  end
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  if self._rewardData then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = self._rewardData
    })
  end
  self._rewardData = nil
  self._currentPos = self._bm:GetCurrentPos()
  for key, _ in pairs(self._blockData) do
    self._blockData[key] = nil
  end
  for i = 1, 18 do
    if self._bm:GetBlocks()[i] == nil then
      LogError("MazePage:RefreshBlockData", tostring(i) .. " not exist!")
      break
    end
    self._blockData[i] = {
      serverData = self._bm:GetBlocks()[i],
      hilight = false,
      player = i == self._currentPos
    }
    self._block[i].helper:RefreshCell(self._blockData[i])
  end
  self:OnCardClicked(0)
  self:RefreshCardData()
end

function MazePage:RefreshCardData()
  for i = 1, 3 do
    self._card[i].txt:SetText(self._bm:GetCards()[i])
    local imageRecord = imgTextHelper[self._bm:GetCards()[i]]
    self._card[i].txtImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function MazePage:RefreshCurrencyData()
  self._haveCurrencyNum1 = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.TimeCrystal)
  local info = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetBaseInfo()
  local chipInfo = info.chipInfo
  if chipInfo then
    self._currency1Cell:SetActive(true)
    self._currency1Num1:SetText(tostring(chipInfo.has))
    self._currency1Num2:SetText(tostring(chipInfo.max))
  else
    self._currency1Cell:SetActive(false)
    LogError("PuzzlePage:RefreshCurrencyData", "nil chipinfo")
  end
  self._haveCurrencyNum2 = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.TimeDice)
  if self._haveCurrencyNum2 > 0 then
    self._currency2Num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1979, {
      NumberManager.GetShowNumber(self._haveCurrencyNum2)
    }))
  else
    self._currency2Num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1980))
  end
end

function MazePage:RefreshTaskReddot()
  self._dailyTaskBtnReddot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetIsOpen() and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):HasTasksAward())
end

function MazePage:RefreshEndTimeText()
  self._endTime:SetText(self._bm:GetRemainTimeStr(self._bm:GetRemainTime()))
end

function MazePage:RefreshGoBtnState()
  local currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.TimeDice)
  local canClick = 0 < currencyNum and 0 < self._selectCardIndex
  self._goBtn:SetInteractable(canClick)
  self._goBtnMask:SetActive(not canClick)
end

function MazePage:HilightBlocks()
  local tmpIndex = self._bm:GetCards()[self._selectCardIndex]
  for index, _ in ipairs(self._blockData) do
    self._blockData[index].hilight = tmpIndex ~= nil and index >= self._currentPos and index <= self._currentPos + tmpIndex
  end
  if tmpIndex and self._currentPos + tmpIndex > 18 then
    self._blockData[1].hilight = true
  end
  for index, _ in ipairs(self._blockData) do
    self._block[index].helper:RefreshCell(self._blockData[index])
  end
end

function MazePage:OnSRefreshMazeBlock(notification)
  local protocol = notification.userInfo
  if self._cardTimer then
    GameTimer.RemoveTask(self._cardTimer)
    self._cardTimer = nil
  end
  local rewardData = {
    items = protocol.itemInfo
  }
  if not rewardData.items or #rewardData.items <= 0 then
    self:RefreshBlockData()
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  else
    self._rewardData = rewardData
    DialogManager.CreateSingletonDialog("guide.blockclickdialog")
    self._cardTimer = GameTimer.AddTask(0, cardStepTime, function()
      if PrintTable then
        LogError("self._currentPos ", tostring(self._currentPos))
      end
      if self._currentPos == self._bm:GetCurrentPos() then
        if self._cardTimer then
          GameTimer.RemoveTask(self._cardTimer)
          self._cardTimer = nil
        end
        self:RefreshBlockData()
        DialogManager.DestroySingletonDialog("guide.blockclickdialog")
      else
        self._currentPos = math.fmod(self._currentPos, 18) + 1
        for index, _ in ipairs(self._blockData) do
          self._blockData[index].player = index == self._currentPos
          self._block[index].helper:RefreshCell(self._blockData[index], true)
        end
      end
    end)
  end
end

function MazePage:OnGoBtnClicked()
  if self._selectCardIndex > 0 then
    self._bm:SendCChooseMazeCard(self._bm:GetCards()[self._selectCardIndex])
  end
end

function MazePage:OnGoBtnMaskClicked()
  if NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.TimeDice) > 0 then
    for i = 1, 3 do
      self._card[i].animator:SetTrigger("blink")
    end
  end
end

function MazePage:OnCardClicked(cardIndex)
  self._selectCardIndex = cardIndex
  for i = 1, 3 do
    if cardIndex == i then
      self._card[i].animator:SetTrigger("show")
    else
      self._card[i].animator:SetTrigger("hide")
    end
  end
  self:HilightBlocks()
  self:RefreshGoBtnState()
end

function MazePage:OnDailyBtnClicked()
  DialogManager.CreateSingletonDialog("activity.giftoftime.killbosstaskdialog"):Init()
end

function MazePage:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(3)
end

function MazePage:OnCurrency1IconClicked()
  local width, height = self._currency1Cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._haveCurrencyNum1Item
    })
    tipsDialog:SetTipsPosition(width, height, self._currency1Cell:GetLocalPointInUiRootPanel())
  end
end

function MazePage:OnCurrency2IconClicked()
  local width, height = self._currency2Icon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._haveCurrencyNum2Item
    })
    tipsDialog:SetTipsPosition(width, height, self._currency2Icon:GetLocalPointInUiRootPanel())
  end
end

function MazePage:OnCenterItem1Clicked()
  local width, height = self._centerItem1Icon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._centerItem1
    })
    tipsDialog:SetTipsPosition(width, height, self._centerItem1Icon:GetLocalPointInUiRootPanel())
  end
end

function MazePage:OnCenterItem2Clicked()
  local width, height = self._centerItem2Icon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._centerItem2
    })
    tipsDialog:SetTipsPosition(width, height, self._centerItem2Icon:GetLocalPointInUiRootPanel())
  end
end

return MazePage
