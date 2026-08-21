-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/AttributeDefineConfig.lua

module("logic.battle.config.AttributeDefineConfig", package.seeall)

local AttributeDefineConfig = class("AttributeDefineConfig", BaseConfig)

function AttributeDefineConfig:onInit()
	self._attributeCfgInfo = false
	self._attributePartCfgInfo = false
	self._attributeValue2AttributeCfg = {}
end

function AttributeDefineConfig:getNames()
	return {
		ConfigName.AttributeDefine,
		ConfigName.AttributePartDefine
	}
end

function AttributeDefineConfig:handleConfig(name, content)
	if name == ConfigName.AttributeDefine then
		self._attributeCfgInfo = content

		self:_buildAttribute2COCache()
	elseif name == ConfigName.AttributePartDefine then
		self._attributePartCfgInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function AttributeDefineConfig:getAttributePartDefineCO(code)
	local config = self._attributePartCfgInfo[code]

	if not config and enableErrorLog then
		printError("AttributeDefineConfig::Cannot find config for", code)
	end

	return config
end

function AttributeDefineConfig:getAttributeCO(code)
	local config = self._attributeCfgInfo[code]

	if not config and enableErrorLog then
		printError("AttributeDefineConfig::Cannot find config for", code)
	end

	return config
end

function AttributeDefineConfig:getAttributeCOByAttribute(attribute)
	local config = self._attributeValue2AttributeCfg[attribute]

	if not config and enableErrorLog then
		printError("AttributeDefineConfig::Cannot find config for", attribute)
	end

	return config
end

function AttributeDefineConfig:getAttributeCOByProgramming(programming)
	local attribute = BattleExtension_pb.Attribute[programming]

	return self:getAttributeCOByAttribute(attribute)
end

function AttributeDefineConfig:_buildAttribute2COCache()
	for _, v in ipairs(self._attributeCfgInfo.dataList) do
		if not string.nilorempty(v.programming) then
			local attribute = BattleExtension_pb.Attribute[v.programming]

			if attribute then
				self._attributeValue2AttributeCfg[attribute] = v
			end
		end
	end
end

function AttributeDefineConfig:getAttributePartByProgramming(programming)
	for _, co in ipairs(self._attributePartCfgInfo.dataList) do
		if co.programming == programming then
			return co
		end
	end

	printError("Cannot find attribute part by:", programming)

	return nil
end

AttributeDefineConfig.instance = AttributeDefineConfig.New()

return AttributeDefineConfig
