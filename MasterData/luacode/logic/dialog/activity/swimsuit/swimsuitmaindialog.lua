local STATE = {
  Main = 1,
  Shop = 2,
  DIY = 3
}
local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local HexagonalBlock = require("logic.manager.experimental.types.hexagonalblock")
local Item = require("logic.manager.experimental.types.item")
local timeutils = require("logic.utils.timeutils")
local CHexagonScene = BeanManager.GetTableByName("activity.chexagonscene")
local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSwimDailyMission = BeanManager.GetTableByName("activity.cswimdailymission")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local MaterialsId = {
  DataCommon.SwimSuitWood,
  DataCommon.SwimSuitSand,
  DataCommon.SwimSuitStone
}
local NightCurrencyId = {
  DataCommon.SwimSuitCoinConch,
  DataCommon.SwimSuitCoinPearl,
  DataCommon.SwimSuitCoinCoral
}
local ChildDialogs = {
  "activity.swimsuit.buydialog",
  "activity.swimsuit.showdialog",
  "activity.swimsuit.xiguadialog",
  "activity.swimsuit.activitysummerbuybuildingtip",
  "activity.swimsuit.swimsuitstorybranchdialog",
  "activity.swimsuit.swimsuitstorymiandialog",
  "activity.swimsuit.swimsuitbattledialog",
  "activity.swimsuit.swimsuitstorybattledialog",
  "bag.spiritrecoverdialog"
}
local MillisecondToDay = 86400000
local SwimSuitMainDialog = class("SwimSuitMainDialog", Dialog)
SwimSuitMainDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainDialog.AssetName = "ActivitySummerMain"

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(64, 1) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(64)
  end
end

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 64 and notification.userInfo.guideStatus == "Start" then
    LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

function SwimSuitMainDialog:Ctor(...)
  SwimSuitMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._state = STATE.Main
end

function SwimSuitMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._shopBtn = self:GetChild("ShopBtn")
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._diyBtn = self:GetChild("RankBtn")
  self._diyBtn:Subscribe_PointerClickEvent(self.OnDIYBtnClicked, self)
  self._downPanel = self:GetChild("Down")
  self._downBack = self:GetChild("Down/DownBack")
  self._itemCellPanel = self:GetChild("Down/ItemFrame")
  self._itemCellPanelanchorX, self._itemCellPaneloffsetX = self._itemCellPanel:GetHeight()
  self._itemFrame = TableFrame.Create(self._itemCellPanel, self, false, false)
  self._empty = self:GetChild("Down/Empty")
  self._downPanel:SetActive(false)
  self._diyBtn:SetActive(false)
  self._panelDIY = self:GetChild("PanelDIY")
  self._panelDIY:SetActive(false)
  self._noBtn = self:GetChild("PanelDIY/Select/NoBtn")
  self._yesBtn = self:GetChild("PanelDIY/Select/YesBtn")
  self._diyTitle = self:GetChild("PanelDIY/Title")
  self._diyTitle:SetActive(false)
  self._diyselect = self:GetChild("PanelDIY/Select")
  self._anchorX, self._offsetX, self._anchorY, self._offsetY = self._diyselect:GetSize()
  self._noBtn:Subscribe_PointerClickEvent(self.OnNoBtnClicked, self)
  self._yesBtn:Subscribe_PointerClickEvent(self.OnYesBtnClicked, self)
  self._mainPanel = self:GetChild("Panel")
  self._CharUp = self:GetChild("Panel/CharUp")
  self._charUpCellPanel = self:GetChild("Panel/CharUp/CharFrame")
  self._charUpFrame = TableFrame.Create(self._charUpCellPanel, self, false, false)
  self._materials = {}
  for i = 1, 3 do
    self._materials[i] = {}
    self._materials[i].back = self:GetChild("Panel/Material/Material" .. i .. "/back")
    self._materials[i].back:Subscribe_PointerClickEvent(function()
      self:OnMaterialClick(i)
    end, self)
    self._materials[i].img = self:GetChild("Panel/Material/Material" .. i .. "/Image")
    self._materials[i].name = self:GetChild("Panel/Material/Material" .. i .. "/Text")
    self._materials[i].count = self:GetChild("Panel/Material/Material" .. i .. "/Num")
  end
  self._taskTitle = self:GetChild("Panel/Task")
  self._taskCellPanel = self:GetChild("Panel/Task/Frame")
  self._taskFrame = TableFrame.Create(self._taskCellPanel, self, true, true)
  self._taksFrameScrollBar = self:GetChild("Panel/Task/Frame/Scrollbar")
  self._ringDay = self:GetChild("Panel/Time/ChangeBtn/RingMask/RingDay")
  self._ringNigh = self:GetChild("Panel/Time/ChangeBtn/RingMask/RingNigh")
  self._timeChangeBtn = self:GetChild("Panel/Time/ChangeBtn")
  self._sunImg = self:GetChild("Panel/Time/ChangeBtn/Sun")
  self._moonImg = self:GetChild("Panel/Time/ChangeBtn/Moon")
  self._timeChangeBtn:Subscribe_PointerClickEvent(self.OnTimeChangeBtnClicked, self)
  self._timeImg = self:GetChild("Panel/Time/ChangeBtn/RingMask/RingDay")
  self._timeTipsback = self:GetChild("Panel/Time/Tipsback")
  self._tipText = self:GetChild("Panel/Time/Tipsback/Text")
  self._timeTipsEffect = self:GetChild("UI_TX_Prefab_GuideClick_alone")
  self._coordinateOutPutBtn = self:GetChild("coordinate")
  self._coordinateOutPutBtn:SetActive(CS.PixelNeko.LuaManager.IsUnityEditor())
  self._coordinateOutPutBtn:Subscribe_PointerClickEvent(self.PrintCoordinates, self)
  self._eventIconPanel = self:GetChild("EventIconPanel")
  self._spiritNum = self:GetChild("Num0/Text")
  self._spiritAddBtn = self:GetChild("Num0/Add")
  self._spiritRedDot = self:GetChild("Num0/RedDot")
  self._nightcurrency = {}
  for i = 1, 3 do
    self._nightcurrency[i] = {}
    self._nightcurrency[i].panel = self:GetChild("Num" .. i)
    self._nightcurrency[i].count = self:GetChild("Num" .. i .. "/Text")
    self._nightcurrency[i].img = self:GetChild("Num" .. i .. "/Icon")
    self._nightcurrency[i].add = self:GetChild("Num" .. i .. "/Add")
    self._nightcurrency[i].add1 = self:GetChild("Num" .. i .. "/Add (1)")
    self._nightcurrency[i].redDot = self:GetChild("Num" .. i .. "/RedDot")
    self._nightcurrency[i].redDot:SetActive(false)
    self._nightcurrency[i].add:SetActive(false)
    self._nightcurrency[i].add1:SetActive(false)
    self._nightcurrency[i].panel:Subscribe_PointerClickEvent(function()
      self:OnNightCurrencyClick(i)
    end)
  end
  self._spiritAddBtn:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._interactDialog = DialogManager.GetDialog("activity.swimsuit.interactdialog")
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSGetSummerConstructionUpdateList, Common.n_SGetSummerConstructionUpdateList, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateSummerMissions, Common.n_SUpdateSummerMissions, nil)
  LuaNotificationCenter.AddObserver(self, self.OnHideDownPanel, Common.n_SHideDownPanel, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMaterials, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMaterials, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMaterials, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMaterials, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function SwimSuitMainDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._itemCellPanel._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    local dialog = DialogManager.GetDialog("activity.swimsuit.activitysummerbuybuildingtip")
    if dialog and not dialog:IsRectangleContainsScreenPoint(args) then
      LuaNotificationCenter.PostNotification(Common.n_SHideDownPanel, nil, nil)
    end
  end
end

function SwimSuitMainDialog:IsRectangleContainsScreenPoint(args)
  return UIManager.RectangleContainsScreenPoint(self._itemCellPanel._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y)
end

function SwimSuitMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  if self._taskFrame then
    self._taskFrame:Destroy()
  end
  if self._charUpFrame then
    self._charUpFrame:Destroy()
  end
  for _, dialogName in pairs(ChildDialogs) do
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._eventIconCells then
    for i, v in ipairs(self._eventIconCells) do
      v.dialog:Destroy()
      v.dialog:RootWindowDestroy()
    end
  end
  DialogManager.DestroySingletonDialog("activity.swimsuit.xiguabattleselectdialog")
  DialogManager.DestroySingletonDialog("activity.swimsuit.maskdialog")
  DialogManager.DestroySingletonDialog("activity.swimsuit.swimsuitfoodstallsdialog")
  DialogManager.DestroySingletonDialog("activity.swimsuit.shopmaindialog")
end

function SwimSuitMainDialog:Init(sceneController)
  self._sceneController = sceneController
  for i, v in ipairs(self._materials) do
    local item = Item.Create(MaterialsId[i])
    v.img:SetSprite(item:GetIconAB())
    v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(MaterialsId[i]))
  end
  self._timeProgress = self._bm:GetTimeProgress()
  self._timeProgressMax = self._bm:GetTimeProgressMax()
  self._ringDay:SetActive(self._bm:IsDayTime())
  self._ringNigh:SetActive(not self._bm:IsDayTime())
  self._CharUp:SetActive(not self._bm:IsDayTime())
  self._sunImg:SetActive(self._bm:IsDayTime())
  self._moonImg:SetActive(not self._bm:IsDayTime())
  for i, v in ipairs(self._nightcurrency) do
    v.panel:SetActive(not self._bm:IsDayTime())
  end
  self._timeTipsback:SetActive(self._timeProgress >= self._timeProgressMax)
  self._timeTipsEffect:SetActive(self._timeProgress >= self._timeProgressMax)
  if not self._bm:IsDayTime() then
    self._tipText:SetText(TextManager.GetText(701416))
    if self._timeProgress == 0 or self._timeProgressMax == 0 then
      self._ringNigh:SetFillAmount(0)
    else
      self._ringNigh:SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
    end
    self._charUpData = {}
    local allIds = CEventBoostRole:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CEventBoostRole:GetRecorder(allIds[i])
      if record.eventid == DataCommon.Activities.SwimSuit then
        table.insert(self._charUpData, record)
      end
    end
    table.sort(self._charUpData, function(a, b)
      return a.sort < b.sort
    end)
    self._charUpFrame:ReloadAllCell()
    for i, v in ipairs(self._nightcurrency) do
      local item = Item.Create(NightCurrencyId[i])
      v.img:SetSprite(item:GetIconAB())
      v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(NightCurrencyId[i]))
    end
  else
    if self._timeProgress == 0 or self._timeProgressMax == 0 then
      self._ringDay:SetFillAmount(0)
    else
      self._ringDay:SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
    end
    self._tipText:SetText(TextManager.GetText(701415))
  end
  self._taskData = {}
  local taskData = self._bm:GetMissions()
  for i, v in ipairs(taskData) do
    table.insert(self._taskData, v)
  end
  self._taskTitle:SetActive(0 < #self._taskData)
  self._taskFrame:ReloadAllCell()
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
  self._spiritRedDot:SetActive(self:HaveSpiritItemSoonExpire())
  local state = self._bm:GetState()
  local perState = self._bm:GetPreState()
  if perState then
    if perState == 8 and state == 9 then
      local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitnextopendialog")
      dialog:Init(CStringres:GetRecorder(1613).msgTextID, nil, function()
      end)
    end
    if perState == 10 and state == 11 then
      local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitnextopendialog")
      dialog:Init(CStringres:GetRecorder(1614).msgTextID, nil, function()
      end)
    end
  end
  self._shopBtn:SetActive(self._bm:CanBuyBuildings())
  local time = ServerGameTimer.GetServerTime()
  local endtime = timeutils.GetConfigFormatTimeStamp(CHexagonScene:GetRecorder(9001).functionEndTime)
  local limit = endtime - time
  if limit < 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100396)
  end
