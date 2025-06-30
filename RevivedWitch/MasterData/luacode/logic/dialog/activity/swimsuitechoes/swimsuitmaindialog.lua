-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local CSRLand = (BeanManager.GetTableByName)("activity.csrland")
local CurrencyID = {DataCommon.SummerEchoesCurrency1, DataCommon.SummerEchoesCurrency2}
local ChildDialogs = {"activity.swimsuitechoes.swimsuitstorymiandialog", "activity.swimsuitechoes.swimsuitstorybattledialog", "bag.spiritrecoverdialog"}
local DestroyDialogs = {"activity.swimsuitechoes.swimsuitstorymiandialog", "activity.swimsuitechoes.swimsuitstorybattledialog", "activity.swimsuitechoes.swimsuitbattledialog", "bag.spiritrecoverdialog", "activity.swimsuitechoes.challenge.maindialog"}
local MillisecondToDay = 86400000
local SwimSuitMainDialog = class("SwimSuitMainDialog", Dialog)
SwimSuitMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitMainDialog.AssetName = "ActivitySummer2Main"
SwimSuitMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitMainDialog
  ((SwimSuitMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._charUpCellPanel = self:GetChild("Panel/CharUp/CharFrame")
  self._charUpFrame = (TableFrame.Create)(self._charUpCellPanel, self, false, false)
  self._coordinateOutPutBtn = self:GetChild("coordinate")
  ;
  (self._coordinateOutPutBtn):SetActive((((CS.PixelNeko).LuaManager).IsUnityEditor)())
  ;
  (self._coordinateOutPutBtn):Subscribe_PointerClickEvent(self.PrintCoordinates, self)
  self._eventIconPanel = self:GetChild("EventIconPanel")
  self._num0Icon = self:GetChild("Num0/Icon")
  self._spiritNum = self:GetChild("Num0/Text")
  self._spiritAddBtn = self:GetChild("Num0/Add")
  self._spiritRedDot = self:GetChild("Num0/RedDot")
  ;
  (self._spiritAddBtn):Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._currency = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

      (self._currency)[i] = {}
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._currency)[i]).panel = self:GetChild("Num" .. i)
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._currency)[i]).count = self:GetChild("Num" .. i .. "/Text")
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._currency)[i]).img = self:GetChild("Num" .. i .. "/Icon")
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._currency)[i]).add = self:GetChild("Num" .. i .. "/Add")
      -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._currency)[i]).add1 = self:GetChild("Num" .. i .. "/Add (1)")
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._currency)[i]).redDot = self:GetChild("Num" .. i .. "/RedDot")
      ;
      (((self._currency)[i]).redDot):SetActive(false)
      ;
      (((self._currency)[i]).add):SetActive(false)
      ;
      (((self._currency)[i]).add1):SetActive(false)
      ;
      (((self._currency)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnNightCurrencyClick(i)
  end
)
    end
  end
  self._tipsBtn = self:GetChild("Ibtn")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._title = self:GetChild("Panel/Title")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateEchoEvent, Common.n_OnSUpdateEchoEvent, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  self._interactDialog = (DialogManager.GetDialog)("activity.swimsuitechoes.interactdialog")
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2155))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
  self:HandleSpriteEvidence()
end

SwimSuitMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, DestroyDialogs
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._charUpFrame then
    (self._charUpFrame):Destroy()
  end
  for _,dialogName in pairs(DestroyDialogs) do
    local dialog = (DialogManager.GetDialog)(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._eventIconCells then
    for _,v in ipairs(self._eventIconCells) do
      (v.dialog):Destroy()
      ;
      (v.dialog):RootWindowDestroy()
    end
  end
  do
    if self._offlinesweepDialog then
      (self._offlinesweepDialog):Destroy()
      self._offlinesweepDialog = nil
    end
  end
end

SwimSuitMainDialog.Init = function(self, sceneController)
  -- function num : 0_3 , upvalues : CEventBoostRole, _ENV
  self._sceneController = sceneController
  self._charUpData = {}
  local allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == (DataCommon.Activities).SummerEchoes then
      (table.insert)(self._charUpData, record)
    end
  end
  ;
  (table.sort)(self._charUpData, function(a, b)
    -- function num : 0_3_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._charUpFrame):ReloadAllCell()
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
  ;
  (self._spiritRedDot):SetActive(self:HaveSpiritItemSoonExpire())
  self:RefreshCurrencyData()
end

SwimSuitMainDialog.RefreshCurrencyData = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item, CurrencyID
  for i,v in ipairs(self._currency) do
    local item = (Item.Create)(CurrencyID[i])
    ;
    (v.img):SetSprite(item:GetIconAB())
    ;
    (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(CurrencyID[i]))
  end
end

SwimSuitMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  GlobalGameFSM:SetNumber("sceneLoadingId", 30001)
end

SwimSuitMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

SwimSuitMainDialog.OnSUpdateEchoEvent = function(self)
  -- function num : 0_7 , upvalues : _ENV, CSRLand, UIManager
  if self.___closed then
    return 
  end
  local eventsIconData = (self._sceneController):GetEventsIconData()
  if self._eventIconCells then
    for i,v in ipairs(self._eventIconCells) do
      (v.dialog):Destroy()
      ;
      (v.dialog):RootWindowDestroy()
    end
  end
  do
    self._eventIconCells = {}
    for i,v in ipairs(eventsIconData) do
      local worldPos = v.worldPos
      local offset = (CSRLand:GetRecorder(v.blockId)).titleOffset
      local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)((self._eventIconPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("Main", worldPos.x, worldPos.y, worldPos.z))
      local dialog = (DialogManager.CreateDialog)("activity.swimsuitechoes.swimsuiteventiconcell", (self._eventIconPanel)._uiObject)
      dialog:RefreshCell(v, self)
      ;
      (dialog._rootWindow):SetAnchoredPosition(posX + offset[1], posY + offset[2])
      local temp = {worldPos = worldPos, dialog = dialog, offset = offset}
      ;
      (table.insert)(self._eventIconCells, temp)
    end
  end
end

SwimSuitMainDialog.UpdateEventIconPosition = function(self)
  -- function num : 0_8 , upvalues : _ENV, UIManager
  for i,v in ipairs(self._eventIconCells) do
    if not v.dialog___closed then
      local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)((self._eventIconPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("Main", (v.worldPos).x, (v.worldPos).y, (v.worldPos).z))
      ;
      ((v.dialog)._rootWindow):SetAnchoredPosition(posX + (v.offset)[1], posY + (v.offset)[2])
    end
  end
end

SwimSuitMainDialog.OnEventIconClick = function(self, blockID)
  -- function num : 0_9
  (self._sceneController):SelectBlock(blockID)
  ;
  (self._bm):OnBlockClick(blockID)
end

SwimSuitMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  return #self._charUpData
end

SwimSuitMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  return "activity.swimsuitechoes.swimsuitmaincharcell"
end

SwimSuitMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return (self._charUpData)[index]
end

SwimSuitMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_13 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

SwimSuitMainDialog.OnSpiritAddBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

SwimSuitMainDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_15 , upvalues : _ENV
  self._spirit = (notification.userInfo).spirit
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
end

SwimSuitMainDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_16 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

SwimSuitMainDialog.OnNightCurrencyClick = function(self, index)
  -- function num : 0_17 , upvalues : _ENV, Item, CurrencyID
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(CurrencyID[index])})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

SwimSuitMainDialog.RefreshShopInfo = function(self, notification)
  -- function num : 0_18 , upvalues : _ENV
  local protocol = notification.userInfo
  if DataCommon.SummerEchoesShopID2 == protocol.shopId or DataCommon.SummerEchoesShopID3 == protocol.shopId then
    local dialog = (DialogManager.GetDialog)("activity.swimsuitechoes.shopmaindialog")
    if not dialog then
      dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.shopmaindialog")
    end
    if dialog then
      dialog:SetData(protocol.shopId)
    end
  end
end

SwimSuitMainDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(15)
end

SwimSuitMainDialog.RefreshOfflineSweepActive = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local status = ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus()
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if status ~= 0 and self._offlinesweepDialog == nil then
    self._offlinesweepDialog = (DialogManager.CreateDialog)("mainline.offlinesweep.offlinesweepshowbtndialog", (self._rootWindow)._uiObject)
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

SwimSuitMainDialog.PrintCoordinates = function(self)
  -- function num : 0_21
  (self._sceneController):LogAllBlocksCoordinateInfo()
end

SwimSuitMainDialog.HandleSpriteEvidence = function(self)
  -- function num : 0_22 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
  local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    if not CImagePathTable:GetRecorder(tonumber((CVarconfig:GetRecorder(125)).Value)) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._num0Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      local imageRecord = ((Item.Create)(DataCommon.SpiritID)):GetIcon()
      ;
      (self._num0Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
end

return SwimSuitMainDialog

