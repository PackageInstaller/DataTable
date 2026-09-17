local activityBattlePassObj = class("activityBattlePassObj")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local activity_vipbuy_data = require("data.activity_vipbuy_data")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_manager = require("controller.activity_manager")
local recharge_manager = require("controller.recharge_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")

function activityBattlePassObj:ctor(arg_1_1, arg_1_2)
	self._id = arg_1_1
	self._activityObj = arg_1_2
	self.battlePassStat = {}
	self.taskList = {}

	self:initBattlePassMaxLevel()
end

function activityBattlePassObj:getBattlePassLevelData()
	self._activityObj:getActivityProceed(function(arg_3_0, arg_3_1)
		if arg_3_0 ~= 1 then
			return
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			var_3_0[iter_3_1.id] = {}
			var_3_0[iter_3_1.id].stat = iter_3_1.status
			var_3_0[iter_3_1.id].level = iter_3_1.id
			var_3_0[iter_3_1.id].drop = activity_proceed_data[self._id .. "-" .. iter_3_1.id].drop
			var_3_0[iter_3_1.id].specialDrop = activity_proceed_data[self._id .. "-" .. iter_3_1.id].specialDrop
		end

		self.battlePassStat = var_3_0

		table.insert(var_3_0, {
			level = "?",
			stat = UN_KONW
		})
		activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, {
			list = var_3_0,
			listLen = #var_3_0
		})
		activity_manager:updateActivityAlert("proceed", self._id, self:isHasRewardCanGet())
	end)
end

function activityBattlePassObj:getCurBattlePassLevel()
	if not self.battlePassStat then
		return
	end

	for iter_4_0 = 1, #self.battlePassStat do
		if self.battlePassStat[iter_4_0].stat == var_0_1 then
			return self.battlePassStat[iter_4_0].level
		end
	end

	return #self.battlePassStat
end

function activityBattlePassObj:getBattlePassExp(arg_5_1)
	local var_5_0 = self._id .. "-" .. (arg_5_1 or self:getCurBattlePassLevel())

	if not activity_proceed_data[var_5_0] then
		return 0
	end

	local var_5_1 = activity_proceed_data[var_5_0].item1

	if self:isBattlePassSVIP() then
		return item_manager:getItemNumber(var_5_1)
	else
		return item_manager:getItemNumber(var_5_1) * (activity_vipbuy_data["svip_" .. self._id].magnification or 1)
	end
end

function activityBattlePassObj:isBattlePassVIP()
	return item_manager:haveItem(activity_vipbuy_data["vip_" .. self._id].checkitem) or item_manager:haveItem(activity_vipbuy_data["allvip_" .. self._id].checkitem)
end

function activityBattlePassObj:isBattlePassSVIP()
	return item_manager:haveItem(activity_vipbuy_data["allvip_" .. self._id].checkitem)
end

function activityBattlePassObj:getCurLevelProceed(arg_8_1)
	local var_8_0 = arg_8_1 or self:getCurBattlePassLevel()
	local var_8_1 = self._id .. "-" .. var_8_0

	if not activity_proceed_data[self._id .. "-" .. var_8_0] then
		var_8_0 = var_8_0 - 1
		var_8_1 = self._id .. "-" .. var_8_0
	end

	local var_8_2 = activity_proceed_data[var_8_1].num1
	local var_8_3 = activity_proceed_data[self._id .. "-" .. var_8_0 - 1] or {
		num1 = 0
	}
	local var_8_4 = item_manager:getItemNumber(activity_proceed_data[var_8_1].item1)

	if self:isBattlePassSVIP() then
		var_8_4 = math.ceil(var_8_4 * (activity_vipbuy_data["svip_" .. self._id].magnification or 1))
	end

	return (var_8_4 - var_8_3.num1) / (var_8_2 - var_8_3.num1) * 100, var_8_4 - var_8_3.num1 .. "/" .. var_8_2 - var_8_3.num1
end

function activityBattlePassObj:getBattlePassDrop(arg_9_1)
	if not arg_9_1 then
		return {}
	end

	local var_9_0 = drop_manager:getAllDrops(arg_9_1)

	if drop_manager:getGold(arg_9_1) > 0 then
		table.insert(var_9_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_9_1)
		})
	end

	if drop_manager:getDiamond(arg_9_1) > 0 then
		table.insert(var_9_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_9_1)
		})
	end

	return var_9_0
end

