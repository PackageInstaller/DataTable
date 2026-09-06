-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameBaseView.lua

module("logic.extensions.linkgame.view.LinkGameBaseView", package.seeall)

local LinkGameBaseView = class("LinkGameBaseView", ViewComponent)

function LinkGameBaseView:ctor()
	LinkGameBaseView.super.ctor(self)
end

function LinkGameBaseView:bindEvents()
	return
end

function LinkGameBaseView:unbindEvents()
	return
end

function LinkGameBaseView:buildUI()
	self._container = self:getGo("container")
	self._linkContainer = self:getGo("linkContainer")
	self._freeContainer = self:getGo("cellPool")
	self._cell = self:getGo("cell")
	self._linkCell = self:getGo("linkCell")
end

function LinkGameBaseView:destroyUI()
	return
end

function LinkGameBaseView:onEnter()
	GameUtil.SetActive(self._cell, false)

	self._isSelecting = true
	self._cellPools = {}

	self:setMapData()
	self:_genarateMap()
end

function LinkGameBaseView:onExit()
	removetimer(self._hideLinkEffect, self)
	removetimer(self._onSelectEnd, self)
	self:_disposeMap()

	self._isSelecting = true
end

function LinkGameBaseView:setMapData()
	self._miniGameCfg = LinkGameConfig.instance:getMiniGameCfg(2)
	self._iconCfg = LinkGameConfig.instance:getIconCfgs(self._miniGameCfg.iconPlan)

	if string.nilorempty(self._miniGameCfg.map) then
		-- block empty
	else
		local mapInfo = GameUtil.jsonToTable(self._miniGameCfg.map)

		LinkGameModel.instance:setMapData(mapInfo, true)
	end

	LinkGameController.instance:randomCurMap()
end

function LinkGameBaseView:getCellSize()
	return {
		x = 100,
		y = 100
	}
end

function LinkGameBaseView:getCellOffset()
	return {
		x = 5,
		y = 5
	}
end

function LinkGameBaseView:_startGame()
	self._isSelecting = false
end

function LinkGameBaseView:_genarateMap()
	self:_clearMap()

	self._mapData = LinkGameModel.instance:getMapData()
	self._mapCol = LinkGameModel.instance:getMapCol()
	self._mapRow = LinkGameModel.instance:getMapRow()
	self._mapObject = {}

	local cellSize = self:getCellSize()
	local cellCellOffset = self:getCellOffset()
	local posX, poxY = 0, 0
	local step = {
		x = cellSize.x + cellCellOffset.x,
		y = -(cellSize.y + cellCellOffset.y)
	}

	for row = 1, self._mapRow do
		for col = 1, self._mapCol do
			local obj = self:_genarateCell(self._mapData[row][col])

			self._mapObject[row] = self._mapObject[row] or {}
			self._mapObject[row][col] = obj

			GameUtil.setAnchoredPos(obj, -((cellSize.x + cellCellOffset.x) * self._mapCol + cellCellOffset.x) / 2 + step.x * (col - 1), ((cellSize.y + cellCellOffset.y) * self._mapRow + cellCellOffset.y) / 2 + step.y * (row - 1))
		end
	end

	self._linkObject = {}

	if self._linkCell and self._linkContainer then
		for row = 1, self._mapRow do
			for col = 1, self._mapCol do
				local obj = self:_genarateLinkCell()

				self._linkObject[row] = self._linkObject[row] or {}
				self._linkObject[row][col] = obj

				GameUtil.setAnchoredPos(obj, -((cellSize.x + cellCellOffset.x) * self._mapCol + cellCellOffset.x) / 2 + step.x * (col - 1), ((cellSize.y + cellCellOffset.y) * self._mapRow + cellCellOffset.y) / 2 + step.y * (row - 1))
			end
		end
	end
end

function LinkGameBaseView:_disposeFunc(obj)
	local imgIcon = goutil.findChild(obj, "cellInfo/imgIcon")

	if imgIcon then
		MaterialMgr.resetAll(imgIcon)
	end
end

function LinkGameBaseView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
	GameUtil.SetActive(obj.gameObject, false)
end

function LinkGameBaseView:_genarateCell(cellInfo)
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._cellPools[cellInfo.stateIdx] = self._cellPools[cellInfo.stateIdx] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPools[cellInfo.stateIdx] then
		cellObj = self._cellPools[cellInfo.stateIdx]:fetchObject()
	end

	if not cellObj then
		if self._cell then
			cellObj = goutil.cloneAndSetParent(self._cell, self._container.gameObject.transform)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._container.gameObject.transform)
	end

	GameUtil.SetActive(cellObj.gameObject, true)
	self:_updateCell(cellObj, cellInfo)

	return cellObj
end

