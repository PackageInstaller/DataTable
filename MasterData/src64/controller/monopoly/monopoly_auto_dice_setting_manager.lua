local MonopolyAutoDiceSettingManager = class("MonopolyAutoDiceSettingManager", (require("controller.base_manager")))

MonopolyAutoDiceSettingManager.MULTITON_MSG = "MonopolyAutoDiceSettingManager instancealready constructed!"

function MonopolyAutoDiceSettingManager:ctor()
	MonopolyAutoDiceSettingManager.super.ctor(self)

	self._data = {}
end

function MonopolyAutoDiceSettingManager:requestInfo(arg_2_1)
	return
end

function MonopolyAutoDiceSettingManager:handlerInfo(arg_3_1)
	return
end

function MonopolyAutoDiceSettingManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyAutoDiceSettingManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyAutoDiceSettingManager:switchAutoCostGoldBuild()
	local var_6_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	var_6_0:setAutoUpgradeBuilding(not var_6_0:isAutoUpgradeBuilding())

	if self.layer then
		self.layer:updateCostLayout()
	end
end

function MonopolyAutoDiceSettingManager:switchAutoCostDiamondBuild()
	local var_7_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	var_7_0:setAutoUpgradeHignBuilding(not var_7_0:isAutoUpgradeHignBuilding())

	if self.layer then
		self.layer:updateCostLayout()
	end
end

function MonopolyAutoDiceSettingManager:isAutoCostGoldBuild()
	return require("controller.monopoly.monopoly_manager"):getInstance():isAutoUpgradeBuilding()
end

function MonopolyAutoDiceSettingManager:isAutoCostDiamondBuild()
	return require("controller.monopoly.monopoly_manager"):getInstance():isAutoUpgradeHignBuilding()
end

return MonopolyAutoDiceSettingManager
