-- chunkname: @IQIGame\\UI\\LoopMapUI.lua

local LoopMapUI = {}

LoopMapUI = Base:Extend("LoopMapUI", "IQIGame.Onigao.UI.LoopMapUI", LoopMapUI)

local LoopMapUIViewClass = require("IQIGame.UI.LoopMapUI.LoopMapUIView")
local LoopMapNormalCellClass = require("IQIGame.UI.LoopMapUI.LoopMapNormalCell")
local LoopMapStartCellClass = require("IQIGame.UI.LoopMapUI.LoopMapStartCell")
local LoopMapEndCellClass = require("IQIGame.UI.LoopMapUI.LoopMapEndCell")
local LoopMapConvertCellClass = require("IQIGame.UI.LoopMapUI.LoopMapConvertCell")
local LoopMapLightCellClass = require("IQIGame.UI.LoopMapUI.LoopMapLightCell")
local LoopMapBlockCellClass = require("IQIGame.UI.LoopMapUI.LoopMapBlockCell")
local OPTION = {
	open = 3,
	revise = 2,
	normal = 1
}

function LoopMapUI:OnInit()
	self.view = LoopMapUIViewClass.New(self.gameObject)

	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function LoopMapUI:InitMembers()
	self.mapCellList = {}
	self.lineCellList = {}
	self.lastLineIndex = 0
	self.currentOption = OPTION.normal
end

function LoopMapUI:InitDelegate()
	function self.onBeginDrag(gameObject, eventData, eventDataGo)
		self:OnBeginDrag(gameObject, eventData, eventDataGo)
	end

	function self.onDrag(gameObject, eventData, eventDataGo)
		self:OnDrag(gameObject, eventData, eventDataGo)
	end

	function self.onPointClick(gameObject, eventData)
		self:OnPointClick(gameObject, eventData)
	end

	function self.delegateOnClickButtonReturn()
		UIModule.CloseSelf(self)

		if self.startLoopMapTask then
			self.startLoopMapTask:SetComplete(false)
		end
	end

	function self.delegateOnClickButtonRevert()
		self:OnClickButtonRevert()
	end

	function self.delegateOnClickButtonRevise()
		self:OnClickButtonRevise()
	end

	function self.delegateOnClickButtonSwitch()
		self:OnClickButtonSwitch()
	end

	function self.rotateConvertCellEvent(row, column)
		self:RotateConvert(row, column)
	end
end

function LoopMapUI:InitComponent()
	self.mapContentEventListener = self.view.mapContent:GetComponent("EventTriggerExtendListener")
	self.mapContentEventListener._onBeginDrag = self.mapContentEventListener._onBeginDrag + self.onBeginDrag
	self.mapContentEventListener._onDrag = self.mapContentEventListener._onDrag + self.onDrag
	self.mapContentEventListener.onPointerClick = self.mapContentEventListener.onPointerClick + self.onPointClick
	self.mapContentGrid = self.view.mapContent:GetComponent("GridLayoutGroup")
	self.mapContentRect = self.view.mapContent:GetComponent("RectTransform")
	self.prefabRect = self.view.mapItem:GetComponent("RectTransform")
end

function LoopMapUI:OnOpen(userData)
	self.cfgId = userData.cfgId
	self.startLoopMapTask = userData.startLoopMapTask

	self:CreateMap()
end

function LoopMapUI:OnAddListeners()
	self.view.buttonReturn:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonReturn)
	self.view.buttonRevert:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonRevert)
	self.view.buttonRevise:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonRevise)
	self.view.buttonSwitch:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSwitch)
	EventDispatcher.AddEventListener(EventID.LoopMapUIRotateConvertEvent, self.rotateConvertCellEvent)
end

function LoopMapUI:OnRemoveListeners()
	self.view.buttonReturn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonReturn)
	self.view.buttonRevert:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonRevert)
	self.view.buttonRevise:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonRevise)
	self.view.buttonSwitch:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSwitch)
	EventDispatcher.RemoveEventListener(EventID.LoopMapUIRotateConvertEvent, self.rotateConvertCellEvent)
