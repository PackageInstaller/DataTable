local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIBackManager = require("framework.ui.uibackmanager")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local ChangeDisplayRolesDialog = class("ChangeDisplayRolesDialog", Dialog)
ChangeDisplayRolesDialog.AssetBundleName = "ui/layouts.friends"
ChangeDisplayRolesDialog.AssetName = "ChangeShow"
local SORT_TYPE = {
  LEVEL = 501827,
  RARITY = 501828,
  GET_TIME = 501829,
  HP = 501830
}
local RARITY = {
  R = 1,
  SR = 2,
  SSR = 3,
  UR = 4,
  EX = 5
}
local ELEMENT_TYPE = {
  HYDRAGYRUM = 1,
  SALT = 2,
  FIRE = 3,
  ETHER = 4
}
local FILTER = {
  [RARITY.SSR] = 501831,
  [RARITY.SR] = 501832,
  [RARITY.R] = 501833,
  [RARITY.UR] = 501834,
  [RARITY.EX] = 502614
}
local FILTER_ELEMENT = {
  [ELEMENT_TYPE.HYDRAGYRUM] = 502771,
  [ELEMENT_TYPE.SALT] = 502772,
  [ELEMENT_TYPE.FIRE] = 502773,
  [ELEMENT_TYPE.ETHER] = 502774
}

function ChangeDisplayRolesDialog:Ctor(...)
  ChangeDisplayRolesDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._roleList = {}
  self._selectedRoleList = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = SORT_TYPE.LEVEL
  self._isAscendingOrder = false
  self._listByConditions = {}
end

function ChangeDisplayRolesDialog:OnCreate()
  self._filterBtn = self:GetChild("FliterBtn")
  self._levelBtn = self:GetChild("LevelBtn")
  self._levelBtnTxt = self:GetChild("LevelBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  self._sortUpBtnImg:SetActive(false)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  self._sortDownBtnImg:SetActive(true)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  self._sortUpBtnTxt:SetActive(false)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  self._sortDownBtnTxt:SetActive(true)
  self._upPanel = self:GetChild("Back/CellFrame")
  self._downPanel = self:GetChild("Back/CellFrame2")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._tip = self:GetChild("Back/Tips")
  self._tip:SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._upFrame = GridFrame.Create(self._upPanel, self, true, 8)
  self._downFrame = TableFrame.Create(self._downPanel, self, false, false)
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._levelBtn:Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  local uiSortInfo = NekoData.BehaviorManager.BM_Game:GetUISortType(CUpdateUISortType.ROLE4SHOW)
  if uiSortInfo then
    self._sortCriteriaNameId = uiSortInfo.nameTxtId or self._sortCriteriaNameId
    self._isAscendingOrder = uiSortInfo.isAscending or self._isAscendingOrder
    self._sortUpBtnImg:SetActive(self._isAscendingOrder)
    self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
    self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
    self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  end
  self._selectedRoleList = NekoData.BehaviorManager.BM_Friends:GetDisplayRoles()
  self:Refresh()
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
end

function ChangeDisplayRolesDialog:OnDestroy()
  self._upFrame:Destroy()
  self._downFrame:Destroy()
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
  self:SendCUpdateUISortType()
end

function ChangeDisplayRolesDialog:Refresh()
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  self:ScreeningAndSorting()
  if #self._selectedRoleList > 0 then
    for i, v in ipairs(self._selectedRoleList) do
      self._selectedRoleList[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(v:GetId())
    end
  end
  self._downFrame:ReloadAllCell()
end

function ChangeDisplayRolesDialog:OnUniqueEquipLevelUp(notification)
  self._upFrame:FireEvent("UniqueEquipLevelUp", notification.userInfo.roleId)
  self._downFrame:FireEvent("UniqueEquipLevelUp", notification.userInfo.roleId)
end

function ChangeDisplayRolesDialog:IsInSelectedRoleList(key)
  for i, v in ipairs(self._selectedRoleList) do
    if v:GetRoleId() == key then
      return i
    end
  end
  return nil
end

function ChangeDisplayRolesDialog:SetSelectedRoles(key)
  local index = self:IsInSelectedRoleList(key)
  if index then
    table.remove(self._selectedRoleList, index)
    self._upFrame:FireEvent("SetRolesSelectedState", self._selectedRoleList)
  else
    table.insert(self._selectedRoleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(key))
    self._upFrame:FireEvent("SetRolesSelectedState", self._selectedRoleList)
  end
  self._downFrame:ReloadAllCell()
end

function ChangeDisplayRolesDialog:NumberOfCell(frame)
  if frame == self._upFrame then
    return #self._listByConditions
  else
    return #self._selectedRoleList
  end
end

function ChangeDisplayRolesDialog:CellAtIndex(frame)
  return "assistbattle.changesupportrolecell"
end

function ChangeDisplayRolesDialog:DataAtIndex(frame, index)
  if frame == self._upFrame then
    return self._listByConditions[index]
  else
    local data = {}
    data.role = self._selectedRoleList[index]
    data.tag = true
    return data
  end
end

function ChangeDisplayRolesDialog:CheckConditionNum()
  local count = 0
  for k, v in pairs(self._screeningConditions) do
    count = count + table.nums(v)
  end
  return count
end

function ChangeDisplayRolesDialog:ScreeningAndSorting()
  self._levelBtnTxt:SetText(TextManager.GetText(self._sortCriteriaNameId))
  self._listByConditions = {}
  if self:CheckConditionNum() > 0 then
    local indexMap = {}
    local map1, map2, map3 = {}, {}, {}
    local check1, check2, check3 = false, false, false
    for k, v in pairs(self._screeningConditions) do
      for _, value in ipairs(v) do
        for i, role in ipairs(self._roleList) do
          if k == 1 then
            check1 = true
            if value.nameid == FILTER[role:GetRarityId()] then
              table.insert(map1, i)
            end
          end
          if k == 2 then
            check2 = true
            if value.nameid == role:GetVocationNameId() then
              table.insert(map2, i)
            end
          end
          if k == 3 then
            check3 = true
            if value.nameid == FILTER_ELEMENT[role:GetElement()] then
              table.insert(map3, i)
            end
          end
        end
      end
    end
    if check1 and check2 and check3 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map2, v1) and table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 and check2 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map2, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 and check3 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check2 and check3 then
      for _, v1 in ipairs(map2) do
        if table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 then
      indexMap = map1
    elseif check2 then
      indexMap = map2
    elseif check3 then
      indexMap = map3
    end
    for _, v in pairs(indexMap) do
      table.insert(self._listByConditions, self._roleList[v])
    end
  else
    self._listByConditions = self._roleList
  end
  table.sort(self._listByConditions, function(a, b)
    local _a, _b
    local sortType = self._sortCriteriaNameId
    if sortType == SORT_TYPE.LEVEL then
      _a, _b = a:GetLevel(), b:GetLevel()
    elseif sortType == SORT_TYPE.RARITY then
      _a, _b = a:GetRarityId(), b:GetRarityId()
    elseif sortType == SORT_TYPE.GET_TIME then
      _a, _b = a:GetBirthDay(), b:GetBirthDay()
    end
    if _a == _b and sortType ~= SORT_TYPE.GET_TIME then
      local aId, bId
      if sortType == SORT_TYPE.LEVEL or sortType == SORT_TYPE.RARITY or sortType == 29 then
        aId, bId = a:GetId(), b:GetId()
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
  if self._upFrame then
    self._upFrame:ReloadAllCell()
  end
end

function ChangeDisplayRolesDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "Role", self._screeningConditions)
end

function ChangeDisplayRolesDialog:OnLevelBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 2, "Role", self._sortCriteriaNameId)
end

