-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/config/SpineInterfaceConfig.lua

module("logic.extensions.spineinterface.config.SpineInterfaceConfig", package.seeall)

local SpineInterfaceConfig = class("SpineInterfaceConfig", BaseConfig)

function SpineInterfaceConfig:onInit()
	SpineInterfaceConfig.super.onInit(self)
end

function SpineInterfaceConfig:getNames()
	return {
		"md_spine_base",
		"md_spine_public_params",
		"md_spine_spine_params",
		"md_spine_spine_params_dictionary",
		"md_spine_behavior",
		"md_spine_spine_event"
	}
end

function SpineInterfaceConfig:handleConfig(name, content)
	if name == "md_spine_base" then
		self._msBaseCfg = content

		self:_checkMsBaseCfg()
	elseif name == "md_spine_public_params" then
		self._msPubParamsCfg = content
	elseif name == "md_spine_spine_params" then
		self._msSpParamsCfg = content
	elseif name == "md_spine_spine_params_dictionary" then
		self._msSpParamsDicCfg = content
	elseif name == "md_spine_behavior" then
		self._msBehaviorCfg = content
	elseif name == "md_spine_spine_event" then
		self._msSpineEventCfg = content
	end
end

function SpineInterfaceConfig:getMsBaseDataList()
	return self._msBaseCfg.dataList
end

function SpineInterfaceConfig:getMsBaseData(skinId)
	return self._msBaseCfg[skinId]
end

function SpineInterfaceConfig:getSkinPlanId(skinId)
	local data = self:getMsBaseData(skinId)

	return data.skinPlanId
end

function SpineInterfaceConfig:getSpineUrl(skinId)
	local data = self:getMsBaseData(skinId)

	return data.spineUrl
end

function SpineInterfaceConfig:_checkMsBaseCfg()
	local dataList = self:getMsBaseDataList()

	for _, data in ipairs(dataList) do
		local skinData = PetSkinConfig.instance:getPetSkinCfg(data.skinId)

		if skinData and skinData.skinGroup > 0 then
			local skinGroup = PetSkinConfig.instance:getPetSkinListBySkinGroup(skinData.skinGroup)

			for _, skinGroupData in ipairs(skinGroup) do
				local baseData = self:getMsBaseData(skinGroupData.skinId)

				if baseData == nil and enableDebug then
					local name = PetSkinConfig.instance:getPetSkinName(skinGroupData.skinId)

					printError(string.format("皮肤交互漏配精灵[%s], skinGroup:%s, skinId:%s ( j精灵皮肤.xlsx # m模型骨骼动画交互行为表.xlsx )", name, skinGroupData.skinGroup, skinGroupData.skinId))
				end
			end
		end
	end
end

function SpineInterfaceConfig:getMsPubParamsDataList(skinId)
	local skinPlanId = self:getSkinPlanId(skinId)

	return self._msPubParamsCfg[skinPlanId]
end

function SpineInterfaceConfig:getMsPubParamsData(skinId, publicParamId)
	local dataList = self:getMsPubParamsDataList(skinId)

	return dataList[publicParamId]
end

function SpineInterfaceConfig:getMsSpParamsDataList(skinId)
	local skinPlanId = self:getSkinPlanId(skinId)

	return self._msSpParamsCfg[skinPlanId]
end

function SpineInterfaceConfig:getMsSpParamsData(skinId, spineParamId)
	local dataList = self:getMsSpParamsDataList(skinId)

	return dataList[spineParamId]
end

function SpineInterfaceConfig:getMsSpParamsDicData(spineParamDicId)
	return self._msSpParamsDicCfg[spineParamDicId]
end

function SpineInterfaceConfig:getMsBehaviorDataLists(skinId)
	local skinPlanId = self:getSkinPlanId(skinId)

	return self._msBehaviorCfg[skinPlanId]
end

function SpineInterfaceConfig:getMsBehaviorDataList(skinId, behaviorLayerId)
	local skinPlanId = self:getSkinPlanId(skinId)

	return self._msBehaviorCfg[skinPlanId][behaviorLayerId]
end

function SpineInterfaceConfig:getMsBehaviorData(skinId, behaviorLayerId, behaviorId)
	local skinPlanId = self:getSkinPlanId(skinId)

	return self._msBehaviorCfg[skinPlanId][behaviorLayerId][behaviorId]
end

function SpineInterfaceConfig:getMsSpineEventData(spineEventId)
	return self._msSpineEventCfg[spineEventId]
end

SpineInterfaceConfig.instance = SpineInterfaceConfig.New()

return SpineInterfaceConfig
