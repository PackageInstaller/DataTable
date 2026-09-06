-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/config/MasterFormConfig.lua

module("logic.extensions.masterform.config.MasterFormConfig", package.seeall)

local MasterFormConfig = class("MasterFormConfig", BaseConfig)

function MasterFormConfig:onInit()
	MasterFormConfig.super.onInit(self)
end

function MasterFormConfig:getNames()
	return {
		"master_form",
		"master_form_system_fmt",
		"master_form_system_pet",
		"master_form_rank_prize",
		"master_form_tag",
		"master_form_threshold",
		"master_form_common",
		"formation_collect_fmt",
		"master_form_hot_pet",
		"master_form_hot_pet_tab"
	}
end

function MasterFormConfig:handleConfig(name, content)
	if name == "master_form" then
		self._mfBaseCfg = content
		self._mfBaseDataList = content.dataList
	elseif name == "master_form_system_fmt" then
		self._mfSysFmtCfgs = content

		self:_handleMfSysFmtCfgs(content.dataList)
	elseif name == "master_form_system_pet" then
		self._mfSysPetCfg = content
	elseif name == "master_form_rank_prize" then
		self._mfRankPrizeCfg = content
	elseif name == "master_form_tag" then
		self._mfTagCfg = content
	elseif name == "master_form_threshold" then
		self._mfThresholdCfg = content
	elseif name == "master_form_common" then
		self._mfCommonCfg = content
	elseif name == "formation_collect_fmt" then
		self._master_form_fmt_collect = content
	elseif name == "master_form_hot_pet" then
		self._master_form_hot_pet = content
	elseif name == "master_form_hot_pet_tab" then
		self._master_form_hot_pet_tab = content
	end
end

function MasterFormConfig:getMfBaseDataList()
	return self._mfBaseDataList
end

function MasterFormConfig:getMfBaseData(periodId)
	return self._mfBaseCfg[periodId]
end

function MasterFormConfig:getMfSysFmtCfg(sysFmtPlanId)
	return self._mfSysFmtCfgs[sysFmtPlanId]
end

function MasterFormConfig:getMfSysFmtData(sysFmtPlanId, index)
	return self._mfSysFmtCfgs[sysFmtPlanId][index]
end

function MasterFormConfig:getMfSysFmtDataById(sysFmtId)
	return self._mfSysFmtDataPool[sysFmtId]
end

function MasterFormConfig:_handleMfSysFmtCfgs(dataList)
	self._mfSysFmtDataPool = {}

	for _, data in ipairs(dataList) do
		self._mfSysFmtDataPool[data.sysFmtId] = data
	end
end

function MasterFormConfig:getMfSysPetData(sysPetId)
	return self._mfSysPetCfg[sysPetId]
end

function MasterFormConfig:getMfRankPrizeCfg(periodId)
	return self._mfRankPrizeCfg[periodId]
end

function MasterFormConfig:getMfRankPrizeData(periodId, rankId)
	return self._mfRankPrizeCfg[periodId][rankId]
end

function MasterFormConfig:getMfTagCfg()
	return self._mfTagCfg
end

function MasterFormConfig:getMfTagData(tagId)
	return self._mfTagCfg[tagId]
end

function MasterFormConfig:getMfThresholdCfg()
	return self._mfThresholdCfg
end

function MasterFormConfig:getMfThresholdData(thresholdId)
	return self._mfThresholdCfg[thresholdId]
end

function MasterFormConfig:getMfCommonValue(key, isToNumber)
	local data = self._mfCommonCfg[key]
	local value = data and data.value

	return isToNumber and checknumber(value) or value
end

function MasterFormConfig:getFmtCollectCfg()
	return self._master_form_fmt_collect
end

function MasterFormConfig:getFmtCollectDataList()
	return (self._master_form_fmt_collect or nil) and (self._master_form_fmt_collect.dataList or {})
end

function MasterFormConfig:getFmtCollectData(fmtId)
	return self._master_form_fmt_collect and self._master_form_fmt_collect[fmtId]
end

function MasterFormConfig:getHotPetCfg(raceId)
	return self._master_form_hot_pet and self._master_form_hot_pet[raceId]
end

function MasterFormConfig:getHotPetTab(hotPetPlanId)
	return self._master_form_hot_pet_tab and self._master_form_hot_pet_tab[hotPetPlanId]
end

MasterFormConfig.instance = MasterFormConfig.New()

return MasterFormConfig
