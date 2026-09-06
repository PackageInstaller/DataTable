-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameOverView.lua

module("logic.extensions.dreamteam.view.FlipGameOverView", package.seeall)

local FlipGameOverView = class("FlipGameOverView", ViewComponent)

function FlipGameOverView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._txtScore = self:getTxt("txtScore")
end

function FlipGameOverView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function FlipGameOverView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function FlipGameOverView:onEnter()
	self:_setScore()
end

function FlipGameOverView:onExit()
	return
end

function FlipGameOverView:_onClickClose()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.FlipGameEnd)
end

function FlipGameOverView:_setScore()
	self._txtScore.text = string.format("x%d", FlipGameModel.instance:getTotalGameScore())
end

return FlipGameOverView
