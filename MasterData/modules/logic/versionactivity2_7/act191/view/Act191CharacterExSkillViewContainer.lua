-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CharacterExSkillViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterExSkillViewContainer", package.seeall)

local Act191CharacterExSkillViewContainer = class("Act191CharacterExSkillViewContainer", BaseViewContainer)

function Act191CharacterExSkillViewContainer:buildViews()
	return {
		Act191CharacterExSkillView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Act191CharacterExSkillViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

function Act191CharacterExSkillViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
end

return Act191CharacterExSkillViewContainer
