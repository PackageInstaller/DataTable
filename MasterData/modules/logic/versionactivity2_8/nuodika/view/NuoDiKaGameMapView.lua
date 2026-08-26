-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameMapView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameMapView", package.seeall)

local NuoDiKaGameMapView = class("NuoDiKaGameMapView", BaseView)

function NuoDiKaGameMapView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_map")
	self._gonodeItem = gohelper.findChild(self.viewGO, "#go_map/#go_nodeItem")
	self._gocontenttop = gohelper.findChild(self.viewGO, "#go_maptop")
	self._gonodeTopItem = gohelper.findChild(self.viewGO, "#go_maptop/#go_nodetopItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaGameMapView:addEvents()
	return
end

function NuoDiKaGameMapView:removeEvents()
	return
end

function NuoDiKaGameMapView:_editableInitView()
	self._grid = self._gocontent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	self._topGrid = self._gocontenttop:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	gohelper.setActive(self._gonodeItem, false)
	gohelper.setActive(self._gonodeTopItem, false)
	self:_addEvents()
end

function NuoDiKaGameMapView:_addEvents()
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDraging, self._onNodeUnitDraging, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDragEnd, self._onNodeUnitDragEnd, self)
	self.addEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.MapRefresh, self._onRefreshMap, self)
end

function NuoDiKaGameMapView:_removeEvents()
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDraging, self._onNodeUnitDraging, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDragEnd, self._onNodeUnitDragEnd, self)
	self.removeEventCb(self, NuoDiKaController.instance, NuoDiKaEvent.MapRefresh, self._onRefreshMap, self)
end

function NuoDiKaGameMapView:_onRefreshMap()
	self:_refreshMap()
end

function NuoDiKaGameMapView:_getTargetNodeItem(pos)
	for _, node in pairs(self._nodeItems) do
		local mainCamera = CameraMgr.instance:getUICamera()
		local refPos = self.viewGO.transform.position
		local pos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pos, mainCamera, refPos)
		local posTr = node:getNodeRoot().transform
		local collider2D = gohelper.findChild(posTr.gameObject, "btn_node"):GetComponent(typeof(UnityEngine.Collider2D))
		local isOverlapPoint = collider2D and collider2D:OverlapPoint(pos)

		if isOverlapPoint then
			return node
		end
	end

	return nil
end

function NuoDiKaGameMapView:_onNodeUnitDraging(pos, nodeMo)
	for _, node in pairs(self._nodeItems) do
		node:showPlaceable(false)
		node:showDamage(false)
	end

	if not nodeMo or not nodeMo:isNodeHasItem() then
		return
	end

	local itemCo = NuoDiKaConfig.instance:getItemCo(nodeMo:getEvent().eventParam)

	if itemCo.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local targetNodeItem = self:_getTargetNodeItem(pos)
	local isPlaceble = targetNodeItem

	if targetNodeItem then
		local targetNodeMo = targetNodeItem:getNodeMo()

		if itemCo.canEmpty == NuoDiKaEnum.ItemPlaceType.AllEnemy then
			isPlaceble = isPlaceble and isPlaceble and targetNodeMo:isNodeUnlock() and targetNodeMo:isNodeHasEnemy()
		end
	end

	if not isPlaceble then
		for _, node in pairs(self._nodeItems) do
			local curNodeMo = node:getNodeMo()

			if itemCo.canEmpty == NuoDiKaEnum.ItemPlaceType.AllEnemy then
				if curNodeMo:isNodeUnlock() and curNodeMo:isNodeHasEnemy() then
					node:showPlaceable(true)
				end
			elseif itemCo.canEmpty == NuoDiKaEnum.ItemPlaceType.AllNode then
				node:showPlaceable(true)
			end
		end

		return
	end

	local itemCo = NuoDiKaConfig.instance:getItemCo(nodeMo:getEvent().eventParam)
	local skillCo = NuoDiKaConfig.instance:getSkillCo(itemCo.skillID)
	local scales = string.splitToNumber(skillCo.scale, "#")
	local rangeType = scales[1]

	if rangeType == NuoDiKaEnum.TriggerRangeType.TargetNode then
		targetNodeItem:showDamage(true)
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		if not scales[2] then
			local scale = 0
			local targetNodeMo = targetNodeItem:getNodeMo()

			for _, node in pairs(self._nodeItems) do
				local curNodeMo = node:getNodeMo()

				if scale >= math.abs(targetNodeMo.y - curNodeMo.y) + math.abs(targetNodeMo.x - curNodeMo.x) then
					node:showDamage(true)
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.SquareLength then
		if not scales[2] then
			local scale = 0
			local targetNodeMo = targetNodeItem:getNodeMo()

			for _, node in pairs(self._nodeItems) do
				local curNodeMo = node:getNodeMo()

				if scale >= math.abs(targetNodeMo.y - curNodeMo.y) and scale >= math.abs(targetNodeMo.x - curNodeMo.x) then
					node:showDamage(true)
				end
			end
		end
	elseif rangeType == NuoDiKaEnum.TriggerRangeType.All then
		for _, node in pairs(self._nodeItems) do
			node:showDamage(true)
		end
	end
