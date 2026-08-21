-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/MaterialDungeonViewPresentor.lua

module("logic.extensions.dungeon.view.materialdungeon.MaterialDungeonViewPresentor", package.seeall)

local M = class("MaterialDungeonViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Resources_explore_resources_main_view,
		ResName.Resources_explore_resources_level_item,
		ResName.Resources_explore_resource_tab,
		ResName.Common_enemy_head,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Material),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Fight),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_ResourcesExplore)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MaterialDungeonView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	return views
end

return M
