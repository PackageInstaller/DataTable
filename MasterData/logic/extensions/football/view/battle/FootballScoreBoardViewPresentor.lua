-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/FootballScoreBoardViewPresentor.lua

module("logic.extensions.football.view.battle.FootballScoreBoardViewPresentor", package.seeall)

local M = class("FootballScoreBoardViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Battle_pvp_score_board
	}
end

function M:attachToWhichRoot()
	return ViewRootType.HudTop
end

function M:buildViews()
	local views = {}

	table.insert(views, FootballScoreBoardView.New())

	return views
end

return M
