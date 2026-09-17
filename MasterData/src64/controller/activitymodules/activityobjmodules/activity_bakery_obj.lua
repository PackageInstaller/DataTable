local activity_bakery_conf = require("data.activity_bakery_conf")
local activity_bakery_level_conf = require("data.activity_bakery_level_conf")
local activity_bakery_device_data = require("data.activity_bakery_device_data")
local network = require("network.network")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local activity_flychess_conf_data = require("data.activity_flychess_conf_data")
local activity_flychess_boss_data = require("data.activity_flychess_boss_data")
local item_manager = require("controller.item_manager")

function ACTIVITY_OBJ_NEW:get_activity_bakery_data(arg_1_1)
	network:rpc("get_activity_bakery_data", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.bakery_equipment_level = arg_2_0.equipment_level
			self.bakery_gold = arg_2_0.gold
			self.bakery_level = arg_2_0.level
			self.bakery_target_gold = arg_2_0.target_gold

			if arg_2_0.items then
				global_get(arg_2_0)
			end

			if arg_1_1 then
				arg_1_1(arg_2_0)
			end
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords("")
		elseif arg_2_0.result == 3 then
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_bakery_device_levelup(arg_3_1, arg_3_2)
	network:rpc("activity_bakery_device_levelup", {
		activityid = self._id,
		equipmentName = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			self.bakery_equipment_level = arg_4_0.equipment_level
			self.bakery_gold = arg_4_0.gold

			if arg_3_2 then
				arg_3_2(arg_4_0)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_BAKERY_UPDATE_GOLD, arg_4_0)
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords("升级设备错误!!!")
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords("已经达到了最高等级!!!")
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords("金币不足!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_bakery_pass_level(arg_5_1, arg_5_2)
	network:rpc("activity_bakery_pass_level", {
		activityid = self._id,
		level_gold = arg_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			local var_6_0

			if activity_bakery_level_conf[self._id * 100 + self.bakery_level] then
				var_6_0 = activity_bakery_level_conf[self._id * 100 + self.bakery_level].dropid or nil
			end

			self.bakery_gold = arg_6_0.gold
			self.bakery_level = arg_6_0.level
			self.bakery_target_gold = arg_6_0.target_gold

			if arg_6_0.items then
				global_get(arg_6_0)
			end

			if arg_5_2 then
				arg_5_2({
					result = 1,
					drop = var_6_0,
					level = self.bakery_level,
					gold = self.bakery_gold,
					target_gold = arg_6_0.target_gold
				})
			end
		elseif arg_6_0.result == 2 then
			self.bakery_gold = arg_6_0.gold

			if arg_5_2 then
				arg_5_2({
					result = 2,
					gold = arg_5_1,
					level = self.bakery_level
				})
			end

			global_ShowBlockWords("未达到目标分数, 挑战失败！")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("已经是最后一关啦!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_bakery_game_start(arg_7_1, arg_7_2, arg_7_3)
	network:rpc("activity_bakery_game_start", {
		activityid = self._id,
		helpdata = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			self.bakery_gold = arg_8_0.gold
			self.bakery_level = arg_8_0.level
			self.bakery_target_gold = arg_8_0.target_gold

			if arg_8_0.consumes then
				for iter_8_0, iter_8_1 in pairs(arg_8_0.consumes) do
					item_manager:deleteItem(iter_8_1.entityid, iter_8_1.num)
				end
			end

			if arg_7_2 then
				arg_7_2({
					gold = arg_8_0.gold,
					level = arg_8_0.level,
					target_gold = arg_8_0.target_gold,
					equipment_level = self.bakery_equipment_level
				})
			end
		elseif arg_8_0.result == 2 then
			global_ShowBlockWords("门票不足")
		elseif arg_8_0.result == 3 then
			global_ShowBlockWords("已经是最后一关啦!!!")
		elseif arg_8_0.result == 4 then
			global_ShowBlockWords("帮助道具不足！！")
		end

		if arg_7_3 then
			arg_7_3()
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_get_bakery_conf(arg_9_1)
	return activity_bakery_conf[self._id]
end

function ACTIVITY_OBJ_NEW:activity_get_bakery_level_conf(arg_10_1)
	if self:activity_get_bakery_conf().max_level >= self.bakery_level then
		return activity_bakery_level_conf[self._id * 100 + self.bakery_level]
	else
		return {}
	end
end

function ACTIVITY_OBJ_NEW:activity_get_bakery_cur_data(arg_11_1)
	return {
		equipment_level = self.bakery_equipment_level,
		gold = self.bakery_gold,
		level = self.bakery_level,
		target_gold = self.bakery_target_gold
	}
end

function ACTIVITY_OBJ_NEW:activity_get_bakery_device_levelinfo(arg_12_1)
	return self.bakery_equipment_level[arg_12_1] or 1, activity_bakery_device_data[arg_12_1]
end
