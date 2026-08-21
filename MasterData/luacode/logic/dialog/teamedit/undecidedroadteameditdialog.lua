-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/undecidedroadteameditdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local CDungeonSelectWorld = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local CDungeonSelectMainlineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CBattleConstCfgTable = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local iconItem = (Item.Create)(DataCommon.DiamodID)
local UndecidedRoadTeamEditDialog = class("UndecidedRoadTeamEditDialog", Dialog)
UndecidedRoadTeamEditDialog.AssetBundleName = "ui/layouts.teamedit"
UndecidedRoadTeamEditDialog.AssetName = "TeamEditMainNewNoSupport"
local limit = nil
local roleNum = 6
local VocationType = {Defend = 1, Damage = 2, Assassin = 3, Impair = 4, Heal = 5, Magic = 6, Witch = 7}
local AutoTeamShowType = {NoHealRole = 1, NoOutputRole = 2, NoBearDamageRoleInFrontOrAlternateFront = 3, LevelNotSatisfied = 4, ResourceVocationLimit = 5}
local ResourceDungeonInfoType = {
DefendRecover = {201, 401}
, 
AssassinDamage = {202, 402}
, 
MagicImpair = {203, 403}
}
UndecidedRoadTeamEditDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadTeamEditDialog
  ((UndecidedRoadTeamEditDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._teamList = {}
  self._teamId = nil
  self._teamIdList = {}
  self._spirit = nil
  self._curTeamRoles = {}
  self._roleList = nil
  self._testBattleInfo = nil
  self._btn4GuideEffectHandler = nil
  self._copyType = nil
  self._copyID = nil
  self._supportVocationTable = nil
  self._charLargeCell = {}
  self._tempChangeRoleList = nil
  self._oneTimeChangingCurTeamRoles = {}
  self._dialogStr = "teamedit.characterlargecell"
  self._levelNotSatisfiedHasReminder = false
end

UndecidedRoadTeamEditDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : limit, _ENV, roleNum, CVarconfig, iconItem
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._btn1 = self:GetChild("Btn1")
  self._btn4 = self:GetChild("Btn4")
  self._teamBtn = {}
  for i,c in ipairs({"A", "B", "C", "D", "E"}) do
    do
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

      (self._teamBtn)[i] = {btn = self:GetChild("TopPanel/Team" .. c), name = self:GetChild("TopPanel/Team" .. c .. "/Text"), editBtn = self:GetChild("TopPanel/Team" .. c .. "/Edit")}
      ;
      (((self._teamBtn)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnTeamClicked(i)
  end
)
      if ((self._teamBtn)[i]).editBtn then
        (((self._teamBtn)[i]).editBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnTeamNameEditClicked()
  end
)
      end
    end
  end
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._panel_scaleX = (self._panel):GetLocalScale()
  self._pos = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

    (self._pos)[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i)
    ;
    ((self._pos)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnCharPosClicked(i)
  end
)
  end
  self._posLock = {}
  for i = 4, roleNum do
    -- DECOMPILER ERROR at PC112: Confused about usage of register: R5 in 'UnsetPending'

    (self._posLock)[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "Lock")
    ;
    ((self._posLock)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self, i
    self:OnCharPosLockClicked(i)
  end
)
    if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AlterNativeRole) then
      ((self._posLock)[i]):SetActive(true)
    else
      ;
      ((self._posLock)[i]):SetActive(false)
    end
  end
  self._switchPositionBtn = self:GetChild("SwitchPositionBtn")
  self._switchPositionBlack = self:GetChild("SwitchPositionBlack")
  self._switchFinishBtn = self:GetChild("SwitchFinishBtn")
  self._autoTeamLittlePanel = self:GetChild("AutoTeam")
  ;
  (self._autoTeamLittlePanel):SetActive(true)
  self._autoTeamTip = self:GetChild("AutoTeam/Txt1")
  ;
  (self._autoTeamTip):SetActive(false)
  self._autoTeamBtn = self:GetChild("AutoTeam/TeamBtn")
  ;
  (self._autoTeamBtn):SetActive(true)
  self._elementImg = self:GetChild("ElementStage/Element")
  self._elementContentTxt = self:GetChild("ElementStage/Txt1")
  self._elementContentNum = self:GetChild("ElementStage/Txt2")
  self._elementContentTxtRectX = (self._elementContentTxt):GetRectSize()
  self._elementContentTxtWidthX = (self._elementContentTxt):GetWidth(self._elementContentTxtWidthOX)
  self._elementContentNumPosX = (self._elementContentNum):GetPosition()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._menuBtn):SetActive(not GlobalGameFSM or GlobalGameFSM:GetCurrentState() == "MainCity")
  self._jobLimit = self:GetChild("JobLimit")
  self._jobLimitTxt = self:GetChild("JobLimit/Txt2")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._btn1):Subscribe_PointerClickEvent(self.OnBtn1Clicked, self)
  ;
  (self._btn4):Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
  ;
  (self._switchPositionBtn):Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  ;
  (self._switchFinishBtn):Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  ;
  (self._autoTeamBtn):Subscribe_PointerClickEvent(self.OnAutoTeamBtnClicked, self)
  ;
  (self._elementImg):Subscribe_PointerClickEvent(self.OnElementBtnClicked, self)
  self._dontOpenAutoTeamDialog = ((NekoData.BehaviorManager).BM_Game):GetFloorIsUnlockWithMainLineId(tonumber((CVarconfig:GetRecorder(85)).Value))
  self:LoadLocalData()
  local currentTeamId = ((NekoData.BehaviorManager).BM_Team):GetUndecidedRoadTeamId()
  if currentTeamId == 5001 then
    currentTeamId = 1
  end
  self:Refresh(currentTeamId)
  local ImageRecord = iconItem:GetIcon()
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  self._autoTip = self:GetChild("Auto")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEnterDungeon, Common.n_EnterDungeon, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTeam, Common.n_TeamInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UndecidedRoadTeamEditDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
end

