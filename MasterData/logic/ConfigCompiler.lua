-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/config/ConfigCompiler.lua

module("logic.extensions.spineinterface.config.ConfigCompiler", package.seeall)

local ConfigCompiler = class("ConfigCompiler")

function ConfigCompiler:ctor()
	self._adapter = ConfigAdapter.New()
end

function ConfigCompiler:compile(skinId)
	local raw = self._adapter:buildRaw(skinId)

	if raw == nil then
		return nil
	end

	self:_diagnoseRaw(skinId, raw)

	local definition = InteractionDefinition.New()

	definition:onInit(skinId, raw)

	return definition
end

function ConfigCompiler:_diagnoseRaw(skinId, raw)
	if raw.behaviorDataLists == nil then
		printError(string.format("spineinterface behavior config missing, skinId = %s", skinId))

		return
	end

	for behaviorLayerId, behaviorDataList in ipairs(raw.behaviorDataLists) do
		for behaviorId, behaviorData in ipairs(behaviorDataList) do
			if behaviorData.triggerType == nil then
				printError(string.format("spineinterface triggerType missing, skinId = %s, behaviorLayerId = %s, behaviorId = %s", skinId, behaviorLayerId, behaviorId))
			end
		end
	end
end

return ConfigCompiler
