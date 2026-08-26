-- chunkname: @modules/logic/milestone/controller/MileStoneController.lua

module("modules.logic.milestone.controller.MileStoneController", package.seeall)

local MileStoneController = class("MileStoneController", BaseController)

function MileStoneController:onInit()
	return
end

function MileStoneController:addConstEvents()
	return
end

function MileStoneController:reInit()
	return
end

function MileStoneController:openViewByActId(viewName, actId)
	local config = MileStoneConfig.instance:getMileStoneConfigByActId(actId)

	if not config then
		return
	end

	self:openViewById(viewName, config.milestoneId)
end

function MileStoneController:openViewById(viewName, id)
	self._viewName = viewName
	self._id = id

	MileStoneRpc.instance:sendGetMilestoneInfoRequest({
		self._id
	}, self._onGetMilestoneInfoCallback, self)
end

function MileStoneController:_onGetMilestoneInfoCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not self._viewName then
		return
	end

	ViewMgr.instance:openView(self._viewName, {
		id = self._id
	})
end

MileStoneController.instance = MileStoneController.New()

return MileStoneController