end

function SwimSuitMainDialog:RefreshMaterials(notification)
  for i, v in ipairs(self._materials) do
    v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(MaterialsId[i]))
  end
  if not self._bm:IsDayTime() then
    for i, v in ipairs(self._nightcurrency) do
      v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(NightCurrencyId[i]))
    end
  end
end

function SwimSuitMainDialog:SetData(data)
  self._charUpData = {}
  self._taskData = {}
  self._shopData = {}
  self._buildingData = {}
end

function SwimSuitMainDialog:OnHideDownPanel()
  self._state = STATE.Main
  self._mainPanel:SetActive(true)
  self._downPanel:SetActive(false)
  self._panelDIY:SetActive(false)
  self._shopBtn:SetActive(#self._shopData ~= 0)
  self._interactDialog:OnExitDIYMode()
  local dialog = DialogManager.GetDialog("activity.swimsuit.activitysummerbuybuildingtip")
  if dialog then
    dialog:Destroy()
  end
end

function SwimSuitMainDialog:OnBackBtnClicked()
  if self._state == STATE.Main then
    GlobalGameFSM:SetNumber("sceneLoadingId", 30001)
  elseif self._state == STATE.DIY then
    self._state = STATE.Main
    self._mainPanel:SetActive(true)
    self._downPanel:SetActive(false)
    self._panelDIY:SetActive(false)
    self._interactDialog:OnExitDIYMode()
  elseif self._state == STATE.Shop then
    self._state = STATE.Main
    self._mainPanel:SetActive(true)
    self._downPanel:SetActive(false)
    self._panelDIY:SetActive(false)
    self._shopBtn:SetActive(#self._shopData ~= 0)
    self._interactDialog:OnExitDIYMode()
    local dialog = DialogManager.GetDialog("activity.swimsuit.activitysummerbuybuildingtip")
    if dialog then
      dialog:Destroy()
    end
  end
end

function SwimSuitMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function SwimSuitMainDialog:OnTimeChangeBtnClicked()
  if self._timeProgress >= self._timeProgressMax then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cchangesummeractivitytime")
    csend:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100391)
  end
end

function SwimSuitMainDialog:OnDIYBtnClicked()
  self._state = STATE.DIY
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetsummerconstructionupdatelist")
  csend:Send()
end

function SwimSuitMainDialog:OnShopBtnClicked()
  if self._state == STATE.Shop then
    self:OnBackBtnClicked()
    return
  end
  self._state = STATE.Shop
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetsummerconstructionupdatelist")
  csend:Send()
end

function SwimSuitMainDialog:OnSGetSummerConstructionUpdateList()
  if self._state == STATE.DIY then
    self._downPanel:SetActive(true)
    self._panelDIY:SetActive(true)
    self._diyselect:SetActive(false)
    self._interactDialog:OnEnterDIYMode()
    self._sceneController:SetSelectBlock(0)
    self._buildingData = {}
    local ids = self._bm:GetStorageConstructionList()
    for i, v in ipairs(ids) do
      local temp = {
        tag = "DIY",
        id = v,
        used = false
      }
      table.insert(self._buildingData, temp)
    end
    local constructions = self._bm:GetConstructions()
    for i, v in ipairs(constructions) do
      local temp = {
        tag = "DIY",
        id = v.ID,
        used = true
      }
      table.insert(self._buildingData, temp)
    end
    self._itemFrame:ReloadAllCell()
    local totalWidth = self._itemFrame:GetTotalLength()
    self._itemCellPanel:SetWidth(self._itemCellPanelanchorX, totalWidth)
    self._downBack:SetWidth(self._itemCellPanelanchorX, totalWidth)
  elseif self._state == STATE.Shop then
    self._downPanel:SetActive(true)
    self._panelDIY:SetActive(true)
    self._diyselect:SetActive(false)
    self._interactDialog:OnEnterDIYMode()
    self._shopData = {}
    local ids = self._bm:GetShopConstructionList()
    for i, v in ipairs(ids) do
      local temp = {tag = "SHOP", id = v}
      table.insert(self._shopData, temp)
    end
    self._empty:SetActive(#self._shopData == 0)
    self._itemFrame:ReloadAllCell()
    local totalWidth = self._itemFrame:GetTotalLength()
    self._itemCellPanel:SetWidth(self._itemCellPanelanchorX, totalWidth)
    self._downBack:SetWidth(self._itemCellPanelanchorX, totalWidth)
  end
end

function SwimSuitMainDialog:OnSUpdateSummerConstruction(notification)
  local protocol = notification.userInfo
  if protocol.construction.level == 1 then
    for i, v in ipairs(self._shopData) do
      if v.id == protocol.construction.ID then
        table.remove(self._shopData, i)
        break
      end
    end
    self:OnShopBtnClicked()
  end
  if protocol.construction.level > 1 and (protocol.construction.ID == 12 or protocol.construction.ID == 9) then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.levelupresultdialog")
    dialog:SetData({
      level = protocol.construction.level,
      ID = protocol.construction.ID
    })
  end
end

function SwimSuitMainDialog:OnSUpdateSummerMissions()
  self._timeProgress = self._bm:GetTimeProgress()
  self._timeProgressMax = self._bm:GetTimeProgressMax()
  self._timeTipsback:SetActive(self._timeProgress >= self._timeProgressMax)
  self._timeTipsEffect:SetActive(self._timeProgress >= self._timeProgressMax)
  if self._bm:IsDayTime() then
    if self._timeProgress == 0 or self._timeProgressMax == 0 then
      self._ringDay:SetFillAmount(0)
    else
      self._ringDay:SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
    end
  elseif self._timeProgress == 0 or self._timeProgressMax == 0 then
    self._ringNigh:SetFillAmount(0)
  else
    self._ringNigh:SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
  end
  self._taskData = {}
  local taskData = self._bm:GetMissions()
  for i, v in ipairs(taskData) do
    table.insert(self._taskData, v)
  end
  self._taskFrame:ReloadAllCell()
end

function SwimSuitMainDialog:OnBuildingCellClick(blockId)
  if self._state == STATE.DIY then
    local coordinate = self._sceneController:GetBlockDefaultCoordinate(blockId)
    if coordinate then
      local csend = LuaNetManager.CreateProtocol("protocol.activity.cmovesummerconstruction")
      csend.construction = blockId
      csend.vertical = coordinate.y
      csend.abscissa = coordinate.x
      csend:Send()
    else
      LogError("SwimSuitMainDialog", "地图上没有位置了！")
    end
  elseif self._state == STATE.Shop then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.activitysummerbuybuildingtip")
    dialog:SetData(blockId)
    self._itemFrame:FireEvent("ChangedSelected", blockId)
  end
end

function SwimSuitMainDialog:OnBuildingCellReduceClick(blockId)
  if self._state == STATE.DIY then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cmovesummerconstruction")
    csend.construction = blockId
    csend.vertical = 999
    csend.abscissa = 999
    csend:Send()
  end
end

function SwimSuitMainDialog:UpdateConstructionEvent()
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
    local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._eventIconPanel._uiObject, UIManager.WorldToScreenPointInMargin("Main", worldPos.x, worldPos.y, worldPos.z))
    local dialog = DialogManager.CreateDialog("activity.swimsuit.swimsuiteventiconcell", self._eventIconPanel._uiObject)
    dialog:RefreshCell(v, self)
    dialog._rootWindow:SetAnchoredPosition(posX, posY)
    local temp = {worldPos = worldPos, dialog = dialog}
    table.insert(self._eventIconCells, temp)
  end
end

function SwimSuitMainDialog:UpdateEventIconPosition()
  for i, v in ipairs(self._eventIconCells) do
    if not v.dialog___closed then
      local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._eventIconPanel._uiObject, UIManager.WorldToScreenPointInMargin("Main", v.worldPos.x, v.worldPos.y, v.worldPos.z))
      v.dialog._rootWindow:SetAnchoredPosition(posX, posY)
    end
  end