UndecidedRoadTeamEditDialog.SetCopyInfo = function(self, copyType, id, additionalData, supportVocationTable)
  -- function num : 0_3 , upvalues : _ENV
  self._copyType = copyType
  self._copyID = id
  self._additionalData = additionalData
  local teamList = ((NekoData.BehaviorManager).BM_Team):GetUndecidedRoadTeamsInfo()
  self._teamIdList = {}
  for id,_ in pairs(teamList) do
    (table.insert)(self._teamIdList, id)
  end
  if #self._teamIdList > 0 then
    self._teamList = teamList
  else
    for id,_ in pairs(self._teamList) do
      (table.insert)(self._teamIdList, id)
    end
  end
  do
    for i,id in pairs(self._teamIdList) do
      if (self._teamBtn)[i] and ((self._teamBtn)[i]).name then
        (((self._teamBtn)[i]).name):SetText(((self._teamList)[id]).name)
      end
    end
    ;
    (table.sort)(self._teamIdList, function(a, b)
    -- function num : 0_3_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for i,v in ipairs(self._teamBtn) do
      (v.btn):SetActive(false)
    end
    for i,id in ipairs(self._teamIdList) do
      if (self._teamBtn)[i] and ((self._teamBtn)[i]).name then
        (((self._teamBtn)[i]).btn):SetActive(true)
        ;
        (((self._teamBtn)[i]).name):SetText(((self._teamList)[id]).name)
      end
    end
    self:Refresh(((NekoData.BehaviorManager).BM_Team):GetUndecidedRoadTeamId())
    self:SetSupportVocationTable(supportVocationTable)
  end
end

UndecidedRoadTeamEditDialog.SetSupportVocationTable = function(self, supportVocationTable)
  -- function num : 0_4 , upvalues : _ENV, CVocationCfgTable
  if supportVocationTable and #supportVocationTable > 0 then
    if self._copyType == "UndecidedRoad" then
      (self._autoTeamBtn):SetActive(false)
    end
    local oneSupportVocationTable = {
vid = {}
, 
txt = {}
}
    for _,vid in ipairs(supportVocationTable) do
      local vidNum = tonumber(vid)
      ;
      (table.insert)(oneSupportVocationTable.vid, vidNum)
      ;
      (table.insert)(oneSupportVocationTable.txt, (TextManager.GetText)((CVocationCfgTable:GetRecorder(vidNum)).nameTextID))
    end
    self._supportVocationTable = oneSupportVocationTable
    ;
    (self._jobLimitTxt):SetText(((NekoData.BehaviorManager).BM_Vocation):GetOneSupportVocationDescription(self._supportVocationTable))
    ;
    (self._jobLimit):SetActive(true)
    self:OnRefresh()
  end
end

UndecidedRoadTeamEditDialog.DestroyModal = function(self, dialog)
  -- function num : 0_5
end

UndecidedRoadTeamEditDialog.OnRefreshSpirit = function(self, notification)
  -- function num : 0_6
  self._spirit = (notification.userInfo).spirit
end

UndecidedRoadTeamEditDialog.OnRefreshCurrency = function(self)
  -- function num : 0_7
end

UndecidedRoadTeamEditDialog.RefreshFashion = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for posi,_ in ipairs(self._pos) do
    local index = nil
    for i,v in ipairs(self._curTeamRoles) do
      if posi == v.station and v.roleKey ~= 0 then
        index = i
        break
      end
    end
    do
      if (self._charLargeCell)[posi] then
        ((self._charLargeCell)[posi]):Destroy()
        ;
        ((self._charLargeCell)[posi]):RootWindowDestroy()
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._charLargeCell)[posi] = nil
      end
      do
        if index then
          local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[posi])._uiObject)
          cell:RefreshCell((self._curTeamRoles)[index], self)
          -- DECOMPILER ERROR at PC48: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._charLargeCell)[posi] = cell
        end
        -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

local CheckMainRolesSecondSkillUnlock = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (DialogManager.GetDialog)("dungeon.dungeonnextfloordialog") or self._copyType ~= "MainLine" and self._copyType ~= "AutoExploreMainline" then
    return 
  else
    local list = nil
    for i,v in ipairs(self._curTeamRoles) do
      if v.station <= 3 then
        local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v.roleKey)
        if role then
          local skill2Info = role:GetShowSkillDataByIndex(2)
          if not skill2Info.unlock then
            if not list then
              list = {}
            end
            ;
            (table.insert)(list, role)
          end
        end
      end
    end
    if not list then
      return 
    else
      ;
      ((DialogManager.CreateSingletonChildDialog)("teamedit.promptunlockskilldialog", self._dialogName, self._rootWindow)):SetData(list)
      return true
    end
  end
end

