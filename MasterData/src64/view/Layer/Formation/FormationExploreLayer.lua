local FormationExploreLayer = class("FormationExploreLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function FormationExploreLayer:ctor()
	FormationExploreLayer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.selectGirlType = SELECT_GIRL_EXPLORE_HP_INHERIT
	self.selectHorcruxType = SELECT_HORCRUX_EXPLORE_HP_INHERIT
	self.bInit = true
end

function FormationExploreLayer:initManager()
	self.manager = require("controller.formation.formation_explore_manager"):getInstance()
end

function FormationExploreLayer:create(arg_3_1)
	local var_3_0 = FormationExploreLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationExploreLayer:init(arg_4_1)
	if FormationExploreLayer.super.init(self, arg_4_1) then
		if arg_4_1.initindex then
			self.manager:setCurFormationIndex(arg_4_1.initindex)

			self.curFormationIndex = arg_4_1.initindex
			self.configType = arg_4_1.configtype

			self.manager:setConfigType(self.configType)

			self.customConfigexitCallback = arg_4_1.customConfigexitCallback
		end

		if arg_4_1.configtype == CONFIG_TYPE_EXPLORE then
			self.selectGirlType = SELECT_GIRL_EXPLORE
			self.selectHorcruxType = SELECT_HORCRUX_EXPLORE
		end

		self.fighttype = arg_4_1.fighttype

		self:updateLayer()

		return true
	end

	return false
end

function FormationExploreLayer:onEnter()
	FormationExploreLayer.super.onEnter(self)
end

function FormationExploreLayer:onExit()
	FormationExploreLayer.super.onExit(self)

	if self.customConfigexitCallback then
		self.customConfigexitCallback(self.curFormationIndex)
	end
end

function FormationExploreLayer:getSelectGirlConfig(arg_7_1)
	local var_7_0 = FormationExploreLayer.super.getSelectGirlConfig(self, arg_7_1)

	var_7_0.exploringSouls = self.configType == CONFIG_TYPE_EXPLORE and require("controller.explore_manager"):getExploringSouls() or nil

	return var_7_0
end

function FormationExploreLayer:sureButtonCallBack()
	local array_manager = require("controller.array_manager")
	local audio_manager = require("controller.audio_manager")

	if CONFIG_TYPE_EXPLORE == self.configType then
		local var_8_2, var_8_3 = array_manager:checkExploreArray(self.curFormationIndex)

		if var_8_2 then
			if self.configCallback then
				self.configCallback(self.curFormationIndex)
			end

			array_manager:executeHangupArrayChange()
			self:closeAction()
		elseif var_8_3 == 0 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[0], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif var_8_3 == 1 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[1], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif var_8_3 == 2 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[2], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	elseif CONFIG_TYPE_EXPLORE_HP_INHERIT == self.configType then
		local var_8_4, var_8_5 = array_manager:checkExploreArrayHpInherit(self.curFormationIndex)

		if var_8_4 then
			if self.configCallback then
				self.configCallback(self.curFormationIndex)
			end

			array_manager:executeHangupArrayChange()
			self:closeAction()
		elseif var_8_5 == 0 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[0], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif var_8_5 == 1 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[1], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif var_8_5 == 2 then
			global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Explore[2], RISE_WORDS_FAIL)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end
end

function FormationExploreLayer:getSelectGirlConfig(arg_9_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		sureCallBack = function(arg_10_0)
			return
		end
	}
end

function FormationExploreLayer:selectGirl(arg_11_1)
	if self:selectGirlConditionScreening(arg_11_1, {
		bAutoTips = true
	}) then
		local var_11_0 = self:getFormationInfo()

		if var_11_0 and var_11_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_11_1)))
		end
	end
end

function FormationExploreLayer:getSelectHorcruxConfig(arg_12_1)
	local var_12_0 = self:getFormationInfo()
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0[self.curFormationIndex]) do
		if iter_12_1.assist_girl then
			var_12_1[#var_12_1 + 1] = iter_12_1.assist_girl
		end
	end

	return {
		selectType = self.selectHorcruxType,
		curHorcrux = var_12_0[self.curFormationIndex][arg_12_1].assist_girl,
		arrayIndex = self.curFormationIndex,
		arrayPos = arg_12_1,
		outSide = var_12_1,
		battleInfo = var_12_0[self.curFormationIndex],
		selectGirlServantId = var_12_0[self.curFormationIndex][arg_12_1].fight_girl,
		selectCallback = function(arg_13_0)
			return
		end
	}
end

return FormationExploreLayer
