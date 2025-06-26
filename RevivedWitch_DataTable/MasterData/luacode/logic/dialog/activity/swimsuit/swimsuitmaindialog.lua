-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local STATE = {Main = 1, Shop = 2, DIY = 3}
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local HexagonalBlock = require("logic.manager.experimental.types.hexagonalblock")
local Item = require("logic.manager.experimental.types.item")
local timeutils = require("logic.utils.timeutils")
local CHexagonScene = (BeanManager.GetTableByName)("activity.chexagonscene")
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSwimDailyMission = (BeanManager.GetTableByName)("activity.cswimdailymission")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local MaterialsId = {DataCommon.SwimSuitWood, DataCommon.SwimSuitSand, DataCommon.SwimSuitStone}
local NightCurrencyId = {DataCommon.SwimSuitCoinConch, DataCommon.SwimSuitCoinPearl, DataCommon.SwimSuitCoinCoral}
local ChildDialogs = {"activity.swimsuit.buydialog", "activity.swimsuit.showdialog", "activity.swimsuit.xiguadialog", "activity.swimsuit.activitysummerbuybuildingtip", "activity.swimsuit.swimsuitstorybranchdialog", "activity.swimsuit.swimsuitstorymiandialog", "activity.swimsuit.swimsuitbattledialog", "activity.swimsuit.swimsuitstorybattledialog", "bag.spiritrecoverdialog"}
local MillisecondToDay = 86400000
local SwimSuitMainDialog = class("SwimSuitMainDialog", Dialog)
SwimSuitMainDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainDialog.AssetName = "ActivitySummerMain"
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(64, 1) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(64)
  end
end

