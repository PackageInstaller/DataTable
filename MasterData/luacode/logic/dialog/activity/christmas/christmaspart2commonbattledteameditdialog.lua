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
local UIManager = CS.PixelNeko.UI.UIManager
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local iconItem = Item.Create(DataCommon.DiamodID)
local BM_StarMirage = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID)
local ChristmasPart2CommonBattledTeamEditDialog = class("ChristmasPart2CommonBattledTeamEditDialog", Dialog)
ChristmasPart2CommonBattledTeamEditDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasPart2CommonBattledTeamEditDialog.AssetName = "ActivityChristmasTeam"
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

function ChristmasPart2CommonBattledTeamEditDialog:Ctor(...)
  ChristmasPart2CommonBattledTeamEditDialog.super.Ctor(self, ...)
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
  self._firstEnterDungeon = false
  self._charLargeCell = {}
  self._tempChangeRoleList = nil
  self._oneTimeChangingCurTeamRoles = {}
  self._dialogStr = "teamedit.characterlargecell"
  self._levelNotSatisfiedHasReminder = false
  self._isChristmasPart2CommonBattled = true
end

function ChristmasPart2CommonBattledTeamEditDialog:OnCreate()
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
  self._roleStatusWidgets = {}
  for i = 1, 6 do
    self._roleStatusWidgets[i] = {}
    self._roleStatusWidgets[i].panel = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "/LineBack")
    self._roleStatusWidgets[i].progress = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "/LineBack/LineColor")
    self._roleStatusWidgets[i].current = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "/LineBack/Num2")
    self._roleStatusWidgets[i].totle = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "/LineBack/Num1")
  end
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
  self._tips = self:GetChild("Tips")
  self._tips:SetText(TextManager.GetText(701552) .. TextManager.GetText(701553))
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._btn1:Subscribe_PointerClickEvent(self.OnBtn1Clicked, self)
  self._btn4:Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
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

function ChristmasPart2CommonBattledTeamEditDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
end

function ChristmasPart2CommonBattledTeamEditDialog:SetCopyInfo(copyType, id, additionalData)
  self._copyType = copyType
  self._copyID = id
  self._additionalData = additionalData
  self:JudgeIfNeedAutoTeamFunction()
end

function ChristmasPart2CommonBattledTeamEditDialog:FirstEnterDungeon()
  self._firstEnterDungeon = true
  self._menuBtn:SetActive(false)
end

function ChristmasPart2CommonBattledTeamEditDialog:DestroyModal(dialog)
end

function ChristmasPart2CommonBattledTeamEditDialog:OnRefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
end

function ChristmasPart2CommonBattledTeamEditDialog:OnRefreshCurrency()
end

function ChristmasPart2CommonBattledTeamEditDialog:RefreshFashion()
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
      DialogManager.CreateSingletonDialog("teamedit.promptunlockskilldialog"):SetData(list)
      return true
    end
  end
end

function ChristmasPart2CommonBattledTeamEditDialog:CheckTeamRationalForBeginTask()
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

function ChristmasPart2CommonBattledTeamEditDialog:OnRefreshTeam(notification)
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

function ChristmasPart2CommonBattledTeamEditDialog:OnRefresh(notification)
  self:LoadLocalData()
  self:Refresh(self._teamId)
end

function ChristmasPart2CommonBattledTeamEditDialog:LoadLocalData()
  local teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
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
end

function ChristmasPart2CommonBattledTeamEditDialog:Refresh(teamId)
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
  self:RefreshRoleStatus()
  self:JudgeIfNeedAutoTeamFunction()
end

function ChristmasPart2CommonBattledTeamEditDialog:RefreshRoleStatus()
  self._hasRoleTired = false
  for i, v in ipairs(self._roleStatusWidgets) do
    v.panel:SetActive(false)
  end
  for k, v in pairs(self._teamInfo.roles) do
    if 0 < v then
      local totle = BeanManager.GetTableByName("dungeonselect.cchrispuppetlimit"):GetRecorder(1).puppetAllphy
      self._roleStatusWidgets[k].panel:SetActive(true)
      self._roleStatusWidgets[k].totle:SetText(totle)
      local currentStatus = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetRolesStatusByRoleID(v)
      if currentStatus < 1 then
        self._hasRoleTired = true
      end
      self._roleStatusWidgets[k].current:SetText(currentStatus)
      self._roleStatusWidgets[k].progress:SetFillAmount(currentStatus / tonumber(totle))
    end
  end
end

function ChristmasPart2CommonBattledTeamEditDialog:JudgeIfNeedAutoTeamFunction()
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

function ChristmasPart2CommonBattledTeamEditDialog:CheckIfTeamRational()
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

function ChristmasPart2CommonBattledTeamEditDialog:RefreshTeamElementInfo()
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
    self._elementContentNum:SetText(tostring(math.floor(elementRecord.effect / 1000 * 100)) .. "%")
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

