-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StageLoadingView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StageLoadingView", package.seeall)

local Season123_2_1StageLoadingView = class("Season123_2_1StageLoadingView", BaseView)

function Season123_2_1StageLoadingView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1StageLoadingView:addEvents()
	return
end

function Season123_2_1StageLoadingView:removeEvents()
	return
end

function Season123_2_1StageLoadingView:_editableInitView()
	return
end

function Season123_2_1StageLoadingView:onDestroyView()
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
end

function Season123_2_1StageLoadingView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOpenView, self)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_map_upgrade)

	local actId = self.viewParam.actId
	local stage = self.viewParam.stage

	logNormal(string.format("Season123_2_1StageLoadingView actId=%s, stage=%s", actId, stage))
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 2.5)
end

function Season123_2_1StageLoadingView:onClose()
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
end

function Season123_2_1StageLoadingView:handleDelayAnimTransition()
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = self.viewParam.actId,
		stage = self.viewParam.stage
	})
end

function Season123_2_1StageLoadingView:handleOpenView(viewName)
	if viewName == Season123Controller.instance:getEpisodeListViewName() then
		self:closeThis()
	end
end

return Season123_2_1StageLoadingView
