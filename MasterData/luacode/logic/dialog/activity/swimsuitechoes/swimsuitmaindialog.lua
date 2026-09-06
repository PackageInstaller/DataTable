local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local CSRLand = BeanManager.GetTableByName("activity.csrland")
local CurrencyID = {
  DataCommon.SummerEchoesCurrency1,
  DataCommon.SummerEchoesCurrency2
}
local ChildDialogs = {
  "activity.swimsuitechoes.swimsuitstorymiandialog",
  "activity.swimsuitechoes.swimsuitstorybattledialog",
  "bag.spiritrecoverdialog"
}
local DestroyDialogs = {
  "activity.swimsuitechoes.swimsuitstorymiandialog",
  "activity.swimsuitechoes.swimsuitstorybattledialog",
  "activity.swimsuitechoes.swimsuitbattledialog",
  "bag.spiritrecoverdialog",
  "activity.swimsuitechoes.challenge.maindialog"
}
local MillisecondToDay = 86400000
local SwimSuitMainDialog = class("SwimSuitMainDialog", Dialog)
SwimSuitMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitMainDialog.AssetName = "ActivitySummer2Main"

function SwimSuitMainDialog:Ctor(...)
  SwimSuitMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SwimSuitMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._charUpCellPanel = self:GetChild("Panel/CharUp/CharFrame")
  self._charUpFrame = TableFrame.Create(self._charUpCellPanel, self, false, false)
  self._coordinateOutPutBtn = self:GetChild("coordinate")
  self._coordinateOutPutBtn:SetActive(CS.PixelNeko.LuaManager.IsUnityEditor())
  self._coordinateOutPutBtn:Subscribe_PointerClickEvent(self.PrintCoordinates, self)
  self._eventIconPanel = self:GetChild("EventIconPanel")
  self._num0Icon = self:GetChild("Num0/Icon")
  self._spiritNum = self:GetChild("Num0/Text")
  self._spiritAddBtn = self:GetChild("Num0/Add")
  self._spiritRedDot = self:GetChild("Num0/RedDot")
  self._spiritAddBtn:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._currency = {}
  for i = 1, 2 do
    self._currency[i] = {}
    self._currency[i].panel = self:GetChild("Num" .. i)
    self._currency[i].count = self:GetChild("Num" .. i .. "/Text")
    self._currency[i].img = self:GetChild("Num" .. i .. "/Icon")
    self._currency[i].add = self:GetChild("Num" .. i .. "/Add")
    self._currency[i].add1 = self:GetChild("Num" .. i .. "/Add (1)")
    self._currency[i].redDot = self:GetChild("Num" .. i .. "/RedDot")
    self._currency[i].redDot:SetActive(false)
    self._currency[i].add:SetActive(false)
    self._currency[i].add1:SetActive(false)
    self._currency[i].panel:Subscribe_PointerClickEvent(function()
      self:OnNightCurrencyClick(i)
    end)
  end
  self._tipsBtn = self:GetChild("Ibtn")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._title = self:GetChild("Panel/Title")
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateEchoEvent, Common.n_OnSUpdateEchoEvent, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  self._interactDialog = DialogManager.GetDialog("activity.swimsuitechoes.interactdialog")
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(2155))
  LuaNotificationCenter.AddObserver(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
  self:HandleSpriteEvidence()
end

function SwimSuitMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._charUpFrame then
    self._charUpFrame:Destroy()
  end
  for _, dialogName in pairs(DestroyDialogs) do
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._eventIconCells then
    for _, v in ipairs(self._eventIconCells) do
      v.dialog:Destroy()
      v.dialog:RootWindowDestroy()
    end
  end
  if self._offlinesweepDialog then
    self._offlinesweepDialog:Destroy()
    self._offlinesweepDialog = nil
  end
end

function SwimSuitMainDialog:Init(sceneController)
  self._sceneController = sceneController
  self._charUpData = {}
  local allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == DataCommon.Activities.SummerEchoes then
      table.insert(self._charUpData, record)
    end
  end
  table.sort(self._charUpData, function(a, b)
    return a.sort < b.sort
  end)
  self._charUpFrame:ReloadAllCell()
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
  self._spiritRedDot:SetActive(self:HaveSpiritItemSoonExpire())
  self:RefreshCurrencyData()
end

function SwimSuitMainDialog:RefreshCurrencyData()
  for i, v in ipairs(self._currency) do
    local item = Item.Create(CurrencyID[i])
    v.img:SetSprite(item:GetIconAB())
    v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(CurrencyID[i]))
  end
