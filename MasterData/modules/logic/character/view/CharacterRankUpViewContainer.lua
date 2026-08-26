-- chunkname: @modules/logic/character/view/CharacterRankUpViewContainer.lua

module("modules.logic.character.view.CharacterRankUpViewContainer", package.seeall)

local CharacterRankUpViewContainer = class("CharacterRankUpViewContainer", BaseViewContainer)

function CharacterRankUpViewContainer:buildViews()
	local views = {
		CharacterRankUpView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
	local helpShowView = HelpShowView.New()

	helpShowView:setHelpId(HelpEnum.HelpId.CharacterRankUp)
	helpShowView:setDelayTime(0.5)
	table.insert(views, helpShowView)

	return views
end

function CharacterRankUpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local showHelp = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.CharacterRankUp)

		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			showHelp
		}, HelpEnum.HelpId.CharacterRankUp)

		return {
			self._navigateButtonView
		}
	end

	if tabContainerId == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Gold
			})
		}
	end
end

function CharacterRankUpViewContainer:refreshHelp()
	if self._navigateButtonView then
		local showHelp = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.CharacterRankUp)

		self._navigateButtonView:setParam({
			true,
			true,
			showHelp
		})
	end
end

return CharacterRankUpViewContainer
