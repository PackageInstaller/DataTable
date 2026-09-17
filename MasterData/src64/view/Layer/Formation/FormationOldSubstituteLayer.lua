local FormationOldSubstituteLayer = class("FormationOldSubstituteLayer", (require("view.Layer.Formation.BaseFormationLayer")))
local var_0_1 = config._DEBUG and 0 or 1

function FormationOldSubstituteLayer:ctor()
	FormationOldSubstituteLayer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = self.manager:getCurFormationIndex()
	self.selectGirlType = SELECT_GIRL_SUBSTITUTION_OLD
	self.selectHorcruxType = SELECT_HORCRUX_SUBSTITUTION_OLD
	self.configType = CONFIG_TYPE_SUBSTITUTION_OLD
end

function FormationOldSubstituteLayer:initManager()
	self.manager = require("controller.formation.formation_old_substitute_manager"):getInstance()
end

function FormationOldSubstituteLayer:create(arg_3_1)
	local var_3_0 = FormationOldSubstituteLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationOldSubstituteLayer:init(arg_4_1)
	FormationOldSubstituteLayer.super.init(self, arg_4_1)

	arg_4_1 = arg_4_1 or {}
	self.mode = arg_4_1.mode
	self.level = arg_4_1.level
	self.cancelcallback = arg_4_1.cancelcallback

	self.manager:setReturnLayer(arg_4_1.returnlayer)

	return true
end

function FormationOldSubstituteLayer:onEnter()
	FormationOldSubstituteLayer.super.onEnter(self)
	self.manager:requestInfo(self.mode)
end

function FormationOldSubstituteLayer:onExit()
	FormationOldSubstituteLayer.super.onExit(self)
end

function FormationOldSubstituteLayer:initListener()
	FormationOldSubstituteLayer.super.initListener(self)
	self._root:_addEvent(function()
		if self.cancelcallback then
			self.cancelcallback()
		end

		self:closeAction()
	end)
end

function FormationOldSubstituteLayer:sureButtonCallBack()
	if self.manager:canContinueSetGirl() then
		require("view.Layer.DialogLayer")
		global_basic_scene:addChild(DialogLayer:create(nil, "当前五个队伍仍然有空位\n是否确定要进行游戏", 500, 250, function()
			self.manager:startFight()
		end, nil, true), 10001)
	else
		self.manager:startFight()
	end
end

function FormationOldSubstituteLayer:updateLayer()
	FormationOldSubstituteLayer.super.updateLayer(self)
end

function FormationOldSubstituteLayer:isShowAutoFormationBtn()
	return false
end

function FormationOldSubstituteLayer:isRegisterTeamSkill()
	return false
end

function FormationOldSubstituteLayer:getSureBtnTextInfo()
	local var_14_0 = {}

	var_14_0.path = "public/button/public_button_orange_long.png"
	var_14_0.str = "确认派出"
	var_14_0.configTextureType = var_0_1
	var_14_0.strColor = "242C3A"
	var_14_0.strSize = 30
	var_14_0.strFont = FONT_BUTTON

	return var_14_0
end

function FormationOldSubstituteLayer:getSureBtnExtendTextInfo()
	local var_15_0 = {}

	var_15_0.str = "确认派出"
	var_15_0.visible = false
	var_15_0.strColor = "FFD102"
	var_15_0.strSize = 24
	var_15_0.strFont = FONT_BUTTON

	return var_15_0
end

function FormationOldSubstituteLayer:getSelectGirlConfig(arg_16_1)
	return {
		is_hp_inherit = false,
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.mode,
		formationIndex = self.curFormationIndex,
		excludelist = self:getExcludeGirlList(),
		sureCallBack = function(arg_17_0)
			return
		end
	}
end

function FormationOldSubstituteLayer:getExcludeGirlList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs((self.manager:getFormationInfo())) do
		if iter_18_0 ~= self.curFormationIndex then
			for iter_18_2, iter_18_3 in ipairs(iter_18_1) do
				if iter_18_3.fight_girl then
					table.insert(var_18_0, iter_18_3.fight_girl)
				end
			end
		end
	end

	return var_18_0
end

function FormationOldSubstituteLayer:selectGirl(arg_19_1)
	if self:selectGirlConditionScreening(arg_19_1, {
		bAutoTips = true
	}) then
		local var_19_0 = self:getFormationInfo()

		if var_19_0 and var_19_0[self.curFormationIndex] then
			local var_19_1 = self:getSelectGirlConfig(arg_19_1)

			print("SelectGirlConfig: ", dump(var_19_1))
			LayerManager:pushInLayer("QuickFormationLayer", var_19_1)
		end
	end
end

return FormationOldSubstituteLayer
