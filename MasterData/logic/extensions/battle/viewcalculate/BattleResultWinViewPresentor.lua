-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleResultWinViewPresentor.lua

module("logic.extensions.battle.viewcalculate.BattleResultWinViewPresentor", package.seeall)

local M = class("BattleResultWinViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		BattleResourceName.UIBattleResultView
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BattleResultWinView.New())

	return views
end

return M
