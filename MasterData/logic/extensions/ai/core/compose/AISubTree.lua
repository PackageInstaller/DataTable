-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AISubTree.lua

module("logic.extensions.ai.core.compose.AISubTree", package.seeall)

local AISubTree = class("AISubTree", AIParentNode)

function AISubTree:ctor(context)
	AISubTree.super.ctor(self, context)

	self._subTreeName = false
	self._treeInstance = false
end

function AISubTree:initFromConfig(aiConfigData)
	AISubTree.super.initFromConfig(self, aiConfigData)

	self._subTreeName = aiConfigData.treeName

	self:addChild(self:getSubTreeInstance())
end

function AISubTree:onStart()
	AISubTree.super.onStart(self)

	return self:getChildAt(1):onStart()
end

function AISubTree:onChildEnd(child)
	return self:onEnd(child:getStatus())
end

function AISubTree:onReset()
	AISubTree.super.onReset(self)
end

function AISubTree:onReuse(context)
	AISubTree.super.onReuse(self, context)
end

function AISubTree:onRecycle()
	AISubTree.super.onRecycle(self)

	self._treeInstance = false
	self._subTreeName = false
end

function AISubTree:onDestroy()
	AISubTree.super.onDestroy(self)

	self._treeInstance = false
	self._subTreeName = false
end

function AISubTree:getSubTreeInstance()
	if not self._treeInstance then
		local aiConfigData = AIUtil.getAIConfigData(self._subTreeName)

		self._treeInstance = AIUtil.parseAINodeConfig(aiConfigData.root, self._context)
	end

	return self._treeInstance
end

return AISubTree
