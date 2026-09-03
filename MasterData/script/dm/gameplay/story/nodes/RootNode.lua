-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/nodes/RootNode.lua

module("story", package.seeall)

function sandbox.getnode(root, name)
	assert(root ~= nil, "Invalid root node")

	return function()
		return root:getChildById(name)
	end
end

sandbox.__getnode__ = sandbox.getnode
RootNode = class("RootNode", StageNode)

register_stage_node("Root", RootNode)

function RootNode:initialize(config)
	self.__isroot__ = true
	self._nodeToIdRegistry = {}
	self._idToNodeRegistry = {}
	self._childConfigList = {}

	super.initialize(self, config)
end

function RootNode:createRenderNode(config)
	return cc.Node:create()
end

function RootNode:getChildById(id)
	local node = self._idToNodeRegistry[id]

	if node == nil then
		node = self:createRootChild(id)
	end

	return node
end

function RootNode:_registerChildNode(child)
	local oldId = self._nodeToIdRegistry[child]
	local newId = child:getId()

	if oldId == newId then
		return
	end

	self._nodeToIdRegistry[child] = newId

	local idToNodeRegistry = self._idToNodeRegistry

	if oldId ~= nil then
		assert(idToNodeRegistry[oldId] == child, "Unexpected internal state")

		idToNodeRegistry[oldId] = nil
	end

	if newId ~= nil then
		assert(idToNodeRegistry[newId] == nil, string.format("Duplicate node id \"%s\"", newId))

		idToNodeRegistry[newId] = child
	end
end

function RootNode:_unregisterChildNode(child)
	local oldId = self._nodeToIdRegistry[child]

	if oldId == nil then
		return
	end

	assert(self._idToNodeRegistry[oldId] == child, "Unexpected internal state")

	self._nodeToIdRegistry[child] = nil
	self._idToNodeRegistry[oldId] = nil
end

function RootNode:setChildrenList(data)
	data = data or {}
	self._childConfigList = {}

	local childrenList = {}

	table.deepcopy(data, childrenList)

	local function addConfig(list, parentId)
		for k, v in pairs(list) do
			if v.children then
				addConfig(v.children, v.id)
			end

			v.children = nil
			v._rootParentId = parentId
			self._childConfigList[v.id] = v
		end
	end

	addConfig(childrenList, "_rootNode_")
end

function RootNode:createRootChild(id)
	local config = self._childConfigList[id]

	if config then
		local parentId = config._rootParentId

		config._rootParentId = nil

		local parentNode = parentId == "_rootNode_" and self or self:getChildById(parentId)

		if parentNode then
			local node = StageNodeFactory:createNodeWithConfig(config)

			if node then
				parentNode:addChild(node, config.zorder, config.name)
				node:refreshLayout()

				return node
			end
		end
	end
end

StageRootNode = class("StageRootNode", RootNode)

StageRootNode:has("_agent", {
	is = "rw"
})
register_stage_node("Stage", StageRootNode)

function StageRootNode:createRenderNode(config)
	local renderNode = cc.Node:create()
	local stageMountPoint = cc.Node:create()

	stageMountPoint:setName("_stage")
	renderNode:addChild(stageMountPoint)

	local uiMountPoint = cc.Node:create()

	uiMountPoint:setName("_ui")
	renderNode:addChild(uiMountPoint)

	self._renderMountPoints = {
		default = stageMountPoint,
		ui = uiMountPoint
	}

	return renderNode
end

function StageRootNode:refreshLayout()
	self:adjustRenderNode()

	local renderNode = self._renderNode
	local contentSize = renderNode:getContentSize()

	for _, node in pairs(self._renderMountPoints) do
		node:setContentSize(contentSize)
	end

	self:doLayout()
end

function StageRootNode:getStageRenderNode()
	return self._renderNode:getChildByName("_stage")
end
