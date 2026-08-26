-- chunkname: @modules/logic/fight/system/work/FightWorkWeekWalkRevive.lua

module("modules.logic.fight.system.work.FightWorkWeekWalkRevive", package.seeall)

local FightWorkWeekWalkRevive = class("FightWorkWeekWalkRevive", BaseWork)

function FightWorkWeekWalkRevive:onStart()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local is_WeekWalk_episode = episode_config and episode_config.type == DungeonEnum.EpisodeType.WeekWalk

	if not is_WeekWalk_episode then
		self:_done()

		return
	end

	local mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not mapInfo or not mapInfo.isShowSelectCd then
		self:_done()

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	WeekWalkController.instance:openWeekWalkReviveView()
end

function FightWorkWeekWalkRevive:_onCloseView(viewName)
	if viewName == ViewName.WeekWalkReviveView then
		self:_done()
	end
end

function FightWorkWeekWalkRevive:_done()
	self:onDone(true)
end

function FightWorkWeekWalkRevive:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
end

return FightWorkWeekWalkRevive
