-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameMapView.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapView", package.seeall)

local WuErLiXiGameMapView = class("WuErLiXiGameMapView", BaseView)

function WuErLiXiGameMapView:onInitView()
	self._gomaproot = gohelper.findChild(self.viewGO, "#go_maproot")
	self._gonodes = gohelper.findChild(self.viewGO, "#go_maproot/#go_nodes")
	self._gonodeitem = gohelper.findChild(self.viewGO, "#go_maproot/#go_nodes/#scroll_node/viewport/content/#go_nodeitem")
	self._gorays = gohelper.findChild(self.viewGO, "#go_maproot/#go_ray")
	self._gorayitem = gohelper.findChild(self.viewGO, "#go_maproot/#go_ray/#go_rayitem")
	self._gounits = gohelper.findChild(self.viewGO, "#go_maproot/#go_units")
	self._gounititem = gohelper.findChild(self.viewGO, "#go_maproot/#go_units/#go_unititem")
	self._godragitem = gohelper.findChild(self.viewGO, "#go_dragitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WuErLiXiGameMapView:addEvents()
	return
end

function WuErLiXiGameMapView:removeEvents()
	return
end

function WuErLiXiGameMapView:_editableInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_maproot/#go_nodes/#scroll_node/viewport/content")
	self._grid = self._gocontent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	self:_addEvents()
end

function WuErLiXiGameMapView:_addEvents()
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.ActUnitDragEnd, self._onActUnitDragEnd, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeUnitDragEnd, self._onNodeUnitDragEnd, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.UnitDraging, self._onUnitDraging, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeClicked, self._onNodeChange, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, self._onMapReset, self)
	self.addEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.StartGuideDragUnit, self._startGuideDragUnit, self)
end

function WuErLiXiGameMapView:_removeEvents()
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.ActUnitDragEnd, self._onActUnitDragEnd, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeUnitDragEnd, self._onNodeUnitDragEnd, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.UnitDraging, self._onUnitDraging, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.NodeClicked, self._onNodeChange, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, self._onMapReset, self)
	self.removeEventCb(self, WuErLiXiController.instance, WuErLiXiEvent.StartGuideDragUnit, self._startGuideDragUnit, self)
end

function WuErLiXiGameMapView:_startGuideDragUnit(param)
	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	local visible = tonumber(param) == 1

	gohelper.setActive(self._goblock, visible)

	if visible then
		self._dragEffectLoader = PrefabInstantiate.Create(self.viewGO)

		self._dragEffectLoader:startLoad("ui/viewres/guide/guide_wuerlixi.prefab", self._onDragEffectLoaded, self)
	end
end

function WuErLiXiGameMapView:_onDragEffectLoaded()
	local go = self._dragEffectLoader:getInstGO()

	gohelper.setActive(gohelper.findChild(go, "guide1").gameObject, true)
end