end

function SwimSuitMainDialog:OnEventIconClick(blockID)
  if self._state == STATE.DIY or self._state == STATE.Shop then
    return
  end
  self._sceneController:SelectBlock(blockID)
  self._bm:OnBlockClick(blockID)
end

function SwimSuitMainDialog:OnTaskCellClick(taskID)
  if self._state == STATE.DIY or self._state == STATE.Shop then
    return
  end
  local recorder = CSwimDailyMission:GetRecorder(taskID)
  local blockID = recorder.landID
  if recorder.jumpType == 1 then
    if self._sceneController._mainLineBlockID and self._bm:BlockHasEvent(self._sceneController._mainLineBlockID) then
      self._sceneController:SelectBlock(self._sceneController._mainLineBlockID)
      self._bm:OnBlockClick(self._sceneController._mainLineBlockID)
    end
  elseif recorder.jumpType == 2 then
    local block = self._sceneController:GetBlocks()[blockID]
    if block and self._bm:BlockHasEvent(blockID) then
      self._sceneController:SelectBlock(blockID)
      self._bm:OnBlockClick(blockID)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(recorder.message)
    end
  elseif recorder.jumpType == 3 then
    if not self._bm:BlockHasEvent(blockID) then
      NekoData.BehaviorManager.BM_Message:SendMessageById(recorder.message)
    else
      self._sceneController:SelectBlock(blockID)
      self._bm:OnBlockClick(blockID)
    end
  elseif recorder.jumpType == 4 and self._bm:BlockHasEvent(blockID) then
    self._sceneController:SelectBlock(blockID)
    self._bm:OnBlockClick(blockID)
  end
