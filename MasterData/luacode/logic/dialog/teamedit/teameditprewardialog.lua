local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local CDungeonSelectWorld = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local CDungeonSelectMainlineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local ResourceStageTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CElementEffect = BeanManager.GetTableByName("role.celementeffect")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CBattleConstCfgTable = BeanManager.GetTableByName("battle.cbattleconstcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local DungeonType = LuaNetManager.GetBeanDef("protocol.battle.dungeontype")
local UIManager = CS.PixelNeko.UI.UIManager
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local iconItem = Item.Create(DataCommon.DiamodID)
local BM_StarMirage = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID)
local TeamEditPreWarDialog = class("TeamEditPreWarDialog", Dialog)
TeamEditPreWarDialog.AssetBundleName = "ui/layouts.teamedit"
TeamEditPreWarDialog.AssetName = "TeamEditMainNewBeforeBattle"
local limit
local roleNum = 6
local VocationType = {
  Defend = 1,
  Damage = 2,
  Assassin = 3,
  Impair = 4,
  Heal = 5,
  Magic = 6,
  Witch = 7
}
local AutoTeamShowType = {
  NoHealRole = 1,
  NoOutputRole = 2,
  NoBearDamageRoleInFrontOrAlternateFront = 3,
  LevelNotSatisfied = 4,
  ResourceVocationLimit = 5
}
local ResourceDungeonInfoType = {
  DefendRecover = {201, 401},
  AssassinDamage = {202, 402},
  MagicImpair = {203, 403}
}

function TeamEditPreWarDialog:Ctor(...)
  TeamEditPreWarDialog.super.Ctor(self, ...)
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
  self._firstEnterDungeon = false
  self._charLargeCell = {}
  self._tempChangeRoleList = nil
  self._oneTimeChangingCurTeamRoles = {}
  self._dialogStr = "teamedit.characterlargecell"
  self._levelNotSatisfiedHasReminder = false
end

