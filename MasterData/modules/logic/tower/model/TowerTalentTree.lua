-- chunkname: @modules/logic/tower/model/TowerTalentTree.lua

module("modules.logic.tower.model.TowerTalentTree", package.seeall)

local TowerTalentTree = class("TowerTalentTree")

function TowerTalentTree:ctor()
	return
end

function TowerTalentTree:initTree(mo, talents)
	self.nodeDict = {}
	self.nodeGroupDict = {}
	self.rootNode = nil
	self.bossMo = mo
	self.talentCount = 0

	if talents then
		for k, v in pairs(talents) do
			local node = self:makeNode(v)

			self.nodeDict[v.nodeId] = node

			if node:isRootNode() then
				self.rootNode = node
			end

			if v.nodeGroup ~= 0 then
				if self.nodeGroupDict[v.nodeGroup] == nil then
					self.nodeGroupDict[v.nodeGroup] = {}
				end

				table.insert(self.nodeGroupDict[v.nodeGroup], v.nodeId)
			end

			self.talentCount = self.talentCount + 1
		end

		for k, v in pairs(talents) do
			self:setNodeParentAndChild(v)
		end
	end
end

function TowerTalentTree:makeNode(config)
	local node = TowerTalentTreeNode.New()

	node:init(config, self)

	return node
end

function TowerTalentTree:setNodeParentAndChild(config)
	local curNode = self:getNode(config.nodeId)
	local list = curNode.isOr and string.splitToNumber(config.preNodeIds, "#") or string.splitToNumber(config.preNodeIds, "&")

	if list then
		for k, v in pairs(list) do
			local preNode = self:getNode(v)

			if preNode then
				curNode:setParent(preNode)
				preNode:setChild(curNode)
			end
		end
	end
end

function TowerTalentTree:getNode(nodeId)
	return self.nodeDict[nodeId]
end

function TowerTalentTree:isActiveTalent(nodeId)
	return self.bossMo:isActiveTalent(nodeId)
end

function TowerTalentTree:isSelectedSystemTalentPlan()
	return self.bossMo:isSelectedSystemTalentPlan()
end

function TowerTalentTree:isActiveGroup(groupId)
	local list = self.nodeGroupDict[groupId]
	local result = false
	local activeId

	if list then
		for k, v in pairs(list) do
			if self:isActiveTalent(v) then
				result = true
				activeId = v

				break
			end
		end
	end

	return result, activeId
end

function TowerTalentTree:getTalentPoint()
	return self.bossMo:getTalentPoint()
end

function TowerTalentTree:getList()
	if not self.nodeList then
		self.nodeList = {}

		for k, v in pairs(self.nodeDict) do
			table.insert(self.nodeList, v)
		end

		if #self.nodeList > 1 then
			table.sort(self.nodeList, SortUtil.keyLower("nodeId"))
		end
	end

	return self.nodeList
end

function TowerTalentTree:hasTalentCanActive()
	for k, v in pairs(self.nodeDict) do
		if v:isTalentCanActive() then
			return true
		end
	end

	return false
end

function TowerTalentTree:getActiveTalentList()
	local nodeList = self:getList()
	local list = {}

	for i, v in ipairs(nodeList) do
		if v:isActiveTalent() then
			table.insert(list, v)
		end
	end

	return list
end

return TowerTalentTree
