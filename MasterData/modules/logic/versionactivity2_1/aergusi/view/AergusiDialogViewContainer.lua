-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogViewContainer", package.seeall)

local AergusiDialogViewContainer = class("AergusiDialogViewContainer", BaseViewContainer)

function AergusiDialogViewContainer:buildViews()
	return {
		AergusiDialogRoleView.New(),
		AergusiDialogContentView.New(),
		AergusiDialogTaskView.New(),
		AergusiDialogView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function AergusiDialogViewContainer:buildTabViews(tabContainerId)
	self._startServerTime = ServerTime.now()
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

	return {
		self._navigateButtonView
	}
end

function AergusiDialogViewContainer:_overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act163ExitEvidence, MsgBoxEnum.BoxType.Yes_No, self._startClose, nil, nil, self)
end

function AergusiDialogViewContainer:_startClose()
	local clueList = {}
	local clueConfigs = AergusiModel.instance.instance:getEpisodeClueConfigs(self.viewParam.episodeId, true)

	for _, v in pairs(clueConfigs) do
		table.insert(clueList, v.clueName)
	end

	StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
		[StatEnum.EventProperties.EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.Result] = "Abort",
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self._startServerTime,
		[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
		[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
		[StatEnum.EventProperties.HoldClueName] = clueList
	})
	self:closeThis()
end

function AergusiDialogViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return AergusiDialogViewContainer
