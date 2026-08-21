-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewanimation/BattlePlayBossAnimationViewPresentor.lua

module("logic.extensions.battle.viewanimation.BattlePlayBossAnimationViewPresentor", package.seeall)

local M = class("BattlePlayBossAnimationViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Battle_play_animation
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BattlePlayBossAnimationView.New())

	return views
end

return M