function activityBattlePassObj:getBattlePassReward(arg_10_1)
	self._activityObj:getActivityProceedAward(arg_10_1, function(arg_11_0, arg_11_1)
		if arg_11_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		if arg_11_1.items and next(arg_11_1.items) then
			global_gain(arg_11_1)
		end

		self:getBattlePassLevelData()
	end)
end

function activityBattlePassObj:getActivityTask()
	self._activityObj:getActivityTaskList(nil, function(arg_13_0, arg_13_1)
		if arg_13_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_13_0, iter_13_1 in pairs(arg_13_1.list) do
			iter_13_1.name = task_data[iter_13_1.taskid].name
			iter_13_1.task_des = task_data[iter_13_1.taskid].task_des
			iter_13_1.image = task_data[iter_13_1.taskid].image
			iter_13_1.drop = task_data[iter_13_1.taskid].drop
			iter_13_1.jump = task_data[iter_13_1.taskid].jump
			iter_13_1.order = task_data[iter_13_1.taskid].order
			iter_13_1.display_type = task_data[iter_13_1.taskid].display_type

			if iter_13_1.status == 1 then
				iter_13_1.percent = -1
			end

			table.insert(self.taskList, iter_13_1)
		end

		table.sort(self.taskList, function(arg_14_0, arg_14_1)
			if arg_14_0.display_type ~= arg_14_1.display_type then
				if arg_14_0.percent < 0 then
					return false
				elseif arg_14_1.percent < 0 then
					return true
				end

				return arg_14_0.display_type > arg_14_1.display_type
			end

			if arg_14_0.percent == arg_14_1.percent then
				return arg_14_0.order < arg_14_1.order
			else
				return arg_14_0.percent > arg_14_1.percent
			end
		end)
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.taskList,
			listLen = #self.taskList
		})
		activity_manager:updateActivityAlert("task", self._id, self:isHasCanCompleteTask())
	end, false, nil)
end

function activityBattlePassObj:getActivityTaskData()
	return self.taskList
end

function activityBattlePassObj:getCompleteTaskNum()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self.taskList) do
		if not iter_16_1.percent or iter_16_1.percent == -1 or iter_16_1.percent == 100 then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function activityBattlePassObj:isHasRewardCanGet()
	for iter_17_0, iter_17_1 in ipairs(self.battlePassStat) do
		if iter_17_1.stat == var_0_2 then
			return true
		end

		if iter_17_1.stat == var_0_3 and self:isBattlePassVIP() then
			return true
		end
	end

	return false
end

function activityBattlePassObj:isHasCanCompleteTask()
	if not self.taskList then
		return false
	end

	for iter_18_0, iter_18_1 in pairs(self.taskList) do
		if iter_18_1.status == 0 and iter_18_1.percent == 100 then
			return true
		end
	end

	return false
end

function activityBattlePassObj:getBPTaskReward(arg_19_1)
	self._activityObj:getTaskReward(arg_19_1, function(arg_20_0, arg_20_1)
		if arg_20_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_20_1)
		self:getActivityTask()
		self:getBattlePassLevelData()
	end)
end

function activityBattlePassObj:getTaskRewardOneKey()
	self._activityObj:getActivityTaskList(nil, function(arg_22_0, arg_22_1)
		if arg_22_0 ~= 1 then
			return
		end

		global_gain(arg_22_1)

		self.taskList = {}

		for iter_22_0, iter_22_1 in pairs(arg_22_1.list) do
			iter_22_1.name = task_data[iter_22_1.taskid].name
			iter_22_1.task_des = task_data[iter_22_1.taskid].task_des
			iter_22_1.image = task_data[iter_22_1.taskid].image
			iter_22_1.drop = task_data[iter_22_1.taskid].drop
			iter_22_1.jump = task_data[iter_22_1.taskid].jump
			iter_22_1.order = task_data[iter_22_1.taskid].order
			iter_22_1.display_type = task_data[iter_22_1.taskid].display_type

			if iter_22_1.status == 1 then
				iter_22_1.percent = -1
			end

			table.insert(self.taskList, iter_22_1)
		end

		table.sort(self.taskList, function(arg_23_0, arg_23_1)
			if arg_23_0.display_type ~= arg_23_1.display_type then
				if arg_23_0.percent < 0 then
					return false
				elseif arg_23_1.percent < 0 then
					return true
				end

				return arg_23_0.display_type > arg_23_1.display_type
			end

			if arg_23_0.percent == arg_23_1.percent then
				return arg_23_0.order < arg_23_1.order
			else
				return arg_23_0.percent > arg_23_1.percent
			end
		end)
		self:getBattlePassLevelData()
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.taskList,
			listLen = #self.taskList
		})
		activity_manager:updateActivityAlert("task", self._id, self:isHasCanCompleteTask())
	end, true, nil)
