-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/mazepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MazeBlockHelper = require("logic.dialog.activity.giftoftime.mazeblockhelper")
local MazePage = class("MazePage", Dialog)
MazePage.AssetBundleName = "ui/layouts.battlepassnew"
MazePage.AssetName = "BattlePassNewMaze"
local cardStepTime = 0.75
if ((((CImagePathTable:GetRecorder(14726) or not CImagePathTable:GetRecorder(14727)) and CImagePathTable:GetRecorder(14728)) or not CImagePathTable:GetRecorder(14729)) and CImagePathTable:GetRecorder(14730)) or not CImagePathTable:GetRecorder(14731) then
  local imgTextHelper = {[1] = DataCommon.DefaultImageAsset, [2] = DataCommon.DefaultImageAsset, [3] = DataCommon.DefaultImageAsset, [4] = DataCommon.DefaultImageAsset, [5] = DataCommon.DefaultImageAsset, [6] = DataCommon.DefaultImageAsset}
  MazePage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MazePage
  ((MazePage.super).Ctor)(self, ...)
  self._selectCardIndex = 0
  self._blockData = {}
end

  MazePage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, AnimatorStaticFunctions, MazeBlockHelper
  self._endTime = self:GetChild("EndTime")
  self._dailyTaskBtn = self:GetChild("DailyTask")
  ;
  (self._dailyTaskBtn):Subscribe_PointerClickEvent(self.OnDailyBtnClicked, self)
  self._dailyTaskBtnTxt = self:GetChild("DailyTask/Text")
  self._dailyTaskBtnReddot = self:GetChild("DailyTask/Dot")
  self._tipBtn = self:GetChild("Tip")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._currency1Cell = self:GetChild("MoneyCell")
  ;
  (self._currency1Cell):Subscribe_PointerClickEvent(self.OnCurrency1IconClicked, self)
  self._currency1Icon = self:GetChild("MoneyCell/Icon")
  self._currency1Num1 = self:GetChild("MoneyCell/Num1")
  self._currency1Num2 = self:GetChild("MoneyCell/Num2")
  self._currency2Icon = self:GetChild("GoFrame/Count/Icon")
  ;
  (self._currency2Icon):Subscribe_PointerClickEvent(self.OnCurrency2IconClicked, self)
  self._currency2Num = self:GetChild("GoFrame/Count/Num")
  self._centerTxt = self:GetChild("FrameOn/Txt")
  self._centerItem1Frame = self:GetChild("FrameOn/ItemCell01/_BackGround/Frame")
  self._centerItem1Icon = self:GetChild("FrameOn/ItemCell01/_BackGround/Icon")
  ;
  (self._centerItem1Icon):Subscribe_PointerClickEvent(self.OnCenterItem1Clicked, self)
  self._centerItem1Count = self:GetChild("FrameOn/ItemCell01/_Count")
  self._centerItem2Frame = self:GetChild("FrameOn/ItemCell02/_BackGround/Frame")
  self._centerItem2Icon = self:GetChild("FrameOn/ItemCell02/_BackGround/Icon")
  ;
  (self._centerItem2Icon):Subscribe_PointerClickEvent(self.OnCenterItem2Clicked, self)
  self._centerItem2Count = self:GetChild("FrameOn/ItemCell02/_Count")
  self._goBtn = self:GetChild("GoFrame/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._goBtnText = self:GetChild("GoFrame/GoBtn/_Text")
  self._goBtnMask = self:GetChild("GoFrame/GoBtnClick")
  ;
  (self._goBtnMask):Subscribe_PointerClickEvent(self.OnGoBtnMaskClicked, self)
  self._desText = self:GetChild("GoFrame/Text")
  self._card = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC136: Confused about usage of register: R5 in 'UnsetPending'

      (self._card)[i] = {}
      -- DECOMPILER ERROR at PC146: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._card)[i]).root = self:GetChild("GoFrame/NumImg0" .. tostring(i))
      ;
      (((self._card)[i]).root):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCardClicked(i)
  end
