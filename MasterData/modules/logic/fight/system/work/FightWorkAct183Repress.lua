-- chunkname: @modules/logic/fight/system/work/FightWorkAct183Repress.lua

module("modules.logic.fight.system.work.FightWorkAct183Repress", package.seeall)

local FightWorkAct183Repress = class("FightWorkAct183Repress", BaseWork)

function FightWorkAct183Repress:onStart(context)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not episodeCo or episodeCo.type ~= DungeonEnum.EpisodeType.Act183 then
		self:onDone(true)

		return
	end

	local battleFinishedInfo = Act183Model.instance:getBattleFinishedInfo()

	if not battleFinishedInfo or not battleFinishedInfo.win then
		self:onDone(true)

		return
	end

	local activityId = battleFinishedInfo.activityId
	local status = ActivityHelper.getActivityStatus(activityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		self:onDone(true)

		return
	end

	local episodeMo = battleFinishedInfo.episodeMo
	local isLastEpisode = Act183Helper.isLastPassEpisodeInGroup(episodeMo)

	if not isLastEpisode then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
		Act183Controller.instance:openAct183RepressView(battleFinishedInfo)

		return
	end

	self:onDone(true)
end

function FightWorkAct183Repress:_onCloseViewFinish(viewName)
	if viewName == ViewName.Act183RepressView then
		self:onDone(true)
	end
end

function FightWorkAct183Repress:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

return FightWorkAct183Repress