function TeamEditPreWarDialog:OnCreate()
  limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._btn1 = self:GetChild("Btn1")
  self._btn4 = self:GetChild("Btn4")
  self._teamBtn = {}
  for i, c in ipairs({
    "A",
    "B",
    "C",
    "D",
    "E"
  }) do
    self._teamBtn[i] = {
      btn = self:GetChild("TopPanel/Team" .. c),
      name = self:GetChild("TopPanel/Team" .. c .. "/Text"),
      editBtn = self:GetChild("TopPanel/Team" .. c .. "/Edit")
    }
    self._teamBtn[i].btn:Subscribe_PointerClickEvent(function()
      self:OnTeamClicked(i)
    end)
    if self._teamBtn[i].editBtn then
      self._teamBtn[i].editBtn:Subscribe_PointerClickEvent(function()
        self:OnTeamNameEditClicked()
      end)
    end
  end
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._panel_scaleX, self._panel_scaleY = self._panel:GetLocalScale()
  self._pos = {}
  for i = 1, roleNum do
    self._pos[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i)
    self._pos[i]:Subscribe_PointerClickEvent(function()
      self:OnCharPosClicked(i)
    end)
  end
  self._posLock = {}
  for i = 4, roleNum do
    self._posLock[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "Lock")
    self._posLock[i]:Subscribe_PointerClickEvent(function()
      self:OnCharPosLockClicked(i)
    end)
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AlterNativeRole) then
      self._posLock[i]:SetActive(true)
    else
      self._posLock[i]:SetActive(false)
    end
  end
  self._supportRolePanel = self:GetChild("CharBack4")
  self._supportLock = self:GetChild("CharBack4/Lock")
  self._supportEmpty = self:GetChild("CharBack4/Empty")
  self._supportRolePos = self:GetChild("CharBack4/Pos")
  self._supportRoleName = self:GetChild("CharBack4/Name")
  self._switchPositionBtn = self:GetChild("SwitchPositionBtn")
  self._switchPositionBlack = self:GetChild("SwitchPositionBlack")
  self._switchFinishBtn = self:GetChild("SwitchFinishBtn")
  self._autoTeamLittlePanel = self:GetChild("AutoTeam")
  self._autoTeamLittlePanel:SetActive(true)
  self._autoTeamTip = self:GetChild("AutoTeam/Txt1")
  self._autoTeamBtn = self:GetChild("AutoTeam/TeamBtn")
  self._autoTeamBtn:SetActive(true)
  self._elementImg = self:GetChild("ElementStage/Element")
  self._elementContentTxt = self:GetChild("ElementStage/Txt1")
  self._elementContentNum = self:GetChild("ElementStage/Txt2")
  self._elementContentTxtRectX = self._elementContentTxt:GetRectSize()
  self._elementContentTxtWidthX, self._elementContentTxtWidthOX = self._elementContentTxt:GetWidth(self._elementContentTxtWidthOX)
  self._elementContentNumPosX, self._elementContentNumPosOX, self._elementContentNumPosY, self._elementContentNumPosOY = self._elementContentNum:GetPosition()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:SetActive(GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity")
  self._jobLimit = self:GetChild("JobLimit")
  self._jobLimitTxt = self:GetChild("JobLimit/Txt2")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._btn1:Subscribe_PointerClickEvent(self.OnBtn1Clicked, self)
  self._btn4:Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
  self._supportRolePanel:Subscribe_PointerClickEvent(self.ChooseSupportRole, self)
  self._switchPositionBtn:Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  self._switchFinishBtn:Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  self._autoTeamBtn:Subscribe_PointerClickEvent(self.OnAutoTeamBtnClicked, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementBtnClicked, self)
  self._dontOpenAutoTeamDialog = NekoData.BehaviorManager.BM_Game:GetFloorIsUnlockWithMainLineId(tonumber(CVarconfig:GetRecorder(85).Value))
  self:LoadLocalData()
  local currentTeamId = NekoData.BehaviorManager.BM_Team:GetCurrentTeamId()
  if currentTeamId == 5001 then
    currentTeamId = 1
  end
  self:Refresh(currentTeamId)
  local ImageRecord = iconItem:GetIcon()
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._autoTip = self:GetChild("Auto")
  LuaNotificationCenter.AddObserver(self, self.OnEnterDungeon, Common.n_EnterDungeon, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTeam, Common.n_TeamInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function TeamEditPreWarDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
end

function TeamEditPreWarDialog:SetCopyInfo(copyType, id, additionalData)
  self._copyType = copyType
  self._copyID = id
  self._additionalData = additionalData
  self:JudgeIfNeedAutoTeamFunction()
  if self._copyType == "BossRush" or self._copyType == "WeekBoss" then
    self._supportLock:SetActive(true)
    self._supportEmpty:SetActive(false)
    self._supportRoleInfo = {}
    local teamList = NekoData.BehaviorManager.BM_Team:GetBossTeamsInfo()
    self._teamIdList = {}
    for id, _ in pairs(teamList) do
      table.insert(self._teamIdList, id)
    end
    if #self._teamIdList > 0 then
      self._teamList = teamList
    else
      for id, _ in pairs(self._teamList) do
        table.insert(self._teamIdList, id)
      end
    end
    for i, id in pairs(self._teamIdList) do
      if self._teamBtn[i] and self._teamBtn[i].name then
        self._teamBtn[i].name:SetText(self._teamList[id].name)
      end
    end
    table.sort(self._teamIdList, function(a, b)
      return a < b
    end)
    self:Refresh(NekoData.BehaviorManager.BM_Team:GetBossCurrentTeamId())
  end
  if self._copyType == "Resource" or self._copyType == "DispatchResource" or self._copyType == "DispatchChristmas" or self._copyType == "DispatchLover" or self._copyType == "DispatchSummer" then
    local teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
    local currentTeamId = NekoData.BehaviorManager.BM_Team:GetCurrentTeamId()
    if currentTeamId == 5001 then
      currentTeamId = 1
    end
    local resourceRecord = ResourceStageTable:GetRecorder(self._copyID)
    if resourceRecord then
      local resourceDungeonInfoId = tonumber(resourceRecord.dungeonID)
      for _, id in ipairs(ResourceDungeonInfoType.DefendRecover) do
        if resourceDungeonInfoId == id then
          teamList = NekoData.BehaviorManager.BM_Team:GetDefendRecoverTeamsInfo()
          currentTeamId = NekoData.BehaviorManager.BM_Team:GetDefendRecoverCurrentTeamId()
          break
        end
      end
      for _, id in ipairs(ResourceDungeonInfoType.AssassinDamage) do
        if resourceDungeonInfoId == id then
          teamList = NekoData.BehaviorManager.BM_Team:GetAssassinDamageTeamsInfo()
          currentTeamId = NekoData.BehaviorManager.BM_Team:GetAssassinDamageCurrentTeamId()
          break
        end
      end
      for _, id in ipairs(ResourceDungeonInfoType.MagicImpair) do
        if resourceDungeonInfoId == id then
          teamList = NekoData.BehaviorManager.BM_Team:GetMagicImpairTeamsInfo()
          currentTeamId = NekoData.BehaviorManager.BM_Team:GetMagicImpairCurrentTeamId()
          break
        end
      end
    end
    self._teamIdList = {}
    for id, _ in pairs(teamList) do
      table.insert(self._teamIdList, id)
    end
    if #self._teamIdList > 0 then
      self._teamList = teamList
    else
      for id, _ in pairs(self._teamList) do
        table.insert(self._teamIdList, id)
      end
    end
    table.sort(self._teamIdList, function(a, b)
      return a < b
    end)
    for i, v in ipairs(self._teamBtn) do
      v.btn:SetActive(false)
    end
    for i, id in ipairs(self._teamIdList) do
      if self._teamBtn[i] and self._teamBtn[i].name then
        self._teamBtn[i].btn:SetActive(true)
        self._teamBtn[i].name:SetText(self._teamList[id].name)
      end
    end
    self:Refresh(currentTeamId)
  end
  if self._copyType == "AutoExploreResource" then
    local teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
    local currentTeamId = NekoData.BehaviorManager.BM_Team:GetCurrentTeamId()
    self._teamIdList = {}
    for id, _ in pairs(teamList) do
      table.insert(self._teamIdList, id)
    end
    if #self._teamIdList > 0 then
      self._teamList = teamList
    else
      for id, _ in pairs(self._teamList) do
        table.insert(self._teamIdList, id)
      end
    end
    table.sort(self._teamIdList, function(a, b)
      return a < b
    end)
    for i, v in ipairs(self._teamBtn) do
      v.btn:SetActive(false)
    end
    for i, id in ipairs(self._teamIdList) do
      if self._teamBtn[i] and self._teamBtn[i].name then
        self._teamBtn[i].btn:SetActive(true)
        self._teamBtn[i].name:SetText(self._teamList[id].name)
      end
    end
    self:Refresh(currentTeamId)
  end
  LogInfoFormat("TeamEditPreWarDialog", "--- copyType = %s ---", self._copyType)
  if self._copyType == "AutoExploreMainline" or self._copyType == "AutoExploreResource" or self._copyType == DungeonType.ACTIVITY or self._copyType == "AutoExploreStarMirage" or self._copyType == "AutoExploreSwimSuit" or self._copyType == "AutoExploreSwimSuitEchoes" or self._copyType == "AutoExploreChristmas" or self._copyType == "AutoExploreLover" or self._copyType == "AutoExploreSummerEchoes" then
    self._autoTip:SetActive(true)
    for i, v in ipairs(self._teamBtn) do
      v.btn:SetActive(false)
    end
    if self._copyType == "AutoExploreSummerEchoes" or self._copyType == DungeonType.ACTIVITY or self._copyType == "AutoExploreResource" or self._copyType == "AutoExploreLover" then
      self:Refresh(5001)
    end
  end
  if self._copyType == "SwimSuitEchoesChallenge" then
    self._supportLock:SetActive(true)
    self._supportEmpty:SetActive(false)
    self._supportRoleInfo = {}
    local teamList = NekoData.BehaviorManager.BM_Team:GetSRChallengeTeamInfo()
    self._teamIdList = {}
    for id, _ in pairs(teamList) do
      table.insert(self._teamIdList, id)
    end
    if #self._teamIdList > 0 then
      self._teamList = teamList
    else
      for id, _ in pairs(self._teamList) do
        table.insert(self._teamIdList, id)
      end
    end
    for i, v in ipairs(self._teamBtn) do
      v.btn:SetActive(false)
    end
    for i, id in pairs(self._teamIdList) do
      if self._teamBtn[i] and self._teamBtn[i].name then
        self._teamBtn[i].btn:SetActive(true)
        self._teamBtn[i].name:SetText(self._teamList[id].name)
      end
    end
    table.sort(self._teamIdList, function(a, b)
      return a < b
    end)
    self:Refresh(NekoData.BehaviorManager.BM_Team:GetSRChallengeTeamId())
  end
  self:GetSupportVocationTable()
end

function TeamEditPreWarDialog:GoTowerBattle(index)
  self._isTowerBattle = true
  self._dialogStr = "tower.towerbattleteamlargecharactercell"
  self._supportRoleInfo = {}
  self._supportLock:SetActive(true)
  self._supportEmpty:SetActive(false)
  self._towerIndex = index
  local teamList = NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()
  self._teamIdList = {}
  for id, _ in pairs(teamList) do
    table.insert(self._teamIdList, id)
  end
  if #self._teamIdList > 0 then
    self._teamList = teamList
  else
    for id, _ in pairs(self._teamList) do
      table.insert(self._teamIdList, id)
    end
  end
  table.sort(self._teamIdList, function(a, b)
    return a < b
  end)
  self:Refresh(NekoData.BehaviorManager.BM_Team:GetTowerCurrentTeamId())
end

function TeamEditPreWarDialog:FirstEnterDungeon()
  self._firstEnterDungeon = true
  self._menuBtn:SetActive(false)
end

function TeamEditPreWarDialog:DestroyModal(dialog)
end

function TeamEditPreWarDialog:OnRefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
end

function TeamEditPreWarDialog:OnRefreshCurrency()
end

function TeamEditPreWarDialog:RefreshFashion()
  for posi, _ in ipairs(self._pos) do
    local index
    for i, v in ipairs(self._curTeamRoles) do
      if posi == v.station and v.roleKey ~= 0 then
        index = i
        break
      end
    end
    if self._charLargeCell[posi] then
      self._charLargeCell[posi]:Destroy()
      self._charLargeCell[posi]:RootWindowDestroy()
      self._charLargeCell[posi] = nil
    end
    if index then
      local cell = DialogManager.CreateDialog(self._dialogStr, self._pos[posi]._uiObject)
      cell:RefreshCell(self._curTeamRoles[index], self)
      self._charLargeCell[posi] = cell
    end
  end
end

function TeamEditPreWarDialog:RefreshSupportRoleInfo()
  if self._isTowerBattle or self._copyType == "AutoExploreMainline" or self._copyType == "AutoExploreResource" or self._copyType == DungeonType.ACTIVITY or self._copyType == "AutoExploreStarMirage" or self._copyType == "AutoExploreSwimSuit" or self._copyType == "AutoExploreSwimSuitEchoes" or self._copyType == "AutoExploreChristmas" or self._copyType == "AutoExploreLover" or self._copyType == "AutoExploreSummerEchoes" or self._copyType == "DispatchResource" or self._copyType == "DispatchChristmas" or self._copyType == "DispatchLover" or self._copyType == "DispatchSummer" or self._copyType == "DispatchSummerEchoes" or self._copyType == "DispatchStarryMirror" then
    self._supportLock:SetActive(true)
    self._supportEmpty:SetActive(false)
    self._supportRoleInfo = {}
    if self._supportRoleCell then
      self._supportRoleCell:Destroy()
      self._supportRoleCell:RootWindowDestroy()
      self._supportRoleCell = nil
    end
  else
    self._supportLock:SetActive(false)
    self._supportRoleInfo = NekoData.BehaviorManager.BM_Team:GetSupportRole()
    if self._supportRoleInfo.role then
      if self._supportRoleCell then
        self._supportRoleCell:Destroy()
        self._supportRoleCell:RootWindowDestroy()
        self._supportRoleCell = nil
      end
      local cell = DialogManager.CreateDialog("assistbattle.teameditsupportrolecell", self._supportRolePos._uiObject)
      cell:RefreshCell(self._supportRoleInfo.role)
      self._supportRoleCell = cell
    else
      if self._supportRoleCell then
        self._supportRoleCell:Destroy()
        self._supportRoleCell:RootWindowDestroy()
        self._supportRoleCell = nil
      end
      self._supportEmpty:SetActive(true)
    end
    if self._supportRoleInfo.user then
      self._supportRoleName:SetText(self._supportRoleInfo.user:GetName())
    else
      self._supportRoleName:SetText(TextManager.GetText(CStringRes:GetRecorder(1498).msgTextID))
    end
  end
end

local function CheckMainRolesSecondSkillUnlock(self)
  if DialogManager.GetDialog("dungeon.dungeonnextfloordialog") or self._copyType ~= "MainLine" and self._copyType ~= "AutoExploreMainline" then
    return
  else
    local list
    for i, v in ipairs(self._curTeamRoles) do
      if v.station <= 3 then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey)
        if role then
          local skill2Info = role:GetShowSkillDataByIndex(2)
          if not skill2Info.unlock then
            list = list or {}
            table.insert(list, role)
          end
        end
      end
    end
    if not list then
      return
    else
      DialogManager.CreateSingletonChildDialog("teamedit.promptunlockskilldialog", self._dialogName, self._rootWindow):SetData(list)
      return true
    end
  end
end

function TeamEditPreWarDialog:CheckTeamRationalForBeginTask()
  local notRationalTipsType = self:CheckIfTeamRational()
  if notRationalTipsType == AutoTeamShowType.LevelNotSatisfied and not self._levelNotSatisfiedHasReminder then
    self._levelNotSatisfiedHasReminder = true
    
    local function func()
      local minLevelRoleTable = {role = nil, value = 10000}
      for i, v in ipairs(self._curTeamRoles) do
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey)
        if role and not role:IsInAlternativeTeams(self._teamId) and role:GetLevel() < minLevelRoleTable.value then
          minLevelRoleTable.role = role
          minLevelRoleTable.value = role:GetLevel()
        end
      end
      local dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
      dialog:Refresh(minLevelRoleTable.role)
      dialog:OnLevelUpPanelClick()
    end
    
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      if self._minBreakLevel > 0 then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(110, {
          self._minBreakLevel,
          self._minRoleLevel
        }, func, {}, nil, {})
      else
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(113, {
          self._minRoleLevel
        }, func, {}, nil, {})
      end
    end
  elseif notRationalTipsType and notRationalTipsType ~= AutoTeamShowType.LevelNotSatisfied and not self._dontOpenAutoTeamDialog then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(117, nil, function()
      self:OnAutoTeamBtnClicked()
    end, {}, function()
      local value = CheckMainRolesSecondSkillUnlock(self)
      if not value then
        self:BeginTaskBtnClicked()
      end
    end, {})
  else
    local value = CheckMainRolesSecondSkillUnlock(self)
    if not value then
      self:BeginTaskBtnClicked()
    end
  end
