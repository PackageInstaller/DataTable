local FormationManager = class("FormationManager", (require("controller.base_manager")))

FormationManager.MULTITON_MSG = "FormationManager instancealready constructed!"

function FormationManager:ctor()
	FormationManager.super.ctor(self)
end

function FormationManager:getFormationInfoByConfigType(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or 1

	if arg_2_1 and CONFIG_TYPE_SCOREARENA == arg_2_1 then
		return require("controller.formation.formation_points_match_manager"):getInstance():getFormationInfo()[arg_2_2]
	end

	return {}
end

function FormationManager:getFormationInfoBySelectType(arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or 1

	if arg_3_1 then
		local var_3_0

		if SELECT_GIRL_FIGHT_POINT == arg_3_1 then
			var_3_0 = require("controller.formation.formation_points_match_manager"):getInstance():getFormationInfo()
		elseif SELECT_GIRL_FIGHT_MODE == arg_3_1 or SELECT_GIRL_FIGHT_MATERIAL == arg_3_1 or SELECT_GIRL_FIGHT_ELEMENTS == arg_3_1 then
			var_3_0 = require("controller.formation.formation_mode_manager"):getInstance():getFormationInfo()
		elseif SELECT_GIRL_FIGHT == arg_3_1 then
			var_3_0 = require("controller.formation.formation_main_manager"):getInstance():getFormationInfo()
		elseif SELECT_GIRL_ARENA_ATTACK == arg_3_1 then
			var_3_0 = require("controller.array_manager"):getArenaAttackArray() or {}
			var_3_0 = {
				[arg_3_2] = var_3_0
			}
		elseif SELECT_GIRL_ARENA_DEFENCE == arg_3_1 then
			var_3_0 = require("controller.array_manager"):getArenaDefenceArray() or {}
			var_3_0 = {
				[arg_3_2] = var_3_0
			}
		elseif SELECT_GIRL_SUBSTITUTION == arg_3_1 then
			var_3_0 = require("controller.substitution_manager"):getUsingArraysData(arg_3_2) or {}
			var_3_0 = {
				[arg_3_2] = var_3_0
			}
		elseif SELECT_GIRL_EXPLORE_HP_INHERIT == arg_3_1 then
			var_3_0 = require("controller.array_manager"):getBattleArrayDataHpInherit(arg_3_2) or {}
			var_3_0 = {
				[arg_3_2] = var_3_0
			}
		elseif SELECT_GIRL_EXPEDITION == arg_3_1 then
			local var_3_1 = require("controller.expedition_manager"):getExpeditionTeamListInfo()

			var_3_0 = {}

			for iter_3_0 = 1, #var_3_1 do
				var_3_0[iter_3_0] = {
					pos = iter_3_0
				}

				if var_3_1[iter_3_0].servantid then
					var_3_0[iter_3_0].fight_girl = var_3_1[iter_3_0].servantid
				end
			end

			var_3_0 = {
				[arg_3_2] = var_3_0
			}
		elseif SELECT_GIRL_TEST_FIGHT_PLAYER == arg_3_1 then
			var_3_0 = {
				[arg_3_2] = require("controller.test_fight_manager"):getPlayerArray()
			}
		elseif SELECT_GIRL_TEST_FIGHT_EMPTY == arg_3_1 then
			var_3_0 = {
				[arg_3_2] = require("controller.test_fight_manager"):getPvpArray()
			}
		elseif SELECT_GIRL_TVT_ATTACK == arg_3_1 then
			return require("controller.formation.formation_3v3_manager"):getInstance():getFormationInfo()
		end

		if var_3_0 and var_3_0[arg_3_2] then
			return var_3_0[arg_3_2]
		end
	end

	return {}
end

function FormationManager:getFormationInfoBySelectHorcruxType(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or 1

	if arg_4_1 then
		if SELECT_HORCRUX_FIGHT_POINT == arg_4_1 then
			local formation_points_match_manager = require("controller.formation.formation_points_match_manager")

			if formation_points_match_manager[arg_4_2] then
				return formation_points_match_manager:getInstance():getFormationInfo()[arg_4_2]
			end
		elseif SELECT_HORCRUX_FIGHT_MODE == arg_4_1 or SELECT_HORCRUX_FIGHT_MATERIAL == arg_4_1 or SELECT_HORCRUX_FIGHT_ELEMENTS == arg_4_1 then
			local formation_mode_manager = require("controller.formation.formation_mode_manager")

			if formation_mode_manager[arg_4_2] then
				return formation_mode_manager:getInstance():getFormationInfo()[arg_4_2]
			end
		end
	end

	return {}
end

function FormationManager:requestModeInfo(arg_5_1, arg_5_2)
	return
end

function FormationManager:updateGirl()
	for iter_6_0, iter_6_1 in pairs((self:getAllManager())) do
		iter_6_1():updateGirl()
	end
end

function FormationManager:getAllManager()
	return {
		function()
			return require("controller.formation.formation_points_match_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_grab_match_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_mode_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_explore_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_special_explore_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_main_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_3v3_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_3v3_setting_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_overclock_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_test_fight_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_old_substitute_manager"):getInstance()
		end,
		function()
			return require("controller.formation.formation_jumptower_manager"):getInstance()
		end
	}
end

function FormationManager:updateLayer()
	self:updateGirl()
end

function FormationManager:pushFormationLayer(arg_21_1, arg_21_2)
	LayerManager:pushInLayer(arg_21_1, arg_21_2)
end

return FormationManager
