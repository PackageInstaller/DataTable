-- chunkname: @modules/logic/fight/system/work/FightWorkAct183Ending.lua

module("modules.logic.fight.system.work.FightWorkAct183Ending", package.seeall)

local FightWorkAct183Ending = class("FightWorkAct183Ending", BaseWork)

function FightWorkAct183Ending:onStart(context)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not episodeCo or episodeCo.type ~= DungeonEnum.EpisodeType.Act183 then
		self:onDone(true)

		return
	end

	local battleFinishedInfo = Act183Model.instance:getBattleFinishedInfo()
	local hasRecord = battleFinishedInfo and battleFinishedInfo.record ~= nil
	local episodeMo = battleFinishedInfo and battleFinishedInfo.episodeMo
	local groupType = episodeMo and episodeMo:getGroupType()

	if groupType ~= Act183Enum.GroupType.Daily and hasRecord then
		local activityId = battleFinishedInfo.activityId
		local params = {
			activityId = activityId,
			groupRecordMo = battleFinishedInfo.record
		}

		self._flow = FlowSequence.New()

		self._flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Act183FinishView, params))
		self._flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Act183SettlementView, params))
		self._flow:addWork(FunctionWork.New(self.onDone, self, true))
		self._flow:start()
	else
		self:onDone(true)
	end
end

return FightWorkAct183Ending