end

function TeamEditPreWarDialog:OnRefreshTeam(notification)
  self:LoadLocalData()
  self:Refresh(self._teamId)
  if notification.userInfo.name == "schangeroles" then
    if self._haveSendCConfirmRolesBeforeEnterDungeon then
      self._haveSendCConfirmRolesBeforeEnterDungeon = false
      self:CheckTeamRationalForBeginTask()
    end
    if self._haveSendCConfirmRolesWhenClickAutoTeamBtn then
      self._haveSendCConfirmRolesWhenClickAutoTeamBtn = false
    end
  end
end

function TeamEditPreWarDialog:OnRefresh(notification)
  self:LoadLocalData()
  self:Refresh(self._teamId)
end

function TeamEditPreWarDialog:LoadLocalData()
  local teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
  if self._isTowerBattle then
    teamList = NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()
  elseif self._copyType == "BossRush" or self._copyType == "WeekBoss" then
    teamList = NekoData.BehaviorManager.BM_Team:GetBossTeamsInfo()
  elseif self._copyType == "BossRush" or self._copyType == "WeekBoss" then
    teamList = NekoData.BehaviorManager.BM_Team:GetBossTeamsInfo()
  elseif self._copyType == "SwimSuitEchoesChallenge" then
    teamList = NekoData.BehaviorManager.BM_Team:GetSRChallengeTeamInfo()
  elseif self._copyType == "Resource" or self._copyType == "DispatchResource" or self._copyType == "DispatchChristmas" or self._copyType == "DispatchLover" or self._copyType == "DispatchSummer" then
    local resourceRecord = ResourceStageTable:GetRecorder(self._copyID)
    if resourceRecord then
      local resourceDungeonInfoId = tonumber(resourceRecord.dungeonID)
      for _, id in ipairs(ResourceDungeonInfoType.DefendRecover) do
        if resourceDungeonInfoId == id then
          teamList = NekoData.BehaviorManager.BM_Team:GetDefendRecoverTeamsInfo()
          break
        end
      end
      for _, id in ipairs(ResourceDungeonInfoType.AssassinDamage) do
        if resourceDungeonInfoId == id then
          teamList = NekoData.BehaviorManager.BM_Team:GetAssassinDamageTeamsInfo()
          break
        end
      end
      for _, id in ipairs(ResourceDungeonInfoType.MagicImpair) do
        if resourceDungeonInfoId == id then
          teamList = NekoData.BehaviorManager.BM_Team:GetMagicImpairTeamsInfo()
          break
        end
      end
    end
  end
  self._teamIdList = {}
  for id, _ in pairs(teamList) do
    table.insert(self._teamIdList, id)
  end
  if #self._teamIdList > 0 then
    self._teamList = teamList
  else
    for id, _ in pairs(self._teamList) do
      table.insert(self._teamIdList, id)
    end
  end
  table.sort(self._teamIdList, function(a, b)
    return a < b
  end)
  for i, id in ipairs(self._teamIdList) do
    if self._teamBtn[i] and self._teamBtn[i].name then
      self._teamBtn[i].name:SetText(self._teamList[id].name)
    end
  end
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  self:RefreshSupportRoleInfo()
end

