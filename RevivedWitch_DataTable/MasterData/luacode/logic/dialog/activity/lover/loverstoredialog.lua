-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/loverstoredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CLoverStoreCfg = (BeanManager.GetTableByName)("activity.cvalentinestore")
local CLinesCfg = (BeanManager.GetTableByName)("activity.cfoodstallslines")
local timeofword = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(88)).Value)
local LoverStoreDialog = class("LoverStoreDialog", Dialog)
LoverStoreDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverStoreDialog.AssetName = "ActivityValentinesStore"
local CheckFormula = function(self, id)
  -- function num : 0_0 , upvalues : CLoverStoreCfg, _ENV
  local recorder = CLoverStoreCfg:GetRecorder(id)
  if recorder then
    local consumablesNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(recorder.itemId1)
    if recorder.itemNum1 * recorder.buyNum <= consumablesNum then
      return true
    end
  end
end

LoverStoreDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : LoverStoreDialog, _ENV
  ((LoverStoreDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._moneyList = {DataCommon.LoveFlowers, DataCommon.LoveChocolate, DataCommon.LoveTownCurrency}
  self._messageBM = (NekoData.BehaviorManager).BM_Message
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.LoverActivityManagerID)
end

LoverStoreDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV, CLoverStoreCfg, Item, TableFrame
  self._backImage = self:GetChild("BackImage")
  self._background = self:GetChild("Background")
  self._back1 = self:GetChild("Back1")
  self._title = self:GetChild("Title")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1700))
  ;
  (self._back1):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_0 , upvalues : self
    self:PlayVoiceText(1)
  end
)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._dialogPanel = self:GetChild("Talk")
  self._dialogTxt = self:GetChild("Talk/Text")
  ;
  (self._dialogPanel):SetActive(false)
  self._dialogPanel_width = (self._dialogPanel):GetDeltaSize()
  self._dialogPanel_txt_width = (self._dialogTxt):GetDeltaSize()
  self._exchangeArea = {}
  local tempStr = "ChocolateBuy"
  for i = 1, 2 do
    local name = tempStr .. i
    do
      local id = (i - 1) * 2 + 1
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._exchangeArea)[i] = {}
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).cell = self:GetChild(name)
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).onebtn = self:GetChild(name .. "/Onebtn")
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).tenbtn = self:GetChild(name .. "/Tenkbtn")
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).onebtn_text = self:GetChild(name .. "/Onebtn/Text")
      -- DECOMPILER ERROR at PC122: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).tenbtn_text = self:GetChild(name .. "/Tenkbtn/Text")
      -- DECOMPILER ERROR at PC130: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).directionText = self:GetChild(name .. "/Direction/Text")
      ;
      (((self._exchangeArea)[i]).onebtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_1 , upvalues : self, id
    self:OnGetBtnClicked(id)
  end
)
      ;
      (((self._exchangeArea)[i]).tenbtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_2 , upvalues : self, id
    self:OnGetBtnClicked(id + 1)
  end
)
      ;
      (((self._exchangeArea)[i]).onebtn_text):SetText((self._messageBM):GetString(1706, {(CLoverStoreCfg:GetRecorder(id)).buyNum}))
      ;
      (((self._exchangeArea)[i]).tenbtn_text):SetText((self._messageBM):GetString(1706, {(CLoverStoreCfg:GetRecorder(id + 1)).buyNum}))
      ;
      (((self._exchangeArea)[i]).directionText):SetText((self._messageBM):GetString(1723))
      -- DECOMPILER ERROR at PC191: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).consumablesImg = self:GetChild(name .. "/Item1")
      -- DECOMPILER ERROR at PC199: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).consumablesNumTxt = self:GetChild(name .. "/Item1/Num")
      -- DECOMPILER ERROR at PC207: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).consumablesText = self:GetChild(name .. "/Item1/Text")
      -- DECOMPILER ERROR at PC215: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).productImag = self:GetChild(name .. "/Item2")
      -- DECOMPILER ERROR at PC223: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).productNumTxt = self:GetChild(name .. "/Item2/Num")
      -- DECOMPILER ERROR at PC231: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).productText = self:GetChild(name .. "/Item2/Text")
      -- DECOMPILER ERROR at PC239: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).unexpectedExplanationTxt = self:GetChild(name .. "/ImageBack/Num")
      -- DECOMPILER ERROR at PC247: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).unexpectedProductImag = self:GetChild(name .. "/ImageBack/Item")
      -- DECOMPILER ERROR at PC255: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self._exchangeArea)[i]).unexpectedProductNumTxt = self:GetChild(name .. "/ImageBack/Item/Num")
      local recorder = CLoverStoreCfg:GetRecorder(id)
      if recorder then
        local consumablesItem = (Item.Create)(recorder.itemId1)
        local imageRecord = consumablesItem:GetIcon()
        ;
        (((self._exchangeArea)[i]).consumablesImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (((self._exchangeArea)[i]).consumablesNumTxt):SetText(recorder.itemNum1)
        ;
        (((self._exchangeArea)[i]).consumablesText):SetText(consumablesItem:GetName())
        local productItem = (Item.Create)(recorder.itemId2)
        local imageRecord = productItem:GetIcon()
        ;
        (((self._exchangeArea)[i]).productImag):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (((self._exchangeArea)[i]).productNumTxt):SetText(recorder.itemNum2)
        ;
        (((self._exchangeArea)[i]).productText):SetText(productItem:GetName())
        local unexpectedProductItem = (Item.Create)(recorder.itemId3)
        local imageRecord = unexpectedProductItem:GetIcon()
        ;
        (((self._exchangeArea)[i]).unexpectedProductImag):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (((self._exchangeArea)[i]).unexpectedExplanationTxt):SetText((self._messageBM):GetString(1705, {recorder.item3Probability}))
        ;
        (((self._exchangeArea)[i]).unexpectedProductNumTxt):SetText(recorder.itemNum3)
        ;
        (((self._exchangeArea)[i]).consumablesImg):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_3 , upvalues : self, consumablesItem
    self:OnItemCellClick(consumablesItem)
  end
, self)
        ;
        (((self._exchangeArea)[i]).productImag):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_4 , upvalues : self, productItem
    self:OnItemCellClick(productItem)
  end