end

function NuoDiKaGameMapView:_onNodeUnitDragEnd(pos, nodeMo)
	for _, node in pairs(self._nodeItems) do
		node:showPlaceable(false)
		node:showDamage(false)
	end

	if not nodeMo or not nodeMo:isNodeHasItem() then
		return
	end

	local itemCo = NuoDiKaConfig.instance:getItemCo(nodeMo:getEvent().eventParam)

	if itemCo.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local targetNodeItem = self:_getTargetNodeItem(pos)

	if not targetNodeItem then
		return
	end

	local targetNodeMo = targetNodeItem:getNodeMo()

	if itemCo.canEmpty == NuoDiKaEnum.ItemPlaceType.AllEnemy and (not targetNodeMo:isNodeUnlock() or not targetNodeMo:isNodeHasEnemy()) then
		return
	end

	local isInitPos = nodeMo.x == targetNodeMo.x and nodeMo.y == targetNodeMo.y

	if isInitPos then
		return
	end

	local eventCo = nodeMo:getEvent()

	if eventCo and eventCo.eventParam == 2005 then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ShowItemScan, targetNodeMo)
	end

	local skillId = NuoDiKaConfig.instance:getItemCo(eventCo.eventParam).skillID
	local skillCo = NuoDiKaConfig.instance:getSkillCo(skillId)

	if tonumber(skillCo.trigger) == NuoDiKaEnum.TriggerTimingType.Interact and (skillCo.effect == NuoDiKaEnum.SkillType.AttackSelected or skillCo.effect == NuoDiKaEnum.SkillType.AttackRandom or skillCo.effect == NuoDiKaEnum.SkillType.AttackAll) then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
	end

	NuoDiKaMapModel.instance:setCurSelectNode(targetNodeMo.id)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemStartSkill, targetNodeMo, nodeMo)
end

function NuoDiKaGameMapView:_checkMapSuccess()
	if self._mapMo.passType == NuoDiKaEnum.MapPassType.ClearEnemy then
		if NuoDiKaMapModel.instance:isAllEnemyDead(self._mapId) then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.GameSuccess)
		end
	elseif self._mapMo.passType == NuoDiKaEnum.MapPassType.UnlockItem then
		local unlockItemNodeMo = NuoDiKaMapModel.instance:isSpEventUnlock(self._mapId)

		if unlockItemNodeMo then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.GameItemUnlockSuccess, unlockItemNodeMo)
		end
	end
end

function NuoDiKaGameMapView:onOpen()
	self._actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	self._mapId = NuoDiKaConfig.instance:getEpisodeCo(self._actId, self.viewParam.episodeId).mapId
	self._mapMo = NuoDiKaMapModel.instance:getMap(self._mapId)

	local nodeMos = NuoDiKaMapModel.instance:getStartNodes(self._mapId)

	NuoDiKaMapModel.instance:setCurSelectNode(nodeMos[1].id)

	self._nodeItems = {}

	self:_refreshMap()
end

function NuoDiKaGameMapView:_refreshMap()
	self:_refreshNodes()
	self:_checkMapSuccess()
end

function NuoDiKaGameMapView:_refreshNodes()
	local rowCount = NuoDiKaMapModel.instance:getMapRowCount(self._mapId)
	local lineCount = NuoDiKaMapModel.instance:getMapLineCount(self._mapId)
	local mapNodes = NuoDiKaMapModel.instance:getMapNodes(self._mapId)

	for _, nodeMo in ipairs(mapNodes) do
		if not self._nodeItems[nodeMo.id] then
			self._nodeItems[nodeMo.id] = NuoDiKaGameMapNodeItem.New()

			local go = gohelper.cloneInPlace(self._gonodeItem)
			local topGo = gohelper.cloneInPlace(self._gonodeTopItem)

			self._nodeItems[nodeMo.id]:init(go, topGo)
		end

		local offsetX = (nodeMo.y - 0.5 * (lineCount + 1)) * NuoDiKaEnum.OnLineOffsetX
		local offsetY = (nodeMo.y - 0.5 * (lineCount + 1)) * NuoDiKaEnum.OnLineOffsetY

		self._nodeItems[nodeMo.id]:setNodeOffset(offsetX, offsetY)
		self._nodeItems[nodeMo.id]:setItem(nodeMo)
	end

	self._grid.constraintCount = rowCount
	self._topGrid.constraintCount = rowCount
end

function NuoDiKaGameMapView:onClose()
	NuoDiKaMapModel.instance:resetNode(self._mapId)
end

function NuoDiKaGameMapView:onDestroyView()
	self:_removeEvents()

	for _, item in pairs(self._nodeItems) do
		item:destroy()
	end
end

return NuoDiKaGameMapView
