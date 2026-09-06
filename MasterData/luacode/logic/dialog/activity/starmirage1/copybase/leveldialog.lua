local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local DungeonType = LuaNetManager.GetBeanDef("protocol.battle.dungeontype")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local LevelDialog = class("LevelDialog", Dialog)
LevelDialog.NotificationName = {
  RefreshDetailPanel = "LevelDialog_RefreshDetailPanel",
  RefreshFunctionBtnShow = "LevelDialog_RefreshFunctionBtnShow"
}

function LevelDialog:Ctor(args)
  LevelDialog.super.Ctor(self, args[1], args[2])
  self._TypeEnum = args.TypeEnum
  self._bm = args.bm
  self._ActivityId = args.ActivityId
  self._SpecialBossLevelMap = args.SpecialBossLevelMap
  self._LevelRecords = args.LevelRecords
  self._DiffcultyRecords = args.DiffcultyRecords
  self._BossLevelDetailDialogName = args.BossLevelDetailDialogName
  self._LevelCellName = args.LevelCellName
  self._LevelBossCellName = args.LevelBossCellName
  self._levelNodeLineData = {}
  self._levelNodeData = {}
  self._selectLevelId = nil
  self._rewardList = {}
  self._init = false
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
end

function LevelDialog:OnCreate()
  self._levelPanel = self:GetChild("LevelFrame")
  self._backEffect = self:GetChild("Effect")
  self._plotDetailPanel = self:GetChild("Detail/Level1")
  self._plotDetailPanel_name = self:GetChild("Detail/Level1/LevelNum")
  self._plotDetailPanel_introduction = self:GetChild("Detail/Level1/Detail2/Txt")
  self._plotDetailPanel_checkBtn = self:GetChild("Detail/Level1/Checkbtn")
  self._plotDetailPanel_checkBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._levelDetailPanel = self:GetChild("Detail/Level2")
  self._detail_back = self:GetChild("Detail/Level2/DetailBack")
  self._detail_name = self:GetChild("Detail/Level2/LevelNum")
  self._levelPanel_width, self._levelPanel_height = self._levelPanel:GetRectSize()
  self._levelPanel_anchor, self._levelPanel_offset = self._levelPanel:GetXPosition()
  self._detail_back_width, self._detail_back_height = self._detail_back:GetRectSize()
  self._screenWidth, self._screenHeight = self:GetRootWindow():GetRectSize()
  self._detail1Panel = self:GetChild("Detail/Level2/Detail1")
  self._recommendCapacity = self:GetChild("Detail/Level2/Detail1/Txt2")
  self._recommendBreakLv = self:GetChild("Detail/Level2/Detail1/BreakNumTxt")
  self._detail_describe = self:GetChild("Detail/Level2/Detail2/Txt")
  self._detail_rewardPanel = self:GetChild("Detail/Level2/CellPanel")
  self._detail_power = self:GetChild("Detail/Level2/CostBack/Txt2")
  self._detail_powerRed = self:GetChild("Detail/Level2/CostBack/Txt2Red")
  self._detail_autoBtn = self:GetChild("Detail/Level2/AutoBtn")
  self._detail_autoBtnTips = self:GetChild("Detail/Level2/AutoBtn/Tips")
  self._detail_autoBtnTips:SetActive(false)
  self._detail_autoBtnClickArea = self:GetChild("Detail/Level2/Click")
  self._detail_goBtn = self:GetChild("Detail/Level2/GoBtn")
  self._detail_goBtnCenter = self:GetChild("Detail/Level2/GoBtnCenter")
  self._detail_rewardFrame = TableFrame.Create(self._detail_rewardPanel, self, false, true)
  self._detail_autoBtn:Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  self._detail_autoBtnClickArea:Subscribe_PointerClickEvent(self.OnAutoBtnClickAreaClicked, self)
  self._detail_goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._detail_goBtnCenter:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  self._rootWindow:Subscribe_StateExitEvent(self.OnStateExit, self)
  local cellDialog = DialogManager.CreateDialog(self._LevelCellName, nil)
  self._levelCellWidth, self._levelCellHeight = cellDialog._rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  cellDialog = DialogManager.CreateDialog(self._LevelBossCellName, nil)
  self._levelBossCellWidth, self._levelBossCellHeight = cellDialog._rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  self:GetChild("Detail/Level2/CostBack/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2023))
  self:GetChild("Detail/Level1/Checkbtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2101))
end

function LevelDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._detail_rewardFrame:Destroy()
end

function LevelDialog:OnRefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  if self._selectLevelId then
    local temp = self._levelNodeData[self._selectLevelId]
    local record = temp.record
    if record.spirit > self._spirit then
      self._detail_power:SetActive(false)
      self._detail_powerRed:SetActive(true)
      self._detail_powerRed:SetText(record.spirit)
    else
      self._detail_power:SetActive(true)
      self._detail_powerRed:SetActive(false)
      self._detail_power:SetText(record.spirit)
    end
  end
end

local function EnterTeamEdit(self, levelId)
  local temp = self._levelNodeData[levelId]
  local record = temp.record
  if record.spirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
    return
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) and not self._bm:IsBossLevel(levelId) then
    NekoData.DataManager.DM_Team:ClearSupportRole()
    NekoData.BehaviorManager.BM_Team:SaveTeamEditCopyInfo(self._TypeEnum.BattleType, levelId)
    local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    if self._bm:IsBossLevel(levelId) then
      NekoData.DataManager.DM_Team:ClearSupportRole()
    end
    local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo(self._TypeEnum.BattleType, levelId)
    end
  end
end

local function RefreshDetailPanel(self)
  local temp = self._levelNodeData[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if data.status == LevelStateEnum.UNCLEAR and record.forebattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.forebattleplot) then
    self._plotDetailPanel:SetActive(true)
    self._levelDetailPanel:SetActive(false)
    self._plotDetailPanel_name:SetText(TextManager.GetText(record.leveltitle))
    self._plotDetailPanel_introduction:SetText(TextManager.GetText(record.plotdescribe))
  else
    self._plotDetailPanel:SetActive(false)
    self._levelDetailPanel:SetActive(true)
    self._detail_name:SetText(TextManager.GetText(record.leveltitle))
    local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(data.recommendLevel).clientBreakLevel
    local clientLevel = CRoleLevelCfgTable:GetRecorder(data.recommendLevel).clientLevel
    self._detail1Panel:SetActive(0 < clientBreakLevel)
    self._recommendCapacity:SetText(clientLevel)
    self._recommendBreakLv:SetText(clientBreakLevel)
    self._detail_describe:SetText(TextManager.GetText(record.levelinfo))
    if record.spirit > self._spirit then
      self._detail_power:SetActive(false)
      self._detail_powerRed:SetActive(true)
      self._detail_powerRed:SetText(record.spirit)
    else
      self._detail_power:SetActive(true)
      self._detail_powerRed:SetActive(false)
      self._detail_power:SetText(record.spirit)
    end
    local detail_autoBtnTag = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AutoExplore)
    self._detail_autoBtn:SetActive(detail_autoBtnTag)
    self._detail_goBtn:SetActive(detail_autoBtnTag)
    self._detail_goBtnCenter:SetActive(not detail_autoBtnTag)
    self._detail_autoBtn:SetInteractable(data.firstGet)
    self._autoGoBtnTipsNotShow = not data.firstGet
    self._detail_autoBtnTips:SetActive(false)
    if self._autoTipsShowTask then
      GameTimer.RemoveTask(self._autoTipsShowTask)
      self._autoTipsShowTask = nil
    end
    while self._rewardList[#self._rewardList] do
      table.remove(self._rewardList, #self._rewardList)
    end
    for i, v in ipairs(data.firstItems) do
      table.insert(self._rewardList, {tag = "First", data = v})
    end
    for i, v in ipairs(data.normalItems) do
      table.insert(self._rewardList, {tag = "Normal", data = v})
    end
    for i, v in ipairs(data.randItems) do
      table.insert(self._rewardList, {tag = "Random", data = v})
    end
    self._detail_rewardFrame:ReloadAllCell()
    LuaNotificationCenter.PostNotification(LevelDialog.NotificationName.RefreshDetailPanel, nil, nil)
  end
end

function LevelDialog:OnNPCChatEnd(notification)
  if self._chatdialogId == notification.userInfo then
    local record
    for k, v in pairs(self._LevelRecords) do
      if self._chatdialogId == v.forebattleplot or self._chatdialogId == v.afterbattleplot then
        record = v
        break
      end
    end
    if record then
      if self._chatdialogId == record.forebattleplot then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.BEFORE_BATTLE
        protocol.activity = self._ActivityId
        protocol.battleID = record.id
        protocol:Send()
      elseif self._chatdialogId == record.afterbattleplot then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.AFTER_BATTLE
        protocol.activity = self._ActivityId
        protocol.battleID = record.id
        protocol:Send()
        self._bm:SetLevelStatus(self._type, record.id, LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode").PASSED)
      end
    end
  end
end

function LevelDialog:BeforePlotFinished(levelId)
  local record = self._LevelRecords[levelId]
  if self._selectLevelId and self._selectLevelId == levelId and record and record.bosslevelornot ~= 0 then
    self._selectLevelId = nil
    self:SelectLevelById(record.id, true)
  else
    RefreshDetailPanel(self)
  end
end

local function BuildNodeData(self)
  for k, v in pairs(self._levelNodeData) do
    local dialog = v.dialog
    dialog:Destroy()
    dialog:RootWindowDestroy()
    self._levelNodeData[k] = nil
  end
  while self._levelNodeLineData[#self._levelNodeLineData] do
    local dialog = self._levelNodeLineData[#self._levelNodeLineData].dialog
    dialog:Destroy()
    dialog:RootWindowDestroy()
    table.remove(self._levelNodeLineData, #self._levelNodeLineData)
  end
  local levelDataMap = {}
  if self._data then
    for i, v in ipairs(self._data) do
      levelDataMap[v.levelId] = v
    end
  end
  local levelPosData = {}
  for levelId, record in pairs(self._LevelRecords) do
    if record.difficulty == self._type then
      levelPosData[levelId] = {}
      local pos = string.split(record.levelentrylocation, ",")
      local isBoss = record.bosslevelornot ~= 0
      local centerX, centerY
      if isBoss then
        centerX = tonumber(pos[1]) + self._levelBossCellWidth / 2
        centerY = tonumber(pos[2]) + self._levelBossCellHeight / 2
      else
        centerX = tonumber(pos[1]) + self._levelCellWidth / 2
        centerY = tonumber(pos[2]) + self._levelCellHeight / 2
      end
      levelPosData[levelId] = {
        x = tonumber(pos[1]),
        y = tonumber(pos[2]),
        cX = centerX,
        cY = centerY
      }
      self._levelNodeData[levelId] = {
        data = levelDataMap[levelId],
        record = record,
        isBoss = isBoss,
        posData = levelPosData[levelId]
      }
    end
  end
  for k, v in pairs(levelPosData) do
    local record = self._LevelRecords[k]
    for _, targetId in ipairs(record.levellinetarget) do
      local targetNodePosData = levelPosData[targetId]
      if targetNodePosData then
        local deltaX = targetNodePosData.cX - v.cX
        local deltaY = targetNodePosData.cY - v.cY
        local len = (deltaX ^ 2 + deltaY ^ 2) ^ 0.5
        local posX = v.cX + deltaX / 2
        local posY = v.cY + deltaY / 2
        local dialog = DialogManager.CreateDialog("activity.starmirage.levellinecell", self._levelPanel._uiObject)
        dialog._rootWindow:SetWidth(0, len)
        local levelLineCellWidth, levelLineCellHeight = dialog._rootWindow:GetRectSize()
        dialog._rootWindow:SetPosition(0, posX - levelLineCellWidth / 2, 0, posY - levelLineCellHeight / 2)
        dialog._rootWindow:SetZRotation(1, 0, deltaX, deltaY)
        dialog._rootWindow:SetActive(levelDataMap[targetId])
        table.insert(self._levelNodeLineData, {
          dialog = dialog,
          startLevelId = k,
          targetLevelId = targetId
        })
      end
    end
  end
  for k, v in pairs(levelPosData) do
    local info = self._levelNodeData[k]
    local dialog
    if not info.isBoss then
      dialog = DialogManager.CreateDialog(self._LevelCellName, self._levelPanel._uiObject)
    else
      dialog = DialogManager.CreateDialog(self._LevelBossCellName, self._levelPanel._uiObject)
    end
    dialog._rootWindow:SetPosition(0, v.x, 0, v.y)
    if levelDataMap[k] and info.record.bosslevelornot ~= 2 then
      dialog._rootWindow:SetActive(true)
    else
      dialog._rootWindow:SetActive(false)
    end
    if levelDataMap[k] then
      dialog:SetData(self, info)
    end
    self._levelNodeData[k].dialog = dialog
  end
end

function LevelDialog:RefreshByProtocol(data)
  if not self._init then
    self._init = true
    self._data = self._delegate._levelMap[self._type]
    BuildNodeData(self)
  end
  local lineDialogMap = {}
  for i, v in ipairs(self._levelNodeLineData) do
    if not lineDialogMap[v.targetLevelId] then
      lineDialogMap[v.targetLevelId] = {}
    end
    lineDialogMap[v.targetLevelId][v.startLevelId] = v.dialog
  end
  for i, info in ipairs(data) do
    if info.battletype == self._type then
      local v = self._bm:GetLevelInfo(info.battletype, info.id)
      if self._levelNodeData[v.levelId] and self._levelNodeData[v.levelId].data then
        self._levelNodeData[v.levelId].data = v
        self._levelNodeData[v.levelId].dialog:SetData(self, self._levelNodeData[v.levelId])
      else
        local levelId = v.levelId
        local record = self._LevelRecords[levelId]
        if record then
          self._levelNodeData[levelId].data = v
        else
          LogErrorFormat("LevelDialog", "Can not find record by levelId: %s.", levelId)
        end
        local map = lineDialogMap[levelId]
        if map then
          for k, value in pairs(map) do
            value._rootWindow:SetActive(true)
          end
        end
        local info = self._levelNodeData[levelId]
        local dialog = info.dialog
        dialog._rootWindow:SetActive(true)
        dialog:SetData(self, info)
        dialog:PlayAnimation()
      end
    end
  end
  LuaNotificationCenter.PostNotification(LevelDialog.NotificationName.RefreshFunctionBtnShow, nil, nil)
end

function LevelDialog:RefreshTabCell(type, data, notSelectLevel, refresh)
  if not self._init or refresh then
    self._type = type
    if not self._init then
      self._init = true
      self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(self._DiffcultyRecords[self._type].backeffect))
    end
    self._data = data
    BuildNodeData(self)
    LuaNotificationCenter.PostNotification(LevelDialog.NotificationName.RefreshFunctionBtnShow, nil, nil)
  end
  if notSelectLevel then
    self:SelectLevelById(nil)
  end
  if refresh and self._selectLevelId then
    RefreshDetailPanel(self)
  end
end

function LevelDialog:SelectLevelById(levelId, hideDetail)
  if levelId then
    local data = self._levelNodeData[levelId]
    local status = data.data.status
    if status == LevelStateEnum.LOCK then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100298)
    elseif status == LevelStateEnum.UNSTART then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100296)
    elseif not (self._selectLevelId == levelId or self._selectLevelId) or self._selectLevelId and self._selectLevelId ~= self._SpecialBossLevelMap[levelId] then
      if self._selectLevelId then
        local info = self._levelNodeData[self._selectLevelId]
        if info.isBoss then
          DialogManager.DestroySingletonDialog(self._BossLevelDetailDialogName)
        end
      end
      local playResourceSelectDetailHide
      if data.isBoss and (status ~= LevelStateEnum.UNCLEAR or data.record.forebattleplot == -1 or self._chatdialogId and self._chatdialogId == data.record.forebattleplot) then
        local info = self._levelNodeData[self._selectLevelId]
        if hideDetail or info and not info.isBoss then
          playResourceSelectDetailHide = true
        end
        if playResourceSelectDetailHide then
          self:ResourceSelectDetailHide()
        end
        self._selectLevelId = levelId
        DialogManager.CreateSingletonChildDialog(self._BossLevelDetailDialogName, self._delegate._dialogName, self._delegate:GetRootWindow()):Init(self)
      else
        self._selectLevelId = levelId
        self:ResourceSelectDetailShow()
      end
      for k, v in pairs(self._levelNodeData) do
        if v.data then
          v.dialog:OnEvent("SetSelected")
        end
      end
      local info = self._levelNodeData[self._selectLevelId]
      if info then
        local anchor, offset = self._levelPanel:GetXPosition()
        local startPos = UIManager.InverseTransformPoint(self._rootWindow._uiObject, CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(info.dialog._rootWindow._uiObject)))
        local delta = self._screenWidth / 2 - self._detail_back_width - self._levelCellWidth / 2 - (offset - self._levelPanel_offset)
        if delta < startPos.x then
          self._moveTask = Tween.new(0.2, {posX = offset}, {
            posX = self._levelPanel_offset - (startPos.x - delta)
          }, "linear")
          DialogManager.CreateSingletonDialog("guide.blockclickdialog")
        elseif offset < self._levelPanel_offset and info.posData.cX <= self._levelPanel_width / 2 then
          self._moveTask = Tween.new(0.2, {posX = offset}, {
            posX = self._levelPanel_offset
          }, "linear")
          DialogManager.CreateSingletonDialog("guide.blockclickdialog")
        end
      end
    end
  elseif self._selectLevelId then
    local info = self._levelNodeData[self._selectLevelId]
    self._selectLevelId = nil
    for k, v in pairs(self._levelNodeData) do
      if v.data then
        v.dialog:OnEvent("SetSelected")
      end
    end
    if info.isBoss then
      DialogManager.DestroySingletonDialog(self._BossLevelDetailDialogName)
      if self._detailShow then
        self:ResourceSelectDetailHide()
      end
    else
      self:ResourceSelectDetailHide()
    end
    local anchor, offset = self._levelPanel:GetXPosition()
    if offset ~= self._levelPanel_offset then
      self._moveTask = Tween.new(0.2, {posX = offset}, {
        posX = self._levelPanel_offset
      }, "linear")
      DialogManager.CreateSingletonDialog("guide.blockclickdialog")
    end
  end
end

function LevelDialog:OnUpdate(notification)
  if self._moveTask then
    if self._moveTask:update(notification.userInfo.deltaTime) then
      self._levelPanel:SetXPosition(self._levelPanel_anchor, self._moveTask.target.posX)
      self._moveTask = nil
      DialogManager.DestroySingletonDialog("guide.blockclickdialog")
    else
      self._levelPanel:SetXPosition(self._levelPanel_anchor, self._moveTask.subject.posX)
    end
  end
end

function LevelDialog:OnAutoBtnClicked()
  local temp = self._levelNodeData[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if record.spirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = DungeonType.ACTIVITY
      data.id = self._selectLevelId
      data.spirit = record.spirit
      dialog:SetInfo(data)
    end
  end
end

function LevelDialog:OnAutoBtnClickAreaClicked()
  NekoData.BehaviorManager.BM_Message:SendMessageById(100473)
end

function LevelDialog:OnGoBtnClicked(bossLevelId)
  local levelId
  if bossLevelId and type(bossLevelId) == "number" then
    levelId = bossLevelId
  else
    levelId = self._selectLevelId
  end
  local temp = self._levelNodeData[levelId]
  local record = temp.record
  local data = temp.data
  if data.status == LevelStateEnum.UNCLEAR then
    if record.forebattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.forebattleplot) then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        self._chatdialogId = record.forebattleplot
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.StarMirage)
      end
    else
      EnterTeamEdit(self, levelId)
    end
  elseif data.status == LevelStateEnum.BEFORE_CLEAR then
    EnterTeamEdit(self, levelId)
  elseif data.status == LevelStateEnum.CLEAR then
    if record.afterbattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.afterbattleplot) then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        self._chatdialogId = record.afterbattleplot
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.StarMirage)
      end
    end
  elseif data.status == LevelStateEnum.PASSED then
    EnterTeamEdit(self, levelId)
  end
