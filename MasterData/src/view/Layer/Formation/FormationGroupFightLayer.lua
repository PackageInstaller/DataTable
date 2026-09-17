local FormationGroupFightLayer = class("FormationGroupFightLayer", (require("view.Layer.Formation.BaseFormationLayer")))

require("view.Sprite.BottomBtnList")

local model_data = require("data.model_data")
local arenatft_manager = require("controller.arenatft_manager")
local audio_manager = require("controller.audio_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local servant_data = require("data.servant_data")
local activity_manager = require("controller.activity_manager")
local TempWidget = require("view.Sprite.TempWidget")

function FormationGroupFightLayer:ctor()
	FormationGroupFightLayer.super.ctor(self)
	self.manager:setCurFormationIndex(1)

	self.curFormationIndex = 1
	self.configType = CONFIG_TYPE_GROUP_FIGHT
	self.selectGirlType = SELECT_GIRL_GROUP_FIGHT
	self.selectHorcruxType = SELECT_HORCRUX_FIGHT_MODE
end

function FormationGroupFightLayer:initManager()
	self.manager = require("controller.formation.formation_groupfight_manager"):getInstance()
end

function FormationGroupFightLayer:create(arg_3_1)
	local var_3_0 = FormationGroupFightLayer.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function FormationGroupFightLayer:init(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self.groupNum = self.manager:CountTeamNum(arg_4_1)
	self.data = arg_4_1
	self.mode = arg_4_1.mode
	self.level = arg_4_1.level
	self.defaultIndex = 1

	if arg_4_1.defaultIndex then
		self.defaultIndex = arg_4_1.defaultIndex
	elseif arg_4_1.initindex then
		self.defaultIndex = arg_4_1.initindex
	end

	if FormationGroupFightLayer.super.init(self, arg_4_1) then
		return true
	end

	return false
end

function FormationGroupFightLayer:initLayer()
	FormationGroupFightLayer.super.initLayer(self)
	self:checkGroupAutoFight()
end

function FormationGroupFightLayer:onEnter()
	FormationGroupFightLayer.super.onEnter(self)
	self.manager:requestInfo(self.mode, self.defaultIndex, self.data)
end

function FormationGroupFightLayer:getSelectGirlConfig(arg_7_1)
	local var_7_0 = FormationGroupFightLayer.super.getSelectGirlConfig(self, arg_7_1)

	var_7_0.adverturemode = self.mode

	return var_7_0
end

function FormationGroupFightLayer:getSelectHorcruxConfig(arg_8_1)
	local var_8_0 = FormationGroupFightLayer.super.getSelectHorcruxConfig(self, arg_8_1)

	var_8_0.adverturemode = self.mode

	return var_8_0
end

function FormationGroupFightLayer:sureButtonCallBack()
	local var_9_0 = self.manager:CheckTeam()

	if var_9_0 then
		global_ShowBlockWords(string.format(L_TVT_DEFENCE_ARRAY_NIL, var_9_0))
	else
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in pairs(self:getFormationInfo()[1]) do
			table.insert(var_9_1, iter_9_1.fight_girl)
		end

		self.configCallback(var_9_1)
	end
end

function FormationGroupFightLayer:getSelectGirlConfig(arg_10_1)
	return {
		layerType = self.configType,
		selectGirlType = self.selectGirlType,
		is_hp_inherit = self.is_hp_inherit,
		selectHorcruxType = self.selectHorcruxType,
		mode = self.mode,
		formationIndex = self.curFormationIndex,
		allArray = self.manager:getFormationInfo(),
		sureCallBack = function(arg_11_0)
			return
		end
	}
end

function FormationGroupFightLayer:selectGirl(arg_12_1)
	if self:selectGirlConditionScreening(arg_12_1, {
		bAutoTips = true
	}) then
		local var_12_0 = self:getFormationInfo()

		if var_12_0 and var_12_0[self.curFormationIndex] then
			LayerManager:pushInLayer("QuickFormationLayer", (self:getSelectGirlConfig(arg_12_1)))
		end
	end
end

function FormationGroupFightLayer:getAutoFormationCallBack()
	local var_13_1 = self.curFormationIndex

	return function(arg_14_0)
		local var_14_0 = {}
		local var_14_1 = {}

		for iter_14_0, iter_14_1 in pairs(ATTR_ID) do
			var_14_1[iter_14_1] = {}
		end

		local var_14_2 = {}
		local var_14_3 = self:getFormationInfo()

		for iter_14_2 = 1, #var_14_3 do
			if iter_14_2 ~= var_13_1 then
				for iter_14_3 = 1, #var_14_3[iter_14_2] do
					if var_14_3[iter_14_2][iter_14_3].fight_girl then
						var_14_2[var_14_3[iter_14_2][iter_14_3].fight_girl] = true
					end
				end
			end
		end

		local fight_capacity_manager = require("controller.fight_capacity_manager")

		if arg_14_0.type == "all" or string.find(arg_14_0.type, "other") then
			for iter_14_4, iter_14_5 in pairs(playermodel.haveServant) do
				if not var_14_2[iter_14_4] then
					table.insert(var_14_0, {
						id = iter_14_4,
						capacity = fight_capacity_manager:getSoulFightCapacity(iter_14_4, "number")
					})
				end
			end

			table.sort(var_14_0, function(arg_15_0, arg_15_1)
				return arg_15_0.capacity > arg_15_1.capacity
			end)
		elseif string.find(arg_14_0.type, ",") then
			for iter_14_6, iter_14_7 in pairs(playermodel.haveServant) do
				if not var_14_2[iter_14_6] then
					local var_14_5 = global_get_all_model_attrs(servant_data[iter_14_6].modelid)
					local var_14_6 = fight_capacity_manager:getSoulFightCapacity(iter_14_6, "number")

					table.insert(var_14_1[var_14_5.main], {
						id = iter_14_6,
						capacity = var_14_6
					})

					for iter_14_8, iter_14_9 in ipairs(var_14_5.sub or {}) do
						table.insert(var_14_1[iter_14_9], {
							id = iter_14_6,
							capacity = var_14_6
						})
					end
				end
			end

			for iter_14_10, iter_14_11 in ipairs({
				"wind",
				"fire",
				"water",
				"light",
				"dark"
			}) do
				for iter_14_12, iter_14_13 in ipairs(var_14_1.imaginary) do
					table.insert(var_14_1[iter_14_11], iter_14_13)
				end
			end

			for iter_14_14, iter_14_15 in ipairs((string.split(arg_14_0.type, ","))) do
				for iter_14_16, iter_14_17 in ipairs(var_14_1[iter_14_15]) do
					table.insert(var_14_0, iter_14_17)
				end
			end

			table.sort(var_14_0, function(arg_16_0, arg_16_1)
				return arg_16_0.capacity > arg_16_1.capacity
			end)
		else
			for iter_14_18, iter_14_19 in pairs(playermodel.haveServant) do
				if not var_14_2[iter_14_18] then
					local var_14_7 = global_get_all_model_attrs(servant_data[iter_14_18].modelid)
					local var_14_8 = fight_capacity_manager:getSoulFightCapacity(iter_14_18, "number")

					table.insert(var_14_1[var_14_7.main], {
						id = iter_14_18,
						capacity = var_14_8
					})

					for iter_14_20, iter_14_21 in ipairs(var_14_7.sub or {}) do
						table.insert(var_14_1[iter_14_21], {
							id = iter_14_18,
							capacity = var_14_8
						})
					end
				end
			end

			for iter_14_22, iter_14_23 in ipairs({
				"wind",
				"fire",
				"water",
				"light",
				"dark"
			}) do
				for iter_14_24, iter_14_25 in ipairs(var_14_1.imaginary) do
					table.insert(var_14_1[iter_14_23], iter_14_25)
				end
			end

			for iter_14_26, iter_14_27 in pairs(var_14_1) do
				table.sort(iter_14_27, function(arg_17_0, arg_17_1)
					return arg_17_0.capacity > arg_17_1.capacity
				end)
			end
		end

		local var_14_9, var_14_10 = self:chooseTheTeam(var_13_1, arg_14_0.type, var_14_1, var_14_0)

		if var_14_9 and next(var_14_9) then
			if not var_14_10 then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						title = L_GO_CONFIG_DES.twist,
						des = L_BASE_FORMATION[10],
						button = L_BATTLEPASS_BUY.button
					},
					surecallback = function()
						LayerManager:switchShowLayer("TwisteggLayer")
					end
				})

				return false
			end
		end

		self.manager:autoTeam(self.mode, var_14_9, self.curFormationIndex, self.groupNum)

		return true
	end
end

function FormationGroupFightLayer:isShowFastEquipmentBtn()
	return true
end

function FormationGroupFightLayer:isShowAutoAdvanceForceBtn()
	return false
end

function FormationGroupFightLayer:isShowHelpBattle()
	return false
end

function FormationGroupFightLayer:isShowAutoHelpBattleBtn()
	return true
end

function FormationGroupFightLayer:checkGroupAutoFight()
	if require("controller.activity_manager"):isGroupTowerMode(require("data.levelmode_data")[self.mode].mode) == false then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("GroupTowerAutoFight", false) then
		global_count_down_layer(4, function()
			self:sureButtonCallBack()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_group_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("GroupTowerAutoFight", false)
		end)
	end
end

return FormationGroupFightLayer
