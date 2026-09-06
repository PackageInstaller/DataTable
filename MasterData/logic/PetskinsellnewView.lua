-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PetskinsellnewView.lua

module("logic.extensions.firstcharge.view.PetskinsellnewView", package.seeall)

local PetskinsellnewView = class("PetskinsellnewView", PetskinsellView)

function PetskinsellnewView:ctor()
	PetskinsellnewView.super.ctor(self)
end

function PetskinsellnewView:buildUI()
	PetskinsellnewView.super.buildUI(self)

	self._goodsId = 8001
	self._funcId = 283
end

function PetskinsellnewView:bindEvents()
	PetskinsellnewView.super.bindEvents(self)
end

function PetskinsellnewView:unbindEvents()
	PetskinsellnewView.super.unbindEvents(self)
end

function PetskinsellnewView:destroyUI()
	PetskinsellnewView.super.destroyUI(self)
end

function PetskinsellnewView:onEnter()
	PetskinsellnewView.super.onEnter(self)
end

function PetskinsellnewView:onEnterFinished()
	PetskinsellnewView.super.onEnterFinished(self)
end

function PetskinsellnewView:onExit()
	PetskinsellnewView.super.onExit(self)
end

function PetskinsellnewView:onExitFinished()
	PetskinsellnewView.super.onExitFinished(self)
end

return PetskinsellnewView