end

function LoopMapUI:OnClose(userData)
	for _, v in pairs(self.mapCellList) do
		v:OnDestroy()
	end

	self:InitMembers()
end

function LoopMapUI:GetPreloadAssetPaths()
	return nil
end

function LoopMapUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LoopMapUI:IsManualShowOnOpen(userData)
	return false
end

function LoopMapUI:GetBGM(userData)
	return nil
end

function LoopMapUI:OnPause()
	return
end

function LoopMapUI:OnResume()
	return
end

function LoopMapUI:OnCover()
	return
end

function LoopMapUI:OnReveal()
	return
end

function LoopMapUI:OnRefocus(userData)
	return
end

function LoopMapUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LoopMapUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoopMapUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoopMapUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoopMapUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.view:OnDestroy()
end

function LoopMapUI:OnBeginDrag(gameObject, eventData, eventDataGo)
	if self.currentOption ~= OPTION.normal then
		return
	end

	if LuaUtility.GameObjectIsNullOrEmpty(eventDataGo) then
		return
	end

	local cell = self:GetCellClassWithInstanceID(eventDataGo)

	if not cell then
		return
	end

	self:AddLineListIfNeed(cell)
	cell:OnDragging()
end

function LoopMapUI:OnDrag(gameObject, eventData, eventDataGo)
	if self.currentOption ~= OPTION.normal then
		return
	end

	if LuaUtility.GameObjectIsNullOrEmpty(eventDataGo) then
		return
	end

	local cell = self:GetCellClassWithInstanceID(eventDataGo)

	if not cell then
		return
	end

	self:AddLineListIfNeed(cell)
	cell:OnDragging()
end

function LoopMapUI:OnPointClick(gameObject, eventData)
	if self.currentOption ~= OPTION.revise then
		return
	end

	if LuaUtility.GameObjectIsNullOrEmpty(eventData.pointerEnter) then
		return
	end

	local cell = self:GetCellClassWithInstanceID(eventData.pointerEnter)

	if not cell then
		return
	end

	self:ReviseCellLine(cell)
end

function LoopMapUI:GetCellClassWithInstanceID(gameObject)
	local id = gameObject:GetInstanceID()

	for _, v in pairs(self.mapCellList) do
		if v:GetInstanceID() == id then
			return v
		end
	end

	return nil
end

function LoopMapUI:AddLineListIfNeed(cell)
	if self.lastLineIndex and self.lastLineIndex ~= 0 then
		local len = #self.lineCellList[self.lastLineIndex]
		local lastCell = self.lineCellList[self.lastLineIndex][len]

		if lastCell:GetType() ~= Constant.LoopMapCellType.End and self:CheckCellAdd(lastCell, cell) and cell:IsNeedAddInLineList() then
			self:CheckCellDirection(self.lastLineIndex, lastCell, cell)
			lastCell:OnDragging()
			table.insert(self.lineCellList[self.lastLineIndex], cell)

			return
		end
	end

	local len = #self.lineCellList

	for i = 1, len do
		local len2 = #self.lineCellList[i]

		if len2 <= 0 then
			if cell:IsNeedAddInLineList() and cell:GetType() == Constant.LoopMapCellType.Start then
				cell:SetIsAddInList(true)
				table.insert(self.lineCellList[i], cell)

				self.lastLineIndex = i

				return
			end
		else
			local lastCell = self.lineCellList[i][len2]

			if lastCell:GetType() ~= Constant.LoopMapCellType.End and self:CheckCellAdd(lastCell, cell) and cell:IsNeedAddInLineList() then
				self:CheckCellDirection(i, lastCell, cell)
				lastCell:OnDragging()
				table.insert(self.lineCellList[i], cell)

				self.lastLineIndex = i

				return
			end
		end
	end
end

