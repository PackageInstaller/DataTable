-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentTreeView.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTreeView", package.seeall)

local TowerAssistBossTalentTreeView = class("TowerAssistBossTalentTreeView", BaseView)

function TowerAssistBossTalentTreeView:onInitView()
	self.goNode = gohelper.findChild(self.viewGO, "Scroll/Viewport/Tree/node/#goNode")
	self.goLine = gohelper.findChild(self.viewGO, "Scroll/Viewport/Tree/line/#goLine")
	self.nodeItems = {}
	self.lineItems = {}
	self.tempVect2 = Vector2(0, 0)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossTalentTreeView:addEvents()
	self.addEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.SelectTalentItem, self._onSelectTalentItem, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self._onRefreshTalent, self)
end

function TowerAssistBossTalentTreeView:removeEvents()
	self.removeEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.SelectTalentItem, self._onSelectTalentItem, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self._onRefreshTalent, self)
end

function TowerAssistBossTalentTreeView:_editableInitView()
	return
end

function TowerAssistBossTalentTreeView:_onResetTalent(talentId)
	self:refreshView()
end

function TowerAssistBossTalentTreeView:_onActiveTalent(talentId)
	self:playNodeLightingAnim(talentId)
end

function TowerAssistBossTalentTreeView:_onSelectTalentItem()
	for k, v in pairs(self.nodeItems) do
		v:refreshSelect()
	end
end

function TowerAssistBossTalentTreeView:_onRefreshTalent()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossTalentTreeView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossTalentTreeView:onOpen()
	self:refreshParam()
	TowerAssistBossTalentListModel.instance:initBoss(self.bossId)
	self:refreshView()
end

function TowerAssistBossTalentTreeView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getBoss(self.bossId)
	self.talentTree = self.bossMo:getTalentTree()
end

function TowerAssistBossTalentTreeView:refreshView()
	self:refreshTree()
end

function TowerAssistBossTalentTreeView:refreshTree()
	local list = self.talentTree:getList()

	for i, v in ipairs(list) do
		self:updateNode(v)
	end

	for i, v in pairs(self.nodeItems) do
		local parents = v._mo:getParents()

		for _, parentNode in pairs(parents) do
			if not parentNode:isRootNode() then
				self:updateLineItem(v._mo.nodeId, parentNode.nodeId)
			end
		end
	end
end

function TowerAssistBossTalentTreeView:updateNode(node)
	local item = self:getNodeItem(node.id)

	item:onUpdateMO(node)
end

function TowerAssistBossTalentTreeView:getNodeItem(nodeId)
	if not self.nodeItems[nodeId] then
		local go = gohelper.cloneInPlace(self.goNode, tostring(nodeId))

		self.nodeItems[nodeId] = MonoHelper.addNoUpdateLuaComOnceToGo(go, TowerAssistBossTalentItem)
	end

	return self.nodeItems[nodeId]
end

function TowerAssistBossTalentTreeView:updateLineItem(nodeId, preNodeId)
	local lineItem = self:getLineItem(nodeId, preNodeId)
	local talentNode = self.talentTree:getNode(nodeId)
	local preNode = self.talentTree:getNode(preNodeId)
	local isActive = talentNode:isActiveTalent()
	local isActiveGroup = talentNode:isActiveGroup()
	local isParentActive = talentNode:isParentActive()
	local isPreActive = preNode:isActiveTalent()
	local isSelectedSystemTalentPlan = self.talentTree:isSelectedSystemTalentPlan()
	local canActive = not isActive and not isActiveGroup and isParentActive and isPreActive

	if canActive and not isSelectedSystemTalentPlan then
		if lineItem.isGray then
			lineItem.anim:Play("tocanlight")
		else
			lineItem.anim:Play("canlight")
		end
	elseif isActive and isPreActive then
		lineItem.anim:Play("lighted")
	else
		lineItem.anim:Play("gray")
	end

	lineItem.isGray = not canActive and not isActive and not isParentActive
	lineItem.isActive = isActive and isParentActive

	self:updateLineItemPos(lineItem, nodeId, preNodeId)

	return lineItem
