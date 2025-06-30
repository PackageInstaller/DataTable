-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/runeadvancement/exchangedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ExchangeTable = (BeanManager.GetTableByName)("role.croleadvanceditemexchange")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
ExchangeDialog.AssetName = "CharUpgradeMixSecondConfirm"
ExchangeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ExchangeDialog
  ((ExchangeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._exchangeIdStacks = {}
  self._exchangeId = nil
  self._canClickCancleBtn = false
  self._canClickConfirmBtn = false
  self._costNum = 0
  self._limitNum = 0
end

ExchangeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("BackImage/Item1/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2050))
  ;
  (self:GetChild("BackImage/Item2/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2051))
  ;
  (self:GetChild("BackImage/CancelButton/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2))
  ;
  (self:GetChild("BackImage/ConfirmButton/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1))
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
  ;
  (self._leftItem_icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnCellClicked(1)
  end
, self)
  ;
  (self._rightItem_icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnCellClicked(2)
  end
)
end

ExchangeDialog.OnDestroy = function(self)
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
  (self._txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2048, {(self._leftItem):GetName(), (self._rightItem):GetName()}))
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

ExchangeDialog.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV, ExchangeTable, Item, RefreshOperatePanel
  if (table.nums)(self._exchangeIdStacks) == 0 then
    self:Destroy()
    return 
  end
  self._exchangeId = (self._exchangeIdStacks)[1]
  local record = ExchangeTable:GetRecorder(self._exchangeId)
  local leftItem = (Item.Create)(record.nowItem)
  local rightItem = (Item.Create)(record.exchangeItem)
  self._leftItem = leftItem
  self._rightItem = rightItem
  self._rate = record.exchangeNum / record.itemNum
  self._costNumRate = record.itemNum
  self._costNum = self._costNumRate
  local str = ((NekoData.BehaviorManager).BM_Message):GetString(2047)
  ;
  (self._title):SetText(str)
  local imageRecord = leftItem:GetIcon()
  ;
  (self._leftItem_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = rightItem:GetIcon()
  ;
  (self._rightItem_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum1, haveNum2 = nil, nil
  haveNum1 = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(record.nowItem)
  self._limitNum = (math.floor)(haveNum1 / self._costNumRate) * self._costNumRate
  haveNum2 = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(record.exchangeItem)
  ;
  (self._leftItem_curNum):SetText((NumberManager.GetShowNumber)(haveNum1))
  ;
  (self._rightItem_curNum):SetText((NumberManager.GetShowNumber)(haveNum2))
  RefreshOperatePanel(self)
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

ExchangeDialog.PushDialogSetting = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  local repeatId = nil
  for i,v in ipairs(self._exchangeIdStacks) do
    if v == id then
      repeatId = id
      break
    end
  end
  do
    if repeatId then
      LogErrorFormat("ExchangeDialog", "Duplicate with existing ID: %s", repeatId)
    end
    ;
    (table.insert)(self._exchangeIdStacks, id)
    self:Refresh()
  end
end

ExchangeDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_7 , upvalues : RefreshOperatePanel
  self._costNum = self._costNum - self._costNumRate
  RefreshOperatePanel(self)
end

ExchangeDialog.OnAddBtnClicked = function(self)
  -- function num : 0_8 , upvalues : RefreshOperatePanel
  self._costNum = self._costNum + self._costNumRate
  RefreshOperatePanel(self)
end

ExchangeDialog.OnMinBtnClicked = function(self)
  -- function num : 0_9 , upvalues : RefreshOperatePanel
  self._costNum = self._costNumRate
  RefreshOperatePanel(self)
end

ExchangeDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_10 , upvalues : RefreshOperatePanel
  self._costNum = self._limitNum
  RefreshOperatePanel(self)
end

ExchangeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self._canClickCancleBtn then
    return 
  end
  self._canClickCancleBtn = false
  ;
  (table.remove)(self._exchangeIdStacks, 1)
  self:Refresh()
end

ExchangeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self._canClickConfirmBtn then
    return 
  end
  if self._needJump then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100483, {(self._leftItem):GetName()})
  else
    self._canClickConfirmBtn = false
    local cmd = (LuaNetManager.CreateProtocol)("protocol.login.cdustsynthesis")
    cmd.dustId = (self._exchangeIdStacks)[1]
    cmd.num = (math.ceil)(self._costNum * self._rate)
    cmd:Send()
    ;
    (table.remove)(self._exchangeIdStacks, 1)
    self:Refresh()
  end
end

ExchangeDialog.OnCellClicked = function(self, id)
  -- function num : 0_13 , upvalues : _ENV
  local item = nil
  if id == 1 then
    item = self._leftItem
  else
    if id == 2 then
      item = self._rightItem
    end
  end
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = item})
  end
end

return ExchangeDialog

