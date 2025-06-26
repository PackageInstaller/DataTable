-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepausedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CBattleMessageTable = (BeanManager.GetTableByName)("message.cbattlemessage")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CEnemyInfo = (BeanManager.GetTableByName)("battle.cenemyinfo")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local BattlePauseDialog = class("BattlePauseDialog", Dialog)
BattlePauseDialog.AssetBundleName = "ui/layouts.battlenew"
BattlePauseDialog.AssetName = "BattlePause"
local BottomToTop = 2
BattlePauseDialog.PageType = {SelfSkill = 1, BuffDetail = 2, EnemyInfo = 3}
local OnNewBattleGuideTimeType1003 = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  if notification.userInfo == 3 then
    self._battleGuideState = true
    ;
    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialogInBattle(nil, function()
    -- function num : 0_0_0 , upvalues : self
    local width, height = (self._playBtnBig):GetRectSize()
    local screenPos = (self._playBtnBigGuide):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, function()
    -- function num : 0_0_1 , upvalues : self
    local width, height = (self._playBtnBig):GetRectSize()
    local screenPos = (self._playBtnBigGuide):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, "Up", 2301171)
  end
end

BattlePauseDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BattlePauseDialog
  ((BattlePauseDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
  self._messageList = {}
  self._message0List = {}
  self._buffDetailList = {}
end

BattlePauseDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : BottomToTop, TableFrame, _ENV, OnNewBattleGuideTimeType1003
  self._playBtn = self:GetChild("PlayBtn")
  self._playBtnBig = self:GetChild("PlayBtnBig")
  self._playBtnBigGuide = self:GetChild("PlayBtnBig/Guide")
  self._leaveBtn = self:GetChild("LeaveBtn")
  self._text = self:GetChild("Tips/Text")
  self._leftArrow = self:GetChild("Tips/LeftArrow")
  self._rightArrow = self:GetChild("Tips/RightArrow")
  self._panel = self:GetChild("Frame")
  self._buffPanel = self:GetChild("PageBuff")
  self._buffFramePanel = self:GetChild("PageBuff/Frame")
  self._buffFrameScrollBar = self:GetChild("PageBuff/Scrollbar")
  ;
  (self._buffFrameScrollBar):SetScrollDirection(BottomToTop)
  self._enemyPanel = self:GetChild("PageEnemy")
  self._enemyFramePanel = self:GetChild("PageEnemy/Frame")
  self._enemyFrameScrollBar = self:GetChild("PageEnemy/Scrollbar")
  ;
  (self._enemyFrameScrollBar):SetScrollDirection(BottomToTop)
  self._selfSkillToggle = self:GetChild("ToggleGroup/_Toggle_0")
  self._buffDetailToggle = self:GetChild("ToggleGroup/_Toggle_1")
  self._enemyInfoToggle = self:GetChild("ToggleGroup/_Toggle_2")
  self._panelAnchorMinX = (self._panel):GetAnchorAndOffset()
  self._frame = (TableFrame.Create)(self._panel, self, R4_PC83, R5_PC82)
  -- DECOMPILER ERROR at PC97: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC98: Overwrote pending register: R5 in 'AssignReg'

  self._buffFrame = (TableFrame.Create)(self._buffFramePanel, self, R4_PC83, R5_PC82, R6_PC81)
  -- DECOMPILER ERROR at PC105: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC106: Overwrote pending register: R5 in 'AssignReg'

  self._enemyFrame = (TableFrame.Create)(self._enemyFramePanel, self, R4_PC83, R5_PC82)
  self._buffPanelWidth = (self._buffPanel):GetRectSize()
  self._enemyPanelWidth = (self._enemyPanel):GetRectSize()
  -- DECOMPILER ERROR at PC122: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._playBtn):Subscribe_PointerClickEvent(self.OnPlayBtnClick, R4_PC83)
  -- DECOMPILER ERROR at PC127: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._playBtnBig):Subscribe_PointerClickEvent(self.OnPlayBtnBigClick, R4_PC83)
  -- DECOMPILER ERROR at PC132: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._leaveBtn):Subscribe_PointerClickEvent(self.OnLeaveBtnClick, R4_PC83)
  -- DECOMPILER ERROR at PC137: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, R4_PC83)
  -- DECOMPILER ERROR at PC142: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, R4_PC83)
  -- DECOMPILER ERROR at PC147: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._selfSkillToggle):Subscribe_PointerClickEvent(self.OnSelfSkillClick, R4_PC83)
  -- DECOMPILER ERROR at PC152: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._buffDetailToggle):Subscribe_PointerClickEvent(self.OnBuffDetailClick, R4_PC83)
  -- DECOMPILER ERROR at PC157: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._enemyInfoToggle):Subscribe_PointerClickEvent(self.OnEnemyInfoClick, R4_PC83)
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  -- DECOMPILER ERROR at PC170: Overwrote pending register: R4 in 'AssignReg'

  if dialog and dialog._pauseBtn then
    (dialog._pauseBtn):SetActive(R4_PC83)
  end
  -- DECOMPILER ERROR at PC179: Overwrote pending register: R4 in 'AssignReg'

  if dialog and dialog._leaveBtn then
    (dialog._leaveBtn):SetActive(R4_PC83)
  end
  -- DECOMPILER ERROR at PC183: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC184: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC185: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC186: Overwrote pending register: R5 in 'AssignReg'

  -- DECOMPILER ERROR at PC186: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC187: Overwrote pending register: R6 in 'AssignReg'

  -- DECOMPILER ERROR at PC188: Overwrote pending register: R6 in 'AssignReg'

  -- DECOMPILER ERROR at PC189: Overwrote pending register: R6 in 'AssignReg'

  ;
  (self._leaveBtn):SetActive(R4_PC83(R5_PC82, R6_PC81))
  -- DECOMPILER ERROR at PC198: Overwrote pending register: R6 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, R6_PC81)
  LogInfoFormat("BattlePauseDialog", "OnCreate \n\n%s\n", (debug.traceback)())