function WuErLiXiGameMapView:_onNodeUnitDragEnd(pos, unitMo)
	for _, nodes in pairs(self._nodeItems) do
		for _, node in pairs(nodes) do
			node:showHightLight(false)
			node:showPlaceable(false)
			node:showUnplace(false)
		end
	end

	local nodeMo = self._nodeItems[unitMo.y][unitMo.x]:getNodeMo()
	local unitType = unitMo.unitType
	local unitDir = unitMo.dir
	local targetNodeItems = self:_getTargetNodeItems(pos, unitType, unitDir)

	if not targetNodeItems or #targetNodeItems < 1 then
		WuErLiXiMapModel.instance:addOperation(unitMo.id, unitType, nodeMo.x, nodeMo.y, "Null", "Null")
		WuErLiXiMapModel.instance:clearSelectUnit()
		self._unitItems[unitMo.y][unitMo.x]:destroy()

		self._unitItems[unitMo.y][unitMo.x] = nil

		WuErLiXiMapModel.instance:clearNodeUnit(nodeMo)
		WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaceBack)
		self:_refreshMap()

		return
	elseif unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti and #targetNodeItems < 3 then
		return
	end

	local couldPlace = true

	for _, targetNodeItem in pairs(targetNodeItems) do
		if WuErLiXiMapModel.instance:isNodeHasUnit(targetNodeItem:getNodeMo()) then
			local targetUnitMo = targetNodeItem:getNodeMo():getNodeUnit()

			if targetUnitMo.x ~= unitMo.x or targetUnitMo.y ~= unitMo.y then
				couldPlace = false
			end
		end
	end

	if not couldPlace then
		return
	end

	local targetNodeMo = targetNodeItems[1]:getNodeMo()

	if targetNodeMo.x == nodeMo.x and targetNodeMo.y == nodeMo.y then
		return
	end

	self._unitItems[unitMo.y][unitMo.x]:destroy()

	self._unitItems[unitMo.y][unitMo.x] = nil

	local skipKey = false

	WuErLiXiMapModel.instance:addOperation(unitMo.id, unitType, nodeMo.x, nodeMo.y, targetNodeMo.x, targetNodeMo.y)

	local nodeRay = nodeMo:getNodeRay()
	local targetNodeRay = targetNodeMo:getNodeRay()
	local isActiveSelf = WuErLiXiMapModel.instance:isKeyActiveSelf(unitMo.id, targetNodeMo)

	if not isActiveSelf and nodeRay and unitMo.unitType == WuErLiXiEnum.UnitType.Key then
		if targetNodeRay then
			if targetNodeRay.rayType == WuErLiXiEnum.RayType.SwitchSignal then
				skipKey = true
			end
		elseif nodeRay then
			if (nodeRay.rayDir == WuErLiXiEnum.Dir.Up or nodeRay.rayDir == WuErLiXiEnum.Dir.Down) and nodeMo.x == targetNodeMo.x and nodeMo.y ~= targetNodeMo.y then
				local hasBlockRayUnit = WuErLiXiMapModel.instance:hasBlockRayUnit(nodeMo, targetNodeMo, nodeRay.rayType, nodeRay.rayDir)

				if not hasBlockRayUnit then
					skipKey = true
				end
			end

			if (nodeRay.rayDir == WuErLiXiEnum.Dir.Left or nodeRay.rayDir == WuErLiXiEnum.Dir.Right) and nodeMo.y == targetNodeMo.y and nodeMo.x ~= targetNodeMo.x then
				local hasBlockRayUnit = WuErLiXiMapModel.instance:hasBlockRayUnit(nodeMo, targetNodeMo, nodeRay.rayType, nodeRay.rayDir)

				if not hasBlockRayUnit then
					skipKey = true
				end
			end
		end
	end

	WuErLiXiMapModel.instance:clearNodeUnit(nodeMo, skipKey)
	WuErLiXiMapModel.instance:setNodeUnitByUnitMo(targetNodeMo, unitMo, skipKey)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.PutUnitGuideFinish)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaced)
	self:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_put)

	self._targetUnitItem = self._unitItems[targetNodeMo.y][targetNodeMo.x]

	self._targetUnitItem:showPut(true)
	TaskDispatcher.runDelay(self._resetShowPut, self, 0.7)
end

function WuErLiXiGameMapView:_resetShowPut()
	if self._targetUnitItem then
		self._targetUnitItem:showPut(false)

		self._targetUnitItem = nil
	end

	TaskDispatcher.cancelTask(self._resetShowPut, self)
end

