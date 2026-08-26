-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchAreaGameMapView.lua

module("modules.logic.partygame.view.snatcharea.SnatchAreaGameMapView", package.seeall)

local SnatchAreaGameMapView = class("SnatchAreaGameMapView", BaseView)

function SnatchAreaGameMapView:onInitView()
	self.centerRectTr = gohelper.findChildComponent(self.viewGO, "root/center/center", gohelper.Type_RectTransform)
	self.cellItem = gohelper.findChild(self.viewGO, "root/center/center/item")

	gohelper.setActive(self.cellItem, false)

	self.centerWidth = recthelper.getWidth(self.centerRectTr)
	self.centerHeight = recthelper.getHeight(self.centerRectTr)
	self.cellItemList = {}
	self.playerUid2ColorId = {}
	self.areaType2PlayerId = {}
	self.interface = PartyGameCSDefine.SnatchAreaInterfaceCs
	self.rectWidth, self.rectHeight = recthelper.getWidth(self.centerRectTr), recthelper.getHeight(self.centerRectTr)
	self.preState = nil
end

function SnatchAreaGameMapView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.onFrameTick, self)
end

function SnatchAreaGameMapView:removeEvents()
	self.removeEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.onFrameTick, self)
end

function SnatchAreaGameMapView:onFrameTick()
	local curState = self.interface.GetCurState()

	if curState == SnatchEnum.GameState.StartRound then
		self:initPlayerColor()
		self:initMap()
	elseif curState == SnatchEnum.GameState.ShowOperate then
		self:refreshMap()
	elseif curState == SnatchEnum.GameState.Playing then
		local isDirty = self.interface.MapIsDirty()

		if isDirty then
			self:refreshMap()
		end
	elseif curState == SnatchEnum.GameState.Settlement then
		local isDirty = self.interface.MapIsDirty()

		if isDirty then
			self:refreshMap()
		end

		self:stepDissolveMap()
	end

	self.preState = curState
end

function SnatchAreaGameMapView:initPlayerColor()
	tabletool.clear(self.playerUid2ColorId)

	local playerMoList = PartyGameModel.instance:getCurGamePlayerList()

	for _, playerMo in ipairs(playerMoList) do
		local uid = playerMo.uid

		self.playerUid2ColorId[tostring(uid)] = self.interface.GetPlayerColorId(uid)
	end
end

function SnatchAreaGameMapView:initMap()
	local curState = self.interface.GetCurState()

	if self.preState == curState then
		return
	end

	self.pixTotalWidth, self.pixTotalHeight = self.interface.GetMapPixSize(nil, nil)
	self.halfCellPixWidth, self.halfCellPixHeight = self.interface.GetHalfCellSize(nil, nil)

	self:hideAllCell()

	local mapId = self.interface.GetMapId()
	local mapCo = mapId and lua_partygame_snatch_area_map.configDict[mapId]

	if not mapCo then
		logError("map co is nil : " .. tostring(mapId))

		mapCo = lua_partygame_snatch_area_map.configList[1]
	end

	local mapData, mapAreaPosList = SnatchAreaHelper.decodeMapData(mapCo.mapdata)

	self.preHandleStep = 0
	self.mapData = mapData
	self.mapAreaPosList = mapAreaPosList
	self.mapCo = mapCo
	self.row = #mapData
	self.column = #mapData[1]

	local cellWidth, cellHeight = self.centerWidth / self.column, self.centerHeight / self.row

	for i = 1, self.row do
		for j = 1, self.column do
			local index = self:getCellIndex(i, j)
			local cellItem = self.cellItemList[index]

			if not cellItem then
				cellItem = self:createCellItem()
				self.cellItemList[index] = cellItem
			end

			cellItem.animator:Play("idle", 0, 0)
			gohelper.setActive(cellItem.go, true)
			gohelper.setActive(cellItem.goImage, false)
			gohelper.setActive(cellItem.goEmpty, true)
			recthelper.setSize(cellItem.rectTr, cellWidth, cellHeight)

			local pixPosX, pixPosY = self.interface.GetCellPos(i - 1, j - 1, nil, nil)

			pixPosX = pixPosX - self.halfCellPixWidth
			pixPosY = pixPosY + self.halfCellPixHeight

			local anchorPosX, anchorPosY = SnatchAreaHelper.pixPos2AnchorPos(pixPosX, pixPosY, self.rectWidth, self.rectHeight, self.pixTotalWidth, self.pixTotalHeight)

			recthelper.setAnchor(cellItem.rectTr, anchorPosX, anchorPosY)

			local noneColor = SnatchEnum.Color[SnatchEnum.ColorId.White]

			SLFramework.UGUI.GuiHelper.SetColor(cellItem.image, noneColor)
			gohelper.setActive(cellItem.goLeftEdge, true)
			gohelper.setActive(cellItem.goRightEdge, true)
			gohelper.setActive(cellItem.goBottomEdge, true)
			gohelper.setActive(cellItem.goTopEdge, true)
			gohelper.setActive(cellItem.goLeftEdgeLight, false)
			gohelper.setActive(cellItem.goRightEdgeLight, false)
			gohelper.setActive(cellItem.goBottomEdgeLight, false)
			gohelper.setActive(cellItem.goTopEdgeLight, false)
		end
	end