function LoopMapUI:CheckCellAdd(lastCell, cell)
	if math.abs(lastCell.column - cell.column) > 1 or math.abs(lastCell.row - cell.row) > 1 then
		return false
	end

	if lastCell.column ~= cell.column and lastCell.row ~= cell.row then
		return false
	end

	return true
end

function LoopMapUI:CheckCellDirection(lineIndex, lastCell, cell)
	if not lastCell then
		return
	end

	if lastCell.column == cell.column then
		lastCell:AddOrSetConnect(lineIndex, nil, lastCell.row > cell.row and Constant.LoopMapDirection.Top or Constant.LoopMapDirection.Bottom)
		cell:AddOrSetConnect(lineIndex, lastCell.row > cell.row and Constant.LoopMapDirection.Bottom or Constant.LoopMapDirection.Top, nil)
	else
		lastCell:AddOrSetConnect(lineIndex, nil, lastCell.column > cell.column and Constant.LoopMapDirection.Left or Constant.LoopMapDirection.Right)
		cell:AddOrSetConnect(lineIndex, lastCell.column > cell.column and Constant.LoopMapDirection.Right or Constant.LoopMapDirection.Left, nil)
	end

	cell:SetIsAddInList(true)
end

function LoopMapUI:CreateMap()
	if not self.cfgId or self.cfgId == 0 then
		logError("【线路图】 cfgId = " .. self.cfgId)

		return
	end

	self.cfgLoopMap = CfgUtil.GetCfgLoopMapDataWithID(self.cfgId)

	local width = self.prefabRect.sizeDelta.x * self.cfgLoopMap.column
	local height = self.prefabRect.sizeDelta.y * self.cfgLoopMap.row

	self.mapContentRect.sizeDelta = Vector2.New(width, height)

	local spIndex = 1

	for i = 1, self.cfgLoopMap.row do
		for j = 1, self.cfgLoopMap.column do
			local o = GameObject.Instantiate(self.view.mapItem, self.view.mapContent.transform)
			local cellType = Constant.LoopMapCellType.Normal
			local params, openNode

			if self.cfgLoopMap.mapCellList[spIndex].row == i and self.cfgLoopMap.mapCellList[spIndex].column == j then
				cellType = self.cfgLoopMap.mapCellList[spIndex].cellType
				params = self.cfgLoopMap.mapCellList[spIndex].params
				openNode = self.cfgLoopMap.mapCellList[spIndex].openNode
				spIndex = spIndex + 1
			end

			local param = {}

			param.cellType = cellType
			param.row = i
			param.column = j
			param.gameObject = o
			param.params = params
			param.openNode = openNode

			local cell = self:_GetCell(param)

			if not cell then
				logError("【线路图】未知格子类型 cellType = " .. cellType)

				return
			end

			table.insert(self.mapCellList, cell)
		end
	end
end

function LoopMapUI:_GetCell(param)
	local cell

	if param.cellType == Constant.LoopMapCellType.Normal then
		cell = LoopMapNormalCellClass.new(param)
	elseif param.cellType == Constant.LoopMapCellType.Converter then
		cell = LoopMapConvertCellClass.new(param)

		cell:RefreshState()
	elseif param.cellType == Constant.LoopMapCellType.Light then
		cell = LoopMapLightCellClass.new(param)
	elseif param.cellType == Constant.LoopMapCellType.Block then
		cell = LoopMapBlockCellClass.new(param)
	elseif param.cellType == Constant.LoopMapCellType.End then
		cell = LoopMapEndCellClass.new(param)
	elseif param.cellType == Constant.LoopMapCellType.Start then
		cell = LoopMapStartCellClass.new(param)

		table.insert(self.lineCellList, {})
	end

	return cell
end

function LoopMapUI:OnClickButtonRevert()
	if self.currentOption == OPTION.open then
		return
	end

	self:RevertAllCell()
end

function LoopMapUI:RevertAllCell()
	self.lastLineIndex = 0

	for _, v in pairs(self.mapCellList) do
		v:RevertState()
	end

	local len = #self.lineCellList

	for i = 1, len do
		self.lineCellList[i] = {}
	end