UndecidedRoadTeamEditDialog.CheckTeamRationalForBeginTask = function(self)
  -- function num : 0_10 , upvalues : AutoTeamShowType, _ENV, CheckMainRolesSecondSkillUnlock
  local notRationalTipsType = self:CheckIfTeamRational()
  if notRationalTipsType == AutoTeamShowType.LevelNotSatisfied and not self._levelNotSatisfiedHasReminder then
    self._levelNotSatisfiedHasReminder = true
    local func = function()
    -- function num : 0_10_0 , upvalues : _ENV, self
    local minLevelRoleTable = {role = nil, value = 10000}
    for i,v in ipairs(self._curTeamRoles) do
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v.roleKey)
      if role and not role:IsInAlternativeTeams(self._teamId) and role:GetLevel() < minLevelRoleTable.value then
        minLevelRoleTable.role = role
        minLevelRoleTable.value = role:GetLevel()
      end
    end
    local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    dialog:Refresh(minLevelRoleTable.role)
    dialog:OnLevelUpPanelClick()
  end

    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      if self._minBreakLevel > 0 then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(110, {self._minBreakLevel, self._minRoleLevel}, func, {}, nil, {})
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(113, {self._minRoleLevel}, func, {}, nil, {})
      end
    end
  else
    do
      if notRationalTipsType and notRationalTipsType ~= AutoTeamShowType.LevelNotSatisfied and not self._dontOpenAutoTeamDialog then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(117, nil, function()
    -- function num : 0_10_1 , upvalues : self
    self:OnAutoTeamBtnClicked()
  end
, {}, function()
    -- function num : 0_10_2 , upvalues : CheckMainRolesSecondSkillUnlock, self
    local value = CheckMainRolesSecondSkillUnlock(self)
    if not value then
      self:BeginTaskBtnClicked()
    end
  end
, {})
      else
        local value = CheckMainRolesSecondSkillUnlock(self)
        if not value then
          self:BeginTaskBtnClicked()
        end
      end
    end
  end
end

UndecidedRoadTeamEditDialog.OnRefreshTeam = function(self, notification)
  -- function num : 0_11
  self:LoadLocalData()
  self:Refresh(self._teamId)
  if (notification.userInfo).name == "schangeroles" then
    if self._haveSendCConfirmRolesBeforeEnterDungeon then
      self._haveSendCConfirmRolesBeforeEnterDungeon = false
      self:CheckTeamRationalForBeginTask()
    end
    if self._haveSendCConfirmRolesWhenClickAutoTeamBtn then
      self._haveSendCConfirmRolesWhenClickAutoTeamBtn = false
    end
  end
end

UndecidedRoadTeamEditDialog.OnRefresh = function(self, notification)
  -- function num : 0_12
  self:LoadLocalData()
  self:Refresh(self._teamId)
end

UndecidedRoadTeamEditDialog.LoadLocalData = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local teamList = ((NekoData.BehaviorManager).BM_Team):GetTeamsInfo()
  if self._copyType == "UndecidedRoad" or self._copyType == "ChristmasBoss" then
    teamList = ((NekoData.BehaviorManager).BM_Team):GetUndecidedRoadTeamsInfo()
  end
  self._teamIdList = {}
  for id,_ in pairs(teamList) do
    (table.insert)(self._teamIdList, id)
  end
  if #self._teamIdList > 0 then
    self._teamList = teamList
  else
    for id,_ in pairs(self._teamList) do
      (table.insert)(self._teamIdList, id)
    end
  end
  do
    ;
    (table.sort)(self._teamIdList, function(a, b)
    -- function num : 0_13_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for i,id in ipairs(self._teamIdList) do
      if (self._teamBtn)[i] and ((self._teamBtn)[i]).name then
        (((self._teamBtn)[i]).name):SetText(((self._teamList)[id]).name)
      end
    end
    self._roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  end
end

UndecidedRoadTeamEditDialog.Refresh = function(self, teamId)
  -- function num : 0_14 , upvalues : _ENV
  if #self._teamIdList > 0 and teamId and teamId > 0 and (self._teamList)[teamId] then
    self._teamId = teamId
    self._teamInfo = (self._teamList)[teamId]
  end
  if self._teamInfo then
    self._name = (self._teamInfo).name
    for i,id in ipairs(self._teamIdList) do
      local v = (self._teamBtn)[i]
      if v then
        if id == teamId then
          (v.btn):SetSelected(true)
          if v.editBtn then
            (v.editBtn):SetActive(true)
          end
        else
          ;
          (v.btn):SetSelected(false)
          if v.editBtn then
            (v.editBtn):SetActive(false)
          end
        end
      end
    end
    do
      while (self._curTeamRoles)[#self._curTeamRoles] do
        (table.remove)(self._curTeamRoles, #self._curTeamRoles)
      end
      for k,v in pairs((self._teamInfo).roles) do
        local temp = {}
        temp.station = k
        temp.roleKey = v
        ;
        (table.insert)(self._curTeamRoles, temp)
      end
      ;
      (table.sort)(self._curTeamRoles, function(a, b)
    -- function num : 0_14_0
    do return b.station < a.station end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      for posi,_ in ipairs(self._pos) do
        local index = nil
        for i,v in ipairs(self._curTeamRoles) do
          if posi == v.station and v.roleKey ~= 0 then
            index = i
            break
          end
        end
        do
          if (self._charLargeCell)[posi] then
            ((self._charLargeCell)[posi]):Destroy()
            ;
            ((self._charLargeCell)[posi]):RootWindowDestroy()
            -- DECOMPILER ERROR at PC122: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._charLargeCell)[posi] = nil
          end
          do
            if index then
              local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[posi])._uiObject)
              cell:RefreshCell((self._curTeamRoles)[index], self)
              -- DECOMPILER ERROR at PC138: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self._charLargeCell)[posi] = cell
            end
            -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      local tag = false
      for k,v in pairs((self._teamInfo).roles) do
        if v and v ~= 0 then
          tag = true
          break
        end
      end
      do
        do
          ;
          (self._btn4):SetInteractable(tag)
          self:RefreshTeamElementInfo()
          local a = nil
        end
      end
    end
  end
end

