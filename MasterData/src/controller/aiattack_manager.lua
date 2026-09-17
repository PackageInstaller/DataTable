local var_0_0 = {
	_fighted = {},
	_fighting = {},
	_dead = {},
	ailist = {}
}
local var_0_1 = {}
local bit = require("bit")
local var_0_4 = 43781
local var_0_5 = bit.bxor(8, 43781)
local var_0_6 = 1011
local network = require("network.network")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")

function var_0_0.get_levelmode_id(arg_1_0)
	return var_0_6
end

function var_0_0.fightFail(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_1()
	end
end

function var_0_0:fightSuccess(arg_3_1)
	local item_manager = require("controller.item_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local model_manager = require("controller.model_manager")
	local var_3_4 = playermodel.curMode
	local var_3_5 = {}
	local var_3_6 = {}

	for iter_3_0, iter_3_1 in pairs(self._dead) do
		var_3_5[iter_3_1] = not var_3_5[iter_3_1] and 1 or var_3_5[iter_3_1] + 1
	end

	for iter_3_2, iter_3_3 in pairs(var_3_5) do
		table.insert(var_3_6, {
			itemid = iter_3_2,
			num = iter_3_3
		})
	end

	network:rpc("pass_aiattack", {
		mode = playermodel.curMode,
		token = nil,
		cost_items = var_3_6
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			if arg_5_0.gold and arg_5_0.gold > 0 then
				playermodel.gold = playermodel.gold + arg_5_0.gold
			end

			local var_5_0 = {}

			if arg_5_0.items then
				for iter_5_0, iter_5_1 in pairs(arg_5_0.items) do
					dropcache_manager:insertItemCache(iter_5_1)
				end
			end

			if arg_5_0.gainitems then
				for iter_5_2, iter_5_3 in pairs(arg_5_0.gainitems) do
					local var_5_1 = {}

					var_5_1.number, var_5_1.entityid = item_manager:setItemByServerItem(iter_5_3), iter_5_3.entityid

					table.insert(var_5_0, var_5_1)

					if item_data[iter_5_3.itemid].bag_item_type == kITEM_HERO or item_data[iter_5_3.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")

						local var_5_2 = GetRoleAnimationLayer:create(iter_5_3.itemid)

						if not var_5_2:getParent() then
							global_basic_scene:addChild(var_5_2, 999)
						end
					end
				end
			end

			if arg_5_0.gold and arg_5_0.gold > 0 then
				table.insert(var_5_0, {
					entityid = "gold",
					number = arg_5_0.gold
				})
			end

			local var_5_3 = {
				gold = arg_5_0.gold,
				items = var_5_0
			}

			for iter_5_4, iter_5_5 in pairs(var_3_6) do
				item_manager:deleteItem(iter_5_5.itemid, iter_5_5.num)
			end

			global_update_gold_stone_diamond(arg_5_0.gold)

			playermodel.curLevel = arg_5_0.curlevel
			playermodel.curMode = arg_5_0.curmode

			if playermodel.levelmode[arg_5_0.levelmode.mode].status ~= arg_5_0.levelmode.status then
				var_0_1[var_3_4 .. "-" .. tostring(arg_5_0.levelmode.status - 1) .. "-1"] = nil
			end

			playermodel.levelmode[arg_5_0.levelmode.mode] = arg_5_0.levelmode

			if arg_5_0.gold and arg_5_0.gold > 0 then
				AnalyticManager.getGold("traingold", arg_5_0.gold)
			end

			if arg_3_1 then
				arg_3_1(1, var_5_3, var_3_6)
			end
		elseif arg_3_1 then
			arg_3_1(0)
		end
	end)
end

function var_0_0.isAllFighted(arg_6_0)
	return false
end

function var_0_0:isNoHaveAI()
	for iter_7_0, iter_7_1 in pairs(self.ailist) do
		if self:getLeftMonsterNum(iter_7_1) > 0 then
			return false
		end
	end

	return true
end

function var_0_0:getAvailableAINum()
	return bit.bxor(var_0_5, var_0_4) - self:getFightingNum()
end

function var_0_0:getFightingNum()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(self._fighting) do
		var_9_0 = var_9_0 + self:getAIWeight(iter_9_1)
	end

	return var_9_0
end

function var_0_0:getFightedNum()
	return #self._fighted
end

function var_0_0.getAllHaveAI(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs((require("data.item_AI_data"))) do
		if item_manager:haveItem(iter_11_0) then
			table.insert(var_11_0, iter_11_0)
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		local var_12_0 = fight_capacity_manager:getEnemyFightCapacity(var_0_6, item_data[arg_12_0].monster)
		local var_12_1 = fight_capacity_manager:getEnemyFightCapacity(var_0_6, item_data[arg_12_1].monster)

		if var_12_0 == var_12_1 then
			return arg_12_0 < arg_12_1
		else
			return var_12_1 < var_12_0
		end
	end)

	return var_11_0
end

function var_0_0:getLeftMonsterNum(arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(self._fighted) do
		if iter_13_1 == arg_13_1 then
			var_13_0 = var_13_0 + 1
		end
	end

	return item_manager:getItemNumber(arg_13_1) - var_13_0
end

function var_0_0:addAiByManual(arg_14_1)
	if self:isAllFighted() then
		global_ShowBlockWords("上阵次数已用完")

		return
	end

	local var_14_0 = self.ailist[arg_14_1]

	if self:getLeftMonsterNum(self.ailist[arg_14_1]) <= 0 then
		global_ShowBlockWords("怪物已用完")

		return
	end

	local var_14_1 = item_data[var_14_0].monster
	local var_14_2 = self:getMonsterData(item_data[var_14_0].monster)

	var_14_2.ai_monster_level = item_data[var_14_0].ai_monster_level

	if self:getAvailableAINum() - self:getAIWeight(var_14_0) < 0 then
		global_ShowBlockWords("人口不足")

		return
	end

	local var_14_3 = self:getCurFightPos()

	table.insert(self._fighted, var_14_0)

	self._fighting[var_14_3] = var_14_0

	FightManager.addNewAiPlayerByManual(var_14_2, var_14_1, var_14_3)

	return true
end

function var_0_0:getCurFightPos()
	local var_15_1 = 1

	while self._fighting[var_15_1] do
		var_15_1 = var_15_1 + 1
	end

	return var_15_1
end

function var_0_0:onAiDie(arg_16_1)
	arg_16_1 = tonumber(arg_16_1)

	table.insert(self._dead, self._fighting[arg_16_1])

	if self:getLeftMonsterNum(self._fighting[arg_16_1]) <= 0 then
		self:remove_spine_cache(self:getMonsterData(item_data[self._fighting[arg_16_1]].monster).modelid)
	end

	self._fighting[arg_16_1] = nil
end

function var_0_0.getAiAttackEnemy(arg_17_0)
	local var_17_0 = monster_manager.initBossList((level_manager.getBossTeam()))

	if var_17_0.boss then
		arg_17_0._boss = var_17_0.boss.id or nil
	end

	return var_17_0
end

function var_0_0.switchToAiAttack(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1 = var_0_6

	local var_18_0, var_18_1 = level_manager:isModeValid(var_0_6)

	if not var_18_0 then
		if arg_18_3 then
			arg_18_3(var_18_1)
		end

		return
	end

	network:rpc("switch_to_aiattack", {
		mode = var_0_6,
		chapter = arg_18_2
	}, function(arg_19_0)
		if arg_19_0.result == 1 then
			playermodel.levelmode[arg_18_1] = arg_19_0.levelmode
			playermodel.curLevel = arg_19_0.curlevel
			playermodel.curMode = arg_19_0.curmode
			var_0_5 = level_manager.getCurLevelData(arg_18_1, arg_18_2 .. "-1").weight_limit
			arg_18_0.ailist = arg_18_0:getAllHaveAI()
			arg_18_0._fighted = {}
			arg_18_0._fighting = {}
			arg_18_0._dead = {}

			AnalyticManager.joinAdventure(arg_18_1)
			AnalyticManager.startLevel(playermodel.curMode, playermodel.curLevel)

			if arg_18_3 then
				arg_18_3(1)
			end
		elseif arg_18_3 then
			arg_18_3(arg_19_0.result)
		end
	end)
end

function var_0_0:getAiList()
	return self.ailist
end

function var_0_0.getMonsterData(arg_21_0, arg_21_1)
	return monster_manager:getMonsterData(var_0_6, arg_21_1)
end

function var_0_0.remove_spine_cache(arg_22_0, arg_22_1)
	SpineCacheManager:releaseSpineCacheTextures(ROLE_SPINE_PATH .. model_data[arg_22_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_22_1].spine_model .. ".atlas", (model_data[arg_22_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[arg_22_1].clothes_model .. ".atlas" or nil))
end

function var_0_0:random_ai_modelid()
	local var_23_0 = {}
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(self._fighted) do
		local var_23_2 = item_data[iter_23_1].ai_monster_level or 1
		local var_23_3 = self:getMonsterData(item_data[iter_23_1].monster).modelid

		if var_23_2 > 1 then
			table.insert(var_23_0, var_23_3)
		end

		table.insert(var_23_1, var_23_3)
	end

	if next(var_23_0) == nil then
		return var_23_1[math.random(#var_23_1)]
	else
		return var_23_0[math.random(#var_23_0)]
	end
end

function var_0_0:getDeadAINum()
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(self._dead) do
		var_24_0 = var_24_0 + 1
	end

	return var_24_0
end

function var_0_0.getAdventureDropInfo(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if var_0_1[arg_25_1 .. "-" .. arg_25_2] then
		if arg_25_3 then
			arg_25_3(var_0_1[arg_25_1 .. "-" .. arg_25_2])
		end

		return
	end

	network:rpc("get_level_drop_info", {
		infotype = "AIATTACK",
		chapter = arg_25_1 .. "-" .. arg_25_2
	}, function(arg_26_0)
		var_0_1[arg_25_1 .. "-" .. arg_25_2] = arg_26_0.dropinfo

		if arg_25_3 then
			pcall(arg_25_3, arg_26_0.dropinfo)
		end
	end)
end

function var_0_0:getAIWeight(arg_27_1)
	return self:getMonsterData(item_data[arg_27_1].monster).monster_weight or 1
end

return var_0_0