end

function SwimSuitMainDialog:OnBackBtnClicked()
  GlobalGameFSM:SetNumber("sceneLoadingId", 30001)
end

function SwimSuitMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function SwimSuitMainDialog:OnSUpdateEchoEvent()
  if self.___closed then
    return
  end
  local eventsIconData = self._sceneController:GetEventsIconData()
  if self._eventIconCells then
    for i, v in ipairs(self._eventIconCells) do
      v.dialog:Destroy()
      v.dialog:RootWindowDestroy()
    end
  end
  self._eventIconCells = {}
  for i, v in ipairs(eventsIconData) do
    local worldPos = v.worldPos
    local offset = CSRLand:GetRecorder(v.blockId).titleOffset
    local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._eventIconPanel._uiObject, UIManager.WorldToScreenPointInMargin("Main", worldPos.x, worldPos.y, worldPos.z))
    local dialog = DialogManager.CreateDialog("activity.swimsuitechoes.swimsuiteventiconcell", self._eventIconPanel._uiObject)
    dialog:RefreshCell(v, self)
    dialog._rootWindow:SetAnchoredPosition(posX + offset[1], posY + offset[2])
    local temp = {
      worldPos = worldPos,
      dialog = dialog,
      offset = offset
    }
    table.insert(self._eventIconCells, temp)
  end
end

function SwimSuitMainDialog:UpdateEventIconPosition()
  for i, v in ipairs(self._eventIconCells) do
    if not v.dialog___closed then
      local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._eventIconPanel._uiObject, UIManager.WorldToScreenPointInMargin("Main", v.worldPos.x, v.worldPos.y, v.worldPos.z))
      v.dialog._rootWindow:SetAnchoredPosition(posX + v.offset[1], posY + v.offset[2])
    end
  end
end

function SwimSuitMainDialog:OnEventIconClick(blockID)
  self._sceneController:SelectBlock(blockID)
  self._bm:OnBlockClick(blockID)
end

function SwimSuitMainDialog:NumberOfCell(frame)
  return #self._charUpData
end

function SwimSuitMainDialog:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.swimsuitmaincharcell"
end

function SwimSuitMainDialog:DataAtIndex(frame, index)
  return self._charUpData[index]
end

function SwimSuitMainDialog:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function SwimSuitMainDialog:OnSpiritAddBtnClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function SwimSuitMainDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
end

function SwimSuitMainDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function SwimSuitMainDialog:OnNightCurrencyClick(index)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(CurrencyID[index])
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function SwimSuitMainDialog:RefreshShopInfo(notification)
  local protocol = notification.userInfo
  if DataCommon.SummerEchoesShopID2 == protocol.shopId or DataCommon.SummerEchoesShopID3 == protocol.shopId then
    local dialog = DialogManager.GetDialog("activity.swimsuitechoes.shopmaindialog")
    dialog = dialog or DialogManager.CreateSingletonDialog("activity.swimsuitechoes.shopmaindialog")
    if dialog then
      dialog:SetData(protocol.shopId)
    end
  end
end

function SwimSuitMainDialog:OnTipsBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(15)
end

function SwimSuitMainDialog:RefreshOfflineSweepActive()
  local status = NekoData.BehaviorManager.BM_OfflineSweep:GetStatus()
  if status ~= 0 then
    if self._offlinesweepDialog == nil then
      self._offlinesweepDialog = DialogManager.CreateDialog("mainline.offlinesweep.offlinesweepshowbtndialog", self._rootWindow._uiObject)
    end
  elseif self._offlinesweepDialog then
    self._offlinesweepDialog:Destroy()
    self._offlinesweepDialog = nil
  end
end

function SwimSuitMainDialog:PrintCoordinates()
  self._sceneController:LogAllBlocksCoordinateInfo()
end

function SwimSuitMainDialog:HandleSpriteEvidence()
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    local imageRecord = CImagePathTable:GetRecorder(tonumber(CVarconfig:GetRecorder(125).Value)) or DataCommon.DefaultImageAsset
    self._num0Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    local imageRecord = Item.Create(DataCommon.SpiritID):GetIcon()
    self._num0Icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

return SwimSuitMainDialog
