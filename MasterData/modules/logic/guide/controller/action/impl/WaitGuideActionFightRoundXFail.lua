-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightRoundXFail.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundXFail", package.seeall)

local WaitGuideActionFightRoundXFail = class("WaitGuideActionFightRoundXFail", BaseGuideAction)

function WaitGuideActionFightRoundXFail:onStart(context)
	WaitGuideActionFightRoundXFail.super.onStart(self, context)

	local temp = string.splitToNumber(self.actionParam, "#")

	self._waveRoundDict = nil

	if #temp > 2 then
		for i = 1, #temp, 2 do
			if temp[i + 1] then
				local waveRound = temp[i] .. "#" .. temp[i + 1]

				self._waveRoundDict = self._waveRoundDict or {}
				self._waveRoundDict[waveRound] = true
			else
				logError(string.format("guide_%d_%d 等待战斗第m波次第n回合失败 配置错误 参数数量应为1或者偶数", self.guideId, self.stepId))
			end
		end
	elseif #temp == 2 then
		local waveRound = temp[1] .. "#" .. temp[2]

		self._waveRoundDict = self._waveRoundDict or {}
		self._waveRoundDict[waveRound] = true
	elseif #temp == 1 then
		local waveRound = 1 .. "#" .. temp[1]

		self._waveRoundDict = self._waveRoundDict or {}
		self._waveRoundDict[waveRound] = true
	end

	self._roundIdInWave = 0

	FightController.instance:registerCallback(FightEvent.OnBeginWave, self._onBeginWave, self)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, self._onBeginRound, self)
	FightController.instance:registerCallback(FightEvent.StageChanged, self._onStageChange, self)
end

function WaitGuideActionFightRoundXFail:_onBeginWave()
	self._roundIdInWave = 0
end

function WaitGuideActionFightRoundXFail:_onBeginRound()
	self._roundIdInWave = self._roundIdInWave + 1
end

function WaitGuideActionFightRoundXFail:_onStageChange()
	if FightDataHelper.stateMgr.isFinish then
		local fightRecordMO = FightModel.instance:getRecordMO()
		local fail = fightRecordMO and fightRecordMO.fightResult == FightEnum.FightResult.Fail

		if fail then
			local waveId = FightModel.instance:getCurWaveId()
			local key = waveId .. "#" .. self._roundIdInWave

			if not self._waveRoundDict or self._waveRoundDict[key] then
				self:onDone(true)
			end
		end
	end
end

function WaitGuideActionFightRoundXFail:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, self._onBeginWave, self)
	FightController.instance:unregisterCallback(FightEvent.RespBeginRound, self._onBeginRound, self)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, self._onStageChange, self)
end

return WaitGuideActionFightRoundXFail
