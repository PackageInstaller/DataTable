local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local CStarryMirrorDiffculty = BeanManager.GetTableByName("dungeonselect.cstarrymirrordiffculty")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local Num = 4
local BossLevelId = 10007
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local EasyTabCell = class("EasyTabCell", Dialog)
EasyTabCell.AssetBundleName = "ui/layouts.activitystar"
EasyTabCell.AssetName = "ActivityStarMainLevel1"

function EasyTabCell:Ctor(...)
  EasyTabCell.super.Ctor(self, ...)
  self._levelRecords = {}
  self._levelTargetMap = {}
  local allIds = CStarrymirrorlevel:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CStarrymirrorlevel:GetRecorder(allIds[i])
    self._levelRecords[record.id] = record
    for _, v in ipairs(record.levellinetarget) do
      if not self._levelTargetMap[v] then
        self._levelTargetMap[v] = {}
      end
      self._levelTargetMap[v][record.id] = true
    end
  end
  self._roleAddRecordList = {}
  allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == DataCommon.Activities.StarMirage then
      table.insert(self._roleAddRecordList, record)
    end
  end
  table.sort(self._roleAddRecordList, function(a, b)
    return a.sort < b.sort
  end)
  self._levelNodeLineData = {}
  self._levelNodeData = {}
  self._selectLevelId = nil
  self._rewardList = {}
  self._init = false
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID)
end

function EasyTabCell:OnCreate()
  self._levelPanel = self:GetChild("LevelFrame")
  self._backEffect = self:GetChild("Effect")
  self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(CStarryMirrorDiffculty:GetRecorder(DataCommon.StarMirage.Type.Easy).backeffect))
  self._detail_back = self:GetChild("Detail/Level1/DetailBack")
  self._detail_name = self:GetChild("Detail/Level1/LevelNum")
  self._levelPanel_width, self._levelPanel_height = self._levelPanel:GetRectSize()
  self._levelPanel_anchor, self._levelPanel_offset = self._levelPanel:GetXPosition()
  self._detail_back_width, self._detail_back_height = self._detail_back:GetRectSize()
  self._screenWidth, self._screenHeight = self:GetRootWindow():GetRectSize()
  self._detail1Panel = self:GetChild("Detail/Level1/Detail1")
  self._recommendCapacity = self:GetChild("Detail/Level1/Detail1/Txt2")
  self._recommendBreakLv = self:GetChild("Detail/Level1/Detail1/BreakNumTxt")
  self._detail1Panel_NoBreak = self:GetChild("Detail/Level1/Detail1_NoneBreak")
  self._recommendCapacity_NoBreak = self:GetChild("Detail/Level1/Detail1_NoneBreak/Txt2")
  self._detail_describe = self:GetChild("Detail/Level1/Detail2/Txt")
  self._detail_rewardPanel = self:GetChild("Detail/Level1/CellPanel")
  self._detail_power = self:GetChild("Detail/Level1/CostBack/Txt2")
  self._detail_powerRed = self:GetChild("Detail/Level1/CostBack/Txt2Red")
  self._detail_autoBtn = self:GetChild("Detail/Level1/AutoBtn")
  self._detail_autoBtnTips = self:GetChild("Detail/Level1/AutoBtn/Tips")
  self._detail_autoBtnTips:SetActive(false)
  self._detail_autoBtnClickArea = self:GetChild("Detail/Level1/Click")
  self._detail_goBtn = self:GetChild("Detail/Level1/GoBtn")
  self._detail_goBtnCenter = self:GetChild("Detail/Level1/GoBtnCenter")
  self._detail_rewardFrame = TableFrame.Create(self._detail_rewardPanel, self, false, true)
  self._detail_autoBtn:Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  self._detail_autoBtnClickArea:Subscribe_PointerClickEvent(self.OnAutoBtnClickAreaClicked, self)
  self._detail_goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._detail_goBtnCenter:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._accumulateRewardBtn = self:GetChild("AccountBtn")
  self._accumulateRewardBtn_redDot = self:GetChild("AccountBtn/RedDot")
  self._shopBtn = self:GetChild("ShopBtn")
  self._rankBtn = self:GetChild("RankBtn")
  self._roleAddPanel = self:GetChild("TitleBack")
  self:GetChild("TitleBack/Txt"):SetText(TextManager.GetText(1900585))
  self._roleAddPanel_framePanel = self:GetChild("TitleBack/CharFrame")
  self._roleAddPanel_frame = TableFrame.Create(self._roleAddPanel_framePanel, self, false, true)
  self._accumulateRewardBtn:Subscribe_PointerClickEvent(self.OnAccumulateRewardBtnClicked, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._rootWindow:Subscribe_StateExitEvent(self.OnStateExit, self)
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self:RefreshActivityRewards()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  local cellDialog = DialogManager.CreateDialog("activity.starmirage.levelcell", nil)
  self._levelCellWidth, self._levelCellHeight = cellDialog._rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  cellDialog = DialogManager.CreateDialog("activity.starmirage.levelbosscell", nil)
  self._levelBossCellWidth, self._levelBossCellHeight = cellDialog._rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
end

function EasyTabCell:OnDestroy()
  if self._autoTipsShowTask then
    GameTimer.RemoveTask(self._autoTipsShowTask)
    self._autoTipsShowTask = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  self._detail_rewardFrame:Destroy()
  self._roleAddPanel_frame:Destroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
end

function EasyTabCell:OnRefreshSpirit(notification)
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

local function EnterTeamEdit(self)
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) and not self._bm:IsBossLevel(self._selectLevelId) then
    NekoData.DataManager.DM_Team:ClearSupportRole()
    NekoData.BehaviorManager.BM_Team:SaveTeamEditCopyInfo("StarMirage", self._selectLevelId)
    local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    if self._bm:IsBossLevel(self._selectLevelId) then
      NekoData.DataManager.DM_Team:ClearSupportRole()
    end
    local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("StarMirage", self._selectLevelId)
    end
  end