function WuErLiXiGameMapView:_onActUnitDragEnd(pos, actUnitMo)
	for _, nodes in pairs(self._nodeItems) do
		for _, node in pairs(nodes) do
			node:showPlaceable(false)
			node:showHightLight(false)
			node:showUnplace(false)
		end
	end

	local unitType = actUnitMo.type
	local unitDir = actUnitMo.dir
	local targetNodeItems = self:_getTargetNodeItems(pos, unitType, unitDir)

	if not targetNodeItems or #targetNodeItems < 1 then
		return
	end

	local couldPlace = true

	for _, targetNodeItem in pairs(targetNodeItems) do
		local nodeMo = targetNodeItem:getNodeMo()

		if WuErLiXiMapModel.instance:isNodeHasUnit(nodeMo) then
			couldPlace = false
		end
	end

	if not couldPlace then
		return
	end

	WuErLiXiMapModel.instance:setNodeUnitByActUnitMo(targetNodeItems[1]:getNodeMo(), actUnitMo)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.PutUnitGuideFinish)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaced)
	self:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_put)

	local nodeMo = targetNodeItems[1]:getNodeMo()

	WuErLiXiMapModel.instance:addOperation(actUnitMo.id, unitType, "Null", "Null", nodeMo.x, nodeMo.y)

	self._targetUnitItem = self._unitItems[nodeMo.y][nodeMo.x]

	self._targetUnitItem:showPut(true)
	TaskDispatcher.runDelay(self._resetShowPut, self, 0.7)
end

function WuErLiXiGameMapView:_onUnitDraging(pos, mo, type)
	self:_resetShowPut()

	for _, nodes in pairs(self._nodeItems) do
		for _, node in pairs(nodes) do
			node:showHightLight(true)
			node:showUnplace(false)
			node:showPlaceable(false)
		end
	end

	if not mo.dir then
		local unitDir = mo:getNodeUnit().dir
		local targetNodeItems = self:_getTargetNodeItems(pos, type, unitDir)

		if not targetNodeItems or #targetNodeItems < 1 then
			return
		end

		for _, targetNodeItem in pairs(targetNodeItems) do
			local nodeMo = targetNodeItem:getNodeMo()
			local hasUnit = WuErLiXiMapModel.instance:isNodeHasUnit(nodeMo)
			local unitMo = nodeMo:getNodeUnit()

			if mo.x and unitMo then
				::label_12_0::

				local isInitPos = not (mo.x ~= unitMo.x or mo.y ~= unitMo.y)

				targetNodeItem:showUnplace(hasUnit and not isInitPos)
				targetNodeItem:showPlaceable(not hasUnit or isInitPos)
			end
		end
	end
end

function WuErLiXiGameMapView:_getTargetNodeItems(pos, unitType, unitDir)
	local lineCount = WuErLiXiMapModel.instance:getMapLineCount()
	local rowCount = WuErLiXiMapModel.instance:getMapRowCount()
	local items = {}

	for _, nodes in pairs(self._nodeItems) do
		for _, node in pairs(nodes) do
			local posTr = node.go.transform
			local actAnchorPos = recthelper.screenPosToAnchorPos(pos, posTr)

			if math.abs(actAnchorPos.x) * 2 <= recthelper.getWidth(node.go.transform) and math.abs(actAnchorPos.y) * 2 <= recthelper.getHeight(node.go.transform) then
				table.insert(items, node)

				local nodeMo = node:getNodeMo()

				if unitType == WuErLiXiEnum.UnitType.SignalMulti then
					if unitDir == WuErLiXiEnum.Dir.Up or unitDir == WuErLiXiEnum.Dir.Down then
						if nodeMo.x > 1 then
							table.insert(items, self._nodeItems[nodeMo.y][nodeMo.x - 1])
						end

						if rowCount > nodeMo.x then
							table.insert(items, self._nodeItems[nodeMo.y][nodeMo.x + 1])
						end
					else
						if nodeMo.y > 1 then
							table.insert(items, self._nodeItems[nodeMo.y - 1][nodeMo.x])
						end

						if lineCount > nodeMo.y then
							table.insert(items, self._nodeItems[nodeMo.y + 1][nodeMo.x])
						end
					end
				end

				return items
			end
		end
	end

	return items
end

function WuErLiXiGameMapView:_onNodeChange()
	self:_refreshMap()
end

function WuErLiXiGameMapView:_checkMapSuccess()
	local isSuccess = WuErLiXiMapModel.instance:isAllSignalEndActive(self._mapId)

	if not isSuccess then
		return
	end

	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.MapConnectSuccess)
end

function WuErLiXiGameMapView:_onMapReset()
	self:_refreshMap()
end