end

function activityBattlePassObj:getAllVIPLevelGift(arg_24_1)
	arg_24_1 = arg_24_1 or 1

	local var_24_0 = self._id .. "-" .. arg_24_1
	local var_24_1 = 0
	local var_24_2 = {}

	while activity_proceed_data[var_24_0] do
		if activity_proceed_data[var_24_0].specialDrop then
			for iter_24_0, iter_24_1 in pairs((self:getBattlePassDrop(activity_proceed_data[var_24_0].specialDrop))) do
				iter_24_1.level = arg_24_1

				if iter_24_1.dropid ~= "diamond" then
					table.insert(var_24_2, iter_24_1)
				else
					var_24_1 = var_24_1 + iter_24_1.dropNum
				end
			end
		end

		arg_24_1 = arg_24_1 + 1
		var_24_0 = self._id .. "-" .. arg_24_1
	end

	if var_24_1 > 0 then
		table.insert(var_24_2, {
			dropid = "diamond",
			dropNum = var_24_1
		})
	end

	table.sort(var_24_2, function(arg_25_0, arg_25_1)
		if arg_25_0.dropid == "diamond" then
			return true
		end

		if arg_25_1.dropid == "diamond" then
			return false
		end

		return item_data[arg_25_0.dropid].bag_item_type > item_data[arg_25_1.dropid].bag_item_type
	end)

	return var_24_2
end

function activityBattlePassObj:initBattlePassMaxLevel()
	self._maxLevel = 1

	while activity_proceed_data[self._id .. "-" .. self._maxLevel] do
		self._maxLevel = self._maxLevel + 1
	end
end

function activityBattlePassObj:getBattlePassMaxLevel()
	return self._maxLevel
end

function activityBattlePassObj:canLevelUp(arg_28_1)
	return arg_28_1 + self:getCurBattlePassLevel() <= self._maxLevel
end

function activityBattlePassObj:getLevelupCanGetDrop(arg_29_1)
	local var_29_0 = self:getCurBattlePassLevel()

	if var_29_0 + arg_29_1 > self._maxLevel then
		return {}
	end

	local var_29_1 = 1
	local var_29_2 = {}

	while var_29_1 <= arg_29_1 do
		if activity_proceed_data[self._id .. "-" .. var_29_0 + 1 - 1].specialDrop then
			for iter_29_0, iter_29_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. "-" .. var_29_0 + 1 - 1].specialDrop))) do
				iter_29_1.level = var_29_0 + var_29_1 - 1
				var_29_2[var_29_1] = var_29_2[var_29_1] or {}

				table.insert(var_29_2[var_29_1], iter_29_1)
			end
		end

		if activity_proceed_data[self._id .. "-" .. var_29_0 + 1 - 1].drop then
			for iter_29_2, iter_29_3 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. "-" .. var_29_0 + 1 - 1].drop))) do
				iter_29_3.level = var_29_0 + var_29_1 - 1
				var_29_2[var_29_1] = var_29_2[var_29_1] or {}

				table.insert(var_29_2[var_29_1], iter_29_3)
			end
		end

		var_29_1 = var_29_1 + 1
	end

	return var_29_2
end

function activityBattlePassObj:buyVipById(arg_30_1)
	local function var_30_0(arg_31_0, arg_31_1)
		if arg_31_0 ~= 1 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_VIP[arg_31_0])

			return
		end

		for iter_31_0, iter_31_1 in pairs(arg_31_1.costitems) do
			item_manager:deleteItem(iter_31_1.itemid, iter_31_1.costnum)
		end

		arg_31_1.items = arg_31_1.getitems

		local var_31_0 = {}
		local var_31_1 = {}

		for iter_31_2 = 1, #arg_31_1.items do
			if arg_31_1.items[iter_31_2].itemid == activity_vipbuy_data["vip_" .. self._id].checkitem or arg_31_1.items[iter_31_2].itemid == activity_vipbuy_data["svip_" .. self._id].checkitem then
				table.insert(var_31_1, arg_31_1.items[iter_31_2])
			else
				table.insert(var_31_0, arg_31_1.items[iter_31_2])
			end
		end

		global_gain({
			items = var_31_0
		})
		global_get({
			items = var_31_1
		})
		global_ShowBlockWords(L_BUY_BATTLEPASS_VIP[arg_31_0])
		self:getBattlePassLevelData()
		activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE)
	end

	self.buyLock = true

	if not activity_vipbuy_data[arg_30_1].costitem_1 then
		self:rechargeForVip(arg_30_1)
	elseif not item_manager:isHaveEnoughItem(activity_vipbuy_data[arg_30_1].costitem_1, activity_vipbuy_data[arg_30_1].costnum_1) then
		LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
			targetlayer = "PopSupermarketLayer"
		})
	else
		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_BATTLEPASS_BUY.title,
				des = string.format(L_BATTLEPASS_BUY.des, activity_vipbuy_data[arg_30_1].name),
				button = L_BATTLEPASS_BUY.button
			},
			surecallback = function()
				network:rpc("activity_marray_buy_vip", {
					activityid = self._id,
					id = arg_30_1
				}, function(arg_33_0)
					var_30_0(arg_33_0.result, arg_33_0)
				end)
			end
		})
	end
