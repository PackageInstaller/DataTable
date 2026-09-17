local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local activity_springfirecracker_conf = require("data.activity_springfirecracker_conf")

function activity_base_manager:springfirecracker_get_game_data(arg_1_1, arg_1_2)
	return self.activities[arg_1_1]:springfirecracker_get_game_data(arg_1_2)
end

function activity_base_manager:springfirecracker_start_game(arg_2_1, arg_2_2)
	return self.activities[arg_2_1]:springfirecracker_start_game(arg_2_2)
end

function activity_base_manager:springfirecracker_level_up(arg_3_1, arg_3_2, arg_3_3)
	return self.activities[arg_3_1]:springfirecracker_level_up(arg_3_2, arg_3_3)
end

function activity_base_manager:springfirecracker_game_end(arg_4_1, arg_4_2, arg_4_3)
	return self.activities[arg_4_1]:springfirecracker_game_end(arg_4_2, arg_4_3)
end

function activity_base_manager.getLevelupInfo(arg_5_0, arg_5_1, arg_5_2)
	if not activity_springfirecracker_conf[arg_5_1] then
		return
	end

	local var_5_0 = string.split(activity_springfirecracker_conf[arg_5_1].levelup_need_item, ",")

	return {
		max_strengthen_level = activity_springfirecracker_conf[arg_5_1].max_strengthen_level,
		strengthen_item = activity_springfirecracker_conf[arg_5_1].strengthen_item,
		damage_level_need = tonumber(var_5_0[arg_5_2.damage_level]),
		bullet_num_level_need = tonumber(var_5_0[arg_5_2.bullet_num_level]),
		attack_speed_level_need = tonumber(var_5_0[arg_5_2.attack_speed_level])
	}
end
