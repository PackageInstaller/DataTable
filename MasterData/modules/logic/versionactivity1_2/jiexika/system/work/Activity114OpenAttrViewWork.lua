-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114OpenAttrViewWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenAttrViewWork", package.seeall)

local Activity114OpenAttrViewWork = class("Activity114OpenAttrViewWork", Activity114OpenViewWork)

function Activity114OpenAttrViewWork:onStart(context)
	if not Activity114Helper.haveAttrOrFeatureChange(self.context) then
		self:onDone(true)

		return
	end

	self._viewName = ViewName.Activity114FinishEventView

	Activity114OpenAttrViewWork.super.onStart(self, context)
end

return Activity114OpenAttrViewWork
