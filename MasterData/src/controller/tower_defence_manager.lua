local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local core_manager = require("controller.core_manager")
local time_check_manager = require("controller.time_check_manager")
local parse_server = require("controller.parse_server")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local bigWar_role_cost_data = require("data.bigWar_role_cost_data")
local bigWar_base_data = require("data.bigWar_base_data")
local item_data = require("data.item_data")
local var_0_18 = 1021
local var_0_19 = 0

function var_0_0.get_modetype(arg_1_0)
	return var_0_18
end

local function var_0_20(arg_2_0)
	return tonumber((arg_2_0:match("^%d+")))
end

local function var_0_21(arg_3_0)
	return model_data[servant_data[arg_3_0].modelid].range
end

local function var_0_22(arg_4_0)
	return core_manager:getCoreLv(arg_4_0)
end

function var_0_0.sortRoleListTbl(arg_5_0, arg_5_1)
	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0:get_servant_cost(arg_6_0)
		local var_6_1 = arg_5_0:get_servant_cost(arg_6_1)
		local var_6_2 = var_0_21(arg_6_0)
		local var_6_3 = var_0_21(arg_6_1)
		local var_6_4 = var_0_22(arg_6_0)

		if var_6_0 == var_6_1 then
			if var_6_4 == var_6_4 then
				return var_6_2 < var_6_3
			else
				return var_0_22(arg_6_1) < var_6_4
			end
		else
			return var_6_1 < var_6_0
		end
	end)
end

