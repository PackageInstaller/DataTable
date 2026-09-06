-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoocancelfollowView.lua

module("logic.extensions.zoo.view.ZoocancelfollowView", package.seeall)

local ZoocancelfollowView = class("ZoocancelfollowView", ViewComponent)

function ZoocancelfollowView:ctor()
	ZoocancelfollowView.super.ctor(self)
end

function ZoocancelfollowView:buildUI()
	ZoocancelfollowView.super.buildUI(self)

	self._bg = GameUtil.asBtn(self.mainGO, "bg")
end

function ZoocancelfollowView:bindEvents()
	ZoocancelfollowView.super.bindEvents(self)
	self._bg:AddClickListener(self.close, self)
end

function ZoocancelfollowView:unbindEvents()
	ZoocancelfollowView.super.unbindEvents(self)
	self._bg:RemoveClickListener()
end

function ZoocancelfollowView:destroyUI()
	ZoocancelfollowView.super.destroyUI(self)
end

function ZoocancelfollowView:onEnter()
	ZoocancelfollowView.super.onEnter(self)
end

function ZoocancelfollowView:onEnterFinished()
	ZoocancelfollowView.super.onEnterFinished(self)
end

function ZoocancelfollowView:onExit()
	ZoocancelfollowView.super.onExit(self)
end

function ZoocancelfollowView:onExitFinished()
	ZoocancelfollowView.super.onExitFinished(self)
end

return ZoocancelfollowView
