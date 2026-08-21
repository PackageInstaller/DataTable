-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleCalculatePresentor.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleCalculatePresentor", package.seeall)

local M = class("AirWorkBattleCalculatePresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_calculate
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkBattleCalculateView.New())

	return views
end

return M