function TeamEditPreWarDialog:Refresh(teamId)
  if #self._teamIdList > 0 and teamId and 0 < teamId and self._teamList[teamId] then
    self._teamId = teamId
    self._teamInfo = self._teamList[teamId]
  end
  if self._teamInfo then
    self._name = self._teamInfo.name
    for i, id in ipairs(self._teamIdList) do
      local v = self._teamBtn[i]
      if v then
        if id == teamId then
          v.btn:SetSelected(true)
          if v.editBtn then
            v.editBtn:SetActive(true)
          end
        else
          v.btn:SetSelected(false)
          if v.editBtn then
            v.editBtn:SetActive(false)
          end
        end
      end
    end
    while self._curTeamRoles[#self._curTeamRoles] do
      table.remove(self._curTeamRoles, #self._curTeamRoles)
    end
    for k, v in pairs(self._teamInfo.roles) do
      local temp = {}
      temp.station = k
      temp.roleKey = v
      table.insert(self._curTeamRoles, temp)
    end
    table.sort(self._curTeamRoles, function(a, b)
      return a.station > b.station
    end)
    for posi, _ in ipairs(self._pos) do
      local index
      for i, v in ipairs(self._curTeamRoles) do
        if posi == v.station and v.roleKey ~= 0 then
          index = i
          break
        end
      end
      if self._charLargeCell[posi] then
        self._charLargeCell[posi]:Destroy()
        self._charLargeCell[posi]:RootWindowDestroy()
        self._charLargeCell[posi] = nil
      end
      if index then
        local cell = DialogManager.CreateDialog(self._dialogStr, self._pos[posi]._uiObject)
        cell:RefreshCell(self._curTeamRoles[index], self)
        self._charLargeCell[posi] = cell
      end
    end
    local tag = false
    for k, v in pairs(self._teamInfo.roles) do
      if v and v ~= 0 then
        tag = true
        break
      end
    end
    self._btn4:SetInteractable(tag)
    self:RefreshTeamElementInfo()
  end
  self:JudgeIfNeedAutoTeamFunction()
end

function TeamEditPreWarDialog:JudgeIfNeedAutoTeamFunction()
  local isMainLine = CDungeonSelectMainlineTable:GetRecorder(self._copyID)
  local showAutoTeamTip = false
  if isMainLine and not NekoData.BehaviorManager.BM_Game:GetFloorIsPassWithMainLineId(self._copyID) then
    showAutoTeamTip = true
  end
  if self._copyType == "Resource" then
    showAutoTeamTip = true
  end
  self._autoTeamTip:SetActive(false)
  if showAutoTeamTip then
    local notRationalTipsType = self:CheckIfTeamRational()
    if notRationalTipsType then
      local str = ""
      if notRationalTipsType == AutoTeamShowType.NoHealRole then
        str = TextManager.GetText(600146)
      elseif notRationalTipsType == AutoTeamShowType.NoOutputRole then
        str = TextManager.GetText(600147)
      elseif notRationalTipsType == AutoTeamShowType.NoBearDamageRoleInFrontOrAlternateFront then
        str = TextManager.GetText(600148)
      elseif notRationalTipsType == AutoTeamShowType.LevelNotSatisfied then
        str = TextManager.GetText(600149)
      elseif notRationalTipsType == AutoTeamShowType.ResourceVocationLimit then
        str = TextManager.GetText(600154)
      end
      self._autoTeamTip:SetActive(true)
      self._autoTeamTip:SetText(str)
    end
  end
end

function TeamEditPreWarDialog:CheckIfTeamRational()
  local isMainLine = CDungeonSelectMainlineTable:GetRecorder(self._copyID)
  local checkTag = false
  self._recommendLevel = 0
  self._minBreakLevel = 0
  self._minRoleLevel = 0
  if isMainLine and NekoData.BehaviorManager.BM_Game:GetFloorIsUnlockWithMainLineId(tonumber(CVarconfig:GetRecorder(84).Value)) and not NekoData.BehaviorManager.BM_Game:GetFloorIsPassWithMainLineId(self._copyID) then
    checkTag = true
    self._recommendLevel = CDungeonSelectMainlineTable:GetRecorder(self._copyID).magic
    self._minBreakLevel = CRoleLevelCfgTable:GetRecorder(self._recommendLevel).clientBreakLevel
    self._minRoleLevel = CRoleLevelCfgTable:GetRecorder(self._recommendLevel).clientLevel
  end
  if self._copyType == "Resource" or self._copyType == "DispatchResource" or self._copyType == "DispatchChristmas" or self._copyType == "DispatchLover" or self._copyType == "DispatchSummer" then
    local ResourceRecord = ResourceStageTable:GetRecorder(self._copyID)
    if ResourceRecord then
      self._recommendLevel = tonumber(ResourceStageTable:GetRecorder(self._copyID).levelShow)
      self._minBreakLevel = CRoleLevelCfgTable:GetRecorder(self._recommendLevel).clientBreakLevel
      self._minRoleLevel = CRoleLevelCfgTable:GetRecorder(self._recommendLevel).clientLevel
      local supportVocationTable = NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationTable(self._copyID)
      if supportVocationTable then
        for _, v in pairs(self._curTeamRoles) do
          local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey)
          if role and not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(role, supportVocationTable) then
            return AutoTeamShowType.ResourceVocationLimit
          end
        end
      else
        local notPass = not NekoData.BehaviorManager.BM_Game:GetResourceFloorIsPassWithStageId(self._copyID)
        if notPass and self._recommendLevel <= 30 then
          checkTag = true
        end
      end
    end
  end
  if not checkTag then
    return
  end
  local reasonType
  local haveNoHealRole = true
  local haveNoOutputRole = true
  local frontNoBearDamage = true
  for i, v in ipairs(self._curTeamRoles) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey)
    if role then
      local isMainTeamMember = not role:IsInAlternativeTeams(self._teamId)
      if isMainTeamMember and role:GetLevel() + 10 <= self._recommendLevel then
        reasonType = AutoTeamShowType.LevelNotSatisfied
      end
      if isMainTeamMember and role:GetLevel() - 5 >= self._recommendLevel then
        return
      end
      local someRoleIdList = string.split(CBattleConstCfgTable:GetRecorder(115).attr, ";")
      local isSomeRole = false
      for _, roleId in ipairs(someRoleIdList) do
        if role:GetId() == tonumber(roleId) then
          isSomeRole = true
          break
        end
      end
      if isMainTeamMember and (role:GetVocationId() == VocationType.Heal or role:GetVocationId() == VocationType.Impair or isSomeRole) then
        haveNoHealRole = false
      end
      if isMainTeamMember and role:GetVocationId() ~= VocationType.Heal then
        haveNoOutputRole = false
      end
      if v.station == LineUpStation.FRONT_ROW and (role:GetVocationId() == VocationType.Defend or role:GetVocationId() == VocationType.Damage or role:GetVocationId() == VocationType.Assassin) then
        frontNoBearDamage = false
      end
    end
  end
  if haveNoHealRole then
    reasonType = AutoTeamShowType.NoHealRole
  elseif haveNoOutputRole then
    reasonType = AutoTeamShowType.NoOutputRole
  elseif frontNoBearDamage then
    reasonType = AutoTeamShowType.NoBearDamageRoleInFrontOrAlternateFront
  end
  return reasonType
end

function TeamEditPreWarDialog:RefreshTeamElementInfo()
  self._extraElemenEffect = {}
  if self._copyType == "WeekBoss" and NekoData.BehaviorManager.BM_WeekBoss:GetTeamAddtion() then
    self._extraElemenEffect.type = CBattleStartProtocol.WEEK_BOSS
  end
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station, roleId in pairs(self._teamInfo.roles) do
    if roleId ~= 0 then
      haveTeamInfo = true
      stationElementTag[station] = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(roleId):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        table.insert(etherStationList, station)
      end
    end
  end
  self._oneTotalElementValue = nil
  self._elementStage = nil
  if haveTeamInfo then
    if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
      end
    elseif stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
      end
    elseif stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
      end
    elseif stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
      end
    elseif stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
      end
    elseif stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
      for _, station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
      end
    end
    if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.BACK_ROW] then
      self._elementStage = 1
      if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] then
        self._elementStage = 2
      end
      self._oneTotalElementValue = stationElementTag[LineUpStation.FRONT_ROW]
    end
  end
  local StageType = {NoStage = 0}
  if self._elementStage then
    local elementRecord = CElementEffect:GetRecorder(self._elementStage)
    local imgRecord = CImagePathTable:GetRecorder(elementRecord.image) or DataCommon.DefaultImageAsset
    self._elementImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    local str = TextManager.GetText(CStringRes:GetRecorder(1492).msgTextID)
    self._elementContentTxt:SetText(str)
    local delta = self._elementContentTxt:GetPreferredSize() - self._elementContentTxtRectX
    self._elementContentTxt:SetWidth(self._elementContentTxtWidthX, self._elementContentTxtWidthOX + delta)
    self._elementContentNum:SetPosition(self._elementContentNumPosX, self._elementContentNumPosOX + delta, self._elementContentNumPosY, self._elementContentNumPosOY)
    self._elementContentNum:SetActive(true)
    local effect = elementRecord.effect
    if self._extraElemenEffect and self._extraElemenEffect.type == CBattleStartProtocol.WEEK_BOSS then
      effect = elementRecord.weekBossEffect
    end
    self._elementContentNum:SetText(tostring(math.floor(effect / 1000 * 100)) .. "%")
  else
    local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
    local imgRecord = CImagePathTable:GetRecorder(elementRecord.image) or DataCommon.DefaultImageAsset
    self._elementImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self._elementContentTxt:SetText(TextManager.GetText(elementRecord.describe))
    local delta = self._elementContentTxt:GetPreferredSize() - self._elementContentTxtRectX
    self._elementContentTxt:SetWidth(self._elementContentTxtWidthX, self._elementContentTxtWidthOX + delta)
    self._elementContentNum:SetActive(false)
  end
end

function TeamEditPreWarDialog:OnEnterDungeon()
  DialogManager.DestroySingletonDialog("mainline.mainline.newmainlinefloordialog")
  DialogManager.DestroySingletonDialog("mainline.mainline.mainlineworlddialog")
  DialogManager.DestroySingletonDialog("dungeon.dungeonnextfloordialog")
  DialogManager.DestroySingletonDialog("dungeon.branchlinenextfloordialog")
  DialogManager.DestroySingletonDialog("base.basemainui")
  DialogManager.DestroySingletonDialog("base.basemainmenudialog")
  DialogManager.DestroySingletonDialog("assistbattle.choosesupportroledialog")
  self:Destroy()
end

function TeamEditPreWarDialog:OnBtn1Clicked()
  if self._isTowerBattle then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(3, nil, function()
      local cbreakLineup = LuaNetManager.CreateProtocol("protocol.battle.ctowerbreaklineup")
      if cbreakLineup then
        cbreakLineup.lineupId = self._teamId
        cbreakLineup:Send()
        self._btn4:SetInteractable(false)
      end
    end, {}, nil, {})
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(3, nil, function()
      local cbreakLineup = LuaNetManager.CreateProtocol("protocol.login.cbreaklineup")
      if cbreakLineup then
        cbreakLineup.lineupId = self._teamId
        cbreakLineup:Send()
        self._btn4:SetInteractable(false)
      end
    end, {}, nil, {})
  end
end

