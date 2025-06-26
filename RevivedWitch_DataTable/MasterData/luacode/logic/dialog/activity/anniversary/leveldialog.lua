-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversary/leveldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
local CAnniversaryDiffculty = (BeanManager.GetTableByName)("dungeonselect.canniversarydiffculty")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local DungeonType = (LuaNetManager.GetBeanDef)("protocol.battle.dungeontype")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local Num = 4
local ActivityId = (DataCommon.Activities).Anniversary
local ShopIdMap = {[((DataCommon.Anniversary).Type).Easy] = ((DataCommon.Anniversary).Shop).Easy, [((DataCommon.Anniversary).Type).Hard] = ((DataCommon.Anniversary).Shop).Hard}
local SpecialBossLevelMap = {[40001417] = 40001408, [40001418] = 40001416}
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local LevelDialog = class("LevelDialog", Dialog)
LevelDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
LevelDialog.AssetName = "Activity1YearAnniversaryMainLevel2"
LevelDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelDialog, CAnniversarylevel, _ENV, CEventBoostRole
  ((LevelDialog.super).Ctor)(self, ...)
  self._levelRecords = {}
  local allIds = CAnniversarylevel:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CAnniversarylevel:GetRecorder(allIds[i])
    if not record then
      LogErrorFormat("LevelDialog", "--- index = %s, id = %s ---", i, allIds[i])
    end
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._levelRecords)[record.id] = record
  end
  self._roleAddRecordList = {}
  allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == (DataCommon.Activities).Anniversary then
      (table.insert)(self._roleAddRecordList, record)
    end
  end
  ;
  (table.sort)(self._roleAddRecordList, function(a, b)
    -- function num : 0_0_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self._levelNodeData = {}
  self._selectLevelId = nil
  self._rewardList = {}
  self._init = false
  self._bm = (NekoData.BehaviorManager).BM_Anniversary
end

LevelDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._levelPanel = self:GetChild("LevelFrame")
  self._backEffect = self:GetChild("Effect")
  self._plotDetailPanel = self:GetChild("Detail/Level1")
  self._plotDetailPanel_name = self:GetChild("Detail/Level1/LevelNum")
  self._plotDetailPanel_introduction = self:GetChild("Detail/Level1/Detail2/Txt")
  self._plotDetailPanel_checkBtn = self:GetChild("Detail/Level1/Checkbtn")
  ;
  (self._plotDetailPanel_checkBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._levelDetailPanel = self:GetChild("Detail/Level2")
  self._detail_back = self:GetChild("Detail/Level2/DetailBack")
  self._detail_name = self:GetChild("Detail/Level2/LevelNum")
  self._levelPanel_width = (self._levelPanel):GetRectSize()
  self._levelPanel_anchor = (self._levelPanel):GetXPosition()
  self._detail_back_width = (self._detail_back):GetRectSize()
  self._screenWidth = (self:GetRootWindow()):GetRectSize()
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
  ;
  (self._detail_autoBtnTips):SetActive(false)
  self._detail_autoBtnClickArea = self:GetChild("Detail/Level2/Click")
  self._detail_goBtn = self:GetChild("Detail/Level2/GoBtn")
  self._detail_goBtnCenter = self:GetChild("Detail/Level2/GoBtnCenter")
  self._detail_rewardFrame = (TableFrame.Create)(self._detail_rewardPanel, self, false, true)
  ;
  (self._detail_autoBtn):Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  ;
  (self._detail_autoBtnClickArea):Subscribe_PointerClickEvent(self.OnAutoBtnClickAreaClicked, self)
  ;
  (self._detail_goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._detail_goBtnCenter):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._dailySupplyBtn = self:GetChild("PowerBtn")
  self._dailySupplyBtn_redDot = self:GetChild("PowerBtn/RedDot")
  self._dailyTaskBtn = self:GetChild("AccountBtn")
  self._dailyTaskBtn_redDot = self:GetChild("AccountBtn/RedDot")
  self._shopBtn = self:GetChild("ShopBtn")
  self._rankBtn = self:GetChild("RankBtn")
  self._roleAddPanel = self:GetChild("TitleBack")
  self._roleAddPanel_framePanel = self:GetChild("TitleBack/CharFrame")
  self._roleAddPanel_frame = (TableFrame.Create)(self._roleAddPanel_framePanel, self, false, true)
  ;
  (self._dailySupplyBtn):Subscribe_PointerClickEvent(self.OnDailySupplyBtnClicked, self)
  ;
  (self._dailyTaskBtn):Subscribe_PointerClickEvent(self.OnDailyTaskBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (self._rootWindow):Subscribe_StateExitEvent(self.OnStateExit, self)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, Common.n_RefreshAnniversaryDailyTaskList, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, Common.n_RefreshAnniversaryCumulativeTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFunctionBtnShow, Common.n_RefreshAnniversaryDailySupply, nil)
  local cellDialog = (DialogManager.CreateDialog)("activity.anniversary.levelcell", nil)
  self._levelCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
  ;
  (self:GetChild("PowerBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1998))
  ;
  (self:GetChild("AccountBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1999))
  ;
  (self:GetChild("ShopBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2000))
  ;
  (self:GetChild("RankBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2001))
  ;
  (self:GetChild("TitleBack/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2018))
  ;
  (self:GetChild("Detail/Level2/CostBack/Txt1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2023))
  ;
  (self:GetChild("Detail/Level1/Checkbtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2101))
end

LevelDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._autoTipsShowTask then
    (GameTimer.RemoveTask)(self._autoTipsShowTask)
    self._autoTipsShowTask = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._detail_rewardFrame):Destroy()
  ;
  (self._roleAddPanel_frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.spiritrecoverdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.autoexplorecontinuedialog")
  ;
  (DialogManager.DestroySingletonDialog)("npcchat.newnpcchatdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.anniversary.dailysupplydialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.anniversary.dailytaskdialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.rankmaindialog")
end

LevelDialog.OnRefreshSpirit = function(self, notification)
  -- function num : 0_3
  self._spirit = (notification.userInfo).spirit
  if self._selectLevelId then
    local temp = (self._levelNodeData)[self._selectLevelId]
    local record = temp.record
    if self._spirit < record.spirit then
      (self._detail_power):SetActive(false)
      ;
      (self._detail_powerRed):SetActive(true)
      ;
      (self._detail_powerRed):SetText(record.spirit)
    else
      ;
      (self._detail_power):SetActive(true)
      ;
      (self._detail_powerRed):SetActive(false)
      ;
      (self._detail_power):SetText(record.spirit)
    end
  end
end

local EnterTeamEdit = function(self, levelId)
  -- function num : 0_4 , upvalues : _ENV, CBattleStartProtocol
  local temp = (self._levelNodeData)[levelId]
  local record = temp.record
  if self._spirit < record.spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
    return 
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) and not (self._bm):IsBossLevel(levelId) then
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    ;
    ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo(CBattleStartProtocol.ANNIVERSARY, levelId)
    local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    do
      if (self._bm):IsBossLevel(levelId) then
        ((NekoData.DataManager).DM_Team):ClearSupportRole()
      end
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
      if dialog then
        dialog:SetCopyInfo(CBattleStartProtocol.ANNIVERSARY, levelId)
      end
    end
  end
end

LevelDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, ActivityId
  if self._chatdialogId == notification.userInfo then
    local record = nil
    for k,v in pairs(self._levelRecords) do
      if self._chatdialogId == v.forebattleplot or self._chatdialogId == v.afterbattleplot then
        record = v
        break
      end
    end
    do
      if record then
        if self._chatdialogId == record.forebattleplot then
          local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivitydramapassed")
          protocol.dramaType = protocol.BEFORE_BATTLE
          protocol.activity = ActivityId
          protocol.battleID = record.id
          protocol:Send()
        else
          do
            if self._chatdialogId == record.afterbattleplot then
              local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivitydramapassed")
              protocol.dramaType = protocol.AFTER_BATTLE
              protocol.activity = ActivityId
              protocol.battleID = record.id
              protocol:Send()
              ;
              ((NekoData.BehaviorManager).BM_Anniversary):SetLevelStatus(self._type, record.id, ((LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")).PASSED)
            end
          end
        end
      end
    end
  end
end

LevelDialog.BeforePlotFinished = function(self, levelId)
  -- function num : 0_6
  local record = (self._levelRecords)[levelId]
  if self._selectLevelId and self._selectLevelId == levelId and record and record.bosslevelornot ~= 0 then
    self._selectLevelId = nil
    self:SelectLevelById(record.id, true)
  else
    self:RefreshDetailPanel()
  end
end

local BuildNodeData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for k,v in pairs(self._levelNodeData) do
    local dialog = v.dialog
    dialog:Destroy()
    dialog:RootWindowDestroy()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._levelNodeData)[k] = nil
  end
  local levelDataMap = {}
  if self._data then
    for i,v in ipairs(self._data) do
      levelDataMap[v.levelId] = v
    end
  end
  do
    local levelPosData = {}
    for levelId,record in pairs(self._levelRecords) do
      if record.difficulty == self._type then
        levelPosData[levelId] = {}
        local pos = (string.split)(record.levelentrylocation, ",")
        local isBoss = record.bosslevelornot ~= 0
        local centerX = tonumber(pos[1]) + self._levelCellWidth / 2
        local centerY = tonumber(pos[2]) + self._levelCellHeight / 2
        levelPosData[levelId] = {x = tonumber(pos[1]), y = tonumber(pos[2]), cX = centerX, cY = centerY}
        -- DECOMPILER ERROR at PC78: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._levelNodeData)[levelId] = {data = levelDataMap[levelId], record = record, isBoss = isBoss, posData = levelPosData[levelId]}
      end
    end
    for k,v in pairs(levelPosData) do
      local info = (self._levelNodeData)[k]
      local dialog = (DialogManager.CreateDialog)("activity.anniversary.levelcell", (self._levelPanel)._uiObject)
      ;
      (dialog._rootWindow):SetPosition(0, v.x, 0, v.y)
      if levelDataMap[k] and (info.record).bosslevelornot ~= 2 then
        (dialog._rootWindow):SetActive(true)
      else
        (dialog._rootWindow):SetActive(false)
      end
      if levelDataMap[k] then
        dialog:SetData(self, info)
      end
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((self._levelNodeData)[k]).dialog = dialog
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

LevelDialog.RefreshFunctionBtnShow = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local unlock = (self._bm):IsUnlockFunctionById(((DataCommon.Anniversary).Function).DailySupply)
  ;
  (self._dailySupplyBtn):SetActive(unlock)
  if unlock then
    (self._dailySupplyBtn_redDot):SetActive((self._bm):ShowDailySupplyRedDot())
  end
  unlock = (self._bm):IsUnlockFunctionById(((DataCommon.Anniversary).Function).DailyTask)
  ;
  (self._dailyTaskBtn):SetActive(unlock)
  if unlock and not (self._bm):ShowDailyTaskRedDot() then
    (self._dailyTaskBtn_redDot):SetActive((self._bm):ShowCumulativeTaskRedDot())
    ;
    (self._shopBtn):SetActive((self._bm):IsUnlockFunctionById(((DataCommon.Anniversary).Function).Shop))
    ;
    (self._rankBtn):SetActive((self._bm):IsUnlockFunctionById(((DataCommon.Anniversary).Function).Rank))
    local value = (self._bm):IsUnlockFunctionById(((DataCommon.Anniversary).Function).RoleAdd)
    if value then
      (self._roleAddPanel):SetActive(true)
      ;
      (self._roleAddPanel_frame):ReloadAllCell()
    else
      ;
      (self._roleAddPanel):SetActive(false)
    end
  end
end

LevelDialog.RefreshDetailPanel = function(self)
  -- function num : 0_9 , upvalues : LevelStateEnum, _ENV, CRoleLevelCfgTable
  local temp = (self._levelNodeData)[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if data.status == LevelStateEnum.UNCLEAR and record.forebattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.forebattleplot) then
    (self._plotDetailPanel):SetActive(true)
    ;
    (self._levelDetailPanel):SetActive(false)
    ;
    (self._plotDetailPanel_name):SetText((TextManager.GetText)(record.leveltitle))
    ;
    (self._plotDetailPanel_introduction):SetText((TextManager.GetText)(record.plotdescribe))
  else
    ;
    (self._plotDetailPanel):SetActive(false)
    ;
    (self._levelDetailPanel):SetActive(true)
    ;
    (self._detail_name):SetText((TextManager.GetText)(record.leveltitle))
    local clientBreakLevel = (CRoleLevelCfgTable:GetRecorder(data.recommendLevel)).clientBreakLevel
    local clientLevel = (CRoleLevelCfgTable:GetRecorder(data.recommendLevel)).clientLevel
    ;
    (self._detail1Panel):SetActive(clientBreakLevel > 0)
    ;
    (self._detail1Panel_NoBreak):SetActive(clientBreakLevel == 0)
    if clientBreakLevel > 0 then
      (self._recommendCapacity):SetText(clientLevel)
      ;
      (self._recommendBreakLv):SetText(clientBreakLevel)
    else
      (self._recommendCapacity_NoBreak):SetText(clientLevel)
    end
    ;
    (self._detail_describe):SetText((TextManager.GetText)(record.levelinfo))
    if self._spirit < record.spirit then
      (self._detail_power):SetActive(false)
      ;
      (self._detail_powerRed):SetActive(true)
      ;
      (self._detail_powerRed):SetText(record.spirit)
    else
      (self._detail_power):SetActive(true)
      ;
      (self._detail_powerRed):SetActive(false)
      ;
      (self._detail_power):SetText(record.spirit)
    end
    local detail_autoBtnTag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AutoExplore)
    ;
    (self._detail_autoBtn):SetActive(detail_autoBtnTag)
    ;
    (self._detail_goBtn):SetActive(detail_autoBtnTag)
    ;
    (self._detail_goBtnCenter):SetActive(not detail_autoBtnTag)
    ;
    (self._detail_autoBtn):SetInteractable(data.firstGet)
    self._autoGoBtnTipsNotShow = not data.firstGet
    ;
    (self._detail_autoBtnTips):SetActive(false)
    if self._autoTipsShowTask then
      (GameTimer.RemoveTask)(self._autoTipsShowTask)
      self._autoTipsShowTask = nil
    end
    while (self._rewardList)[#self._rewardList] do
      (table.remove)(self._rewardList, #self._rewardList)
    end
    for i,v in ipairs(data.firstItems) do
      (table.insert)(self._rewardList, {tag = "First", data = v})
    end
    for i,v in ipairs(data.normalItems) do
      (table.insert)(self._rewardList, {tag = "Normal", data = v})
    end
    for i,v in ipairs(data.randItems) do
      (table.insert)(self._rewardList, {tag = "Random", data = v})
    end
    ;
    (self._detail_rewardFrame):ReloadAllCell()
  end
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

LevelDialog.RefreshByProtocol = function(self, data)
  -- function num : 0_10 , upvalues : BuildNodeData, _ENV
  if not self._init then
    self._init = true
    self._data = ((self._delegate)._levelMap)[self._type]
    BuildNodeData(self)
  end
  for i,info in ipairs(data) do
    if info.battletype == self._type then
      local v = (self._bm):GetLevelInfo(info.battletype, info.id)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

      if (self._levelNodeData)[v.levelId] and ((self._levelNodeData)[v.levelId]).data then
        ((self._levelNodeData)[v.levelId]).data = v
        ;
        (((self._levelNodeData)[v.levelId]).dialog):SetData(self, (self._levelNodeData)[v.levelId])
      else
        local levelId = v.levelId
        local record = (self._levelRecords)[levelId]
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R10 in 'UnsetPending'

        if record then
          ((self._levelNodeData)[levelId]).data = v
        else
          LogErrorFormat("LevelDialog", "Can not find record by levelId: %s.", levelId)
        end
        local info = (self._levelNodeData)[levelId]
        local dialog = info.dialog
        ;
        (dialog._rootWindow):SetActive(true)
        dialog:SetData(self, info)
        dialog:PlayAnimation()
      end
    end
  end
  self:RefreshFunctionBtnShow()
end

LevelDialog.RefreshTabCell = function(self, type, data, notSelectLevel, refresh)
  -- function num : 0_11 , upvalues : _ENV, CAnniversaryDiffculty, BuildNodeData
  if not self._init or refresh then
    self._type = type
    if not self._init then
      self._init = true
      ;
      (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)((CAnniversaryDiffculty:GetRecorder(self._type)).backeffect))
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

LevelDialog.SelectLevelById = function(self, levelId, hideDetail)
  -- function num : 0_12 , upvalues : LevelStateEnum, _ENV, SpecialBossLevelMap, UIManager, TransformStaticFunctions
  if levelId then
    local data = (self._levelNodeData)[levelId]
    local status = (data.data).status
    if status == LevelStateEnum.LOCK then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100298)
    else
      if status == LevelStateEnum.UNSTART then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100296)
      else
        if (self._selectLevelId ~= levelId and not self._selectLevelId) or self._selectLevelId and self._selectLevelId ~= SpecialBossLevelMap[levelId] then
          do
            if self._selectLevelId then
              local info = (self._levelNodeData)[self._selectLevelId]
              if info.isBoss then
                (DialogManager.DestroySingletonDialog)("activity.anniversary.bossleveldetaildialog")
              end
            end
            local playResourceSelectDetailHide = nil
            if data.isBoss and (status ~= LevelStateEnum.UNCLEAR or (data.record).forebattleplot == -1 or not self._chatdialogId or self._chatdialogId == (data.record).forebattleplot) then
              local info = (self._levelNodeData)[self._selectLevelId]
              if hideDetail or info and not info.isBoss then
                playResourceSelectDetailHide = true
              end
              if playResourceSelectDetailHide then
                self:ResourceSelectDetailHide()
              end
              self._selectLevelId = levelId
              ;
              ((DialogManager.CreateSingletonChildDialog)("activity.anniversary.bossleveldetaildialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())):Init(self)
            else
              do
                self._selectLevelId = levelId
                self:ResourceSelectDetailShow()
                for k,v in pairs(self._levelNodeData) do
                  if v.data then
                    (v.dialog):OnEvent("SetSelected")
                  end
                end
                local info = (self._levelNodeData)[self._selectLevelId]
                if info then
                  local anchor, offset = (self._levelPanel):GetXPosition()
                  local startPos = (UIManager.InverseTransformPoint)((self._rootWindow)._uiObject, ((CS.UnityEngine).Vector3)((TransformStaticFunctions.GetPosition)(((info.dialog)._rootWindow)._uiObject)))
                  local delta = self._screenWidth / 2 - self._detail_back_width - self._levelCellWidth / 2 - (offset - self._levelPanel_offset)
                  if delta < startPos.x then
                    self._moveTask = (Tween.new)(0.2, {posX = offset}, {posX = self._levelPanel_offset - (startPos.x - delta)}, "linear")
                    ;
                    (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                  else
                    if offset < self._levelPanel_offset and (info.posData).cX <= self._levelPanel_width / 2 then
                      self._moveTask = (Tween.new)(0.2, {posX = offset}, {posX = self._levelPanel_offset}, "linear")
                      ;
                      (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                    end
                  end
                end
                do
                  if self._selectLevelId then
                    local info = (self._levelNodeData)[self._selectLevelId]
                    self._selectLevelId = nil
                    for k,v in pairs(self._levelNodeData) do
                      if v.data then
                        (v.dialog):OnEvent("SetSelected")
                      end
                    end
                    if info.isBoss then
                      (DialogManager.DestroySingletonDialog)("activity.anniversary.bossleveldetaildialog")
                      if self._detailShow then
                        self:ResourceSelectDetailHide()
                      end
                    else
                      self:ResourceSelectDetailHide()
                    end
                    local anchor, offset = (self._levelPanel):GetXPosition()
                    if offset ~= self._levelPanel_offset then
                      self._moveTask = (Tween.new)(0.2, {posX = offset}, {posX = self._levelPanel_offset}, "linear")
                      ;
                      (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

LevelDialog.OnUpdate = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  if self._moveTask then
    if (self._moveTask):update((notification.userInfo).deltaTime) then
      (self._levelPanel):SetXPosition(self._levelPanel_anchor, ((self._moveTask).target).posX)
      self._moveTask = nil
      ;
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    else
      ;
      (self._levelPanel):SetXPosition(self._levelPanel_anchor, ((self._moveTask).subject).posX)
    end
  end
end

LevelDialog.OnAutoBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV, DungeonType
  local temp = (self._levelNodeData)[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if self._spirit < record.spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = DungeonType.ACTIVITY
      data.id = self._selectLevelId
      data.spirit = record.spirit
      dialog:SetInfo(data)
    end
  end
end

LevelDialog.OnAutoBtnClickAreaClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self._autoGoBtnTipsNotShow then
    (self._detail_autoBtnTips):SetActive(true)
    if self._autoTipsShowTask then
      (GameTimer.RemoveTask)(self._autoTipsShowTask)
      self._autoTipsShowTask = nil
    end
    self._autoTipsShowTask = (GameTimer.AddTask)(3, -1, function()
    -- function num : 0_15_0 , upvalues : self
    (self._detail_autoBtnTips):SetActive(false)
  end
)
  end
end

LevelDialog.OnGoBtnClicked = function(self, bossLevelId)
  -- function num : 0_16 , upvalues : _ENV, LevelStateEnum, EnterTeamEdit
  local levelId = nil
  if bossLevelId and type(bossLevelId) == "number" then
    levelId = bossLevelId
  else
    levelId = self._selectLevelId
  end
  local temp = (self._levelNodeData)[levelId]
  local record = temp.record
  local data = temp.data
  if data.status == LevelStateEnum.UNCLEAR then
    if record.forebattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.forebattleplot) then
      local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
      if dialog then
        self._chatdialogId = record.forebattleplot
        dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).Anniversary)
      end
    else
      do
        EnterTeamEdit(self, levelId)
        if data.status == LevelStateEnum.BEFORE_CLEAR then
          EnterTeamEdit(self, levelId)
        else
          -- DECOMPILER ERROR at PC76: Unhandled construct in 'MakeBoolean' P1

          if data.status == LevelStateEnum.CLEAR and record.afterbattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.afterbattleplot) then
            local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
            if dialog then
              self._chatdialogId = record.afterbattleplot
              dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).Anniversary)
            end
          end
        end
        do
          if data.status == LevelStateEnum.PASSED then
            EnterTeamEdit(self, levelId)
          end
        end
      end
    end
  end
end

LevelDialog.OnDailySupplyBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.anniversary.dailysupplydialog")
end

LevelDialog.OnDailyTaskBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.anniversary.dailytaskdialog")
end

LevelDialog.OnShopBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV, ShopIdMap
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  protocol.shopId = ShopIdMap[self._type]
  protocol:Send()
end

LevelDialog.OnRankBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV, ActivityId
  ((DialogManager.CreateSingletonDialog)("activity.starmirage.rankmaindialog")):SetType(ActivityId, ((DataCommon.StarMirage).Type).Easy)
end

LevelDialog.ResourceSelectDetailShow = function(self)
  -- function num : 0_21
  if not self._willShowDetail then
    self._detailShow = true
    ;
    (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailShow")
    self:RefreshDetailPanel()
  end
end

LevelDialog.ResourceSelectDetailHide = function(self)
  -- function num : 0_22
  self._detailShow = false
  ;
  (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailHide")
end

LevelDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_23 , upvalues : _ENV
  if stateName == "MainLevel1Show" then
    local levelId, afterbattleplot = (self._bm):GetClearLevelIdAndPlotId(self._type)
    do
      if afterbattleplot and (not self._chatdialogId or self._chatdialogId ~= afterbattleplot) then
        local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
        if dialog then
          self._chatdialogId = afterbattleplot
          dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).Anniversary)
        end
      end
      ;
      (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
      if self._willShowDetail then
        self._willShowDetail = false
        self:ResourceSelectDetailShow()
      end
    end
  end
end

LevelDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_24
  if frame == self._roleAddPanel_frame then
    return #self._roleAddRecordList
  else
    return #self._rewardList
  end
end

LevelDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_25
  if frame == self._roleAddPanel_frame then
    return "activity.starmirage.roleaddcell"
  else
    return "activity.starmirage.rewardcell"
  end
end

LevelDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_26
  if frame == self._roleAddPanel_frame then
    return (self._roleAddRecordList)[index]
  else
    return (self._rewardList)[index]
  end
end

return LevelDialog