function ChristmasPart2CommonBattledTeamEditDialog:OnEnterDungeon()
  DialogManager.DestroySingletonDialog("mainline.mainline.newmainlinefloordialog")
  DialogManager.DestroySingletonDialog("mainline.mainline.mainlineworlddialog")
  DialogManager.DestroySingletonDialog("dungeon.dungeonnextfloordialog")
  DialogManager.DestroySingletonDialog("dungeon.branchlinenextfloordialog")
  DialogManager.DestroySingletonDialog("base.basemainui")
  DialogManager.DestroySingletonDialog("base.basemainmenudialog")
  self:Destroy()
end

function ChristmasPart2CommonBattledTeamEditDialog:OnBtn1Clicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(3, nil, function()
    local cbreakLineup = LuaNetManager.CreateProtocol("protocol.login.cbreaklineup")
    if cbreakLineup then
      cbreakLineup.lineupId = self._teamId
      cbreakLineup:Send()
    end
  end, {}, nil, {})
end

function ChristmasPart2CommonBattledTeamEditDialog:OnBtn4Clicked()
  if self._hasRoleTired then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100415)
    return
  end
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(124, nil, function()
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
    local haveOneAlternativeRoleButNoInBattleRole = false
    local haveSomeEmptyVacancy = false
    if frontRoleId == 0 and frontAlternativeRoleId ~= 0 or middleRoleId == 0 and middleAlternativeRoleId ~= 0 or backRoleId == 0 and backAlternativeRoleId ~= 0 then
      haveOneAlternativeRoleButNoInBattleRole = true
    elseif frontRoleId == 0 or middleRoleId == 0 or backRoleId == 0 or frontAlternativeRoleId == 0 or middleAlternativeRoleId == 0 or backAlternativeRoleId == 0 then
      haveSomeEmptyVacancy = true
      if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AlterNativeRole) and frontRoleId ~= 0 and middleRoleId ~= 0 and backRoleId ~= 0 then
        haveSomeEmptyVacancy = false
      end
    end
    self:CheckTeamRationalForBeginTask()
  end, {}, nil, {})
end

function ChristmasPart2CommonBattledTeamEditDialog:BeginTaskBtnClicked()
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
  else
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
    csend.constructionID = self._additionalData
    csend.eventID = self._copyID
    csend.lineupID = self._teamId
    csend:Send()
  end
  local randomKey = NekoData.BehaviorManager.BM_Team:GetRandomRoleKeyInTeam(self._teamId)
  local roleID = randomKey
  NekoData.BehaviorManager.BM_Voice:Play(roleID, NekoData.BehaviorManager.BM_Voice.VoiceType.Adventure, nil)
end

function ChristmasPart2CommonBattledTeamEditDialog:OnTeamClicked(index)
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

function ChristmasPart2CommonBattledTeamEditDialog:OnTeamNameEditClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditchangenamedialog")
  dialog:SetTeamName(self._name, self._teamId)
end

function ChristmasPart2CommonBattledTeamEditDialog:ReturnRoleList()
  local roleList = {}
  for _, v in ipairs(self._curTeamRoles) do
    if v.roleKey ~= 0 then
      table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey))
    end
  end
  return roleList
end

function ChristmasPart2CommonBattledTeamEditDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChristmasPart2CommonBattledTeamEditDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChristmasPart2CommonBattledTeamEditDialog:OnCharPosLockClicked(posIndex)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100244)
end

function ChristmasPart2CommonBattledTeamEditDialog:OnCharPosClicked(posIndex)
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
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmaspart2commonbattlechangeteamdialog")
    dialog:SetFilterCondition(NekoData.BehaviorManager.BM_Team:GetTeamFilterCondition())
    dialog:Init(self._teamInfo, self._curTeamRoles[index])
  end
end

function ChristmasPart2CommonBattledTeamEditDialog:OnCharCellBeginDrag(screenPosition, data)
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

function ChristmasPart2CommonBattledTeamEditDialog:OnCharCellDrag(screenPosition, data)
  if self._charLargeCell[data.station] then
    self._charLargeCell[data.station]:GetRootWindow():SetAnchoredPosition(UIManager.ScreenPointToLocalPointInRectangle(self._pos[data.station]._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("ChristmasPart2CommonBattledTeamEditDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

function ChristmasPart2CommonBattledTeamEditDialog:OnCharCellEndDrag(screenPosition, data)
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

function ChristmasPart2CommonBattledTeamEditDialog:OnSwitchPositionBtnClicked()
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

function ChristmasPart2CommonBattledTeamEditDialog:OnAutoTeamBtnClicked()
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
  req:Send()
end

function ChristmasPart2CommonBattledTeamEditDialog:OnElementBtnClicked()
  DialogManager.CreateSingletonDialog("teamedit.teamelementinfodialog"):SetData(self._oneTotalElementValue, self._elementStage)
end

function ChristmasPart2CommonBattledTeamEditDialog:UnreasonableLineupTip(id, func)
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

return ChristmasPart2CommonBattledTeamEditDialog
