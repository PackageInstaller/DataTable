-- chunkname: @modules/logic/versionactivity1_4/act130/controller/StatActivity130Controller.lua

module("modules.logic.versionactivity1_4.act130.controller.StatActivity130Controller", package.seeall)

local StatActivity130Controller = class("StatActivity130Controller", BaseController)

function StatActivity130Controller:statStart()
	self.startTime = Time.realtimeSinceStartup
end

function StatActivity130Controller:statSuccess()
	self:statEnd(StatEnum.Result.Success)
end

function StatActivity130Controller:statFail()
	self:statEnd(StatEnum.Result.Fail)
end

function StatActivity130Controller:statAbort()
	self:statEnd(StatEnum.Result.Abort)
end

function StatActivity130Controller:statReset()
	self:statEnd(StatEnum.Result.Reset)
	self:statStart()
end

function StatActivity130Controller:statEnd(result)
	if not self.startTime then
		return
	end

	local useTime = Time.realtimeSinceStartup - self.startTime
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local challengeNum = Activity130Model.instance:getGameChallengeNum(episodeId)
	local roundNum = PuzzleRecordListModel.instance:getCount()
	local goalNum = Role37PuzzleModel.instance:getResult() and 1 or 0
	local levelInfo = Activity130Model.instance:getInfo(episodeId)

	StatController.instance:track(StatEnum.EventName.Exit37Game, {
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(episodeId),
		[StatEnum.EventProperties.ChallengesNum] = challengeNum,
		[StatEnum.EventProperties.RoundNum] = roundNum,
		[StatEnum.EventProperties.GoalNum] = goalNum,
		[StatEnum.EventProperties.ElementNum] = (levelInfo.getFinishElementCount or nil) and levelInfo:getFinishElementCount(),
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.FailReason] = (result == StatEnum.Result.Fail or nil) and "超出回合数"
	})

	self.startTime = nil
end

StatActivity130Controller.instance = StatActivity130Controller.New()

return StatActivity130Controller
