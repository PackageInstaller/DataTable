-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/config/GoddesscollectorConfig.lua

module("logic.extensions.goddesscollector.config.GoddesscollectorConfig", package.seeall)

local GoddesscollectorConfig = class("GoddesscollectorConfig", BaseConfig)

function GoddesscollectorConfig:onInit()
	return
end

function GoddesscollectorConfig:getNames()
	return {
		"goddess_collector_main_tab",
		"goddess_collector",
		"goddess_collector_pet",
		"goddess_collector_skin",
		"goddess_collector_prize",
		"goddess_collector_common",
		"goddess_collector_bless",
		"goddess_collector_rank_prize",
		"goddess_collector_skin_rare_show"
	}
end

function GoddesscollectorConfig:handleConfig(name, content)
	if name == "goddess_collector_main_tab" then
		self._goddess_collector_main_tab = content
	elseif name == "goddess_collector" then
		self._goddess_collector = content
	elseif name == "goddess_collector_pet" then
		self._goddess_collector_pet = content
	elseif name == "goddess_collector_skin" then
		self._goddess_collector_skin = content
	elseif name == "goddess_collector_prize" then
		self._goddess_collector_prize = content
	elseif name == "goddess_collector_common" then
		self._goddess_collector_common = content
	elseif name == "goddess_collector_bless" then
		self._goddess_collector_bless = content
	elseif name == "goddess_collector_rank_prize" then
		self._goddess_collector_rank_prize = content
	elseif name == "goddess_collector_skin_rare_show" then
		self._goddess_collector_skin_rare_show = content
	end
end

function GoddesscollectorConfig:getTabCfgs()
	return self._goddess_collector_main_tab.dataList
end

function GoddesscollectorConfig:getActCfg(activityId)
	return self._goddess_collector[activityId]
end

function GoddesscollectorConfig:getPetCfg(petPlanId)
	return self._goddess_collector_pet[petPlanId]
end

function GoddesscollectorConfig:getCollectorPrizeCfg(activityId)
	return self._goddess_collector_rank_prize[activityId]
end

function GoddesscollectorConfig:getPrizeCfgs(prizePlanId)
	return self._goddess_collector_prize[prizePlanId]
end

function GoddesscollectorConfig:getPrizeCfg(prizePlanId, prizeId)
	return self._goddess_collector_prize[prizePlanId][prizeId]
end

function GoddesscollectorConfig:getSkinCfgs(skinPlanId)
	return self._goddess_collector_skin[skinPlanId]
end

function GoddesscollectorConfig:getCommonValue(key, need2number)
	local value = self._goddess_collector_common[key].value

	if need2number then
		value = checkint(value)
	end

	return value
end

function GoddesscollectorConfig:getBlessClientCfgs()
	return self._goddess_collector_bless.dataList
end

function GoddesscollectorConfig:getSkinRareShowCfgsByQualityId(skinRareShowPlanId, qualityId)
	return self._goddess_collector_skin_rare_show[skinRareShowPlanId] and self._goddess_collector_skin_rare_show[skinRareShowPlanId][qualityId]
end

function GoddesscollectorConfig:getQualityToSkinIdDic(skinPlanId, qualityList)
	local qualityDic = {}
	local skinCfgs = self._goddess_collector_skin[skinPlanId]

	for idx, qualityId in ipairs(qualityList) do
		qualityDic[qualityId] = {}
	end

	if skinCfgs then
		for idx, skinCfg in ipairs(skinCfgs) do
			local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinCfg.skinId)
			local qualityId = petSkinCfg.quality

			if qualityDic[qualityId] then
				table.insert(qualityDic[qualityId], skinCfg)
			end
		end
	end

	return qualityDic
end

GoddesscollectorConfig.instance = GoddesscollectorConfig.New()

return GoddesscollectorConfig