local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV, FinishGuide
  local guideId = (notification.userInfo).guideID
  if guideId == 64 and (notification.userInfo).guideStatus == "Start" then
    (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

SwimSuitMainDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : SwimSuitMainDialog, STATE
  ((SwimSuitMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._state = STATE.Main
end

SwimSuitMainDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : TableFrame, _ENV, HandleGuideStatusChanged
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._shopBtn = self:GetChild("ShopBtn")
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._diyBtn = self:GetChild("RankBtn")
  ;
  (self._diyBtn):Subscribe_PointerClickEvent(self.OnDIYBtnClicked, self)
  self._downPanel = self:GetChild("Down")
  self._downBack = self:GetChild("Down/DownBack")
  self._itemCellPanel = self:GetChild("Down/ItemFrame")
  self._itemCellPanelanchorX = (self._itemCellPanel):GetHeight()
  self._itemFrame = (TableFrame.Create)(self._itemCellPanel, self, false, false)
  self._empty = self:GetChild("Down/Empty")
  ;
  (self._downPanel):SetActive(false)
  ;
  (self._diyBtn):SetActive(false)
  self._panelDIY = self:GetChild("PanelDIY")
  ;
  (self._panelDIY):SetActive(false)
  self._noBtn = self:GetChild("PanelDIY/Select/NoBtn")
  self._yesBtn = self:GetChild("PanelDIY/Select/YesBtn")
  self._diyTitle = self:GetChild("PanelDIY/Title")
  ;
  (self._diyTitle):SetActive(false)
  self._diyselect = self:GetChild("PanelDIY/Select")
  self._anchorX = (self._diyselect):GetSize()
  ;
  (self._noBtn):Subscribe_PointerClickEvent(self.OnNoBtnClicked, self)
  ;
  (self._yesBtn):Subscribe_PointerClickEvent(self.OnYesBtnClicked, self)
  self._mainPanel = self:GetChild("Panel")
  self._CharUp = self:GetChild("Panel/CharUp")
  self._charUpCellPanel = self:GetChild("Panel/CharUp/CharFrame")
  self._charUpFrame = (TableFrame.Create)(self._charUpCellPanel, self, false, false)
  self._materials = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC144: Confused about usage of register: R5 in 'UnsetPending'

      (self._materials)[i] = {}
      -- DECOMPILER ERROR at PC153: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._materials)[i]).back = self:GetChild("Panel/Material/Material" .. i .. "/back")
      ;
      (((self._materials)[i]).back):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_0 , upvalues : self, i
    self:OnMaterialClick(i)
  end
, self)
      -- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._materials)[i]).img = self:GetChild("Panel/Material/Material" .. i .. "/Image")
      -- DECOMPILER ERROR at PC178: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._materials)[i]).name = self:GetChild("Panel/Material/Material" .. i .. "/Text")
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._materials)[i]).count = self:GetChild("Panel/Material/Material" .. i .. "/Num")
    end
  end
  self._taskTitle = self:GetChild("Panel/Task")
  self._taskCellPanel = self:GetChild("Panel/Task/Frame")
  self._taskFrame = (TableFrame.Create)(self._taskCellPanel, self, true, true)
  self._taksFrameScrollBar = self:GetChild("Panel/Task/Frame/Scrollbar")
  self._ringDay = self:GetChild("Panel/Time/ChangeBtn/RingMask/RingDay")
  self._ringNigh = self:GetChild("Panel/Time/ChangeBtn/RingMask/RingNigh")
  self._timeChangeBtn = self:GetChild("Panel/Time/ChangeBtn")
  self._sunImg = self:GetChild("Panel/Time/ChangeBtn/Sun")
  self._moonImg = self:GetChild("Panel/Time/ChangeBtn/Moon")
  ;
  (self._timeChangeBtn):Subscribe_PointerClickEvent(self.OnTimeChangeBtnClicked, self)
  self._timeImg = self:GetChild("Panel/Time/ChangeBtn/RingMask/RingDay")
  self._timeTipsback = self:GetChild("Panel/Time/Tipsback")
  self._tipText = self:GetChild("Panel/Time/Tipsback/Text")
  self._timeTipsEffect = self:GetChild("UI_TX_Prefab_GuideClick_alone")
  self._coordinateOutPutBtn = self:GetChild("coordinate")
  ;
  (self._coordinateOutPutBtn):SetActive((((CS.PixelNeko).LuaManager).IsUnityEditor)())
  ;
  (self._coordinateOutPutBtn):Subscribe_PointerClickEvent(self.PrintCoordinates, self)
  self._eventIconPanel = self:GetChild("EventIconPanel")
  self._spiritNum = self:GetChild("Num0/Text")
  self._spiritAddBtn = self:GetChild("Num0/Add")
  self._spiritRedDot = self:GetChild("Num0/RedDot")
  self._nightcurrency = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC291: Confused about usage of register: R5 in 'UnsetPending'

    (self._nightcurrency)[i] = {}
    -- DECOMPILER ERROR at PC299: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nightcurrency)[i]).panel = self:GetChild("Num" .. i)
    -- DECOMPILER ERROR at PC308: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nightcurrency)[i]).count = self:GetChild("Num" .. i .. "/Text")
    -- DECOMPILER ERROR at PC317: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nightcurrency)[i]).img = self:GetChild("Num" .. i .. "/Icon")
    -- DECOMPILER ERROR at PC326: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nightcurrency)[i]).add = self:GetChild("Num" .. i .. "/Add")
    -- DECOMPILER ERROR at PC335: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nightcurrency)[i]).add1 = self:GetChild("Num" .. i .. "/Add (1)")
    -- DECOMPILER ERROR at PC344: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nightcurrency)[i]).redDot = self:GetChild("Num" .. i .. "/RedDot")
    ;
    (((self._nightcurrency)[i]).redDot):SetActive(false)
    ;
    (((self._nightcurrency)[i]).add):SetActive(false)
    ;
    (((self._nightcurrency)[i]).add1):SetActive(false)
    ;
    (((self._nightcurrency)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_1 , upvalues : self, i
    self:OnNightCurrencyClick(i)
  end
)
  end
  ;
  (self._spiritAddBtn):Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._interactDialog = (DialogManager.GetDialog)("activity.swimsuit.interactdialog")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSGetSummerConstructionUpdateList, Common.n_SGetSummerConstructionUpdateList, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateSummerMissions, Common.n_SUpdateSummerMissions, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMaterials, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMaterials, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMaterials, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshMaterials, Common.n_RefreshCurrency, nil)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

SwimSuitMainDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV, ChildDialogs
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  if self._taskFrame then
    (self._taskFrame):Destroy()
  end
  if self._charUpFrame then
    (self._charUpFrame):Destroy()
  end
  for _,dialogName in pairs(ChildDialogs) do
    local dialog = (DialogManager.GetDialog)(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._eventIconCells then
    for i,v in ipairs(self._eventIconCells) do
      (v.dialog):Destroy()
      ;
      (v.dialog):RootWindowDestroy()
    end
  end
  do
    ;
    (DialogManager.DestroySingletonDialog)("activity.swimsuit.xiguabattleselectdialog")
    ;
    (DialogManager.DestroySingletonDialog)("activity.swimsuit.maskdialog")
    ;
    (DialogManager.DestroySingletonDialog)("activity.swimsuit.swimsuitfoodstallsdialog")
    ;
    (DialogManager.DestroySingletonDialog)("activity.swimsuit.shopmaindialog")
  end
end

SwimSuitMainDialog.Init = function(self, sceneController)
  -- function num : 0_5 , upvalues : _ENV, Item, MaterialsId, CEventBoostRole, NightCurrencyId, CStringres, timeutils, CHexagonScene
  self._sceneController = sceneController
  for i,v in ipairs(self._materials) do
    local item = (Item.Create)(MaterialsId[i])
    ;
    (v.img):SetSprite(item:GetIconAB())
    ;
    (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(MaterialsId[i]))
  end
  self._timeProgress = (self._bm):GetTimeProgress()
  self._timeProgressMax = (self._bm):GetTimeProgressMax()
  ;
  (self._ringDay):SetActive((self._bm):IsDayTime())
  ;
  (self._ringNigh):SetActive(not (self._bm):IsDayTime())
  ;
  (self._CharUp):SetActive(not (self._bm):IsDayTime())
  ;
  (self._sunImg):SetActive((self._bm):IsDayTime())
  ;
  (self._moonImg):SetActive(not (self._bm):IsDayTime())
  for i,v in ipairs(self._nightcurrency) do
    (v.panel):SetActive(not (self._bm):IsDayTime())
  end
  ;
  (self._timeTipsback):SetActive(self._timeProgressMax <= self._timeProgress)
  ;
  (self._timeTipsEffect):SetActive(self._timeProgressMax <= self._timeProgress)
  if not (self._bm):IsDayTime() then
    (self._tipText):SetText((TextManager.GetText)(701416))
    if self._timeProgress == 0 or self._timeProgressMax == 0 then
      (self._ringNigh):SetFillAmount(0)
    else
      (self._ringNigh):SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
    end
    self._charUpData = {}
    local allIds = CEventBoostRole:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CEventBoostRole:GetRecorder(allIds[i])
      if record.eventid == (DataCommon.Activities).SwimSuit then
        (table.insert)(self._charUpData, record)
      end
    end
    ;
    (table.sort)(self._charUpData, function(a, b)
    -- function num : 0_5_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self._charUpFrame):ReloadAllCell()
    for i,v in ipairs(self._nightcurrency) do
      local item = (Item.Create)(NightCurrencyId[i])
      ;
      (v.img):SetSprite(item:GetIconAB())
      ;
      (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(NightCurrencyId[i]))
    end
  else
    if self._timeProgress == 0 or self._timeProgressMax == 0 then
      (self._ringDay):SetFillAmount(0)
    else
      (self._ringDay):SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
    end
    ;
    (self._tipText):SetText((TextManager.GetText)(701415))
  end
  self._taskData = {}
  local taskData = (self._bm):GetMissions()
  for i,v in ipairs(taskData) do
    (table.insert)(self._taskData, v)
  end
  ;
  (self._taskTitle):SetActive(#self._taskData > 0)
  ;
  (self._taskFrame):ReloadAllCell()
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
  ;
  (self._spiritRedDot):SetActive(self:HaveSpiritItemSoonExpire())
  local state = (self._bm):GetState()
  local perState = (self._bm):GetPreState()
  if perState then
    do
      if perState == 8 and state == 9 then
        local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitnextopendialog")
        dialog:Init((CStringres:GetRecorder(1613)).msgTextID, nil, function()
    -- function num : 0_5_1
  end
)
      end
      do
        if perState == 10 and state == 11 then
          local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitnextopendialog")
          dialog:Init((CStringres:GetRecorder(1614)).msgTextID, nil, function()
    -- function num : 0_5_2
  end
)
        end
        ;
        (self._shopBtn):SetActive((self._bm):CanBuyBuildings())
        local time = (ServerGameTimer.GetServerTime)()
        local endtime = (timeutils.GetConfigFormatTimeStamp)((CHexagonScene:GetRecorder(9001)).functionEndTime)
        local limit = endtime - time
        if limit < 0 then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100396)
        end
        -- DECOMPILER ERROR: 17 unprocessed JMP targets
      end
    end
  end
end

SwimSuitMainDialog.RefreshMaterials = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV, MaterialsId, NightCurrencyId
  for i,v in ipairs(self._materials) do
    (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(MaterialsId[i]))
  end
  if not (self._bm):IsDayTime() then
    for i,v in ipairs(self._nightcurrency) do
      (v.count):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(NightCurrencyId[i]))
    end
  end
