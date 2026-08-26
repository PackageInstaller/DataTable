-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5StageLoadingView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5StageLoadingView", package.seeall)

local Season123_3_5StageLoadingView = class("Season123_3_5StageLoadingView", BaseView)

function Season123_3_5StageLoadingView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5StageLoadingView:addEvents()
	return
end

function Season123_3_5StageLoadingView:removeEvents()
	return
end

function Season123_3_5StageLoadingView:_editableInitView()
	return
end

function Season123_3_5StageLoadingView:onDestroyView()
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
end

function Season123_3_5StageLoadingView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOpenView, self)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_map_upgrade)

	local actId = self.viewParam.actId
	local stage = self.viewParam.stage

	logNormal(string.format("Season123_3_5StageLoadingView actId=%s, stage=%s", actId, stage))
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 2.5)
end

function Season123_3_5StageLoadingView:onClose()
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
end

function Season123_3_5StageLoadingView:handleDelayAnimTransition()
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = self.viewParam.actId,
		stage = self.viewParam.stage
	})
end

function Season123_3_5StageLoadingView:handleOpenView(viewName)
	if viewName == Season123Controller.instance:getEpisodeListViewName() then
		self:closeThis()
	end
end

return Season123_3_5StageLoadingView