end

BattlePauseDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog and dialog._pauseBtn then
    (dialog._pauseBtn):SetActive(dialog._pauseBtnState)
    dialog._pause = false
    ;
    (dialog._frame):FireEvent("ChangeLittleCharRaycastTarget", false)
  end
  if dialog and dialog._leaveBtn then
    (dialog._leaveBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattleRetreat))
  end
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
  if self._buffFrame then
    (self._buffFrame):Destroy()
    self._buffFrame = nil
  end
  if self._enemyFrame then
    (self._enemyFrame):Destroy()
    self._enemyFrame = nil
  end
end

BattlePauseDialog.SetData = function(self, battleId, type)
  -- function num : 0_4 , upvalues : _ENV, CBattleMessageTable, LineUpStation, CEnemyInfo
  self._roleList = {}
  for k,v in pairs(CBattleMessageTable:GetAllIds()) do
    local record = CBattleMessageTable:GetRecorder(v)
    if record.battleId == battleId then
      (table.insert)(self._messageList, record)
    end
    if record.battleId == 0 then
      (table.insert)(self._message0List, record)
    end
  end
  if #self._messageList > 0 then
    local str = (TextManager.GetText)(((self._messageList)[(math.random)(#self._messageList)]).messageTextID)
    ;
    (self._text):SetText(str)
  else
    do
      do
        if #self._message0List > 0 then
          local str = (TextManager.GetText)(((self._message0List)[(math.random)(#self._message0List)]).messageTextID)
          ;
          (self._text):SetText(str)
        end
        local battlerList = {}
        local leftBattlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
        for k,v in pairs(leftBattlers) do
          if v:IsRole() and (v:IsAlive() or not v:IsHaveAlternate()) then
            (table.insert)(battlerList, v)
          end
        end
        ;
        (table.sort)(battlerList, function(a, b)
    -- function num : 0_4_0 , upvalues : LineUpStation
    local aKey = a:GetKey()
    local bKey = b:GetKey()
    if aKey == LineUpStation.ALTERNATE_BACK_ROW then
      aKey = LineUpStation.BACK_ROW
    end
    if aKey == LineUpStation.ALTERNATE_FRONT_ROW then
      aKey = LineUpStation.FRONT_ROW
    end
    if aKey == LineUpStation.ALTERNATE_MIDDLE_ROW then
      aKey = LineUpStation.MIDDLE_ROW
    end
    if bKey == LineUpStation.ALTERNATE_BACK_ROW then
      bKey = LineUpStation.BACK_ROW
    end
    if bKey == LineUpStation.ALTERNATE_FRONT_ROW then
      bKey = LineUpStation.FRONT_ROW
    end
    if bKey == LineUpStation.ALTERNATE_MIDDLE_ROW then
      bKey = LineUpStation.MIDDLE_ROW
    end
    do return bKey < aKey end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        for i,v in ipairs(battlerList) do
          local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(v:GetConfigId())
          ;
          (table.insert)(self._roleList, role)
        end
        ;
        (self._frame):ReloadAllCell()
        local totalLength = (self._frame):GetTotalLength()
        ;
        (self._panel):SetAnchorAndOffset(0.5, self._panelAnchorMinY, 0.5, self._panelAnchorMaxY, -totalLength / 2, self._panelOffsetMinY, totalLength / 2, self._panelOffsetMaxY)
        ;
        (self._frame):ReloadAllCell()
        local recorder = CEnemyInfo:GetRecorder(battleId)
        if recorder then
          (self._enemyInfoToggle):SetActive(true)
          self._enemyInfoList = {}
          for i,labelId in ipairs(recorder.labels) do
            (table.insert)(self._enemyInfoList, {title = (TextManager.GetText)(labelId), describe = (TextManager.GetText)((recorder.descriptions)[i])})
          end
          ;
          (self._enemyFrame):ReloadAllCell()
        else
          ;
          (self._enemyInfoToggle):SetActive(false)
        end
        if type == "enemyinfo" then
          self:OnEnemyInfoClick()
        else
          self:OnSelfSkillClick()
        end
      end
    end
  end
end

BattlePauseDialog.OnPlayBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("newbattle.battlecountdowndialog")
  self:Destroy()
end

BattlePauseDialog.OnPlayBtnBigClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._battleGuideState then
    self._battleGuideState = false
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
  end
  ;
  (DialogManager.CreateSingletonDialog)("newbattle.battlecountdowndialog")
  self:Destroy()
end

BattlePauseDialog.OnLeaveBtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV, CBattleStartProtocol
  local secondConfirmID = nil
  self._isSpring = ((NekoData.BehaviorManager).BM_SBattleStart):GetBattleType() == CBattleStartProtocol.SPRING_FESTIVAL
  if self._isSpring then
    secondConfirmID = 131
  else
    secondConfirmID = 35
  end
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(secondConfirmID, nil, function()
    -- function num : 0_7_0 , upvalues : _ENV, self
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
    if not controller then
      controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
    end
    if controller then
      controller:BSC_Retreat()
    else
      LogError("BattlePauseDialog", "无有效战斗场景")
    end
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelBattlePause()
    self:Destroy()
  end
, {}, nil, {})
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BattlePauseDialog.OnLeftArrowClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if #self._messageList > 0 then
    local str = (TextManager.GetText)(((self._messageList)[(math.random)(#self._messageList)]).messageTextID)
    ;
    (self._text):SetText(str)
  else
    do
      if #self._message0List > 0 then
        local str = (TextManager.GetText)(((self._message0List)[(math.random)(#self._message0List)]).messageTextID)
        ;
        (self._text):SetText(str)
      end
    end
  end
end

BattlePauseDialog.OnRightArrowClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if #self._messageList > 0 then
    local str = (TextManager.GetText)(((self._messageList)[(math.random)(#self._messageList)]).messageTextID)
    ;
    (self._text):SetText(str)
  else
    do
      if #self._message0List > 0 then
        local str = (TextManager.GetText)(((self._message0List)[(math.random)(#self._message0List)]).messageTextID)
        ;
        (self._text):SetText(str)
      end
    end
  end
end

BattlePauseDialog.OnSelfSkillClick = function(self)
  -- function num : 0_10
  self._pageTag = (self.PageType).SelfSkill
  ;
  (self._selfSkillToggle):SetIsOnType(true)
  ;
  (self._panel):SetActive(true)
  ;
  (self._buffPanel):SetActive(false)
  ;
  (self._enemyPanel):SetActive(false)
end

BattlePauseDialog.OnBuffDetailClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self._pageTag = (self.PageType).BuffDetail
  ;
  (self._buffDetailToggle):SetIsOnType(true)
  ;
  (self._panel):SetActive(false)
  ;
  (self._buffPanel):SetActive(true)
  ;
  (self._enemyPanel):SetActive(false)
  while 1 do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    if (self._buffDetailList)[#self._buffDetailList] then
      (self._buffDetailList)[#self._buffDetailList] = nil
      -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  for entityId,v in pairs(((NekoData.BehaviorManager).BM_Battle):GetEntityBuff()) do
    if (v.battler):IsAlive() then
      (table.insert)(self._buffDetailList, v)
    end
  end
  ;
  (table.sort)(self._buffDetailList, function(a, b)
    -- function num : 0_11_0
    local aBattler = a.battler
    local bBattler = b.battler
    do return aBattler:GetPosition() < bBattler:GetPosition() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._buffFrame):ReloadAllCell()
  ;
  (self._buffFrame):MoveToTop()
end

BattlePauseDialog.OnEnemyInfoClick = function(self)
  -- function num : 0_12
  self._pageTag = (self.PageType).EnemyInfo
  ;
  (self._enemyInfoToggle):SetIsOnType(true)
  ;
  (self._panel):SetActive(false)
  ;
  (self._buffPanel):SetActive(false)
  ;
  (self._enemyPanel):SetActive(true)
end

BattlePauseDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  if frame == self._frame then
    return #self._roleList
  else
    if frame == self._buffFrame then
      return #self._buffDetailList
    else
      if frame == self._enemyFrame then
        return #self._enemyInfoList
      end
    end
  end
end

BattlePauseDialog.CellAtIndex = function(self, frame)
  -- function num : 0_14
  if frame == self._frame then
    return "newbattle.battlepauseroleskillcell"
  else
    if frame == self._buffFrame then
      return "newbattle.battlepausebuffdetailcell"
    else
      if frame == self._enemyFrame then
        return "newbattle.battlepauseenemyinfocell"
      end
    end
  end
end

BattlePauseDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._frame then
    return (self._roleList)[index]
  else
    if frame == self._buffFrame then
      return (self._buffDetailList)[index]
    else
      if frame == self._enemyFrame then
        return (self._enemyInfoList)[index]
      end
    end
  end
end

BattlePauseDialog.ShouldLengthChange = function(self, frame, index)
  -- function num : 0_16
  if frame == self._buffFrame then
    return true
  else
    if frame == self._enemyFrame then
      return true
    end
  end
end

BattlePauseDialog.OnCurPosChange = function(self, frame, ratio)
  -- function num : 0_17
  if frame == self._buffFrame then
    local total = (self._buffFrame):GetTotalLength()
    if self._buffPanelHeight < total then
      (self._buffFrameScrollBar):SetActive(true)
      ;
      (self._buffFrameScrollBar):SetScrollSize(self._buffPanelHeight / total)
      ;
      (self._buffFrameScrollBar):SetScrollValue(ratio)
    else
      ;
      (self._buffFrameScrollBar):SetActive(false)
    end
  else
    do
      if frame == self._enemyFrame then
        local total = (self._enemyFrame):GetTotalLength()
        if self._enemyPanelHeight < total then
          (self._enemyFrameScrollBar):SetActive(true)
          ;
          (self._enemyFrameScrollBar):SetScrollSize(self._enemyPanelHeight / total)
          ;
          (self._enemyFrameScrollBar):SetScrollValue(ratio)
        else
          ;
          (self._enemyFrameScrollBar):SetActive(false)
        end
      end
    end
  end
end

BattlePauseDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:OnPlayBtnBigClick()
end

return BattlePauseDialog

