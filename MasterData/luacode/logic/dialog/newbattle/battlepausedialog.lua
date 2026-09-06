local TableFrame = require("framework.ui.frame.table.tableframe")
local CBattleMessageTable = BeanManager.GetTableByName("message.cbattlemessage")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CEnemyInfo = BeanManager.GetTableByName("battle.cenemyinfo")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local BattlePauseDialog = class("BattlePauseDialog", Dialog)
BattlePauseDialog.AssetBundleName = "ui/layouts.battlenew"
BattlePauseDialog.AssetName = "BattlePause"
local BottomToTop = 2
BattlePauseDialog.PageType = {
  SelfSkill = 1,
  BuffDetail = 2,
  EnemyInfo = 3
}

local function OnNewBattleGuideTimeType1003(self, notification)
  if notification.userInfo == 3 then
    self._battleGuideState = true
    NekoData.BehaviorManager.BM_Guide:CreateGuideDialogInBattle(nil, function()
      local width, height = self._playBtnBig:GetRectSize()
      local screenPos = self._playBtnBigGuide:GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = screenPos.x,
        posY = screenPos.y
      }
    end, function()
      local width, height = self._playBtnBig:GetRectSize()
      local screenPos = self._playBtnBigGuide:GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = screenPos.x,
        posY = screenPos.y
      }
    end, "Up", 2301171)
  end
end

function BattlePauseDialog:Ctor(...)
  BattlePauseDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._messageList = {}
  self._message0List = {}
  self._buffDetailList = {}
end

function BattlePauseDialog:OnCreate()
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
  self._buffFrameScrollBar:SetScrollDirection(BottomToTop)
  self._enemyPanel = self:GetChild("PageEnemy")
  self._enemyFramePanel = self:GetChild("PageEnemy/Frame")
  self._enemyFrameScrollBar = self:GetChild("PageEnemy/Scrollbar")
  self._enemyFrameScrollBar:SetScrollDirection(BottomToTop)
  self._selfSkillToggle = self:GetChild("ToggleGroup/_Toggle_0")
  self._buffDetailToggle = self:GetChild("ToggleGroup/_Toggle_1")
  self._enemyInfoToggle = self:GetChild("ToggleGroup/_Toggle_2")
  self._panelAnchorMinX, self._panelAnchorMinY, self._panelAnchorMaxX, self._panelAnchorMaxY, self._panelOffsetMinX, self._panelOffsetMinY, self._panelOffsetMaxX, self._panelOffsetMaxY = self._panel:GetAnchorAndOffset()
  self._frame = TableFrame.Create(self._panel, self, false, false)
  self._buffFrame = TableFrame.Create(self._buffFramePanel, self, true, true, true)
  self._enemyFrame = TableFrame.Create(self._enemyFramePanel, self, true, true)
  self._buffPanelWidth, self._buffPanelHeight = self._buffPanel:GetRectSize()
  self._enemyPanelWidth, self._enemyPanelHeight = self._enemyPanel:GetRectSize()
  self._playBtn:Subscribe_PointerClickEvent(self.OnPlayBtnClick, self)
  self._playBtnBig:Subscribe_PointerClickEvent(self.OnPlayBtnBigClick, self)
  self._leaveBtn:Subscribe_PointerClickEvent(self.OnLeaveBtnClick, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._selfSkillToggle:Subscribe_PointerClickEvent(self.OnSelfSkillClick, self)
  self._buffDetailToggle:Subscribe_PointerClickEvent(self.OnBuffDetailClick, self)
  self._enemyInfoToggle:Subscribe_PointerClickEvent(self.OnEnemyInfoClick, self)
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog and dialog._pauseBtn then
    dialog._pauseBtn:SetActive(false)
  end
  if dialog and dialog._leaveBtn then
    dialog._leaveBtn:SetActive(false)
  end
  self._leaveBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleRetreat))
  LuaNotificationCenter.AddObserver(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, nil)
  LogInfoFormat("BattlePauseDialog", [[
OnCreate 

%s
]], debug.traceback())
end

