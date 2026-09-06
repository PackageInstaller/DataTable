local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local UIManager = CS.PixelNeko.UI.UIManager
local CScreeningConditions = BeanManager.GetTableByName("role.cscreeningconditions")
local MaxResolveNum = 20
local BaseCharacterListAllDialog = class("BaseCharacterCellListAll", Dialog)
BaseCharacterListAllDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListAllDialog.AssetName = "BaseCharactorCellListAll"

function BaseCharacterListAllDialog:Ctor(...)
  BaseCharacterListAllDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._inResolvePanel = false
  self._selectResolveRoles = {}
  self._roleList = {}
  self._redPointBtnSelected = false
  self._screeningConditions = {}
  self._sortCriteriaNameId = 501827
  self._isAscendingOrder = false
  self._listByConditions = {}
  self._isLock = false
  self._redPointRefList = {}
  self._roleHelperCurPos = nil
end

function BaseCharacterListAllDialog:OnCreate()
  self._cellFrame = self:GetChild("CellLargeFrame")
  self._numPage = self:GetChild("Page")
  self._numPage:SetActive(false)
  self._num = self:GetChild("Page/Num")
  self._total = self:GetChild("Page/Total")
  self._lockBtn = self:GetChild("Black1/LockBtn")
  self._lockBtn:SetSelected(false)
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
  self._lockBtn:Subscribe_PointerClickEvent(self.OnLockBtnClick, self)
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._levelBtn:Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._redPointBtn = self:GetChild("FliterBtnRedDot")
  self._redPointBtn_num = self:GetChild("FliterBtnRedDot/_Text")
  self._redPointBtn:Subscribe_PointerClickEvent(self.OnRedPointBtnClick, self)
  self._lockBlack = self:GetChild("Black1/Black")
  self._lockBlack:SetActive(false)
  self._resolveBtn = self:GetChild("ResolveBtn")
  self._resolveBtn2 = self:GetChild("Black2/ResolveBtn")
  self._black2 = self:GetChild("Black2")
  self._resolvePanel = self:GetChild("Resolve")
  self._resolveNum = self:GetChild("Resolve/Num")
  self._resolveTotalNum = self:GetChild("Resolve/Total")
  self._confirmBtn = self:GetChild("Resolve/ConfirmBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  local ratio = UIManager.GetScreenWHRatio()
  local cellNum = 6
  if 2.0 < ratio then
    local wAnchor, wWidth = self._cellFrame:GetWidth()
    local px, pox, py, poy = self._cellFrame:GetPosition()
    local cellDialog = DialogManager.CreateDialog("character.basecharacterlistallcell", nil)
    local rootWindow = cellDialog:GetRootWindow()
    local cellWidth = rootWindow:GetRectSize()
    cellDialog:RootWindowDestroy()
    self._cellFrame:SetWidth(wAnchor, wWidth + cellWidth)
    self._cellFrame:SetPosition(px, pox - cellWidth / 2, py, poy)
    cellNum = 7
  end
  self._frame = GridFrame.Create(self._cellFrame, self, true, cellNum)
  self._frame:SetMargin(40, 40)
  local uiSortInfo = NekoData.BehaviorManager.BM_Game:GetUISortType(CUpdateUISortType.ALL_ROLES)
  if uiSortInfo then
    self._sortCriteriaNameId = uiSortInfo.nameTxtId or self._sortCriteriaNameId
    self._isAscendingOrder = uiSortInfo.isAscending or self._isAscendingOrder
    self._sortUpBtnImg:SetActive(self._isAscendingOrder)
    self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
    self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
    self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  end
  self:LoadLocalData()
  self:OnRedPointNumChanged()
  LuaNotificationCenter.AddObserver(self, self.OnRoleRemove, Common.n_RoleRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleLocked, Common.n_RoleLocked, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(3)
  if not NekoData.BehaviorManager.BM_Guide:HasFinished(67) and NekoData.BehaviorManager.BM_Guide:HasFinished(2) then
    LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
  end
end

function BaseCharacterListAllDialog:Init(sceneController)
  self._baseSceneController = sceneController
end

function BaseCharacterListAllDialog:OnDestroy()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
  DialogManager.DestroySingletonDialog("character.basecharacterlistselectdialog")
  self._frame:Destroy()
  self._frame = nil
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
  self:SendCUpdateUISortType()
end

function BaseCharacterListAllDialog:OnRedPointNumChanged(notification)
  if not notification or notification.userInfo.redPointID == 100001 then
    if NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(100001) > 0 then
      self._redPointBtn:SetActive(true)
      self._redPointBtn:SetSelected(self._redPointBtnSelected)
      local num = 0
      for i, role in ipairs(self._redPointRefList) do
        if 0 < NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(100002, {
          role:GetId()
        }) then
          num = num + 1
        end
      end
      self._redPointBtn_num:SetText(num)
      if notification and (not self._redPointNum or num ~= self._redPointNum) then
        self:ScreeningAndSorting()
      end
      self._redPointNum = num
    else
      if self._redPointBtnSelected then
        self._redPointNum = nil
        self._redPointBtnSelected = not self._redPointBtnSelected
        self._redPointBtn:SetSelected(self._redPointBtnSelected)
        if notification then
          self:ScreeningAndSorting()
        end
      end
      self._redPointBtn:SetActive(false)
    end
  end
end

function BaseCharacterListAllDialog:OnRefresh(notification)
  self:LoadLocalData()
  if self._roleHelperCurPos and self._frame then
    self._frame:MoveToAssignedPos(self._roleHelperCurPos)
  end
end

function BaseCharacterListAllDialog:OnRoleLocked(notification)
  self._frame:FireEvent("RoleLock", notification.userInfo)
end

function BaseCharacterListAllDialog:OnRoleRemove(notification)
  if notification.userInfo.roleId then
    local index = self:GetCellIndex(notification.userInfo.roleId)
    if index then
      self._frame:RemoveCellsAtIndex({index})
      table.remove(self._listByConditions, index)
    end
  end
  if self._inResolvePanel then
    if self._resolveBtn:IsActive() then
      self._resolveBtn:SetActive(false)
    end
    if not self._black2:IsActive() then
      self._black2:SetActive(true)
    end
    if not self._resolvePanel:IsActive() then
      self._resolvePanel:SetActive(true)
    end
    if #self._selectResolveRoles == MaxResolveNum then
      self._frame:FireEvent("RoleDust")
    end
    local indexList = {}
    for i, v in ipairs(self._selectResolveRoles) do
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v:GetRoleId())
      if not role then
        table.insert(indexList, i)
      else
        self._selectResolveRoles[i] = role
      end
    end
    while indexList[#indexList] do
      table.remove(self._selectResolveRoles, indexList[#indexList])
      table.remove(indexList, #indexList)
    end
    local num = #self._selectResolveRoles
    self._resolveNum:SetText(tostring(num))
    if num == 0 then
      self._confirmBtn:SetInteractable(false)
    else
      self._confirmBtn:SetInteractable(true)
    end
  else
    if not self._resolveBtn:IsActive() then
      self._resolveBtn:SetActive(true)
    end
    if self._black2:IsActive() then
      self._black2:SetActive(false)
    end
    if self._resolvePanel:IsActive() then
      self._resolvePanel:SetActive(false)
    end
  end
end

function BaseCharacterListAllDialog:GetCellIndex(key)
  for i, v in ipairs(self._listByConditions) do
    if v:GetRoleId() == key then
      return i
    end
  end
  return nil
end

function BaseCharacterListAllDialog:LoadLocalData()
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetContainMaterialRoleList()
  self:ScreeningAndSorting()
  if self._inResolvePanel then
    if self._resolveBtn:IsActive() then
      self._resolveBtn:SetActive(false)
    end
    if not self._black2:IsActive() then
      self._black2:SetActive(true)
    end
    if not self._resolvePanel:IsActive() then
      self._resolvePanel:SetActive(true)
    end
    local indexList = {}
    for i, v in ipairs(self._selectResolveRoles) do
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v:GetRoleId())
      if not role then
        table.insert(indexList, i)
      else
        self._selectResolveRoles[i] = role
      end
    end
    while indexList[#indexList] do
      table.remove(self._selectResolveRoles, indexList[#indexList])
      table.remove(indexList, #indexList)
    end
    local num = #self._selectResolveRoles
    self._resolveNum:SetText(tostring(num))
    if num == 0 then
      self._confirmBtn:SetInteractable(false)
    else
      self._confirmBtn:SetInteractable(true)
    end
  else
    if not self._resolveBtn:IsActive() then
      self._resolveBtn:SetActive(true)
    end
    if self._black2:IsActive() then
      self._black2:SetActive(false)
    end
    if self._resolvePanel:IsActive() then
      self._resolvePanel:SetActive(false)
    end
  end
end

function BaseCharacterListAllDialog:OnRedPointBtnClick()
  self._redPointBtnSelected = not self._redPointBtnSelected
  self._redPointBtn:SetSelected(self._redPointBtnSelected)
  self:ScreeningAndSorting()
end

function BaseCharacterListAllDialog:GetNumByRoleId(id)
  local count = 0
  for i, v in ipairs(self._listByConditions) do
    if v:GetId() == id then
      count = count + 1
    end
  end
  return count
end

function BaseCharacterListAllDialog:ScreeningAndSorting()
  self._levelBtnTxt:SetText(TextManager.GetText(self._sortCriteriaNameId))
  while self._listByConditions[#self._listByConditions] do
    table.remove(self._listByConditions, #self._listByConditions)
  end
  for i, v in ipairs(self._roleList) do
    table.insert(self._listByConditions, v)
  end
  for k, v in pairs(self._screeningConditions) do
    local select = false
    local indexMap = {}
    for index, value in ipairs(v) do
      select = true
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == 501833 and role:GetRarityId() == 1 or value.nameid == 501832 and role:GetRarityId() == 2 or value.nameid == 501831 and role:GetRarityId() == 3 or value.nameid == 501834 and role:GetRarityId() == 4 or value.nameid == 502614 and role:GetRarityId() == 5 then
          indexMap[i] = i
        end
      end
    end
    for index, value in ipairs(v) do
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == role:GetVocationNameId() then
          indexMap[i] = i
        end
      end
    end
    for index, value in ipairs(v) do
      for i, role in ipairs(self._listByConditions) do
        if value.nameid == 502771 and role:GetElement() == 1 or value.nameid == 502772 and role:GetElement() == 2 or value.nameid == 502773 and role:GetElement() == 3 or value.nameid == 502774 and role:GetElement() == 4 then
          indexMap[i] = i
        end
      end
    end
    if select then
      local deleteList = {}
      for i = 1, #self._listByConditions do
        if not indexMap[i] then
          table.insert(deleteList, i)
        end
      end
      while deleteList[#deleteList] do
        table.remove(self._listByConditions, deleteList[#deleteList])
        table.remove(deleteList, #deleteList)
      end
    end
  end
  table.sort(self._listByConditions, function(a, b)
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
    end
    if _a == _b and self._sortCriteriaNameId ~= 501829 then
      local aId, bId
      if self._sortCriteriaNameId == 501827 then
        aId, bId = a:GetRarityId(), b:GetRarityId()
      elseif self._sortCriteriaNameId == 501828 then
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
  while self._redPointRefList[#self._redPointRefList] do
    table.remove(self._redPointRefList, #self._redPointRefList)
  end
  while self._listByConditions[#self._listByConditions] do
    table.insert(self._redPointRefList, 1, self._listByConditions[#self._listByConditions])
    table.remove(self._listByConditions, #self._listByConditions)
  end
  for i, v in ipairs(self._redPointRefList) do
    if self._redPointBtnSelected then
      if NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(100002, {
        v:GetId()
      }) > 0 then
        table.insert(self._listByConditions, v)
      end
    else
      table.insert(self._listByConditions, v)
    end
  end
  self:OnRedPointNumChanged()
  if self._frame then
    self._frame:ReloadAllCell()
    self._frame:RefreshUIParticleClipper()
  end
end

function BaseCharacterListAllDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "Role", self._screeningConditions)
end

function BaseCharacterListAllDialog:OnLevelBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 2, "Role", self._sortCriteriaNameId)
end

function BaseCharacterListAllDialog:OnSortBtnClick()
  self._isAscendingOrder = not self._isAscendingOrder
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.ALL_ROLES, self._sortCriteriaNameId, self._isAscendingOrder)
end

function BaseCharacterListAllDialog:OnLockBtnClick()
  if self._isLock then
    self._lockBtn:SetSelected(false)
    self._lockBlack:SetActive(false)
    self._frame:FireEvent("EnterLockEvent", false)
  else
    self._lockBtn:SetSelected(true)
    self._lockBlack:SetActive(true)
    self._frame:FireEvent("EnterLockEvent", true)
  end
  self._isLock = not self._isLock
end

function BaseCharacterListAllDialog:SetSortCriteriaNameId(nameId)
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.ALL_ROLES, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

function BaseCharacterListAllDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function BaseCharacterListAllDialog:ReturnRoleList()
  return self._listByConditions
end

function BaseCharacterListAllDialog:SetRoleHelperCurPos()
  self._roleHelperCurPos = self._frame:GetCurrentPosition()
end

function BaseCharacterListAllDialog:NumberOfCell(frame)
  return #self._listByConditions
end

function BaseCharacterListAllDialog:CellAtIndex(frame)
  if frame == self._frame then
    return "character.basecharacterlistallcell"
  end
end

function BaseCharacterListAllDialog:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._listByConditions[index]
  end
end

function BaseCharacterListAllDialog:IsInSelectResolveRoles(role)
  for i, v in ipairs(self._selectResolveRoles) do
    if v:GetRoleId() == role:GetRoleId() then
      return i
    end
  end
  return nil
end

function BaseCharacterListAllDialog:ChooseResolveRoles(role)
  local index = self:IsInSelectResolveRoles(role)
  if index then
    table.remove(self._selectResolveRoles, index)
  else
    table.insert(self._selectResolveRoles, role)
  end
  self._frame:FireEvent("ChooseResolveRole")
  local num = #self._selectResolveRoles
  self._resolveNum:SetText(tostring(num))
  if num == 0 then
    self._confirmBtn:SetInteractable(false)
  else
    self._confirmBtn:SetInteractable(true)
  end
end

function BaseCharacterListAllDialog:OnResolveBtnClick()
  if self._inResolvePanel then
    self._inResolvePanel = false
    self._resolveBtn:SetActive(true)
    self._black2:SetActive(false)
    self._resolvePanel:SetActive(false)
    while self._selectResolveRoles[#self._selectResolveRoles] do
      table.remove(self._selectResolveRoles, #self._selectResolveRoles)
    end
    self._frame:FireEvent("RoleDusted")
  else
    self._inResolvePanel = true
    self._resolveBtn:SetActive(false)
    self._black2:SetActive(true)
    self._resolvePanel:SetActive(true)
    self._frame:FireEvent("RoleDust")
    self._resolveNum:SetText(tostring(0))
    self._resolveTotalNum:SetText(MaxResolveNum)
    self._confirmBtn:SetInteractable(false)
  end
end

function BaseCharacterListAllDialog:OnConfirmBtnClick()
  DialogManager.CreateSingletonDialog("character.resolveroledialog"):SetData(self._selectResolveRoles)
end

function BaseCharacterListAllDialog:OnBackBtnClicked()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  DialogManager.DestroySingletonDialog("character.basecharacterlistselectdialog")
  self:Destroy()
end

function BaseCharacterListAllDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function BaseCharacterListAllDialog:GetTypeBtnTxt()
  return self._typeBtnTxt
end

function BaseCharacterListAllDialog:OnActorCellClicked(tagCount)
  local logicCell = self._frame:GetLogicCell(1)
  if not logicCell._cell then
    self._frame:GetCellDialog(logicCell)
    logicCell._cell._delegate = self
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
  end
  local _, sizeY = logicCell._cell:GetRootWindow():GetRectSize()
  logicCell._cell:GetRootWindow():SetPosition(0, logicCell._posX, 1, -logicCell._posY - sizeY)
  logicCell._cell:OnCellClicked()
end

function BaseCharacterListAllDialog:OnSpecificActorCellClicked(roleId)
  for i, v in ipairs(self._listByConditions) do
    if v:GetRoleId() == roleId then
      local logicCell = self._frame:GetLogicCell(i)
      if not logicCell._cell then
        self._frame:GetCellDialog(logicCell)
        logicCell._cell._delegate = self
        logicCell._cell._cellData = logicCell._data
        logicCell._cell:RefreshCell(logicCell._data)
      end
      local _, sizeY = logicCell._cell:GetRootWindow():GetRectSize()
      logicCell._cell:GetRootWindow():SetPosition(0, logicCell._posX, 1, -logicCell._posY - sizeY)
      logicCell._cell:OnCellClicked()
      break
    end
  end
end

function BaseCharacterListAllDialog:JumpToRoleGift()
  local logicCell = self._frame:GetLogicCell(1)
  if not logicCell._cell then
    self._frame:GetCellDialog(logicCell)
    logicCell._cell._delegate = self
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
  end
  if logicCell._cell._cellData:GetIsLeader() then
    logicCell = self._frame:GetLogicCell(2)
    if not logicCell._cell then
      self._frame:GetCellDialog(logicCell)
      logicCell._cell._delegate = self
      logicCell._cell._cellData = logicCell._data
      logicCell._cell:RefreshCell(logicCell._data)
    end
  end
  local _, sizeY = logicCell._cell:GetRootWindow():GetRectSize()
  logicCell._cell:GetRootWindow():SetPosition(0, logicCell._posX, 1, -logicCell._posY - sizeY)
  logicCell._cell:OnCellClicked()
end

function BaseCharacterListAllDialog:SendCUpdateUISortType()
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = LuaNetManager.CreateProtocol("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.ALL_ROLES
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

return BaseCharacterListAllDialog
