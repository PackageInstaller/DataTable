-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/config/PowerCrystalConfig.lua

module("logic.extensions.powercrystal.config.PowerCrystalConfig", package.seeall)

local PowerCrystalConfig = class("PowerCrystalConfig", BaseConfig)

function PowerCrystalConfig:onInit()
	PowerCrystalConfig.super.onInit(self)

	self._cofigDialogCfg = nil
	self._cofigParamCfg = nil
	self._cofigUnlockCostCfg = nil
end

function PowerCrystalConfig:getNames()
	return {
		"power_crystal_dialog",
		"power_crystal_param",
		"power_crystal_unlock_cost"
	}
end

function PowerCrystalConfig:handleConfig(name, content)
	if name == "power_crystal_dialog" then
		self._cofigDialogCfg = content
	elseif name == "power_crystal_param" then
		self._cofigParamCfg = content
	elseif name == "power_crystal_unlock_cost" then
		self._cofigUnlockCostCfg = content
	end
end

function PowerCrystalConfig:getBubbleDesById(id)
	return (self._cofigDialogCfg and self._cofigDialogCfg[id] or nil) and (self._cofigDialogCfg[id][2] or "")
end

function PowerCrystalConfig:getBubbleNum()
	return (self._cofigDialogCfg or nil) and (#self._cofigDialogCfg or 5)
end

function PowerCrystalConfig:getSlotUnLockCostCdg(slotId)
	return self._cofigUnlockCostCfg and self._cofigUnlockCostCfg[slotId]
end

function PowerCrystalConfig:getSlotMaxNum()
	return (self._cofigUnlockCostCfg or nil) and (#self._cofigUnlockCostCfg or 20)
end

function PowerCrystalConfig:getSlotCfg()
	return self._cofigUnlockCostCfg
end

function PowerCrystalConfig:getSlotMaxCoolTimeStr()
	return (self._cofigParamCfg and self._cofigParamCfg.cdInterval or nil) and (self._cofigParamCfg.cdInterval.paramValue .. "小时" or "24小时")
end

function PowerCrystalConfig:getOneDiamondTime()
	return (self._cofigParamCfg and self._cofigParamCfg.clearCdPrice or nil) and self._cofigParamCfg.clearCdPrice.paramValue * 60
end

function PowerCrystalConfig:getMainOrSecondCostMo(isMain)
	local key = isMain and "mainCostItem" or "secondCostItem"
	local value = self._cofigParamCfg[key].paramValue
	local tab = string.splitToNumber(value, ":")
	local matType = tab[1]
	local matId = tab[2]

	return matType, matId
end

PowerCrystalConfig.instance = PowerCrystalConfig.New()

return PowerCrystalConfig
