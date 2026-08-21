-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMeetMonsterViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMeetMonsterViewPresentor", package.seeall)

local M = class("RogueMeetMonsterViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupjudgement_run_group_battle_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMeetMonsterView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
