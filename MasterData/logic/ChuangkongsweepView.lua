-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongsweepView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongsweepView", package.seeall)

local ChuangkongsweepView = class("ChuangkongsweepView", ViewComponent)

function ChuangkongsweepView:ctor()
	ChuangkongsweepView.super.ctor(self)
end

function ChuangkongsweepView:unbindEvents()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSweep)
	ChuangkongsweepView.super.unbindEvents(self)
end

function ChuangkongsweepView:bindEvents()
	ChuangkongsweepView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSweep, self._onClickSweep, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChuangkongsweepView:buildUI()
	ChuangkongsweepView.super.buildUI(self)

	self._btnSweep = self:getGo("btnSweep")
	self._btnClose = self:getGo("btnClose")
end

function ChuangkongsweepView:onExit()
	ChuangkongunionController.instance:unregisterNotify(ChuangkongunionController.DATA_CHANGE, self.close, self)
	ChuangkongsweepView.super.onExit(self)
end

function ChuangkongsweepView:onEnter()
	ChuangkongsweepView.super.onEnter(self)

	self.taskId = checknumber(self:getFirstParam())

	ChuangkongunionController.instance:registerNotify(ChuangkongunionController.DATA_CHANGE, self.close, self)
end

function ChuangkongsweepView:_onClickSweep()
	ChuangkongunionController.instance:sweepTask(self.taskId)
end

return ChuangkongsweepView