UndecidedRoadTeamEditDialog.CheckIfTeamRational = function(self)
  -- function num : 0_15 , upvalues : CDungeonSelectMainlineTable, _ENV, CVarconfig, CRoleLevelCfgTable, AutoTeamShowType, CBattleConstCfgTable, VocationType, LineUpStation
  local isMainLine = CDungeonSelectMainlineTable:GetRecorder(self._copyID)
  local checkTag = false
  self._recommendLevel = 0
  self._minBreakLevel = 0
  self._minRoleLevel = 0
  if isMainLine and ((NekoData.BehaviorManager).BM_Game):GetFloorIsUnlockWithMainLineId(tonumber((CVarconfig:GetRecorder(84)).Value)) and not ((NekoData.BehaviorManager).BM_Game):GetFloorIsPassWithMainLineId(self._copyID) then
    checkTag = true
    self._recommendLevel = (CDungeonSelectMainlineTable:GetRecorder(self._copyID)).magic
    self._minBreakLevel = (CRoleLevelCfgTable:GetRecorder(self._recommendLevel)).clientBreakLevel
    self._minRoleLevel = (CRoleLevelCfgTable:GetRecorder(self._recommendLevel)).clientLevel
  end
  if not checkTag then
    return 
  end
  local reasonType = nil
  local haveNoHealRole = true
  local haveNoOutputRole = true
  local frontNoBearDamage = true
  for i,v in ipairs(self._curTeamRoles) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v.roleKey)
    if role then
      local isMainTeamMember = not role:IsInAlternativeTeams(self._teamId)
      if isMainTeamMember and role:GetLevel() + 10 <= self._recommendLevel then
        reasonType = AutoTeamShowType.LevelNotSatisfied
      end
      if isMainTeamMember and self._recommendLevel <= role:GetLevel() - 5 then
        return 
      end
      local someRoleIdList = (string.split)((CBattleConstCfgTable:GetRecorder(115)).attr, ";")
      local isSomeRole = false
      for _,roleId in ipairs(someRoleIdList) do
        if role:GetId() == tonumber(roleId) then
          isSomeRole = true
          break
        end
      end
      do
        do
          if isMainTeamMember and (role:GetVocationId() == VocationType.Heal or role:GetVocationId() == VocationType.Impair or isSomeRole) then
            haveNoHealRole = false
          end
          if isMainTeamMember and role:GetVocationId() ~= VocationType.Heal then
            haveNoOutputRole = false
          end
          if v.station == LineUpStation.FRONT_ROW and (role:GetVocationId() == VocationType.Defend or role:GetVocationId() == VocationType.Damage or role:GetVocationId() == VocationType.Assassin) then
            frontNoBearDamage = false
          end
          -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC160: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if haveNoHealRole then
    reasonType = AutoTeamShowType.NoHealRole
  else
    if haveNoOutputRole then
      reasonType = AutoTeamShowType.NoOutputRole
    else
      if frontNoBearDamage then
        reasonType = AutoTeamShowType.NoBearDamageRoleInFrontOrAlternateFront
      end
    end
  end
  return reasonType
end

