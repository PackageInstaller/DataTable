-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonSummarizeViewPresentor.lua

module("logic.extensions.season.view.SeasonSummarizeViewPresentor", package.seeall)

local M = class("SeasonSummarizeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Season)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SeasonSummarizeView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
