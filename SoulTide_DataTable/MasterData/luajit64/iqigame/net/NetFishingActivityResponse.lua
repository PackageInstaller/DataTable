-- chunkname: @IQIGame\\Net\\NetFishingActivityResponse.lua

function net_fishingActivity.fishingResult(code, fish)
	FishingActivityModule.FishingResult(fish)
end

function net_fishingActivity.fishingConfirmResult(code)
	FishingActivityModule.FishingConfirmResult()
end

function net_fishingActivity.getAutoFishingRewardsResult(code, fishes, autoFishingRewardsTim)
	FishingActivityModule.GetAutoFishingRewardsResult(fishes, autoFishingRewardsTim)
end

function net_fishingActivity.upRoleResult(code, level)
	FishingActivityModule.UpRoleResult(level)
end

function net_fishingActivity.upSkillResult(code, id, level)
	FishingActivityModule.UpSkillResult(id, level)
end

function net_fishingActivity.upActionResult(code, id, level)
	FishingActivityModule.UpActionResult(id, level)
end

function net_fishingActivity.getStoryRewardsResult(code, itemShows)
	FishingActivityModule.GetStoryRewardsResult(itemShows)
end