function ChangeDisplayRolesDialog:OnSortBtnClick()
  self._isAscendingOrder = not self._isAscendingOrder
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.ROLE4SHOW, self._sortCriteriaNameId, self._isAscendingOrder)
end

function ChangeDisplayRolesDialog:SetSortCriteriaNameId(nameId)
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.ROLE4SHOW, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

function ChangeDisplayRolesDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function ChangeDisplayRolesDialog:OnConfirmBtnClicked()
  local cchangeDisplayRoles = LuaNetManager.CreateProtocol("protocol.chat.cchangedisplayroles")
  if cchangeDisplayRoles then
    local list = {}
    for i = 1, 3 do
      list[i] = 0
    end
    for i, v in ipairs(self._selectedRoleList) do
      list[i] = v:GetRoleId()
    end
    cchangeDisplayRoles.roleIds = list
    cchangeDisplayRoles:Send()
  end
  self:Destroy()
end

function ChangeDisplayRolesDialog:OnBackBtnClicked()
  local isSame = true
  if #self._selectedRoleList == #NekoData.BehaviorManager.BM_Friends:GetDisplayRoles() then
    for i, v in ipairs(self._selectedRoleList) do
      local tag = false
      for index, value in ipairs(NekoData.BehaviorManager.BM_Friends:GetDisplayRoles()) do
        if v:GetRoleId() == value:GetRoleId() then
          tag = true
          break
        end
      end
      if not tag then
        isSame = false
        break
      end
    end
  else
    isSame = false
  end
  if isSame then
    self:Destroy()
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(28, nil, function()
      self:Destroy()
    end, {}, nil, {})
  end
end

function ChangeDisplayRolesDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChangeDisplayRolesDialog:SendCUpdateUISortType()
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = LuaNetManager.CreateProtocol("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.ROLE4SHOW
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

return ChangeDisplayRolesDialog