function TeamEditPreWarDialog:OnBtn4Clicked()
  local guideTag = false
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(17) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(17)
    guideTag = true
  elseif NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(13) then
    NekoData.BehaviorManager.BM_Game:SetGuideTag(GuideType.FIRST_ENTER_DUNGEON, 1)
    guideTag = true
  elseif NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(5) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(5)
  elseif NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(35) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(35)
  elseif NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(52) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(52)
  end
  if guideTag then
    self:BeginTaskBtnClicked()
    return
  end
  local frontRoleId, frontAlternativeRoleId = 0, 0
  local middleRoleId, middleAlternativeRoleId = 0, 0
  local backRoleId, backAlternativeRoleId = 0, 0
  for _, v in ipairs(self._curTeamRoles) do
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
  for _, value in pairs(self._teamInfo.roles) do
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(value)
    if role ~= nil and not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(role, self._supportVocationTable) then
      haveJobLimit = true
    end
  end
  if frontRoleId == 0 and frontAlternativeRoleId ~= 0 or middleRoleId == 0 and middleAlternativeRoleId ~= 0 or backRoleId == 0 and backAlternativeRoleId ~= 0 then
    haveOneAlternativeRoleButNoInBattleRole = true
  elseif frontRoleId == 0 or middleRoleId == 0 or backRoleId == 0 or frontAlternativeRoleId == 0 or middleAlternativeRoleId == 0 or backAlternativeRoleId == 0 then
    haveSomeEmptyVacancy = true
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AlterNativeRole) and frontRoleId ~= 0 and middleRoleId ~= 0 and backRoleId ~= 0 then
      haveSomeEmptyVacancy = false
    end
  end
  if self._copyType == "AutoExploreMainline" or self._copyType == "AutoExploreResource" or self._copyType == DungeonType.ACTIVITY or self._copyType == "AutoExploreStarMirage" or self._copyType == "AutoExploreSwimSuit" or self._copyType == "AutoExploreSwimSuitEchoes" or self._copyType == "AutoExploreChristmas" or self._copyType == "AutoExploreLover" or self._copyType == "AutoExploreSummerEchoes" then
    haveJobLimit = false
    haveOneAlternativeRoleButNoInBattleRole = false
    haveSomeEmptyVacancy = false
  end
  if haveJobLimit then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100226)
    for _, oneLargeCell in pairs(self._charLargeCell) do
      oneLargeCell:PlayTwinkleByVocationLimit()
    end
  elseif haveOneAlternativeRoleButNoInBattleRole then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(68, nil, function()
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
      local req = LuaNetManager.CreateProtocol("protocol.login.cconfirmroles")
      req.lineupId = self._teamId
      req.roles = {
        [LineUpStation.FRONT_ROW] = frontRoleId,
        [LineUpStation.MIDDLE_ROW] = middleRoleId,
        [LineUpStation.BACK_ROW] = backRoleId,
        [LineUpStation.ALTERNATE_FRONT_ROW] = frontAlternativeRoleId,
        [LineUpStation.ALTERNATE_MIDDLE_ROW] = middleAlternativeRoleId,
        [LineUpStation.ALTERNATE_BACK_ROW] = backAlternativeRoleId
      }
      req:Send()
      self._haveSendCConfirmRolesBeforeEnterDungeon = true
    end)
  elseif haveSomeEmptyVacancy then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(69, nil, function()
      self:CheckTeamRationalForBeginTask()
    end)
  else
    self:CheckTeamRationalForBeginTask()
  end
end

function TeamEditPreWarDialog:BeginTaskBtnClicked()
  local tag = false
  for i, v in ipairs(self._teamInfo.roles) do
    if v and v ~= 0 then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
      if not tag and role:GetHurtExtent() ~= 0 then
        tag = true
        break
      end
    end
  end
  if tag then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100018)
  elseif self._testBattleInfo then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    if self._testBattleInfo.isArena then
      req.battleType = req.ARENA
    else
      req.battleType = req.TEST
    end
    req.id = self._testBattleInfo.battleId
    req.battleSceneId = self._testBattleInfo.battleSceneId
    LogErrorFormat("TeamEditPreWarDialog", "--- battleId = %s, battleSceneId = %s ---", self._testBattleInfo.battleId, self._testBattleInfo.battleSceneId)
    req.lineupID = self._teamId
    req:Send()
  elseif self._firstEnterDungeon then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    csend.dungeonType = type.MAIN
    csend.id = 1
    csend.lineupId = 1
    LogInfoFormat("TeamEditPreWarDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
    csend:Send()
  elseif self._isTowerBattle then
    NekoData.BehaviorManager.BM_Tower:StartBattle(self._towerIndex, self._teamId)
  elseif self._copyType == "AutoExploreMainline" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.MAIN
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreResource" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.RESOURCE
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "Resource" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    csend.battleType = csend.RESOURCE
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "DispatchResource" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.RESOURCE
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == "DispatchChristmas" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.CHRISTMAS
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == "DispatchLover" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.LOVER
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == "DispatchSummer" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.SUMMER
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == "DispatchStarryMirror" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.STARRY_MIRROR
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == "DispatchSummerEchoes" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.SUMMER_ECHO
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == "BossRush" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    csend.battleType = csend.BOSS_RUSH
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "WeekBoss" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    LogErrorFormat("teameditprewardialog", "id %s teamid %s", self._copyID, self._teamId)
    csend.battleType = csend.WEEK_BOSS
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "BranchLine" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
    local dungeontype = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    local type = dungeontype.SIDE_QUEST
    local id = self._copyID
    csend.dungeonType = type
    csend.id = id
    csend.lineupId = self._teamId
    LogInfoFormat("TeamEditPreWarDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
    csend:Send()
  elseif self._copyType == "StarMirage" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    csend.battleType = csend.STARRY
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "SwimSuit" then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.csummeractivityevent")
    csend.constructionID = self._additionalData
    csend.eventID = self._copyID
    csend.lineupID = self._teamId
    LogError(self._teamId, self._copyID .. " " .. self._additionalData)
    csend:Send()
  elseif self._copyType == "SwimSuitEchoes" or self._copyType == "SwimSuitEchoesChallenge" then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.csummerechoevent")
    csend.constructionID = self._additionalData
    csend.eventID = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "Christmas" then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
    csend.constructionID = self._additionalData
    csend.eventID = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "Lover" then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cloveractivityevent")
    csend.constructionID = self._additionalData
    csend.eventID = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == CBattleStartProtocol.ANNIVERSARY then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    csend.battleType = self._copyType
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == "DispatchAnniversary" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cstartsweep")
    csend.battleType = CBattleStartProtocol.ANNIVERSARY
    csend.id = self._copyID
    csend.lineupId = self._teamId
    csend.sweepNum = self._additionalData
    csend:Send()
  elseif self._copyType == CBattleStartProtocol.STARRY_MIRROR then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    csend.battleType = self._copyType
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  elseif self._copyType == DungeonType.ACTIVITY then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    req.zoneId = self._copyID
    req.dungeonType = DungeonType.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreStarMirage" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreSwimSuit" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreSwimSuitEchoes" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreChristmas" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreLover" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "AutoExploreSummerEchoes" then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cstartautoexplore")
    local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    req.zoneId = self._copyID
    req.dungeonType = type.ACTIVITY
    req:Send()
    NekoData.DataManager.DM_Game:SetAutoExploreProtocol(req)
  elseif self._copyType == "SpringFestival" then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
    csend.battleType = csend.SPRING_FESTIVAL
    csend.id = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  else
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
    local dialog = DialogManager.GetDialog("mainline.mainline.newmainlinefloordialog")
    local dungeontype = LuaNetManager.CreateBean("protocol.battle.dungeontype")
    local type = dungeontype.MAIN
    local id = 0
    local dialogs = {
      [dungeontype.MAIN] = DialogManager.GetDialog("mainline.mainline.newmainlinefloordialog")
    }
    for k, v in pairs(dialogs) do
      if v then
        type = k
        dialog = v
        break
      end
    end
    if dialog then
      id = dialog:GetFloorDetail().id
    else
      id = self._copyID
    end
    local unreasonableLineupTip = self:UnreasonableLineupTip(id, function()
      csend.dungeonType = type
      csend.id = id
      csend.lineupId = self._teamId
      LogInfoFormat("TeamEditPreWarDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
      csend:Send()
    end)
    if not unreasonableLineupTip then
      csend.dungeonType = type
      csend.id = id
      csend.lineupId = self._teamId
      LogInfoFormat("TeamEditPreWarDialog", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
      csend:Send()
    end
  end
  local randomKey = NekoData.BehaviorManager.BM_Team:GetRandomRoleKeyInTeam(self._teamId)
  local roleID = randomKey
  NekoData.BehaviorManager.BM_Voice:Play(roleID, NekoData.BehaviorManager.BM_Voice.VoiceType.Adventure, nil)
end

function TeamEditPreWarDialog:ChooseSupportRole()
  if self:IsCurCopyTypeDispatch() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100472)
    return
  end
  if self._isTowerBattle then
    return
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) then
    if self._copyType == "BossRush" or self._copyType == "WeekBoss" then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100090)
      return
    end
    if self._copyType == "StarMirage" and BM_StarMirage:IsBossLevel(self._copyID) or self._copyType == "SwimSuitEchoesChallenge" or self._copyType == CBattleStartProtocol.ANNIVERSARY and NekoData.BehaviorManager.BM_Anniversary:IsBossLevel(self._copyID) or self._copyType == "DispatchAnniversary" and NekoData.BehaviorManager.BM_Anniversary:IsBossLevel(self._copyID) or self._copyType == CBattleStartProtocol.STARRY_MIRROR and NekoData.BehaviorManager.BM_StarMirageCopy:IsBossLevel(self._copyID) then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100351)
      return
    end
    if not self._firstEnterDungeon then
      DialogManager.DestroySingletonDialog("assistbattle.choosesupportroledialog")
      local dialog = DialogManager.CreateSingletonDialog("assistbattle.choosesupportroledialog")
      if dialog then
        dialog:OnSRefreshSupportRoleList(NekoData.BehaviorManager.BM_Friends:GetSupportRoleList())
      end
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100245)
  end
