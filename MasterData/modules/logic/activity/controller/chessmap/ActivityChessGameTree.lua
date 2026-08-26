-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessGameTree.lua

module("modules.logic.activity.controller.chessmap.ActivityChessGameTree", package.seeall)

local ActivityChessGameTree = class("ActivityChessGameTree")

ActivityChessGameTree.MaxBucket = 9

function ActivityChessGameTree:buildTree(root)
	self.allNodes = {}

	local maxRecursion = 50
	local waitingList = {
		root
	}
	local curStep = 1

	while #waitingList > 0 and curStep <= maxRecursion do
		curStep = curStep + 1

		if maxRecursion < curStep then
			logError("max exclusive !")

			break
		end

		local curNode = table.remove(waitingList)

		table.insert(self.allNodes, curNode)

		for _, node in pairs(curNode.nodes) do
			self:processChildNode(curNode, node, node.x, node.y, true)
			self:processChildNode(curNode, node, node.x - ActivityChessEnum.ClickRangeX, node.y)
			self:processChildNode(curNode, node, node.x + ActivityChessEnum.ClickRangeX, node.y)
			self:processChildNode(curNode, node, node.x, node.y - ActivityChessEnum.ClickRangeY)
			self:processChildNode(curNode, node, node.x, node.y + ActivityChessEnum.ClickRangeY)
		end

		for i = 1, 4 do
			local child = curNode.children[i]

			if #child.nodes > ActivityChessGameTree.MaxBucket then
				self:growToBranch(child)
				table.insert(waitingList, child)
			end
		end
	end

	logNormal("build tree in " .. tostring(curStep))

	self.root = root
end

function ActivityChessGameTree:processChildNode(curNode, node, x, y)
	local fixChild = self:getFixNode(curNode, x, y)

	if not fixChild.keys[node] then
		table.insert(fixChild.nodes, node)
		table.insert(fixChild.centerNodes, node)

		fixChild.keys[node] = true
	end
end

function ActivityChessGameTree:createLeaveNode()
	return {
		nodes = {},
		keys = {},
		centerNodes = {}
	}
end

function ActivityChessGameTree:growToBranch(root)
	local minX, minY, maxX, maxY = 9999, 9999, -9999, -9999

	for _, node in pairs(root.centerNodes) do
		minX = math.min(minX, node.x)
		minY = math.min(minY, node.y)
		maxX = math.max(maxX, node.x)
		maxY = math.max(maxY, node.y)
	end

	root.x = (minX + maxX) * 0.5
	root.y = (minY + maxY) * 0.5
	root.children = {}

	for i = 1, 4 do
		root.children[i] = self:createLeaveNode()
		root.children[i].parent = root
	end
end

function ActivityChessGameTree:getFixNode(root, x, y)
	if x > root.x then
		if y > root.y then
			return root.children[1]
		else
			return root.children[4]
		end
	elseif y > root.y then
		return root.children[2]
	else
		return root.children[3]
	end
end

function ActivityChessGameTree:search(anchorX, anchorY)
	local targetNode = self.root

	while targetNode.children ~= nil do
		targetNode = self:getFixNode(targetNode, anchorX, anchorY)
	end

	local parentNode = targetNode.parent

	if parentNode ~= nil then
		return parentNode.nodes
	else
		return targetNode.nodes
	end
end

return ActivityChessGameTree
