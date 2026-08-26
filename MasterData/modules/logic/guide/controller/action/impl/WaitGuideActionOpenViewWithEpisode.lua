-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionOpenViewWithEpisode.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewWithEpisode", package.seeall)

local WaitGuideActionOpenViewWithEpisode = class("WaitGuideActionOpenViewWithEpisode", BaseGuideAction)

function WaitGuideActionOpenViewWithEpisode:onStart(context)
	WaitGuideActionOpenViewWithEpisode.super.onStart(self, context)

	local paramList = string.split(self.actionParam, "#")

	self._viewName = ViewName[paramList[1]]
	self._targetEposideId = tonumber(paramList[2])

	if ViewMgr.instance:isOpen(self._viewName) and self._targetEposideId == DungeonModel.instance.curLookEpisodeId then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
end

function WaitGuideActionOpenViewWithEpisode:_checkOpenView(viewName, viewParam)
	if self._viewName == viewName and self._targetEposideId == DungeonModel.instance.curLookEpisodeId then
		self:clearWork()
		self:onDone(true)
	end
end

function WaitGuideActionOpenViewWithEpisode:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
end

return WaitGuideActionOpenViewWithEpisode
