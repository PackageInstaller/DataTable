-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleResultViewPresentor.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleResultViewPresentor", package.seeall)

local M = class("AirWorkBattleResultViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_calculate_result
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkBattleResultView.New())

	return views
end

return M
