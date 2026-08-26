-- chunkname: @modules/logic/versionactivity1_2/common/Stat1_2Controller.lua

module("modules.logic.versionactivity1_2.common.Stat1_2Controller", package.seeall)

local Stat1_2Controller = class("Stat1_2Controller")

function Stat1_2Controller:yaXianStatStart()
	self.yaXianStartTime = ServerTime.now()
end

function Stat1_2Controller:yaXianStatEnd(result)
	if not self.yaXianStartTime then
		return
	end

	if self.waitingRpc then
		return
	end

	self.useTime = ServerTime.now() - self.yaXianStartTime
	self.mapId = YaXianGameModel.instance:getMapId()
	self.round = YaXianGameModel.instance:getRound()
	self.goalNum = YaXianGameModel.instance:getFinishConditionCount()
	self.episodeId = YaXianGameModel.instance:getEpisodeId()
	self.result = result
	self.waitingRpc = true

	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, self._onReceiveMsg, self)
end

function Stat1_2Controller:_onReceiveMsg()
	local episodeMo = YaXianModel.instance:getEpisodeMo(self.episodeId)

	if episodeMo then
		if not episodeMo.totalCount then
			local challengesNum = 0

			self.yaXianStartTime = nil
			self.waitingRpc = false

			StatController.instance:track(StatEnum.EventName.ExitYaXian, {
				[StatEnum.EventProperties.UseTime] = self.useTime,
				[StatEnum.EventProperties.MapId] = tostring(self.mapId),
				[StatEnum.EventProperties.ChallengesNum] = challengesNum,
				[StatEnum.EventProperties.RoundNum] = self.round,
				[StatEnum.EventProperties.GoalNum] = self.goalNum,
				[StatEnum.EventProperties.Result] = self.result
			})
		end
	end
end

Stat1_2Controller.instance = Stat1_2Controller.New()

return Stat1_2Controller