, self)
      -- DECOMPILER ERROR at PC164: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._card)[i]).txt = self:GetChild("GoFrame/NumImg0" .. tostring(i) .. "/Txt")
      -- DECOMPILER ERROR at PC175: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._card)[i]).txtImg = self:GetChild("GoFrame/NumImg0" .. tostring(i) .. "/TxtImg")
      -- DECOMPILER ERROR at PC186: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._card)[i]).select = self:GetChild("GoFrame/NumImg0" .. tostring(i) .. "/Select")
      -- DECOMPILER ERROR at PC196: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._card)[i]).animator = (AnimatorStaticFunctions.Get)((((self._card)[i]).root):GetUIObject())
    end
  end
  self._block = {}
  for i = 1, 18 do
    -- DECOMPILER ERROR at PC207: Confused about usage of register: R5 in 'UnsetPending'

    (self._block)[i] = {}
    local tmpElement = self:GetChild("Frame/BattlePassNewMazeItemCell" .. tostring(i))
    -- DECOMPILER ERROR at PC217: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._block)[i]).root = tmpElement
    -- DECOMPILER ERROR at PC224: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._block)[i]).helper = (MazeBlockHelper.Create)(tmpElement, i)
  end
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self:SetStaticRes()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_NewDreamSpiralRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshGoBtnState, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskReddot, Common.n_NewDreamSpiralTaskRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshBlockData, Common.n_OnSOpenLabyrinth, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCardData, Common.n_OnSOpenLabyrinth, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSRefreshMazeBlock, Common.n_OnSRefreshMazeBlock, nil)
end

  MazePage.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, Item
  (self._dailyTaskBtnTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1948))
  ;
  (self._centerTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1977))
  ;
  (self._desText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2038))
  self._haveCurrencyNum1Item = (Item.Create)(DataCommon.TimeCrystal)
  local imageRecord = (self._haveCurrencyNum1Item):GetIcon()
  ;
  (self._currency1Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._haveCurrencyNum2Item = (Item.Create)(DataCommon.TimeDice)
  imageRecord = (self._haveCurrencyNum2Item):GetIcon()
  ;
  (self._currency2Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._centerItem1 = (Item.Create)((((self._bm):GetCBPLabyrinthStartRewardCfg()).itemID)[1])
  imageRecord = (self._centerItem1):GetIcon()
  ;
  (self._centerItem1Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._centerItem1):GetPinJiImage()
  ;
  (self._centerItem1Frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._centerItem1Count):SetText((((self._bm):GetCBPLabyrinthStartRewardCfg()).itemNum)[1])
  self._centerItem2 = (Item.Create)((((self._bm):GetCBPLabyrinthStartRewardCfg()).itemID)[2])
  imageRecord = (self._centerItem2):GetIcon()
  ;
  (self._centerItem2Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._centerItem2):GetPinJiImage()
  ;
  (self._centerItem2Frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._centerItem2Count):SetText((((self._bm):GetCBPLabyrinthStartRewardCfg()).itemNum)[2])
end

  MazePage.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._timeTimer then
    (ServerGameTimer.RemoveTask)(self._timeTimer)
    self._timeTimer = nil
  end
  if self._cardTimer then
    (GameTimer.RemoveTask)(self._cardTimer)
    self._cardTimer = nil
  end
  self._rewardData = nil
end

  MazePage.RefreshData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:RefreshBlockData()
  self:RefreshCardData()
  self:RefreshCurrencyData()
  self:RefreshTaskReddot()
  self:RefreshGoBtnState()
  if self._timeTimer then
    (ServerGameTimer.RemoveTask)(self._timeTimer)
    self._timeTimer = nil
  end
  self._timeTimer = (ServerGameTimer.AddTask)(0, 60, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshEndTimeText()
  end
)
end

  MazePage.RefreshBlockData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._cardTimer then
    (GameTimer.RemoveTask)(self._cardTimer)
    self._cardTimer = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  if self._rewardData then
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = self._rewardData})
  end
  self._rewardData = nil
  self._currentPos = (self._bm):GetCurrentPos()
  for key,_ in pairs(self._blockData) do
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

    (self._blockData)[key] = nil
  end
  for i = 1, 18 do
    if ((self._bm):GetBlocks())[i] == nil then
      LogError("MazePage:RefreshBlockData", tostring(i) .. " not exist!")
      break
    end
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._blockData)[i] = {serverData = ((self._bm):GetBlocks())[i], hilight = false, player = i == self._currentPos}
    ;
    (((self._block)[i]).helper):RefreshCell((self._blockData)[i])
  end
  self:OnCardClicked(0)
  self:RefreshCardData()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

  MazePage.RefreshCardData = function(self)
  -- function num : 0_6 , upvalues : imgTextHelper
  for i = 1, 3 do
    (((self._card)[i]).txt):SetText(((self._bm):GetCards())[i])
    local imageRecord = imgTextHelper[((self._bm):GetCards())[i]]
    ;
    (((self._card)[i]).txtImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

  MazePage.RefreshCurrencyData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._haveCurrencyNum1 = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.TimeCrystal)
  local info = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetBaseInfo()
  local chipInfo = info.chipInfo
  if chipInfo then
    (self._currency1Cell):SetActive(true)
    ;
    (self._currency1Num1):SetText(tostring(chipInfo.has))
    ;
    (self._currency1Num2):SetText(tostring(chipInfo.max))
  else
    ;
    (self._currency1Cell):SetActive(false)
    LogError("PuzzlePage:RefreshCurrencyData", "nil chipinfo")
  end
  self._haveCurrencyNum2 = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.TimeDice)
  if self._haveCurrencyNum2 > 0 then
    (self._currency2Num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1979, {(NumberManager.GetShowNumber)(self._haveCurrencyNum2)}))
  else
    ;
    (self._currency2Num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1980))
  end
