-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameStartView.lua

module("logic.extensions.dreamteam.view.FlipGameStartView", package.seeall)

local FlipGameStartView = class("FlipGameStartView", ViewComponent)

function FlipGameStartView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
end

function FlipGameStartView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
end

function FlipGameStartView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function FlipGameStartView:onEnter()
	self._activityId = self:getFirstParam()
end

function FlipGameStartView:onExit()
	return
end

function FlipGameStartView:_onClickClose()
	self:close()
end

function FlipGameStartView:_onClickStart()
	if self._activityId then
		FlipGameController.instance:openGameMain(self._activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameToStartGame)
	self:_onClickClose()
end

return FlipGameStartView