end

function EasyTabCell:OnNPCChatEnd(notification)
  if self._chatdialogId == notification.userInfo then
    local record
    for k, v in pairs(self._levelRecords) do
      if self._chatdialogId == v.forebattleplot or self._chatdialogId == v.afterbattleplot then
        record = v
        break
      end
    end
    if record then
      if self._chatdialogId == record.forebattleplot then
        EnterTeamEdit(self)
      elseif self._chatdialogId == record.afterbattleplot then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.AFTER_BATTLE
        protocol.activity = DataCommon.Activities.StarMirage
        protocol.battleID = record.id
        protocol:Send()
      end
    end
  end
end

function EasyTabCell:RefreshActivityRewards()
  self._accumulateRewardBtn_redDot:SetActive(NekoData.BehaviorManager.BM_Activity:HaveGetRewardById(DataCommon.StarMirageManagerID))
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
  for levelId, record in pairs(self._levelRecords) do
    levelPosData[levelId] = {}
    local pos = string.split(record.levelentrylocation, ",")
    local isBoss = record.bosslevelornot == 2
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
  for k, v in pairs(levelPosData) do
    local record = self._levelRecords[k]
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
      dialog = DialogManager.CreateDialog("activity.starmirage.levelcell", self._levelPanel._uiObject)
    else
      dialog = DialogManager.CreateDialog("activity.starmirage.levelbosscell", self._levelPanel._uiObject)
    end
    dialog._rootWindow:SetPosition(0, v.x, 0, v.y)
    if levelDataMap[k] then
      dialog._rootWindow:SetActive(true)
      dialog:SetData(self, info)
    else
      dialog._rootWindow:SetActive(false)
    end
    self._levelNodeData[k].dialog = dialog
  end
end

local function RefreshFunctionBtnShow(self)
  self._accumulateRewardBtn:SetActive(self._bm:IsUnlockFunctionById(DataCommon.StarMirage.Function.AccumulateRewardsId))
  self._shopBtn:SetActive(self._bm:IsUnlockFunctionById(DataCommon.StarMirage.Function.ShopId))
  self._rankBtn:SetActive(self._bm:IsUnlockFunctionById(DataCommon.StarMirage.Function.RankId))
  local value = self._bm:IsUnlockFunctionById(DataCommon.StarMirage.Function.RoleAddId)
  if value then
    self._roleAddPanel:SetActive(true)
    self._roleAddPanel_frame:ReloadAllCell()
  else
    self._roleAddPanel:SetActive(false)
  end
end

local function RefreshDetailPanel(self)
  local temp = self._levelNodeData[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  self._detail_name:SetText(TextManager.GetText(record.levelname))
  local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(data.recommendLevel).clientBreakLevel
  local clientLevel = CRoleLevelCfgTable:GetRecorder(data.recommendLevel).clientLevel
  self._detail1Panel:SetActive(0 < clientBreakLevel)
  self._detail1Panel_NoBreak:SetActive(clientBreakLevel == 0)
  if 0 < clientBreakLevel then
    self._recommendCapacity:SetText(clientLevel)
    self._recommendBreakLv:SetText(clientBreakLevel)
  else
    self._recommendCapacity_NoBreak:SetText(clientLevel)
  end
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
end

function EasyTabCell:RefreshByProtocol(data)
  if not self._init then
    self._init = true
    self._data = self._delegate._levelMap[DataCommon.StarMirage.Type.Easy]
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
    if info.battletype == DataCommon.StarMirage.Type.Easy then
      local v = self._bm:GetLevelInfo(info.battletype, info.id)
      if self._levelNodeData[v.levelId] and self._levelNodeData[v.levelId].data then
        self._levelNodeData[v.levelId].data = v
        self._levelNodeData[v.levelId].dialog:SetData(self, self._levelNodeData[v.levelId])
      else
        local levelId = v.levelId
        local record = self._levelRecords[levelId]
        if record then
          self._levelNodeData[levelId].data = v
        else
          LogErrorFormat("EasyTabCell", "Can not find record by levelId: %s.", levelId)
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
  RefreshFunctionBtnShow(self)
end

function EasyTabCell:RefreshTabCell(data, notSelectLevel, refresh)
  if not self._init or refresh then
    self._init = true
    self._data = data
    BuildNodeData(self)
    RefreshFunctionBtnShow(self)
  end
  if notSelectLevel then
    self:SelectLevelById(nil)
  end
  if refresh and self._selectLevelId then
    RefreshDetailPanel(self)
  end
end

function EasyTabCell:SelectLevelById(levelId)
  if levelId then
    local data = self._levelNodeData[levelId]
    local status = data.data.status
    if status == LevelStateEnum.LOCK then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100298)
    elseif status == LevelStateEnum.UNSTART then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100296)
    elseif self._selectLevelId ~= levelId then
      if self._selectLevelId then
        local info = self._levelNodeData[self._selectLevelId]
        if info.isBoss then
          DialogManager.DestroySingletonDialog("activity.starmirage.bossleveldetaildialog")
        end
      end
      local playResourceSelectDetailHide
      if data.isBoss then
        local info = self._levelNodeData[self._selectLevelId]
        if info and not info.isBoss then
          playResourceSelectDetailHide = true
        end
        if playResourceSelectDetailHide then
          self:GetRootWindow():PlayAnimation("ResourceSelectDetailHide")
        end
        self._selectLevelId = levelId
        DialogManager.CreateSingletonChildDialog("activity.starmirage.bossleveldetaildialog", self._delegate._dialogName, self._delegate:GetRootWindow()):Init(self, data.data)
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
      DialogManager.DestroySingletonDialog("activity.starmirage.bossleveldetaildialog")
    else
      self:GetRootWindow():PlayAnimation("ResourceSelectDetailHide")
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