UndecidedRoadTeamEditDialog.RefreshTeamElementInfo = function(self)
  -- function num : 0_16 , upvalues : _ENV, LineUpStation, CElementEffect, CImagePathTable, CStringRes
  local currentTeamRoleList = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(self._teamId)
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station,roleId in pairs(currentTeamRoleList) do
    if roleId ~= 0 then
      haveTeamInfo = true
      stationElementTag[station] = (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(roleId)):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        (table.insert)(etherStationList, station)
      end
    end
  end
  self._oneTotalElementValue = nil
  self._elementStage = nil
  if haveTeamInfo then
    if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
      for _,station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
      end
    else
      do
        if stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
          for _,station in ipairs(etherStationList) do
            stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
          end
        else
          do
            if stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
              for _,station in ipairs(etherStationList) do
                stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
              end
            else
              do
                if stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
                  for _,station in ipairs(etherStationList) do
                    stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
                  end
                else
                  do
                    if stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
                      for _,station in ipairs(etherStationList) do
                        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
                      end
                    else
                      do
                        if stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
                          for _,station in ipairs(etherStationList) do
                            stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
                          end
                        end
                        do
                          if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.BACK_ROW] then
                            self._elementStage = 1
                            if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] then
                              self._elementStage = 2
                            end
                            self._oneTotalElementValue = stationElementTag[LineUpStation.FRONT_ROW]
                          end
                          local StageType = {NoStage = 0}
                          if self._elementStage then
                            local elementRecord = CElementEffect:GetRecorder(self._elementStage)
                            if not CImagePathTable:GetRecorder(elementRecord.image) then
                              local imgRecord = DataCommon.DefaultImageAsset
                            end
                            ;
                            (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                            local str = (TextManager.GetText)((CStringRes:GetRecorder(1492)).msgTextID)
                            ;
                            (self._elementContentTxt):SetText(str)
                            local delta = (self._elementContentTxt):GetPreferredSize() - self._elementContentTxtRectX
                            ;
                            (self._elementContentTxt):SetWidth(self._elementContentTxtWidthX, self._elementContentTxtWidthOX + delta)
                            ;
                            (self._elementContentNum):SetPosition(self._elementContentNumPosX, self._elementContentNumPosOX + delta, self._elementContentNumPosY, self._elementContentNumPosOY)
                            ;
                            (self._elementContentNum):SetActive(true)
                            ;
                            (self._elementContentNum):SetText(tostring((math.floor)(elementRecord.effect / 1000 * 100)) .. "%")
                          else
                            do
                              local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
                              if not CImagePathTable:GetRecorder(elementRecord.image) then
                                local imgRecord = DataCommon.DefaultImageAsset
                              end
                              ;
                              (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                              ;
                              (self._elementContentTxt):SetText((TextManager.GetText)(elementRecord.describe))
                              local delta = (self._elementContentTxt):GetPreferredSize() - self._elementContentTxtRectX
                              ;
                              (self._elementContentTxt):SetWidth(self._elementContentTxtWidthX, self._elementContentTxtWidthOX + delta)
                              ;
                              (self._elementContentNum):SetActive(false)
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
      end
    end
  end
end

UndecidedRoadTeamEditDialog.OnEnterDungeon = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("mainline.mainline.newmainlinefloordialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.mainline.mainlineworlddialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonnextfloordialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.branchlinenextfloordialog")
  ;
  (DialogManager.DestroySingletonDialog)("base.basemainui")
  ;
  (DialogManager.DestroySingletonDialog)("base.basemainmenudialog")
  self:Destroy()
end

UndecidedRoadTeamEditDialog.OnBtn1Clicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self._isTowerBattle then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(3, nil, function()
    -- function num : 0_18_0 , upvalues : _ENV, self
    local cbreakLineup = (LuaNetManager.CreateProtocol)("protocol.battle.ctowerbreaklineup")
    if cbreakLineup then
      cbreakLineup.lineupId = self._teamId
      cbreakLineup:Send()
    end
  end
, {}, nil, {})
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(3, nil, function()
    -- function num : 0_18_1 , upvalues : _ENV, self
    local cbreakLineup = (LuaNetManager.CreateProtocol)("protocol.login.cbreaklineup")
    if cbreakLineup then
      cbreakLineup.lineupId = self._teamId
      cbreakLineup:Send()
    end
  end
, {}, nil, {})
  end
end

UndecidedRoadTeamEditDialog.OnBtn4Clicked = function(self)
  -- function num : 0_19 , upvalues : _ENV, GuideType, LineUpStation
  local guideTag = false
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(17) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(17)
    guideTag = true
  else
    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(13) then
      ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.FIRST_ENTER_DUNGEON, 1)
      guideTag = true
    else
      if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(5) then
        ((NekoData.BehaviorManager).BM_Guide):FinishGuide(5)
      else
        if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(35) then
          ((NekoData.BehaviorManager).BM_Guide):FinishGuide(35)
        else
          if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(52) then
            ((NekoData.BehaviorManager).BM_Guide):FinishGuide(52)
          end
        end
      end
    end
  end
  if guideTag then
    self:BeginTaskBtnClicked()
    return 
  end
  local frontRoleId, frontAlternativeRoleId = 0, 0
  local middleRoleId, middleAlternativeRoleId = 0, 0
  local backRoleId, backAlternativeRoleId = 0, 0
  for _,v in ipairs(self._curTeamRoles) do
    if v.station == LineUpStation.FRONT_ROW then
      frontRoleId = v.roleKey
    end
    if v.station == LineUpStation.MIDDLE_ROW then
      middleRoleId = v.roleKey
    end
    if v.station == LineUpStation.BACK_ROW then
      backRoleId = v.roleKey
    end
    if v.station == LineUpStation.ALTERNATE_FRONT_ROW then
      frontAlternativeRoleId = v.roleKey
    end
    if v.station == LineUpStation.ALTERNATE_MIDDLE_ROW then
      middleAlternativeRoleId = v.roleKey
    end
    if v.station == LineUpStation.ALTERNATE_BACK_ROW then
      backAlternativeRoleId = v.roleKey
    end
  end
  local haveJobLimit = false
  local haveOneAlternativeRoleButNoInBattleRole = false
  local haveSomeEmptyVacancy = false
  for _,value in pairs((self._teamInfo).roles) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(value)
    if role ~= nil and not ((NekoData.BehaviorManager).BM_Vocation):GetVocationIsSupport(role, self._supportVocationTable) then
      haveJobLimit = true
    end
  end
  do
    -- DECOMPILER ERROR at PC165: Unhandled construct in 'MakeBoolean' P3

    if (frontRoleId == 0 and frontAlternativeRoleId ~= 0) or middleRoleId ~= 0 or backRoleId == 0 and backAlternativeRoleId ~= 0 then
      haveOneAlternativeRoleButNoInBattleRole = true
    else
      if frontRoleId == 0 or middleRoleId == 0 or backRoleId == 0 or frontAlternativeRoleId == 0 or middleAlternativeRoleId == 0 or backAlternativeRoleId == 0 then
        haveSomeEmptyVacancy = true
        if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AlterNativeRole) and frontRoleId ~= 0 and middleRoleId ~= 0 and backRoleId ~= 0 then
          haveSomeEmptyVacancy = false
        end
      end
    end
    if haveJobLimit then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100226)
      for _,oneLargeCell in pairs(self._charLargeCell) do
        oneLargeCell:PlayTwinkleByVocationLimit()
      end
    else
      do
        if haveOneAlternativeRoleButNoInBattleRole then
          ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(68, nil, function()
    -- function num : 0_19_0 , upvalues : frontRoleId, frontAlternativeRoleId, middleRoleId, middleAlternativeRoleId, backRoleId, backAlternativeRoleId, _ENV, self, LineUpStation
    if frontRoleId == 0 and frontAlternativeRoleId ~= 0 then
      frontRoleId = frontAlternativeRoleId
      frontAlternativeRoleId = 0
    end
    if middleRoleId == 0 and middleAlternativeRoleId ~= 0 then
      middleRoleId = middleAlternativeRoleId
      middleAlternativeRoleId = 0
    end
    if backRoleId == 0 and backAlternativeRoleId ~= 0 then
      backRoleId = backAlternativeRoleId
      backAlternativeRoleId = 0
    end
    local req = (LuaNetManager.CreateProtocol)("protocol.login.cconfirmroles")
    req.lineupId = self._teamId
    req.roles = {[LineUpStation.FRONT_ROW] = frontRoleId, [LineUpStation.MIDDLE_ROW] = middleRoleId, [LineUpStation.BACK_ROW] = backRoleId, [LineUpStation.ALTERNATE_FRONT_ROW] = frontAlternativeRoleId, [LineUpStation.ALTERNATE_MIDDLE_ROW] = middleAlternativeRoleId, [LineUpStation.ALTERNATE_BACK_ROW] = backAlternativeRoleId}
    req:Send()
    self._haveSendCConfirmRolesBeforeEnterDungeon = true
  end
)
        else
          if haveSomeEmptyVacancy then
            ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(69, nil, function()
    -- function num : 0_19_1 , upvalues : self
    self:CheckTeamRationalForBeginTask()
  end
)
          else
            self:CheckTeamRationalForBeginTask()
          end
        end
      end
    end
  end
