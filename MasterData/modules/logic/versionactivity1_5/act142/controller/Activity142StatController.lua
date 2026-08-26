-- chunkname: @modules/logic/versionactivity1_5/act142/controller/Activity142StatController.lua

module("modules.logic.versionactivity1_5.act142.controller.Activity142StatController", package.seeall)

local Activity142StatController = class("Activity142StatController", BaseController)

Activity142StatController.FailReasonEnum = {
	[0] = "",
	nil,
	nil,
	"回合上限",
	"触碰到不可触碰的棋子",
	"被场地机制击倒"
}

function Activity142StatController:statStart()
	self.startTime = Time.realtimeSinceStartup
end

function Activity142StatController:statEnd(result)
	if not self.startTime or self.waitingRpc then
		return
	end

	self.useTime = Time.realtimeSinceStartup - self.startTime
	self.episodeId = Activity142Model.instance:getCurEpisodeId()
	self.round = Va3ChessGameModel.instance:getRound()

	if result == StatEnum.Result.Abort or result == StatEnum.Result.Reset or result == StatEnum.Result.BackTrace then
		self.round = self.round - 1
	end

	self.goalNum = Activity142Model.instance:getStarCount()
	self.result = result

	if result == StatEnum.Result.Fail then
		local numFailReason = Va3ChessGameModel.instance:getFailReason()

		self.failReason = Activity142StatController.FailReasonEnum[numFailReason or 0] or ""
	else
		self.failReason = ""
	end

	self.startTime = nil
	self.waitingRpc = true

	local actId = Activity142Model.instance:getActivityId()

	Va3ChessRpcController.instance:sendGetActInfoRequest(actId, self._onReceive142InfoCb, self)
end

function Activity142StatController:_onReceive142InfoCb()
	local episodeMo = Activity142Model.instance:getEpisodeData(self.episodeId)

	if episodeMo then
		if not episodeMo.totalCount then
			local challengesNum = 0

			self.waitingRpc = false

			StatController.instance:track(StatEnum.EventName.ExitSpathodeaActivity, {
				[StatEnum.EventProperties.UseTime] = self.useTime,
				[StatEnum.EventProperties.EpisodeId] = tostring(self.episodeId),
				[StatEnum.EventProperties.ChallengesNum] = challengesNum,
				[StatEnum.EventProperties.RoundNum] = self.round,
				[StatEnum.EventProperties.GoalNum] = self.goalNum,
				[StatEnum.EventProperties.Result] = self.result,
				[StatEnum.EventProperties.FailReason] = self.failReason
			})
		end
	end
end

function Activity142StatController:statSuccess()
	self:statEnd(StatEnum.Result.Success)
end

function Activity142StatController:statFail()
	self:statEnd(StatEnum.Result.Fail)
	self:statStart()
end

function Activity142StatController:statBack2CheckPoint()
	self:statEnd(StatEnum.Result.BackTrace)
	self:statStart()
end

function Activity142StatController:statReset()
	self:statEnd(StatEnum.Result.Reset)
	self:statStart()
end

function Activity142StatController:statAbort()
	self:statEnd(StatEnum.Result.Abort)
end

function Activity142StatController:statCollectionViewStart()
	self.collectionViewStartTime = Time.realtimeSinceStartup
end

function Activity142StatController:statCollectionViewEnd()
	if not self.collectionViewStartTime then
		return
	end

	local actId = Activity142Model.instance:getActivityId()
	local useTime = Time.realtimeSinceStartup - self.collectionViewStartTime
	local collectedItemNameList = {}
	local hasCollectionIdList = Activity142Model.instance:getHadCollectionIdList()

	for _, collectionId in ipairs(hasCollectionIdList) do
		local collectionName = Activity142Config.instance:getCollectionName(actId, collectionId)

		table.insert(collectedItemNameList, collectionName)
	end

	StatController.instance:track(StatEnum.EventName.ExitSpathodeaCollect, {
		[StatEnum.EventProperties.Time] = useTime,
		[StatEnum.EventProperties.CollectedItems] = collectedItemNameList
	})

	self.collectionViewStartTime = nil
end

Activity142StatController.instance = Activity142StatController.New()

return Activity142StatController