end

function TowerAssistBossTalentTreeView:updateLineItemPos(lineItem, nodeId, preNodeId)
	local nodeItem = self.nodeItems[nodeId]
	local preNodeItem = self.nodeItems[preNodeId]
	local posX, posY = nodeItem:getLocalPos()
	local initPos = nodeItem.transform.anchoredPosition
	local prePos = preNodeItem.transform.anchoredPosition
	local width = nodeItem:getWidth()
	local preWidth = preNodeItem:getWidth()
	local lineWidth = Vector2.Distance(prePos, initPos)

	self.tempVect2:Set(initPos.x - prePos.x, initPos.y - prePos.y)

	local offsetPos = self.tempVect2
	local linePos = (initPos + prePos) * 0.5

	recthelper.setAnchor(lineItem.transform, linePos.x, linePos.y)
	recthelper.setHeight(lineItem.imgLine.transform, lineWidth)
	recthelper.setHeight(lineItem.imgLine1.transform, lineWidth)

	local angle = Mathf.Atan2(offsetPos.y, offsetPos.x) * Mathf.Rad2Deg - 90

	transformhelper.setLocalRotation(lineItem.transform, 0, 0, angle)
end

function TowerAssistBossTalentTreeView:getLineItem(nodeId, preNodeId)
	local key = string.format("%s_%s", nodeId, preNodeId)

	if not self.lineItems[key] then
		local go = gohelper.cloneInPlace(self.goLine, key)
		local item = self:getUserDataTb_()

		item.key = key
		item.go = go
		item.transform = go.transform
		item.imgLine = gohelper.findChildImage(go, "#go_Line")
		item.imgLine1 = gohelper.findChildImage(go, "Line1")
		item.anim = go:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(go, true)

		self.lineItems[key] = item
	end

	return self.lineItems[key]
end

function TowerAssistBossTalentTreeView:playNodeLightingAnim(nodeId)
	local node = self.talentTree:getNode(nodeId)

	if not node then
		return
	end

	UIBlockMgr.instance:startBlock("playNodeLightingAnim")

	local activeLines = {}
	local parents = node:getParents()

	for _, parent in pairs(parents) do
		if parent:isActiveTalent() then
			local key = string.format("%s_%s", nodeId, parent.nodeId)
			local line = self.lineItems[key]

			if line and not line.isActive then
				table.insert(activeLines, line)
			end
		end
	end

	local childs = node.childs

	for _, child in pairs(childs) do
		if child:isActiveTalent() then
			local key = string.format("%s_%s", child.nodeId, nodeId)
			local line = self.lineItems[key]

			if line and not line.isActive then
				table.insert(activeLines, line)
			end
		end
	end

	for _, line in ipairs(activeLines) do
		line.isActive = true

		line.anim:Play("lighting")
	end

	if #activeLines > 0 then
		self.lightingNodeId = nodeId

		TaskDispatcher.runDelay(self.delayLightNode, self, 0.5)
	else
		self:_lightingNode(nodeId)
	end
end

function TowerAssistBossTalentTreeView:delayLightNode()
	self:_lightingNode(self.lightingNodeId)
end

function TowerAssistBossTalentTreeView:_lightingNode(nodeId)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")

	self.lightingNodeId = nil

	local nodeItem = self.nodeItems[nodeId]

	if nodeItem then
		nodeItem:playLightingAnim()
	end

	self:delayRefreshView()
end

function TowerAssistBossTalentTreeView:delayRefreshView()
	TaskDispatcher.cancelTask(self.refreshView, self)
	TaskDispatcher.runDelay(self.refreshView, self, 0.5)
end

function TowerAssistBossTalentTreeView:onClose()
	return
end

function TowerAssistBossTalentTreeView:onDestroyView()
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")
	TaskDispatcher.cancelTask(self.delayLightNode, self)
	TaskDispatcher.cancelTask(self.refreshView, self)
end

return TowerAssistBossTalentTreeView
