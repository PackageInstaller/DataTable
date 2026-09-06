-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaNode.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaNode", package.seeall)

local DivineKingNuoYaNode = class("DivineKingNuoYaNode", ViewComponent)

function DivineKingNuoYaNode:ctor(luaComponentContainer)
	self._rightRoot = nil
	self._rightDownRoot = nil
	self._downRoot = nil
	self._leftDownRoot = nil
end

function DivineKingNuoYaNode:bindEvents()
	DivineKingNuoYaNode.super.bindEvents(self)
end

function DivineKingNuoYaNode:unbindEvents()
	DivineKingNuoYaNode.super.unbindEvents(self)
end

function DivineKingNuoYaNode:onExit()
	DivineKingNuoYaNode.super.onExit(self)
end

function DivineKingNuoYaNode:onEnter()
	DivineKingNuoYaNode.super.onEnter(self)
end

return DivineKingNuoYaNode
