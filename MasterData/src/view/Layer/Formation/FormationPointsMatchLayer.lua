local FormationPointsMatchLayer = class("FormationPointsMatchLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationPointsMatchLayer:ctor()
	FormationPointsMatchLayer.super.ctor(self)

	self.curFormationIndex = self.manager:getCurFormationIndex()
	self.selectGirlType = SELECT_GIRL_FIGHT_POINT
	self.selectHorcruxType = SELECT_HORCRUX_FIGHT_POINT
	self.configType = CONFIG_TYPE_SCOREARENA
end

function FormationPointsMatchLayer:initManager()
	self.manager = require("controller.formation.formation_points_match_manager"):getInstance()
end

function FormationPointsMatchLayer:create(arg_3_1)
	local var_3_0 = FormationPointsMatchLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationPointsMatchLayer:init(arg_4_1)
	if FormationPointsMatchLayer.super.init(self, arg_4_1) then
		arg_4_1 = arg_4_1 or {}
		self.enemyId = arg_4_1.enemyId

		return true
	end

	return false
end

function FormationPointsMatchLayer:initLayer()
	FormationPointsMatchLayer.super.initLayer(self)
	self:checkAutoFight()
end

function FormationPointsMatchLayer:onEnter()
	FormationPointsMatchLayer.super.onEnter(self)
	self.manager:requestInfo()
end

function FormationPointsMatchLayer:onExit()
	FormationPointsMatchLayer.super.onExit(self)
end

function FormationPointsMatchLayer:getFormationInfo()
	return self.manager:getFormationInfo()
end

function FormationPointsMatchLayer:sureButtonCallBack()
	self.manager:requestChallenge(self.enemyId)
end

function FormationPointsMatchLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationPointsMatchLayer:checkAutoFight()
	if RoleDefault:getInstance():getBoolForKey("ScoreAutoFight", false) then
		global_count_down_layer(4, function()
			if tolua.isnull(self) then
				return
			end

			self.manager:requestChallenge(self.enemyId)
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("score_cancel_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("ScoreAutoFight", false)
		end)
	end
end

function FormationPointsMatchLayer:getAutoAdvanceForcesCallBack()
	return function()
		local var_15_0 = self.manager:getAdvanceForcesOneTimeArray()
		local var_15_1 = false

		for iter_15_0, iter_15_1 in pairs(self.manager:getFormationInfo()[self.curFormationIndex]) do
			if iter_15_1.assist_girl ~= var_15_0["pos_" .. iter_15_1.pos].assist_girl then
				var_15_1 = true

				break
			end

			if iter_15_1.fight_girl ~= var_15_0["pos_" .. iter_15_1.pos].fight_girl then
				var_15_1 = true

				break
			end
		end

		if var_15_1 then
			self.manager:requestOneTimeUpdateArray(nil, var_15_0)
		else
			global_ShowBlockWords("与先遣阵容相同，无需更换")
		end
	end
end

function FormationPointsMatchLayer:getSelectGirlConfig(arg_16_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		sureCallBack = function(arg_17_0)
			return
		end
	}
end

function FormationPointsMatchLayer:selectGirl(arg_18_1)
	if self:selectGirlConditionScreening(arg_18_1, {
		bAutoTips = true
	}) then
		local var_18_0 = self:getFormationInfo()

		if var_18_0 and var_18_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_18_1)))
		end
	end
end

function FormationPointsMatchLayer:isShowHelpBattle()
	return true
end

function FormationPointsMatchLayer:isShowAutoHelpBattleBtn()
	return true
end

function FormationPointsMatchLayer:isShowFastEquipmentBtn()
	return true
end

return FormationPointsMatchLayer
