-- chunkname: @modules/logic/fight/system/work/FightWorkCachotEnding.lua

module("modules.logic.fight.system.work.FightWorkCachotEnding", package.seeall)

local FightWorkCachotEnding = class("FightWorkCachotEnding", BaseWork)

function FightWorkCachotEnding:onStart(context)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not episodeCo or episodeCo.type ~= DungeonEnum.EpisodeType.Cachot then
		self:onDone(true)

		return
	end

	local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

	if rogueEndingInfo ~= nil then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	else
		self:onDone(true)
	end
end

function FightWorkCachotEnding:_onCloseViewFinish(viewName)
	if viewName == ViewName.V1a6_CachotResultView then
		self:onDone(true)
	end
end

function FightWorkCachotEnding:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

return FightWorkCachotEnding
