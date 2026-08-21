-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolMapViewPresentor.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolMapViewPresentor", package.seeall)

local M = class("RogueHackToolMapViewPresentor", ViewPresentor)
local Urls = {}

table.insert(Urls, ResName.Rungroupexplore_run_group_main_view)

M.Url_Plane_Empty = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/plane_empty")

table.insert(Urls, ResName.Line_line)
table.insert(Urls, ResName.Line_line_Y)
table.insert(Urls, ResName.Line_point)
table.insert(Urls, M.Url_Plane_Empty)
table.insert(Urls, IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice))

function M:dependWhatResources()
	return Urls
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHackToolMapView.New())

	return views
end

return M
