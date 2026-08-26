-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114OpenTransitionViewByEventCoWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenTransitionViewByEventCoWork", package.seeall)

local Activity114OpenTransitionViewByEventCoWork = class("Activity114OpenTransitionViewByEventCoWork", Activity114OpenTransitionViewWork)

function Activity114OpenTransitionViewByEventCoWork:getTransitionId()
	if self._transitionId then
		return self._transitionId
	end

	local eventCo = self.context.eventCo

	if string.nilorempty(eventCo.config.isTransition) then
		return
	end

	local ids = string.splitToNumber(eventCo.config.isTransition, "#")
	local id

	if self.context.result == Activity114Enum.Result.Success or self.context.result == Activity114Enum.Result.FightSucess then
		id = ids[1]
	elseif self.context.result == Activity114Enum.Result.Fail then
		id = ids[2]
	end

	if not id or id == 0 then
		return
	end

	return id
end

return Activity114OpenTransitionViewByEventCoWork
