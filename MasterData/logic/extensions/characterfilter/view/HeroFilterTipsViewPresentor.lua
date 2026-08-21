-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterfilter/view/HeroFilterTipsViewPresentor.lua

module("logic.extensions.characterfilter.view.HeroFilterTipsViewPresentor", package.seeall)

local M = class("HeroFilterTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Common_team_filter_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HeroFilterTipsView.New())

	return views
end

return M
