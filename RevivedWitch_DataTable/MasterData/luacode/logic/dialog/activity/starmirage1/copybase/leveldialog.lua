-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/copybase/leveldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local DungeonType = (LuaNetManager.GetBeanDef)("protocol.battle.dungeontype")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local LevelDialog = class("LevelDialog", Dialog)
LevelDialog.NotificationName = {RefreshDetailPanel = "LevelDialog_RefreshDetailPanel", RefreshFunctionBtnShow = "LevelDialog_RefreshFunctionBtnShow"}
LevelDialog.Ctor = function(self, args)
  -- function num : 0_0 , upvalues : LevelDialog, _ENV
  ((LevelDialog.super).Ctor)(self, args[1], args[2])
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
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
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
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (self._rootWindow):Subscribe_StateExitEvent(self.OnStateExit, self)
  local cellDialog = (DialogManager.CreateDialog)(self._LevelCellName, nil)
  self._levelCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
  cellDialog = (DialogManager.CreateDialog)(self._LevelBossCellName, nil)
  self._levelBossCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
  ;
  (self:GetChild("Detail/Level2/CostBack/Txt1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2023))
  ;
  (self:GetChild("Detail/Level1/Checkbtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2101))
end

LevelDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._detail_rewardFrame):Destroy()
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
  -- function num : 0_4 , upvalues : _ENV
  local temp = (self._levelNodeData)[levelId]
  local record = temp.record
  if self._spirit < record.spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
    return 
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) and not (self._bm):IsBossLevel(levelId) then
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    ;
    ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo((self._TypeEnum).BattleType, levelId)
    local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    do
      if (self._bm):IsBossLevel(levelId) then
        ((NekoData.DataManager).DM_Team):ClearSupportRole()
      end
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
      if dialog then
        dialog:SetCopyInfo((self._TypeEnum).BattleType, levelId)
      end
    end
  end
end

local RefreshDetailPanel = function(self)
  -- function num : 0_5 , upvalues : LevelStateEnum, _ENV, CRoleLevelCfgTable, LevelDialog
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
    (self._recommendCapacity):SetText(clientLevel)
    ;
    (self._recommendBreakLv):SetText(clientBreakLevel)
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
    ;
    (LuaNotificationCenter.PostNotification)((LevelDialog.NotificationName).RefreshDetailPanel, nil, nil)
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

LevelDialog.OnNPCChatEnd = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if self._chatdialogId == notification.userInfo then
    local record = nil
    for k,v in pairs(self._LevelRecords) do
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
          protocol.activity = self._ActivityId
          protocol.battleID = record.id
          protocol:Send()
        else
          do
            if self._chatdialogId == record.afterbattleplot then
              local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivitydramapassed")
              protocol.dramaType = protocol.AFTER_BATTLE
              protocol.activity = self._ActivityId
              protocol.battleID = record.id
              protocol:Send()
              ;
              (self._bm):SetLevelStatus(self._type, record.id, ((LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")).PASSED)
            end
          end
        end
      end
    end
  end
end

LevelDialog.BeforePlotFinished = function(self, levelId)
  -- function num : 0_7 , upvalues : RefreshDetailPanel
  local record = (self._LevelRecords)[levelId]
  if self._selectLevelId and self._selectLevelId == levelId and record and record.bosslevelornot ~= 0 then
    self._selectLevelId = nil
    self:SelectLevelById(record.id, true)
  else
    RefreshDetailPanel(self)
  end
end

local BuildNodeData = function(self)
  -- function num : 0_8 , upvalues : _ENV
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
        for levelId,record in pairs(self._LevelRecords) do
          if record.difficulty == self._type then
            levelPosData[levelId] = {}
            local pos = (string.split)(record.levelentrylocation, ",")
            local isBoss = record.bosslevelornot ~= 0
            local centerX, centerY = nil, nil
            if isBoss then
              centerX = tonumber(pos[1]) + self._levelBossCellWidth / 2
              centerY = tonumber(pos[2]) + self._levelBossCellHeight / 2
            else
              centerX = tonumber(pos[1]) + self._levelCellWidth / 2
              centerY = tonumber(pos[2]) + self._levelCellHeight / 2
            end
            levelPosData[levelId] = {x = tonumber(pos[1]), y = tonumber(pos[2]), cX = centerX, cY = centerY}
            -- DECOMPILER ERROR at PC116: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (self._levelNodeData)[levelId] = {data = levelDataMap[levelId], record = record, isBoss = isBoss, posData = levelPosData[levelId]}
          end
        end
        for k,v in pairs(levelPosData) do
          local record = (self._LevelRecords)[k]
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
            dialog = (DialogManager.CreateDialog)(self._LevelCellName, (self._levelPanel)._uiObject)
          else
            dialog = (DialogManager.CreateDialog)(self._LevelBossCellName, (self._levelPanel)._uiObject)
          end
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
          -- DECOMPILER ERROR at PC251: Confused about usage of register: R10 in 'UnsetPending'

          ;
          ((self._levelNodeData)[k]).dialog = dialog
        end
        -- DECOMPILER ERROR: 12 unprocessed JMP targets
      end
    end
  end
end

LevelDialog.RefreshByProtocol = function(self, data)
  -- function num : 0_9 , upvalues : BuildNodeData, _ENV, LevelDialog
  if not self._init then
    self._init = true
    self._data = ((self._delegate)._levelMap)[self._type]
    BuildNodeData(self)
  end
  local lineDialogMap = {}
  for i,v in ipairs(self._levelNodeLineData) do
    if not lineDialogMap[v.targetLevelId] then
      lineDialogMap[v.targetLevelId] = {}
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (lineDialogMap[v.targetLevelId])[v.startLevelId] = v.dialog
  end
  for i,info in ipairs(data) do
    if info.battletype == self._type then
      local v = (self._bm):GetLevelInfo(info.battletype, info.id)
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

      if (self._levelNodeData)[v.levelId] and ((self._levelNodeData)[v.levelId]).data then
        ((self._levelNodeData)[v.levelId]).data = v
        ;
        (((self._levelNodeData)[v.levelId]).dialog):SetData(self, (self._levelNodeData)[v.levelId])
      else
        local levelId = v.levelId
        local record = (self._LevelRecords)[levelId]
        -- DECOMPILER ERROR at PC77: Confused about usage of register: R11 in 'UnsetPending'

        if record then
          ((self._levelNodeData)[levelId]).data = v
        else
          LogErrorFormat("LevelDialog", "Can not find record by levelId: %s.", levelId)
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
            -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (LuaNotificationCenter.PostNotification)((LevelDialog.NotificationName).RefreshFunctionBtnShow, nil, nil)
end

LevelDialog.RefreshTabCell = function(self, type, data, notSelectLevel, refresh)
  -- function num : 0_10 , upvalues : _ENV, BuildNodeData, LevelDialog, RefreshDetailPanel
  if not self._init or refresh then
    self._type = type
    if not self._init then
      self._init = true
      ;
      (self._backEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(((self._DiffcultyRecords)[self._type]).backeffect))
    end
    self._data = data
    BuildNodeData(self)
    ;
    (LuaNotificationCenter.PostNotification)((LevelDialog.NotificationName).RefreshFunctionBtnShow, nil, nil)
  end
  if notSelectLevel then
    self:SelectLevelById(nil)
  end
  if refresh and self._selectLevelId then
    RefreshDetailPanel(self)
  end
end

LevelDialog.SelectLevelById = function(self, levelId, hideDetail)
  -- function num : 0_11 , upvalues : LevelStateEnum, _ENV, UIManager, TransformStaticFunctions
  if levelId then
    local data = (self._levelNodeData)[levelId]
    local status = (data.data).status
    if status == LevelStateEnum.LOCK then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100298)
    else
      if status == LevelStateEnum.UNSTART then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100296)
      else
        if (self._selectLevelId ~= levelId and not self._selectLevelId) or self._selectLevelId and self._selectLevelId ~= (self._SpecialBossLevelMap)[levelId] then
          do
            if self._selectLevelId then
              local info = (self._levelNodeData)[self._selectLevelId]
              if info.isBoss then
                (DialogManager.DestroySingletonDialog)(self._BossLevelDetailDialogName)
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
              ((DialogManager.CreateSingletonChildDialog)(self._BossLevelDetailDialogName, (self._delegate)._dialogName, (self._delegate):GetRootWindow())):Init(self)
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
                      (DialogManager.DestroySingletonDialog)(self._BossLevelDetailDialogName)
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
  -- function num : 0_12 , upvalues : _ENV
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
  -- function num : 0_13 , upvalues : _ENV, DungeonType
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
  -- function num : 0_14 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100473)
end

LevelDialog.OnGoBtnClicked = function(self, bossLevelId)
  -- function num : 0_15 , upvalues : _ENV, LevelStateEnum, EnterTeamEdit
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
        dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).StarMirage)
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
              dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).StarMirage)
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

