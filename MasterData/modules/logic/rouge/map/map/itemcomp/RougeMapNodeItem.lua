-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapNodeItem.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapNodeItem", package.seeall)

local RougeMapNodeItem = class("RougeMapNodeItem", RougeMapBaseItem)

function RougeMapNodeItem:init(nodeMo, map, episodeItem)
	RougeMapNodeItem.super.init(self)

	self.episodeItem = episodeItem
	self.posType = episodeItem.posType
	self.parentGo = episodeItem.go
	self.nodeMo = nodeMo
	self.map = map
	self.nodeId = self.nodeMo.nodeId
	self.select = false

	self:updateData()
	self:setId(self.nodeMo.nodeId)
	self:createGo()
	self:createNodeBg()
	self:createIcon()
	self:checkNodeFog()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectNode, self.onSelectNode, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self.onCloseFullView, self)
end

function RougeMapNodeItem:updateData()
	self.eventId = self.nodeMo.eventId
	self.eventCo = self.nodeMo:getEventCo()
	self.arriveStatus = self.nodeMo.arriveStatus
end

function RougeMapNodeItem:createGo()
	self.go = gohelper.create3d(self.parentGo, self.nodeId)
	self.tr = self.go:GetComponent(gohelper.Type_Transform)

	local localX, localY, localZ = RougeMapHelper.getNodeLocalPos(self.nodeMo.index, self.posType)

	self.nodeMo:setPos(localX, localY, localZ)
	transformhelper.setLocalPos(self.tr, localX, localY, localZ)
end

function RougeMapNodeItem:createNodeBg()
	local prefab, offset

	if self.nodeMo:checkIsNormal() then
		prefab = self.map:getNodeBgPrefab(self.eventCo, self.arriveStatus)
		offset = RougeMapEnum.NodeBgOffset[self.arriveStatus]
	else
		prefab = self.map.startBgPrefab
		offset = RougeMapEnum.StartBgOffset
	end

	self.nodeBgGo = gohelper.clone(prefab, self.go, "bg")
	self.nodeBgTr = self.nodeBgGo:GetComponent(gohelper.Type_Transform)
	self.nodeBgAnimator = self.nodeBgGo:GetComponent(gohelper.Type_Animator)
	self.nodeBgAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.nodeBgGo)

	transformhelper.setLocalScale(self.nodeBgTr, RougeMapEnum.Scale.NodeBg, RougeMapEnum.Scale.NodeBg, 1)
	transformhelper.setLocalPos(self.nodeBgTr, offset.x, offset.y, self:getBgOffsetZ())
	self:playNodeBgAnim("open")
end

function RougeMapNodeItem:createIcon()
	if self.nodeMo:checkIsNormal() then
		local prefab = self.map:getNodeIconPrefab(self.eventCo)

		self.iconGo = gohelper.clone(prefab, self.go, "icon")
		self.iconTr = self.iconGo:GetComponent(gohelper.Type_Transform)
		self.iconAnimator = self.iconGo:GetComponent(gohelper.Type_Animator)
		self.iconAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.iconGo)

		transformhelper.setLocalScale(self.iconTr, RougeMapEnum.Scale.Icon, RougeMapEnum.Scale.Icon, 1)
		self:updateIconPos()

		if self.arriveStatus == RougeMapEnum.Arrive.CantArrive then
			self:playIconAnim("overdue")
		else
			self:playIconAnim("open")
		end
	else
		self.iconGo = nil
		self.iconTr = nil
		self.iconAnimator = nil
	end
end

function RougeMapNodeItem:updateIconPos()
	if self.eventCo then
		local offset = RougeMapEnum.IconOffset[self.arriveStatus]

		transformhelper.setLocalPos(self.iconTr, offset.x, offset.y, self:getIconOffsetZ())
	end
end

function RougeMapNodeItem:getIconOffsetZ()
	return self:getBgOffsetZ() - RougeMapEnum.NodeIconOffsetZInterval
end

function RougeMapNodeItem:getBgOffsetZ()
	return -(self.nodeMo.index - 1) * (RougeMapEnum.NodeOffsetZInterval + RougeMapEnum.NodeIconOffsetZInterval)
end

function RougeMapNodeItem:getScenePos()
	return self.nodeBgTr.position
end

function RougeMapNodeItem:getMapPos()
	local x, y, z = RougeMapHelper.getNodeContainerPos(self.nodeMo.episodeId, self.nodeMo:getEpisodePos())

	return x, y, z
end

function RougeMapNodeItem:getActorPos()
	local x, y, z = self:getMapPos()

	return RougeMapEnum.ActorOffset.x + x, RougeMapEnum.ActorOffset.y + y, z
