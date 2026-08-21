-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/LotteryHacktoolSelectViewPresentor.lua

module("logic.extensions.hacktool.view.LotteryHacktoolSelectViewPresentor", package.seeall)

local M = class("LotteryHacktoolSelectViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Characterdepot_character_depot_main_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterDepot)
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, LotteryHacktoolSelectView.New())

	return views
end

return M
