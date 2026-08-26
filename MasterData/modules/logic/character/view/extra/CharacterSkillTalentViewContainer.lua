-- chunkname: @modules/logic/character/view/extra/CharacterSkillTalentViewContainer.lua

module("modules.logic.character.view.extra.CharacterSkillTalentViewContainer", package.seeall)

local CharacterSkillTalentViewContainer = class("CharacterSkillTalentViewContainer", BaseViewContainer)

function CharacterSkillTalentViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkillTalentTreeView.New())
	table.insert(views, CharacterSkillTalentNodeTipView.New())
	table.insert(views, CharacterSkillTalentView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CharacterSkillTalentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Hero3124TalentSkillView)

		return {
			self.navigateView
		}
	end
end

return CharacterSkillTalentViewContainer
