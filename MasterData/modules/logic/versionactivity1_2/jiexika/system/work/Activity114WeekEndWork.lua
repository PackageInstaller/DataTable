-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114WeekEndWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114WeekEndWork", package.seeall)

local Activity114WeekEndWork = class("Activity114WeekEndWork", Activity114OpenViewWork)

function Activity114WeekEndWork:onStart(context)
	self._viewName = ViewName.Activity114ScoreReportView

	Activity114WeekEndWork.super.onStart(self, context)
end

return Activity114WeekEndWork
