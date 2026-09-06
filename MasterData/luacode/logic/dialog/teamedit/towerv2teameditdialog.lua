local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CElementEffect = BeanManager.GetTableByName("role.celementeffect")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local UIManager = CS.PixelNeko.UI.UIManager
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local iconItem = Item.Create(DataCommon.DiamodID)
local TowerV2TeamEditDialog = class("TowerV2TeamEditDialog", Dialog)
TowerV2TeamEditDialog.AssetBundleName = "ui/layouts.stair"
TowerV2TeamEditDialog.AssetName = "StairTeam"
local limit
local roleNum = 6

function TowerV2TeamEditDialog:Ctor(...)
  TowerV2TeamEditDialog.super.Ctor(self, ...)
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
  self._charLargeCell = {}
  self._tempChangeRoleList = nil
  self._oneTimeChangingCurTeamRoles = {}
  self._dialogStr = "teamedit.characterlargecell"
end

function TowerV2TeamEditDialog:OnCreate()
  limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._btn4 = self:GetChild("Btn4")
  self._teamBtn = {}
  for i, c in ipairs({"A"}) do
    self._teamBtn[i] = {
      name = self:GetChild("TopPanel/Team" .. c .. "/Text"),
      editBtn = self:GetChild("TopPanel/Team" .. c .. "/Edit")
    }
    if self._teamBtn[i].editBtn then
      self._teamBtn[i].editBtn:Subscribe_PointerClickEvent(function()
        self:OnTeamNameEditClicked()
      end)
    end
  end
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._pos = {}
  for i = 1, roleNum do
    self._pos[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i)
    self._pos[i]:Subscribe_PointerClickEvent(function()
      self:OnCharPosClicked(i)
    end)
    self._pos[i]:Subscribe_LongPressEvent(function()
      self:OnCharPosLongPress(i)
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
  self._switchPositionBtn = self:GetChild("SwitchPositionBtn")
  self._switchPositionBlack = self:GetChild("SwitchPositionBlack")
  self._switchFinishBtn = self:GetChild("SwitchFinishBtn")
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
  self._btn4:Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
  self._switchPositionBtn:Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  self._switchFinishBtn:Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementBtnClicked, self)
  self:LoadLocalData()
  self:Refresh(NekoData.BehaviorManager.BM_Team:GetTowerCurrentTeamId())
  local ImageRecord = iconItem:GetIcon()
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  LuaNotificationCenter.AddObserver(self, self.OnEnterDungeon, Common.n_TowerV2Refresh, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTeam, Common.n_TeamInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
end

function TowerV2TeamEditDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
end

function TowerV2TeamEditDialog:GoTowerBattle(state)
  self._state = state
  self._isTowerBattle = true
  self._dialogStr = "towerv2.towerv2teamlargecharactercell"
  self._teamList = NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()
  self._teamIdList = {}
  for id, _ in pairs(self._teamList) do
    table.insert(self._teamIdList, id)
  end
  table.sort(self._teamIdList, function(a, b)
    return a < b
  end)
  print("tower team id", NekoData.BehaviorManager.BM_Team:GetTowerCurrentTeamId())
  self:Refresh(NekoData.BehaviorManager.BM_Team:GetTowerCurrentTeamId())
end

function TowerV2TeamEditDialog:DestroyModal(dialog)
end

function TowerV2TeamEditDialog:OnRefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
end

function TowerV2TeamEditDialog:OnRefreshCurrency()
end

function TowerV2TeamEditDialog:RefreshFashion()
end

function TowerV2TeamEditDialog:OnRefreshTeam(notification)
  self:LoadLocalData()
  self:Refresh(self._teamId)
  if notification.userInfo.name == "schangeroles" and self._haveSendCConfirmRolesBeforeEnterDungeon then
    self._haveSendCConfirmRolesBeforeEnterDungeon = false
    self:BeginTaskBtnClicked()
  end
end

function TowerV2TeamEditDialog:OnRefresh(notification)
  self:LoadLocalData()
  self:Refresh(self._teamId)
end

function TowerV2TeamEditDialog:LoadLocalData()
  if self._isTowerBattle then
    self._teamList = NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()
  else
    self._teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
  end
  self._teamIdList = {}
  for id, _ in pairs(self._teamList) do
    table.insert(self._teamIdList, id)
  end
  for id, v in pairs(self._teamList) do
    if self._teamBtn[id] and self._teamBtn[id].name then
      self._teamBtn[id].name:SetText(v.name)
    end
  end
  table.sort(self._teamIdList, function(a, b)
    return a < b
  end)
  self._roleList = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
end

function TowerV2TeamEditDialog:Refresh(teamId)
  if #self._teamIdList > 0 and teamId and 0 < teamId and self._teamList[teamId] then
    self._teamId = teamId
    self._teamInfo = self._teamList[teamId]
  end
  if self._teamInfo then
    self._name = self._teamInfo.name
    for i, v in ipairs(self._teamBtn) do
      v.editBtn:SetActive(true)
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
end

function TowerV2TeamEditDialog:RefreshTeamElementInfo()
  local currentTeamRoleList = NekoData.BehaviorManager.BM_Team:GetTeamRoles(self._teamId)
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station, roleId in pairs(currentTeamRoleList) do
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

function TowerV2TeamEditDialog:OnEnterDungeon()
  DialogManager.DestroySingletonDialog("mainline.mainline.newmainlinefloordialog")
  DialogManager.DestroySingletonDialog("mainline.mainline.mainlineworlddialog")
  DialogManager.DestroySingletonDialog("dungeon.dungeonnextfloordialog")
  DialogManager.DestroySingletonDialog("base.basemainui")
  DialogManager.DestroySingletonDialog("base.basemainmenudialog")
  DialogManager.DestroySingletonDialog("assistbattle.choosesupportroledialog")
  self:Destroy()
end

function TowerV2TeamEditDialog:OnBtn4Clicked()
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
  end
  if haveOneAlternativeRoleButNoInBattleRole then
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
      self:BeginTaskBtnClicked()
    end)
  else
    self:BeginTaskBtnClicked()
  end
