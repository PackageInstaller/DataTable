-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/view/LinkageLotteryTaskView.lua

module("logic.extensions.linkagelottery.view.LinkageLotteryTaskView", package.seeall)

local LinkageLotteryTaskView = class("LinkageLotteryTaskView", EventtasksummaryView)

function LinkageLotteryTaskView:ctor()
	LinkageLotteryTaskView.super.ctor(self)
end

function LinkageLotteryTaskView:buildUI()
	LinkageLotteryTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function LinkageLotteryTaskView:bindEvents()
	LinkageLotteryTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function LinkageLotteryTaskView:unbindEvents()
	LinkageLotteryTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LinkageLotteryTaskView:_onClickClose()
	self:close()
end

return LinkageLotteryTaskView
