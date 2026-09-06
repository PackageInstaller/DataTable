-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialrecover/config/MaterialRecoverConfig.lua

module("logic.extensions.materialrecover.config.MaterialRecoverConfig", package.seeall)

local MaterialRecoverConfig = class("MaterialRecoverConfig", BaseConfig)

function MaterialRecoverConfig:getNames()
	return {
		"material_recover_define",
		"material_recover_common"
	}
end

function MaterialRecoverConfig:handleConfig(name, content)
	if name == "material_recover_define" then
		self._recoverDefine = content
	elseif name == "material_recover_common" then
		self._recoverCommon = content
	end
end

function MaterialRecoverConfig:getRecoverDefine(funType)
	return self._recoverDefine[funType]
end

function MaterialRecoverConfig:getAllRecoverDefines()
	return self._recoverDefine.dataList
end

function MaterialRecoverConfig:getRecoverNormalPercent()
	return checknumber(self._recoverCommon.FREE_RECOVER_PERCENT.value)
end

function MaterialRecoverConfig:getRecoverPerfectPercent()
	return checknumber(self._recoverCommon.PERFECT_RECOVER_PERCENT.value)
end

MaterialRecoverConfig.instance = MaterialRecoverConfig.New()

return MaterialRecoverConfig
