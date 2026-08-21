-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/puzzlepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local PullzeFragHelper = require("logic.dialog.activity.giftoftime.pullzefraghelper")
local PuzzleRewardHelper = require("logic.dialog.activity.giftoftime.puzzlerewardhelper")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local PuzzlePage = class("PuzzlePage", Dialog)
PuzzlePage.AssetBundleName = "ui/layouts.battlepassnew"
PuzzlePage.AssetName = "BattlePassNewPuzzle"
PuzzlePage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PuzzlePage
  ((PuzzlePage.super).Ctor)(self, ...)
  self._puzzleData = {}
  self._rewardData = {}
end

PuzzlePage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, PullzeFragHelper, PuzzleRewardHelper
  self._ruleTxt = self:GetChild("RuleTxt")
  self._endTime = self:GetChild("EndTime")
  self._currency2Txt = self:GetChild("Count/Txt")
  self._dailyTaskBtnTxt = self:GetChild("DailyTask/Text")
  self._dailyTaskBtnReddot = self:GetChild("DailyTask/Dot")
  self._tipBtn = self:GetChild("Tip")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._currency1Icon = self:GetChild("MoneyCell/Icon")
  self._currency1Num1 = self:GetChild("MoneyCell/Num1")
  self._currency1Num2 = self:GetChild("MoneyCell/Num2")
  self._currency1Cell = self:GetChild("MoneyCell")
  ;
  (self._currency1Cell):Subscribe_PointerClickEvent(self.OnCurrency1IconClicked, self)
  self._currency2Icon = self:GetChild("Count/Icon")
  self._currency2Num = self:GetChild("Count/Num")
  ;
  (self._currency2Icon):Subscribe_PointerClickEvent(self.OnCurrency2IconClicked, self)
  self._dailyTaskBtn = self:GetChild("DailyTask")
  ;
  (self._dailyTaskBtn):Subscribe_PointerClickEvent(self.OnDailyBtnClicked, self)
  self._puzzleImg = self:GetChild("Frame/PuzzleArea/PuzzleImg")
  local tmpIndexUIHelper = {[1] = 1, [2] = 5, [3] = 9, [4] = 13, [5] = 2, [6] = 6, [7] = 10, [8] = 14, [9] = 3, [10] = 7, [11] = 11, [12] = 15, [13] = 4, [14] = 8, [15] = 12, [16] = 16}
  self._puzzleList = {}
  for i = 1, 16 do
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R6 in 'UnsetPending'

    (self._puzzleList)[i] = {}
    local tmpElement = self:GetChild("Frame/PuzzleArea/PuzzleLock/Puzzle" .. tostring(tmpIndexUIHelper[i]))
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._puzzleList)[i]).root = tmpElement
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._puzzleList)[i]).helper = (PullzeFragHelper.Create)(tmpElement, i)
  end
  self._rewardList = {}
  for i = 1, 9 do
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R6 in 'UnsetPending'

    (self._rewardList)[i] = {}
    local tmpElement = self:GetChild("Frame/BattlePassNewPuzzleItemCell" .. tostring(i))
    -- DECOMPILER ERROR at PC138: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._rewardList)[i]).root = tmpElement
    -- DECOMPILER ERROR at PC145: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._rewardList)[i]).helper = (PuzzleRewardHelper.Create)(tmpElement, i)
  end
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self:SetStaticRes()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_NewDreamSpiralRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMainData, Common.n_OnSOpenBpPuzzle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMainData, Common.n_OnSUnlockBpPuzzle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMainData, Common.n_OnSReceivedBpAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskReddot, Common.n_NewDreamSpiralTaskRefresh, nil)
end

PuzzlePage.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._ruleTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1957))
  ;
  (self._dailyTaskBtnTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1948))
end

PuzzlePage.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._timeTimer then
    (ServerGameTimer.RemoveTask)(self._timeTimer)
    self._timeTimer = nil
  end
end

PuzzlePage.RefreshData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:RefreshMainData()
  self:RefreshCurrencyData()
  self:RefreshTaskReddot()
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

