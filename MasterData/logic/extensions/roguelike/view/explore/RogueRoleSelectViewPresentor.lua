-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRoleSelectViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueRoleSelectViewPresentor", package.seeall)

local M = class("RogueRoleSelectViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_role_select_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterDepot)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueRoleSelectView.New())
	table.insert(views, RogueRoleSelectSubViewFilter.New())

	return views
end

return M