end

SwimSuitMainDialog.SetData = function(self, data)
  -- function num : 0_7
  self._charUpData = {}
  self._taskData = {}
  self._shopData = {}
  self._buildingData = {}
end

SwimSuitMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8 , upvalues : STATE, _ENV
  if self._state == STATE.Main then
    GlobalGameFSM:SetNumber("sceneLoadingId", 30001)
  else
    if self._state == STATE.DIY then
      self._state = STATE.Main
      ;
      (self._mainPanel):SetActive(true)
      ;
      (self._downPanel):SetActive(false)
      ;
      (self._panelDIY):SetActive(false)
      ;
      (self._interactDialog):OnExitDIYMode()
    else
      if self._state == STATE.Shop then
        self._state = STATE.Main
        ;
        (self._mainPanel):SetActive(true)
        ;
        (self._downPanel):SetActive(false)
        ;
        (self._panelDIY):SetActive(false)
        ;
        (self._shopBtn):SetActive(#self._shopData ~= 0)
        ;
        (self._interactDialog):OnExitDIYMode()
        local dialog = (DialogManager.GetDialog)("activity.swimsuit.activitysummerbuybuildingtip")
        if dialog then
          dialog:Destroy()
        end
      end
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SwimSuitMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

SwimSuitMainDialog.OnTimeChangeBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self._timeProgressMax <= self._timeProgress then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchangesummeractivitytime")
    csend:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100391)
    end
  end
end

SwimSuitMainDialog.OnDIYBtnClicked = function(self)
  -- function num : 0_11 , upvalues : STATE, _ENV
  self._state = STATE.DIY
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cgetsummerconstructionupdatelist")
  csend:Send()
end

SwimSuitMainDialog.OnShopBtnClicked = function(self)
  -- function num : 0_12 , upvalues : STATE, _ENV
  if self._state == STATE.Shop then
    self:OnBackBtnClicked()
    return 
  end
  self._state = STATE.Shop
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cgetsummerconstructionupdatelist")
  csend:Send()
end