end

function TeamEditPreWarDialog:OnTeamClicked(index)
  for i, v in ipairs(self._teamBtn) do
    if v.editBtn then
      v.editBtn:SetActive(false)
    end
  end
  if self._teamBtn[index].editBtn then
    self._teamBtn[index].editBtn:SetActive(true)
  end
  self:Refresh(self._teamIdList[index])
end

function TeamEditPreWarDialog:OnTeamNameEditClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditchangenamedialog")
  dialog:SetTeamName(self._name, self._teamId, self._isTowerBattle)
end

function TeamEditPreWarDialog:SetTestBattleInfo(testBattleInfo)
  self._testBattleInfo = testBattleInfo
  NekoData.DataManager.DM_Team:ClearSupportRole()
  self:RefreshSupportRoleInfo()
end

function TeamEditPreWarDialog:ReturnRoleList()
  local roleList = {}
  for _, v in ipairs(self._curTeamRoles) do
    if v.roleKey ~= 0 then
      table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey))
    end
  end
  return roleList
end

function TeamEditPreWarDialog:OnBackBtnClicked()
  if self._isTowerBattle then
    self:Destroy()
    return
  end
  if not self._firstEnterDungeon then
    if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) and self._copyType ~= "BossRush" and self._copyType ~= "WeekBoss" and self._copyType ~= "AutoExploreMainline" and self._copyType ~= "AutoExploreResource" and self._copyType ~= DungeonType.ACTIVITY and self._copyType ~= "AutoExploreStarMirage" and self._copyType == "StarMirage" and not BM_StarMirage:IsBossLevel(self._copyID) and self._copyType == CBattleStartProtocol.ANNIVERSARY and not NekoData.BehaviorManager.BM_Anniversary:IsBossLevel(self._copyID) and self._copyType == "DispatchAnniversary" and not NekoData.BehaviorManager.BM_Anniversary:IsBossLevel(self._copyID) and self._copyType == CBattleStartProtocol.STARRY_MIRROR and not NekoData.BehaviorManager.BM_StarMirageCopy:IsBossLevel(self._copyID) and self._copyType ~= "SwimSuitEchoesChallenge" and self._copyType ~= "AutoExploreSwimSuit" and self._copyType ~= "AutoExploreSwimSuitEchoes" and self._copyType ~= "AutoExploreChristmas" and self._copyType ~= "AutoExploreSummerEchoes" and self._copyType ~= "AutoExploreLover" then
      local dialog = DialogManager.GetDialog("assistbattle.choosesupportroledialog")
      if not dialog and not self._testBattleInfo then
        dialog = DialogManager.CreateSingletonDialog("assistbattle.choosesupportroledialog")
      end
      if dialog then
        dialog:OnSRefreshSupportRoleList(NekoData.BehaviorManager.BM_Friends:GetSupportRoleList())
      end
    end
    self:Destroy()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100076)
  end
end

function TeamEditPreWarDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function TeamEditPreWarDialog:OnCharPosLockClicked(posIndex)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100244)
end

function TeamEditPreWarDialog:OnCharPosClicked(posIndex)
  if self._inSwitchPositionState then
    return
  end
  local index
  for i, v in ipairs(self._curTeamRoles) do
    if posIndex == v.station then
      index = i
      break
    end
  end
  if index then
    local dialog = DialogManager.CreateSingletonDialog("teamedit.changeteamroledialog")
    if self._isTowerBattle then
      dialog:Init(self._teamInfo, self._curTeamRoles[index], true)
    else
      dialog:SetFilterCondition(NekoData.BehaviorManager.BM_Team:GetTeamFilterCondition())
      dialog:Init(self._teamInfo, self._curTeamRoles[index])
    end
    dialog:SetSupportVocationTable(self._supportVocationTable)
  end
end

function TeamEditPreWarDialog:OnCharCellBeginDrag(screenPosition, data)
  self._draging = true
  self._currentDragingCellData = data
  self._tempChangeRoleList = {}
  self._pos[data.station]._uiObject.transform:SetAsLastSibling()
  local maxSortingOrderInfo = {order = 0, station = 0}
  local originalOrder = CanvasStaticFunctions.GetCanvasSortingOrder(self._charLargeCell[data.station]:GetRootWindow()._uiObject)
  for station, cell in pairs(self._charLargeCell) do
    local temp = CanvasStaticFunctions.GetCanvasSortingOrder(cell:GetRootWindow()._uiObject)
    if temp > maxSortingOrderInfo.order then
      maxSortingOrderInfo.order = temp
      maxSortingOrderInfo.station = station
    end
  end
  if data.station ~= maxSortingOrderInfo.station then
    CanvasStaticFunctions.SetCanvasSortingOrder(self._charLargeCell[data.station]:GetRootWindow()._uiObject, maxSortingOrderInfo.order)
    if originalOrder ~= -1 then
      CanvasStaticFunctions.SetCanvasSortingOrder(self._charLargeCell[maxSortingOrderInfo.station]:GetRootWindow()._uiObject, originalOrder)
    end
  end
end

