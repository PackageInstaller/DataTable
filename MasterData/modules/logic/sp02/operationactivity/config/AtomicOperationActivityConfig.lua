-- chunkname: @modules/logic/sp02/operationactivity/config/AtomicOperationActivityConfig.lua

module("modules.logic.sp02.operationactivity.config.AtomicOperationActivityConfig", package.seeall)

local AtomicOperationActivityConfig = class("AtomicOperationActivityConfig", BaseConfig)

function AtomicOperationActivityConfig:reqConfigNames()
	return {
		"activity235_preparation",
		"activity235_const",
		"activity235_target"
	}
end

function AtomicOperationActivityConfig:onInit()
	return
end

function AtomicOperationActivityConfig:onConfigLoaded(configName, configTable)
	if configName == "activity235_preparation" then
		self.preparationConfig = configTable
	elseif configName == "activity235_const" then
		self.constConfig = configTable
	elseif configName == "activity235_target" then
		self.targetConfig = configTable
	end
end

function AtomicOperationActivityConfig:getConstNum(constId)
	local constStr = self:getConstStr(constId)

	if string.nilorempty(constStr) then
		return 0
	else
		return tonumber(constStr)
	end
end

function AtomicOperationActivityConfig:getConstStr(constId)
	local constCO = self.constConfig.configDict[constId]

	if not constCO then
		return nil
	end

	local value = constCO.value

	if not string.nilorempty(value) then
		return value
	end

	return constCO.value2
end

function AtomicOperationActivityConfig:getPreparationConfig(id)
	if not self.preparationConfig then
		return nil
	end

	return self.preparationConfig.configDict[id]
end

function AtomicOperationActivityConfig:getPreparationConfigList()
	if not self.preparationConfig then
		return nil
	end

	return self.preparationConfig.configList
end

function AtomicOperationActivityConfig:getTargetConfig(id)
	if not self.targetConfig then
		return nil
	end

	return self.targetConfig.configDict[id]
end

function AtomicOperationActivityConfig:getTargetConfigList()
	if not self.targetConfig then
		return nil
	end

	return self.targetConfig.configList
end

AtomicOperationActivityConfig.instance = AtomicOperationActivityConfig.New()

return AtomicOperationActivityConfig
