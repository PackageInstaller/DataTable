local FormationModeLayer = class("FormationModeLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationModeLayer:ctor()
	FormationModeLayer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.selectGirlType = SELECT_GIRL_FIGHT_MODE
	self.selectHorcruxType = SELECT_HORCRUX_FIGHT_MODE
	self.configType = CONFIG_TYPE_MODE
end

function FormationModeLayer:initManager()
	self.manager = require("controller.formation.formation_mode_manager"):getInstance()
end

function FormationModeLayer:create(arg_3_1)
	local var_3_0 = FormationModeLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationModeLayer:init(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self.mode = arg_4_1.mode
	self.defaultIndex = 1

	if arg_4_1.defaultIndex then
		self.defaultIndex = arg_4_1.defaultIndex
	elseif arg_4_1.initindex then
		self.defaultIndex = arg_4_1.initindex
	end

	if FormationModeLayer.super.init(self, arg_4_1) then
		return true
	end

	return false
end

function FormationModeLayer:onEnter()
	FormationModeLayer.super.onEnter(self)
	self.manager:requestInfo(self.mode, self.defaultIndex)
end

function FormationModeLayer:getSelectGirlConfig(arg_6_1)
	local var_6_0 = FormationModeLayer.super.getSelectGirlConfig(self, arg_6_1)

	var_6_0.adverturemode = self.mode

	return var_6_0
end

function FormationModeLayer:getSelectHorcruxConfig(arg_7_1)
	local var_7_0 = FormationModeLayer.super.getSelectHorcruxConfig(self, arg_7_1)

	var_7_0.adverturemode = self.mode

	return var_7_0
end

function FormationModeLayer:sureButtonCallBack()
	if self.configCallback then
		self.configCallback(self.curFormationIndex)
	end

	self:closeAction()
end

function FormationModeLayer:isShowFastEquipmentBtn()
	return true
end

function FormationModeLayer:getSelectGirlConfig(arg_10_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.manager._mode,
		sureCallBack = function(arg_11_0)
			return
		end
	}
end

function FormationModeLayer:selectGirl(arg_12_1)
	if self:selectGirlConditionScreening(arg_12_1, {
		bAutoTips = true
	}) then
		local var_12_0 = self:getFormationInfo()

		if var_12_0 and var_12_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_12_1)))
		end
	end
end

function FormationModeLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationModeLayer:isShowHelpBattle()
	return true
end

function FormationModeLayer:isShowAutoHelpBattleBtn()
	return true
end

return FormationModeLayer
