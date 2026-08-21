-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/util/SeasonUtil.lua

module("logic.extensions.season.util.SeasonUtil", package.seeall)

function getFirstActiveIdx(moList)
	local activeIdx, finishedIdx = 0, 0

	for idx, mo in ipairs(moList) do
		if mo:getRewardStatus() == SeasonEnum.RewardStatus.AllActive or mo:getRewardStatus() == SeasonEnum.RewardStatus.VipActive then
			activeIdx = idx

			break
		end

		if mo:getRewardStatus() == SeasonEnum.RewardStatus.Finished then
			finishedIdx = idx
		end
	end

	if activeIdx > 0 then
		return activeIdx
	end

	if finishedIdx > 0 then
		return math.min(#moList, finishedIdx + 1)
	end

	return 1
end
