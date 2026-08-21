-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleCalculateViewNewPresentor.lua

module("logic.extensions.battle.viewcalculate.BattleCalculateViewNewPresentor", package.seeall)

local BattleCalculateViewNewPresentor = class("BattleCalculateViewNewPresentor", ViewPresentor)

function BattleCalculateViewNewPresentor:dependWhatResources()
	return {
		BattleResourceName.UICalculate2
	}
end

function BattleCalculateViewNewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleCalculate2View.New())

	return views
end

return BattleCalculateViewNewPresentor