end

  MazePage.RefreshTaskReddot = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetIsOpen() then
    (self._dailyTaskBtnReddot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):HasTasksAward())
  end
end

  MazePage.RefreshEndTimeText = function(self)
  -- function num : 0_9
  (self._endTime):SetText((self._bm):GetRemainTimeStr((self._bm):GetRemainTime()))
end

  MazePage.RefreshGoBtnState = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local currencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.TimeDice)
  local canClick = currencyNum > 0 and self._selectCardIndex > 0
  ;
  (self._goBtn):SetInteractable(canClick)
  ;
  (self._goBtnMask):SetActive(not canClick)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

  MazePage.HilightBlocks = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local tmpIndex = ((self._bm):GetCards())[self._selectCardIndex]
  for index,_ in ipairs(self._blockData) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._blockData)[index]).hilight = tmpIndex ~= nil and self._currentPos <= index and index <= self._currentPos + tmpIndex
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  if tmpIndex and self._currentPos + tmpIndex > 18 then
    ((self._blockData)[1]).hilight = true
  end
  for index,_ in ipairs(self._blockData) do
    (((self._block)[index]).helper):RefreshCell((self._blockData)[index])
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

  MazePage.OnSRefreshMazeBlock = function(self, notification)
  -- function num : 0_12 , upvalues : _ENV, cardStepTime
  local protocol = notification.userInfo
  if self._cardTimer then
    (GameTimer.RemoveTask)(self._cardTimer)
    self._cardTimer = nil
  end
  local rewardData = {items = protocol.itemInfo}
  if not rewardData.items or #rewardData.items <= 0 then
    self:RefreshBlockData()
    ;
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  else
    self._rewardData = rewardData
    ;
    (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
    self._cardTimer = (GameTimer.AddTask)(0, cardStepTime, function()
    -- function num : 0_12_0 , upvalues : _ENV, self
    if PrintTable then
      LogError("self._currentPos ", tostring(self._currentPos))
    end
    if self._currentPos == (self._bm):GetCurrentPos() then
      if self._cardTimer then
        (GameTimer.RemoveTask)(self._cardTimer)
        self._cardTimer = nil
      end
      self:RefreshBlockData()
      ;
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    else
      self._currentPos = (math.fmod)(self._currentPos, 18) + 1
      for index,_ in ipairs(self._blockData) do
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

        ((self._blockData)[index]).player = index == self._currentPos
        ;
        (((self._block)[index]).helper):RefreshCell((self._blockData)[index], true)
      end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
)
  end
end

  MazePage.OnGoBtnClicked = function(self)
  -- function num : 0_13
  if self._selectCardIndex > 0 then
    (self._bm):SendCChooseMazeCard(((self._bm):GetCards())[self._selectCardIndex])
  end
end

  MazePage.OnGoBtnMaskClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.TimeDice) > 0 then
    for i = 1, 3 do
      (((self._card)[i]).animator):SetTrigger("blink")
    end
  end
end

  MazePage.OnCardClicked = function(self, cardIndex)
  -- function num : 0_15
  self._selectCardIndex = cardIndex
  for i = 1, 3 do
    if cardIndex == i then
      (((self._card)[i]).animator):SetTrigger("show")
    else
      ;
      (((self._card)[i]).animator):SetTrigger("hide")
    end
  end
  self:HilightBlocks()
  self:RefreshGoBtnState()
end

  MazePage.OnDailyBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.giftoftime.killbosstaskdialog")):Init()
end

  MazePage.OnTipBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(3)
end

  MazePage.OnCurrency1IconClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local width, height = (self._currency1Cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._haveCurrencyNum1Item})
    tipsDialog:SetTipsPosition(width, height, (self._currency1Cell):GetLocalPointInUiRootPanel())
  end
end

  MazePage.OnCurrency2IconClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local width, height = (self._currency2Icon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._haveCurrencyNum2Item})
    tipsDialog:SetTipsPosition(width, height, (self._currency2Icon):GetLocalPointInUiRootPanel())
  end
end

  MazePage.OnCenterItem1Clicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local width, height = (self._centerItem1Icon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._centerItem1})
    tipsDialog:SetTipsPosition(width, height, (self._centerItem1Icon):GetLocalPointInUiRootPanel())
  end
end

  MazePage.OnCenterItem2Clicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local width, height = (self._centerItem2Icon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._centerItem2})
    tipsDialog:SetTipsPosition(width, height, (self._centerItem2Icon):GetLocalPointInUiRootPanel())
  end
end

  return MazePage
end