function EasyTabCell:OnUpdate(notification)
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

function EasyTabCell:OnAutoBtnClicked()
  local temp = self._levelNodeData[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if record.spirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreStarMirage"
      data.id = self._selectLevelId
      data.spirit = record.spirit
      dialog:SetInfo(data)
    end
  end
end

function EasyTabCell:OnAutoBtnClickAreaClicked()
  if self._autoGoBtnTipsNotShow then
    self._detail_autoBtnTips:SetActive(true)
    if self._autoTipsShowTask then
      GameTimer.RemoveTask(self._autoTipsShowTask)
      self._autoTipsShowTask = nil
    end
    self._autoTipsShowTask = GameTimer.AddTask(3, -1, function()
      self._detail_autoBtnTips:SetActive(false)
    end)
  end
end

function EasyTabCell:OnGoBtnClicked()
  local temp = self._levelNodeData[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if record.spirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  elseif data.status == LevelStateEnum.UNCLEAR then
    if record.forebattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.forebattleplot) then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        self._chatdialogId = record.forebattleplot
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.StarMirage)
      end
    else
      EnterTeamEdit(self)
    end
  elseif data.status == LevelStateEnum.CLEAR then
    if record.afterbattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.afterbattleplot) then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        self._chatdialogId = record.afterbattleplot
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.StarMirage)
      end
    end
  elseif data.status == LevelStateEnum.PASSED then
    EnterTeamEdit(self)
  end
end

function EasyTabCell:OnAccumulateRewardBtnClicked()
  DialogManager.CreateSingletonDialog("activity.starmirage.accumulaterewarddialog")
end

function EasyTabCell:OnShopBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  protocol.shopId = DataCommon.StarMirage.Shop.EasyId
  protocol:Send()
end

function EasyTabCell:OnRankBtnClicked()
  DialogManager.CreateSingletonDialog("activity.starmirage.rankmaindialog"):SetType(DataCommon.Activities.StarMirage, DataCommon.StarMirage.Type.Easy)
end

function EasyTabCell:ResourceSelectDetailShow()
  if not self._willShowDetail then
    self:GetRootWindow():PlayAnimation("ResourceSelectDetailShow")
    RefreshDetailPanel(self)
  end
end

function EasyTabCell:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "MainLevel1Show" then
    if self._bm:CanEnterBattle() then
      local bossLevelInfo = self._bm:GetLevelInfo(DataCommon.StarMirage.Type.Easy, BossLevelId)
      if bossLevelInfo and bossLevelInfo.status ~= LevelStateEnum.PASSED and bossLevelInfo.bossLevel > 0 then
        local record = self._levelRecords[BossLevelId]
        if record.afterbattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.afterbattleplot) then
          local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
          if dialog then
            self._chatdialogId = record.afterbattleplot
            dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.StarMirage)
          end
        end
      end
    end
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
    if self._willShowDetail then
      self._willShowDetail = false
      self:ResourceSelectDetailShow()
    end
  end
end

function EasyTabCell:NumberOfCell(frame, index)
  if frame == self._roleAddPanel_frame then
    return #self._roleAddRecordList
  else
    return #self._rewardList
  end
end

function EasyTabCell:CellAtIndex(frame, index)
  if frame == self._roleAddPanel_frame then
    return "activity.starmirage.roleaddcell"
  else
    return "activity.starmirage.rewardcell"
  end
end

function EasyTabCell:DataAtIndex(frame, index)
  if frame == self._roleAddPanel_frame then
    return self._roleAddRecordList[index]
  else
    return self._rewardList[index]
  end
end

return EasyTabCell