function LinkGameBaseView:_genarateLinkCell()
	function resetFunc(obj)
		self:_resetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeFunc(obj)
	end

	self._cellPools[-1] = self._cellPools[-1] or ObjectPool.New(5, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPools[-1] then
		cellObj = self._cellPools[-1]:fetchObject()
	end

	if not cellObj then
		if self._linkCell then
			cellObj = goutil.cloneAndSetParent(self._linkCell, self._linkContainer.gameObject.transform)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, self._linkContainer.gameObject.transform)
	end

	GameUtil.SetActive(cellObj.gameObject, true)

	local go = cellObj.gameObject
	local linkGo = goutil.findChild(go, "linkGo")

	GameUtil.SetActive(linkGo, false)

	return cellObj
end

function LinkGameBaseView:_updateCell(cell, cellInfo)
	local go = cell.gameObject
	local cellInfoGo = goutil.findChild(go, "cellInfo")
	local iconChangeColor = goutil.findChildComponent(go, "cellInfo/imgIconColor", "UIImageColorChange")
	local imgIcon = goutil.findChild(go, "cellInfo/imgIcon")
	local linkGo = goutil.findChild(go, "linkGo")
	local btnClick = goutil.findChild(go, "cellInfo/btnClick")
	local selectGo = goutil.findChild(go, "cellInfo/imgSelect")

	MaterialMgr.resetAll(imgIcon)
	GameUtil.SetActive(selectGo, false)
	GameUtil.addClickHandler(btnClick, function()
		self:_onSelectCell(cellInfo.index)
	end, self)

	if cellInfo.stateIdx > 0 then
		if self._iconCfg[cellInfo.stateIdx] then
			GameUtil.SetActive(iconChangeColor, false)
			GameUtil.SetActive(imgIcon, true)
			MaterialMgr.setIcon(imgIcon, MatType.Pet, self._iconCfg[cellInfo.stateIdx].raceId)
		else
			GameUtil.SetActive(iconChangeColor, true)
			GameUtil.SetActive(imgIcon, false)
		end

		iconChangeColor:SetState(cellInfo.stateIdx - 1)
		GameUtil.SetActive(cellInfoGo, true)
		GameUtil.SetActive(linkGo, false)
	else
		GameUtil.SetActive(cellInfoGo, false)
	end
end

function LinkGameBaseView:_onSelectCell(index)
	if self._isSelecting == true then
		return
	end

	self._isSelecting = true

	local preSelectCell = LinkGameModel.instance:getSelectCell()
	local selectCellAInfo = LinkGameModel.instance:getCellInfo(index)
	local selectCellBInfo = LinkGameModel.instance:getCellInfo(preSelectCell)

	if preSelectCell == LinkGameModel.NotSelectIndex and selectCellAInfo.stateIdx ~= LinkGameModel.EmptyState then
		LinkGameModel.instance:setSelectCell(index)
		self:setCellSelect(true, selectCellAInfo)
		self:_onSelectEnd()
	elseif selectCellBInfo ~= nil and selectCellBInfo.stateIdx ~= LinkGameModel.EmptyState then
		LinkGameModel.instance:resetSelectCell()

		if index ~= preSelectCell and selectCellAInfo.stateIdx == selectCellBInfo.stateIdx then
			local path = self:_isLink(selectCellAInfo, selectCellBInfo)

			if #path > 0 then
				self._curPath = path

				self:_showLinkEffect()
				self:setCellSelect(true, selectCellAInfo, selectCellBInfo)
			else
				self:_onSelectEnd()
				self:setCellSelect(false, selectCellAInfo, selectCellBInfo)
			end
		elseif index == preSelectCell then
			self:_onSelectEnd()
			self:setCellSelect(false, selectCellAInfo, selectCellBInfo)
		else
			self:_onSelectEnd()
			self:setCellSelect(false, selectCellAInfo, selectCellBInfo)
		end
	else
		self:_onSelectEnd()
	end
end

function LinkGameBaseView:_isLink(cellInfoA, cellInfoB)
	return LinkGameController.instance:calcCellIsLink(cellInfoA, cellInfoB)
end

function LinkGameBaseView:setCellSelect(isSelect, ...)
	local cellInfos = {
		...
	}

	for i, v in ipairs(cellInfos) do
		if self._mapObject[v.row] and self._mapObject[v.row][v.col] then
			local go = self._mapObject[v.row][v.col]
			local selectGo = goutil.findChild(go, "cellInfo/imgSelect")

			GameUtil.SetActive(selectGo, isSelect)
		end
	end
end

