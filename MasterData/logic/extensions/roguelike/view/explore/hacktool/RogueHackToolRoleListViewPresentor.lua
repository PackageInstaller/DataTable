-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolRoleListViewPresentor.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolRoleListViewPresentor", package.seeall)

local M = class("RogueHackToolRoleListViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_role_list_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterDepot)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHackToolRoleListView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
