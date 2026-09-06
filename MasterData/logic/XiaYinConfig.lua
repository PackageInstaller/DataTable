-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/config/XiaYinConfig.lua

module("logic.extensions.xiayin.config.XiaYinConfig", package.seeall)

local XiaYinConfig = class("XiaYinConfig", BaseConfig)

function XiaYinConfig:onInit()
	XiaYinConfig.super.onInit(self)

	self.xia_yin_activity = nil
	self.xia_yin_tier = nil
	self.xia_yin_progress_prize = nil
	self.xia_yin_monster = nil
	self.xia_yin_creeps = nil
	self.xia_yin_common = nil
end

function XiaYinConfig:getNames()
	return {
		"xia_yin_activity",
		"xia_yin_tier",
		"xia_yin_progress_prize",
		"xia_yin_monster",
		"xia_yin_creeps",
		"xia_yin_common",
		"xia_yin_sign_in_buff"
	}
end

function XiaYinConfig:handleConfig(name, content)
	if name == "xia_yin_activity" then
		self.xia_yin_activity = content
	elseif name == "xia_yin_tier" then
		self.xia_yin_tier = content
	elseif name == "xia_yin_progress_prize" then
		self.xia_yin_progress_prize = content
	elseif name == "xia_yin_monster" then
		self.xia_yin_monster = content
	elseif name == "xia_yin_creeps" then
		self.xia_yin_creeps = content
	elseif name == "xia_yin_common" then
		self.xia_yin_common = content
	elseif name == "xia_yin_sign_in_buff" then
		self._xia_yin_sign_in_buff = content
	end
end

function XiaYinConfig:getActivityCfg(activityId)
	return self.xia_yin_activity[activityId]
end

function XiaYinConfig:getTierCfgList(activityId)
	return self.xia_yin_tier[activityId]
end

function XiaYinConfig:getTierCfg(activityId, tierId)
	return self.xia_yin_tier[activityId] and self.xia_yin_tier[activityId][tierId]
end

function XiaYinConfig:getPrizeCfgList(activityId)
	return self.xia_yin_progress_prize[activityId]
end

function XiaYinConfig:getPrizeCfg(activityId, prizeId)
	return self.xia_yin_progress_prize[activityId] and self.xia_yin_progress_prize[activityId][prizeId]
end

function XiaYinConfig:getMonsterCfg(creepsMasterId)
	return self.xia_yin_monster[creepsMasterId]
end

function XiaYinConfig:getCreeps(creepsMasterId)
	return self.xia_yin_creeps[creepsMasterId]
end

function XiaYinConfig:getSortCreeps(creepsMasterId)
	local list = {}
	local tempList = self:getCreeps(creepsMasterId)

	for i, v in ipairs(tempList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.posId < b.posId
	end)

	return list
end

function XiaYinConfig:getCommonValue(key)
	return self.xia_yin_common[key] and self.xia_yin_common[key].value
end

function XiaYinConfig:getSignBuffCfg(signInPlanId, level)
	return self._xia_yin_sign_in_buff[signInPlanId][level]
end

XiaYinConfig.instance = XiaYinConfig.New()

return XiaYinConfig
