-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/view/TeamTipsViewPresentor.lua

module("logic.extensions.team.view.TeamTipsViewPresentor", package.seeall)

local M = class("TeamTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Team_team_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TeamTipsView.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.TeamTipsViewPresentor)
end

return M