end

function LevelDialog:ResourceSelectDetailShow()
  if not self._willShowDetail then
    self._detailShow = true
    self:GetRootWindow():PlayAnimation("ResourceSelectDetailShow")
    RefreshDetailPanel(self)
  end
end

function LevelDialog:ResourceSelectDetailHide()
  self._detailShow = false
  self:GetRootWindow():PlayAnimation("ResourceSelectDetailHide")
end

function LevelDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "MainLevel1Show" then
    local levelId, afterbattleplot = self._bm:GetClearLevelIdAndPlotId(self._type)
    if afterbattleplot and (not self._chatdialogId or self._chatdialogId ~= afterbattleplot) then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        self._chatdialogId = afterbattleplot
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.StarMirage)
      end
    end
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
    if self._willShowDetail then
      self._willShowDetail = false
      self:ResourceSelectDetailShow()
    end
  end
end

function LevelDialog:NumberOfCell(frame, index)
  if frame == self._detail_rewardFrame then
    return #self._rewardList
  end
end

function LevelDialog:CellAtIndex(frame, index)
  if frame == self._detail_rewardFrame then
    return "activity.starmirage.rewardcell"
  end
end

function LevelDialog:DataAtIndex(frame, index)
  if frame == self._detail_rewardFrame then
    return self._rewardList[index]
  end
end

return LevelDialog
