local FormationGrabMatchLayer = class("FormationGrabMatchLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationGrabMatchLayer:ctor()
	FormationGrabMatchLayer.super.ctor(self)
	self:setAutoAdapt(true)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
end

function FormationGrabMatchLayer:initManager()
	self.manager = require("controller.formation.formation_grab_match_manager"):getInstance()
end

function FormationGrabMatchLayer:create(arg_3_1)
	local var_3_0 = FormationGrabMatchLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationGrabMatchLayer:init(arg_4_1)
	self._data = arg_4_1

	self.manager:setLayerType(arg_4_1.layerType)

	if arg_4_1.layerType == self.manager.Type.Attack then
		self.configType = CONFIG_TYPE_ARENA
		self.selectGirlType = SELECT_GIRL_ARENA_ATTACK
		self.selectHorcruxType = SELECT_HORCRUX_ARENA_ATTACK
	elseif arg_4_1.layerType == self.manager.Type.Defend then
		self.configType = CONFIG_TYPE_ARENA_DEFENCE
		self.selectGirlType = SELECT_GIRL_ARENA_DEFENCE
		self.selectHorcruxType = SELECT_HORCRUX_ARENA_DEFENCE
	end

	if FormationGrabMatchLayer.super.init(self, arg_4_1) then
		self:updateLayer()

		return true
	end

	return false
end

function FormationGrabMatchLayer:onEnter()
	FormationGrabMatchLayer.super.onEnter(self)
	self.manager:requestInfo()
end

function FormationGrabMatchLayer:onExit()
	FormationGrabMatchLayer.super.onExit(self)
	self.manager:setLayerType(nil)
end

function FormationGrabMatchLayer:sureButtonCallBack()
	self:closeAction()

	if self.configCallback then
		self.configCallback()
	end
end

function FormationGrabMatchLayer:getSelectGirlConfig(arg_8_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		type = self._data.layerType,
		sureCallBack = function(arg_9_0)
			return
		end
	}
end

function FormationGrabMatchLayer:selectGirl(arg_10_1)
	if self:selectGirlConditionScreening(arg_10_1, {
		bAutoTips = true
	}) then
		local var_10_0 = self:getFormationInfo()

		if var_10_0 and var_10_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_10_1)))
		end
	end
end

function FormationGrabMatchLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationGrabMatchLayer:isShowHelpBattle()
	return true
end

function FormationGrabMatchLayer:isShowAutoHelpBattleBtn()
	return true
end

return FormationGrabMatchLayer