function BattlePauseDialog:OnDestroy()
  local dialog = DialogManager.GetDialog("newbattle.battlenewmaindialog")
  if dialog and dialog._pauseBtn then
    dialog._pauseBtn:SetActive(dialog._pauseBtnState)
    dialog._pause = false
    dialog._frame:FireEvent("ChangeLittleCharRaycastTarget", false)
  end
  if dialog and dialog._leaveBtn then
    dialog._leaveBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleRetreat))
  end
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  if self._buffFrame then
    self._buffFrame:Destroy()
    self._buffFrame = nil
  end
  if self._enemyFrame then
    self._enemyFrame:Destroy()
    self._enemyFrame = nil
  end
end

function BattlePauseDialog:SetData(battleId, type)
  self._roleList = {}
  for k, v in pairs(CBattleMessageTable:GetAllIds()) do
    local record = CBattleMessageTable:GetRecorder(v)
    if record.battleId == battleId then
      table.insert(self._messageList, record)
    end
    if record.battleId == 0 then
      table.insert(self._message0List, record)
    end
  end
  if #self._messageList > 0 then
    local str = TextManager.GetText(self._messageList[math.random(#self._messageList)].messageTextID)
    self._text:SetText(str)
  elseif 0 < #self._message0List then
    local str = TextManager.GetText(self._message0List[math.random(#self._message0List)].messageTextID)
    self._text:SetText(str)
  end
  local battlerList = {}
  local leftBattlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
  for k, v in pairs(leftBattlers) do
    if v:IsRole() and (v:IsAlive() or not v:IsHaveAlternate()) then
      table.insert(battlerList, v)
    end
  end
  table.sort(battlerList, function(a, b)
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
    return aKey > bKey
  end)
  for i, v in ipairs(battlerList) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(v:GetConfigId())
    table.insert(self._roleList, role)
  end
  self._frame:ReloadAllCell()
  local totalLength = self._frame:GetTotalLength()
  self._panel:SetAnchorAndOffset(0.5, self._panelAnchorMinY, 0.5, self._panelAnchorMaxY, -totalLength / 2, self._panelOffsetMinY, totalLength / 2, self._panelOffsetMaxY)
  self._frame:ReloadAllCell()
  local recorder = CEnemyInfo:GetRecorder(battleId)
  if recorder then
    self._enemyInfoToggle:SetActive(true)
    self._enemyInfoList = {}
    for i, labelId in ipairs(recorder.labels) do
      table.insert(self._enemyInfoList, {
        title = TextManager.GetText(labelId),
        describe = TextManager.GetText(recorder.descriptions[i])
      })
    end
    self._enemyFrame:ReloadAllCell()
  else
    self._enemyInfoToggle:SetActive(false)
  end
  if type == "enemyinfo" then
    self:OnEnemyInfoClick()
  else
    self:OnSelfSkillClick()
  end
end

function BattlePauseDialog:OnPlayBtnClick()
  DialogManager.CreateSingletonDialog("newbattle.battlecountdowndialog")
  self:Destroy()
end

function BattlePauseDialog:OnPlayBtnBigClick()
  if self._battleGuideState then
    self._battleGuideState = false
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
  end
  DialogManager.CreateSingletonDialog("newbattle.battlecountdowndialog")
  self:Destroy()
end

function BattlePauseDialog:OnLeaveBtnClick()
  local secondConfirmID
  self._isSpring = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType() == CBattleStartProtocol.SPRING_FESTIVAL
  if self._isSpring then
    secondConfirmID = 131
  else
    secondConfirmID = 35
  end
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(secondConfirmID, nil, function()
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
    controller = controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
    if controller then
      controller:BSC_Retreat()
    else
      LogError("BattlePauseDialog", "无有效战斗场景")
    end
    NekoData.DataManager.DM_TimeScale:CancelBattlePause()
    self:Destroy()
  end, {}, nil, {})
end

function BattlePauseDialog:OnLeftArrowClick()
  if #self._messageList > 0 then
    local str = TextManager.GetText(self._messageList[math.random(#self._messageList)].messageTextID)
    self._text:SetText(str)
  elseif 0 < #self._message0List then
    local str = TextManager.GetText(self._message0List[math.random(#self._message0List)].messageTextID)
    self._text:SetText(str)
  end
end

function BattlePauseDialog:OnRightArrowClick()
  if #self._messageList > 0 then
    local str = TextManager.GetText(self._messageList[math.random(#self._messageList)].messageTextID)
    self._text:SetText(str)
  elseif 0 < #self._message0List then
    local str = TextManager.GetText(self._message0List[math.random(#self._message0List)].messageTextID)
    self._text:SetText(str)
  end
end

function BattlePauseDialog:OnSelfSkillClick()
  self._pageTag = self.PageType.SelfSkill
  self._selfSkillToggle:SetIsOnType(true)
  self._panel:SetActive(true)
  self._buffPanel:SetActive(false)
  self._enemyPanel:SetActive(false)
end

function BattlePauseDialog:OnBuffDetailClick()
  self._pageTag = self.PageType.BuffDetail
  self._buffDetailToggle:SetIsOnType(true)
  self._panel:SetActive(false)
  self._buffPanel:SetActive(true)
  self._enemyPanel:SetActive(false)
  while self._buffDetailList[#self._buffDetailList] do
    self._buffDetailList[#self._buffDetailList] = nil
  end
  for entityId, v in pairs(NekoData.BehaviorManager.BM_Battle:GetEntityBuff()) do
    if v.battler:IsAlive() then
      table.insert(self._buffDetailList, v)
    end
  end
  table.sort(self._buffDetailList, function(a, b)
    local aBattler = a.battler
    local bBattler = b.battler
    return aBattler:GetPosition() < bBattler:GetPosition()
  end)
  self._buffFrame:ReloadAllCell()
  self._buffFrame:MoveToTop()
end

function BattlePauseDialog:OnEnemyInfoClick()
  self._pageTag = self.PageType.EnemyInfo
  self._enemyInfoToggle:SetIsOnType(true)
  self._panel:SetActive(false)
  self._buffPanel:SetActive(false)
  self._enemyPanel:SetActive(true)
end

function BattlePauseDialog:NumberOfCell(frame)
  if frame == self._frame then
    return #self._roleList
  elseif frame == self._buffFrame then
    return #self._buffDetailList
  elseif frame == self._enemyFrame then
    return #self._enemyInfoList
  end
end

function BattlePauseDialog:CellAtIndex(frame)
  if frame == self._frame then
    return "newbattle.battlepauseroleskillcell"
  elseif frame == self._buffFrame then
    return "newbattle.battlepausebuffdetailcell"
  elseif frame == self._enemyFrame then
    return "newbattle.battlepauseenemyinfocell"
  end
end

function BattlePauseDialog:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._roleList[index]
  elseif frame == self._buffFrame then
    return self._buffDetailList[index]
  elseif frame == self._enemyFrame then
    return self._enemyInfoList[index]
  end
end

function BattlePauseDialog:ShouldLengthChange(frame, index)
  if frame == self._buffFrame then
    return true
  elseif frame == self._enemyFrame then
    return true
  end
end

function BattlePauseDialog:OnCurPosChange(frame, ratio)
  if frame == self._buffFrame then
    local total = self._buffFrame:GetTotalLength()
    if total > self._buffPanelHeight then
      self._buffFrameScrollBar:SetActive(true)
      self._buffFrameScrollBar:SetScrollSize(self._buffPanelHeight / total)
      self._buffFrameScrollBar:SetScrollValue(ratio)
    else
      self._buffFrameScrollBar:SetActive(false)
    end
  elseif frame == self._enemyFrame then
    local total = self._enemyFrame:GetTotalLength()
    if total > self._enemyPanelHeight then
      self._enemyFrameScrollBar:SetActive(true)
      self._enemyFrameScrollBar:SetScrollSize(self._enemyPanelHeight / total)
      self._enemyFrameScrollBar:SetScrollValue(ratio)
    else
      self._enemyFrameScrollBar:SetActive(false)
    end
  end
end

function BattlePauseDialog:OnBackBtnClicked()
  self:OnPlayBtnBigClick()
end

return BattlePauseDialog
