-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMonsterCardViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMonsterCardViewPresentor", package.seeall)

local M = class("RogueMonsterCardViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_card_select_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMonsterCardView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
