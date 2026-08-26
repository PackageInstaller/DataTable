-- chunkname: @modules/logic/chessgame/controller/ChessStatController.lua

module("modules.logic.chessgame.controller.ChessStatController", package.seeall)

local ChessStatController = class("ChessStatController")

function ChessStatController:startStat()
	self.startTime = ServerTime.now()
end

function ChessStatController:statSuccess()
	self:_statEnd(StatEnum.Result.Success)
end

function ChessStatController:statFail()
	self:_statEnd(StatEnum.Result.Fail)
end

function ChessStatController:statReset()
	self:_statEnd(StatEnum.Result.Reset)
	self:startStat()
end

function ChessStatController:statAbort()
	self:_statEnd(StatEnum.Result.Abort)
end

function ChessStatController:_statEnd(result)
	if not self.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.ExitLanShouPaActivity, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self.startTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(ChessModel.instance:getEpisodeId()),
		[StatEnum.EventProperties.RoundNum] = ChessGameModel.instance:getRound(),
		[StatEnum.EventProperties.GoalNum] = ChessGameModel.instance:getCompletedCount(),
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.BackNum] = ChessGameModel.instance:getRollBackNum()
	})
	ChessGameModel.instance:clearRound()
	ChessGameModel.instance:clearRollbackNum()

	self.startTime = nil
end

ChessStatController.instance = ChessStatController.New()

return ChessStatController
