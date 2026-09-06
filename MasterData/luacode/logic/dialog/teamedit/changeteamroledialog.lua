local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local Skill = require("logic.manager.experimental.types.skill")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CScreeningConditions = BeanManager.GetTableByName("role.cscreeningconditions")
local ChangeTeamRoleDialog = class("ChangeTeamRoleDialog", Dialog)
ChangeTeamRoleDialog.AssetBundleName = "ui/layouts.teamedit"
ChangeTeamRoleDialog.AssetName = "TeamEditChangeNew"
local BottomToTop = 3

local function ShowCharUpgrade(self, level)
  self._charUpgrade.panel:SetActive(level ~= 0)
  for i = 1, 5 do
    self._charUpgrade.levelImage[i]:SetActive(level == i)
  end
end

function ChangeTeamRoleDialog:Ctor(...)
  ChangeTeamRoleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._curTeam = {}
  self._curRoleKey = nil
  self._roleList = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = 501827
  self._isAscendingOrder = false
  self._listByConditions = {}
  self._isLock = false
  self._curStationInfo = {}
  self._supportVocationTable = nil
  self._teamType = 0
end

function ChangeTeamRoleDialog:OnCreate()
  self._cellFrame = self:GetChild("Back/CellFrame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._jobLimit = self:GetChild("JobLimit")
  self._jobLimitTxt = self:GetChild("JobLimit/Txt2")
  self._empty = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Empty")
  self._cell = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell")
  self._photo = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Photo")
  self._grey = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Grey")
  self._rankFrame = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Frame")
  self._rankBack = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/RankBack")
  self._downRankBack = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/DownRankBack")
  self._rank = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Rank")
  self._job = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Job")
  self._level = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Level/Num")
  self._maxLevel = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Level/MaxNum")
  self._breakLevelBackBlack = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/BreakLevelBack")
  self._breakLevel = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/BreakLevelNum")
  self._txt = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Txt")
  self._cur = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Current")
  self._select = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Select")
  self._elementImg = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/Element")
  self._charUpgrade = {
    panel = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/CharUpgrade"),
    levelImage = {}
  }
  for i = 1, 5 do
    self._charUpgrade.levelImage[i] = self:GetChild("Back/DownFrame/TeamEditChangeNewCell/Cell/CharUpgrade/Img" .. i)
  end
  self._detailBtn = self:GetChild("Back/DownFrame/Frame/DetailBtn")
  self._detailBtn:Subscribe_PointerClickEvent(self.OnCellLongPress, self)
  self._panel = self:GetChild("Back/DownFrame/Frame")
  self._roleName = self:GetChild("Back/DownFrame/Frame/Name")
  self._roleTitle = self:GetChild("Back/DownFrame/Frame/Title")
  self._power = self:GetChild("Back/DownFrame/Frame/Fight/Num")
  self._healthNum = self:GetChild("Back/DownFrame/Frame/Health/Num")
  self._healthName = self:GetChild("Back/DownFrame/Frame/Health/Name")
  self._healthIcon = self:GetChild("Back/DownFrame/Frame/Health/Image")
  self._phyAtkNum = self:GetChild("Back/DownFrame/Frame/PhyAtk/Num")
  self._atkName = self:GetChild("Back/DownFrame/Frame/PhyAtk/Name")
  self._phyAtkIcon = self:GetChild("Back/DownFrame/Frame/PhyAtk/Image")
  self._phyDefNum = self:GetChild("Back/DownFrame/Frame/PhyDef/Num")
  self._phyDefName = self:GetChild("Back/DownFrame/Frame/PhyDef/Name")
  self._phyDefIcon = self:GetChild("Back/DownFrame/Frame/PhyDef/Image")
  self._magDefNum = self:GetChild("Back/DownFrame/Frame/MagDef/Num")
  self._magDefName = self:GetChild("Back/DownFrame/Frame/MagDef/Name")
  self._magDefIcon = self:GetChild("Back/DownFrame/Frame/MagDef/Image")
  self._skill1Panel = self:GetChild("Back/DownFrame/Frame/SkillBack1")
  self._skill1 = DialogManager.CreateDialog("skill.skillcell", self._skill1Panel._uiObject)
  self._skill2Panel = self:GetChild("Back/DownFrame/Frame/SkillBack2")
  self._skill2 = DialogManager.CreateDialog("skill.skillcell", self._skill2Panel._uiObject)
  self._filterBtn = self:GetChild("FliterBtn")
  self._levelBtn = self:GetChild("LevelBtn")
  self._levelBtnTxt = self:GetChild("LevelBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self._lockBtn = self:GetChild("LockBtn")
  self._lockBtn:SetSelected(false)
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._levelBtn:Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._lockBtn:Subscribe_PointerClickEvent(self.OnLockBtnClick, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:SetActive(GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity")
  self._upFrame = GridFrame.Create(self._cellFrame, self, true, 8)
  self._upFrame:SetMargin(15, 0)
  self._txt:SetActive(false)
  self._cur:SetActive(false)
  self._select:SetActive(false)
  self._skill1._rootWindow:Subscribe_PointerClickEvent(self.OnSkill1Clicked, self)
  self._skill2._rootWindow:Subscribe_PointerClickEvent(self.OnSkill2Clicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillUnlock, Common.n_RefreshWitchSkills, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillUnlock, Common.n_ImproveSkill, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
  local uiSortInfo = NekoData.BehaviorManager.BM_Game:GetUISortType(CUpdateUISortType.QUICKSET_LINEUP)
  if uiSortInfo then
    self._sortCriteriaNameId = uiSortInfo.nameTxtId or self._sortCriteriaNameId
    self._isAscendingOrder = uiSortInfo.isAscending or self._isAscendingOrder
    self._sortUpBtnImg:SetActive(self._isAscendingOrder)
    self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
    self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
    self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  end
end

function ChangeTeamRoleDialog:OnDestroy()
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
  self._upFrame:Destroy()
  DialogManager.DestroySingletonDialog("teamedit.checkroleskilltipsdialog")
  LuaNotificationCenter.RemoveObserver(self)
  local cond = {
    filter = clone(self._screeningConditions),
    sort = self._sortCriteriaNameId
  }
  NekoData.BehaviorManager.BM_Team:SaveTeamFilterCondition(cond)
  self:SendCUpdateUISortType()
end

function ChangeTeamRoleDialog:Refresh()
  self:ScreeningAndSorting()
end

function ChangeTeamRoleDialog:OnRefresh(notification)
  self:Refresh()
  self:RefreshDownPanel()
end

function ChangeTeamRoleDialog:RefreshFashion()
  self:OnRefresh()
end

local function RefreshSkillPanel(self)
  local skill1 = self._role:GetShowSkillDataByIndex(1)
  if skill1 then
    local skill = Skill.Create(skill1.skillId, skill1.skillItemId or true)
    self._skill1Panel:SetActive(true)
    self._skill1:Init(skill, skill1.unlock)
  else
    self._skill1Panel:SetActive(false)
  end
  local skill2 = self._role:GetShowSkillDataByIndex(2)
  if skill2 then
    local skill = Skill.Create(skill2.skillId, skill2.skillItemId or true)
    self._skill2Panel:SetActive(true)
    self._skill2:Init(skill, skill2.unlock)
  else
    self._skill2Panel:SetActive(false)
  end
end

function ChangeTeamRoleDialog:OnSkillUnlock()
  RefreshSkillPanel(self)
end

function ChangeTeamRoleDialog:OnUniqueEquipLevelUp(notification)
  self._upFrame:FireEvent("UniqueEquipLevelUp", notification.userInfo.roleId)
  if self._curStationInfo.roleKey == notification.userInfo.roleId then
    self:RefreshDownPanel()
  end
end

function ChangeTeamRoleDialog:RefreshDownPanel()
  if self._curStationInfo.roleKey == 0 then
    self._empty:SetActive(true)
    self._cell:SetActive(false)
    self._panel:SetActive(false)
    if self._curRoleKey == 0 then
      self._confirmBtn:SetInteractable(false)
    else
      self._confirmBtn:SetInteractable(true)
    end
  else
    self._empty:SetActive(false)
    self._cell:SetActive(true)
    self._panel:SetActive(true)
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._curStationInfo.roleKey)
    local image = self._role:GetSmallRarityBackRecord()
    image = self._role:GetShapeLittleHeadImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._grey:SetActive(false)
    image = self._role:GetSmallRarityFrameRecord()
    self._rankFrame:SetSprite(image.assetBundle, image.assetName)
    if self._role:GetIsLeader() then
      self._rankBack:SetActive(false)
      self._rank:SetActive(false)
    else
      self._rankBack:SetActive(true)
      self._rank:SetActive(true)
      image = self._role:GetRarityImageRecord()
      self._rank:SetSprite(image.assetBundle, image.assetName)
    end
    image = self._role:GetRarityBottomBackRecord()
    self._downRankBack:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    self._level:SetText(self._role:GetShowLv())
    self._maxLevel:SetText(self._role:GetShowMaxBreakLv())
    image = self._role:GetElementImageRecord()
    self._elementImg:SetSprite(image.assetBundle, image.assetName)
    local breakLv = self._role:GetBreakLv()
    self._breakLevelBackBlack:SetActive(breakLv == 0)
    self._breakLevelBack:SetActive(0 < breakLv)
    self._breakLevel:SetActive(0 < breakLv)
    if 0 < breakLv then
      local imageRecord = self._role:GetCurBreakFrame1ImageRecord()
      self._breakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._breakLevel:SetText(breakLv)
    end
    self._roleName:SetText(self._role:GetRoleName())
    self._roleTitle:SetText(self._role:GetTitleName())
    self._power:SetText(self._role:GetRolePower())
    local properties = self._role:GetProperties()
    local hp = properties[AttrTypeEnum.MAX_HP]
    local phyDef = properties[AttrTypeEnum.DEFEND]
    local magDef = properties[AttrTypeEnum.MAGIC_DEFEND]
    local atk = 0
    local attrNameRecord = CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)
    local imageRecord = CImagePathTable:GetRecorder(attrNameRecord.classIcon) or DataCommon.DefaultImageAsset
    self._healthName:SetText(TextManager.GetText(attrNameRecord.classnameTextID))
    self._healthIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    attrNameRecord = CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)
    imageRecord = CImagePathTable:GetRecorder(attrNameRecord.classIcon) or DataCommon.DefaultImageAsset
    self._phyDefName:SetText(TextManager.GetText(attrNameRecord.classnameTextID))
    self._phyDefIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    attrNameRecord = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)
    imageRecord = CImagePathTable:GetRecorder(attrNameRecord.classIcon) or DataCommon.DefaultImageAsset
    self._magDefName:SetText(TextManager.GetText(attrNameRecord.classnameTextID))
    self._magDefIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if self._role:GetDamageType() == 1 then
      attrNameRecord = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
    else
      attrNameRecord = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
    end
    imageRecord = CImagePathTable:GetRecorder(attrNameRecord.classIcon) or DataCommon.DefaultImageAsset
    self._atkName:SetText(TextManager.GetText(attrNameRecord.classnameTextID))
    self._phyAtkIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    atk = properties[AttrTypeEnum.ATTACK]
    self._healthNum:SetText(hp)
    self._phyDefNum:SetText(phyDef)
    self._magDefNum:SetText(magDef)
    self._phyAtkNum:SetText(atk)
    ShowCharUpgrade(self, self._role:GetRuneLevel())
    RefreshSkillPanel(self)
    if self._curRoleKey == self._role:GetRoleId() then
      self._confirmBtn:SetInteractable(false)
    else
      self._confirmBtn:SetInteractable(true)
    end
  end
end

function ChangeTeamRoleDialog:SetFilterCondition(condition)
  if not condition then
    return
  end
  self._screeningConditions = condition.filter
  self._sortCriteriaNameId = condition.sort
end

function ChangeTeamRoleDialog:Init(curTeam, curStationInfo, isTowerBattle)
  self._curTeam = curTeam
  self._isTowerBattle = isTowerBattle
  for k, v in pairs(self._curStationInfo) do
    self._curStationInfo[k] = nil
  end
  self._curRoleKey = curStationInfo.roleKey
  self._curStationInfo.station = curStationInfo.station
  self._curStationInfo.roleKey = curStationInfo.roleKey
  self:Refresh()
  self:RefreshDownPanel()
end

function ChangeTeamRoleDialog:OnSkill1Clicked()
  local skillData = self._role:GetShowSkillDataByIndex(1)
  if skillData.unlock then
    DialogManager.CreateSingletonDialog("skill.skilltipsdialog"):SetSkillAndRoleId(skillData.skillId, skillData.skillItemId, self._role:GetRoleId())
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
  end
end

function ChangeTeamRoleDialog:OnSkill2Clicked()
  local skillData = self._role:GetShowSkillDataByIndex(2)
  if skillData.unlock then
    DialogManager.CreateSingletonDialog("skill.skilltipsdialog"):SetSkillAndRoleId(skillData.skillId, skillData.skillItemId, self._role:GetRoleId())
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
  end
end

function ChangeTeamRoleDialog:OnCellLongPress()
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if not dialog and self._role then
    dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
    dialog:Refresh(self._role)
  end
end

function ChangeTeamRoleDialog:OnConfirmBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(45, 3) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(45)
  end
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(10, 3) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(10)
  end
  if self._curStationInfo.roleKey ~= self._curRoleKey and self._curStationInfo.roleKey ~= 0 then
    if self._curTeam.id then
      if self._role:IsInTeams(self._curTeam.id) and not self._role:IsInAlternativeTeams(self._curTeam.id) then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(71, nil, function()
          self:ConfirmFunction()
        end)
      elseif self._role:IsInAlternativeTeams(self._curTeam.id) then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(70, nil, function()
          self:ConfirmFunction()
        end)
      else
        self:ConfirmFunction()
      end
    else
      self:ConfirmFunction()
    end
  elseif self._curStationInfo.roleKey == 0 then
    self:ConfirmFunction()
  end
end

function ChangeTeamRoleDialog:ConfirmFunction()
  if self._curTeam.id then
    local cchangeRoles = LuaNetManager.CreateProtocol("protocol.login.cchangeroles")
    if cchangeRoles then
      cchangeRoles.lineupId = self._curTeam.id
      cchangeRoles.station = self._curStationInfo.station
      cchangeRoles.roleId = self._curStationInfo.roleKey
      cchangeRoles:Send()
    end
  else
    local data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
    local teamMap = data.defendTeam
    if self._teamType == 1 then
      teamMap = data.attackTeam
    end
    for k, v in pairs(teamMap) do
      if v == self._curStationInfo.roleKey then
        teamMap[k] = 0
      end
    end
    teamMap[self._curStationInfo.station] = self._curStationInfo.roleKey
    local csend = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictchangeteam")
    if csend then
      csend.teamType = self._teamType
      csend.team = teamMap
      csend:Send()
    end
    self:Destroy()
  end
end

function ChangeTeamRoleDialog:SetSelectedID(str, roleKey)
  if str == "RoleLeave" then
    self._curStationInfo.roleKey = 0
    self._upFrame:FireEvent("RoleLeave", roleKey)
    self:RefreshDownPanel()
  end
  if str == "RoleAdd" then
    self._curStationInfo.roleKey = roleKey
    self._upFrame:FireEvent("RoleAdd", roleKey)
    self:RefreshDownPanel()
  end
end

function ChangeTeamRoleDialog:GetNumByRoleId(id)
  local count = 0
  for i, v in ipairs(self._listByConditions) do
    if v:GetId() == id then
      count = count + 1
    end
  end
  return count
end

function ChangeTeamRoleDialog:ScreeningAndSorting()
  self._levelBtnTxt:SetText(TextManager.GetText(self._sortCriteriaNameId))
  local roleList = NekoData.BehaviorManager.BM_AllRoles:GetAllRolesMap()
  local inTeamRole = {}
  for _, v in pairs(self._curTeam.roles) do
    if roleList[v] then
      inTeamRole[v] = roleList[v]
      roleList[v] = nil
    end
  end
  local curStationIndex = self._curStationInfo.roleKey
  local curSelectRole
  if curStationIndex ~= 0 then
    curSelectRole = roleList[curStationIndex]
    if curSelectRole then
      roleList[curStationIndex] = nil
    end
  end
  for k, v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for _, value in pairs(v) do
      select = true
      warn(">> check 1: ", value.nameid)
      for key, role in pairs(roleList) do
        if value.nameid == 501833 and role:GetRarityId() == 1 or value.nameid == 501832 and role:GetRarityId() == 2 or value.nameid == 501831 and role:GetRarityId() == 3 or value.nameid == 501834 and role:GetRarityId() == 4 or value.nameid == 502614 and role:GetRarityId() == 5 then
          indexMap[key] = key
        end
      end
    end
    for _, value in pairs(v) do
      for key, role in pairs(roleList) do
        if value.nameid == role:GetVocationNameId() then
          indexMap[key] = key
        end
      end
    end
    for _, value in pairs(v) do
      for key, role in pairs(roleList) do
        if value.nameid == 502771 and role:GetElement() == 1 or value.nameid == 502772 and role:GetElement() == 2 or value.nameid == 502773 and role:GetElement() == 3 or value.nameid == 502774 and role:GetElement() == 4 then
          indexMap[key] = key
        end
      end
    end
    if select then
      for rk, _ in pairs(roleList) do
        if not indexMap[rk] then
          roleList[rk] = nil
        end
      end
    end
  end
  self._listByConditions = {}
  for _, v in pairs(roleList) do
    table.insert(self._listByConditions, v)
  end
  if curSelectRole and not inTeamRole[curSelectRole:GetRoleId()] then
    table.insert(self._listByConditions, curSelectRole)
  end
  local vocationAvaliable = {}
  local vocationDisavaliable = {}
  local starMirageBoost = {}
  for key, value in pairs(self._listByConditions) do
    if value:IsBoost() then
      table.insert(starMirageBoost, value)
    elseif NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(value, self._supportVocationTable) then
      table.insert(vocationAvaliable, value)
    else
      table.insert(vocationDisavaliable, value)
    end
    self._listByConditions[key] = nil
  end
  table.sort(vocationAvaliable, function(a, b)
    local _a, _b
    if self._sortCriteriaNameId == 501827 then
      _a = a:GetLevel()
      _b = b:GetLevel()
    elseif self._sortCriteriaNameId == 501828 then
      _a = a:GetRarityId()
      _b = b:GetRarityId()
    elseif self._sortCriteriaNameId == 501829 then
      _a = a:GetBirthDay()
      _b = b:GetBirthDay()
    elseif self._sortCriteriaNameId == 501830 then
      _a = a:GetCurrentHp() / a:GetMaxHp()
      _b = b:GetCurrentHp() / b:GetMaxHp()
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId
      if self._sortCriteriaNameId == 501828 then
        aId, bId = a:GetId(), b:GetId()
      end
      if self._sortCriteriaNameId == 501827 then
        local ararity = a:GetRarityId()
        local brarity = b:GetRarityId()
        if ararity == brarity then
          aId, bId = a:GetId(), b:GetId()
          if self._isAscendingOrder then
            return aId < bId
          else
            return aId > bId
          end
        elseif self._isAscendingOrder then
          return ararity < brarity
        else
          return ararity > brarity
        end
      end
      if self._isAscendingOrder then
        return aId < bId
      else
        return aId > bId
      end
    elseif self._isAscendingOrder then
      return _a < _b
    else
      return _a > _b
    end
  end)
  table.sort(vocationDisavaliable, function(a, b)
    local _a, _b
    if self._sortCriteriaNameId == 501827 then
      _a = a:GetLevel()
      _b = b:GetLevel()
    elseif self._sortCriteriaNameId == 501828 then
      _a = a:GetRarityId()
      _b = b:GetRarityId()
    elseif self._sortCriteriaNameId == 501829 then
      _a = a:GetBirthDay()
      _b = b:GetBirthDay()
    elseif self._sortCriteriaNameId == 501830 then
      _a = a:GetCurrentHp() / a:GetMaxHp()
      _b = b:GetCurrentHp() / b:GetMaxHp()
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId
      if self._sortCriteriaNameId == 501828 then
        aId, bId = a:GetId(), b:GetId()
      end
      if self._sortCriteriaNameId == 501827 then
        local ararity = a:GetRarityId()
        local brarity = b:GetRarityId()
        if ararity == brarity then
          aId, bId = a:GetId(), b:GetId()
          if self._isAscendingOrder then
            return aId < bId
          else
            return aId > bId
          end
        elseif self._isAscendingOrder then
          return ararity < brarity
        else
          return ararity > brarity
        end
      end
      if self._isAscendingOrder then
        return aId < bId
      else
        return aId > bId
      end
    elseif self._isAscendingOrder then
      return _a < _b
    else
      return _a > _b
    end
  end)
  table.sort(starMirageBoost, function(a, b)
    local _a, _b
    if self._sortCriteriaNameId == 501827 then
      _a = a:GetLevel()
      _b = b:GetLevel()
    elseif self._sortCriteriaNameId == 501828 then
      _a = a:GetRarityId()
      _b = b:GetRarityId()
    elseif self._sortCriteriaNameId == 501829 then
      _a = a:GetBirthDay()
      _b = b:GetBirthDay()
    elseif self._sortCriteriaNameId == 501830 then
      _a = a:GetCurrentHp() / a:GetMaxHp()
      _b = b:GetCurrentHp() / b:GetMaxHp()
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId
      if self._sortCriteriaNameId == 501828 then
        aId, bId = a:GetId(), b:GetId()
      end
      if self._sortCriteriaNameId == 501827 then
        local ararity = a:GetRarityId()
        local brarity = b:GetRarityId()
        if ararity == brarity then
          aId, bId = a:GetId(), b:GetId()
          if self._isAscendingOrder then
            return aId < bId
          else
            return aId > bId
          end
        elseif self._isAscendingOrder then
          return ararity < brarity
        else
          return ararity > brarity
        end
      end
      if self._isAscendingOrder then
        return aId < bId
      else
        return aId > bId
      end
    elseif self._isAscendingOrder then
      return _a < _b
    else
      return _a > _b
    end
  end)
  for key, value in ipairs(starMirageBoost) do
    table.insert(self._listByConditions, value)
  end
  for key, value in ipairs(vocationAvaliable) do
    table.insert(self._listByConditions, value)
  end
  vocationAvaliable = nil
  for key, value in ipairs(vocationDisavaliable) do
    table.insert(self._listByConditions, value)
  end
  vocationDisavaliable = nil
  local alternativeStationInsertIndex = 1
  for i = 1, #self._curTeam.roles do
    local key = self._curTeam.roles[i]
    if key ~= 0 then
      if i == LineUpStation.FRONT_ROW or i == LineUpStation.MIDDLE_ROW or i == LineUpStation.BACK_ROW then
        alternativeStationInsertIndex = alternativeStationInsertIndex + 1
        table.insert(self._listByConditions, 1, inTeamRole[key])
      else
        table.insert(self._listByConditions, alternativeStationInsertIndex, inTeamRole[key])
      end
    end
  end
  self._upFrame:ReloadAllCell()
end

function ChangeTeamRoleDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "Role", self._screeningConditions)
end

