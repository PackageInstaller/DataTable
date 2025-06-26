-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/changesupportroledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIBackManager = require("framework.ui.uibackmanager")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleConfig = (BeanManager.GetTableByName)("role.roleconfig")
local Skill = require("logic.manager.experimental.types.skill")
local ChangeSupportRoleDialog = class("ChangeSupportRoleDialog", Dialog)
ChangeSupportRoleDialog.AssetBundleName = "ui/layouts.friends"
ChangeSupportRoleDialog.AssetName = "ChangeAssist"
local SORT_TYPE = {LEVEL = 501827, RARITY = 501828, GET_TIME = 501829, HP = 501830}
local RARITY = {R = 1, SR = 2, SSR = 3, UR = 4, EX = 5}
local ELEMENT_TYPE = {HYDRAGYRUM = 1, SALT = 2, FIRE = 3, ETHER = 4}
local FILTER = {[RARITY.SSR] = 501831, [RARITY.SR] = 501832, [RARITY.R] = 501833, [RARITY.UR] = 501834, [RARITY.EX] = 502614}
local FILTER_ELEMENT = {[ELEMENT_TYPE.HYDRAGYRUM] = 502771, [ELEMENT_TYPE.SALT] = 502772, [ELEMENT_TYPE.FIRE] = 502773, [ELEMENT_TYPE.ETHER] = 502774}
ChangeSupportRoleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChangeSupportRoleDialog, SORT_TYPE
  ((ChangeSupportRoleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._selectedRole = nil
  self._roleList = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = SORT_TYPE.LEVEL
  self._isAscendingOrder = false
  self._listByConditions = {}
end

ChangeSupportRoleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, TableFrame, _ENV, UIBackManager, CUpdateUISortType
  self._filterBtn = self:GetChild("FliterBtn")
  self._levelBtn = self:GetChild("LevelBtn")
  self._levelBtnTxt = self:GetChild("LevelBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  ;
  (self._sortUpBtnImg):SetActive(false)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  ;
  (self._sortDownBtnImg):SetActive(true)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  ;
  (self._sortUpBtnTxt):SetActive(false)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  ;
  (self._sortDownBtnTxt):SetActive(true)
  self._upPanel = self:GetChild("Back/CellFrame")
  self._downPanel = self:GetChild("Back/CellFrame2")
  self._name = self:GetChild("Back/NameBack/Name")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._skillPanel = self:GetChild("Back/Skill1")
  self._skillIcon = self:GetChild("Back/Skill1/SkillBack/Skill")
  self._skillLv = self:GetChild("Back/Skill1/SkillBack/Num")
  self._skillName = self:GetChild("Back/Skill1/TitleBack/Num")
  self._skillDetail = self:GetChild("Back/Skill1/Detail")
  self._showPropBtn = self:GetChild("Back/Btn")
  self._propDetailPanel = self:GetChild("PropDetail")
  self._heartNum = self:GetChild("PropDetail/Frame/Heart/Num")
  self._atkNum = self:GetChild("PropDetail/Frame/Atk/Num")
  self._phyDeftNum = self:GetChild("PropDetail/Frame/PhyDef/Num")
  self._magDefNum = self:GetChild("PropDetail/Frame/MagDef/Num")
  self._criticNum = self:GetChild("PropDetail/Frame/Critic/Num")
  self._criticLevelNum = self:GetChild("PropDetail/Frame/CriticLevel/Num")
  self._upFrame = (GridFrame.Create)(self._upPanel, self, true, 8)
  self._downFrame = (TableFrame.Create)(self._downPanel, self, false, false)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  ;
  (self._levelBtn):Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  ;
  (self._showPropBtn):Subscribe_PointerClickEvent(self.ShowProp, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  local uiSortInfo = ((NekoData.BehaviorManager).BM_Game):GetUISortType(CUpdateUISortType.SUPPORT_ROLE)
  if uiSortInfo then
    if not uiSortInfo.nameTxtId then
      self._sortCriteriaNameId = self._sortCriteriaNameId
      if not uiSortInfo.isAscending then
        self._isAscendingOrder = self._isAscendingOrder
        ;
        (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
        ;
        (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
        ;
        (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
        ;
        (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
        self._selectedRole = ((NekoData.BehaviorManager).BM_Friends):GetSupportRole()
        self:Refresh()
        ;
        (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RoleInfoChange, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
      end
    end
  end
end

ChangeSupportRoleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, UIBackManager
  (self._upFrame):Destroy()
  ;
  (self._downFrame):Destroy()
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
  self:SendCUpdateUISortType()
end

ChangeSupportRoleDialog.RefreshDownPanel = function(self)
  -- function num : 0_3
  if self._selectedRole then
    (self._name):SetActive(true)
    ;
    (self._name):SetText((self._selectedRole):GetRoleName())
    ;
    (self._skillPanel):SetActive(true)
    ;
    (self._showPropBtn):SetActive(true)
    self:ShowInfo()
  else
    ;
    (self._name):SetActive(false)
    ;
    (self._skillPanel):SetActive(false)
    ;
    (self._showPropBtn):SetActive(false)
  end
  ;
  (self._propDetailPanel):SetActive(false)
  ;
  (self._downFrame):ReloadAllCell()
end

ChangeSupportRoleDialog.ShowInfo = function(self)
  -- function num : 0_4 , upvalues : CRoleConfig, _ENV, Skill
  local skillItemId = (CRoleConfig:GetRecorder((self._selectedRole):GetId())).assistSkillid
  local skillList = ((self._selectedRole):GetActiveSkillList())
  -- DECOMPILER ERROR at PC10: Overwrote pending register: R3 in 'AssignReg'

  local skillId = .end
  for k,v in pairs(skillList) do
    if skillItemId == v.skillItemId then
      skillId = v.skillId
    end
  end
  local skill = (Skill.Create)(skillId, skillItemId)
  local imageRecord = skill:GetSupportSkillIcon()
  ;
  (self._skillIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._skillName):SetText(skill:GetSupportSkillName())
  ;
  (self._skillLv):SetText(skill:GetSupportSkillLevel())
  ;
  (self._skillDetail):SetText(skill:GetSupportSkillDescribeTxt())
end

ChangeSupportRoleDialog.ShowProp = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("character.newpropertytipsdialog")
  dialog:Init(self._selectedRole, self)
end

ChangeSupportRoleDialog.Refresh = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self._roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  if self._selectedRole then
    self._selectedRole = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._selectedRole):GetRoleId())
  end
  self:ScreeningAndSorting()
  self:RefreshDownPanel()
end

ChangeSupportRoleDialog.OnUniqueEquipLevelUp = function(self, notification)
  -- function num : 0_7
  (self._upFrame):FireEvent("UniqueEquipLevelUp", (notification.userInfo).roleId)
  ;
  (self._downFrame):FireEvent("UniqueEquipLevelUp", (notification.userInfo).roleId)
end

ChangeSupportRoleDialog.SetSelectedRole = function(self, key)
  -- function num : 0_8 , upvalues : _ENV
  if self._selectedRole and key == (self._selectedRole):GetRoleId() then
    self._selectedRole = nil
    ;
    (self._upFrame):FireEvent("SetRoleSelectedState", nil)
  else
    self._selectedRole = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    ;
    (self._upFrame):FireEvent("SetRoleSelectedState", key)
  end
  self:RefreshDownPanel()
end

ChangeSupportRoleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if frame == self._upFrame then
    return #self._listByConditions
  else
    if self._selectedRole then
      return 1
    else
      return 0
    end
  end
end

ChangeSupportRoleDialog.CellAtIndex = function(self, frame)
  -- function num : 0_10
  return "assistbattle.changesupportrolecell"
end

ChangeSupportRoleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._upFrame then
    return (self._listByConditions)[index]
  else
    local data = {}
    data.role = self._selectedRole
    data.tag = true
    return data
  end
end

ChangeSupportRoleDialog.CheckConditionNum = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self._screeningConditions) do
    count = count + (table.nums)(v)
  end
  return count
end

ChangeSupportRoleDialog.ScreeningAndSorting = function(self)
  -- function num : 0_13 , upvalues : _ENV, FILTER, FILTER_ELEMENT, SORT_TYPE
  (self._levelBtnTxt):SetText((TextManager.GetText)(self._sortCriteriaNameId))
  self._listByConditions = {}
  if self:CheckConditionNum() > 0 then
    local indexMap = {}
    local map1, map2, map3 = {}, {}, {}
    local check1, check2, check3 = false, false, false
    for k,v in pairs(self._screeningConditions) do
      for _,value in ipairs(v) do
        for i,role in ipairs(self._roleList) do
          if k == 1 then
            check1 = true
            if value.nameid == FILTER[role:GetRarityId()] then
              (table.insert)(map1, i)
            end
          end
          if k == 2 then
            check2 = true
            if value.nameid == role:GetVocationNameId() then
              (table.insert)(map2, i)
            end
          end
          if k == 3 then
            check3 = true
            if value.nameid == FILTER_ELEMENT[role:GetElement()] then
              (table.insert)(map3, i)
            end
          end
        end
      end
    end
    if check1 and check2 and check3 then
      for _,v1 in ipairs(map1) do
        if (table.indexof)(map2, v1) and (table.indexof)(map3, v1) then
          indexMap[v1] = v1
        end
      end
    else
      do
        if check1 and check2 then
          for _,v1 in ipairs(map1) do
            if (table.indexof)(map2, v1) then
              indexMap[v1] = v1
            end
          end
        else
          do
            if check1 and check3 then
              for _,v1 in ipairs(map1) do
                if (table.indexof)(map3, v1) then
                  indexMap[v1] = v1
                end
              end
            else
              do
                if check2 and check3 then
                  for _,v1 in ipairs(map2) do
                    if (table.indexof)(map3, v1) then
                      indexMap[v1] = v1
                    end
                  end
                else
                  do
                    if check1 then
                      indexMap = map1
                    else
                      if check2 then
                        indexMap = map2
                      else
                        if check3 then
                          indexMap = map3
                        end
                      end
                    end
                    for _,v in pairs(indexMap) do
                      (table.insert)(self._listByConditions, (self._roleList)[v])
                    end
                    do
                      self._listByConditions = self._roleList
                      ;
                      (table.sort)(self._listByConditions, function(a, b)
    -- function num : 0_13_0 , upvalues : self, SORT_TYPE
    local a_skill2Unlock = ((a:GetShowSkillData())[2]).unlock
    local b_skill2Unlock = ((b:GetShowSkillData())[2]).unlock
    if a_skill2Unlock and not b_skill2Unlock then
      return true
    else
      if not a_skill2Unlock and b_skill2Unlock then
        return false
      end
    end
    local _a, _b = nil, nil
    local sortType = self._sortCriteriaNameId
    if sortType == SORT_TYPE.LEVEL then
      _a = a:GetLevel()
    else
      -- DECOMPILER ERROR at PC40: Overwrote pending register: R5 in 'AssignReg'

      if sortType == SORT_TYPE.RARITY then
        _a = a:GetRarityId()
      else
        -- DECOMPILER ERROR at PC50: Overwrote pending register: R5 in 'AssignReg'

        if sortType == SORT_TYPE.GET_TIME then
          _a = a:GetBirthDay()
        end
      end
    end
    if _a == _b and sortType ~= SORT_TYPE.GET_TIME then
      local aId, bId = nil, nil
      if sortType == SORT_TYPE.LEVEL or sortType == SORT_TYPE.RARITY or sortType == 29 then
        aId = a:GetId()
      end
      if aId >= bId then
        do
          do return not self._isAscendingOrder end
          do return bId < aId end
          if _a >= _b then
            do return not self._isAscendingOrder end
            do return _b < _a end
            -- DECOMPILER ERROR: 8 unprocessed JMP targets
          end
        end
      end
    end
  end
)
                      if self._upFrame then
                        (self._upFrame):ReloadAllCell()
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

ChangeSupportRoleDialog.OnFilterBtnClick = function(self)
  -- function num : 0_14
  if not self._filterDlg then
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "Role", self._screeningConditions)
end

ChangeSupportRoleDialog.OnLevelBtnClick = function(self)
  -- function num : 0_15
  if not self._filterDlg then
    return 
  end
  ;
  (self._filterDlg):SetData(self, 2, "Role", self._sortCriteriaNameId)
end

ChangeSupportRoleDialog.OnSortBtnClick = function(self)
  -- function num : 0_16 , upvalues : _ENV, CUpdateUISortType
  self._isAscendingOrder = not self._isAscendingOrder
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  ;
  ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.SUPPORT_ROLE, self._sortCriteriaNameId, self._isAscendingOrder)
end

ChangeSupportRoleDialog.SetSortCriteriaNameId = function(self, nameId)
  -- function num : 0_17 , upvalues : _ENV, CUpdateUISortType
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    ;
    ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.SUPPORT_ROLE, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

ChangeSupportRoleDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_18
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

ChangeSupportRoleDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local supportRole = ((NekoData.BehaviorManager).BM_Friends):GetSupportRole()
  if (not supportRole and not self._selectedRole) or supportRole and self._selectedRole and (self._selectedRole):GetRoleId() == supportRole:GetRoleId() then
    self:Destroy()
  else
    local cchangeSupportRole = (LuaNetManager.CreateProtocol)("protocol.chat.cchangesupportrole")
    if cchangeSupportRole then
      if self._selectedRole then
        cchangeSupportRole.roleId = (self._selectedRole):GetRoleId()
      else
        cchangeSupportRole.roleId = 0
      end
      cchangeSupportRole:Send()
    end
    self:Destroy()
  end
end

ChangeSupportRoleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local supportRole = ((NekoData.BehaviorManager).BM_Friends):GetSupportRole()
  if (not self._selectedRole and not supportRole) or self._selectedRole and supportRole and (self._selectedRole):GetRoleId() == supportRole:GetRoleId() then
    self:Destroy()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(28, nil, function()
    -- function num : 0_20_0 , upvalues : self
    self:Destroy()
  end
, {}, nil, {})
  end
end

ChangeSupportRoleDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ChangeSupportRoleDialog.SendCUpdateUISortType = function(self)
  -- function num : 0_22 , upvalues : _ENV, CUpdateUISortType
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = (LuaNetManager.CreateProtocol)("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.SUPPORT_ROLE
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

return ChangeSupportRoleDialog