end

function RougeMapNodeItem:getClickArea()
	if not self.nodeMo:checkIsNormal() then
		return RougeMapEnum.StartClickArea
	end

	return RougeMapEnum.ClickArea[self.arriveStatus]
end

function RougeMapNodeItem:onClick()
	logNormal(string.format("on click node id : %s, arrive status : %s", self.nodeId, self.arriveStatus))

	if self.arriveStatus == RougeMapEnum.Arrive.CantArrive or self.arriveStatus == RougeMapEnum.Arrive.NotArrive or self.arriveStatus == RougeMapEnum.Arrive.ArrivingFinish or self.arriveStatus == RougeMapEnum.Arrive.Arrived then
		return
	end

	if not self.eventCo then
		return
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, self.nodeMo)
end

function RougeMapNodeItem:updateNode()
	self.arriveStatus = self:getArriveStatus()

	self:checkNodeFog()

	if self.fog then
		return
	end

	if self.nodeBgAnimator then
		self:playNodeBgAnim("close", self._updateNodeBg)
	else
		self:_updateNodeBg()
	end

	if self.iconAnimator then
		self:playIconAnim("close", self._updateIcon)
	else
		self:_updateIcon()
	end
end

function RougeMapNodeItem:_updateNodeBg()
	gohelper.destroy(self.nodeBgGo)
	self:createNodeBg()
end

function RougeMapNodeItem:_updateIcon()
	gohelper.destroy(self.iconGo)
	self:createIcon()
end

function RougeMapNodeItem:onUpdateMapInfo()
	if not RougeMapHelper.checkMapViewOnTop() then
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

	local fogChange = self.fog ~= self.nodeMo.fog

	if fogChange then
		self:updateNode()

		return
	end
end

function RougeMapNodeItem:getArriveStatus()
	if self.select then
		return RougeMapEnum.NodeSelectArriveStatus
	end

	return self.nodeMo.arriveStatus
end

function RougeMapNodeItem:checkNodeFog()
	self.fog = self.nodeMo.fog

	gohelper.setActive(self.go, not self.fog)
end

function RougeMapNodeItem:onSelectNode(nodeMo)
	local select = nodeMo == self.nodeMo

	if self.select == select then
		return
	end

	self.select = select

	local arriveStatusChange = self.arriveStatus ~= self:getArriveStatus()

	if arriveStatusChange then
		self:updateNode()
	end

	if self.select then
		AudioMgr.instance:trigger(AudioEnum.UI.SelectNode)
	end
end

function RougeMapNodeItem:onCloseViewFinish(viewName)
	if self.waitUpdate then
		self:onUpdateMapInfo()
		self:checkNodeFog()
	end
end

function RougeMapNodeItem:onCloseFullView()
	if not self.playingBgAnim and self.nodeBgAnimator then
		self.nodeBgAnimator:Play("idle", 0, 1)
	end

	if not self.playingIconAnim and self.iconAnimator then
		if self.arriveStatus == RougeMapEnum.Arrive.CantArrive then
			self.iconAnimator:Play("overdue", 0, 1)
		else
			self.iconAnimator:Play("idle", 0, 1)
		end
	end
end

function RougeMapNodeItem:setLineItem(lineItem)
	self.lineItem = lineItem
end

function RougeMapNodeItem:getLineItem()
	return self.lineItem
end

function RougeMapNodeItem:playNodeBgAnim(animName, doneCallback)
	if not self.nodeBgAnimator then
		return
	end

	self.playingBgAnim = true

	self.nodeBgAnimatorPlayer:Play(animName, doneCallback or self.disableNodeBgAnimator, self)
end

function RougeMapNodeItem:playIconAnim(animName, doneCallback)
	if not self.iconAnimator then
		return
	end

	self.playingIconAnim = true

	self.iconAnimatorPlayer:Play(animName, doneCallback or self.disableIconAnimator, self)
end

function RougeMapNodeItem:disableNodeBgAnimator()
	if self.nodeBgAnimator then
		self.playingBgAnim = false
	end
end

function RougeMapNodeItem:disableIconAnimator()
	if self.iconAnimator then
		self.playingIconAnim = false
	end
end

function RougeMapNodeItem:destroy()
	if self.nodeBgAnimatorPlayer then
		self.nodeBgAnimatorPlayer:Stop()
	end

	if self.iconAnimatorPlayer then
		self.iconAnimatorPlayer:Stop()
	end

	RougeMapNodeItem.super.destroy(self)
end

return RougeMapNodeItem