function var_0_0:initAllRoleList(arg_7_1)
	local var_7_0 = var_0_20(playermodel.curLevel)
	local var_7_1 = {}

	if chapter_data[playermodel.curMode .. "-" .. var_7_0].ele_type then
		if chapter_data[playermodel.curMode .. "-" .. var_7_0].ele_type_show then
			-- block empty
		end

		for iter_7_0 in chapter_data[playermodel.curMode .. "-" .. var_7_0].ele_type:gmatch("([^,]+)") do
			var_7_1[iter_7_0] = true
		end
	end

	self.initFightRoles = {}

	local var_7_4 = {}

	for iter_7_1, iter_7_2 in pairs(arg_7_1) do
		var_7_4[iter_7_2] = true
	end

	local var_7_5 = {}

	for iter_7_3, iter_7_4 in pairs(servant_data) do
		if playermodel.haveServant[iter_7_4.id] and (next(var_7_1) == nil or next(var_7_1) ~= nil and var_7_1[global_get_model_attr(iter_7_4.modelid)]) then
			table.insert(var_7_5, iter_7_4.id)
		end
	end

	self:sortRoleListTbl(var_7_5)

	if self.defenceType == 1 then
		local var_7_6 = require("controller/urban_defense_manager"):getInstance():getDefendGirls()
		local var_7_7 = {}

		for iter_7_5 = #var_7_5, 1, -1 do
			if var_7_6[var_7_5[iter_7_5]] then
				var_7_7[#var_7_7 + 1] = table.remove(var_7_5, iter_7_5)
			end
		end

		for iter_7_6 = 1, #var_7_7 do
			var_7_5[#var_7_5 + 1] = var_7_7[iter_7_6]
		end
	end

	for iter_7_7, iter_7_8 in pairs(var_7_5) do
		if var_7_4[iter_7_8] then
			table.insert(self.initFightRoles, iter_7_7)
		end
	end

	return var_7_5
end

function var_0_0.initEnemyConf(arg_8_0)
	local var_8_0 = level_manager.getCurMonsterTeamData(playermodel.curMode, level_manager.getCurLevelData(playermodel.curMode, playermodel.curLevel).boss_team)
	local var_8_1 = {
		index = 0,
		teams = {},
		times = {},
		isFinal = {}
	}

	while var_8_0["subteam" .. 1] do
		table.insert(var_8_1.teams, monster_manager.initBossList(var_8_0["subteam" .. 1]))

		local var_8_2 = level_manager.getCurMonsterTeamData(playermodel.curMode, var_8_0["subteam" .. 1])

		table.insert(var_8_1.times, {
			income_time = var_8_2.income_time,
			force_time = var_8_2.force_time
		})

		if var_8_2.is_endless then
			var_8_1.forever_team = monster_manager.initBossList(var_8_0["subteam" .. 1])
			var_8_1.forever_time = var_8_2.endless_time or 6
			var_8_1.forever_init_time = var_8_1.forever_time
		end

		if var_8_2.isFinal then
			var_8_1.isFinal[#var_8_1.teams] = true
		end
	end

	return var_8_1
end

function var_0_0:getRoleList()
	return self.roleList
end

function var_0_0:addRoleByManual(arg_10_1)
	if not self.isFighting then
		return
	end

	local var_10_0 = self.roleList[arg_10_1]

	if self.configInfo.max_role <= 0 then
		global_ShowBlockWords(L_EXP_MGR[15])

		return
	end

	if self._fighting[var_10_0] then
		return
	end

	self._fighting[var_10_0] = true

	FightManager.addTowerPlayerByManual(var_10_0, self:getCurFightPos(arg_10_1))

	self.configInfo.max_role = self.configInfo.max_role - 1
	self.totalCost = self.totalCost - self:get_servant_cost(var_10_0)

	self:updateTowerPanelUI(var_10_0)
	self:add_analysis_info("add_role_count")

	return true
end

function var_0_0.get_servant_cost(arg_11_0, arg_11_1)
	return 0
end

function var_0_0.get_servant_dead_cd(arg_12_0, arg_12_1)
	assert(servant_data[arg_12_1], arg_12_1)

	local var_12_0 = model_data[servant_data[arg_12_1].modelid].modeltype or ""

	for iter_12_0, iter_12_1 in ipairs({
		"servant" .. tostring(arg_12_1),
		"modeltype" .. var_12_0,
		model_data[servant_data[arg_12_1].modelid].career .. "_" .. servant_data[arg_12_1].roll_rarity
	}) do
		if bigWar_role_cost_data[iter_12_1] then
			return bigWar_role_cost_data[iter_12_1].dead_cd
		end
	end

	return 999
end

function var_0_0.getTowerDefanceEnemy(arg_13_0)
	local var_13_0 = monster_manager.initBossList((level_manager.getBossTeam()))

	if var_13_0.boss then
		arg_13_0._boss = var_13_0.boss.id or nil
	end

	return var_13_0
end

function var_0_0.getChapterConfByMode(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return chapter_data[arg_14_1 .. "-" .. arg_14_2][arg_14_3]
end

function var_0_0.switchToTowerDefence(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	arg_15_5 = arg_15_5 or {}

	network:rpc("switch_to_adventuremode", {
		mode = arg_15_1,
		chapter = arg_15_2,
		servants = arg_15_3
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			playermodel.levelmode[arg_15_1] = arg_16_0.levelmode
			playermodel.curLevel = arg_16_0.curlevel
			playermodel.curMode = arg_16_0.curmode
			arg_15_0.isFighting = true
			arg_15_0.defenceType = arg_15_5.type and arg_15_5.type or nil
			arg_15_0.roleList = arg_15_0:initAllRoleList(arg_15_3)
			arg_15_0.enemyConf = arg_15_0:initEnemyConf()
			arg_15_0.totalCost = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "begin_cost") or 50

			local var_16_0 = {}

			var_16_0.begin_cost = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "begin_cost") or 50
			var_16_0.grow_cost = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "grow_cost") or 5
			var_16_0.max_cost = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "max_cost") or 500
			var_16_0.cost_time = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "cost_time") or 3
			var_16_0.max_role = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "max_role") or 10
			var_16_0.role_limit = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "max_role") or 10
			var_16_0.free_xp_count = arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "free_xp_count") or 0
			var_16_0.fightauto = playermodel.autoXP
			var_16_0.fightspeed = FightManager.getBossSpeedUpForce()
			var_16_0.analysis_info = {}
			arg_15_0.configInfo = var_16_0
			arg_15_0._fighting = {}
			arg_15_0._dead = {}

			FightManager.setWorldMapWidth(FIGHTTYPE_TOWER, arg_15_0:getChapterConfByMode(arg_15_1, arg_15_2, "level_lenth") or 3000)
			AnalyticManager.joinAdventure(arg_15_1)
			AnalyticManager.startLevel(playermodel.curMode, playermodel.curLevel)
			AnalyticManager.switchTowerDefence({
				battlelevel = arg_15_1 .. "-" .. arg_15_2,
				choiceservantnum = table.nums(arg_15_0.roleList),
				rolebolong = playermodel:getOwnedServantNum()
			})

			if arg_15_4 then
				arg_15_4(arg_16_0)
			end
		elseif arg_15_4 then
			arg_15_4(arg_16_0)
		end
	end)