end

function SnatchAreaGameMapView:refreshMap()
	local playerMoList = PartyGameModel.instance:getCurGamePlayerList()

	tabletool.clear(self.areaType2PlayerId)

	for _, playerMo in ipairs(playerMoList) do
		local pickType = self.interface.GetPlayerPickArea(playerMo.uid)

		if pickType ~= SnatchEnum.AreaType.None then
			self.areaType2PlayerId[pickType] = playerMo.uid
		end
	end

	for i = 1, self.row do
		for j = 1, self.column do
			local areaType = self.mapData[i][j]
			local playUid = self.areaType2PlayerId[areaType]
			local cellItem = self.cellItemList[self:getCellIndex(i, j)]
			local curCellData = self.mapData[i][j]

			gohelper.setActive(cellItem.goEmpty, false)

			if playUid then
				local colorId = self.playerUid2ColorId[tostring(playUid)]

				SLFramework.UGUI.GuiHelper.SetColor(cellItem.image, SnatchEnum.Color[colorId])
				gohelper.setActive(cellItem.goImage, true)
			else
				local noneColor = SnatchEnum.Color[SnatchEnum.ColorId.White]

				SLFramework.UGUI.GuiHelper.SetColor(cellItem.image, noneColor)
				gohelper.setActive(cellItem.goImage, false)
			end

			local selected = playUid ~= nil

			gohelper.setActive(cellItem.goLeftEdge, selected)
			gohelper.setActive(cellItem.goRightEdge, selected)
			gohelper.setActive(cellItem.goBottomEdge, selected)
			gohelper.setActive(cellItem.goTopEdge, selected)
			gohelper.setActive(cellItem.goLeftEdgeLight, j == 1 or curCellData ~= self.mapData[i][j - 1])
			gohelper.setActive(cellItem.goRightEdgeLight, j == self.column or curCellData ~= self.mapData[i][j + 1])
			gohelper.setActive(cellItem.goBottomEdgeLight, i == self.row or curCellData ~= self.mapData[i + 1][j])
			gohelper.setActive(cellItem.goTopEdgeLight, i == 1 or curCellData ~= self.mapData[i - 1][j])
		end
	end
end

function SnatchAreaGameMapView:hideAllLightBorder()
	for i = 1, self.row do
		for j = 1, self.column do
			local index = self:getCellIndex(i, j)
			local cellItem = self.cellItemList[index]
			local curCellData = self.mapData[i][j]

			if cellItem then
				gohelper.setActive(cellItem.goLeftEdgeLight, j == 1 or curCellData ~= self.mapData[i][j - 1])
				gohelper.setActive(cellItem.goRightEdgeLight, j == self.column or curCellData ~= self.mapData[i][j + 1])
				gohelper.setActive(cellItem.goBottomEdgeLight, i == self.row or curCellData ~= self.mapData[i + 1][j])
				gohelper.setActive(cellItem.goTopEdgeLight, i == 1 or curCellData ~= self.mapData[i - 1][j])
				gohelper.setActive(cellItem.goLeftEdge, false)
				gohelper.setActive(cellItem.goRightEdge, false)
				gohelper.setActive(cellItem.goBottomEdge, false)
				gohelper.setActive(cellItem.goTopEdge, false)
			end
		end
	end
