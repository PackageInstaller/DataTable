local network = require("network.network")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local activity_flychess_conf_data = require("data.activity_flychess_conf_data")
local activity_flychess_boss_data = require("data.activity_flychess_boss_data")
local item_manager = require("controller.item_manager")
local var_0_6 = {
	READY = 1,
	FINISH = 3,
	FIGHTING = 2,
	NONE = 0
}
local var_0_7 = {
	SUCCESS = 1,
	FAIL = 2
}
local var_0_9 = 3
local var_0_12 = 6
local var_0_13 = 7
local var_0_15 = 9
local var_0_16 = {
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	},
	{
		eventType = 1
	}
}

function ACTIVITY_OBJ_NEW:enter_flychess_get_conf(arg_1_1)
	network:rpc("enter_flychess_get_conf", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.flychess_pos = arg_2_0.pos
			self.flychess_map_infos = arg_2_0.map_infos
			self.flychess_explore_point = arg_2_0.explore_point
			self.flychess_free_count = arg_2_0.free_count
			self.flychess_waiting = arg_2_0.waiting
			self.flychess_cur_eventType = arg_2_0.cur_eventType
			self.flychess_boss_battleid = arg_2_0.boss_battleid
			self.flychess_boss_dropid = arg_2_0.boss_dropid
			self.flychess_level = arg_2_0.level

			arg_1_1()
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_ALLMAP_UPDATE, arg_2_0)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_DATA_UPDATE, arg_2_0)

			if self._flychess_fight_state == var_0_6.FINISH then
				self._flychess_fight_state = var_0_6.NONE

				if self._flychessBossFight then
					self._flychessBossFight = false

					self:flyChessBossFightResult(self._flychess_fight_result)

					return
				end

				self:user_handle_flychess_events({
					eventType = self.flychess_cur_eventType,
					fight_result = self._flychess_fight_result
				})
			end
		elseif arg_2_0.result == 2 then
			global_ShowBlockWords("飞行棋活动未开放！")
		elseif arg_2_0.result == 3 then
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:dice_goto_next(arg_3_1)
	if self.flychess_waiting then
		global_ShowBlockWords("有需要有需要班长处理的事件！")

		return
	end

	network:rpc("dice_goto_next", {
		activityid = self._id
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			self.flychess_pos = arg_4_0.pos
			self.flychess_waiting = arg_4_0.waiting
			self.flychess_cur_eventType = arg_4_0.cur_eventType
			self.flychess_free_count = arg_4_0.free_count or self.flychess_free_count
			self.flychess_explore_point = arg_4_0.explore_point or self.flychess_explore_point

			if arg_4_0.consumes then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.consumes) do
					item_manager:deleteItem(iter_4_1.entityid, iter_4_1.num)
				end
			end

			local var_4_0

			if arg_4_0.items then
				local var_4_1, var_4_2, var_4_3, var_4_4, var_4_5, var_4_6, var_4_7, var_4_8, var_4_9, var_4_10, var_4_11 = global_get(arg_4_0)

				if var_4_10 then
					var_4_0 = {
						gold = var_4_1,
						diamond = var_4_2,
						honor = var_4_3,
						sp = var_4_4,
						energy = var_4_6,
						active = var_4_7,
						items = var_4_5,
						itemformat = arg_4_0.itemformat,
						surecallback = var_4_8,
						intocallback = var_4_11,
						cancelcallback = var_4_9
					}
				end
			end

			arg_4_0.popmsg = var_4_0

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_DICE_RANDOM, arg_4_0)
			AnalyticManager.dice_goto_next({
				activityId = self._id,
				pos = self.flychess_pos,
				free_count = self.flychess_free_count,
				cur_eventType = self.flychess_cur_eventType,
				explore_point = self.flychess_explore_point,
				cur_area = self.flychess_level,
				diceRandom = arg_4_0.diceRandom
			})
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords("道具不足！")
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords("illegal error!!!")
		end

		arg_3_1()
	end)
end

