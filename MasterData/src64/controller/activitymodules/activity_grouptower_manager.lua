local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")
local var_0_5

activity_base_manager.arrayGroupIndex = 1

function activity_base_manager.passGroupAdventure(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local model_manager = require("controller.model_manager")
	local horcrux_manager = require("controller.horcrux_manager")

	network:rpc("pass_adventure", {
		mode = arg_1_1,
		time = FightManager.getFightTimeStatistics()
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			if arg_2_0.gold and arg_2_0.gold > 0 then
				playermodel.gold = playermodel.gold + arg_2_0.gold
			end

			local var_2_0 = {}

			if arg_2_0.items then
				for iter_2_0, iter_2_1 in pairs(arg_2_0.items) do
					dropcache_manager:insertItemCache(iter_2_1)
				end
			end

			if arg_2_0.gainitems then
				for iter_2_2, iter_2_3 in pairs(arg_2_0.gainitems) do
					local var_2_1 = {}
					local var_2_2 = item_manager:setItemByServerItem(iter_2_3)

					var_2_1.entityid = iter_2_3.entityid
					var_2_1.number = var_2_2

					if var_2_2 > 0 then
						table.insert(var_2_0, var_2_1)
					end

					if equipData[iter_2_3.itemid].bag_item_type == kITEM_HERO or equipData[iter_2_3.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")

						local var_2_3 = GetRoleAnimationLayer:create(iter_2_3.itemid)

						if not var_2_3:getParent() then
							global_basic_scene:addChild(var_2_3, 999)
						end
					end
				end
			end

			if arg_2_0.gold and arg_2_0.gold > 0 then
				table.insert(var_2_0, {
					entityid = "gold",
					number = arg_2_0.gold
				})
			end

			local var_2_4 = {
				gold = arg_2_0.gold,
				score = arg_2_0.score,
				items = var_2_0
			}

			global_update_gold_stone_diamond(arg_2_0.gold)

			playermodel.curLevel = arg_2_0.curlevel
			playermodel.curMode = arg_2_0.curmode
			playermodel.levelmode[arg_2_0.levelmode.mode] = arg_2_0.levelmode

			if arg_2_0.externlevelmode then
				for iter_2_4, iter_2_5 in ipairs(arg_2_0.externlevelmode) do
					playermodel.levelmode[iter_2_5.mode] = iter_2_5
				end
			end

			if arg_2_0.gold and arg_2_0.gold > 0 then
				AnalyticManager.getGold("traingold", arg_2_0.gold)
			end

			tipsManager:triggerWithPassLevel(playermodel.curMode, playermodel.levelmode[arg_2_0.levelmode.mode].status)

			if arg_1_3 then
				arg_1_3(1, var_2_4, arg_2_0.remainfighttime, arg_2_0.canbuytime)
			end
		elseif arg_1_3 then
			arg_1_3(0)
		end
	end)
end

function activity_base_manager.getGroupmode(arg_3_0, arg_3_1)
	var_0_5 = arg_3_1
end

function activity_base_manager.getGroupTowerArray(arg_4_0)
	local var_4_0
	local var_4_1 = level_manager.getCurLevelData(playermodel.curMode, playermodel.curLevel)

	for iter_4_0 = 1, 10 do
		if iter_4_0 ~= 1 and not var_4_1["boss_team_" .. iter_4_0] then
			var_4_0 = iter_4_0 - 1

			break
		end
	end

	arg_4_0.groupNum = var_4_0

	local var_4_2 = {
		{
			{}
		}
	}

	for iter_4_1 = 1, var_4_0 do
		var_4_2[iter_4_1] = {}

		for iter_4_2 = 1, 5 do
			if RoleDefault:getInstance():getStringForKey(tostring(playermodel.curMode) .. "-" .. tostring(iter_4_1) .. "-" .. tostring(iter_4_2)) then
				local var_4_3 = {}

				var_4_3.fight_girl = tonumber(RoleDefault:getInstance():getStringForKey(tostring(playermodel.curMode) .. "-" .. tostring(iter_4_1) .. "-" .. tostring(iter_4_2)))
				var_4_3.pos = iter_4_2
				var_4_2[iter_4_1][iter_4_2] = var_4_3
				var_4_2[iter_4_1][iter_4_2].pos = iter_4_2
			else
				var_4_2[iter_4_1][iter_4_2] = {
					pos = iter_4_2
				}
				var_4_2[iter_4_1][iter_4_2].pos = iter_4_2
			end
		end
	end

	arg_4_0.allArray = var_4_2

	return var_4_2[activity_base_manager.arrayGroupIndex]
end

function activity_base_manager.getGroupEnemyList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs((monster_manager.getGroupChapterBigBossAll(playermodel.curMode, playermodel.curLevel, activity_base_manager.arrayGroupIndex))) do
		if iter_5_0 == "boss" then
			var_5_0[iter_5_0] = iter_5_1
		else
			var_5_0[tostring(1)] = iter_5_1
		end
	end

	return var_5_0
end

function activity_base_manager:getGroupNum()
	return self.groupNum
end

function activity_base_manager:getIsHaveArrayNil()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.allArray) do
		var_7_0[iter_7_0] = true

		for iter_7_2 = 1, 5 do
			if self.allArray[iter_7_0][iter_7_2].fight_girl ~= nil then
				var_7_0[iter_7_0] = false

				break
			end
		end
	end

	return var_7_0
end

function activity_base_manager:getGroupArray()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs((self:getGroupTowerArray())) do
		if iter_8_1.fight_girl then
			var_8_0[iter_8_0] = iter_8_1
			var_8_0[iter_8_0].classtype = 1
		end
	end

	return var_8_0
end

function activity_base_manager.getGroupActivityID(arg_9_0)
	return ((playermodel.curMode - 1) / 10 - 7) / 10
end

function activity_base_manager.getGroupIndexNum(arg_10_0)
	return activity_base_manager.arrayGroupIndex
end

function activity_base_manager.getGroupIndexNumUp(arg_11_0)
	activity_base_manager.arrayGroupIndex = activity_base_manager.arrayGroupIndex + 1

	return activity_base_manager.arrayGroupIndex
end

function activity_base_manager.getGroupIndexNumRestart(arg_12_0)
	activity_base_manager.arrayGroupIndex = 1
end

function activity_base_manager.isGroupTowerMode(arg_13_0, arg_13_1)
	return arg_13_1 == var_0_5
end

function activity_base_manager.startGroupTower(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	var_0_5 = arg_14_1

	require("network.network"):rpc("switch_to_adventuremode", {
		mode = arg_14_1,
		chapter = arg_14_2,
		servants = arg_14_4
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			playermodel.levelmode[arg_14_1] = arg_15_0.levelmode
			playermodel.curLevel = arg_15_0.curlevel
			playermodel.curMode = arg_15_0.curmode

			AnalyticManager.joinAdventure(arg_14_1)
			AnalyticManager.startLevel(playermodel.curMode, playermodel.curLevel)

			if arg_14_3 then
				arg_14_3(1)
			end
		elseif arg_14_3 then
			arg_14_3(arg_15_0.result)
		end
	end)
end
