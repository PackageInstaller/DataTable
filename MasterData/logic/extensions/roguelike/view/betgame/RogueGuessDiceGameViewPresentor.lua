-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/betgame/RogueGuessDiceGameViewPresentor.lua

module("logic.extensions.roguelike.view.betgame.RogueGuessDiceGameViewPresentor", package.seeall)

local M = class("RogueGuessDiceGameViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupgame_guess_dice_game_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueGuessDiceGameView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RogueVendingMachineShowType))

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)
	table.insert(views, TitleView.New(CommEnum.ManualKey.RogueGuess))

	return views
end

return M
