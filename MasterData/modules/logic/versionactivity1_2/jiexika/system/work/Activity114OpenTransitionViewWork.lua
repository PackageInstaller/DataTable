-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114OpenTransitionViewWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenTransitionViewWork", package.seeall)

local Activity114OpenTransitionViewWork = class("Activity114OpenTransitionViewWork", Activity114OpenViewWork)

function Activity114OpenTransitionViewWork:ctor(id)
	self._transitionId = id
end

function Activity114OpenTransitionViewWork:getTransitionId()
	return self._transitionId
end

function Activity114OpenTransitionViewWork:onStart(context)
	local transitionId = self:getTransitionId()

	if not transitionId then
		self:onDone(true)

		return
	end

	self.context.transitionId = transitionId

	local _, str = Activity114Config.instance:getConstValue(Activity114Model.instance.id, self.context.transitionId)

	if string.nilorempty(str) then
		self.context.transitionId = nil

		self:onDone(true)

		return
	end

	self._viewName = ViewName.Activity114TransitionView

	Activity114OpenTransitionViewWork.super.onStart(self, context)
end

return Activity114OpenTransitionViewWork
