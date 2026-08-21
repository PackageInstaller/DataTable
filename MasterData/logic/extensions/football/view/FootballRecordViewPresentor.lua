-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballRecordViewPresentor.lua

module("logic.extensions.football.view.FootballRecordViewPresentor", package.seeall)

local M = class("FootballRecordViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Football_football_report_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FootballRecordView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
