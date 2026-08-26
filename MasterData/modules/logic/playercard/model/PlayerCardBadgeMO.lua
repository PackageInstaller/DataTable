-- chunkname: @modules/logic/playercard/model/PlayerCardBadgeMO.lua

module("modules.logic.playercard.model.PlayerCardBadgeMO", package.seeall)

local PlayerCardBadgeMO = class("PlayerCardBadgeMO")

function PlayerCardBadgeMO:initMO(co)
	self.id = co.id
	self.co = co
end

function PlayerCardBadgeMO:getRare(co)
	return co.level
end

function PlayerCardBadgeMO:isGain()
	local taskMo = self:getTaskMo()

	if taskMo and taskMo:isClaimed() then
		local activityId = self:getActivityId()

		if not activityId or ActivityHelper.isOpen(activityId) then
			return true
		end
	end
end

function PlayerCardBadgeMO:getActivityId()
	local taskMo = self:getTaskMo()

	if taskMo then
		::label_4_0::

		local var_4_0 = taskMo.config

		if taskMo.config then
			return taskMo.config.activityId
		end
	end
end

function PlayerCardBadgeMO:getTaskMo()
	if self.co then
		local taskId = self.co.taskId

		if taskId and taskId > 0 then
			return (TaskModel.instance:getTaskById(taskId))
		end
	end
end

return PlayerCardBadgeMO
