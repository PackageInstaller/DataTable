-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryVersionConfigBase.lua

module("modules.logic.necrologiststory.config.NecrologistStoryVersionConfigBase", package.seeall)

local NecrologistStoryVersionConfigBase = class("NecrologistStoryVersionConfigBase", BaseConfig)

function NecrologistStoryVersionConfigBase:onConfigLoaded(configName, configTable)
	local loadFuncName = string.format("onLoad%s", configName)
	local func = self[loadFuncName]

	if func then
		func(self, configTable)
	end
end

return NecrologistStoryVersionConfigBase