function ACTIVITY_OBJ_NEW:user_handle_flychess_events(arg_5_1)
	network:rpc("user_handle_flychess_events", {
		activityid = self._id,
		eventType = arg_5_1.eventType,
		fight_result = arg_5_1.fight_result,
		forward_num = arg_5_1.forward_num,
		build_grid_type = arg_5_1.build_grid_type
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			self.flychess_waiting = arg_6_0.waiting
			self.flychess_pos = arg_6_0.pos or self.flychess_pos
			self.flychess_map_infos = arg_6_0.map_infos or self.flychess_map_infos
			self.flychess_explore_point = arg_6_0.explore_point or self.flychess_explore_point
			self.flychess_free_count = arg_6_0.free_count or self.flychess_free_count
			self.flychess_cur_eventType = arg_6_0.cur_eventType or self.flychess_cur_eventType
			arg_6_0.forward_num = arg_5_1.forward_num

			if arg_5_1.eventType == var_0_9 then
				if arg_5_1.fight_result == var_0_7.SUCCESS then
					global_ShowBlockWords("战斗胜利！班长可以选择一种建筑建造哦~")
					activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_ALLMAP_UPDATE, arg_6_0)
				else
					global_ShowBlockWords("战斗失败~班长下次加油哦~")
				end
			elseif arg_5_1.eventType == var_0_12 then
				-- block empty
			elseif arg_5_1.eventType == var_0_13 then
				-- block empty
			elseif arg_5_1.eventType == var_0_15 then
				activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_ALLMAP_UPDATE, arg_6_0)
			end

			local var_6_0

			if arg_6_0.items then
				local var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6, var_6_7, var_6_8, var_6_9, var_6_10, var_6_11 = global_get(arg_6_0)

				if var_6_10 then
					var_6_0 = {
						gold = var_6_1,
						diamond = var_6_2,
						honor = var_6_3,
						sp = var_6_4,
						energy = var_6_6,
						active = var_6_7,
						items = var_6_5,
						itemformat = arg_6_0.itemformat,
						surecallback = var_6_8,
						intocallback = var_6_11,
						cancelcallback = var_6_9
					}
				end
			end

			arg_6_0.popmsg = var_6_0

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_DICE_ANY, arg_6_0)
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("未传入事件")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("不需要操作")
		elseif arg_6_0.result == 4 then
			global_ShowBlockWords("不一致")
		end
	end)
end

function ACTIVITY_OBJ_NEW:can_throw()
	return not self.flychess_waiting
end

function ACTIVITY_OBJ_NEW:initFlyChessBossFight()
	if self.flychess_explore_point < self:getFlyChessBossBattleScore() then
		global_ShowBlockWords("区域头目尚未发现，需要积累更多探索值~")

		return
	end

	if self.flychess_level > self:getFlyChessMaxLevel() then
		global_ShowBlockWords("区域已经彻底安全，没有更多悬赏头目了~")

		return
	end

	local var_8_0 = self:getFlychessBossBattleid()

	assert(var_8_0 ~= nil, "there is no boss_battleId!!!")

	self._flychess_fight_state = var_0_6.READY
	activity_manager._flychessBattleId = var_8_0
	activity_manager._flychessActivityId = self._id
	self._flychessBossFight = true

	if FightManager.refreshFightToType(FIGHTTYPE_FLYCHESS) then
		self._flychess_fight_state = var_0_6.FIGHTING

		LayerManager:switchShowLayer("FightLayer", {})
	end
end

function ACTIVITY_OBJ_NEW:initFlyChessFight()
	local var_9_0 = self:getFlychessBattleid()

	assert(var_9_0 ~= nil, "there is no battleId!!!")

	self._flychess_fight_state = var_0_6.READY
	activity_manager._flychessBattleId = var_9_0
	activity_manager._flychessActivityId = self._id

	if FightManager.refreshFightToType(FIGHTTYPE_FLYCHESS) then
		self._flychess_fight_state = var_0_6.FIGHTING

		LayerManager:switchShowLayer("FightLayer", {})
	end
end

function ACTIVITY_OBJ_NEW:getFlyChessBattleFieldStatus()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs((self:getBuffsAndScoreList())) do
		if not iter_10_1.buff_score then
			break
		end

		if self.flychess_explore_point >= iter_10_1.buff_score then
			table.insert(var_10_0, iter_10_1.buff)
		else
			break
		end
	end

	return var_10_0
end

function ACTIVITY_OBJ_NEW:flychessFightFail()
	self._flychess_fight_state = var_0_6.FINISH
	self._flychess_fight_result = var_0_7.FAIL

	LayerManager:switchShowLayer("flyChessMainLayer", {
		activityId = self._id
	})
end

function ACTIVITY_OBJ_NEW:flychessFightSuccess()
	if self._flychessBossFight then
		self._flychess_fight_state = var_0_6.FINISH
		self._flychess_fight_result = var_0_7.SUCCESS

		LayerManager:switchShowLayer("flyChessMainLayer", {
			activityId = self._id
		})

		return
	end

	self._flychess_fight_state = var_0_6.FINISH
	self._flychess_fight_result = var_0_7.SUCCESS

	LayerManager:switchShowLayer("flyChessMainLayer", {
		activityId = self._id
	})
end

