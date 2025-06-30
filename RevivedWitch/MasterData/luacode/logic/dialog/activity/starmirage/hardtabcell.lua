-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/hardtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local Role = require("logic.manager.experimental.types.role")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CStarryMirrorEnemyBoost = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorenemyboost")
local CStarryMirrorDiffculty = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrordiffculty")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local ColumnNum = 2
local Num = 4
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local HardTabCell = class("HardTabCell", Dialog)
HardTabCell.AssetBundleName = "ui/layouts.activitystar"
HardTabCell.AssetName = "ActivityStarMainLevel2"
HardTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HardTabCell, CStarrymirrorlevel, _ENV, CStarryMirrorEnemyBoost, CEventBoostRole
  ((HardTabCell.super).Ctor)(self, ...)
  self._levelRecords = {}
  self._levelTargetMap = {}
  local allIds = CStarrymirrorlevel:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CStarrymirrorlevel:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._levelRecords)[record.id] = record
    for _,v in ipairs(record.levellinetarget) do
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R13 in 'UnsetPending'

      if not (self._levelTargetMap)[v] then
        (self._levelTargetMap)[v] = {}
      end
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self._levelTargetMap)[v])[record.id] = true
    end
  end
  self._entryRecords = {}
  allIds = CStarryMirrorEnemyBoost:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CStarryMirrorEnemyBoost:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._entryRecords)[record.id] = record
  end
  self._roleAddRecordList = {}
  allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == (DataCommon.Activities).StarMirage then
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
  self._levelNodeLineData = {}
  self._levelNodeData = {}
  self._selectLevelId = nil
  self._rewardList = {}
  self._entryList = {}
  self._init = false
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID)
end

HardTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStarryMirrorDiffculty, TableFrame, GridFrame, ColumnNum
  self._levelPanel = self:GetChild("LevelFrame")
  self._backEffect = self:GetChild("Effect")
  ;
  (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)((CStarryMirrorDiffculty:GetRecorder(((DataCommon.StarMirage).Type).Hard)).backeffect))
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
  self._detail_entryPanel = self:GetChild("Detail/Level2/BossBuff/Frame")
  self._detail_entryIBtn = self:GetChild("Detail/Level2/BossBuff/Ibtn")
  self._detail_autoBtn = self:GetChild("Detail/Level2/AutoBtn")
  self._detail_autoBtnTips = self:GetChild("Detail/Level2/AutoBtn/Tips")
  ;
  (self._detail_autoBtnTips):SetActive(false)
  self._detail_autoBtnClickArea = self:GetChild("Detail/Level2/Click")
  self._detail_goBtn = self:GetChild("Detail/Level2/GoBtn")
  self._detail_goBtnCenter = self:GetChild("Detail/Level2/GoBtnCenter")
  self._detail_rewardFrame = (TableFrame.Create)(self._detail_rewardPanel, self, false, true)
  self._detail_entryFrame = (GridFrame.Create)(self._detail_entryPanel, self, true, ColumnNum)
  ;
  (self._detail_entryIBtn):Subscribe_PointerClickEvent(self.OnEntryIBtnClicked, self)
  ;
  (self._detail_autoBtn):Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  ;
  (self._detail_autoBtnClickArea):Subscribe_PointerClickEvent(self.OnAutoBtnClickAreaClicked, self)
  ;
  (self._detail_goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._detail_goBtnCenter):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self:GetChild("Level2Tips")):SetText((TextManager.GetText)(1900588))
  self._accumulateRewardBtn = self:GetChild("AccountBtn")
  self._accumulateRewardBtn_redDot = self:GetChild("AccountBtn/RedDot")
  self._shopBtn = self:GetChild("ShopBtn")
  self._rankBtn = self:GetChild("RankBtn")
  self._roleAddPanel = self:GetChild("TitleBack")
  ;
  (self:GetChild("TitleBack/Txt")):SetText((TextManager.GetText)(1900585))
  self._roleAddPanel_framePanel = self:GetChild("TitleBack/CharFrame")
  self._roleAddPanel_frame = (TableFrame.Create)(self._roleAddPanel_framePanel, self, false, true)
  ;
  (self._accumulateRewardBtn):Subscribe_PointerClickEvent(self.OnAccumulateRewardBtnClicked, self)
  ;
  (self._shopBtn):Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (self._rootWindow):Subscribe_StateExitEvent(self.OnStateExit, self)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  self:RefreshActivityRewards()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  local cellDialog = (DialogManager.CreateDialog)("activity.starmirage.levelcell", nil)
  self._levelCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
  cellDialog = (DialogManager.CreateDialog)("activity.starmirage.levelbosscell", nil)
  self._levelBossCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
