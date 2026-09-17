local FormationJumptowerLayer = class("FormationJumptowerLayer", (require("view.Layer.Formation.FormationModeLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationJumptowerLayer:ctor()
	FormationJumptowerLayer.super.ctor(self)

	self.selectGirlType = SELECT_GIRL_JUMP_TOWER
	self.selectHorcruxType = SELECT_HORCRUX_JUMP_TOWER
	self.configType = CONFIG_TYPE_JUMP_TOWER
end

function FormationJumptowerLayer:initManager()
	self.manager = require("controller.formation.formation_jumptower_manager"):getInstance()
end

function FormationJumptowerLayer:create(arg_3_1)
	local var_3_0 = FormationJumptowerLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationJumptowerLayer:init(arg_4_1)
	if FormationJumptowerLayer.super.init(self, arg_4_1) then
		self.activityId = math.floor(arg_4_1.mode / 100)
		self.configCallback = arg_4_1.configcallback

		return true
	end

	return false
end

function FormationJumptowerLayer:initLayer()
	FormationJumptowerLayer.super.initLayer(self)
end

function FormationJumptowerLayer:executeHangupArrayChange()
	FightManager.registerPlayerReplace()
	AlertManager:check_servant_strenghth()
	AlertManager:check_horcrux_strenghth()
	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
end

function FormationJumptowerLayer:sureButtonCallBack()
	local var_7_0, var_7_1 = self.manager:checkAdventureArray()

	if var_7_0 then
		self:executeHangupArrayChange()

		if self.configCallback and self.manager:checkIsSameColorTeam(self.mode) then
			local var_7_2 = {}

			for iter_7_0, iter_7_1 in pairs(self:getFormationInfo()[1]) do
				table.insert(var_7_2, iter_7_1.fight_girl)
			end

			self.configCallback(var_7_2)
		end
	elseif var_7_1 == 0 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[0], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	elseif var_7_1 == 1 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
		require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
	end
end

function FormationJumptowerLayer:getSelectGirlConfig(arg_8_1)
	return {
		layerType = self.configType,
		excludelist = require("controller.activity_manager"):getJumptowerLockServants(self.activityId),
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.manager._mode,
		sureCallBack = function(arg_9_0)
			return
		end
	}
end

function FormationJumptowerLayer:selectGirl(arg_10_1)
	if self:selectGirlConditionScreening(arg_10_1, {
		bAutoTips = true
	}) then
		local var_10_0 = self:getFormationInfo()

		if var_10_0 and var_10_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_10_1)))
		end
	end
end

function FormationJumptowerLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationJumptowerLayer:isShowHelpBattle()
	return false
end

function FormationJumptowerLayer:isShowAutoHelpBattleBtn()
	return false
end

function FormationJumptowerLayer:isShowAutoFormationBtn()
	return false
end

return FormationJumptowerLayer