end

function activityBattlePassObj:rechargeForVip(arg_34_1)
	local var_34_0 = activity_vipbuy_data[arg_34_1].rechargId

	network:rpc("check_recharge", {
		id = activity_vipbuy_data[arg_34_1].rechargId,
		client = config.clientmode
	}, function(arg_35_0)
		if arg_35_0.result == 1 then
			self.recharging = false

			AnalyticManager.clickPurchaseItem({
				product = arg_34_1,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			recharge_manager:confirmPayment(var_34_0)
		elseif arg_35_0.result == 2 then
			print("测试模式")
		elseif arg_35_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_35_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_35_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_35_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function activityBattlePassObj:isVIPBtnLock()
	return false
end

function activityBattlePassObj:getVipPriceById(arg_37_1)
	return activity_vipbuy_data[arg_37_1].costnum_1
end

function activityBattlePassObj:getLevelUpCost(arg_38_1)
	local var_38_0 = self:getCurBattlePassLevel() + arg_38_1 - 1

	if not activity_proceed_data[self._id .. "-" .. var_38_0] then
		return 0
	end

	local var_38_1 = item_manager:getItemNumber(activity_proceed_data[self._id .. "-" .. var_38_0].item1)
	local var_38_2 = activity_vipbuy_data["svip_" .. self._id].magnification or 1

	if self:isBattlePassSVIP() then
		var_38_1 = math.ceil(var_38_1 * var_38_2)
	end

	local var_38_3 = activity_proceed_data[self._id .. "-" .. var_38_0].num1 - var_38_1

	if self:isBattlePassSVIP() then
		var_38_3 = math.ceil(var_38_3 / var_38_2)
	end

	return math.abs(var_38_3 * activity_vipbuy_data["allvip_" .. self._id].proportion)
end

function activityBattlePassObj:buyActivityLevel(arg_39_1)
	local function var_39_0(arg_40_0, arg_40_1)
		if arg_40_0 ~= 1 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[arg_40_0])

			return
		end

		if arg_40_1.cost_items then
			for iter_40_0, iter_40_1 in pairs(arg_40_1.cost_items) do
				item_manager:deleteItem(iter_40_1.entityid, iter_40_1.num)
			end
		end

		playermodel.diamond = playermodel.diamond - arg_40_1.cost_diamond

		global_update_gold_stone_diamond(nil, nil, arg_40_1.cost_diamond)
		global_gain(arg_40_1)
		self:getBattlePassLevelData()
	end

	network:rpc("activity_marray_buy_proceed", {
		id = self._id,
		level = arg_39_1
	}, function(arg_41_0)
		var_39_0(arg_41_0.result, arg_41_0)
	end)
end

function activityBattlePassObj:getGiftPreviewList()
	local var_42_0 = {}
	local var_42_1 = 1

	while activity_proceed_data[self._id .. "-" .. var_42_1 * 5] do
		if activity_proceed_data[self._id .. "-" .. var_42_1 * 5].drop then
			for iter_42_0, iter_42_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. "-" .. var_42_1 * 5].drop))) do
				iter_42_1.level = var_42_1 * 5

				table.insert(var_42_0, iter_42_1)
			end
		end

		var_42_1 = var_42_1 + 1
	end

	local var_42_3 = {}

	for iter_42_2, iter_42_3 in pairs(var_42_0) do
		if not var_42_3[iter_42_3.dropid] then
			var_42_3[iter_42_3.dropid] = iter_42_3
		else
			var_42_3[iter_42_3.dropid].dropNum = var_42_3[iter_42_3.dropid].dropNum + iter_42_3.dropNum
		end
	end

	local var_42_4 = {}

	for iter_42_4, iter_42_5 in pairs(var_42_3) do
		table.insert(var_42_4, iter_42_5)
	end

	return var_42_4