SwimSuitMainDialog.OnSGetSummerConstructionUpdateList = function(self)
  -- function num : 0_13 , upvalues : STATE, _ENV
  if self._state == STATE.DIY then
    (self._downPanel):SetActive(true)
    ;
    (self._panelDIY):SetActive(true)
    ;
    (self._diyselect):SetActive(false)
    ;
    (self._interactDialog):OnEnterDIYMode()
    ;
    (self._sceneController):SetSelectBlock(0)
    self._buildingData = {}
    local ids = (self._bm):GetStorageConstructionList()
    for i,v in ipairs(ids) do
      local temp = {tag = "DIY", id = v, used = false}
      ;
      (table.insert)(self._buildingData, temp)
    end
    local constructions = (self._bm):GetConstructions()
    for i,v in ipairs(constructions) do
      local temp = {tag = "DIY", id = v.ID, used = true}
      ;
      (table.insert)(self._buildingData, temp)
    end
    ;
    (self._itemFrame):ReloadAllCell()
    local totalWidth = (self._itemFrame):GetTotalLength()
    ;
    (self._itemCellPanel):SetWidth(self._itemCellPanelanchorX, totalWidth)
    ;
    (self._downBack):SetWidth(self._itemCellPanelanchorX, totalWidth)
  else
    do
      if self._state == STATE.Shop then
        (self._downPanel):SetActive(true)
        ;
        (self._panelDIY):SetActive(true)
        ;
        (self._diyselect):SetActive(false)
        ;
        (self._interactDialog):OnEnterDIYMode()
        self._shopData = {}
        local ids = (self._bm):GetShopConstructionList()
        for i,v in ipairs(ids) do
          local temp = {tag = "SHOP", id = v}
          ;
          (table.insert)(self._shopData, temp)
        end
        ;
        (self._empty):SetActive(#self._shopData == 0)
        ;
        (self._itemFrame):ReloadAllCell()
        local totalWidth = (self._itemFrame):GetTotalLength()
        ;
        (self._itemCellPanel):SetWidth(self._itemCellPanelanchorX, totalWidth)
        ;
        (self._downBack):SetWidth(self._itemCellPanelanchorX, totalWidth)
      end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

SwimSuitMainDialog.OnSUpdateSummerConstruction = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV
  local protocol = notification.userInfo
  if (protocol.construction).level == 1 then
    for i,v in ipairs(self._shopData) do
      if v.id == (protocol.construction).ID then
        (table.remove)(self._shopData, i)
        break
      end
    end
    do
      self:OnShopBtnClicked()
      if (protocol.construction).level > 1 and ((protocol.construction).ID == 12 or (protocol.construction).ID == 9) then
        local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.levelupresultdialog")
        dialog:SetData({level = (protocol.construction).level, ID = (protocol.construction).ID})
      end
    end
  end
end

SwimSuitMainDialog.OnSUpdateSummerMissions = function(self)
  -- function num : 0_15 , upvalues : _ENV
  self._timeProgress = (self._bm):GetTimeProgress()
  self._timeProgressMax = (self._bm):GetTimeProgressMax()
  ;
  (self._timeTipsback):SetActive(self._timeProgressMax <= self._timeProgress)
  ;
  (self._timeTipsEffect):SetActive(self._timeProgressMax <= self._timeProgress)
  if (self._bm):IsDayTime() then
    if self._timeProgress == 0 or self._timeProgressMax == 0 then
      (self._ringDay):SetFillAmount(0)
    else
      (self._ringDay):SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
    end
  elseif self._timeProgress == 0 or self._timeProgressMax == 0 then
    (self._ringNigh):SetFillAmount(0)
  else
    (self._ringNigh):SetFillAmount(self._timeProgress / self._timeProgressMax / 2)
  end
  self._taskData = {}
  local taskData = (self._bm):GetMissions()
  for i,v in ipairs(taskData) do
    (table.insert)(self._taskData, v)
  end
  ;
  (self._taskFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

SwimSuitMainDialog.OnBuildingCellClick = function(self, blockId)
  -- function num : 0_16 , upvalues : STATE, _ENV
  if self._state == STATE.DIY then
    local coordinate = (self._sceneController):GetBlockDefaultCoordinate(blockId)
    if coordinate then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cmovesummerconstruction")
      csend.construction = blockId
      csend.vertical = coordinate.y
      csend.abscissa = coordinate.x
      csend:Send()
    else
      do
        do
          LogError("SwimSuitMainDialog", "地图上没有位置了！")
          if self._state == STATE.Shop then
            local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.activitysummerbuybuildingtip")
            dialog:SetData(blockId)
            ;
            (self._itemFrame):FireEvent("ChangedSelected", blockId)
          end
        end
      end
    end
  end
end

SwimSuitMainDialog.OnBuildingCellReduceClick = function(self, blockId)
  -- function num : 0_17 , upvalues : STATE, _ENV
  if self._state == STATE.DIY then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cmovesummerconstruction")
    csend.construction = blockId
    csend.vertical = 999
    csend.abscissa = 999
    csend:Send()
  end
end

SwimSuitMainDialog.UpdateConstructionEvent = function(self)
  -- function num : 0_18 , upvalues : _ENV, UIManager
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
      local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)((self._eventIconPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("Main", worldPos.x, worldPos.y, worldPos.z))
      local dialog = (DialogManager.CreateDialog)("activity.swimsuit.swimsuiteventiconcell", (self._eventIconPanel)._uiObject)
      dialog:RefreshCell(v, self)
      ;
      (dialog._rootWindow):SetAnchoredPosition(posX, posY)
      local temp = {worldPos = worldPos, dialog = dialog}
      ;
      (table.insert)(self._eventIconCells, temp)
    end
  end
end

SwimSuitMainDialog.UpdateEventIconPosition = function(self)
  -- function num : 0_19 , upvalues : _ENV, UIManager
  for i,v in ipairs(self._eventIconCells) do
    if not v.dialog___closed then
      local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)((self._eventIconPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("Main", (v.worldPos).x, (v.worldPos).y, (v.worldPos).z))
      ;
      ((v.dialog)._rootWindow):SetAnchoredPosition(posX, posY)
    end
  end
end

SwimSuitMainDialog.OnEventIconClick = function(self, blockID)
  -- function num : 0_20 , upvalues : STATE
  if self._state == STATE.DIY or self._state == STATE.Shop then
    return 
  end
  ;
  (self._sceneController):SelectBlock(blockID)
  ;
  (self._bm):OnBlockClick(blockID)
end

SwimSuitMainDialog.OnTaskCellClick = function(self, taskID)
  -- function num : 0_21 , upvalues : STATE, CSwimDailyMission, _ENV
  if self._state == STATE.DIY or self._state == STATE.Shop then
    return 
  end
  local recorder = CSwimDailyMission:GetRecorder(taskID)
  local blockID = recorder.landID
  if recorder.jumpType == 1 and (self._sceneController)._mainLineBlockID and (self._bm):BlockHasEvent((self._sceneController)._mainLineBlockID) then
    (self._sceneController):SelectBlock((self._sceneController)._mainLineBlockID)
    ;
    (self._bm):OnBlockClick((self._sceneController)._mainLineBlockID)
  end
  if recorder.jumpType == 2 then
    local block = ((self._sceneController):GetBlocks())[blockID]
    if block and (self._bm):BlockHasEvent(blockID) then
      (self._sceneController):SelectBlock(blockID)
      ;
      (self._bm):OnBlockClick(blockID)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(recorder.message)
    end
  else
    do
      if recorder.jumpType == 3 then
        if not (self._bm):BlockHasEvent(blockID) then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(recorder.message)
        else
          ;
          (self._sceneController):SelectBlock(blockID)
          ;
          (self._bm):OnBlockClick(blockID)
        end
      else
        if recorder.jumpType == 4 and (self._bm):BlockHasEvent(blockID) then
          (self._sceneController):SelectBlock(blockID)
          ;
          (self._bm):OnBlockClick(blockID)
        end
      end
    end
  end
end

SwimSuitMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_22 , upvalues : STATE
  if frame == self._itemFrame then
    if self._state == STATE.DIY then
      return #self._buildingData
    else
      if self._state == STATE.Shop then
        return #self._shopData
      end
    end
  else
    if frame == self._taskFrame then
      return #self._taskData
    else
      if frame == self._charUpFrame then
        return #self._charUpData
      end
    end
  end
end

SwimSuitMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_23 , upvalues : STATE
  if frame == self._itemFrame then
    if self._state == STATE.DIY then
      return "activity.swimsuit.swimsuitmainbuildingcell"
    else
      if self._state == STATE.Shop then
        return "activity.swimsuit.swimsuitmainbuildingcell"
      end
    end
  else
    if frame == self._taskFrame then
      return "activity.swimsuit.swimsuitmaintaskcell"
    else
      if frame == self._charUpFrame then
        return "activity.swimsuit.swimsuitmaincharcell"
      end
    end
  end
end

SwimSuitMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_24 , upvalues : STATE
  if frame == self._itemFrame then
    if self._state == STATE.DIY then
      return (self._buildingData)[index]
    else
      if self._state == STATE.Shop then
        return (self._shopData)[index]
      end
    end
  else
    if frame == self._taskFrame then
      return (self._taskData)[index]
    else
      if frame == self._charUpFrame then
        return (self._charUpData)[index]
      end
    end
  end
end

SwimSuitMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_25 , upvalues : _ENV, ChildDialogs
  if (table.contain)(ChildDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

SwimSuitMainDialog.OnSpiritAddBtnClick = function(self)
  -- function num : 0_26 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

SwimSuitMainDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_27 , upvalues : _ENV
  self._spirit = (notification.userInfo).spirit
  ;
  (self._spiritNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit))
end

SwimSuitMainDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_28 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

SwimSuitMainDialog.OnMaterialClick = function(self, index)
  -- function num : 0_29 , upvalues : _ENV, Item, MaterialsId
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(MaterialsId[index])})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

SwimSuitMainDialog.OnNightCurrencyClick = function(self, index)
  -- function num : 0_30 , upvalues : _ENV, Item, NightCurrencyId
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(NightCurrencyId[index])})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

SwimSuitMainDialog.PrintCoordinates = function(self)
  -- function num : 0_31
  (self._sceneController):LogAllBlocksCoordinateInfo()
end

SwimSuitMainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_32
  local width, height = (self._taskCellPanel):GetRectSize()
  local total = (self._taskFrame):GetTotalLength()
  if height < total then
    (self._taksFrameScrollBar):SetScrollSize(height / total)
    ;
    (self._taksFrameScrollBar):SetScrollValue(proportion)
  else
    ;
    (self._taksFrameScrollBar):SetScrollSize(1)
    ;
    (self._taksFrameScrollBar):SetScrollValue(proportion)
  end
end

return SwimSuitMainDialog

