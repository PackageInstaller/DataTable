-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0StageLoadingView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0StageLoadingView", package.seeall)

local Season123_2_0StageLoadingView = class("Season123_2_0StageLoadingView", BaseView)

function Season123_2_0StageLoadingView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0StageLoadingView:addEvents()
	return
end

function Season123_2_0StageLoadingView:removeEvents()
	return
end

function Season123_2_0StageLoadingView:_editableInitView()
	return
end

function Season123_2_0StageLoadingView:onDestroyView()
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
end

function Season123_2_0StageLoadingView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOpenView, self)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_map_upgrade)

	local actId = self.viewParam.actId
	local stage = self.viewParam.stage

	logNormal(string.format("Season123_2_0StageLoadingView actId=%s, stage=%s", actId, stage))
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 2.5)
end

function Season123_2_0StageLoadingView:onClose()
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
end

function Season123_2_0StageLoadingView:handleDelayAnimTransition()
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = self.viewParam.actId,
		stage = self.viewParam.stage
	})
end

function Season123_2_0StageLoadingView:handleOpenView(viewName)
	if viewName == Season123Controller.instance:getEpisodeListViewName() then
		self:closeThis()
	end
end

return Season123_2_0StageLoadingView
