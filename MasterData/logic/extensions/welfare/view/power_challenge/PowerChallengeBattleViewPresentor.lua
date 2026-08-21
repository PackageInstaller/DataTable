-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengeBattleViewPresentor.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengeBattleViewPresentor", package.seeall)

local M = class("PowerChallengeBattleViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Power_challenge_battle_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PowerChallengeBattleView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
