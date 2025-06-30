-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitbattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CHexagonBattleConfig = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CHexagonChatConfig = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CFunctionLevelup = (BeanManager.GetTableByName)("activity.cfunctionlevelup")
local TableFrame = require("framework.ui.frame.table.tableframe")
local State = {Unlock = 1, PreconditionsNotMet = 2, Lock = 3}
local SwimSuitBattleDialog = class("SwimSuitBattleDialog", Dialog)
SwimSuitBattleDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitBattleDialog.AssetName = "ActivitySummerbattle"
SwimSuitBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitBattleDialog
  ((SwimSuitBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitBattleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
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
  self._lvText = self:GetChild("Name/Lv")
  self._lvNum = self:GetChild("Name/Nun")
  self._nameText = self:GetChild("Name/text")
  self._ranknum = self:GetChild("Battlelevel/Ranknum")
  self._panel = self:GetChild("frame")
  self._frame = (TableFrame.Create)(self._panel, self, false)
  self._additionText = self:GetChild("Line/Text")
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
end

SwimSuitBattleDialog.OnDestroy = function(self)
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

SwimSuitBattleDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CHexagonFunction, State
  self._functionIDs = data.functionIDs
  self._constructionID = data.constructionID
  self._locked = data.locked
  self._event2lock = data.event2lock
  self._battlesData = {}
  ;
  (self._lvNum):SetText(data.constructionLevel)
  self._constructionLevel = data.constructionLevel
  ;
  (table.sort)(self._functionIDs, function(a, b)
    -- function num : 0_3_0 , upvalues : CHexagonFunction
    local funectionRecorderA = CHexagonFunction:GetRecorder(a)
    local funectionRecorderB = CHexagonFunction:GetRecorder(b)
    do return funectionRecorderA.difficulty < funectionRecorderB.difficulty end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(self._locked, function(a, b)
    -- function num : 0_3_1 , upvalues : CHexagonFunction
    local funectionRecorderA = CHexagonFunction:GetRecorder(a)
    local funectionRecorderB = CHexagonFunction:GetRecorder(b)
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
          -- DECOMPILER ERROR at PC77: Confused about usage of register: R13 in 'UnsetPending'

          if k.functionID == v then
            ((self._battlesData)[j]).state = State.PreconditionsNotMet
          end
        end
        do
          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if self._event2lock > 0 then
    if not (table.contain)(self._functionIDs, self._event2lock) then
      count = count + 1
      local temp = {functionID = self._event2lock, state = State.Lock, index = #self._battlesData + 1}
      ;
      (table.insert)(self._battlesData, temp)
    else
      do
        for j,k in ipairs(self._battlesData) do
          -- DECOMPILER ERROR at PC119: Confused about usage of register: R8 in 'UnsetPending'

          if k.functionID == self._event2lock then
            ((self._battlesData)[j]).state = State.Lock
          end
        end
        do
          ;
          (self._buttonFrame):ReloadAllCell()
          self:OnButtonGroupClick(#self._functionIDs)
        end
      end
    end
  end
end

SwimSuitBattleDialog.OnButtonGroupClick = function(self, index)
  -- function num : 0_4 , upvalues : State, _ENV, CHexagonFunction, CHexagonBattleConfig, CRoleLevelCfgTable
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
  ;
  (self._num):SetText((TextManager.GetText)(701478, self._constructionLevel + 1))
  local funectionRecorder = CHexagonFunction:GetRecorder(data.functionID)
  if not funectionRecorder then
    LogErrorFormat("SwimSuitBattleDialog", "CHexagonFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return 
  end
  ;
  (self._autoBtn):SetInteractable((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):HasFinishBlockBattle(self._constructionID, data.functionID))
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
    for i,v in ipairs((self._battleRecorder).mayDropItems) do
      local temp = {tag = "may", itemID = v, count = ((self._battleRecorder).mayDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    for i,v in ipairs((self._battleRecorder).sureDropItems) do
      local temp = {tag = "sure", itemID = v, count = ((self._battleRecorder).sureDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    ;
    (self._frame):ReloadAllCell()
  else
    LogErrorFormat("SwimSuitBattleDialog", "functionID %s 没有找到战斗", tostring(data.functionID))
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

SwimSuitBattleDialog.OnGoBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < (self._battleRecorder).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    ;
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("SwimSuit", ((self._battlesData)[self._index]).functionID, self._constructionID)
    end
    self:Destroy()
  end
end

SwimSuitBattleDialog.OnAutoBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < (self._battleRecorder).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreSwimSuit"
      data.id = ((self._battlesData)[self._index]).functionID
      data.spirit = (self._battleRecorder).spirit
      dialog:SetInfo(data)
    end
  end
end

SwimSuitBattleDialog.OnLevelUpBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, CFunctionLevelup, CHexagonLand
  local resultRecord = nil
  for _,id in pairs(CFunctionLevelup:GetAllIds()) do
    local record = CFunctionLevelup:GetRecorder(id)
    if record and record.landID == self._constructionID and record.level == self._constructionLevel + 1 then
      resultRecord = record
      break
    end
  end
  do
    local record = CHexagonLand:GetRecorder(self._constructionID)
    if resultRecord then
      local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.levelupconfirmdialog")
      if dialog then
        dialog:SetData(resultRecord, (TextManager.GetText)(record.name))
      end
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100384)
      end
    end
  end
end

SwimSuitBattleDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not (UIManager.RectangleContainsScreenPoint)((self._buttonPanelBack)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:Destroy()
  end
end

SwimSuitBattleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if frame == self._buttonFrame then
    return #self._battlesData
  end
  return #self._itemData
end

SwimSuitBattleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._buttonFrame then
    return "activity.swimsuit.swimsuitbattlebtncell"
  end
  return "activity.swimsuit.swimsuitbattleitemcell"
end

SwimSuitBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._buttonFrame then
    return (self._battlesData)[index]
  end
  return (self._itemData)[index]
end

SwimSuitBattleDialog.OnSUpdateSummerConstruction = function(self, notification)
  -- function num : 0_12
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

SwimSuitBattleDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_13 , upvalues : CHexagonFunction, _ENV
  local data = (self._battlesData)[self._index]
  local funectionRecorder = CHexagonFunction:GetRecorder(data.functionID)
  if not funectionRecorder then
    LogErrorFormat("SwimSuitBattleDialog", "CHexagonFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return 
  end
  local battleID = funectionRecorder.battleID
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = battleID
    data.type = "SwimStit"
    dialog:Init(data)
  end
end

return SwimSuitBattleDialog