end

function activityBattlePassObj:getSpGiftPreviewList()
	local var_43_0 = {}
	local var_43_1 = 1

	while activity_proceed_data[self._id .. "-" .. var_43_1 * 5] do
		if activity_proceed_data[self._id .. "-" .. var_43_1 * 5].specialDrop then
			for iter_43_0, iter_43_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. "-" .. var_43_1 * 5].specialDrop))) do
				iter_43_1.level = var_43_1 * 5

				if iter_43_1.dropid ~= "diamond" then
					table.insert(var_43_0, iter_43_1)
				end
			end
		end

		var_43_1 = var_43_1 + 1
	end

	local var_43_3 = self:getSpDiamondNum()

	if var_43_3 > 0 then
		table.insert(var_43_0, {
			dropid = "diamond",
			dropNum = var_43_3
		})
	end

	local var_43_4 = {}

	for iter_43_2, iter_43_3 in pairs(var_43_0) do
		if not var_43_4[iter_43_3.dropid] then
			var_43_4[iter_43_3.dropid] = iter_43_3
		else
			var_43_4[iter_43_3.dropid].dropNum = var_43_4[iter_43_3.dropid].dropNum + iter_43_3.dropNum
		end
	end

	local var_43_5 = {}

	for iter_43_4, iter_43_5 in pairs(var_43_4) do
		table.insert(var_43_5, iter_43_5)
	end

	return var_43_5
end

function activityBattlePassObj:getSpDiamondNum()
	local var_44_1 = 1
	local var_44_2 = 0

	while activity_proceed_data[self._id .. "-" .. 1] do
		if activity_proceed_data[self._id .. "-" .. 1].specialDrop then
			for iter_44_0, iter_44_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. "-" .. 1].specialDrop))) do
				if iter_44_1.dropid == "diamond" then
					var_44_2 = var_44_2 + iter_44_1.dropNum
				end
			end
		end

		var_44_1 = var_44_1 + 1
	end

	return var_44_2
end

function activityBattlePassObj:getBuySVIPDrop()
	local var_45_0 = activity_vipbuy_data["allvip_" .. self._id].dropid or activity_vipbuy_data["vip_" .. self._id].dropid
	local var_45_1 = {}

	if var_45_0 then
		for iter_45_0, iter_45_1 in pairs((self:getBattlePassDrop(var_45_0))) do
			if iter_45_1.dropid ~= activity_vipbuy_data["allvip_" .. self._id].checkitem then
				table.insert(var_45_1, iter_45_1)
			end
		end
	end

	return var_45_1
end

function activityBattlePassObj:getActivityEndTime()
	if not activity_conf_data[self._id].finishtime then
		return
	end

	return global_get_time_by_date(activity_conf_data[self._id].finishtime) - time_check_manager:getCurTime()
end

function activityBattlePassObj:getBattlePassLive2d()
	return activity_vipbuy_data["vip_" .. self._id].live2d
end

function activityBattlePassObj:getBuyVipJumpTo()
	if activity_vipbuy_data["svip_" .. self._id].dropid then
		return "PopGetBianhuaBpVIPLayer"
	else
		return "PopGetBattlepassVIPLayer"
	end
end

function activityBattlePassObj:isBPRewardCanGet(arg_49_1)
	if type(arg_49_1) ~= "number" then
		return false
	end

	local var_49_0 = self.battlePassStat[arg_49_1].stat

	if self.battlePassStat[arg_49_1].stat == var_0_2 then
		if activity_proceed_data[self._id .. "-" .. arg_49_1].drop ~= nil then
			return true
		end

		if self:isBattlePassVIP() then
			return true
		end
	end

	if var_49_0 == var_0_3 and self:isBattlePassVIP() then
		return true
	end

	return false
end

function activityBattlePassObj:getBPLayerName()
	return "Activity_bp_" .. self._id
end

function activityBattlePassObj:isRechargeBP(arg_51_1)
	return activity_vipbuy_data[arg_51_1].rechargId ~= nil
end

function activityBattlePassObj:getBPVipBuyBtnPos()
	return cc.p(145, 32)
end

function activityBattlePassObj:getBPVipBuyIncoPos()
	return cc.p(190, 32)
end

return activityBattlePassObj