end

HardTabCell.OnDestroy = function(self)
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
  (self._detail_entryFrame):Destroy()
  ;
  (self._roleAddPanel_frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.entrydetaildialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
end

HardTabCell.OnRefreshSpirit = function(self, notification)
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

local EnterTeamEdit = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) and not (self._bm):IsBossLevel(self._selectLevelId) then
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    ;
    ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("StarMirage", self._selectLevelId)
    local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    do
      if (self._bm):IsBossLevel(self._selectLevelId) then
        ((NekoData.DataManager).DM_Team):ClearSupportRole()
      end
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
      if dialog then
        dialog:SetCopyInfo("StarMirage", self._selectLevelId)
      end
    end
  end
end

HardTabCell.OnNPCChatEnd = function(self, notification)
  -- function num : 0_5 , upvalues : EnterTeamEdit, _ENV
  if self._chatdialogId == notification.userInfo then
    local temp = (self._levelNodeData)[self._selectLevelId]
    local record = temp.record
    if self._chatdialogId == record.forebattleplot then
      EnterTeamEdit(self)
    else
      if self._chatdialogId == record.afterbattleplot then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivitydramapassed")
        protocol.dramaType = protocol.AFTER_BATTLE
        protocol.activity = (DataCommon.Activities).StarMirage
        protocol.battleID = self._selectLevelId
        protocol:Send()
      end
    end
  end
end

HardTabCell.RefreshActivityRewards = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._accumulateRewardBtn_redDot):SetActive(((NekoData.BehaviorManager).BM_Activity):HaveGetRewardById(DataCommon.StarMirageManagerID))
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
  do
    do
      while (self._levelNodeLineData)[#self._levelNodeLineData] do
        local dialog = ((self._levelNodeLineData)[#self._levelNodeLineData]).dialog
        dialog:Destroy()
        dialog:RootWindowDestroy()
        ;
        (table.remove)(self._levelNodeLineData, #self._levelNodeLineData)
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
          levelPosData[levelId] = {}
          local pos = (string.split)(record.levelentrylocation, ",")
          local isBoss = record.bosslevelornot == 2
          local centerX, centerY = nil, nil
          if isBoss then
            centerX = tonumber(pos[1]) + self._levelBossCellWidth / 2
            centerY = tonumber(pos[2]) + self._levelBossCellHeight / 2
          else
            centerX = tonumber(pos[1]) + self._levelCellWidth / 2
            centerY = tonumber(pos[2]) + self._levelCellHeight / 2
          end
          levelPosData[levelId] = {x = tonumber(pos[1]), y = tonumber(pos[2]), cX = centerX, cY = centerY}
          -- DECOMPILER ERROR at PC112: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self._levelNodeData)[levelId] = {data = levelDataMap[levelId], record = record, isBoss = isBoss, posData = levelPosData[levelId]}
        end
        for k,v in pairs(levelPosData) do
          local record = (self._levelRecords)[k]
          for _,targetId in ipairs(record.levellinetarget) do
            local targetNodePosData = levelPosData[targetId]
            if targetNodePosData then
              local deltaX = targetNodePosData.cX - v.cX
              local deltaY = targetNodePosData.cY - v.cY
              local len = deltaX ^ 2 + deltaY ^ 2 ^ 0.5
              local posX = v.cX + deltaX / 2
              local posY = v.cY + deltaY / 2
              local dialog = (DialogManager.CreateDialog)("activity.starmirage.levellinecell", (self._levelPanel)._uiObject)
              ;
              (dialog._rootWindow):SetWidth(0, len)
              local levelLineCellWidth, levelLineCellHeight = (dialog._rootWindow):GetRectSize()
              ;
              (dialog._rootWindow):SetPosition(0, posX - levelLineCellWidth / 2, 0, posY - levelLineCellHeight / 2)
              ;
              (dialog._rootWindow):SetZRotation(1, 0, deltaX, deltaY)
              ;
              (dialog._rootWindow):SetActive(levelDataMap[targetId])
              ;
              (table.insert)(self._levelNodeLineData, {dialog = dialog, startLevelId = k, targetLevelId = targetId})
            end
          end
        end
        for k,v in pairs(levelPosData) do
          local info = (self._levelNodeData)[k]
          local dialog = nil
          if not info.isBoss then
            dialog = (DialogManager.CreateDialog)("activity.starmirage.levelcell", (self._levelPanel)._uiObject)
          else
            dialog = (DialogManager.CreateDialog)("activity.starmirage.levelbosscell", (self._levelPanel)._uiObject)
          end
          ;
          (dialog._rootWindow):SetPosition(0, v.x, 0, v.y)
          if levelDataMap[k] then
            (dialog._rootWindow):SetActive(true)
            dialog:SetData(self, info)
          else
            (dialog._rootWindow):SetActive(false)
          end
          -- DECOMPILER ERROR at PC240: Confused about usage of register: R10 in 'UnsetPending'

          ;
          ((self._levelNodeData)[k]).dialog = dialog
        end
        -- DECOMPILER ERROR: 11 unprocessed JMP targets
      end
    end
  end
end

local RefreshFunctionBtnShow = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (self._accumulateRewardBtn):SetActive((self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).AccumulateRewardsId))
  ;
  (self._shopBtn):SetActive((self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).ShopId))
  ;
  (self._rankBtn):SetActive((self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).RankId))
  local value = (self._bm):IsUnlockFunctionById(((DataCommon.StarMirage).Function).RoleAddId)
  if value then
    (self._roleAddPanel):SetActive(true)
    ;
    (self._roleAddPanel_frame):ReloadAllCell()
  else
    ;
    (self._roleAddPanel):SetActive(false)
  end
