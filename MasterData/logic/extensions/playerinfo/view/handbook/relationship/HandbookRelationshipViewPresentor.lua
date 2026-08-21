-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationshipViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationshipViewPresentor", package.seeall)

local M = class("HandbookRelationshipViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_relationship_view,
		ResName.Handbook_handbook_relationship_hero_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRelationshipView.New())

	return views
end

return M
