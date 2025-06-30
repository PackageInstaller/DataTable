-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/rolebooklistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CCardRoleConfig_HandBook = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CNPCConfig_Handbook = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local RoleBookListDialog = class("RoleBookListDialog", Dialog)
RoleBookListDialog.AssetBundleName = "ui/layouts.tujiannew"
RoleBookListDialog.AssetName = "BookList"
local ListType = {Role = 1, NPC = 2}
local MAXCOUNT = 10000
RoleBookListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleBookListDialog, ListType
  ((RoleBookListDialog.super).Ctor)(self, ...)
  self._data = {}
  self._listtype = ListType.Role
  self._screeningConditions = {}
  self._sortCriteriaNameId = 1301081
  self._isAscendingOrder = false
  self._listByConditions = {}
end

RoleBookListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CUpdateUISortType
  self._toggle_0 = self:GetChild("ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("ToggleGroup/_Toggle_1")
  self._groupBtn = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtn)[i] = self:GetChild("GroupBtn" .. i)
    end
  end
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):SetActive(false)
  self._scrollBar = self:GetChild("Scrollbar")
  self.roleListPanel = self:GetChild("Frame")
  ;
  (self._toggle_0):SetIsOnType(false)
  ;
  (self._toggle_1):SetIsOnType(true)
  ;
  (self._toggle_0):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    (self._toggle_0):SetIsOnType(false)
    self:ToRelationship()
  end
