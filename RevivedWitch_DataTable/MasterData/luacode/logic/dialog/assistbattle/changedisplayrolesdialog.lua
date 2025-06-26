-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/changedisplayrolesdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIBackManager = require("framework.ui.uibackmanager")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local ChangeDisplayRolesDialog = class("ChangeDisplayRolesDialog", Dialog)
ChangeDisplayRolesDialog.AssetBundleName = "ui/layouts.friends"
ChangeDisplayRolesDialog.AssetName = "ChangeShow"
local SORT_TYPE = {LEVEL = 501827, RARITY = 501828, GET_TIME = 501829, HP = 501830}
local RARITY = {R = 1, SR = 2, SSR = 3, UR = 4, EX = 5}
local ELEMENT_TYPE = {HYDRAGYRUM = 1, SALT = 2, FIRE = 3, ETHER = 4}
local FILTER = {[RARITY.SSR] = 501831, [RARITY.SR] = 501832, [RARITY.R] = 501833, [RARITY.UR] = 501834, [RARITY.EX] = 502614}
local FILTER_ELEMENT = {[ELEMENT_TYPE.HYDRAGYRUM] = 502771, [ELEMENT_TYPE.SALT] = 502772, [ELEMENT_TYPE.FIRE] = 502773, [ELEMENT_TYPE.ETHER] = 502774}
ChangeDisplayRolesDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChangeDisplayRolesDialog, SORT_TYPE
  ((ChangeDisplayRolesDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._roleList = {}
  self._selectedRoleList = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = SORT_TYPE.LEVEL
  self._isAscendingOrder = false
  self._listByConditions = {}
end

ChangeDisplayRolesDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame, TableFrame, UIBackManager, CUpdateUISortType
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
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._tip = self:GetChild("Back/Tips")
  ;
  (self._tip):SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
  self._upFrame = (GridFrame.Create)(self._upPanel, self, true, 8)
  self._downFrame = (TableFrame.Create)(self._downPanel, self, false, false)
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  ;
  (self._levelBtn):Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
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
  local uiSortInfo = ((NekoData.BehaviorManager).BM_Game):GetUISortType(CUpdateUISortType.ROLE4SHOW)
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
        self._selectedRoleList = ((NekoData.BehaviorManager).BM_Friends):GetDisplayRoles()
        self:Refresh()
        ;
        (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RoleInfoChange, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
      end
    end
  end
end

ChangeDisplayRolesDialog.OnDestroy = function(self)
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

ChangeDisplayRolesDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  self:ScreeningAndSorting()
  if #self._selectedRoleList > 0 then
    for i,v in ipairs(self._selectedRoleList) do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

      (self._selectedRoleList)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v:GetId())
    end
  end
  do
    ;
    (self._downFrame):ReloadAllCell()
  end
end

ChangeDisplayRolesDialog.OnUniqueEquipLevelUp = function(self, notification)
  -- function num : 0_4
  (self._upFrame):FireEvent("UniqueEquipLevelUp", (notification.userInfo).roleId)
  ;
  (self._downFrame):FireEvent("UniqueEquipLevelUp", (notification.userInfo).roleId)
end

ChangeDisplayRolesDialog.IsInSelectedRoleList = function(self, key)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(self._selectedRoleList) do
    if v:GetRoleId() == key then
      return i
    end
  end
  return nil
end

ChangeDisplayRolesDialog.SetSelectedRoles = function(self, key)
  -- function num : 0_6 , upvalues : _ENV
  local index = self:IsInSelectedRoleList(key)
  if index then
    (table.remove)(self._selectedRoleList, index)
    ;
    (self._upFrame):FireEvent("SetRolesSelectedState", self._selectedRoleList)
  else
    ;
    (table.insert)(self._selectedRoleList, ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key))
    ;
    (self._upFrame):FireEvent("SetRolesSelectedState", self._selectedRoleList)
  end
  ;
  (self._downFrame):ReloadAllCell()
end

ChangeDisplayRolesDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._upFrame then
    return #self._listByConditions
  else
    return #self._selectedRoleList
  end
end

ChangeDisplayRolesDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "assistbattle.changesupportrolecell"
end

ChangeDisplayRolesDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._upFrame then
    return (self._listByConditions)[index]
  else
    local data = {}
    data.role = (self._selectedRoleList)[index]
    data.tag = true
    return data
  end
end

ChangeDisplayRolesDialog.CheckConditionNum = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local count = 0
  for k,v in pairs(self._screeningConditions) do
    count = count + (table.nums)(v)
  end
  return count
end

ChangeDisplayRolesDialog.ScreeningAndSorting = function(self)
  -- function num : 0_11 , upvalues : _ENV, FILTER, FILTER_ELEMENT, SORT_TYPE
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
    -- function num : 0_11_0 , upvalues : self, SORT_TYPE
    local _a, _b = nil, nil
    local sortType = self._sortCriteriaNameId
    if sortType == SORT_TYPE.LEVEL then
      _a = a:GetLevel()
    else
      -- DECOMPILER ERROR at PC19: Overwrote pending register: R3 in 'AssignReg'

      if sortType == SORT_TYPE.RARITY then
        _a = a:GetRarityId()
      else
        -- DECOMPILER ERROR at PC29: Overwrote pending register: R3 in 'AssignReg'

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

ChangeDisplayRolesDialog.OnFilterBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "Role", self._screeningConditions)
end

ChangeDisplayRolesDialog.OnLevelBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 2, "Role", self._sortCriteriaNameId)
end

ChangeDisplayRolesDialog.OnSortBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV, CUpdateUISortType
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
  ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.ROLE4SHOW, self._sortCriteriaNameId, self._isAscendingOrder)
end

ChangeDisplayRolesDialog.SetSortCriteriaNameId = function(self, nameId)
  -- function num : 0_15 , upvalues : _ENV, CUpdateUISortType
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    ;
    ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.ROLE4SHOW, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

ChangeDisplayRolesDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_16
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

ChangeDisplayRolesDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local cchangeDisplayRoles = (LuaNetManager.CreateProtocol)("protocol.chat.cchangedisplayroles")
  do
    if cchangeDisplayRoles then
      local list = {}
      for i = 1, 3 do
        list[i] = 0
      end
      for i,v in ipairs(self._selectedRoleList) do
        list[i] = v:GetRoleId()
      end
      cchangeDisplayRoles.roleIds = list
      cchangeDisplayRoles:Send()
    end
    self:Destroy()
  end
end

ChangeDisplayRolesDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local isSame = true
  if #self._selectedRoleList == #((NekoData.BehaviorManager).BM_Friends):GetDisplayRoles() then
    for i,v in ipairs(self._selectedRoleList) do
      local tag = false
      for index,value in ipairs(((NekoData.BehaviorManager).BM_Friends):GetDisplayRoles()) do
        if v:GetRoleId() == value:GetRoleId() then
          tag = true
          break
        end
      end
      do
        do
          if not tag then
            isSame = false
            break
          end
          -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  else
    isSame = false
  end
  if isSame then
    self:Destroy()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(28, nil, function()
    -- function num : 0_18_0 , upvalues : self
    self:Destroy()
  end
, {}, nil, {})
  end
end

ChangeDisplayRolesDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ChangeDisplayRolesDialog.SendCUpdateUISortType = function(self)
  -- function num : 0_20 , upvalues : _ENV, CUpdateUISortType
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = (LuaNetManager.CreateProtocol)("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.ROLE4SHOW
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

return ChangeDisplayRolesDialog

