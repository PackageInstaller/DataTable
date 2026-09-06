-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/config/ReviveElizabethConfig.lua

module("logic.extensions.reviveelizabeth.config.ReviveElizabethConfig", package.seeall)

local ReviveElizabethConfig = class("ReviveElizabethConfig", BaseConfig)

function ReviveElizabethConfig:getNames()
	return {
		"revive_elizabeth_activity",
		"revive_elizabeth_world_progress_prize",
		"revive_elizabeth_user_progress_prize",
		"revive_elizabeth_soul",
		"revive_elizabeth_rand_plan",
		"revive_elizabeth_message",
		"revive_elizabeth_story"
	}
end

function ReviveElizabethConfig:handleConfig(name, content)
	if name == "revive_elizabeth_activity" then
		self._revive_elizabeth_activity = content
	elseif name == "revive_elizabeth_world_progress_prize" then
		self._revive_elizabeth_world_progress_prize = content
	elseif name == "revive_elizabeth_user_progress_prize" then
		self._revive_elizabeth_user_progress_prize = content
	elseif name == "revive_elizabeth_soul" then
		self._revive_elizabeth_soul = content
	elseif name == "revive_elizabeth_rand_plan" then
		self._revive_elizabeth_rand_plan = content
	elseif name == "revive_elizabeth_message" then
		self._revive_elizabeth_message = content
	elseif name == "revive_elizabeth_story" then
		self._revive_elizabeth_story = content
	end
end

function ReviveElizabethConfig:getActivityCfg(activityId)
	return self._revive_elizabeth_activity[activityId]
end

function ReviveElizabethConfig:getWorldProgressPrizeCfg(activityId)
	return self._revive_elizabeth_world_progress_prize[activityId]
end

function ReviveElizabethConfig:getUserProgressPrizeCfg(activityId)
	return self._revive_elizabeth_user_progress_prize[activityId]
end

function ReviveElizabethConfig:getReviveElizabethSoulCfg(activityId)
	return self._revive_elizabeth_soul[activityId]
end

function ReviveElizabethConfig:getReviveElizabethSoulOnceCfg(activityId, flowerId)
	return self._revive_elizabeth_soul[activityId][flowerId]
end

function ReviveElizabethConfig:getRandPlanValue(key)
	return self._revive_elizabeth_rand_plan[key].value
end

function ReviveElizabethConfig:getMessage()
	return self._revive_elizabeth_message
end

function ReviveElizabethConfig:getSoulConfig(activityId)
	print("[YuTestPrint] =====>\t getSoulConfig运行")

	if self.flowerCfg and self.flowerCfg[activityId] then
		return self.flowerCfg[activityId]
	end

	self.flowerCfg = self.flowerCfg or {}
	self.flowerCfg[activityId] = self.flowerCfg[activityId] or {}

	local soulCfg = self:getReviveElizabethSoulCfg(activityId)
	local progCfg = self:getUserProgressPrizeCfg(activityId)

	for i, soul in ipairs(soulCfg) do
		for i, prog in ipairs(progCfg) do
			if prog.flowerId and prog.flowerId == soul.flowerId then
				table.insert(self.flowerCfg[activityId], {
					flowerId = soul.flowerId,
					flowerIcon = soul.flowerIcon,
					flowerContent = soul.flowerContent,
					prizeId = prog.prizeId,
					progress = prog.progress
				})
			end
		end
	end

	table.sort(self.flowerCfg[activityId], function(a, b)
		return a.flowerId < b.flowerId
	end)

	return self.flowerCfg[activityId]
end

function ReviveElizabethConfig:getStoryConfig(activityId)
	print("[YuTestPrint] =====>\t getStoryConfig运行")

	if self.storyCfg and self.storyCfg[activityId] then
		return self.storyCfg[activityId]
	end

	self.storyCfg = self.storyCfg or {}
	self.storyCfg[activityId] = self.storyCfg[activityId] or {}

	local worldProgCfg = self:getWorldProgressPrizeCfg(activityId)

	for i, v in ipairs(worldProgCfg) do
		if v.storyId and v.storyId > 0 then
			table.insert(self.storyCfg[activityId], {
				storyId = v.storyId,
				content = self._revive_elizabeth_story[v.storyId].content,
				prizeId = v.prizeId
			})
		end
	end

	return self.storyCfg[activityId]
end

ReviveElizabethConfig.instance = ReviveElizabethConfig.New()

return ReviveElizabethConfig