, self)
  ;
  (self._toggle_1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    (self._toggle_1):SetIsOnType(true)
  end
, self)
  for i = 1, 2 do
    ((self._groupBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:SetListType(i)
  end
)
  end
  ;
  ((self._groupBtn)[1]):SetSelected(true)
  self._filterBtn = self:GetChild("FliterBtn")
  self._levelBtn = self:GetChild("LevelBtn")
  self._levelBtnTxt = self:GetChild("LevelBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  ;
  (self._sortUpBtnImg):SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  ;
  (self._sortDownBtnImg):SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  ;
  (self._sortUpBtnTxt):SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  ;
  (self._sortDownBtnTxt):SetActive(not self._isAscendingOrder)
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  ;
  (self._levelBtn):Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
  local uiSortInfo = ((NekoData.BehaviorManager).BM_Game):GetUISortType(CUpdateUISortType.ROLES_HANDBOOK)
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
        local lockedRoleList = ((NekoData.BehaviorManager).BM_HandBook):GetLockedRoleList()
        self._lockedRoleMap = {}
        for _,id in ipairs(lockedRoleList) do
          -- DECOMPILER ERROR at PC196: Confused about usage of register: R8 in 'UnsetPending'

          (self._lockedRoleMap)[id] = true
        end
      end
    end
  end
end

RoleBookListDialog.Refresh = function(self)
  -- function num : 0_2 , upvalues : GridFrame, ListType, _ENV, CCardRoleConfig_HandBook, Role, CNPCConfig_Handbook
  if self.roleListFrame then
    (self.roleListFrame):Destroy()
  end
  self.roleListFrame = (GridFrame.Create)(self.roleListPanel, self, true, 6)
  self._data = {}
  if self._listtype == ListType.Role then
    (self._filterBtn):SetActive(true)
    ;
    (self._levelBtn):SetActive(true)
    ;
    (self._sortBtn):SetActive(true)
    for _,v in ipairs(CCardRoleConfig_HandBook:GetAllIds()) do
      local record = CCardRoleConfig_HandBook:GetRecorder(v)
      if record.isShow == 1 and not (self._lockedRoleMap)[record.id] then
        local role = (Role.Create)(record.id, nil, true)
        ;
        (table.insert)(self._data, role)
      end
    end
    self:ScreeningAndSorting()
  else
    ;
    (self._filterBtn):SetActive(false)
    ;
    (self._levelBtn):SetActive(false)
    ;
    (self._sortBtn):SetActive(false)
    for _,v in ipairs(CNPCConfig_Handbook:GetAllIds()) do
      local record = CNPCConfig_Handbook:GetRecorder(v)
      if record.isShow == 1 then
        local npcData = {id = record.id, nameTextId = record.NPCNameTextID, imageID = record.imageID}
        ;
        (table.insert)(self._data, npcData)
      end
    end
    ;
    (self.roleListFrame):ReloadAllCell()
  end
end

RoleBookListDialog.OnDestroy = function(self)
  -- function num : 0_3
  if self.roleListFrame then
    (self.roleListFrame):Destroy()
  end
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
  self:SendCUpdateUISortType()
end

RoleBookListDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4 , upvalues : ListType
  if self._listtype == ListType.Role then
    return #self._listByConditions
  else
    return #self._data
  end
end

RoleBookListDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5 , upvalues : ListType
  if self._listtype == ListType.Role then
    return "handbook.booklistcharcell"
  else
    return "handbook.booklistnpccell"
  end
end

RoleBookListDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6 , upvalues : ListType
  if self._listtype == ListType.Role then
    return (self._listByConditions)[index]
  else
    return (self._data)[index]
  end
end

RoleBookListDialog.ToRelationship = function(self)
  -- function num : 0_7
  (self._delegate):SetPage(1)
end

RoleBookListDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  if frame == self.roleListFrame then
    local width, height = (self.roleListPanel):GetRectSize()
    local total = (self.roleListFrame):GetTotalLength()
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  end
end

RoleBookListDialog.SetListType = function(self, type)
  -- function num : 0_9
  self._listtype = type
  for i = 1, 2 do
    ((self._groupBtn)[i]):SetSelected(type == i)
  end
  self:Refresh()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RoleBookListDialog.GetNumByRoleId = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  local count = 0
  for i,v in ipairs(self._listByConditions) do
    if v:GetId() == id then
      count = count + 1
    end
  end
  return count
end

RoleBookListDialog.ScreeningAndSorting = function(self)
  -- function num : 0_11 , upvalues : _ENV, MAXCOUNT, CCardRoleConfig_HandBook
  (self._levelBtnTxt):SetText((TextManager.GetText)(self._sortCriteriaNameId))
  while (self._listByConditions)[#self._listByConditions] do
    (table.remove)(self._listByConditions, #self._listByConditions)
  end
  for i,v in ipairs(self._data) do
    (table.insert)(self._listByConditions, v)
  end
  for k,v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for index,value in ipairs(v) do
      select = true
      for i,role in ipairs(self._listByConditions) do
        if value.type == 1 and value.value == role:GetRarityId() then
          indexMap[i] = i
        else
          if value.type == 2 and value.value == role:GetVocationId() then
            indexMap[i] = i
          else
            if (value.value == 1 and ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(role:GetId())) or value.value == 0 and not ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(role:GetId()) then
              indexMap[i] = i
            end
          end
        end
      end
    end
    if select then
      local deleteList = {}
      for i = 1, #self._listByConditions do
        if not indexMap[i] then
          (table.insert)(deleteList, i)
        end
      end
      do
        do
          while deleteList[#deleteList] do
            (table.remove)(self._listByConditions, deleteList[#deleteList])
            ;
            (table.remove)(deleteList, #deleteList)
          end
          -- DECOMPILER ERROR at PC131: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC131: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC131: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (table.sort)(self._listByConditions, function(a, b)
    -- function num : 0_11_0 , upvalues : self, MAXCOUNT, CCardRoleConfig_HandBook, _ENV
    local _a, _b = nil, nil
    if self._sortCriteriaNameId == 1301081 then
      _a = MAXCOUNT - (CCardRoleConfig_HandBook:GetRecorder(a:GetId())).sortID
      _b = MAXCOUNT - (CCardRoleConfig_HandBook:GetRecorder(b:GetId())).sortID
    else
      if self._sortCriteriaNameId == 1301077 then
        _a = a:GetRarityId()
        _b = b:GetRarityId()
      else
        if self._sortCriteriaNameId == 1301078 then
          if ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(a:GetId()) then
            _a = MAXCOUNT - (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(a:GetId())):GetRoleId()
          else
            _a = -MAXCOUNT
          end
          if ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(b:GetId()) then
            _b = MAXCOUNT - (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(b:GetId())):GetRoleId()
          else
            _b = -MAXCOUNT
          end
        end
      end
    end
    if _a == _b and self._sortCriteriaNameId ~= 1301081 then
      local aSortID, bSortID = nil, nil
      aSortID = (CCardRoleConfig_HandBook:GetRecorder(a:GetId())).sortID
      bSortID = (CCardRoleConfig_HandBook:GetRecorder(b:GetId())).sortID
      if aSortID >= bSortID then
        do
          do return not self._isAscendingOrder end
          do return bSortID < aSortID end
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
  if self.roleListFrame then
    (self.roleListFrame):ReloadAllCell()
  end
end

RoleBookListDialog.OnFilterBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "RoleHandBook", self._screeningConditions)
end

RoleBookListDialog.OnLevelBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 2, "RoleHandBook", self._sortCriteriaNameId)
end

RoleBookListDialog.OnSortBtnClick = function(self)
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
  ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.ROLES_HANDBOOK, self._sortCriteriaNameId, self._isAscendingOrder)
end

RoleBookListDialog.SetSortCriteriaNameId = function(self, nameId)
  -- function num : 0_15 , upvalues : _ENV, CUpdateUISortType
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    ;
    ((NekoData.DataManager).DM_Game):RecorderUISortType(CUpdateUISortType.ROLES_HANDBOOK, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

RoleBookListDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_16
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

RoleBookListDialog.SendCUpdateUISortType = function(self)
  -- function num : 0_17 , upvalues : _ENV, CUpdateUISortType
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = (LuaNetManager.CreateProtocol)("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.ROLES_HANDBOOK
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

return RoleBookListDialog

