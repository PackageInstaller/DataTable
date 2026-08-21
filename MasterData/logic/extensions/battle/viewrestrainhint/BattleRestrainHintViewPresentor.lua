-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewrestrainhint/BattleRestrainHintViewPresentor.lua

module("logic.extensions.battle.viewrestrainhint.BattleRestrainHintViewPresentor", package.seeall)

local BattleRestrainHintViewPresentor = class("BattleRestrainHintViewPresentor", ViewPresentor)

function BattleRestrainHintViewPresentor:dependWhatResources()
	return {
		ResName.Battle_restrain_hint_tips
	}
end

function BattleRestrainHintViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleRestrainHintView.New())

	return views
end

return BattleRestrainHintViewPresentor
