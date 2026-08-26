-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapNodeItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapNodeItem", package.seeall)

local Rouge2_MapNodeItem = class("Rouge2_MapNodeItem", Rouge2_MapBaseItem)

function Rouge2_MapNodeItem:init(nodeMo, map, episodeItem)
	Rouge2_MapNodeItem.super.init(self)

	self.episodeItem = episodeItem
	self.posType = episodeItem.posType
	self.episodeIndex = episodeItem.index
	self.parentGo = episodeItem.go
	self.nodeMo = nodeMo
	self.nodeIndex = nodeMo.index
	self.map = map
	self.iconCanvas = self.map.nodeIconCanvas
	self.nodeId = self.nodeMo.nodeId
	self.select = false

	self:updateData()
	self:setId(self.nodeMo.nodeId)
	self:createGo()
	self:createIcon()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectNode, self.onSelectNode, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function Rouge2_MapNodeItem:updateData()
	self.eventId = self.nodeMo.eventId
	self.eventCo = self.nodeMo:getEventCo()
	self.arriveStatus = self.nodeMo.arriveStatus
end

function Rouge2_MapNodeItem:createGo()
	self.go = gohelper.create3d(self.parentGo, self.nodeId)
	self.tr = self.go:GetComponent(gohelper.Type_Transform)

	local localX, localY, localZ = Rouge2_MapHelper.getNodeLocalPos(self.nodeMo.layer, self.posType, self.episodeIndex, self.nodeIndex)

	self.nodeMo:setPos(localX, localY, localZ)
	transformhelper.setLocalPos(self.tr, localX, localY, localZ)
end

function Rouge2_MapNodeItem:createIcon()
	self.iconItem = self.iconCanvas:getOrCreateNodeIconItem(self.nodeId)

	self.iconItem:onUpdateMO(self.nodeMo, self)
end

function Rouge2_MapNodeItem:getScenePos()
	return self.tr.position
end

function Rouge2_MapNodeItem:getMapPos()
	local x, y, z = Rouge2_MapHelper.getNodeContainerPos(self.nodeMo.episodeId, self.nodeMo:getEpisodePos())

	return x, y, z
end

function Rouge2_MapNodeItem:getActorPos()
	local x, y, z = self:getMapPos()

	return Rouge2_MapEnum.ActorOffset.x + x, Rouge2_MapEnum.ActorOffset.y + y, z
end

function Rouge2_MapNodeItem:getClickArea()
	if not self.nodeMo:checkIsNormal() then
		return Rouge2_MapEnum.StartClickArea
	end

	return Rouge2_MapEnum.ClickArea[self.arriveStatus]
end

function Rouge2_MapNodeItem:onClick()
	logNormal(string.format("on click node id : %s, arrive status : %s", self.nodeId, self.arriveStatus))

	if self.arriveStatus == Rouge2_MapEnum.Arrive.CantArrive or self.arriveStatus == Rouge2_MapEnum.Arrive.NotArrive or self.arriveStatus == Rouge2_MapEnum.Arrive.ArrivingFinish or self.arriveStatus == Rouge2_MapEnum.Arrive.Arrived then
		return
	end

	if not self.eventCo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.ClickEvent)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectNode, self.nodeMo)
end

function Rouge2_MapNodeItem:onUpdateMapInfo()
	if not Rouge2_MapHelper.checkMapViewOnTop() then
		self.waitUpdate = true

		return
	end

	self.waitUpdate = nil

	local eventChange = self.eventId ~= self.nodeMo.eventId

	if eventChange then
		self.eventId = self.nodeMo.eventId
		self.eventCo = self.nodeMo:getEventCo()

		self:updateNode()

		return
	end

	local arriveStatusChange = self.arriveStatus ~= self:getArriveStatus()

	if arriveStatusChange then
		self:updateNode()

		return
	end
end

function Rouge2_MapNodeItem:getArriveStatus()
	if self.select then
		return Rouge2_MapEnum.NodeSelectArriveStatus
	end

	return self.nodeMo.arriveStatus
end

function Rouge2_MapNodeItem:onSelectNode(nodeMo)
	local select = nodeMo == self.nodeMo

	if self.select == select then
		return
	end

	self.select = select

	self.iconItem:onSelect(select)

	local arriveStatusChange = self.arriveStatus ~= self:getArriveStatus()

	if arriveStatusChange then
		self:updateNode()
	end
end

function Rouge2_MapNodeItem:updateNode()
	self.arriveStatus = self:getArriveStatus()

	self.iconItem:onUpdateMO(self.nodeMo, self)
end

function Rouge2_MapNodeItem:getIconGO()
	return self.iconItem and self.iconItem:getIconGO()
end

function Rouge2_MapNodeItem:onCloseViewFinish(viewName)
	if self.waitUpdate then
		self:onUpdateMapInfo()
	end
end

function Rouge2_MapNodeItem:setLineItem(lineItem)
	self.lineItem = lineItem
end

function Rouge2_MapNodeItem:getLineItem()
	return self.lineItem
end

function Rouge2_MapNodeItem:destroy()
	Rouge2_MapNodeItem.super.destroy(self)
end

return Rouge2_MapNodeItem
