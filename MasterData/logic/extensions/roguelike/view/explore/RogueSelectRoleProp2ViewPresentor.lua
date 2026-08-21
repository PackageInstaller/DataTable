-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSelectRoleProp2ViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueSelectRoleProp2ViewPresentor", package.seeall)

local M = class("RogueSelectRoleProp2ViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_props_select_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueSelectRolePropView.New())

	local blurView = BlurBgView.New()

	table.insert(views, blurView)

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return M
