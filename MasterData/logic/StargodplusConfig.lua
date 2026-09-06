-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/config/StargodplusConfig.lua

module("logic.extensions.stargodplus.config.StargodplusConfig", package.seeall)

local StargodplusConfig = class("StargodplusConfig", BaseConfig)

function StargodplusConfig:onInit()
	return
end

function StargodplusConfig:getNames()
	return {
		"star_god_plus_slot",
		"star_god_plus_slot_lv_plan",
		"star_god_plus_filler",
		"star_god_plus_filler_prop",
		"star_god_plus_common",
		"star_god_plus_recommend",
		"star_god_plus_type_rank"
	}
end

function StargodplusConfig:handleConfig(name, content)
	if name == "star_god_plus_slot" then
		self._star_god_plus_slotCfg = content
	elseif name == "star_god_plus_slot_lv_plan" then
		self._star_god_plus_slot_lv_planCfg = content
	elseif name == "star_god_plus_filler" then
		self._star_god_plus_fillerCfg = content
	elseif name == "star_god_plus_filler_prop" then
		self._star_god_plus_filler_propCfg = content
	elseif name == "star_god_plus_common" then
		self._star_god_plus_commonCfg = content
	elseif name == "star_god_plus_recommend" then
		self._star_god_plus_recommendCfg = content
	elseif name == "star_god_plus_type_rank" then
		self._star_god_plus_type_rank = content
	end
end

function StargodplusConfig:getFillerCfgs()
	return self._star_god_plus_fillerCfg
end

function StargodplusConfig:getFillerCfg(id)
	return self._star_god_plus_fillerCfg[id]
end

function StargodplusConfig:getSlotCfgs()
	return self._star_god_plus_slotCfg
end

function StargodplusConfig:getSlotCfg(id)
	return self._star_god_plus_slotCfg[id]
end

function StargodplusConfig:getSlotLvPlan(id)
	return self._star_god_plus_slot_lv_planCfg[id]
end

function StargodplusConfig:getSlotLvPlanByLv(id, lv)
	return self._star_god_plus_slot_lv_planCfg[id][lv]
end

function StargodplusConfig:getCommonValue(key)
	if self._star_god_plus_commonCfg[key] then
		return self._star_god_plus_commonCfg[key].value
	end
end

function StargodplusConfig:getMaxSelectStrenNum()
	return checknumber(self._star_god_plus_commonCfg.MAX_STRENGTHEN_LIMIT.value)
end

function StargodplusConfig:getCommonStrenMatDatas()
	local str1 = self._star_god_plus_commonCfg.UPGRADE_MATERIAL_IDS.value
	local str2 = self._star_god_plus_commonCfg.UPGRADE_MATERIAL_EXPS.value
	local list1 = string.split(str1, ",")
	local list2 = string.split(str2, ",")
	local resList = {}

	for i, v in ipairs(list1) do
		table.insert(resList, {
			matType = MatType.Item,
			matId = checknumber(v),
			exp = checknumber(list2[i])
		})
	end

	return resList
end

function StargodplusConfig:getDecomposeTipsQuality()
	return checknumber(self._star_god_plus_commonCfg.DECOMPOSE_TIPS_QUALITY.value)
end

function StargodplusConfig:getExp2CoinRatio()
	return checknumber(self._star_god_plus_commonCfg.UPGRADE_COIN_EXP_RATIO.value)
end

function StargodplusConfig:getRecommendCfg(id, slot)
	return self._star_god_plus_recommendCfg[id][slot]
end

function StargodplusConfig:getRecommendCfgs(id)
	return self._star_god_plus_recommendCfg[id]
end

function StargodplusConfig:getPropCfg(defineId, slotLv)
	return self._star_god_plus_filler_propCfg[defineId][slotLv]
end

function StargodplusConfig:getJobTypeRank(jobTypeIdx)
	if not self._star_god_plus_type_rank[jobTypeIdx] then
		printError("config from export_星神类型排序  in  x星神plus.xlsx  没有配置类型：", jobTypeIdx)
	end

	return self._star_god_plus_type_rank[jobTypeIdx]
end

StargodplusConfig.instance = StargodplusConfig.New()

return StargodplusConfig
