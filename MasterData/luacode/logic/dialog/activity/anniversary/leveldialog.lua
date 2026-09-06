local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local CAnniversarylevel = BeanManager.GetTableByName("dungeonselect.canniversarylevel")
local CAnniversaryDiffculty = BeanManager.GetTableByName("dungeonselect.canniversarydiffculty")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local DungeonType = LuaNetManager.GetBeanDef("protocol.battle.dungeontype")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local Num = 4
local ActivityId = DataCommon.Activities.Anniversary
local ShopIdMap = {
  [DataCommon.Anniversary.Type.Easy] = DataCommon.Anniversary.Shop.Easy,
  [DataCommon.Anniversary.Type.Hard] = DataCommon.Anniversary.Shop.Hard
}
local SpecialBossLevelMap = {
  [40001417] = 40001408,
  [40001418] = 40001416
}
local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local LevelDialog = class("LevelDialog", Dialog)
LevelDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
LevelDialog.AssetName = "Activity1YearAnniversaryMainLevel2"

function LevelDialog:Ctor(...)
  LevelDialog.super.Ctor(self, ...)
  self._levelRecords = {}
  local allIds = CAnniversarylevel:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CAnniversarylevel:GetRecorder(allIds[i])
    if not record then
      LogErrorFormat("LevelDialog", "--- index = %s, id = %s ---", i, allIds[i])
    end
    self._levelRecords[record.id] = record
  end
  self._roleAddRecordList = {}
  allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == DataCommon.Activities.Anniversary then
      table.insert(self._roleAddRecordList, record)
    end
  end
  table.sort(self._roleAddRecordList, function(a, b)
    return a.sort < b.sort
  end)
  self._levelNodeData = {}
  self._selectLevelId = nil
  self._rewardList = {}
  self._init = false
  self._bm = NekoData.BehaviorManager.BM_Anniversary
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
  self._detail1Panel_NoBreak = self:GetChild("Detail/Level2/Detail1_NoneBreak")
  self._recommendCapacity_NoBreak = self:GetChild("Detail/Level2/Detail1_NoneBreak/Txt2")
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
  self._dailySupplyBtn = self:GetChild("PowerBtn")
  self._dailySupplyBtn_redDot = self:GetChild("PowerBtn/RedDot")
  self._dailyTaskBtn = self:GetChild("AccountBtn")
  self._dailyTaskBtn_redDot = self:GetChild("AccountBtn/RedDot")
  self._shopBtn = self:GetChild("ShopBtn")
  self._rankBtn = self:GetChild("RankBtn")
  self._roleAddPanel = self:GetChild("TitleBack")
  self._roleAddPanel_framePanel = self:GetChild("TitleBack/CharFrame")
  self._roleAddPanel_frame = TableFrame.Create(self._roleAddPanel_framePanel, self, false, true)
  self._dailySupplyBtn:Subscribe_PointerClickEvent(self.OnDailySupplyBtnClicked, self)
  self._dailyTaskBtn:Subscribe_PointerClickEvent(self.OnDailyTaskBtnClicked, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._rootWindow:Subscribe_StateExitEvent(self.OnStateExit, self)
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFunctionBtnShow, Common.n_RefreshAnniversaryDailyTaskList, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFunctionBtnShow, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFunctionBtnShow, Common.n_RefreshAnniversaryCumulativeTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFunctionBtnShow, Common.n_RefreshAnniversaryDailySupply, nil)
  local cellDialog = DialogManager.CreateDialog("activity.anniversary.levelcell", nil)
  self._levelCellWidth, self._levelCellHeight = cellDialog._rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  self:GetChild("PowerBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1998))
  self:GetChild("AccountBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1999))
  self:GetChild("ShopBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2000))
  self:GetChild("RankBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2001))
  self:GetChild("TitleBack/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2018))
  self:GetChild("Detail/Level2/CostBack/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2023))
  self:GetChild("Detail/Level1/Checkbtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2101))
end

function LevelDialog:OnDestroy()
  if self._autoTipsShowTask then
    GameTimer.RemoveTask(self._autoTipsShowTask)
    self._autoTipsShowTask = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  self._detail_rewardFrame:Destroy()
  self._roleAddPanel_frame:Destroy()
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  DialogManager.DestroySingletonDialog("bag.spiritrecoverdialog")
  DialogManager.DestroySingletonDialog("mainline.autoexplorecontinuedialog")
  DialogManager.DestroySingletonDialog("npcchat.newnpcchatdialog")
  DialogManager.DestroySingletonDialog("activity.anniversary.dailysupplydialog")
  DialogManager.DestroySingletonDialog("activity.anniversary.dailytaskdialog")
  DialogManager.DestroySingletonDialog("activity.starmirage.rankmaindialog")
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
    NekoData.BehaviorManager.BM_Team:SaveTeamEditCopyInfo(CBattleStartProtocol.ANNIVERSARY, levelId)
    local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    if self._bm:IsBossLevel(levelId) then
      NekoData.DataManager.DM_Team:ClearSupportRole()
    end
    local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo(CBattleStartProtocol.ANNIVERSARY, levelId)
    end
  end
end

function LevelDialog:OnNPCChatEnd(notification)
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
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.BEFORE_BATTLE
        protocol.activity = ActivityId
        protocol.battleID = record.id
        protocol:Send()
      elseif self._chatdialogId == record.afterbattleplot then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.AFTER_BATTLE
        protocol.activity = ActivityId
        protocol.battleID = record.id
        protocol:Send()
        NekoData.BehaviorManager.BM_Anniversary:SetLevelStatus(self._type, record.id, LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode").PASSED)
      end
    end
  end
end

function LevelDialog:BeforePlotFinished(levelId)
  local record = self._levelRecords[levelId]
  if self._selectLevelId and self._selectLevelId == levelId and record and record.bosslevelornot ~= 0 then
    self._selectLevelId = nil
    self:SelectLevelById(record.id, true)
  else
    self:RefreshDetailPanel()
  end
end

local function BuildNodeData(self)
  for k, v in pairs(self._levelNodeData) do
    local dialog = v.dialog
    dialog:Destroy()
    dialog:RootWindowDestroy()
    self._levelNodeData[k] = nil
  end
  local levelDataMap = {}
  if self._data then
    for i, v in ipairs(self._data) do
      levelDataMap[v.levelId] = v
    end
  end
  local levelPosData = {}
  for levelId, record in pairs(self._levelRecords) do
    if record.difficulty == self._type then
      levelPosData[levelId] = {}
      local pos = string.split(record.levelentrylocation, ",")
      local isBoss = record.bosslevelornot ~= 0
      local centerX = tonumber(pos[1]) + self._levelCellWidth / 2
      local centerY = tonumber(pos[2]) + self._levelCellHeight / 2
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
    local info = self._levelNodeData[k]
    local dialog = DialogManager.CreateDialog("activity.anniversary.levelcell", self._levelPanel._uiObject)
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

function LevelDialog:RefreshFunctionBtnShow()
  local unlock = self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.DailySupply)
  self._dailySupplyBtn:SetActive(unlock)
  if unlock then
    self._dailySupplyBtn_redDot:SetActive(self._bm:ShowDailySupplyRedDot())
  end
  unlock = self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.DailyTask)
  self._dailyTaskBtn:SetActive(unlock)
  if unlock then
    self._dailyTaskBtn_redDot:SetActive(self._bm:ShowDailyTaskRedDot() or self._bm:ShowCumulativeTaskRedDot())
  end
  self._shopBtn:SetActive(self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Shop))
  self._rankBtn:SetActive(self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Rank))
  local value = self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.RoleAdd)
  if value then
    self._roleAddPanel:SetActive(true)
    self._roleAddPanel_frame:ReloadAllCell()
  else
    self._roleAddPanel:SetActive(false)
  end
end

function LevelDialog:RefreshDetailPanel()
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
end

function LevelDialog:RefreshByProtocol(data)
  if not self._init then
    self._init = true
    self._data = self._delegate._levelMap[self._type]
    BuildNodeData(self)
  end
  for i, info in ipairs(data) do
    if info.battletype == self._type then
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
          LogErrorFormat("LevelDialog", "Can not find record by levelId: %s.", levelId)
        end
        local info = self._levelNodeData[levelId]
        local dialog = info.dialog
        dialog._rootWindow:SetActive(true)
        dialog:SetData(self, info)
        dialog:PlayAnimation()
      end
    end
  end
  self:RefreshFunctionBtnShow()
end

function LevelDialog:RefreshTabCell(type, data, notSelectLevel, refresh)
  if not self._init or refresh then
    self._type = type
    if not self._init then
      self._init = true
      self._backEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(CAnniversaryDiffculty:GetRecorder(self._type).backeffect))
    end
    self._data = data
    BuildNodeData(self)
    self:RefreshFunctionBtnShow()
  end
  if notSelectLevel then
    self:SelectLevelById(nil)
  end
  if refresh and self._selectLevelId then
    self:RefreshDetailPanel()
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
    elseif not (self._selectLevelId == levelId or self._selectLevelId) or self._selectLevelId and self._selectLevelId ~= SpecialBossLevelMap[levelId] then
      if self._selectLevelId then
        local info = self._levelNodeData[self._selectLevelId]
        if info.isBoss then
          DialogManager.DestroySingletonDialog("activity.anniversary.bossleveldetaildialog")
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
        DialogManager.CreateSingletonChildDialog("activity.anniversary.bossleveldetaildialog", self._delegate._dialogName, self._delegate:GetRootWindow()):Init(self)
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
      DialogManager.DestroySingletonDialog("activity.anniversary.bossleveldetaildialog")
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
  if record.spirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.offlinesweepcontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "DispatchAnniversary"
      data.id = self._selectLevelId
      data.name = TextManager.GetText(record.leveltitle)
      data.spirit = record.spirit
      data.timelength = 1
      dialog:SetInfo(data)
    end
  end
end

function LevelDialog:OnAutoBtnClickAreaClicked()
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
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Anniversary)
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
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Anniversary)
      end
    end
  elseif data.status == LevelStateEnum.PASSED then
    EnterTeamEdit(self, levelId)
  end
