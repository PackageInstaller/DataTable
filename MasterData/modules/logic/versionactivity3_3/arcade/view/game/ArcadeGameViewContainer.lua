-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/ArcadeGameViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.game.ArcadeGameViewContainer", package.seeall)

local ArcadeGameViewContainer = class("ArcadeGameViewContainer", BaseViewContainer)

function ArcadeGameViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeGameView.New())
	table.insert(views, TabViewGroup.New(1, "Top/#go_currency"))

	return views
end

function ArcadeGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.currencyView = ArcadeCurrencyView.New({
			ArcadeGameEnum.CharacterResource.GameCoin
		}, true)

		return {
			self.currencyView
		}
	end
end

return ArcadeGameViewContainer
