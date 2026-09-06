-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/config/ConfigAdapter.lua

module("logic.extensions.spineinterface.config.ConfigAdapter", package.seeall)

local ConfigAdapter = class("ConfigAdapter")

function ConfigAdapter:ctor()
	return
end

function ConfigAdapter:buildRaw(skinId)
	skinId = checknumber(skinId)

	local raw = {}
	local cfg = SpineInterfaceConfig.instance

	raw.skinId = skinId
	raw.baseData = cfg:getMsBaseData(skinId)

	if raw.baseData == nil then
		printError(string.format("spineinterface config missing base data, skinId = %s", skinId))

		return nil
	end

	raw.skinPlanId = cfg:getSkinPlanId(skinId)
	raw.publicParams = cfg:getMsPubParamsDataList(skinId)
	raw.spineParams = cfg:getMsSpParamsDataList(skinId)
	raw.behaviorDataLists = cfg:getMsBehaviorDataLists(skinId)
	raw.spineParamDic = cfg._msSpParamsDicCfg
	raw.spineEvents = cfg._msSpineEventCfg

	return raw
end

return ConfigAdapter