end

function SwimSuitMainDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    if self._state == STATE.DIY then
      return #self._buildingData
    elseif self._state == STATE.Shop then
      return #self._shopData
    end
  elseif frame == self._taskFrame then
    return #self._taskData
  elseif frame == self._charUpFrame then
    return #self._charUpData
  end
end

function SwimSuitMainDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    if self._state == STATE.DIY then
      return "activity.swimsuit.swimsuitmainbuildingcell"
    elseif self._state == STATE.Shop then
      return "activity.swimsuit.swimsuitmainbuildingcell"
    end
  elseif frame == self._taskFrame then
    return "activity.swimsuit.swimsuitmaintaskcell"
  elseif frame == self._charUpFrame then
    return "activity.swimsuit.swimsuitmaincharcell"
  end
end

function SwimSuitMainDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    if self._state == STATE.DIY then
      return self._buildingData[index]
    elseif self._state == STATE.Shop then
      return self._shopData[index]
    end
  elseif frame == self._taskFrame then
    return self._taskData[index]
  elseif frame == self._charUpFrame then
    return self._charUpData[index]
  end
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

function SwimSuitMainDialog:OnMaterialClick(index)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(MaterialsId[index])
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function SwimSuitMainDialog:OnNightCurrencyClick(index)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(NightCurrencyId[index])
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function SwimSuitMainDialog:PrintCoordinates()
  self._sceneController:LogAllBlocksCoordinateInfo()
end

function SwimSuitMainDialog:OnCurPosChange(frame, proportion)
  local width, height = self._taskCellPanel:GetRectSize()
  local total = self._taskFrame:GetTotalLength()
  if height < total then
    self._taksFrameScrollBar:SetScrollSize(height / total)
    self._taksFrameScrollBar:SetScrollValue(proportion)
  else
    self._taksFrameScrollBar:SetScrollSize(1)
    self._taksFrameScrollBar:SetScrollValue(proportion)
  end
end

return SwimSuitMainDialog
