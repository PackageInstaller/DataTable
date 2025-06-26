-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasbattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CHexagonBattleConfig = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local TableFrame = require("framework.ui.frame.table.tableframe")
local State = {Unlock = 1, PreconditionsNotMet = 2, Lock = 3}
local ChristmasBattleDialog = class("ChristmasBattleDialog", Dialog)
ChristmasBattleDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBattleDialog.AssetName = "ActivityChristmasbattle"
ChristmasBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasBattleDialog
  ((ChristmasBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ChristmasBattleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, CanvasStaticFunctions, _ENV
  self._unLock = self:GetChild("Lock")
  self._next = self:GetChild("Next")
  self._lock = self:GetChild("Unlock")
  self._buttonPanelBack = self:GetChild("frame1/Image")
  self._buttonPanel = self:GetChild("frame1")
  self._buttonFrame = (TableFrame.Create)(self._buttonPanel, self, true, false, true)
  self._goBtn = self:GetChild("Lock/Checkbtn")
  self._autoBtn = self:GetChild("Lock/Autobtn")
  self._levelUpBtn = self:GetChild("Unlock/Checkbtn")
  ;
  (self._levelUpBtn):Subscribe_PointerClickEvent(self.OnLevelUpBtnClicked, self)
  self._num = self:GetChild("Unlock/Num")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._autoBtn):Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  self._spiritNum = self:GetChild("Lock/LineBack/Num")
  self._leveltxt = self:GetChild("LevelTxt")
  self._levelnum = self:GetChild("Battlelevel/levelnum")
  self._nameText = self:GetChild("Name/text")
  self._ranknum = self:GetChild("Battlelevel/Ranknum")
  self._panel = self:GetChild("frame")
  self._frame = (TableFrame.Create)(self._panel, self, false)
  self._additionText = self:GetChild("Line/Text")
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (CanvasStaticFunctions.SetCanvasPixelPerfect)((self._rootWindow)._uiObject, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

ChristmasBattleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  if self._buttonFrame then
    (self._buttonFrame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChristmasBattleDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CInterfaceFunction, State
  self._functionIDs = data.functionIDs
  self._constructionID = data.constructionID
  self._locked = data.locked
  self._battlesData = {}
  ;
  (table.sort)(self._functionIDs, function(a, b)
    -- function num : 0_3_0 , upvalues : CInterfaceFunction
    local funectionRecorderA = CInterfaceFunction:GetRecorder(a)
    local funectionRecorderB = CInterfaceFunction:GetRecorder(b)
    do return funectionRecorderA.difficulty < funectionRecorderB.difficulty end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(self._locked, function(a, b)
    -- function num : 0_3_1 , upvalues : CInterfaceFunction
    local funectionRecorderA = CInterfaceFunction:GetRecorder(a)
    local funectionRecorderB = CInterfaceFunction:GetRecorder(b)
    do return funectionRecorderA.difficulty < funectionRecorderB.difficulty end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(self._functionIDs) do
    local temp = {functionID = v, state = State.Unlock, index = i}
    ;
    (table.insert)(self._battlesData, temp)
  end
  local count = #self._functionIDs
  for i,v in ipairs(self._locked) do
    if not (table.contain)(self._functionIDs, v) then
      count = count + 1
      local temp = {functionID = v, state = State.PreconditionsNotMet, index = count}
      ;
      (table.insert)(self._battlesData, temp)
    else
      do
        for j,k in ipairs(self._battlesData) do
          -- DECOMPILER ERROR at PC69: Confused about usage of register: R13 in 'UnsetPending'

          if k.functionID == v then
            ((self._battlesData)[j]).state = State.PreconditionsNotMet
          end
        end
        do
          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (self._buttonFrame):ReloadAllCell()
  self:OnButtonGroupClick(#self._functionIDs)
end

ChristmasBattleDialog.OnButtonGroupClick = function(self, index)
  -- function num : 0_4 , upvalues : State, CInterfaceFunction, _ENV, CHexagonBattleConfig, CRoleLevelCfgTable
  self._index = index
  ;
  (self._buttonFrame):FireEvent("ChangedSelected", index)
  local data = (self._battlesData)[index]
  ;
  (self._unLock):SetActive(data.state == State.Unlock)
  ;
  (self._next):SetActive(data.state == State.PreconditionsNotMet)
  ;
  (self._lock):SetActive(data.state == State.Lock)
  local funectionRecorder = CInterfaceFunction:GetRecorder(data.functionID)
  if not funectionRecorder then
    LogErrorFormat("ChristmasBattleDialog", "CInterfaceFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return 
  end
  ;
  (self._autoBtn):SetInteractable((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):HasFinishBlockBattle(self._constructionID, data.functionID))
  local battleID = funectionRecorder.battleID
  if battleID ~= 0 then
    self._battleRecorder = CHexagonBattleConfig:GetRecorder(battleID)
    ;
    (self._nameText):SetText((TextManager.GetText)((self._battleRecorder).leveltitle))
    if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < (self._battleRecorder).spirit then
      (self._spiritNum):SetText((self._battleRecorder).spirit)
    else
      (self._spiritNum):SetText((self._battleRecorder).spirit)
    end
    ;
    (self._leveltxt):SetText((TextManager.GetText)((self._battleRecorder).levelinfo))
    local clientBreakLevel = (CRoleLevelCfgTable:GetRecorder((self._battleRecorder).suggestlevel)).clientBreakLevel
    local clientLevel = (CRoleLevelCfgTable:GetRecorder((self._battleRecorder).suggestlevel)).clientLevel
    ;
    (self._levelnum):SetText(clientLevel)
    ;
    (self._ranknum):SetText(clientBreakLevel)
    ;
    (self._additionText):SetText((TextManager.GetText)((self._battleRecorder).addition))
    self._itemData = {}
    for i,v in ipairs((self._battleRecorder).firstItems) do
      local temp = {tag = "first", itemID = v, count = ((self._battleRecorder).firstItemNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    for i,v in ipairs((self._battleRecorder).sureDropItems) do
      local temp = {tag = "sure", itemID = v, count = ((self._battleRecorder).sureDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    for i,v in ipairs((self._battleRecorder).mayDropItems) do
      local temp = {tag = "may", itemID = v, count = ((self._battleRecorder).mayDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    ;
    (self._frame):ReloadAllCell()
  else
    LogErrorFormat("ChristmasBattleDialog", "functionID %s 没有找到战斗", tostring(data.functionID))
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

ChristmasBattleDialog.OnGoBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < (self._battleRecorder).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    ;
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("Christmas", ((self._battlesData)[self._index]).functionID, self._constructionID)
    end
    self:OnBackBtnClicked()
  end
end

ChristmasBattleDialog.OnAutoBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < (self._battleRecorder).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreChristmas"
      data.id = ((self._battlesData)[self._index]).functionID
      data.spirit = (self._battleRecorder).spirit
      dialog:SetInfo(data)
    end
  end
end

ChristmasBattleDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_7 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not (UIManager.RectangleContainsScreenPoint)((self._buttonPanelBack)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ChristmasBattleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  if frame == self._buttonFrame then
    return #self._battlesData
  end
  return #self._itemData
end

ChristmasBattleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._buttonFrame then
    return "activity.christmas.christmasbattlebtncell"
  end
  return "activity.christmas.christmasbattleitemcell"
end

ChristmasBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._buttonFrame then
    return (self._battlesData)[index]
  end
  return (self._itemData)[index]
end

ChristmasBattleDialog.OnSUpdateChristmasConstruction = function(self, notification)
  -- function num : 0_11
  local protocol = notification.userInfo
  if self._constructionID == (protocol.construction).ID then
    local data = {}
    data.functionIDs = (protocol.construction).event
    data.constructionID = self._constructionID
    data.locked = (protocol.construction).locked
    data.event2lock = (protocol.construction).event2lock
    data.constructionLevel = (protocol.construction).level
    self:SetData(data)
  end
end

ChristmasBattleDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_12 , upvalues : CInterfaceFunction, _ENV
  local data = (self._battlesData)[self._index]
  local funectionRecorder = CInterfaceFunction:GetRecorder(data.functionID)
  if not funectionRecorder then
    LogErrorFormat("ChristmasBattleDialog", "CInterfaceFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return 
  end
  local battleID = funectionRecorder.battleID
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = battleID
    data.type = "Christmas"
    dialog:Init(data)
  end
end

ChristmasBattleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

return ChristmasBattleDialog