end

UndecidedRoadTeamEditDialog.BeginTaskBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local tag = false
  for i,v in ipairs((self._teamInfo).roles) do
    if v and v ~= 0 then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
      if not tag and role:GetHurtExtent() ~= 0 then
        tag = true
        break
      end
    end
  end
  do
    if tag then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100018)
    else
      if self._copyType == "UndecidedRoad" then
        local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
        csend.battleType = csend.UNDECIDEDROAD
        csend.id = self._copyID
        csend.lineupID = self._teamId
        csend:Send()
      else
        do
          do
            if self._copyType == "ChristmasBoss" then
              local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
              csend.constructionID = self._additionalData
              csend.eventID = self._copyID
              csend.lineupID = self._teamId
              csend:Send()
            end
            local randomKey = ((NekoData.BehaviorManager).BM_Team):GetRandomRoleKeyInTeam(self._teamId)
            local roleID = randomKey
            ;
            ((NekoData.BehaviorManager).BM_Voice):Play(roleID, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Adventure, nil)
          end
        end
      end
    end
  end
end

UndecidedRoadTeamEditDialog.OnTeamClicked = function(self, index)
  -- function num : 0_21 , upvalues : _ENV
  for i,v in ipairs(self._teamBtn) do
    if v.editBtn then
      (v.editBtn):SetActive(false)
    end
  end
  if ((self._teamBtn)[index]).editBtn then
    (((self._teamBtn)[index]).editBtn):SetActive(true)
  end
  self:Refresh((self._teamIdList)[index])
end

UndecidedRoadTeamEditDialog.OnTeamNameEditClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditchangenamedialog")
  dialog:SetTeamName(self._name, self._teamId, self._isTowerBattle)
end

UndecidedRoadTeamEditDialog.ReturnRoleList = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local roleList = {}
  for _,v in ipairs(self._curTeamRoles) do
    if v.roleKey ~= 0 then
      (table.insert)(roleList, ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v.roleKey))
    end
  end
  return roleList
end

UndecidedRoadTeamEditDialog.OnBackBtnClicked = function(self)
  -- function num : 0_24
  self:Destroy()
end

UndecidedRoadTeamEditDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_25 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

UndecidedRoadTeamEditDialog.OnCharPosLockClicked = function(self, posIndex)
  -- function num : 0_26 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100244)
end

UndecidedRoadTeamEditDialog.OnCharPosClicked = function(self, posIndex)
  -- function num : 0_27 , upvalues : _ENV
  if self._inSwitchPositionState then
    return 
  end
  local index = nil
  for i,v in ipairs(self._curTeamRoles) do
    if posIndex == v.station then
      index = i
      break
    end
  end
  do
    if index then
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.changeteamroledialog")
      if self._isTowerBattle then
        dialog:Init(self._teamInfo, (self._curTeamRoles)[index], true)
      else
        dialog:SetFilterCondition(((NekoData.BehaviorManager).BM_Team):GetTeamFilterCondition())
        dialog:Init(self._teamInfo, (self._curTeamRoles)[index])
      end
      dialog:SetSupportVocationTable(self._supportVocationTable)
    end
  end
end

UndecidedRoadTeamEditDialog.OnCharCellBeginDrag = function(self, screenPosition, data)
  -- function num : 0_28 , upvalues : CanvasStaticFunctions, _ENV
  self._draging = true
  self._currentDragingCellData = data
  self._tempChangeRoleList = {}
  ;
  ((((self._pos)[data.station])._uiObject).transform):SetAsLastSibling()
  local maxSortingOrderInfo = {order = 0, station = 0}
  local originalOrder = (CanvasStaticFunctions.GetCanvasSortingOrder)((((self._charLargeCell)[data.station]):GetRootWindow())._uiObject)
  for station,cell in pairs(self._charLargeCell) do
    local temp = (CanvasStaticFunctions.GetCanvasSortingOrder)((cell:GetRootWindow())._uiObject)
    if maxSortingOrderInfo.order < temp then
      maxSortingOrderInfo.order = temp
      maxSortingOrderInfo.station = station
    end
  end
  if data.station ~= maxSortingOrderInfo.station then
    (CanvasStaticFunctions.SetCanvasSortingOrder)((((self._charLargeCell)[data.station]):GetRootWindow())._uiObject, maxSortingOrderInfo.order)
    if originalOrder ~= -1 then
      (CanvasStaticFunctions.SetCanvasSortingOrder)((((self._charLargeCell)[maxSortingOrderInfo.station]):GetRootWindow())._uiObject, originalOrder)
    end
  end
end