end

function LoopMapUI:OnClickButtonRevise()
	if self.currentOption == OPTION.open then
		return
	end

	if self.currentOption ~= OPTION.revise then
		self.currentOption = OPTION.revise

		LuaUtility.SetImageColorWithGameObject(self.view.buttonRevise, 1, 0, 0, 1)
	else
		self.currentOption = OPTION.normal

		LuaUtility.SetImageColorWithGameObject(self.view.buttonRevise, 1, 1, 1, 1)
	end
end

function LoopMapUI:ReviseCellLine(cell)
	local len = #self.lineCellList

	for i = 1, len do
		local len2 = #self.lineCellList[i]

		for j = 1, len2 do
			if self.lineCellList[i][j]:GetInstanceID() == cell:GetInstanceID() then
				for k = len2, j, -1 do
					self.lineCellList[i][k]:RevertState()

					self.lineCellList[i][k] = nil
				end

				return
			end
		end
	end
end

function LoopMapUI:OnClickButtonSwitch()
	if self.currentOption == OPTION.open then
		return
	end

	self.currentOption = OPTION.open

	local convertList = {}
	local len = #self.lineCellList

	for i = 1, len do
		local len2 = #self.lineCellList[i]

		if len2 <= 0 then
			self:OnProcessingFailed()

			return
		end

		local startCell = self.lineCellList[i][1]

		if startCell.type ~= Constant.LoopMapCellType.Start then
			self:OnProcessingFailed()

			return
		end

		local matchCode = startCell:GetMatchCode()

		for j = 1, len2 do
			if j == len2 then
				local lastCell = self.lineCellList[i][j]

				if lastCell.type ~= Constant.LoopMapCellType.End or lastCell:GetMatchCode() ~= matchCode then
					self:OnProcessingFailed()

					return
				end
			end

			if self.lineCellList[i][j].type == Constant.LoopMapCellType.Converter then
				table.insert(convertList, self.lineCellList[i][j])
			elseif not self.lineCellList[i][j]:OnProcessing() then
				self:OnProcessingFailed()

				return
			end
		end
	end

	len = #convertList

	for i = 1, len do
		if not convertList[i]:OnProcessing() then
			self:OnProcessingFailed()

			return
		end
	end

	for _, v in pairs(self.mapCellList) do
		if (v.type == Constant.LoopMapCellType.Start or v.type == Constant.LoopMapCellType.End or v.type == Constant.LoopMapCellType.Light) and not v:GetIsPowerOn() then
			self:OnProcessingFailed()

			return
		end
	end

	self:OnProcessingSuccess()
end

function LoopMapUI:OnProcessingFailed()
	coroutine.start(function()
		LuaUtility.SetText(self.view.textFlag, "失败")
		LuaUtility.SetGameObjectShow(self.view.textFlag, true)
		LuaUtility.DoFadeWithText(self.view.textFlag, 1, 1)
		coroutine.wait(1)
		LuaUtility.SetGameObjectShow(self.view.textFlag, false)
		self:RevertAllCell()

		self.currentOption = OPTION.normal
	end)
end

function LoopMapUI:OnProcessingSuccess()
	coroutine.start(function()
		LuaUtility.SetText(self.view.textFlag, "成功")
		LuaUtility.SetGameObjectShow(self.view.textFlag, true)
		LuaUtility.DoFadeWithText(self.view.textFlag, 1, 1)
		coroutine.wait(1)
		LuaUtility.SetGameObjectShow(self.view.textFlag, false)
		UIModule.CloseSelf(self)

		if self.startLoopMapTask then
			self.startLoopMapTask:SetComplete(true)
		end
	end)
end

function LoopMapUI:RotateConvert(row, column)
	for _, v in pairs(self.mapCellList) do
		if v.row == row and v.column == column and v.type == Constant.LoopMapCellType.Converter then
			local cell = v

			cell:Rotate()

			break
		end
	end
end

return LoopMapUI
