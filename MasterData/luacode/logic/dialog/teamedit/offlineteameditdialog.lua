local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local UIManager = CS.PixelNeko.UI.UIManager
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CElementEffect = BeanManager.GetTableByName("role.celementeffect")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local OffLineTeamEditDialog = class("OffLineTeamEditDialog", Dialog)
OffLineTeamEditDialog.AssetBundleName = "ui/layouts.offlinepvp"
OffLineTeamEditDialog.AssetName = "OffLinePVPTeam"
local TEAMID = 3000
local roleNum = 3

function OffLineTeamEditDialog:Ctor(...)
  OffLineTeamEditDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._teamId = -1
  self._teamInfo = {}
  self._curTeamRoles = {}
  self._charLargeCell = {}
  self._dialogStr = "teamedit.characterlargecell"
end

function OffLineTeamEditDialog:OnCreate()
  self._btn4 = self:GetChild("Btn4")
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._switchPositionBtn = self:GetChild("SwitchPositionBtn")
  self._switchPositionBlack = self:GetChild("SwitchPositionBlack")
  self._switchFinishBtn = self:GetChild("SwitchFinishBtn")
  self._pos = {}
  for i = 1, roleNum do
    self._pos[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i)
    self._pos[i]:Subscribe_PointerClickEvent(function()
      self:OnCharPosClicked(i)
    end)
  end
  self._elementImg = self:GetChild("ElementStage/Element")
  self._elementContentTxt = self:GetChild("ElementStage/Txt1")
  self._elementContentNum = self:GetChild("ElementStage/Txt2")
  self._elementContentTxtRectX = self._elementContentTxt:GetRectSize()
  self._elementContentTxtWidthX, self._elementContentTxtWidthOX = self._elementContentTxt:GetWidth(self._elementContentTxtWidthOX)
  self._elementContentNumPosX, self._elementContentNumPosOX, self._elementContentNumPosY, self._elementContentNumPosOY = self._elementContentNum:GetPosition()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._btn4:Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
  self._switchPositionBtn:Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  self._switchFinishBtn:Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementBtnClicked, self)
  self._teamId = TEAMID
  self._teamInfo = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()[TEAMID]
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_TeamInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RoleInfoChange, nil)
end

function OffLineTeamEditDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function OffLineTeamEditDialog:SetData(battleId)
  self._battleId = battleId
  self:Refresh()
end

function OffLineTeamEditDialog:RefreshFashion()
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

function OffLineTeamEditDialog:Refresh()
  if self._teamInfo then
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

function OffLineTeamEditDialog:RefreshTeamElementInfo()
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

function OffLineTeamEditDialog:OnBtn4Clicked()
  local req = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
  req.battleType = req.ARENA
  req.id = self._battleId
  LogErrorFormat("OffLineTeamEditDialog", "--- battleId = %s ---", self._battleId)
  req.lineupID = self._teamId
  req:Send()
end

function OffLineTeamEditDialog:OnCharPosClicked(posIndex)
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
    dialog:SetFilterCondition(NekoData.BehaviorManager.BM_Team:GetTeamFilterCondition())
    dialog:Init(self._teamInfo, self._curTeamRoles[index])
  end
end

function OffLineTeamEditDialog:OnCharCellBeginDrag(screenPosition, data)
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

function OffLineTeamEditDialog:OnCharCellDrag(screenPosition, data)
  if self._charLargeCell[data.station] then
    self._charLargeCell[data.station]:GetRootWindow():SetAnchoredPosition(UIManager.ScreenPointToLocalPointInRectangle(self._pos[data.station]._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("OffLineTeamEditDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

function OffLineTeamEditDialog:OnCharCellEndDrag(screenPosition, data)
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

function OffLineTeamEditDialog:OnSwitchPositionBtnClicked()
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

function OffLineTeamEditDialog:OnElementBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teamelementinfodialog")
  if dialog then
    dialog:SetData(self._oneTotalElementValue, self._elementStage)
    dialog:HideStage2()
  end
end

function OffLineTeamEditDialog:OnBackBtnClicked()
  self:Destroy()
end

function OffLineTeamEditDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return OffLineTeamEditDialog
