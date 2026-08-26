-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepSyncObject.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepSyncObject", package.seeall)

local ActivityChessStepSyncObject = class("ActivityChessStepSyncObject", ActivityChessStepBase)

function ActivityChessStepSyncObject:start()
	local newServerData = self.originData.object
	local interactId = newServerData.id
	local extendData = newServerData.data
	local interactMO = ActivityChessGameModel.instance:getObjectDataById(interactId)
	local deltaDatas = ActivityChessGameModel.instance:syncObjectData(interactId, extendData)

	if deltaDatas ~= nil then
		if self:dataHasChanged(deltaDatas, "alertArea") then
			ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
		end

		if self:dataHasChanged(deltaDatas, "goToObject") then
			local interactObj = ActivityChessGameController.instance.interacts:get(interactId)

			if interactObj then
				interactObj.goToObject:updateGoToObject()
			end
		end

		if self:dataHasChanged(deltaDatas, "lostTarget") then
			local interactObj = ActivityChessGameController.instance.interacts:get(interactId)

			if interactObj then
				interactObj.effect:refreshSearchFailed()
				interactObj.goToObject:refreshTarget()
			end
		end
	end

	self:finish()
end

function ActivityChessStepSyncObject:dataHasChanged(deltaDatas, fieldName)
	if deltaDatas[fieldName] ~= nil or deltaDatas.__deleteFields and deltaDatas.__deleteFields[fieldName] then
		return true
	end

	return false
end

function ActivityChessStepSyncObject:finish()
	ActivityChessStepSyncObject.super.finish(self)
end

return ActivityChessStepSyncObject