, self)
        ;
        (((self._exchangeArea)[i]).unexpectedProductImag):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_5 , upvalues : self, unexpectedProductItem
    self:OnItemCellClick(unexpectedProductItem)
  end
, self)
      end
    end
  end
  self._topGroup = self:GetChild("TopGroup")
  self._moneyFrame = (TableFrame.Create)(self._topGroup, self, false, name, id)
  -- DECOMPILER ERROR at PC384: Overwrote pending register: R6 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMoney, Common.n_RefreshCurrency, name)
  self:Init()
end

LoverStoreDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._moneyFrame then
    (self._moneyFrame):Destroy()
    self._moneyFrame = nil
  end
  if self._contentTimer then
    (GameTimer.RemoveTask)(self._contentTimer)
    self._contentTimer = nil
  end
end

LoverStoreDialog.Init = function(self)
  -- function num : 0_4
  self:OnRefreshMoney()
  self:PlayVoiceText(1)
end

LoverStoreDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._moneyFrame then
    return #self._moneyList
  end
end

LoverStoreDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._moneyFrame then
    return "activity.lover.lovermoneynumcell"
  end
end

LoverStoreDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._moneyFrame then
    return (self._moneyList)[index]
  end
end

LoverStoreDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

LoverStoreDialog.OnGetBtnClicked = function(self, id)
  -- function num : 0_9 , upvalues : CheckFormula, _ENV
  if CheckFormula(self, id) then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cdialoguebuy")
    if protocol then
      protocol.id = id
      protocol:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100453)
    end
  end
end

LoverStoreDialog.OnRefreshMoney = function(self)
  -- function num : 0_10
  (self._moneyFrame):ReloadAllCell()
end

LoverStoreDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

LoverStoreDialog.PlayVoiceText = function(self, id)
  -- function num : 0_12 , upvalues : _ENV, timeofword
  self._linesText = (TextManager.GetText)((self._bm):GetRandomLine(((self._bm).LineFuncitionType).Store, id))
  self._linesText = (string.gsub)(self._linesText, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username or "")
  ;
  (self._dialogTxt):SetActive(true)
  ;
  (self._dialogPanel):SetActive(true)
  ;
  (self._dialogTxt):SetText(self._linesText)
  local _, textheight = (self._dialogTxt):GetPreferredSize()
  if self._dialogPanel_txt_height < textheight then
    (self._dialogTxt):SetDeltaSize(self._dialogPanel_txt_width, textheight)
    ;
    (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    ;
    (self._dialogTxt):SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    ;
    (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  local text = (string.trim)(self._linesText)
  if self._contentTimer then
    (GameTimer.RemoveTask)(self._contentTimer)
    self._contentTimer = nil
  end
  self._contentTimer = (GameTimer.AddTask)((utf8.len)(text) * timeofword / 1000, -1, function()
    -- function num : 0_12_0 , upvalues : self, _ENV
    if self._contentTimer then
      (GameTimer.RemoveTask)(self._contentTimer)
      self._contentTimer = nil
      ;
      (self._dialogTxt):SetActive(false)
      ;
      (self._dialogPanel):SetActive(false)
    end
  end
)
end

LoverStoreDialog.OnItemCellClick = function(self, item)
  -- function num : 0_13 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return LoverStoreDialog