PuzzlePage.RefreshMainData = function(self)
  -- function num : 0_5 , upvalues : _ENV, CImagePathTable
  self._rewardGroupID = (self._bm):GetRrewardGroupID()
  local jigSawRecord = ((self._bm):GetCBPJigsawCfg()):GetRecorder(self._rewardGroupID)
  local jigSawRewaredRecord = ((self._bm):GetCBPJigsawRewardCfg()):GetRecorder(self._rewardGroupID)
  if jigSawRecord == nil or jigSawRewaredRecord == nil then
    LogError("PuzzlePage:RefreshMainData", "self._rewardGroupID: " .. tostring(self._rewardGroupID))
    return 
  end
  if not CImagePathTable:GetRecorder(jigSawRecord.jigsawRes) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._puzzleImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  for key,_ in pairs(self._puzzleData) do
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

    (self._puzzleData)[key] = nil
  end
  for key,_ in pairs(self._rewardData) do
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R9 in 'UnsetPending'

    (self._rewardData)[key] = nil
  end
  for index,value in ipairs(jigSawRecord.moneyNum) do
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R9 in 'UnsetPending'

    (self._puzzleData)[index] = {moneyNum = value, isOpen = ((self._bm):GetUnlockedPuzzle())[index]}
  end
  for index,value in ipairs(jigSawRewaredRecord.itemID) do
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R9 in 'UnsetPending'

    (self._rewardData)[index] = {itemID = value, itemNum = (jigSawRewaredRecord.itemNum)[index], status = ((self._bm):GetAwardStatus())[index]}
  end
  for index,value in ipairs(self._puzzleList) do
    (value.helper):RefreshCell((self._puzzleData)[index])
  end
  for index,value in ipairs(self._rewardList) do
    (value.helper):RefreshCell((self._rewardData)[index])
  end
end

PuzzlePage.RefreshCurrencyData = function(self)
  -- function num : 0_6 , upvalues : _ENV, Item
  self._haveCurrencyNum1 = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.TimeCrystal)
  self._haveCurrencyNum1Item = (Item.Create)(DataCommon.TimeCrystal)
  local imageRecord = (self._haveCurrencyNum1Item):GetIcon()
  ;
  (self._currency1Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local info = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetBaseInfo()
  local chipInfo = info.chipInfo
  if chipInfo then
    (self._currency1Num1):SetText(tostring(chipInfo.has))
    ;
    (self._currency1Num2):SetText(tostring(chipInfo.max))
  else
    ;
    (self._currency1Cell):SetActive(false)
    LogError("PuzzlePage:RefreshCurrencyData", "nil chipinfo")
  end
  self._haveCurrencyNum2 = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.WitchSeal)
  self._haveCurrencyNum2Item = (Item.Create)(DataCommon.WitchSeal)
  imageRecord = (self._haveCurrencyNum2Item):GetIcon()
  ;
  (self._currency2Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._currency2Num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1960, {(NumberManager.GetShowNumber)(self._haveCurrencyNum2)}))
end

PuzzlePage.RefreshTaskReddot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetIsOpen() then
    (self._dailyTaskBtnReddot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):HasTasksAward())
  end
end

PuzzlePage.RefreshEndTimeText = function(self)
  -- function num : 0_8
  (self._endTime):SetText((self._bm):GetRemainTimeStr((self._bm):GetRemainTime()))
end

PuzzlePage.OnTipBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(3)
end

PuzzlePage.OnDailyBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.giftoftime.killbosstaskdialog")):Init()
end

PuzzlePage.OnCurrency1IconClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local width, height = (self._currency1Cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._haveCurrencyNum1Item})
    tipsDialog:SetTipsPosition(width, height, (self._currency1Cell):GetLocalPointInUiRootPanel())
  end
end

PuzzlePage.OnCurrency2IconClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local width, height = (self._currency2Icon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._haveCurrencyNum2Item})
    tipsDialog:SetTipsPosition(width, height, (self._currency2Icon):GetLocalPointInUiRootPanel())
  end
end

return PuzzlePage

