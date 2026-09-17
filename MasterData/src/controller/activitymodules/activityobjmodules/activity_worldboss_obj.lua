local activity_manager = require("controller.activity_manager")
local autochess_conf_data = require("data.autochess_conf_data")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local worldboss_data = require("data.worldboss_data")
local var_0_11 = 3

function ACTIVITY_OBJ_NEW:get_worldboss_data(arg_1_1)
	network:rpc("get_worldboss_data", {
		activityid = self._id
	}, function(arg_2_0)
		print("get_worldboss_data====", dump(arg_2_0))

		if arg_2_0.result == 1 then
			self.worldboss_stage = arg_2_0.stage
			self.worldboss_starttime = arg_2_0.starttime
			self.worldboss_daily_chance = arg_2_0.daily_chance
			self.worldboss_max_score = arg_2_0.max_score
			self.worldboss_rank = arg_2_0.rank
			self.worldboss_bosshp = arg_2_0.bosshp
			self.worldboss_endtime = arg_2_0.endtime
			arg_2_0.infos = self:getWorldBossCurData()
			arg_2_0.stagetype = worldboss_data[arg_2_0.stage].type
			arg_2_0.add_servant = self:getWorldBossAddServants()

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_WORLDBOSS_UPDATE, arg_2_0)
		else
			global_ShowBlockWords("illegal error!!!")
		end

		if arg_1_1 then
			arg_1_1(arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:switch_to_worldboss_fight(arg_3_1, arg_3_2, arg_3_3)
	if self.worldboss_daily_chance <= 0 then
		global_ShowBlockWords("今日挑战次数不足!")

		return
	end

	if self.worldboss_bosshp <= 0 then
		global_ShowBlockWords("BOSS已被消灭!!!")

		return
	end

	activity_manager._worldbossfightingId = self._id
	self.worldboss_damage = 0
	playermodel.curMode = arg_3_1
	playermodel.curLevel = arg_3_2 .. "-1"

	FightManager.refreshFightToType(FIGHTTYPE_WORLDBOSS)
	LayerManager:switchShowLayer("FightLayer", {
		is_hide_topcost = true,
		is_hide_listbutton = true
	})
	AnalyticManager.worldbossfight_begin({
		activityid = self._id,
		mode = arg_3_1,
		stage = self.worldboss_stage
	})

	if arg_3_3 then
		arg_3_3()
	end
end

function ACTIVITY_OBJ_NEW:updateWorldBossDamage(arg_4_1)
	self.worldboss_damage = self.worldboss_damage + arg_4_1
end

function ACTIVITY_OBJ_NEW:worldbossFightSuccess()
	self.worldboss_damage = math.min(2100000000, self.worldboss_damage)

	AnalyticManager.worldbossfight_result({
		success = true,
		activityid = self._id,
		stage = self.worldboss_stage,
		damage = self.worldboss_damage
	})

	if not self:isWorldBossStage() then
		-- block empty
	else
		network:rpc("pass_worldboss_fight", {
			activityid = self._id,
			stage = self.worldboss_stage,
			damage = self.worldboss_damage
		}, function(arg_6_0)
			if arg_6_0.result == 1 then
				self.worldboss_stage = arg_6_0.stage
				self.worldboss_starttime = arg_6_0.starttime
				self.worldboss_daily_chance = arg_6_0.daily_chance
				self.worldboss_max_score = arg_6_0.max_score
				self.worldboss_rank = arg_6_0.rank
				self.worldboss_bosshp = arg_6_0.bosshp

				local var_6_0, var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6, var_6_7, var_6_8, var_6_9, var_6_10 = global_get({
					items = arg_6_0.item_res
				})

				LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
					activityId = self._id,
					entercallback = function()
						if not var_6_9 then
							return
						end

						LayerManager:pushInLayer("PopPurchaseResultLayer", {
							gold = var_6_0,
							diamond = var_6_1,
							honor = var_6_2,
							sp = var_6_3,
							energy = var_6_5,
							active = var_6_6,
							items = var_6_4,
							itemformat = arg_6_0.itemformat,
							surecallback = var_6_7,
							intocallback = var_6_10,
							cancelcallback = var_6_8
						})
					end
				})
			else
				global_ShowBlockWords(({
					[2] = "当前BOSS还未开始",
					[3] = "当前BOSS已被击败"
				})[2] or "illegal error!!!")
				LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
					activityId = self._id
				})
			end
		end)
	end

	activity_manager._worldbossfightingId = nil
	self.worldboss_damage = 0

	LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
		activityId = self._id
	})

	if callback then
		callback()
	end