function ChangeTeamRoleDialog:OnLevelBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 2, "Role", self._sortCriteriaNameId, self._isTowerBattle)
end

function ChangeTeamRoleDialog:OnSortBtnClick()
  self._isAscendingOrder = not self._isAscendingOrder
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.QUICKSET_LINEUP, self._sortCriteriaNameId, self._isAscendingOrder)
end

function ChangeTeamRoleDialog:OnLockBtnClick()
  if self._isLock then
    self._lockBtn:SetSelected(false)
  else
    self._lockBtn:SetSelected(true)
  end
  self._isLock = not self._isLock
end

function ChangeTeamRoleDialog:SetSortCriteriaNameId(nameId)
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.QUICKSET_LINEUP, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

function ChangeTeamRoleDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function ChangeTeamRoleDialog:NumberOfCell(frame)
  return #self._listByConditions
end

function ChangeTeamRoleDialog:CellAtIndex(frame)
  if self._isTowerBattle then
    return "towerv2.towerv2teamchangecharactercell"
  else
    return "teamedit.changeteamrolecell"
  end
end

function ChangeTeamRoleDialog:DataAtIndex(frame, index)
  return self._listByConditions[index]
end

function ChangeTeamRoleDialog:OnCurPosChange(frame, proportion)
  local width, height = self._cellFrame:GetRectSize()
  local total = self._upFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

function ChangeTeamRoleDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChangeTeamRoleDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChangeTeamRoleDialog:ReturnRoleList()
  local roleList = {}
  for _, v in ipairs(self._listByConditions) do
    table.insert(roleList, v)
  end
  return roleList
end

function ChangeTeamRoleDialog:SetSupportVocationTable(supportVocationTable)
  local showJobLimit = false
  self._supportVocationTable = supportVocationTable
  if self._supportVocationTable ~= nil then
    showJobLimit = true
    self._jobLimitTxt:SetText(NekoData.BehaviorManager.BM_Vocation:GetOneSupportVocationDescription(self._supportVocationTable))
  end
  self._jobLimit:SetActive(showJobLimit)
  self:OnRefresh()
end

function ChangeTeamRoleDialog:SendCUpdateUISortType()
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = LuaNetManager.CreateProtocol("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.QUICKSET_LINEUP
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

return ChangeTeamRoleDialog
