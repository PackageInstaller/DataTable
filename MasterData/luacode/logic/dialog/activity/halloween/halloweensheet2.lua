-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/halloween/halloweensheet2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ColumnNum = 7
local HalloweenSheet2 = class("HalloweenSheet2", Dialog)
HalloweenSheet2.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenSheet2.AssetName = "ActivityHalloweenTicket"
HalloweenSheet2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HalloweenSheet2
  ((HalloweenSheet2.super).Ctor)(self, ...)
  self._rewardData = {}
end

HalloweenSheet2.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnNum, _ENV
  self._poolName = self:GetChild("PoolName")
  self._poolTxt = self:GetChild("PoolTxt")
  self._staticTxt1 = self:GetChild("Text")
  self._activeTime = self:GetChild("ActiveTime")
  self._currencyIcon = self:GetChild("Item")
  self._num1 = self:GetChild("Txt/Num1")
  self._num2 = self:GetChild("Txt/Num2")
  self._panel = self:GetChild("FrameTask")
  self._currencyNum = self:GetChild("NowNum")
  self._confirmBtn = self:GetChild("Btn3")
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (self._currencyIcon):Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._frame = (GridFrame.Create)(self._panel, self, true, ColumnNum, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardData, Common.n_OnSOpenHalloweenInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRewardData, Common.n_OnSRefreshHalloweenInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
  self:SetData()
end

HalloweenSheet2.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, Item
  (self._poolName):SetText((TextManager.GetText)((CStringRes:GetRecorder(1634)).msgTextID))
  ;
  (self._poolTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1635)).msgTextID))
  ;
  (self._staticTxt1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1632)).msgTextID))
  ;
  (self._activeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1627)).msgTextID))
  self._currencyItem = (Item.Create)(DataCommon.PumpkinPie)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

HalloweenSheet2.OnDestroy = function(self)
  -- function num : 0_3
  if self._frame then
    (self._frame):Destroy()
  end
end

HalloweenSheet2.SetData = function(self, data)
  -- function num : 0_4
  self:RefreshCurrencyData()
  self:RefreshRewardData()
end

HalloweenSheet2.RefreshCurrencyData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local havePumpkinPieNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.PumpkinPie)
  ;
  (self._currencyNum):SetText((NumberManager.GetShowNumber)(havePumpkinPieNum))
end

HalloweenSheet2.RefreshRewardData = function(self)
  -- function num : 0_6 , upvalues : _ENV, Item
  for key,_ in pairs(self._rewardData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._rewardData)[key] = nil
  end
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)
  local allRewards, allRewardsOnceNum, allRewardsTotalNum = bm:GetPumpkinPieReward()
  if allRewards then
    for itemID,itemNum in pairs(allRewards) do
      local item = (Item.Create)(itemID)
      ;
      (table.insert)(self._rewardData, {item = item, itemNum = allRewardsOnceNum[itemID], itemNowNum = itemNum, itemTotalNum = allRewardsTotalNum[itemID]})
    end
    ;
    (table.sort)(self._rewardData, function(itemA, itemB)
    -- function num : 0_6_0 , upvalues : bm, _ENV
    local sortIdA1 = bm:GetPumpkinPieRewardSort((itemA.item):GetID())
    local sortIdB1 = bm:GetPumpkinPieRewardSort((itemB.item):GetID())
    if sortIdA1 == nil then
      sortIdA1 = math.maxinteger
    end
    if sortIdB1 == nil then
      sortIdB1 = math.maxinteger
    end
    do return sortIdA1 < sortIdB1 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    self._allRewardsLen = (table.sum)(allRewards)
    self._allRewardsTotalNumLen = (table.sum)(allRewardsTotalNum)
    ;
    (self._num1):SetText(self._allRewardsLen)
    ;
    (self._num2):SetText(self._allRewardsTotalNumLen)
  else
    ;
    (self._num1):SetText("")
    ;
    (self._num2):SetText("")
  end
  ;
  (self._frame):ReloadAllCell()
end

HalloweenSheet2.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.halloween.halloweenticketcell"
end

HalloweenSheet2.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._rewardData
end

HalloweenSheet2.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return {data = (self._rewardData)[index], index = index}
end

HalloweenSheet2.OnConfirmBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("activity.halloween.halloweenexchangedialog")
  if dialog then
    dialog:SetData(self._allRewardsLen)
  end
end

HalloweenSheet2.OnTipsBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV, CStringRes
  local dialogName = "activity.halloween.halloweentipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1630)).msgTextID)
  end
end

HalloweenSheet2.OnCurrencyIconClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._currencyItem})
  end
end

return HalloweenSheet2