LevelDialog.ResourceSelectDetailShow = function(self)
  -- function num : 0_16 , upvalues : RefreshDetailPanel
  if not self._willShowDetail then
    self._detailShow = true
    ;
    (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailShow")
    RefreshDetailPanel(self)
  end
end

LevelDialog.ResourceSelectDetailHide = function(self)
  -- function num : 0_17
  self._detailShow = false
  ;
  (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailHide")
end

LevelDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_18 , upvalues : _ENV
  if stateName == "MainLevel1Show" then
    local levelId, afterbattleplot = (self._bm):GetClearLevelIdAndPlotId(self._type)
    do
      if afterbattleplot and (not self._chatdialogId or self._chatdialogId ~= afterbattleplot) then
        local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
        if dialog then
          self._chatdialogId = afterbattleplot
          dialog:SetDialogLibraryId(self._chatdialogId, false, (dialog.DialogType).StarMirage)
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
  -- function num : 0_19
  if frame == self._detail_rewardFrame then
    return #self._rewardList
  end
end

LevelDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_20
  if frame == self._detail_rewardFrame then
    return "activity.starmirage.rewardcell"
  end
end

LevelDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_21
  if frame == self._detail_rewardFrame then
    return (self._rewardList)[index]
  end
end

return LevelDialog

