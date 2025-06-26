-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/currencyexchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CurrencyExchangeTable = (BeanManager.GetTableByName)("recharge.ccurrencyexchange")
local Item = require("logic.manager.experimental.types.item")
local CurrencyExchangeDialog = class("CurrencyExchangeDialog", Dialog)
CurrencyExchangeDialog.AssetBundleName = "ui/layouts.yard"
CurrencyExchangeDialog.AssetName = "FurnitureCoinExchange"
CurrencyExchangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CurrencyExchangeDialog
  ((CurrencyExchangeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._currencyExchangeIdStacks = {}
  self._currencyExchangeId = nil
  self._canClickCancleBtn = false
  self._canClickConfirmBtn = false
  self._costNum = 0
  self._limitNum = 0
end

CurrencyExchangeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("BackImage/TitleBack/Title")
  self._leftItem_icon = self:GetChild("BackImage/Item1/ItemCell/_BackGround/Icon")
  self._leftItem_curNum = self:GetChild("BackImage/Item1/ItemCell/_Count")
  self._leftItem_costNum = self:GetChild("BackImage/Item1/Num2")
  self._rightItem_icon = self:GetChild("BackImage/Item2/ItemCell/_BackGround/Icon")
  self._rightItem_curNum = self:GetChild("BackImage/Item2/ItemCell/_Count")
  self._rightItem_addNum = self:GetChild("BackImage/Item2/Num2")
  self._buyNumText = self:GetChild("BackImage/Num/Num")
  self._reduceBtn = self:GetChild("BackImage/Num/MinusBtn")
  self._addBtn = self:GetChild("BackImage/Num/AddBtn")
  self._minBtn = self:GetChild("BackImage/Num/MinBtn")
  self._maxBtn = self:GetChild("BackImage/Num/MaxBtn")
  self._txt = self:GetChild("BackImage/Txt")
  self._cancelBtn = self:GetChild("BackImage/CancelButton")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._minBtn):Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

CurrencyExchangeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

local GetString = function(self, str, params)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs(params) do
    str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
  end
  return str
end

local RefreshOperatePanel = function(self)
  -- function num : 0_4 , upvalues : _ENV, GetString
  (self._rightItem_addNum):SetText((math.ceil)(self._costNum * self._rate))
  ;
  (self._leftItem_costNum):SetText(GetString(self, (TextManager.GetText)(1100048), {self._costNum}))
  ;
  (self._buyNumText):SetText(self._costNum)
  ;
  (self._txt):SetText(GetString(self, (TextManager.GetText)(1100043), {self._costNum, (self._leftItem):GetName(), (math.ceil)(self._costNum * self._rate), (self._rightItem):GetName()}))
  ;
  (self._reduceBtn):SetInteractable(self._costNumRate < self._costNum)
  ;
  (self._addBtn):SetInteractable(self._costNum < self._limitNum)
  ;
  (self._minBtn):SetInteractable(self._costNumRate < self._costNum)
  ;
  (self._maxBtn):SetInteractable(self._costNum < self._limitNum)
  self._needJump = self._limitNum < self._costNum
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

CurrencyExchangeDialog.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV, CurrencyExchangeTable, Item, RefreshOperatePanel
  if (table.nums)(self._currencyExchangeIdStacks) == 0 then
    self:Destroy()
    return 
  end
  self._currencyExchangeId = (self._currencyExchangeIdStacks)[1]
  local record = CurrencyExchangeTable:GetRecorder(self._currencyExchangeId)
  local leftItem = (Item.Create)(record.Currency1)
  local rightItem = (Item.Create)(record.Currency2)
  self._leftItem = leftItem
  self._rightItem = rightItem
  self._rate = record.Currencynum / record.Nums
  self._costNumRate = record.Nums
  self._costNum = self._costNumRate
  local str = (TextManager.GetText)(record.TitleID)
  ;
  (self._title):SetText(str)
  local imageRecord = leftItem:GetIcon()
  ;
  (self._leftItem_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = rightItem:GetIcon()
  ;
  (self._rightItem_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum1, haveNum2 = nil, nil
  if (string.sub)(record.Currency1, 1, 2) == "35" then
    haveNum1 = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(record.Currency1)
  else
    haveNum1 = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(record.Currency1)
  end
  self._limitNum = (math.floor)(haveNum1 / self._costNumRate) * self._costNumRate
  if (string.sub)(record.Currency2, 1, 2) == "35" then
    haveNum2 = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(record.Currency2)
  else
    haveNum2 = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(record.Currency2)
  end
  ;
  (self._leftItem_curNum):SetText((NumberManager.GetShowNumber)(haveNum1))
  ;
  (self._rightItem_curNum):SetText((NumberManager.GetShowNumber)(haveNum2))
  RefreshOperatePanel(self)
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

CurrencyExchangeDialog.PushDialogSetting = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  local repeatId = nil
  for i,v in ipairs(self._currencyExchangeIdStacks) do
    if v == id then
      repeatId = id
      break
    end
  end
  do
    if repeatId then
      LogErrorFormat("CurrencyExchangeDialog", "Duplicate with existing ID: %s", repeatId)
    end
    ;
    (table.insert)(self._currencyExchangeIdStacks, id)
    self:Refresh()
  end
end

CurrencyExchangeDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_7 , upvalues : RefreshOperatePanel
  self._costNum = self._costNum - self._costNumRate
  RefreshOperatePanel(self)
end

CurrencyExchangeDialog.OnAddBtnClicked = function(self)
  -- function num : 0_8 , upvalues : RefreshOperatePanel
  self._costNum = self._costNum + self._costNumRate
  RefreshOperatePanel(self)
end

CurrencyExchangeDialog.OnMinBtnClicked = function(self)
  -- function num : 0_9 , upvalues : RefreshOperatePanel
  self._costNum = self._costNumRate
  RefreshOperatePanel(self)
end

CurrencyExchangeDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_10 , upvalues : RefreshOperatePanel
  self._costNum = self._limitNum
  RefreshOperatePanel(self)
end

CurrencyExchangeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self._canClickCancleBtn then
    return 
  end
  self._canClickCancleBtn = false
  ;
  (table.remove)(self._currencyExchangeIdStacks, 1)
  self:Refresh()
end

CurrencyExchangeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self._canClickConfirmBtn then
    return 
  end
  self._canClickConfirmBtn = false
  if self._needJump then
    if self._currencyExchangeId == 3 then
      self._canClickConfirmBtn = true
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100350)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_12_0 , upvalues : self, _ENV
    self._canClickConfirmBtn = true
    ;
    ((NekoData.BehaviorManager).BM_Shop):JumpToShopBuyDiamonds()
    ;
    (table.remove)(self._currencyExchangeIdStacks, 1)
    self:Refresh()
  end
, {}, function()
    -- function num : 0_12_1 , upvalues : self
    self._canClickConfirmBtn = true
  end
, {})
    end
  else
    local cmd = (LuaNetManager.CreateProtocol)("protocol.shop.cdiamondexchange")
    cmd.costItem = (self._leftItem):GetID()
    cmd.exchangeCurrencyType = (self._rightItem):GetID()
    cmd.exchangeCurrencySum = (math.ceil)(self._costNum * self._rate)
    cmd.costItemSum = self._costNum
    cmd:Send()
    ;
    (table.remove)(self._currencyExchangeIdStacks, 1)
    self:Refresh()
  end
end

return CurrencyExchangeDialog