end

function ACTIVITY_OBJ_NEW.getWorldBossEnemy(arg_8_0)
	return (monster_manager.initBossList((level_manager.getBossTeam())))
end

function ACTIVITY_OBJ_NEW:isWorldBossStage()
	return worldboss_data[self.worldboss_stage].type == var_0_11
end

function ACTIVITY_OBJ_NEW:getWorldBossCurMode()
	return worldboss_data[self.worldboss_stage].mode
end

function ACTIVITY_OBJ_NEW:getWorldBossCurData()
	local var_11_0 = {}

	for iter_11_0 = self.worldboss_stage + 1 - worldboss_data[self.worldboss_stage].type, self.worldboss_stage + (3 - worldboss_data[self.worldboss_stage].type) do
		table.insert(var_11_0, (clone(worldboss_data[iter_11_0])))
	end

	return var_11_0
end

function ACTIVITY_OBJ_NEW:getWorldBossFightAttrAdd()
	local var_12_0, var_12_1 = self:getAttrAddItemid()

	return item_manager:getItemNumber(var_12_0) * 0.01, item_manager:getItemNumber(var_12_1) * 0.01
end

function ACTIVITY_OBJ_NEW:getAttrAddItemid()
	local var_13_0 = self:getWorldBossCurData()

	return var_13_0[var_0_11].hp_item, var_13_0[var_0_11].damage_item
end

function ACTIVITY_OBJ_NEW:getWorldBossAddServants()
	local var_14_0 = string.split(self:getWorldBossCurData()[var_0_11].add_servants, ",")

	table.map(var_14_0, function(arg_15_0, arg_15_1)
		return tonumber(arg_15_0)
	end)

	return var_14_0
end

function ACTIVITY_OBJ_NEW:getWorldBossBattleFieldStatus(arg_16_1)
	local var_16_0

	if not arg_16_1 then
		do return end

		var_16_0 = self:getWorldBossCurData()
	end

	for iter_16_0, iter_16_1 in ipairs((self:getWorldBossAddServants())) do
		if arg_16_1 == iter_16_1 then
			return var_16_0[var_0_11].battlefield_status
		end
	end

	return nil
end

function ACTIVITY_OBJ_NEW:worldbossFightFail()
	self.worldboss_damage = math.min(2100000000, self.worldboss_damage)
	activity_manager._worldbossfightingId = nil

	AnalyticManager.worldbossfight_result({
		success = false,
		activityid = self._id,
		stage = self.worldboss_stage,
		damage = self.worldboss_damage
	})

	if not self:isWorldBossStage() then
		-- block empty
	else
		network:rpc("pass_worldboss_fight", {
			activityid = self._id,
			stage = self.worldboss_stage,
			damage = self.worldboss_damage
		}, function(arg_18_0)
			if arg_18_0.result == 1 then
				self.worldboss_stage = arg_18_0.stage
				self.worldboss_starttime = arg_18_0.starttime
				self.worldboss_daily_chance = arg_18_0.daily_chance
				self.worldboss_max_score = arg_18_0.max_score
				self.worldboss_rank = arg_18_0.rank
				self.worldboss_bosshp = arg_18_0.bosshp

				local var_18_0, var_18_1, var_18_2, var_18_3, var_18_4, var_18_5, var_18_6, var_18_7, var_18_8, var_18_9, var_18_10 = global_get({
					items = arg_18_0.item_res
				})

				LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
					activityId = self._id,
					entercallback = function()
						if not var_18_9 then
							return
						end

						LayerManager:pushInLayer("PopPurchaseResultLayer", {
							gold = var_18_0,
							diamond = var_18_1,
							honor = var_18_2,
							sp = var_18_3,
							energy = var_18_5,
							active = var_18_6,
							items = var_18_4,
							itemformat = arg_18_0.itemformat,
							surecallback = var_18_7,
							intocallback = var_18_10,
							cancelcallback = var_18_8
						})
					end
				})
			else
				global_ShowBlockWords("illegal error!!!")
				LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
					activityId = self._id
				})
			end
		end)
	end

	self.worldboss_damage = 0
end

function ACTIVITY_OBJ_NEW:get_worldboss_rank_list(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	network:rpc("get_worldboss_rank_list", {
		activityid = self._id,
		stage = arg_20_1,
		start = arg_20_2,
		count = arg_20_3
	}, function(arg_21_0)
		if arg_21_0.result == 1 and arg_20_4 then
			arg_20_4(arg_21_0)
		end
	end)
end
