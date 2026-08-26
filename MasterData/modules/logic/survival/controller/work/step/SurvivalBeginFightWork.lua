-- chunkname: @modules/logic/survival/controller/work/step/SurvivalBeginFightWork.lua

module("modules.logic.survival.controller.work.step.SurvivalBeginFightWork", package.seeall)

local SurvivalBeginFightWork = class("SurvivalBeginFightWork", SurvivalStepBaseWork)

function SurvivalBeginFightWork:onStart2(context)
	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(ModuleEnum.HeroGroupSnapshotType.Survival, self._onRecvMsg, self)
end

function SurvivalBeginFightWork:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 and not self.context.fastExecute then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local unitMo = sceneMo.unitsById[self._stepMo.paramInt[1]]

		if unitMo then
			local episodeId = SurvivalConst.Survival_EpisodeId
			local config = DungeonConfig.instance:getEpisodeCO(episodeId)

			DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, unitMo.co.battleId)

			self.context.isEnterFight = true

			self:onDone(true)
		else
			logError("战斗元件不存在" .. tostring(self._stepMo.paramInt[1]))
			self:onDone(true)
		end
	else
		self:onDone(false)
	end
end

return SurvivalBeginFightWork
