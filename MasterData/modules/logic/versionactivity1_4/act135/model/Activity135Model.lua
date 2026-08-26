-- chunkname: @modules/logic/versionactivity1_4/act135/model/Activity135Model.lua

module("modules.logic.versionactivity1_4.act135.model.Activity135Model", package.seeall)

local Activity135Model = class("Activity135Model", BaseModel)

function Activity135Model:onInit()
	return
end

function Activity135Model:reInit()
	return
end

function Activity135Model:getActivityShowReward(episodeId)
	local cos = Activity135Config.instance:getEpisodeCos(episodeId)

	if not cos then
		return
	end

	local rewards = {}
	local actDict = {}

	for k, v in pairs(cos) do
		actDict[v.activityId] = true

		if ActivityHelper.getActivityStatus(v.activityId, true) == ActivityEnum.ActivityStatus.Normal then
			local bonusConfig = DungeonConfig.instance:getBonusCO(v.firstBounsId)

			if bonusConfig then
				local reward = GameUtil.splitString2(bonusConfig.fixBonus, true)

				if reward then
					for _, r in ipairs(reward) do
						r.activityId = v.activityId
						r.isLimitFirstReward = true
					end

					tabletool.addValues(rewards, reward)
				end
			end
		end
	end

	return rewards, actDict
end

Activity135Model.instance = Activity135Model.New()

return Activity135Model