function WuErLiXiGameMapView:onOpen()
	self._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	self._mapId = WuErLiXiConfig.instance:getEpisodeCo(self._actId, self.viewParam.episodeId).mapId
	self._mapMo = WuErLiXiMapModel.instance:getMap(self._mapId)
	self._nodeItems = {}
	self._rayItems = {}
	self._unitItems = {}

	self:_refreshMap()
end

function WuErLiXiGameMapView:_refreshMap()
	WuErLiXiMapModel.instance:setMapData()
	self:_refreshNodes()
	self:_refreshRays()
	self:_checkMapSuccess()
end

function WuErLiXiGameMapView:_refreshNodes()
	local rowCount = WuErLiXiMapModel.instance:getMapRowCount(self._mapId)
	local mapNodes = WuErLiXiMapModel.instance:getMapNodes(self._mapId)

	for _, nodeMos in pairs(mapNodes) do
		for _, nodeMo in pairs(nodeMos) do
			self._nodeItems[nodeMo.y] = self._nodeItems[nodeMo.y] or {}

			if not self._nodeItems[nodeMo.y][nodeMo.x] then
				self._nodeItems[nodeMo.y][nodeMo.x] = WuErLiXiGameMapNodeItem.New()

				local go = gohelper.cloneInPlace(self._gonodeitem)

				self._nodeItems[nodeMo.y][nodeMo.x]:init(go)
			end

			self._nodeItems[nodeMo.y][nodeMo.x]:setItem(nodeMo)

			if nodeMo.unit and nodeMo.x == nodeMo.unit.x and nodeMo.y == nodeMo.unit.y then
				self._unitItems[nodeMo.y] = self._unitItems[nodeMo.y] or {}

				if not self._unitItems[nodeMo.y][nodeMo.x] then
					self._unitItems[nodeMo.y][nodeMo.x] = WuErLiXiGameMapUnitItem.New()

					local go = gohelper.cloneInPlace(self._gounititem)

					self._unitItems[nodeMo.y][nodeMo.x]:init(go, self._godragitem)
				end

				self._unitItems[nodeMo.y][nodeMo.x]:setItem(nodeMo.unit, self._nodeItems[nodeMo.y][nodeMo.x])
			elseif self._unitItems[nodeMo.y] and self._unitItems[nodeMo.y][nodeMo.x] then
				self._unitItems[nodeMo.y][nodeMo.x]:destroy()

				self._unitItems[nodeMo.y][nodeMo.x] = nil
			end
		end
	end

	self._grid.constraintCount = rowCount
end

function WuErLiXiGameMapView:_refreshRays()
	local existItems = {}
	local rays = WuErLiXiMapModel.instance:getMapRays(self._mapId)

	for index, rayMo in pairs(rays) do
		if not self._rayItems[index] then
			self._rayItems[index] = WuErLiXiGameMapRayItem.New()

			local go = gohelper.cloneInPlace(self._gorayitem)

			self._rayItems[index]:init(go)
			self._rayItems[index]:setItem(rayMo, self._nodeItems[rayMo.startPos[2]][rayMo.startPos[1]], self._nodeItems[rayMo.endPos[2]][rayMo.endPos[1]])
		else
			self._rayItems[index]:resetItem(rayMo, self._nodeItems[rayMo.endPos[2]][rayMo.endPos[1]])
		end

		existItems[index] = true
	end

	for index, item in pairs(self._rayItems) do
		if not existItems[index] then
			item:hide()
		end
	end
end

function WuErLiXiGameMapView:onClose()
	TaskDispatcher.cancelTask(self._refreshRaysAndUnits, self)
end

function WuErLiXiGameMapView:onDestroyView()
	self:_removeEvents()

	for _, items in pairs(self._unitItems) do
		for _, item in pairs(items) do
			item:destroy()
		end
	end

	for _, item in pairs(self._rayItems) do
		item:destroy()
	end

	for _, items in pairs(self._nodeItems) do
		for _, item in pairs(items) do
			item:destroy()
		end
	end
end

return WuErLiXiGameMapView