function LinkGameBaseView:setCellLinkState(cellInfo, isShow, linkState, param)
	if self._linkObject[cellInfo.row] and self._linkObject[cellInfo.row][cellInfo.col] then
		local go = self._linkObject[cellInfo.row][cellInfo.col]
		local linkGo = goutil.findChild(go, "linkGo")

		GameUtil.SetActive(linkGo, isShow)

		if isShow == true then
			for i = 1, linkGo.transform.childCount do
				stateGo = goutil.findChild(linkGo, "state" .. i)

				if stateGo then
					GameUtil.SetActive(stateGo, linkState == i)
					GameUtil.setLocalRotation(stateGo, 0, 0, 90 * checknumber(param))
				end
			end
		end
	elseif self._mapObject[cellInfo.row] and self._mapObject[cellInfo.row][cellInfo.col] then
		local go = self._mapObject[cellInfo.row][cellInfo.col]
		local linkGo = goutil.findChild(go, "linkGo")

		GameUtil.SetActive(linkGo, isShow)

		if isShow == true then
			for i = 1, linkGo.transform.childCount do
				stateGo = goutil.findChild(linkGo, "state" .. i)

				if stateGo then
					GameUtil.SetActive(stateGo, linkState == i)
					GameUtil.setLocalRotation(stateGo, 0, 0, 90 * checknumber(param))
				end
			end
		end
	end
end

function LinkGameBaseView:_showLinkEffect()
	for i = 2, #self._curPath - 1 do
		local beforePoint = self._curPath[i - 1]
		local afterPoint = self._curPath[i + 1]

		if beforePoint.col == afterPoint.col then
			self:setCellLinkState(self._curPath[i], true, 1, 1)
		elseif beforePoint.row == afterPoint.row then
			self:setCellLinkState(self._curPath[i], true, 1, 0)
		else
			local offsetCol = beforePoint.col - self._curPath[i].col + (afterPoint.col - self._curPath[i].col)
			local offsetRow = beforePoint.row - self._curPath[i].row + (afterPoint.row - self._curPath[i].row)

			self:setCellLinkState(self._curPath[i], true, 2, offsetCol * offsetRow > 0 and offsetRow - 1 or offsetCol)
		end
	end

	removetimer(self._hideLinkEffect, self)
	settimer(math.min(0.05 * #self._curPath, 0.2), self._hideLinkEffect, self, false)
end

function LinkGameBaseView:_hideLinkEffect()
	for i, v in ipairs(self._curPath) do
		self:setCellLinkState(v, false, 1, 1)
	end

	self:_onLinkEffectEnd()
end

function LinkGameBaseView:_onLinkEffectEnd()
	local pathStart = self._curPath[1]
	local pathEnd = self._curPath[#self._curPath]

	self:_removeCell(pathStart.row, pathStart.col)
	self:_removeCell(pathEnd.row, pathEnd.col)

	if self:_isDeadGame() == true then
		self:_onDeadGame()
	else
		self:_onSelectEnd()
	end

	self._curPath = nil
end

function LinkGameBaseView:_removeCell(row, col)
	if self._mapData[row] and self._mapData[row][col] then
		LinkGameModel.instance:removeCell(self._mapData[row][col].index, true)
	end

	if self._mapObject[row] and self._mapObject[row][col] then
		local go = self._mapObject[row][col]
		local cellInfo = goutil.findChild(go, "cellInfo")

		GameUtil.SetActive(cellInfo, false)
	end
end

function LinkGameBaseView:_isDeadGame()
	local isCheck = false
	local isFind = false
	local stateMap = LinkGameModel.instance:getStateMap()

	for i, typeMap in pairs(stateMap) do
		local list = table.values(typeMap)

		for j, v in ipairs(list) do
			for k = j + 1, #list do
				isCheck = true

				if #self:_isLink(v, list[k]) > 0 then
					isFind = true

					break
				end
			end

			if isFind == true then
				break
			end
		end
	end

	return isCheck and not isFind
end

function LinkGameBaseView:_onDeadGame()
	LinkGameController.instance:randomCurMap()
	self:_genarateMap()
	removetimer(self._onSelectEnd, self)
	settimer(1, self._onSelectEnd, self, false)
end

function LinkGameBaseView:_onSelectEnd()
	self._isSelecting = false

	self:_checkGame()
end

function LinkGameBaseView:_checkGame()
	return
end

function LinkGameBaseView:_endGame()
	self._isSelecting = true
end

function LinkGameBaseView:_clearMap()
	for row, v in ipairs(self._mapObject or {}) do
		for col, obj in ipairs(v) do
			local cellInfo = self._mapData[row][col]

			self._cellPools[cellInfo.stateIdx]:returnObject(obj)
		end
	end

	self._mapObject = nil
end

function LinkGameBaseView:_disposeMap()
	self:_clearMap()

	for k, v in pairs(self._cellPools or {}) do
		v:clear()
	end
end

return LinkGameBaseView
