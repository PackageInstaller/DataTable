-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114TravelFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114TravelFlow", package.seeall)

local Activity114TravelFlow = class("Activity114TravelFlow", Activity114BaseFlow)

function Activity114TravelFlow:addSkipWork()
	if Activity114Model.instance.serverData.battleEventId > 0 then
		self.context.result = Activity114Enum.Result.Fail

		self:addWork(Activity114FightResultWork.New())
		self:addWork(Activity114OpenAttrViewWork.New())

		return
	end

	Activity114TravelFlow.super.addSkipWork(self)
end

function Activity114TravelFlow:addEventWork()
	self:addWork(Activity114CheckWork.New())
	self:addWork(Activity114CheckOrAnswerWork.New())
end

return Activity114TravelFlow