end

function var_0_0:getDefenceType()
	return self.defenceType
end

function var_0_0:getCurTotalCost()
	if not self.isFighting then
		return
	end

	return self.totalCost
end

function var_0_0:getCurConfData(arg_19_1)
	if not self.isFighting then
		return
	end

	return self.configInfo[arg_19_1]
end

function var_0_0.getTowerEnemy(arg_20_0)
	local var_20_0 = monster_manager.initBossList((level_manager.getBossTeam()))

	if var_20_0.boss then
		arg_20_0._boss = var_20_0.boss.id or nil
	end

	return var_20_0
end

function var_0_0:getCurFightPos(arg_21_1)
	return arg_21_1 + #self:getPlayerBaseConf()
end

function var_0_0:getCurRoleNum()
	if not self.isFighting then
		return
	end

	return self.configInfo.role_limit - self.configInfo.max_role
end

function var_0_0:getRoleTotalLimitNum()
	if not self.isFighting then
		return
	end

	return self.configInfo.role_limit
end

function var_0_0:isRoleFighting(arg_24_1)
	if not self.isFighting then
		return
	end

	if self._fighting[arg_24_1] then
		return true
	else
		return false
	end
end

function var_0_0:isRoleDead(arg_25_1)
	if not self.isFighting then
		return
	end

	return not not self._dead[arg_25_1]
end

function var_0_0:getRoleDeadTime(arg_26_1)
	if self:isRoleDead(arg_26_1) then
		return math.floor(self._dead[arg_26_1])
	else
		return ""
	end
end

function var_0_0:getRoleDeadTimePercent(arg_27_1)
	if self:isRoleDead(arg_27_1) then
		return (self:get_servant_dead_cd(arg_27_1) - self._dead[arg_27_1]) / self:get_servant_dead_cd(arg_27_1) * 100
	else
		return 0
	end
end

function var_0_0:getRoleCostPercent(arg_28_1)
	local var_28_0 = 100 - (self:getCurTotalCost() + var_0_19 / self.configInfo.cost_time * self.configInfo.grow_cost) / self:get_servant_cost(arg_28_1) * 100

	var_28_0 = var_28_0 > 100 and 100 or var_28_0

	return var_28_0
end

function var_0_0.getTowerBaseData(arg_29_0, arg_29_1)
	return bigWar_base_data[arg_29_1]
end

function var_0_0:getPlayerBaseConf(arg_30_1, arg_30_2)
	arg_30_1 = arg_30_1 or playermodel.curMode
	arg_30_2 = arg_30_2 or var_0_20(playermodel.curLevel)

	local var_30_0 = chapter_data[arg_30_1 .. "-" .. arg_30_2].playerbaseid
	local var_30_1
	local var_30_2

	if not chapter_data[arg_30_1 .. "-" .. arg_30_2].playerbaseid then
		var_30_0 = "10210010601"
		var_30_1 = {}
		var_30_2 = {
			charactertype = "player",
			isbase = true
		}
	end

	var_30_2.majorlist = self:getTowerBaseData(var_30_0)
	var_30_2.baseid = var_30_0
	var_30_2.pos_x = chapter_data[arg_30_1 .. "-" .. arg_30_2].playerbase_posx
	var_30_1[1] = var_30_2

	local var_30_3 = 1

	while chapter_data[arg_30_1 .. "-" .. arg_30_2]["playertower" .. var_30_3] do
		table.insert(var_30_1, {
			charactertype = "player",
			majorlist = self:getTowerBaseData(chapter_data[arg_30_1 .. "-" .. arg_30_2]["playertower" .. var_30_3]),
			baseid = chapter_data[arg_30_1 .. "-" .. arg_30_2]["playertower" .. var_30_3],
			pos_x = chapter_data[arg_30_1 .. "-" .. arg_30_2]["playertower" .. var_30_3 .. "_posx"]
		})

		var_30_3 = var_30_3 + 1
	end

	return var_30_1