UndecidedRoadTeamEditDialog.OnCharCellDrag = function(self, screenPosition, data)
  -- function num : 0_29 , upvalues : UIManager, _ENV
  if (self._charLargeCell)[data.station] then
    (((self._charLargeCell)[data.station]):GetRootWindow()):SetAnchoredPosition((UIManager.ScreenPointToLocalPointInRectangle)(((self._pos)[data.station])._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("UndecidedRoadTeamEditDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

UndecidedRoadTeamEditDialog.OnCharCellEndDrag = function(self, screenPosition, data)
  -- function num : 0_30 , upvalues : _ENV, roleNum, UIManager, LineUpStation
  self._draging = false
  for _,v in ipairs(self._oneTimeChangingCurTeamRoles) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R8 in 'UnsetPending'

    (self._tempChangeRoleList)[v.station] = v.roleKey
  end
  for i = 1, roleNum do
    if (UIManager.RectangleContainsScreenPoint)(((self._pos)[i])._uiObject, screenPosition.x, screenPosition.y) then
      local originalRoleInfo = {}
      for _,v in ipairs(self._oneTimeChangingCurTeamRoles) do
        if i == v.station then
          originalRoleInfo.station = v.station
          originalRoleInfo.roleKey = v.roleKey
        end
      end
      do
        if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AlterNativeRole) and (originalRoleInfo.station == LineUpStation.ALTERNATE_FRONT_ROW or originalRoleInfo.station == LineUpStation.ALTERNATE_MIDDLE_ROW or originalRoleInfo.station == LineUpStation.ALTERNATE_BACK_ROW) then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100244)
          break
        end
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

        if originalRoleInfo.station ~= data.station then
          (self._tempChangeRoleList)[originalRoleInfo.station] = data.roleKey
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._tempChangeRoleList)[data.station] = originalRoleInfo.roleKey
          if (self._charLargeCell)[originalRoleInfo.station] then
            ((self._charLargeCell)[originalRoleInfo.station]):Destroy()
            ;
            ((self._charLargeCell)[originalRoleInfo.station]):RootWindowDestroy()
            -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._charLargeCell)[originalRoleInfo.station] = nil
          end
          do
            if data.roleKey ~= 0 then
              local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[originalRoleInfo.station])._uiObject)
              cell:RefreshCell({station = originalRoleInfo.station, roleKey = data.roleKey}, self)
              -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self._charLargeCell)[originalRoleInfo.station] = cell
            end
            if (self._charLargeCell)[data.station] then
              ((self._charLargeCell)[data.station]):Destroy()
              ;
              ((self._charLargeCell)[data.station]):RootWindowDestroy()
              -- DECOMPILER ERROR at PC136: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (self._charLargeCell)[data.station] = nil
            end
            do
              do
                if originalRoleInfo.roleKey ~= 0 then
                  local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[data.station])._uiObject)
                  cell:RefreshCell({station = data.station, roleKey = originalRoleInfo.roleKey}, self)
                  -- DECOMPILER ERROR at PC158: Confused about usage of register: R9 in 'UnsetPending'

                  ;
                  (self._charLargeCell)[data.station] = cell
                end
                for _,v in ipairs(self._oneTimeChangingCurTeamRoles) do
                  if v.station == originalRoleInfo.station then
                    v.roleKey = data.roleKey
                  end
                  if v.station == data.station then
                    v.roleKey = originalRoleInfo.roleKey
                  end
                end
                do return  end
                do break end
                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  if (self._charLargeCell)[data.station] then
    ((self._charLargeCell)[data.station]):Destroy()
    ;
    ((self._charLargeCell)[data.station]):RootWindowDestroy()
    -- DECOMPILER ERROR at PC197: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._charLargeCell)[data.station] = nil
  end
  if data.roleKey ~= 0 then
    local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[data.station])._uiObject)
    cell:RefreshCell({station = data.station, roleKey = data.roleKey}, self)
    -- DECOMPILER ERROR at PC219: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._charLargeCell)[data.station] = cell
  end
end

UndecidedRoadTeamEditDialog.OnSwitchPositionBtnClicked = function(self)
  -- function num : 0_31 , upvalues : _ENV, LineUpStation
  if self._inSwitchPositionState then
    if self._draging then
      self:OnCharCellEndDrag({x = 0, y = 0}, self._currentDragingCellData)
    end
    ;
    (self._switchPositionBtn):SetActive(true)
    ;
    (self._switchFinishBtn):SetActive(false)
    self._inSwitchPositionState = false
    ;
    (self._switchPositionBlack):SetActive(false)
    ;
    (self._autoTeamBtn):SetInteractable(true)
    local haveTempChangeRole = false
    for _,v in ipairs(self._curTeamRoles) do
      if self._tempChangeRoleList and (self._tempChangeRoleList)[v.station] and (self._tempChangeRoleList)[v.station] ~= v.roleKey then
        haveTempChangeRole = true
      end
    end
    if haveTempChangeRole then
      local req = (LuaNetManager.CreateProtocol)("protocol.login.cconfirmroles")
      req.lineupId = self._teamId
      req.roles = {[LineUpStation.FRONT_ROW] = (self._tempChangeRoleList)[LineUpStation.FRONT_ROW], [LineUpStation.MIDDLE_ROW] = (self._tempChangeRoleList)[LineUpStation.MIDDLE_ROW], [LineUpStation.BACK_ROW] = (self._tempChangeRoleList)[LineUpStation.BACK_ROW], [LineUpStation.ALTERNATE_FRONT_ROW] = (self._tempChangeRoleList)[LineUpStation.ALTERNATE_FRONT_ROW], [LineUpStation.ALTERNATE_MIDDLE_ROW] = (self._tempChangeRoleList)[LineUpStation.ALTERNATE_MIDDLE_ROW], [LineUpStation.ALTERNATE_BACK_ROW] = (self._tempChangeRoleList)[LineUpStation.ALTERNATE_BACK_ROW]}
      req:Send()
      self._tempChangeRoleList = {}
    end
  else
    do
      ;
      (self._switchPositionBtn):SetActive(false)
      ;
      (self._switchFinishBtn):SetActive(true)
      self._inSwitchPositionState = true
      ;
      (self._switchPositionBlack):SetActive(true)
      ;
      (self._autoTeamBtn):SetInteractable(false)
      self._oneTimeChangingCurTeamRoles = clone(self._curTeamRoles)
    end
  end
end