function TeamEditPreWarDialog:OnCharCellDrag(screenPosition, data)
  if self._charLargeCell[data.station] then
    self._charLargeCell[data.station]:GetRootWindow():SetAnchoredPosition(UIManager.ScreenPointToLocalPointInRectangle(self._pos[data.station]._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("TeamEditPreWarDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

function TeamEditPreWarDialog:OnCharCellEndDrag(screenPosition, data)
  self._draging = false
  for _, v in ipairs(self._oneTimeChangingCurTeamRoles) do
    self._tempChangeRoleList[v.station] = v.roleKey
  end
  for i = 1, roleNum do
    if UIManager.RectangleContainsScreenPoint(self._pos[i]._uiObject, screenPosition.x, screenPosition.y) then
      local originalRoleInfo = {}
      for _, v in ipairs(self._oneTimeChangingCurTeamRoles) do
        if i == v.station then
          originalRoleInfo.station = v.station
          originalRoleInfo.roleKey = v.roleKey
        end
      end
      if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AlterNativeRole) and (originalRoleInfo.station == LineUpStation.ALTERNATE_FRONT_ROW or originalRoleInfo.station == LineUpStation.ALTERNATE_MIDDLE_ROW or originalRoleInfo.station == LineUpStation.ALTERNATE_BACK_ROW) then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100244)
        break
      end
      if originalRoleInfo.station ~= data.station then
        self._tempChangeRoleList[originalRoleInfo.station] = data.roleKey
        self._tempChangeRoleList[data.station] = originalRoleInfo.roleKey
        if self._charLargeCell[originalRoleInfo.station] then
          self._charLargeCell[originalRoleInfo.station]:Destroy()
          self._charLargeCell[originalRoleInfo.station]:RootWindowDestroy()
          self._charLargeCell[originalRoleInfo.station] = nil
        end
        if data.roleKey ~= 0 then
          local cell = DialogManager.CreateDialog(self._dialogStr, self._pos[originalRoleInfo.station]._uiObject)
          cell:RefreshCell({
            station = originalRoleInfo.station,
            roleKey = data.roleKey
          }, self)
          self._charLargeCell[originalRoleInfo.station] = cell
        end
        if self._charLargeCell[data.station] then
          self._charLargeCell[data.station]:Destroy()
          self._charLargeCell[data.station]:RootWindowDestroy()
          self._charLargeCell[data.station] = nil
        end
        if originalRoleInfo.roleKey ~= 0 then
          local cell = DialogManager.CreateDialog(self._dialogStr, self._pos[data.station]._uiObject)
          cell:RefreshCell({
            station = data.station,
            roleKey = originalRoleInfo.roleKey
          }, self)
          self._charLargeCell[data.station] = cell
        end
        for _, v in ipairs(self._oneTimeChangingCurTeamRoles) do
          if v.station == originalRoleInfo.station then
            v.roleKey = data.roleKey
          end
          if v.station == data.station then
            v.roleKey = originalRoleInfo.roleKey
          end
        end
        return
      end
      break
    end
  end
  if self._charLargeCell[data.station] then
    self._charLargeCell[data.station]:Destroy()
    self._charLargeCell[data.station]:RootWindowDestroy()
    self._charLargeCell[data.station] = nil
  end
  if data.roleKey ~= 0 then
    local cell = DialogManager.CreateDialog(self._dialogStr, self._pos[data.station]._uiObject)
    cell:RefreshCell({
      station = data.station,
      roleKey = data.roleKey
    }, self)
    self._charLargeCell[data.station] = cell
  end
end

function TeamEditPreWarDialog:OnSwitchPositionBtnClicked()
  if self._inSwitchPositionState then
    if self._draging then
      self:OnCharCellEndDrag({x = 0, y = 0}, self._currentDragingCellData)
    end
    self._switchPositionBtn:SetActive(true)
    self._switchFinishBtn:SetActive(false)
    self._inSwitchPositionState = false
    self._switchPositionBlack:SetActive(false)
    self._autoTeamBtn:SetInteractable(true)
    local haveTempChangeRole = false
    for _, v in ipairs(self._curTeamRoles) do
      if self._tempChangeRoleList and self._tempChangeRoleList[v.station] and self._tempChangeRoleList[v.station] ~= v.roleKey then
        haveTempChangeRole = true
      end
    end
    if haveTempChangeRole then
      local req = LuaNetManager.CreateProtocol("protocol.login.cconfirmroles")
      req.lineupId = self._teamId
      req.roles = {
        [LineUpStation.FRONT_ROW] = self._tempChangeRoleList[LineUpStation.FRONT_ROW],
        [LineUpStation.MIDDLE_ROW] = self._tempChangeRoleList[LineUpStation.MIDDLE_ROW],
        [LineUpStation.BACK_ROW] = self._tempChangeRoleList[LineUpStation.BACK_ROW],
        [LineUpStation.ALTERNATE_FRONT_ROW] = self._tempChangeRoleList[LineUpStation.ALTERNATE_FRONT_ROW],
        [LineUpStation.ALTERNATE_MIDDLE_ROW] = self._tempChangeRoleList[LineUpStation.ALTERNATE_MIDDLE_ROW],
        [LineUpStation.ALTERNATE_BACK_ROW] = self._tempChangeRoleList[LineUpStation.ALTERNATE_BACK_ROW]
      }
      req:Send()
      self._tempChangeRoleList = {}
    end
  else
    self._switchPositionBtn:SetActive(false)
    self._switchFinishBtn:SetActive(true)
    self._inSwitchPositionState = true
    self._switchPositionBlack:SetActive(true)
    self._autoTeamBtn:SetInteractable(false)
    self._oneTimeChangingCurTeamRoles = clone(self._curTeamRoles)
  end
end

function TeamEditPreWarDialog:OnAutoTeamBtnClicked()
  if self._haveSendCConfirmRolesWhenClickAutoTeamBtn or self._inSwitchPositionState then
    return
  end
  self._haveSendCConfirmRolesWhenClickAutoTeamBtn = true
  local allRoleOrderList = {}
  local sortDefend = {}
  local sortHeal = {}
  local sortDamage = {}
  local resourceSortDefend = {}
  local resourceSortHeal = {}
  local resourceSortAssassinAndDamage = {}
  local resourceSortMagicAndImpair = {}
  local RarityWeight = {
    [1] = 0.85,
    [2] = 0.9,
    [3] = 0.95,
    [4] = 1,
    [5] = 1
  }
  for _, role in ipairs(NekoData.BehaviorManager.BM_AllRoles:GetRoleList()) do
    table.insert(allRoleOrderList, {role = role, hasLayOnStation = false})
    local defendValue = role:GetLevel() * RarityWeight[role:GetRarityId()]
    local healValue = 0
    local damageValue = role:GetLevel() * RarityWeight[role:GetRarityId()]
    local wholeAverageValue = (defendValue + healValue + damageValue) / 3
    if role:GetVocationId() == VocationType.Defend or role:GetVocationId() == VocationType.Damage then
      table.insert(sortDefend, {
        index = #allRoleOrderList,
        value = defendValue,
        wholeAverageValue = wholeAverageValue
      })
      if role:GetVocationId() == VocationType.Defend then
        table.insert(resourceSortDefend, {
          index = #allRoleOrderList,
          value = defendValue,
          wholeAverageValue = wholeAverageValue
        })
      end
    end
    if role:GetVocationId() == VocationType.Assassin or role:GetVocationId() == VocationType.Magic or role:GetVocationId() == VocationType.Witch then
      table.insert(sortDamage, {
        index = #allRoleOrderList,
        value = damageValue,
        wholeAverageValue = wholeAverageValue
      })
    end
    if role:GetVocationId() == VocationType.Assassin or role:GetVocationId() == VocationType.Damage then
      table.insert(resourceSortAssassinAndDamage, {
        index = #allRoleOrderList,
        value = damageValue,
        wholeAverageValue = wholeAverageValue
      })
    elseif role:GetVocationId() == VocationType.Magic or role:GetVocationId() == VocationType.Impair then
      table.insert(resourceSortMagicAndImpair, {
        index = #allRoleOrderList,
        value = damageValue,
        wholeAverageValue = wholeAverageValue
      })
    end
    if role:GetVocationId() == VocationType.Heal or role:GetVocationId() == VocationType.Impair then
      healValue = role:GetLevel() * RarityWeight[role:GetRarityId()]
      damageValue = 0
      wholeAverageValue = (defendValue + healValue + damageValue) / 3
      table.insert(sortHeal, {
        index = #allRoleOrderList,
        value = healValue,
        wholeAverageValue = wholeAverageValue
      })
      if role:GetVocationId() == VocationType.Heal then
        table.insert(resourceSortHeal, {
          index = #allRoleOrderList,
          value = healValue,
          wholeAverageValue = wholeAverageValue
        })
      end
    end
  end
  for _, v in ipairs({
    sortDefend,
    sortHeal,
    sortDamage,
    resourceSortDefend,
    resourceSortHeal,
    resourceSortAssassinAndDamage,
    resourceSortMagicAndImpair
  }) do
    table.sort(v, function(a, b)
      if a.value > b.value then
        return true
      elseif a.value == b.value then
        return a.wholeAverageValue > b.wholeAverageValue
      else
        return false
      end
    end)
  end
  local req = LuaNetManager.CreateProtocol("protocol.login.cconfirmroles")
  req.lineupId = self._teamId
  req.roles = {}
  local supportVocationTable = NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationTable(self._copyID)
  if (self._copyType == "Resource" or self._copyType == "DispatchResource" or self._copyType == "DispatchChristmas" or self._copyType == "DispatchLover" or self._copyType == "DispatchSummer") and supportVocationTable then
    if table.keyof(supportVocationTable.vid, VocationType.Defend) or table.keyof(supportVocationTable.vid, VocationType.Heal) then
      local defendCountIndex = 1
      local healCountIndex = 1
      if resourceSortDefend[defendCountIndex] then
        req.roles[LineUpStation.FRONT_ROW] = allRoleOrderList[resourceSortDefend[defendCountIndex].index].role:GetRoleId()
        defendCountIndex = defendCountIndex + 1
      elseif resourceSortHeal[healCountIndex] then
        req.roles[LineUpStation.MIDDLE_ROW] = allRoleOrderList[resourceSortHeal[healCountIndex].index].role:GetRoleId()
        healCountIndex = healCountIndex + 1
      end
      if resourceSortDefend[defendCountIndex] then
        req.roles[LineUpStation.MIDDLE_ROW] = allRoleOrderList[resourceSortDefend[defendCountIndex].index].role:GetRoleId()
        defendCountIndex = defendCountIndex + 1
      elseif resourceSortHeal[healCountIndex] then
        req.roles[LineUpStation.MIDDLE_ROW] = allRoleOrderList[resourceSortHeal[healCountIndex].index].role:GetRoleId()
        healCountIndex = healCountIndex + 1
      end
      if resourceSortHeal[healCountIndex] then
        req.roles[LineUpStation.BACK_ROW] = allRoleOrderList[resourceSortHeal[healCountIndex].index].role:GetRoleId()
        healCountIndex = healCountIndex + 1
      elseif resourceSortDefend[defendCountIndex] then
        req.roles[LineUpStation.BACK_ROW] = allRoleOrderList[resourceSortDefend[defendCountIndex].index].role:GetRoleId()
        defendCountIndex = defendCountIndex + 1
      end
      if resourceSortDefend[defendCountIndex] then
        req.roles[LineUpStation.ALTERNATE_FRONT_ROW] = allRoleOrderList[resourceSortDefend[defendCountIndex].index].role:GetRoleId()
        defendCountIndex = defendCountIndex + 1
      elseif resourceSortHeal[healCountIndex] then
        req.roles[LineUpStation.ALTERNATE_FRONT_ROW] = allRoleOrderList[resourceSortHeal[healCountIndex].index].role:GetRoleId()
        healCountIndex = healCountIndex + 1
      end
      if resourceSortDefend[defendCountIndex] then
        req.roles[LineUpStation.ALTERNATE_MIDDLE_ROW] = allRoleOrderList[resourceSortDefend[defendCountIndex].index].role:GetRoleId()
        defendCountIndex = defendCountIndex + 1
      elseif resourceSortHeal[healCountIndex] then
        req.roles[LineUpStation.ALTERNATE_MIDDLE_ROW] = allRoleOrderList[resourceSortHeal[healCountIndex].index].role:GetRoleId()
        healCountIndex = healCountIndex + 1
      end
      if resourceSortHeal[healCountIndex] then
        req.roles[LineUpStation.ALTERNATE_BACK_ROW] = allRoleOrderList[resourceSortHeal[healCountIndex].index].role:GetRoleId()
        healCountIndex = healCountIndex + 1
      elseif resourceSortDefend[defendCountIndex] then
        req.roles[LineUpStation.ALTERNATE_BACK_ROW] = allRoleOrderList[resourceSortDefend[defendCountIndex].index].role:GetRoleId()
        defendCountIndex = defendCountIndex + 1
      end
    elseif table.keyof(supportVocationTable.vid, VocationType.Damage) or table.keyof(supportVocationTable.vid, VocationType.Assassin) then
      if resourceSortAssassinAndDamage[1] then
        req.roles[LineUpStation.FRONT_ROW] = allRoleOrderList[resourceSortAssassinAndDamage[1].index].role:GetRoleId()
      end
      if resourceSortAssassinAndDamage[2] then
        req.roles[LineUpStation.MIDDLE_ROW] = allRoleOrderList[resourceSortAssassinAndDamage[2].index].role:GetRoleId()
      end
      if resourceSortAssassinAndDamage[3] then
        req.roles[LineUpStation.BACK_ROW] = allRoleOrderList[resourceSortAssassinAndDamage[3].index].role:GetRoleId()
      end
      if resourceSortAssassinAndDamage[4] then
        req.roles[LineUpStation.ALTERNATE_FRONT_ROW] = allRoleOrderList[resourceSortAssassinAndDamage[4].index].role:GetRoleId()
      end
      if resourceSortAssassinAndDamage[5] then
        req.roles[LineUpStation.ALTERNATE_MIDDLE_ROW] = allRoleOrderList[resourceSortAssassinAndDamage[5].index].role:GetRoleId()
      end
      if resourceSortAssassinAndDamage[6] then
        req.roles[LineUpStation.ALTERNATE_BACK_ROW] = allRoleOrderList[resourceSortAssassinAndDamage[6].index].role:GetRoleId()
      end
    elseif table.keyof(supportVocationTable.vid, VocationType.Magic) or table.keyof(supportVocationTable.vid, VocationType.Impair) then
      if resourceSortMagicAndImpair[1] then
        req.roles[LineUpStation.FRONT_ROW] = allRoleOrderList[resourceSortMagicAndImpair[1].index].role:GetRoleId()
      end
      if resourceSortMagicAndImpair[2] then
        req.roles[LineUpStation.MIDDLE_ROW] = allRoleOrderList[resourceSortMagicAndImpair[2].index].role:GetRoleId()
      end
      if resourceSortMagicAndImpair[3] then
        req.roles[LineUpStation.BACK_ROW] = allRoleOrderList[resourceSortMagicAndImpair[3].index].role:GetRoleId()
      end
      if resourceSortMagicAndImpair[4] then
        req.roles[LineUpStation.ALTERNATE_FRONT_ROW] = allRoleOrderList[resourceSortMagicAndImpair[4].index].role:GetRoleId()
      end
      if resourceSortMagicAndImpair[5] then
        req.roles[LineUpStation.ALTERNATE_MIDDLE_ROW] = allRoleOrderList[resourceSortMagicAndImpair[5].index].role:GetRoleId()
      end
      if resourceSortMagicAndImpair[6] then
        req.roles[LineUpStation.ALTERNATE_BACK_ROW] = allRoleOrderList[resourceSortMagicAndImpair[6].index].role:GetRoleId()
      end
    end
  else
    for _, v in ipairs(sortDefend) do
      if not allRoleOrderList[v.index].hasLayOnStation then
        allRoleOrderList[v.index].hasLayOnStation = true
        req.roles[LineUpStation.FRONT_ROW] = allRoleOrderList[v.index].role:GetRoleId()
        break
      end
    end
    for _, v in ipairs(sortHeal) do
      if not allRoleOrderList[v.index].hasLayOnStation then
        allRoleOrderList[v.index].hasLayOnStation = true
        req.roles[LineUpStation.MIDDLE_ROW] = allRoleOrderList[v.index].role:GetRoleId()
        break
      end
    end
    for _, v in ipairs(sortDamage) do
      if not allRoleOrderList[v.index].hasLayOnStation then
        allRoleOrderList[v.index].hasLayOnStation = true
        req.roles[LineUpStation.BACK_ROW] = allRoleOrderList[v.index].role:GetRoleId()
        break
      end
    end
    for _, v in ipairs(sortDefend) do
      if not allRoleOrderList[v.index].hasLayOnStation then
        allRoleOrderList[v.index].hasLayOnStation = true
        req.roles[LineUpStation.ALTERNATE_FRONT_ROW] = allRoleOrderList[v.index].role:GetRoleId()
        break
      end
    end
    for _, v in ipairs(sortHeal) do
      if not allRoleOrderList[v.index].hasLayOnStation then
        allRoleOrderList[v.index].hasLayOnStation = true
        req.roles[LineUpStation.ALTERNATE_MIDDLE_ROW] = allRoleOrderList[v.index].role:GetRoleId()
        break
      end
    end
    for _, v in ipairs(sortDamage) do
      if not allRoleOrderList[v.index].hasLayOnStation then
        allRoleOrderList[v.index].hasLayOnStation = true
        req.roles[LineUpStation.ALTERNATE_BACK_ROW] = allRoleOrderList[v.index].role:GetRoleId()
        break
      end
    end
  end
  req:Send()
end

function TeamEditPreWarDialog:OnElementBtnClicked()
  DialogManager.CreateSingletonDialog("teamedit.teamelementinfodialog"):SetData(self._oneTotalElementValue, self._elementStage, self._extraElemenEffect)
end

function TeamEditPreWarDialog:GetSupportVocationTable()
  local showJobLimit = false
  self._supportVocationTable = NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationTable(self._copyID)
  if self._supportVocationTable ~= nil then
    showJobLimit = true
    self._jobLimitTxt:SetText(NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationDescription(self._supportVocationTable))
  end
  self._jobLimit:SetActive(showJobLimit)
  self:OnRefresh()
end

function TeamEditPreWarDialog:UnreasonableLineupTip(id, func)
  local cureCount, attackCount
  local currentChapter = CDungeonSelectWorld:GetRecorder(NekoData.BehaviorManager.BM_Game:GetMainLineProgress().world).chapternum
  local LineUpStation = BattleClientProtocolManager.GetBeanDef("data.lineupstation")
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha) and currentChapter < 3 and 3 > NekoData.BehaviorManager.BM_Game:GetChapternumByFloorId(id) then
    local roles = NekoData.BehaviorManager.BM_Team:GetTeamRoles(self._teamId)
    cureCount = 0
    attackCount = 0
    for lineupStation, roleid in pairs(roles) do
      if lineupStation == LineUpStation.ALTERNATE_BACK_ROW or lineupStation == LineUpStation.ALTERNATE_FRONT_ROW or lineupStation == LineUpStation.ALTERNATE_MIDDLE_ROW then
        break
      end
      if roleid ~= 0 then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleid)
        local vocationId = role:GetVocationId()
        if vocationId == 2 or vocationId == 3 or vocationId == 6 or vocationId == 7 then
          attackCount = attackCount + 1
        elseif vocationId == 5 then
          cureCount = cureCount + 1
        end
      end
    end
  end
  return false
end

function TeamEditPreWarDialog:IsCurCopyTypeDispatch()
  if self._copyType == "DispatchResource" then
    return true
  end
  if self._copyType == "DispatchChristmas" then
    return true
  end
  if self._copyType == "DispatchLover" then
    return true
  end
  if self._copyType == "DispatchSummer" then
    return true
  end
  if self._copyType == "DispatchStarryMirror" then
    return true
  end
  if self._copyType == "DispatchSummerEchoes" then
    return true
  end
  if self._copyType == "DispatchAnniversary" then
    return true
  end
end

return TeamEditPreWarDialog
