-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaEpsiodeDetailViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEpsiodeDetailViewContainer", package.seeall)

local AiZiLaEpsiodeDetailViewContainer = class("AiZiLaEpsiodeDetailViewContainer", BaseViewContainer)

function AiZiLaEpsiodeDetailViewContainer:buildViews()
	local views = {}

	self._detailView = AiZiLaEpsiodeDetailView.New()

	table.insert(views, self._detailView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaEpsiodeDetailViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AiZiLaEpsiodeDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function AiZiLaEpsiodeDetailViewContainer:playViewAnimator(animName)
	self._detailView:playViewAnimator(animName)
end

return AiZiLaEpsiodeDetailViewContainer