end

function TowerV2TeamEditDialog:BeginTaskBtnClicked()
  local tag = false
  if tag then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100018)
  elseif self._state == "retreat" then
    NekoData.BehaviorManager.BM_TowerV2:Retreat()
  elseif self._state == "forward" then
    NekoData.BehaviorManager.BM_TowerV2:Forward()
  else
    NekoData.BehaviorManager.BM_TowerV2:Enter()
  end
  local randomKey = NekoData.BehaviorManager.BM_Team:GetRandomRoleKeyInTeam(self._teamId)
  local roleID = randomKey
  NekoData.BehaviorManager.BM_Voice:Play(roleID, NekoData.BehaviorManager.BM_Voice.VoiceType.Adventure, nil)
end

function TowerV2TeamEditDialog:OnTeamNameEditClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditchangenamedialog")
  dialog:SetTeamName(self._name, self._teamId, self._isTowerBattle)
end

function TowerV2TeamEditDialog:ReturnRoleList()
  local roleList = {}
  for _, v in ipairs(self._curTeamRoles) do
    if v.roleKey ~= 0 then
      table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(v.roleKey))
    end
  end
  return roleList
end

function TowerV2TeamEditDialog:OnBackBtnClicked()
  self:Destroy()
end

function TowerV2TeamEditDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function TowerV2TeamEditDialog:OnCharPosClicked(posIndex)
  if self._inSwitchPositionState then
    return
  end
  if 4 <= posIndex and not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AlterNativeRole) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100244)
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
    dialog:SetFilterCondition(NekoData.BehaviorManager.BM_Team:GetTeamFilterCondition())
    dialog:Init(self._teamInfo, self._curTeamRoles[index], true)
  end
end

function TowerV2TeamEditDialog:OnCharPosLongPress(posIndex)
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
    local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(self._curTeamRoles[index].roleKey)
    if not dialog and role then
      dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
      dialog:Refresh(role)
    end
  end
end

function TowerV2TeamEditDialog:OnCharCellBeginDrag(screenPosition, data)
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

function TowerV2TeamEditDialog:OnCharCellDrag(screenPosition, data)
  if self._charLargeCell[data.station] then
    self._charLargeCell[data.station]:GetRootWindow():SetAnchoredPosition(UIManager.ScreenPointToLocalPointInRectangle(self._pos[data.station]._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("TowerV2TeamEditDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

function TowerV2TeamEditDialog:OnCharCellEndDrag(screenPosition, data)
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

function TowerV2TeamEditDialog:OnSwitchPositionBtnClicked()
  if self._inSwitchPositionState then
    if self._draging then
      self:OnCharCellEndDrag({x = 0, y = 0}, self._currentDragingCellData)
    end
    self._switchPositionBtn:SetActive(true)
    self._switchFinishBtn:SetActive(false)
    self._inSwitchPositionState = false
    self._switchPositionBlack:SetActive(false)
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
    self._oneTimeChangingCurTeamRoles = clone(self._curTeamRoles)
  end
end

function TowerV2TeamEditDialog:OnElementBtnClicked()
  DialogManager.CreateSingletonDialog("teamedit.teamelementinfodialog"):SetData(self._oneTotalElementValue, self._elementStage)
end

return TowerV2TeamEditDialog
