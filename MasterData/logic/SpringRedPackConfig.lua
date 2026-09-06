-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/config/SpringRedPackConfig.lua

module("logic.extensions.springredpack.config.SpringRedPackConfig", package.seeall)

local SpringRedPackConfig = class("SpringRedPackConfig", BaseConfig)

function SpringRedPackConfig:onInit()
	SpringRedPackConfig.super.onInit(self)

	self.spring_red_pack_activity = nil
	self.spring_red_pack = nil
	self.spring_red_pack_prize = nil
	self.spring_red_pack_round = nil
	self.spring_red_pack_plan = nil
end

function SpringRedPackConfig:getNames()
	return {
		"spring_red_pack_activity",
		"spring_red_pack",
		"spring_red_pack_prize",
		"spring_red_pack_round",
		"spring_red_pack_plan",
		"spring_red_pack_common_value",
		"spring_red_pack_skin"
	}
end

function SpringRedPackConfig:handleConfig(name, content)
	if name == "spring_red_pack_activity" then
		self.spring_red_pack_activity = content
	elseif name == "spring_red_pack" then
		self.spring_red_pack = content
	elseif name == "spring_red_pack_prize" then
		self.spring_red_pack_prize = content
	elseif name == "spring_red_pack_round" then
		self.spring_red_pack_round = content
	elseif name == "spring_red_pack_plan" then
		self.spring_red_pack_plan = content
	elseif name == "spring_red_pack_common_value" then
		self.spring_red_pack_common_value = content
	elseif name == "spring_red_pack_skin" then
		self.spring_red_pack_skin = content
	end
end

function SpringRedPackConfig:getActivityCfg(activityId)
	return self.spring_red_pack_activity[activityId]
end

function SpringRedPackConfig:getRedPackCfg(redPackId)
	return self.spring_red_pack[redPackId]
end

function SpringRedPackConfig:getRedPackCfgByPrizePlanId(prizePlanId)
	for i, v in ipairs(self.spring_red_pack.dataList) do
		if v.prizePlanId == prizePlanId then
			return v
		end
	end

	return nil
end

function SpringRedPackConfig:getPrizeCfg(prizeId)
	return self.spring_red_pack_prize[prizeId]
end

function SpringRedPackConfig:getPrizeList(prizePlanId, isContainBigPrize)
	local list = self.spring_red_pack_prize.dataList
	local result = {}

	for i, v in ipairs(list) do
		if v.prizePlanId == prizePlanId then
			if isContainBigPrize then
				table.insert(result, v)
			elseif not v.bigPrize then
				table.insert(result, v)
			end
		end
	end

	return result
end

function SpringRedPackConfig:getRoundCfg(activityId, roundId)
	if self.spring_red_pack_round[activityId] then
		return self.spring_red_pack_round[activityId][roundId]
	end
end

function SpringRedPackConfig:getRoundCfgList(activityId)
	return self.spring_red_pack_round[activityId]
end

function SpringRedPackConfig:getPlanCfg(activityId, sort)
	if self.spring_red_pack_plan[activityId] then
		return self.spring_red_pack_plan[activityId][sort]
	end
end

function SpringRedPackConfig:getPlanList(activityId)
	return self.spring_red_pack_plan[activityId] or {}
end

function SpringRedPackConfig:getConstValue(key)
	if self.spring_red_pack_common_value[key] then
		return self.spring_red_pack_common_value[key].value
	end

	return 0
end

function SpringRedPackConfig:getRedPackSkinByRedId(redPackId)
	local skinId = self:getRedPackCfg(redPackId).skinId

	print(">>>>>>>>>>>>>>>>>>>>>>新春红包Cfg", skinId, self.spring_red_pack_skin[skinId])

	return self.spring_red_pack_skin[skinId]
end

SpringRedPackConfig.instance = SpringRedPackConfig.New()

return SpringRedPackConfig
