-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengeRewardPresentor.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengeRewardPresentor", package.seeall)

local M = class("PowerChallengeRewardPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Power_challenge_reward_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PowerChallengeReward.New())

	return views
end

return M
