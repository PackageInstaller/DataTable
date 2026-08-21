-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/constconfig/ConstConfig.lua

module("logic.extensions.common.constconfig.ConstConfig", package.seeall)

local ConstConfig = class("ConstConfig", BaseConfig)

function ConstConfig:onInit()
	self._const = nil
	self._setting_frames = {}
end

function ConstConfig:getNames()
	return {
		"const",
		ConfigName.SettingFrame
	}
end

function ConstConfig:handleConfig(name, content)
	if name == "const" then
		self._const = content
	elseif name == ConfigName.SettingFrame then
		self._setting_frames = content
	end
end

function ConstConfig:getConstConfig()
	return self._const
end

function ConstConfig:getConstDataByKey(keyEnum)
	return self._const[keyEnum]
end

function ConstConfig:getStrValueByKey(keyEnum)
	return self._const[keyEnum].strValue
end

function ConstConfig:getNumValueByKey(keyEnum)
	return self._const[keyEnum] and self._const[keyEnum].numValue or 0
end

function ConstConfig:getFloatValueByKey(keyEnum)
	return self._const[keyEnum] and self._const[keyEnum].floatValue or 0
end

function ConstConfig:getStrValuesByKey(keyEnum)
	return self._const[keyEnum].strValues
end

function ConstConfig:getNumValuesByKey(keyEnum)
	return self._const[keyEnum].numValues
end

function ConstConfig:getJsonValueByKey(keyEnum)
	return self._const[keyEnum].jsonObject
end

function ConstConfig:getAllFrameSetting()
	return self._setting_frames.dataList
end

function ConstConfig:getFrameSettingById(id)
	return self._setting_frames[id]
end

function ConstConfig:getFrameSettingByDpi(dpiQuality)
	for k, v in pairs(self._setting_frames) do
		if v.typeLevel == dpiQuality then
			return v
		end
	end

	return nil
end

ConstConfig.instance = ConstConfig.New()

return ConstConfig