end

local RefreshDetailPanel = function(self)
  -- function num : 0_9 , upvalues : _ENV, CRoleLevelCfgTable
  local temp = (self._levelNodeData)[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  ;
  (self._detail_name):SetText((TextManager.GetText)(record.levelname))
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
  while (self._entryList)[#self._entryList] do
    (table.remove)(self._entryList, #self._entryList)
  end
  local record = (self._entryRecords)[self._selectLevelId]
  for i,v in ipairs(record.boostnameid) do
    (table.insert)(self._entryList, {nameId = v, effectId = (record.boosteffectid)[i], img = (record.boosteffectpicid)[i]})
  end
  ;
  (self._detail_entryFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

HardTabCell.RefreshByProtocol = function(self, data)
  -- function num : 0_10 , upvalues : _ENV, BuildNodeData, RefreshFunctionBtnShow
  if not self._init then
    self._init = true
    self._data = ((self._delegate)._levelMap)[((DataCommon.StarMirage).Type).Hard]
    BuildNodeData(self)
  end
  local lineDialogMap = {}
  for i,v in ipairs(self._levelNodeLineData) do
    if not lineDialogMap[v.targetLevelId] then
      lineDialogMap[v.targetLevelId] = {}
    end
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (lineDialogMap[v.targetLevelId])[v.startLevelId] = v.dialog
  end
  for i,info in ipairs(data) do
    if info.battletype == ((DataCommon.StarMirage).Type).Hard then
      local v = (self._bm):GetLevelInfo(info.battletype, info.id)
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R9 in 'UnsetPending'

      if (self._levelNodeData)[v.levelId] and ((self._levelNodeData)[v.levelId]).data then
        ((self._levelNodeData)[v.levelId]).data = v
        ;
        (((self._levelNodeData)[v.levelId]).dialog):SetData(self, (self._levelNodeData)[v.levelId])
      else
        local levelId = v.levelId
        local record = (self._levelRecords)[levelId]
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R11 in 'UnsetPending'

        if record then
          ((self._levelNodeData)[levelId]).data = v
        else
          LogErrorFormat("EasyTabCell", "Can not find record by levelId: %s.", levelId)
        end
        local map = lineDialogMap[levelId]
        if map then
          for k,value in pairs(map) do
            (value._rootWindow):SetActive(true)
          end
        end
        do
          local info = (self._levelNodeData)[levelId]
          do
            local dialog = info.dialog
            ;
            (dialog._rootWindow):SetActive(true)
            dialog:SetData(self, info)
            dialog:PlayAnimation()
            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  RefreshFunctionBtnShow(self)
end

HardTabCell.RefreshTabCell = function(self, data, notSelectLevel, refresh)
  -- function num : 0_11 , upvalues : BuildNodeData, RefreshFunctionBtnShow, RefreshDetailPanel
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

HardTabCell.SelectLevelById = function(self, levelId)
  -- function num : 0_12 , upvalues : LevelStateEnum, _ENV, UIManager, TransformStaticFunctions
  if levelId then
    local data = (self._levelNodeData)[levelId]
    local status = (data.data).status
    if status == LevelStateEnum.LOCK then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100298)
    else
      if status == LevelStateEnum.UNSTART then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100296)
      else
        if self._selectLevelId ~= levelId then
          do
            if self._selectLevelId then
              local info = (self._levelNodeData)[self._selectLevelId]
              if info.isBoss then
                (DialogManager.DestroySingletonDialog)("activity.starmirage.bossleveldetaildialog")
              end
            end
            local playResourceSelectDetailHide = nil
            if data.isBoss then
              local info = (self._levelNodeData)[self._selectLevelId]
              if info and not info.isBoss then
                playResourceSelectDetailHide = true
              end
              if playResourceSelectDetailHide then
                (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailHide")
              end
              self._selectLevelId = levelId
              ;
              ((DialogManager.CreateSingletonChildDialog)("activity.starmirage.bossleveldetaildialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())):Init(self, data.data)
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
                      (DialogManager.DestroySingletonDialog)("activity.starmirage.bossleveldetaildialog")
                    else
                      ;
                      (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailHide")
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

HardTabCell.OnUpdate = function(self, notification)
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

HardTabCell.OnEntryIBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.starmirage.entrydetaildialog")):Init(self._entryList)
end

HardTabCell.OnAutoBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local temp = (self._levelNodeData)[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if self._spirit < record.spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreStarMirage"
      data.id = self._selectLevelId
      data.spirit = record.spirit
      dialog:SetInfo(data)
    end
  end
end

HardTabCell.OnAutoBtnClickAreaClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self._autoGoBtnTipsNotShow then
    (self._detail_autoBtnTips):SetActive(true)
    if self._autoTipsShowTask then
      (GameTimer.RemoveTask)(self._autoTipsShowTask)
      self._autoTipsShowTask = nil
    end
    self._autoTipsShowTask = (GameTimer.AddTask)(3, -1, function()
    -- function num : 0_16_0 , upvalues : self
    (self._detail_autoBtnTips):SetActive(false)
  end
)
  end
end

HardTabCell.OnGoBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV, LevelStateEnum, EnterTeamEdit
  local temp = (self._levelNodeData)[self._selectLevelId]
  local record = temp.record
  local data = temp.data
  if self._spirit < record.spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    if data.status == LevelStateEnum.UNCLEAR then
      if record.forebattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.forebattleplot) then
        local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
        if dialog then
          self._chatdialogId = record.forebattleplot
          dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).StarMirage)
        end
      else
        do
          EnterTeamEdit(self)
          do
            -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

            if data.status == LevelStateEnum.CLEAR and record.afterbattleplot ~= -1 and (not self._chatdialogId or self._chatdialogId ~= record.afterbattleplot) then
              local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
              if dialog then
                self._chatdialogId = record.afterbattleplot
                dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).StarMirage)
              end
            end
            if data.status == LevelStateEnum.PASSED then
              EnterTeamEdit(self)
            end
          end
        end
      end
    end
  end
end

HardTabCell.OnAccumulateRewardBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.starmirage.accumulaterewarddialog")
end

HardTabCell.OnShopBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  protocol.shopId = ((DataCommon.StarMirage).Shop).HardId
  protocol:Send()
end

HardTabCell.OnRankBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.starmirage.rankmaindialog")):SetType((DataCommon.Activities).StarMirage, ((DataCommon.StarMirage).Type).Hard)
end

HardTabCell.ResourceSelectDetailShow = function(self)
  -- function num : 0_21 , upvalues : RefreshDetailPanel
  if not self._willShowDetail then
    (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailShow")
    RefreshDetailPanel(self)
  end
end

HardTabCell.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_22 , upvalues : _ENV
  if stateName == "MainLevel1Show" then
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    if self._willShowDetail then
      self._willShowDetail = false
      self:ResourceSelectDetailShow()
    end
  end
end

HardTabCell.NumberOfCell = function(self, frame, index)
  -- function num : 0_23
  if frame == self._detail_entryFrame then
    return #self._entryList
  else
    if frame == self._roleAddPanel_frame then
      return #self._roleAddRecordList
    else
      return #self._rewardList
    end
  end
end

HardTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_24
  if frame == self._detail_entryFrame then
    return "activity.starmirage.entrycell"
  else
    if frame == self._roleAddPanel_frame then
      return "activity.starmirage.roleaddcell"
    else
      return "activity.starmirage.rewardcell"
    end
  end
end

HardTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_25
  if frame == self._detail_entryFrame then
    return (self._entryList)[index]
  else
    if frame == self._roleAddPanel_frame then
      return (self._roleAddRecordList)[index]
    else
      return (self._rewardList)[index]
    end
  end
end

return HardTabCell

