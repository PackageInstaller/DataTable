-- chunkname: @modules/logic/tower/model/TowerTalentTreeNode.lua

module("modules.logic.tower.model.TowerTalentTreeNode", package.seeall)

local TowerTalentTreeNode = class("TowerTalentTreeNode")

function TowerTalentTreeNode:ctor()
	self.parents = {}
	self.childs = {}
end

function TowerTalentTreeNode:init(config, tree)
	self.tree = tree
	self.nodeId = config.nodeId
	self.id = self.nodeId
	self.config = config
	self.isOr = not string.find(config.preNodeIds, "&")
end

function TowerTalentTreeNode:isRootNode()
	return self.config.startNode == 1
end

function TowerTalentTreeNode:setParent(parent)
	self.parents[parent.nodeId] = parent
end

function TowerTalentTreeNode:getParents()
	return self.parents
end

function TowerTalentTreeNode:setChild(child)
	self.childs[child.nodeId] = child
end

function TowerTalentTreeNode:isActiveTalent()
	return self.tree:isActiveTalent(self.nodeId)
end

function TowerTalentTreeNode:isSelectedSystemTalentPlan()
	return self.tree:isSelectedSystemTalentPlan()
end

function TowerTalentTreeNode:isParentActive()
	local active

	if self.isOr then
		for k, v in pairs(self.parents) do
			if v:isActiveTalent() then
				active = true

				break
			else
				active = false
			end
		end
	else
		for k, v in pairs(self.parents) do
			if not v:isActiveTalent() then
				active = false

				break
			end
		end
	end

	if active == nil then
		active = true
	end

	return active
end

function TowerTalentTreeNode:getParentActiveResult()
	local result = 2

	if self.isOr then
		for k, v in pairs(self.parents) do
			if v:isActiveTalent() then
				result = 2

				break
			else
				result = 0
			end
		end
	else
		local parentCount = 0
		local activeCount = 0

		for k, v in pairs(self.parents) do
			if v:isActiveTalent() then
				activeCount = activeCount + 1
			end

			parentCount = parentCount + 1
		end

		if parentCount > 0 then
			result = parentCount <= activeCount and 2 or activeCount == 0 and 0 or 1
		end
	end

	return result
end

function TowerTalentTreeNode:isTalentCanActive()
	return self:isParentActive() and self:isTalentConsumeEnough()
end

function TowerTalentTreeNode:isTalentConsumeEnough()
	local talentPoint = self.tree:getTalentPoint()
	local consume = self.config.consume

	return consume <= talentPoint
end

function TowerTalentTreeNode:isActiveGroup()
	return self.tree:isActiveGroup(self.config.nodeGroup)
end

function TowerTalentTreeNode:isLeafNode()
	for k, v in pairs(self.childs) do
		if v:isActiveTalent() then
			return false
		end
	end

	return true
end

return TowerTalentTreeNode
