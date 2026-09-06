-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/view/TaskcardhotshareView.lua

module("logic.extensions.cardhot.view.TaskcardhotshareView", package.seeall)

local TaskcardhotshareView = class("TaskcardhotshareView", ViewComponent)

function TaskcardhotshareView:ctor()
	TaskcardhotshareView.super.ctor(self)
end

function TaskcardhotshareView:buildUI()
	TaskcardhotshareView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
end

function TaskcardhotshareView:bindEvents()
	TaskcardhotshareView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function TaskcardhotshareView:unbindEvents()
	TaskcardhotshareView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function TaskcardhotshareView:destroyUI()
	TaskcardhotshareView.super.destroyUI(self)
end

function TaskcardhotshareView:onEnter()
	TaskcardhotshareView.super.onEnter(self)
	ShareController.instance:share(3, {
		self.btnClose.gameObject
	}, nil, 0)
end

function TaskcardhotshareView:onEnterFinished()
	TaskcardhotshareView.super.onEnterFinished(self)
end

function TaskcardhotshareView:onExit()
	TaskcardhotshareView.super.onExit(self)
end

function TaskcardhotshareView:onExitFinished()
	TaskcardhotshareView.super.onExitFinished(self)
end

return TaskcardhotshareView
