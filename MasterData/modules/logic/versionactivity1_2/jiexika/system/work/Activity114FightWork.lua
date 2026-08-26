-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114FightWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114FightWork", package.seeall)

local Activity114FightWork = class("Activity114FightWork", Activity114BaseWork)

function Activity114FightWork:onStart(context)
	local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, self.context.eventId)

	ViewMgr.instance:closeView(ViewName.Activity114EmptyView, true, true)
	Activity114Controller.instance:enterActivityFight(eventCo.config.battleId)
	self:onDone(true)
end

return Activity114FightWork