end

function var_0_0:getEnemyBaseConf(arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1 or playermodel.curMode
	local var_31_1 = arg_31_2 or var_0_20(playermodel.curLevel)
	local var_31_2 = chapter_data[(arg_31_1 or playermodel.curMode) .. "-" .. var_31_1].enemybaseid
	local var_31_4
	local var_31_3

	if not chapter_data[(arg_31_1 or playermodel.curMode) .. "-" .. var_31_1].enemybaseid then
		var_31_2 = "10210010201"
		var_31_3 = {}
		var_31_4 = {
			charactertype = "enemy",
			isbase = true
		}
	end

	var_31_4.majorlist = self:getTowerBaseData(var_31_2)
	var_31_4.baseid = var_31_2
	var_31_4.pos_x = chapter_data[var_31_0 .. "-" .. var_31_1].enemybase_posx
	var_31_3[1] = var_31_4

	local var_31_5 = 1

	while chapter_data[var_31_0 .. "-" .. var_31_1]["enemytower" .. var_31_5] do
		table.insert(var_31_3, {
			charactertype = "enemy",
			majorlist = self:getTowerBaseData(chapter_data[var_31_0 .. "-" .. var_31_1]["enemytower" .. var_31_5]),
			baseid = chapter_data[var_31_0 .. "-" .. var_31_1]["enemytower" .. var_31_5],
			pos_x = chapter_data[var_31_0 .. "-" .. var_31_1]["enemytower" .. var_31_5 .. "_posx"]
		})

		var_31_5 = var_31_5 + 1
	end

	return var_31_3
end

function var_0_0.updateTowerPanelUI(arg_32_0, arg_32_1)
	if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().towerDefencePanel then
		local var_32_0 = FightLayer.getInstance().towerDefencePanel

		var_32_0:updateUI()
		var_32_0:updatePanelSp(arg_32_1)
	end
end

function var_0_0:updateTotalCost(arg_33_1)
	var_0_19 = var_0_19 + arg_33_1

	if var_0_19 >= self.configInfo.cost_time then
		var_0_19 = 0
		self.totalCost = self.totalCost + self.configInfo.grow_cost

		if self.totalCost >= self.configInfo.max_cost then
			self.totalCost = self.configInfo.max_cost
		end
	end
end

function var_0_0:updateDeadTime(arg_34_1)
	if self._dead and next(self._dead) ~= nil then
		for iter_34_0, iter_34_1 in pairs(self._dead) do
			self._dead[iter_34_0] = self._dead[iter_34_0] - arg_34_1

			if self._dead[iter_34_0] <= 0 then
				self._dead[iter_34_0] = nil
			end
		end
	end
end

function var_0_0:updateEnemyAppearTime(arg_35_1, arg_35_2)
	self:updateTotalCost(arg_35_1)
	self:updateDeadTime(arg_35_1)

	if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().towerDefencePanel then
		FightLayer.getInstance().towerDefencePanel:updatePanel()
	end

	if #self.enemyConf.teams <= self.enemyConf.index then
		if self.enemyConf.forever_time then
			self.enemyConf.forever_time = self.enemyConf.forever_time - arg_35_1

			if self.enemyConf.forever_time <= 0 then
				self.enemyConf.forever_time = self.enemyConf.forever_init_time

				return true, self.enemyConf.forever_team
			end
		end
	else
		if arg_35_2 then
			self.enemyConf.times[self.enemyConf.index + 1].income_time = self.enemyConf.times[self.enemyConf.index + 1].force_time
		end

		for iter_35_0 = self.enemyConf.index + 1, #self.enemyConf.teams do
			self.enemyConf.times[iter_35_0].income_time = self.enemyConf.times[iter_35_0].income_time - arg_35_1
		end

		if self.enemyConf.times[self.enemyConf.index + 1].income_time <= 0 then
			self.enemyConf.index = self.enemyConf.index + 1

			if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().towerDefencePanel then
				local var_35_0 = FightLayer.getInstance().towerDefencePanel

				FightLayer.getInstance():updateTowerDefenceWave()
			end

			return true, self.enemyConf.teams[self.enemyConf.index + 1], self.enemyConf.isFinal[self.enemyConf.index + 1]
		end
	end

	return false
end

function var_0_0:getTeamIdxStr()
	if not self.isFighting then
		return ""
	end

	return self.enemyConf.index .. "/" .. #self.enemyConf.teams, (self.enemyConf.index >= 10 or nil) and 0.8
end

function var_0_0:onPlayerDie(arg_37_1, arg_37_2, arg_37_3)
	if arg_37_2 then
		if arg_37_3 then
			self.isPlayerBossDie = true
		end

		return
	end

	local var_37_0 = self.roleList[tonumber(arg_37_1) - #self:getPlayerBaseConf()]

	self.configInfo.max_role = self.configInfo.max_role + 1
	self._fighting[var_37_0] = nil
	self._dead[var_37_0] = self:get_servant_dead_cd(var_37_0)

	self:updateTowerPanelUI(var_37_0)
end

function var_0_0:resetTowerFight()
	if FightLayer and FightLayer.getInstance() then
		FightLayer.getInstance():updateFightAutoMode(self.configInfo.fightauto or playermodel.autoXP)
		FightLayer.getInstance():updateFightSpeedUp(self.configInfo.fightspeed or 1.5)

		local var_38_1 = FightLayer.getInstance().towerDefencePanel.camera

		FightManager.unregisterWorldMapListener(var_38_1, var_38_1.listenerFunc)
		FightLayer.getInstance().btnAuto:setVisible(true)
		FightLayer.getInstance().btnSpeedup:setVisible(true)
	end

	self.last_fighting_list = self._fighting
	self.isFighting = nil
	self.defenceType = nil
	self.roleList = nil
	self.enemyConf = nil
	self.totalCost = nil
	self.configInfo = nil
	self._fighting = nil
	self._dead = nil
	self.isEnemyBossDie = nil
	self.isPlayerBossDie = nil
end

function var_0_0:refreshTowerFight()
	local var_39_0, var_39_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	self.isFighting = true
	self.enemyConf = self:initEnemyConf()
	self.totalCost = self:getChapterConfByMode(playermodel.curMode, var_39_0, "begin_cost") or 50

	local var_39_2 = {
		isrefresh = 1
	}

	var_39_2.begin_cost = self:getChapterConfByMode(playermodel.curMode, var_39_0, "begin_cost") or 50
	var_39_2.grow_cost = self:getChapterConfByMode(playermodel.curMode, var_39_0, "grow_cost") or 5
	var_39_2.max_cost = self:getChapterConfByMode(playermodel.curMode, var_39_0, "max_cost") or 500
	var_39_2.cost_time = self:getChapterConfByMode(playermodel.curMode, var_39_0, "cost_time") or 3
	var_39_2.max_role = self:getChapterConfByMode(playermodel.curMode, var_39_0, "max_role") or 10
	var_39_2.role_limit = self:getChapterConfByMode(playermodel.curMode, var_39_0, "max_role") or 10
	var_39_2.free_xp_count = self:getChapterConfByMode(playermodel.curMode, var_39_0, "free_xp_count") or 0
	var_39_2.fightauto = playermodel.autoXP
	var_39_2.analysis_info = {}
	self.configInfo = var_39_2
	self._fighting = {}
	self._dead = {}
end

function var_0_0:fightFail(arg_40_1, arg_40_2)
	local var_40_0, var_40_1 = playermodel.curLevel:match("(%d+)-(%d+)")

	AnalyticManager.towerDefenceFail({
		battlelevel = playermodel.curMode .. "-" .. var_40_0,
		costtime = math.floor(FightManager.getFightTimeStatistics()),
		costfreecdprpos = self:get_analysis_info("cost_free_xp_count"),
		costpaidcdprpos = self:get_analysis_info("cost_paid_xp_count"),
		servantarray = self:get_analysis_info("add_role_count"),
		isSurrender = arg_40_1 and 1 or 0,
		servantinfo = self:get_analysis_info("servant_info_list")
	})
	self:resetTowerFight()

	local var_40_2

	if arg_40_2 then
		arg_40_2()

		var_40_2 = {
			mode = playermodel.curMode,
			fighttime = FightManager.getFightTimeStatistics()
		}
	end

	var_40_2.failtype = arg_40_1 and 2 or 1

	network:rpc("pass_adventure_fail", var_40_2, function(arg_41_0)
		return
	end)
end

function var_0_0:fightSuccess(arg_42_1)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local model_manager = require("controller.model_manager")
	local tips_manager = require("controller.tips_manager")
	local var_42_5 = {}

	for iter_42_0, iter_42_1 in pairs(self._fighting) do
		var_42_5[#var_42_5 + 1] = iter_42_0
	end

	local function var_42_6(arg_43_0, arg_43_1)
		self:resetTowerFight()

		if arg_42_1 then
			arg_42_1(arg_43_0, arg_43_1)
		end
	end

	local var_42_7, var_42_8 = playermodel.curLevel:match("(%d+)-(%d+)")
	local var_42_9 = {
		battlelevel = playermodel.curMode .. "-" .. var_42_7,
		costtime = FightManager.getFightTimeStatistics(),
		costfreecdprpos = self:get_analysis_info("cost_free_xp_count"),
		costpaidcdprpos = self:get_analysis_info("cost_paid_xp_count"),
		servantarray = self:get_analysis_info("add_role_count"),
		servantinfo = self:get_analysis_info("servant_info_list")
	}

	network:rpc("pass_adventure", {
		mode = playermodel.curMode,
		time = FightManager.getFightTimeStatistics()
	}, function(arg_44_0)
		if arg_44_0.result == 1 then
			if arg_44_0.gold and arg_44_0.gold > 0 then
				playermodel.gold = playermodel.gold + arg_44_0.gold
			end

			if arg_44_0.diamond and arg_44_0.diamond > 0 then
				playermodel.diamond = playermodel.diamond + arg_44_0.diamond
			end

			local var_44_0 = {}

			if arg_44_0.items then
				for iter_44_0, iter_44_1 in pairs(arg_44_0.items) do
					dropcache_manager:insertItemCache(iter_44_1)
				end
			end

			if arg_44_0.gainitems then
				for iter_44_2, iter_44_3 in pairs(arg_44_0.gainitems) do
					local var_44_1 = {}
					local var_44_2 = item_manager:setItemByServerItem(iter_44_3)

					var_44_1.entityid = iter_44_3.entityid
					var_44_1.number = var_44_2

					if var_44_2 > 0 then
						table.insert(var_44_0, var_44_1)
					end

					if item_data[iter_44_3.itemid].bag_item_type == kITEM_HERO or item_data[iter_44_3.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")

						local var_44_3 = GetRoleAnimationLayer:create(iter_44_3.itemid)

						if not var_44_3:getParent() then
							global_basic_scene:addChild(var_44_3, 999)
						end
					end
				end
			end

			if arg_44_0.gold and arg_44_0.gold > 0 then
				table.insert(var_44_0, {
					entityid = "gold",
					number = arg_44_0.gold
				})
			end

			if arg_44_0.diamond and arg_44_0.diamond > 0 then
				table.insert(var_44_0, {
					entityid = "diamond",
					number = arg_44_0.diamond
				})
			end

			local var_44_4 = {
				gold = arg_44_0.gold,
				diamond = arg_44_0.diamond,
				score = arg_44_0.score,
				items = var_44_0
			}

			global_update_gold_stone_diamond(arg_44_0.gold, nil, playermodel.diamond)

			playermodel.curLevel = arg_44_0.curlevel
			playermodel.curMode = arg_44_0.curmode
			playermodel.levelmode[arg_44_0.levelmode.mode] = arg_44_0.levelmode

			if arg_44_0.gold and arg_44_0.gold > 0 then
				AnalyticManager.getGold("traingold", arg_44_0.gold)
			end

			if arg_44_0.costticket then
				item_manager:deleteItem(arg_44_0.costticket.entityid, arg_44_0.costticket.num)
			end

			tips_manager:triggerWithPassLevel(playermodel.curMode, playermodel.levelmode[arg_44_0.levelmode.mode].status)
			AnalyticManager.towerDefenceSuccess(var_42_9)

			if var_42_6 then
				var_42_6(1, var_44_4)
			end

			require("controller/urban_defense_manager"):getInstance():towerDefenceSuccess({
				mode = playermodel.curMode,
				chapter = var_42_7,
				curSoul = var_42_5
			})
		elseif var_42_6 then
			var_42_6(0)
		end
	end)
end

function var_0_0:addCostOnEnemyDie(arg_45_1)
	if not self.isFighting then
		return
	end

	local var_45_0 = arg_45_1.model
	local var_45_1
	local var_45_2

	if arg_45_1.model.baseid then
		var_45_1 = bigWar_base_data[var_45_0.baseid].kill_cost or 0
		var_45_2 = bigWar_base_data[var_45_0.baseid].free_xp_count or 0
	elseif var_45_0.monsterid then
		local var_45_3 = level_manager.getCurMonsterData(playermodel.curMode, var_45_0.monsterid)

		var_45_1 = var_45_3.kill_cost or 0
		var_45_2 = var_45_3.free_xp_count or 0
	end

	self.totalCost = self.totalCost + var_45_1

	if self.totalCost >= self.configInfo.max_cost then
		self.totalCost = self.configInfo.max_cost
	end

	self.configInfo.add_free_cost = (self.configInfo.add_free_cost or 0) + var_45_2
	self.configInfo.free_xp_count = self.configInfo.free_xp_count + var_45_2

	if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().towerDefencePanel then
		local var_45_4 = FightLayer.getInstance().towerDefencePanel

		if var_45_2 > 0 then
			var_45_4:updateXpCountUI()
			var_45_4:showMonsterDropSp("xp")
		end
	end

	if arg_45_1:isBoss() then
		self.isEnemyBossDie = true
	end
end

function var_0_0:isBossDie(arg_46_1)
	if arg_46_1 == "player" then
		return self.isPlayerBossDie
	elseif arg_46_1 == "enemy" then
		return self.isEnemyBossDie
	else
		return self.isEnemyBossDie or self.isPlayerBossDie
	end
end

function var_0_0:costSpecialItem(arg_47_1, arg_47_2)
	if not self.isFighting then
		arg_47_2({})

		return
	end

	arg_47_1 = arg_47_1 == "xp" and 1 or 2

	local var_47_0 = playermodel.curMode
	local var_47_1 = var_0_20(playermodel.curLevel)

	;(function()
		network:rpc("tower_defence_cost_item", {
			mode = var_47_0,
			chapter = var_47_1,
			costtype = arg_47_1,
			isrefresh = self.configInfo.isrefresh,
			add_free_cost = self.configInfo.add_free_cost
		}, function(arg_49_0)
			if arg_49_0.result == 1 then
				if arg_49_0.costitemid then
					item_manager:deleteItem(arg_49_0.costitemid, arg_49_0.costnum)
					self:add_analysis_info("cost_paid_xp_count")
				elseif arg_49_0.costdiamond then
					playermodel.diamond = playermodel.diamond - arg_49_0.costdiamond

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
					self:add_analysis_info("cost_paid_xp_count")
				elseif arg_49_0.free_xp_count then
					self.configInfo.free_xp_count = arg_49_0.free_xp_count
					self.configInfo.add_free_cost = nil

					self:add_analysis_info("cost_free_xp_count")
				end

				if self.configInfo.isrefresh then
					self.configInfo.isrefresh = nil
				end

				if arg_47_2 then
					arg_47_2(arg_49_0)
				end
			else
				global_ShowBlockWords((not L_TOWER_DEFENCE_COST_ERROR[arg_49_0.result] or nil) and "ERROR")

				if arg_47_2 then
					arg_47_2(arg_49_0)
				end
			end
		end)
	end)()
end

function var_0_0.getAllLevelEnemys(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = {}
	local var_50_1 = {}
	local var_50_2 = level_manager.getCurMonsterTeamData(arg_50_1, level_manager.getCurLevelData(arg_50_1, arg_50_2 .. "-1").boss_team)

	while var_50_2["subteam" .. 1] do
		local var_50_3 = level_manager.getCurMonsterTeamData(arg_50_1, var_50_2["subteam" .. 1])

		for iter_50_0, iter_50_1 in pairs((monster_manager.initBossList(var_50_2["subteam" .. 1]))) do
			var_50_0[iter_50_1.majorlist.modelid] = true

			if var_50_3.isFinal and iter_50_1.index == 1 then
				var_50_1[var_50_0[iter_50_1.majorlist.modelid]] = true
			end
		end
	end

	local var_50_5 = {}

	for iter_50_2, iter_50_3 in pairs(var_50_0) do
		table.insert(var_50_5, iter_50_2)
	end

	return var_50_5, var_50_1
end

function var_0_0:getRandomFightingModelid()
	if self.last_fighting_list then
		local var_51_0 = {}

		for iter_51_0, iter_51_1 in pairs(self.last_fighting_list) do
			table.insert(var_51_0, iter_51_0)
		end

		return global_get_servant_skin(var_51_0[math.random(#var_51_0)]) or "22120"
	end
end

function var_0_0.getXPItemNum(arg_52_0)
	return "×" .. item_manager:getItemNumber(levelmode_data[playermodel.curMode].special_cost_item1)
end

function var_0_0.getXPItemNumEx(arg_53_0)
	return item_manager:getItemNumber(levelmode_data[playermodel.curMode].special_cost_item1)
end

function var_0_0:getXPFreeCount()
	if not self.configInfo then
		return 0
	end

	return self.configInfo.free_xp_count
end

function var_0_0.getReflagItemNum(arg_55_0)
	return "×" .. item_manager:getItemNumber(levelmode_data[playermodel.curMode].special_cost_item2)
end

function var_0_0.getReflagItemNumEx(arg_56_0)
	return item_manager:getItemNumber(levelmode_data[playermodel.curMode].special_cost_item2)
end

function var_0_0:getTowerDefenceAllPlayerModels()
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in pairs((self:getRoleList())) do
		table.insert(var_57_0, global_get_servant_skin(iter_57_1))
	end

	for iter_57_2, iter_57_3 in pairs((self:getPlayerBaseConf(mode, chapter))) do
		table.insert(var_57_0, iter_57_3.majorlist.modelid)
	end

	return var_57_0
end

function var_0_0:getTowerDefenceAllEnemyModels()
	local var_58_0 = var_0_20(playermodel.curLevel)
	local var_58_1 = self:getAllLevelEnemys(playermodel.curMode, var_58_0)

	for iter_58_0, iter_58_1 in pairs((self:getEnemyBaseConf(playermodel.curMode, var_58_0))) do
		table.insert(var_58_1, iter_58_1.majorlist.modelid)
	end

	return var_58_1
end

function var_0_0:get_analysis_info(arg_59_1)
	if not self.configInfo then
		return
	end

	if not self.configInfo.analysis_info then
		return
	end

	if arg_59_1 == "servant_info_list" then
		local var_59_0 = {}

		for iter_59_0, iter_59_1 in pairs(self.roleList) do
			table.insert(var_59_0, {
				servantid = iter_59_1,
				cost = self:get_servant_cost(iter_59_1),
				level = core_manager:getCoreLv(iter_59_1),
				fight_capacity = fight_capacity_manager:getSoulFightCapacity(iter_59_1)
			})
		end

		return json.encode(var_59_0)
	else
		return self.configInfo.analysis_info[arg_59_1]
	end
end

function var_0_0:set_analysis_info(arg_60_1, arg_60_2)
	if not self.configInfo then
		return
	end

	if not self.configInfo.analysis_info then
		return
	end

	self.configInfo.analysis_info[arg_60_1] = arg_60_2
end

function var_0_0:add_analysis_info(arg_61_1)
	if not self.configInfo then
		return
	end

	if not self.configInfo.analysis_info then
		return
	end

	self.configInfo.analysis_info[arg_61_1] = (self.configInfo.analysis_info[arg_61_1] or 0) + 1
end

return var_0_0
