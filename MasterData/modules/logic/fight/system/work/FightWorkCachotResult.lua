-- chunkname: @modules/logic/fight/system/work/FightWorkCachotResult.lua

module("modules.logic.fight.system.work.FightWorkCachotResult", package.seeall)

local FightWorkCachotResult = class("FightWorkCachotResult", BaseWork)

function FightWorkCachotResult:onStart(context)
	local fightRecordMO = FightModel.instance:getRecordMO()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if fightRecordMO and fightRecordMO.fightResult == FightEnum.FightResult.Succ and episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Cachot then
		local topEventMo = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

		if topEventMo and topEventMo:isBattleSuccess() and not ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, topEventMo)
		else
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function FightWorkCachotResult:_onCloseViewFinish()
	if PopupController.instance:getPopupCount() > 0 then
		return
	end

	local topEventMo = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if topEventMo then
		local eventCo = topEventMo:getEventCo()

		if eventCo and (eventCo.type ~= V1a6_CachotEnum.EventType.Battle or eventCo.type == V1a6_CachotEnum.EventType.Battle and topEventMo:isBattleSuccess()) then
			return
		end
	end

	local checkOpenList = {
		ViewName.V1a6_CachotTipsView,
		ViewName.V1a6_CachotRewardView
	}

	for _, viewName in ipairs(checkOpenList) do
		if ViewMgr.instance:isOpen(viewName) then
			return
		end
	end

	self:onDone(true)
end

function FightWorkCachotResult:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

return FightWorkCachotResult
