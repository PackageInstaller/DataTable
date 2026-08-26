-- chunkname: @modules/logic/fight/system/work/FightWorkSystemFightNoticeView.lua

module("modules.logic.fight.system.work.FightWorkSystemFightNoticeView", package.seeall)

local FightWorkSystemFightNoticeView = class("FightWorkSystemFightNoticeView", FightWorkItem)

function FightWorkSystemFightNoticeView:onStart()
	local config = lua_teaching_episode.configDict[FightDataHelper.fieldMgr.episodeId]

	if not config then
		self:onDone(true)

		return
	end

	local flow = self:com_registFlowParallel()

	flow:registWork(FightWorkWaitCloseView, ViewName.FightSystemFightNoticeView)
	flow:registWork(FightWorkOpenView, ViewName.FightSystemFightNoticeView)
	self:playWorkAndDone(flow)
end

return FightWorkSystemFightNoticeView
