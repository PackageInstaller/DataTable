local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local activity_study_servant_data = require("data.activity_study_servant_data")
local activity_study_index_data = require("data.activity_study_index_data")
local activity_study_task_data = require("data.activity_study_task_data")
local monsterdata = require("data.monsterdata")
local servant_data = require("data.servant_data")
local var_0_9 = 1
local var_0_10 = 2
local var_0_11 = 3
local var_0_12 = 4
local var_0_13 = 5
local var_0_14 = 6
local var_0_15 = 7
local var_0_16 = 8

ACTIVITY_OBJ_NEW.studyStateList = {}

local var_0_17 = 1
local var_0_18 = 2
local var_0_20 = 1
local var_0_21 = 2

function ACTIVITY_OBJ_NEW:get_activity_study_info()
	network:rpc("get_activity_study_info", {
		activityid = self._id
	}, function(arg_2_0)
		for iter_2_0, iter_2_1 in pairs(arg_2_0.list) do
			if iter_2_1.state == var_0_18 then
				self.curSturyServant = iter_2_1.servantid
			end

			self.studyStateList[iter_2_1.servantid] = iter_2_1.state
		end

		table.insert(arg_2_0.list, {})
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_STUDY_LIST_UPDATE, arg_2_0)
	end)
end

function ACTIVITY_OBJ_NEW:get_activity_study_servant_info(arg_3_1)
	network:rpc("get_activity_study_servant_info", {
		activityid = self._id,
		servantid = arg_3_1
	}, function(arg_4_0)
		self.curFightGirl = arg_3_1
		arg_4_0.state = self:getServantSturdyState(arg_4_0)

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_STUDY_SERVANT_UPDATE, arg_4_0)
	end)
end

function ACTIVITY_OBJ_NEW:do_activity_study(arg_5_1, arg_5_2)
	network:rpc("do_activity_study", {
		activityid = self._id,
		taskindex = activity_study_task_data[arg_5_2].index
	}, function(arg_6_0)
		if arg_6_0.result and arg_6_0.result ~= 1 then
			global_ShowBlockWords(L_DO_ACTIVITY_STUDY[arg_6_0.result])

			return
		end

		if arg_6_0.cost_gold then
			playermodel.gold = playermodel.gold - arg_6_0.cost_gold
		end

		if arg_6_0.cost_diamond then
			playermodel.diamond = playermodel.diamond - arg_6_0.cost_diamond
		end

		if arg_6_0.cost_strengthpoint then
			playermodel.strengthpoint = playermodel.strengthpoint - arg_6_0.cost_strengthpoint
		end

		if arg_6_0.consumes then
			for iter_6_0, iter_6_1 in pairs(arg_6_0.consumes) do
				item_manager:deleteItem(iter_6_1.entityid, iter_6_1.num)
			end
		end

		global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
		self:get_activity_study_servant_info(arg_5_1)
		global_ShowBlockWords(L_DO_ACTIVITY_STUDY[1])
	end)
end

function ACTIVITY_OBJ_NEW:change_activity_study(arg_7_1)
	network:rpc("change_activity_study", {
		activityid = self._id,
		servantid = arg_7_1
	}, function(arg_8_0)
		if not arg_8_0.result or arg_8_0.result == 1 then
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_STUDY_PLAY_EFFECT, arg_8_0)
			self:get_activity_study_info()
		elseif arg_8_0.result == 2 then
			global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[1])
		elseif arg_8_0.result == 3 then
			global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[3])
		elseif arg_8_0.result == 4 then
			global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[4])
		elseif arg_8_0.result == 5 then
			global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[5])
		end
	end)
end

function ACTIVITY_OBJ_NEW:finish_activity_study(arg_9_1)
	network:rpc("finish_activity_study", {
		activityid = self._id
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			LayerManager:removePopLayer()
			global_gain(arg_10_0)
			self:get_activity_study_info()

			return
		end

		global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[arg_10_0.result])
	end)
end

local function var_0_22(arg_11_0)
	local var_11_0 = {
		1,
		2,
		4,
		8,
		16,
		32,
		64,
		128,
		256,
		512,
		1024,
		2048,
		4096,
		8192,
		16384,
		32768,
		65536,
		131072,
		262144,
		524288,
		1048576,
		2097152,
		4194304,
		8388608,
		16777216,
		33554432,
		67108864,
		134217728,
		268435456,
		536870912,
		1073741824,
		2147483648
	}

	for iter_11_0 = 1, #arg_11_0.list do
		if bit.band(arg_11_0.finish, var_11_0[activity_study_task_data[arg_11_0.list[iter_11_0].taskid].index]) == 0 then
			return false
		end
	end

	return true
end

function ACTIVITY_OBJ_NEW:getServantSturdyState(arg_13_1)
	if arg_13_1.batchid <= 1 then
		if arg_13_1.pre_state == var_0_17 then
			return var_0_9
		elseif self.curSturyServant == arg_13_1.servantid then
			if var_0_22(arg_13_1) then
				return var_0_12
			else
				return var_0_11
			end
		else
			return var_0_10
		end
	else
		if self.studyStateList[arg_13_1.servantid] <= 1 then
			return var_0_13
		end

		if self.studyStateList[arg_13_1.servantid] >= 3 then
			return var_0_16
		end

		return (var_0_22(arg_13_1) or nil) and (var_0_15 or var_0_14)
	end
end

function ACTIVITY_OBJ_NEW:getStakePlayerConf()
	return self.curFightGirl or 203020
end

function ACTIVITY_OBJ_NEW:getStudyPlayerSync(arg_15_1)
	return activity_study_servant_data[self.curFightGirl].npcid
end

function ACTIVITY_OBJ_NEW.getStudyEnemySync(arg_16_0)
	return 100506001
end

function ACTIVITY_OBJ_NEW:getFightRresultEmenyData()
	return {
		playerArray = {
			{
				fight_girl = self.curFightGirl
			}
		},
		enemyArray = {
			{
				servantid = 100506001
			}
		}
	}
end

function ACTIVITY_OBJ_NEW.getServantUnlockjump(arg_18_0, arg_18_1)
	return activity_study_servant_data[arg_18_1].jump
end

function ACTIVITY_OBJ_NEW.getServantUnlockDes(arg_19_0, arg_19_1)
	if activity_study_servant_data[arg_19_1].trigger_type == var_0_20 then
		return {
			title = L_SCHOOL_STUDY_GO.title,
			des = L_SCHOOL_STUDY_GO.des,
			button = L_SCHOOL_STUDY_GO.button
		}
	elseif activity_study_servant_data[arg_19_1].trigger_type == var_0_21 then
		return {
			title = L_SCHOOL_STUDY_GO_2.title,
			des = L_SCHOOL_STUDY_GO_2.des,
			button = L_SCHOOL_STUDY_GO_2.button
		}
	end
end
