-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankViewPresentor.lua

module("logic.extensions.rank.view.RankViewPresentor", package.seeall)

local M = class("RankViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.RankView,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_AirWorkShop)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RankView.New())

	return views
end

return M