end

function LevelDialog:OnDailySupplyBtnClicked()
  DialogManager.CreateSingletonDialog("activity.anniversary.dailysupplydialog")
end

function LevelDialog:OnDailyTaskBtnClicked()
  DialogManager.CreateSingletonDialog("activity.anniversary.dailytaskdialog")
end

function LevelDialog:OnShopBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  protocol.shopId = ShopIdMap[self._type]
  protocol:Send()
end

function LevelDialog:OnRankBtnClicked()
  DialogManager.CreateSingletonDialog("activity.starmirage.rankmaindialog"):SetType(ActivityId, DataCommon.StarMirage.Type.Easy)
end

function LevelDialog:ResourceSelectDetailShow()
  if not self._willShowDetail then
    self._detailShow = true
    self:GetRootWindow():PlayAnimation("ResourceSelectDetailShow")
    self:RefreshDetailPanel()
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
        dialog:SetDialogLibraryId(self._chatdialogId, false, dialog.DialogType.Anniversary)
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
  if frame == self._roleAddPanel_frame then
    return #self._roleAddRecordList
  else
    return #self._rewardList
  end
end

function LevelDialog:CellAtIndex(frame, index)
  if frame == self._roleAddPanel_frame then
    return "activity.starmirage.roleaddcell"
  else
    return "activity.starmirage.rewardcell"
  end
end

function LevelDialog:DataAtIndex(frame, index)
  if frame == self._roleAddPanel_frame then
    return self._roleAddRecordList[index]
  else
    return self._rewardList[index]
  end
end

return LevelDialog