end

function SnatchAreaGameMapView:stepDissolveMap()
	local curStep = self.interface.GetSettlementStep()

	if curStep <= self.preHandleStep then
		return
	end

	self:hideAllLightBorder()

	self.preHandleStep = curStep

	local playerMoList = PartyGameModel.instance:getCurGamePlayerList()

	for _, playerMo in ipairs(playerMoList) do
		local playerUid = playerMo.uid
		local pickType = self.interface.GetPlayerPickArea(playerUid)
		local posList = self.mapAreaPosList[pickType]
		local pos = posList and posList[curStep]

		if posList then
			if not #posList then
				local posListLen = 0

				if pos then
					local cellIndex = self:getCellIndex(pos.x, pos.y)
					local cellItem = self.cellItemList[cellIndex]

					if cellItem then
						local isLast = posListLen <= curStep
						local animName = isLast and "finishout" or "out"

						cellItem.animator:Play(animName, 0, 0)

						if isLast then
							AudioMgr.instance:trigger(340106)
						else
							AudioMgr.instance:trigger(340105)
						end
					else
						logError(string.format("cell item (%s, %s) = %s, not exist ?", pos.x, pos.y, cellIndex))
					end
				end
			end
		end
	end
end

function SnatchAreaGameMapView:getCellIndex(x, y)
	return (x - 1) * self.column + y
end

function SnatchAreaGameMapView:hideAllCell()
	for _, cellItem in ipairs(self.cellItemList) do
		gohelper.setActive(cellItem.go, false)

		cellItem.image.enabled = true
	end
end

function SnatchAreaGameMapView:createCellItem()
	local cellItem = self:getUserDataTb_()

	cellItem.go = gohelper.cloneInPlace(self.cellItem)
	cellItem.animator = cellItem.go:GetComponent(gohelper.Type_Animator)
	cellItem.rectTr = cellItem.go:GetComponent(gohelper.Type_RectTransform)
	cellItem.image = gohelper.findChildImage(cellItem.go, "areatype/icon")
	cellItem.empty = gohelper.findChildImage(cellItem.go, "areatype/empty")
	cellItem.goImage = cellItem.image.gameObject
	cellItem.goEmpty = cellItem.empty.gameObject

	gohelper.setActive(cellItem.goImage, false)
	gohelper.setActive(cellItem.goEmpty, false)

	cellItem.goLeftEdge = gohelper.findChild(cellItem.go, "areatype/go_edge/go_left/normal")
	cellItem.goRightEdge = gohelper.findChild(cellItem.go, "areatype/go_edge/go_right/normal")
	cellItem.goBottomEdge = gohelper.findChild(cellItem.go, "areatype/go_edge/go_bottom/normal")
	cellItem.goTopEdge = gohelper.findChild(cellItem.go, "areatype/go_edge/go_top/normal")

	gohelper.setActive(cellItem.goLeftEdge, false)
	gohelper.setActive(cellItem.goRightEdge, false)
	gohelper.setActive(cellItem.goBottomEdge, false)
	gohelper.setActive(cellItem.goTopEdge, false)

	cellItem.goLeftEdgeLight = gohelper.findChild(cellItem.go, "areatype/go_edge/go_left/light")
	cellItem.goRightEdgeLight = gohelper.findChild(cellItem.go, "areatype/go_edge/go_right/light")
	cellItem.goBottomEdgeLight = gohelper.findChild(cellItem.go, "areatype/go_edge/go_bottom/light")
	cellItem.goTopEdgeLight = gohelper.findChild(cellItem.go, "areatype/go_edge/go_top/light")

	gohelper.setActive(cellItem.goLeftEdgeLight, false)
	gohelper.setActive(cellItem.goRightEdgeLight, false)
	gohelper.setActive(cellItem.goBottomEdgeLight, false)
	gohelper.setActive(cellItem.goTopEdgeLight, false)

	return cellItem
end

function SnatchAreaGameMapView:onDestroyView()
	return
end

return SnatchAreaGameMapView