UndecidedRoadTeamEditDialog.OnAutoTeamBtnClicked = function(self)
  -- function num : 0_32 , upvalues : _ENV, VocationType, LineUpStation
  if self._haveSendCConfirmRolesWhenClickAutoTeamBtn or self._inSwitchPositionState then
    return 
  end
  self._haveSendCConfirmRolesWhenClickAutoTeamBtn = true
  local allRoleOrderList = {}
  local sortDefend = {}
  local sortHeal = {}
  local sortDamage = {}
  local RarityWeight = {[1] = 0.85, [2] = 0.9, [3] = 0.95, [4] = 1, [5] = 1}
  for _,role in ipairs(((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()) do
    if not self._supportVocationTable or (table.contain)((self._supportVocationTable).vid, role:GetVocationId()) then
      (table.insert)(allRoleOrderList, {role = role, hasLayOnStation = false})
      local defendValue = role:GetLevel() * RarityWeight[role:GetRarityId()]
      local healValue = 0
      local damageValue = role:GetLevel() * RarityWeight[role:GetRarityId()]
      local wholeAverageValue = (defendValue + healValue + damageValue) / 3
      if role:GetVocationId() == VocationType.Defend or role:GetVocationId() == VocationType.Damage then
        (table.insert)(sortDefend, {index = #allRoleOrderList, value = defendValue, wholeAverageValue = wholeAverageValue})
      end
      if role:GetVocationId() == VocationType.Assassin or role:GetVocationId() == VocationType.Magic or role:GetVocationId() == VocationType.Witch then
        (table.insert)(sortDamage, {index = #allRoleOrderList, value = damageValue, wholeAverageValue = wholeAverageValue})
      end
      if role:GetVocationId() == VocationType.Heal or role:GetVocationId() == VocationType.Impair then
        healValue = role:GetLevel() * RarityWeight[role:GetRarityId()]
        damageValue = 0
        wholeAverageValue = (defendValue + healValue + damageValue) / 3
        ;
        (table.insert)(sortHeal, {index = #allRoleOrderList, value = healValue, wholeAverageValue = wholeAverageValue})
      end
    end
  end
  for _,v in ipairs({sortDefend, sortHeal, sortDamage}) do
    (table.sort)(v, function(a, b)
    -- function num : 0_32_0
    if b.value < a.value then
      return true
    else
      if b.wholeAverageValue >= a.wholeAverageValue then
        do return a.value ~= b.value end
        do return false end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
)
  end
  local req = (LuaNetManager.CreateProtocol)("protocol.login.cconfirmroles")
  req.lineupId = self._teamId
  req.roles = {}
  for _,v in ipairs(sortDefend) do
    -- DECOMPILER ERROR at PC169: Confused about usage of register: R12 in 'UnsetPending'

    if not (allRoleOrderList[v.index]).hasLayOnStation then
      (allRoleOrderList[v.index]).hasLayOnStation = true
      -- DECOMPILER ERROR at PC177: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (req.roles)[LineUpStation.FRONT_ROW] = ((allRoleOrderList[v.index]).role):GetRoleId()
      break
    end
  end
  do
    for _,v in ipairs(sortHeal) do
      -- DECOMPILER ERROR at PC192: Confused about usage of register: R12 in 'UnsetPending'

      if not (allRoleOrderList[v.index]).hasLayOnStation then
        (allRoleOrderList[v.index]).hasLayOnStation = true
        -- DECOMPILER ERROR at PC200: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (req.roles)[LineUpStation.MIDDLE_ROW] = ((allRoleOrderList[v.index]).role):GetRoleId()
        break
      end
    end
    do
      for _,v in ipairs(sortDamage) do
        -- DECOMPILER ERROR at PC215: Confused about usage of register: R12 in 'UnsetPending'

        if not (allRoleOrderList[v.index]).hasLayOnStation then
          (allRoleOrderList[v.index]).hasLayOnStation = true
          -- DECOMPILER ERROR at PC223: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (req.roles)[LineUpStation.BACK_ROW] = ((allRoleOrderList[v.index]).role):GetRoleId()
          break
        end
      end
      do
        for _,v in ipairs(sortDefend) do
          -- DECOMPILER ERROR at PC238: Confused about usage of register: R12 in 'UnsetPending'

          if not (allRoleOrderList[v.index]).hasLayOnStation then
            (allRoleOrderList[v.index]).hasLayOnStation = true
            -- DECOMPILER ERROR at PC246: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (req.roles)[LineUpStation.ALTERNATE_FRONT_ROW] = ((allRoleOrderList[v.index]).role):GetRoleId()
            break
          end
        end
        do
          for _,v in ipairs(sortHeal) do
            -- DECOMPILER ERROR at PC261: Confused about usage of register: R12 in 'UnsetPending'

            if not (allRoleOrderList[v.index]).hasLayOnStation then
              (allRoleOrderList[v.index]).hasLayOnStation = true
              -- DECOMPILER ERROR at PC269: Confused about usage of register: R12 in 'UnsetPending'

              ;
              (req.roles)[LineUpStation.ALTERNATE_MIDDLE_ROW] = ((allRoleOrderList[v.index]).role):GetRoleId()
              break
            end
          end
          do
            for _,v in ipairs(sortDamage) do
              -- DECOMPILER ERROR at PC284: Confused about usage of register: R12 in 'UnsetPending'

              if not (allRoleOrderList[v.index]).hasLayOnStation then
                (allRoleOrderList[v.index]).hasLayOnStation = true
                -- DECOMPILER ERROR at PC292: Confused about usage of register: R12 in 'UnsetPending'

                ;
                (req.roles)[LineUpStation.ALTERNATE_BACK_ROW] = ((allRoleOrderList[v.index]).role):GetRoleId()
                break
              end
            end
            do
              req:Send()
            end
          end
        end
      end
    end
  end
end

UndecidedRoadTeamEditDialog.OnElementBtnClicked = function(self)
  -- function num : 0_33 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("teamedit.teamelementinfodialog")):SetData(self._oneTotalElementValue, self._elementStage)
end

return UndecidedRoadTeamEditDialog

