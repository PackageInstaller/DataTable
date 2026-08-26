-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTrialCharacterTalentViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyTrialCharacterTalentViewContainer", package.seeall)

local OdysseyTrialCharacterTalentViewContainer = class("OdysseyTrialCharacterTalentViewContainer", BaseViewContainer)

function OdysseyTrialCharacterTalentViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyTrialCharacterTalentTreeView.New())
	table.insert(views, OdysseyTrialCharacterTalentNodeTipView.New())
	table.insert(views, OdysseyTrialCharacterSkillTalentView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function OdysseyTrialCharacterTalentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return OdysseyTrialCharacterTalentViewContainer
