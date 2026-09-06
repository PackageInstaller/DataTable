-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextallpassView.lua

module("logic.extensions.farnas.view.FarnasextallpassView", package.seeall)

local FarnasextallpassView = class("FarnasextallpassView", ViewComponent)

function FarnasextallpassView:ctor()
	FarnasextallpassView.super.ctor(self)
end

function FarnasextallpassView:unbindEvents()
	FarnasextallpassView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FarnasextallpassView:bindEvents()
	FarnasextallpassView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function FarnasextallpassView:buildUI()
	FarnasextallpassView.super.buildUI(self)

	self._btnClose = self:getBtn("container/btnClose")
end

function FarnasextallpassView:onExit()
	FarnasextallpassView.super.onExit(self)
end

function FarnasextallpassView:onEnter()
	FarnasextallpassView.super.onEnter(self)
end

function FarnasextallpassView:_onClickbtnClose()
	self:close()
	BattleController.instance:endBattle()
end

return FarnasextallpassView
