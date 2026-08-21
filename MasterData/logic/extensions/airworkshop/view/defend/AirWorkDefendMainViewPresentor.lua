-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/defend/AirWorkDefendMainViewPresentor.lua

module("logic.extensions.airworkshop.view.defend.AirWorkDefendMainViewPresentor", package.seeall)

local M = class("AirWorkDefendMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Defend_defend_create_schema_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkDefendMainView.New())

	return views
end

return M
