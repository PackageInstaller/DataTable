-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepCreateObject.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepCreateObject", package.seeall)

local ActivityChessStepCreateObject = class("ActivityChessStepCreateObject", ActivityChessStepBase)

function ActivityChessStepCreateObject:start()
	local objId = self.originData.id
	local actId = ActivityChessGameModel.instance:getActId()

	ActivityChessGameModel.instance:removeObjectById(objId)
	ActivityChessGameController.instance:deleteInteractObj(objId)

	local mo = ActivityChessGameModel.instance:addObject(actId, self.originData)

	ActivityChessGameController.instance:addInteractObj(mo)
	logNormal("create object finish !" .. tostring(mo.id))
	self:finish()
end

return ActivityChessStepCreateObject
