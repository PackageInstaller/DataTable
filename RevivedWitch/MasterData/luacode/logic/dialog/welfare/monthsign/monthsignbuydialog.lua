-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/monthsign/monthsignbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local C30DayBenefitSign = (BeanManager.GetTableByName)("welfare.c30daybenefitsign")
local C30dayBenefitSignin = (BeanManager.GetTableByName)("welfare.c30daybenefitsignin")
local RateRecord = C30DayBenefitSign:GetRecorder(1)
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnNum = 5
local MonthSignBuyDialog = class("MonthSignBuyDialog", Dialog)
MonthSignBuyDialog.AssetBundleName = "ui/layouts.welfare"
MonthSignBuyDialog.AssetName = "WelfareSign30DayBuy"
MonthSignBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthSignBuyDialog, C30dayBenefitSignin
  ((MonthSignBuyDialog.super).Ctor)(self, ...)
  self._cellData = {}
  self._buyDays = 1
  self._monthSignRecords = {}
  local allIds = C30dayBenefitSignin:GetAllIds()
  local len = #allIds
  for i = 1, len do
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    (self._monthSignRecords)[i] = C30dayBenefitSignin:GetRecorder(allIds[i])
  end
end

MonthSignBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnNum, _ENV
  self._txt = self:GetChild("Image/Back/Text")
  self._buyNum = self:GetChild("Image/Back/Num/Num")
  self._costTxt = self:GetChild("Image/Back/CostBack")
  self._minusBtn = self:GetChild("Image/Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Image/Back/Num/AddBtn")
  self._maxBtn = self:GetChild("Image/Back/Num/MaxBtn")
  self._cancelButton = self:GetChild("Image/Back/CancelButton")
  self._confirmButton = self:GetChild("Image/Back/ConfirmButton")
  self._itemPanel = self:GetChild("Image/Back/ItemFrame")
  self._itemFrame = (GridFrame.Create)(self._itemPanel, self, true, ColumnNum)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._minusBtn):Subscribe_PointerClickEvent(self.OnMinusBtnClicked, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self:GetChild("Image/Back/Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1919))
  ;
  (self:GetChild("Image/Back/Num/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1921))
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshCurrency, nil)
end

MonthSignBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemFrame):Destroy()
end

MonthSignBuyDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, C30dayBenefitSignin
  self._data = ((NekoData.BehaviorManager).BM_Welfare):GetMonthSignInfo()
  local allIds = C30dayBenefitSignin:GetAllIds()
  local lastRecord = C30dayBenefitSignin:GetRecorder(allIds[#allIds])
  self._maxBuyDays = lastRecord.cumulativeDays - (self._data).signTotalNum
  self:Refresh()
end

MonthSignBuyDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, RateRecord
  local num = (self._data).signTotalNum + self._buyDays
  ;
  (self._txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1920, {num}))
  ;
  (self._buyNum):SetText(self._buyDays)
  local cost = RateRecord.itemsNums * self._buyDays
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(RateRecord.itemsID) then
    (self._costTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1922, {cost}))
  else
    ;
    (self._costTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1923, {cost}))
  end
  ;
  (self._minusBtn):SetInteractable(self._buyDays > 1)
  while (self._cellData)[#self._cellData] do
    (table.remove)(self._cellData, #self._cellData)
  end
  local itemMap = {}
  for i,v in ipairs(self._monthSignRecords) do
    if not ((self._data).receivedIds)[v.id] and (self._data).signTotalNum < v.cumulativeDays and v.cumulativeDays <= num then
      if not itemMap[v.rewardId] then
        itemMap[v.rewardId] = v.nums
      else
        itemMap[v.rewardId] = itemMap[v.rewardId] + v.nums
      end
    end
  end
  if num >= v.cumulativeDays then
    for k,v in pairs(itemMap) do
      (table.insert)(self._cellData, {itemId = k, itemCount = v})
    end
    ;
    (self._itemFrame):ReloadAllCell()
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

MonthSignBuyDialog.OnMinusBtnClicked = function(self)
  -- function num : 0_5
  if self._buyDays > 1 then
    self._buyDays = self._buyDays - 1
    self:Refresh()
  end
end

MonthSignBuyDialog.OnAddBtnClicked = function(self)
  -- function num : 0_6
  if self._buyDays < self._maxBuyDays then
    self._buyDays = self._buyDays + 1
    self:Refresh()
  end
end

MonthSignBuyDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_7
  if self._buyDays < self._maxBuyDays then
    self._buyDays = self._maxBuyDays
    self:Refresh()
  end
end

MonthSignBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

MonthSignBuyDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_9 , upvalues : RateRecord, _ENV
  local cost = RateRecord.itemsNums * self._buyDays
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(RateRecord.itemsID) then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.login.cbuymonthsignnum")
    protocol.num = self._buyDays
    protocol:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_9_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(50)
  end
, {}, nil, {})
    end
  end
end

MonthSignBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  return #self._cellData
end

MonthSignBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  return "welfare.monthsign.rewarditemcell"
end

MonthSignBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return (self._cellData)[index]
end

return MonthSignBuyDialog