function ACTIVITY_OBJ_NEW:flyChessBossFightResult(arg_13_1)
	if arg_13_1 == var_0_7.FAIL then
		return
	end

	network:rpc("flyChess_bossfight_result", {
		activityid = self._id,
		fight_result = arg_13_1
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			self.flychess_pos = arg_14_0.pos
			self.flychess_map_infos = arg_14_0.map_infos
			self.flychess_explore_point = arg_14_0.explore_point
			self.flychess_free_count = arg_14_0.free_count
			self.flychess_waiting = arg_14_0.waiting
			self.flychess_cur_eventType = arg_14_0.cur_eventType
			self.flychess_boss_battleid = arg_14_0.boss_battleid
			self.flychess_boss_dropid = arg_14_0.boss_dropid
			self.flychess_level = arg_14_0.level

			if arg_14_0.items then
				global_gain(arg_14_0)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_BOSSFIGHT_SUCESS, self.flychess_boss_dropid)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_ALLMAP_UPDATE, arg_14_0)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_DATA_UPDATE, arg_14_0)
		elseif arg_14_0.result == 2 then
			global_ShowBlockWords("挑战boss失败！！！")
		elseif arg_14_0.result == 3 then
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:getFlychessAllInfo()
	local var_15_0 = {
		pos = self.flychess_pos,
		map_infos = self.flychess_map_infos,
		explore_point = self.flychess_explore_point,
		free_count = self.flychess_free_count,
		waiting = self.flychess_waiting,
		cur_eventType = self.flychess_cur_eventType
	}

	var_15_0.map_infos = self.flychess_map_infos or var_0_16
	var_15_0.level = self.flychess_level

	return var_15_0
end

function ACTIVITY_OBJ_NEW.getFlychessMapUIConf(arg_16_0)
	return
end

function ACTIVITY_OBJ_NEW:getFlychessConf()
	return activity_flychess_conf_data[self._id]
end

function ACTIVITY_OBJ_NEW:get_flychess_rank_list(arg_18_1)
	network:rpc("get_flychess_rank_list", {
		activityid = self._id
	}, function(arg_19_0)
		print("get_flychess_rank_list==", dump(arg_19_0))

		if arg_18_1 then
			arg_18_1(arg_19_0.data, arg_19_0.player_data)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getFlychessBattleid()
	return self.flychess_map_infos[self.flychess_pos].battleid .. "-" .. math.min(self.flychess_level, activity_flychess_conf_data[self._id].level_num)
end

function ACTIVITY_OBJ_NEW:getFlychessBossBattleid()
	return self.flychess_boss_battleid
end

function ACTIVITY_OBJ_NEW:getBuffsAndScoreList()
	local var_22_0 = {}

	while activity_flychess_conf_data[self._id]["buff_score" .. 1] do
		table.insert(var_22_0, {
			buff = activity_flychess_conf_data[self._id]["buff" .. 1],
			buff_score = activity_flychess_conf_data[self._id]["buff_score" .. 1]
		})
	end

	return var_22_0
end

function ACTIVITY_OBJ_NEW:getFlyChessBossBattleScore()
	return activity_flychess_conf_data[self._id].boss_score
end

function ACTIVITY_OBJ_NEW:getFlyChessTicket()
	return activity_flychess_conf_data[self._id].ticket
end

function ACTIVITY_OBJ_NEW:getFlyChessTicketShop()
	return activity_flychess_conf_data[self._id].ticket_score
end

function ACTIVITY_OBJ_NEW:getFlyChessShop()
	return activity_flychess_conf_data[self._id].shop
end

function ACTIVITY_OBJ_NEW:getFlyChessLevelRewards()
	local var_27_0 = {}

	for iter_27_0 = 1, activity_flychess_conf_data[self._id].level_num do
		table.insert(var_27_0, activity_flychess_boss_data[self._id .. "-" .. iter_27_0].dropid)
	end

	return var_27_0
end

function ACTIVITY_OBJ_NEW:getFlyChessMaxLevel()
	return activity_flychess_conf_data[self._id].level_num
end

function ACTIVITY_OBJ_NEW:getFlyChessBossInfo(arg_29_1)
	local activity_flychess_monster_data
	local activity_flychess_monsterteam_data

	if not self.flychess_boss_battleid then
		do return end

		activity_flychess_monster_data = require("data.activity_flychess_monster_data")
		activity_flychess_monsterteam_data = require("data.activity_flychess_monsterteam_data")
	end

	local var_29_2 = require("data.leveldata.level_data_" .. string.split(self.flychess_boss_battleid, "-")[1])[self.flychess_boss_battleid].boss_team
	local var_29_3 = activity_flychess_monsterteam_data[var_29_2]

	assert(activity_flychess_monsterteam_data[var_29_2] ~= nil, "there is no data of team " .. var_29_2 .. " in monster team data!!!")

	if not var_29_3.boss then
		return
	end

	return activity_flychess_monster_data[var_29_3.boss]
end
