-- chunkname: @modules/logic/fight/system/work/FightWorkAct114RoundEndStory.lua

module("modules.logic.fight.system.work.FightWorkAct114RoundEndStory", package.seeall)

local FightWorkAct114RoundEndStory = class("FightWorkAct114RoundEndStory", BaseWork)

function FightWorkAct114RoundEndStory:onStart()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam or fightParam.episodeId ~= Activity114Enum.episodeId then
		self:onDone(true)

		return
	end

	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, self.onProcessEnd, self)
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	local recordMO = FightModel.instance:getRecordMO()

	if not recordMO then
		self:onDone(true)

		return
	end

	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, self.onProcessEnd, self)

	if recordMO.fightResult == FightEnum.FightResult.Succ then
		if not Activity114Enum.Result.FightSucess then
			local result = Activity114Enum.Result.Fail

			Activity114Controller.instance:dispatchEvent(Activity114Event.OnFightResult, result)
		end
	end
end

function FightWorkAct114RoundEndStory:onProcessEnd()
	self:onDone(true)
end

function FightWorkAct114RoundEndStory:onDestroy()
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessEnd, self.onProcessEnd, self)
end

return FightWorkAct114RoundEndStory
