local network = require("network.network")
local activity_bp_conf = require("data.activity_modules.activity_bp_conf")
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local activity_vipbuy_data = require("data.activity_vipbuy_data")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_manager = require("controller.activity_manager")
local recharge_manager = require("controller.recharge_manager")
local time_check_manager = require("controller.time_check_manager")
local discount_manager = require("controller.discount_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local var_0_17 = require("network.network")
local playermodel = require("model.playermodel")

function ACTIVITY_OBJ_NEW:initModulebp(arg_1_1)
	self._bpstarttime = arg_1_1.starttime
	self._bpfinishtime = arg_1_1.finishtime
	self.needKey = "bp-"

	if self._id == ACTIVITY_WARORDER_ID then
		self.needKey = "warorder-"
	end

	self.battlePassStat = {}
	self.taskList = {}
	self.extraTaskList = {}

	self:initBattlePassMaxLevel()
end

function ACTIVITY_OBJ_NEW:getBattlePassLevelData(arg_2_1)
	self:getActivityBPProceed(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 ~= 1 then
			return
		end

		if self._id ~= ACTIVITY_WARORDER_ID and self.needKey ~= string.match(arg_3_2, "[%a]+") .. "-" then
			self.needKey = string.match(arg_3_2, "[%a]+") .. "-" or self.needKey

			self:initBattlePassMaxLevel()
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			var_3_0[iter_3_1.id] = {}
			var_3_0[iter_3_1.id].stat = iter_3_1.status
			var_3_0[iter_3_1.id].level = iter_3_1.id
			var_3_0[iter_3_1.id].drop = activity_proceed_data[self._id .. self.needKey .. iter_3_1.id].drop
			var_3_0[iter_3_1.id].specialDrop = activity_proceed_data[self._id .. self.needKey .. iter_3_1.id].specialDrop
		end

		self.battlePassStat = var_3_0

		table.insert(var_3_0, {
			level = "?",
			stat = UN_KONW
		})

		if arg_2_1 ~= false then
			activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, {
				list = var_3_0,
				listLen = #var_3_0
			})
		end

		activity_manager:updateActivityAlert("bp_proceed", self._id, (self._id == ACTIVITY_WARORDER_ID or nil) and (self:isHasWarOrderRewardCanGet() or self:isHasRewardCanGet()))
	end)
end

function ACTIVITY_OBJ_NEW:getCurBattlePassLevel()
	if not self.battlePassStat then
		return
	end

	for iter_4_0 = 1, #self.battlePassStat do
		if self.battlePassStat[iter_4_0].stat == var_0_2 then
			return self.battlePassStat[iter_4_0].level
		end
	end

	return #self.battlePassStat
end

function ACTIVITY_OBJ_NEW:getBattlePassExp(arg_5_1)
	local var_5_0 = self._id .. self.needKey .. (arg_5_1 or self:getCurBattlePassLevel())

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

function ACTIVITY_OBJ_NEW:isBattlePassVIP()
	return item_manager:haveItem(activity_vipbuy_data["vip_" .. self._id].checkitem) or item_manager:haveItem(activity_vipbuy_data["allvip_" .. self._id].checkitem)
end

function ACTIVITY_OBJ_NEW:isBattlePassSVIP()
	return item_manager:haveItem(activity_vipbuy_data["allvip_" .. self._id].checkitem)
end

function ACTIVITY_OBJ_NEW:getCurLevelProceed(arg_8_1)
	local var_8_0 = arg_8_1 or self:getCurBattlePassLevel()
	local var_8_1 = self._id .. self.needKey .. var_8_0

	if not activity_proceed_data[self._id .. self.needKey .. var_8_0] then
		var_8_0 = var_8_0 - 1
		var_8_1 = self._id .. self.needKey .. var_8_0
	end

	local var_8_2 = activity_proceed_data[var_8_1].num1
	local var_8_3 = activity_proceed_data[self._id .. self.needKey .. var_8_0 - 1] or {
		num1 = 0
	}
	local var_8_4 = item_manager:getItemNumber(activity_proceed_data[var_8_1].item1)

	if self:isBattlePassSVIP() then
		var_8_4 = math.ceil(var_8_4 * (activity_vipbuy_data["svip_" .. self._id].magnification or 1))
	end

	return (var_8_4 - var_8_3.num1) / (var_8_2 - var_8_3.num1) * 100, var_8_4 - var_8_3.num1 .. "/" .. var_8_2 - var_8_3.num1
end

function ACTIVITY_OBJ_NEW.getBattlePassDrop(arg_9_0, arg_9_1)
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

function ACTIVITY_OBJ_NEW:getBattlePassReward(arg_10_1)
	self:getActivityBPProceedAward(arg_10_1, function(arg_11_0, arg_11_1)
		if arg_11_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_11_1)
		self:getBattlePassLevelData()
	end)
end

function ACTIVITY_OBJ_NEW:getActivityTask(arg_12_1)
	local var_12_0 = self.needKey and string.match(self.needKey, "[%a]+") or "bp"

	self:getActivityTaskList(nil, function(arg_13_0, arg_13_1)
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

			if iter_13_1.status == 1 then
				iter_13_1.percent = -1
			end

			table.insert(self.taskList, iter_13_1)
		end

		table.sort(self.taskList, function(arg_14_0, arg_14_1)
			if arg_14_0.percent == arg_14_1.percent then
				return arg_14_0.order < arg_14_1.order
			else
				return arg_14_0.percent > arg_14_1.percent
			end
		end)

		if arg_12_1 ~= false then
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
				list = self.taskList,
				listLen = #self.taskList
			})
		end

		activity_manager:updateActivityAlert(var_12_0, self._id, self:isHasCanCompleteTask())
	end, false, nil, var_12_0)
end

function ACTIVITY_OBJ_NEW:getExtraTaskList(arg_15_1)
	self:getActivityTaskList(nil, function(arg_16_0, arg_16_1)
		if arg_16_0 ~= 1 then
			return
		end

		self.extraTaskList[arg_15_1] = {}

		for iter_16_0, iter_16_1 in pairs(arg_16_1.list) do
			iter_16_1.name = task_data[iter_16_1.taskid].name
			iter_16_1.task_des = task_data[iter_16_1.taskid].task_des
			iter_16_1.image = task_data[iter_16_1.taskid].image
			iter_16_1.drop = task_data[iter_16_1.taskid].drop
			iter_16_1.jump = task_data[iter_16_1.taskid].jump
			iter_16_1.order = task_data[iter_16_1.taskid].order

			if iter_16_1.status == 1 then
				iter_16_1.percent = -1
			end

			table.insert(self.extraTaskList[arg_15_1], iter_16_1)
		end

		table.sort(self.extraTaskList[arg_15_1], function(arg_17_0, arg_17_1)
			if arg_17_0.percent == arg_17_1.percent then
				return arg_17_0.order < arg_17_1.order
			else
				return arg_17_0.percent > arg_17_1.percent
			end
		end)
		activity_manager:fireEvent(activity_manager.activityEventId.RETURNBACK_EXTRA_TASK_LIST, {
			list = self.extraTaskList[arg_15_1]
		})
		activity_manager:updateActivityAlert(arg_15_1, self._id, self:isExtraTaskComplete(arg_15_1))
	end, false, nil, arg_15_1)
end

function ACTIVITY_OBJ_NEW:isExtraTaskComplete(arg_18_1)
	local var_18_0 = self.extraTaskList[arg_18_1]

	if not self.extraTaskList[arg_18_1] or #var_18_0 == 0 then
		return false
	end

	return var_18_0[1].status == 0 and var_18_0[1].percent == 100
end

function ACTIVITY_OBJ_NEW:getActivityTaskData()
	return self.taskList
end

function ACTIVITY_OBJ_NEW:isHasRewardCanGet()
	for iter_20_0, iter_20_1 in ipairs(self.battlePassStat) do
		if iter_20_1.stat == var_0_3 then
			return true
		end

		if iter_20_1.stat == var_0_4 and self:isBattlePassVIP() then
			return true
		end
	end

	return false
end

function ACTIVITY_OBJ_NEW:isBattlePassLevelFinished()
	if self.battlePassStat and next(self.battlePassStat) then
		for iter_21_0, iter_21_1 in pairs(self.battlePassStat) do
			if self.battlePassStat[iter_21_0].stat ~= var_0_5 then
				return false
			end
		end

		return true
	end

	return false
end

function ACTIVITY_OBJ_NEW:isHasCanCompleteTask()
	if self:isBattlePassLevelFinished() then
		return false
	end

	if not self.taskList or #self.taskList == 0 then
		return false
	end

	return self.taskList[1].status == 0 and self.taskList[1].percent == 100
end

function ACTIVITY_OBJ_NEW:getBPTaskReward(arg_23_1)
	self:getTaskReward(arg_23_1, function(arg_24_0, arg_24_1)
		if arg_24_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_24_1)
		self:getActivityTask()
		self:getBattlePassLevelData()
	end)
end

function ACTIVITY_OBJ_NEW:getTaskRewardOneKey()
	local var_25_0 = self.needKey and string.match(self.needKey, "[%a]+") or "bp"

	self:getActivityTaskList(nil, function(arg_26_0, arg_26_1)
		if arg_26_0 ~= 1 then
			return
		end

		global_gain(arg_26_1)

		self.taskList = {}

		for iter_26_0, iter_26_1 in pairs(arg_26_1.list) do
			iter_26_1.name = task_data[iter_26_1.taskid].name
			iter_26_1.task_des = task_data[iter_26_1.taskid].task_des
			iter_26_1.image = task_data[iter_26_1.taskid].image
			iter_26_1.drop = task_data[iter_26_1.taskid].drop
			iter_26_1.jump = task_data[iter_26_1.taskid].jump
			iter_26_1.order = task_data[iter_26_1.taskid].order

			if iter_26_1.status >= 1 then
				iter_26_1.percent = -1
			end

			table.insert(self.taskList, iter_26_1)
		end

		table.sort(self.taskList, function(arg_27_0, arg_27_1)
			if arg_27_0.percent == arg_27_1.percent then
				return arg_27_0.order < arg_27_1.order
			else
				return arg_27_0.percent > arg_27_1.percent
			end
		end)
		self:getBattlePassLevelData()
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.taskList,
			listLen = #self.taskList
		})
		activity_manager:updateActivityAlert(var_25_0, self._id, self:isHasCanCompleteTask())
	end, true, nil, var_25_0)
end

function ACTIVITY_OBJ_NEW:getAllVIPLevelGift(arg_28_1)
	arg_28_1 = arg_28_1 or 1

	local var_28_0 = self._id .. self.needKey .. arg_28_1
	local var_28_1 = 0
	local var_28_2 = {}

	while activity_proceed_data[var_28_0] do
		if activity_proceed_data[var_28_0].specialDrop then
			for iter_28_0, iter_28_1 in pairs((self:getBattlePassDrop(activity_proceed_data[var_28_0].specialDrop))) do
				iter_28_1.level = arg_28_1

				if iter_28_1.dropid ~= "diamond" then
					table.insert(var_28_2, iter_28_1)
				else
					var_28_1 = var_28_1 + iter_28_1.dropNum
				end
			end
		end

		arg_28_1 = arg_28_1 + 1
		var_28_0 = self._id .. self.needKey .. arg_28_1
	end

	if var_28_1 > 0 then
		table.insert(var_28_2, {
			dropid = "diamond",
			dropNum = var_28_1
		})
	end

	table.sort(var_28_2, function(arg_29_0, arg_29_1)
		if arg_29_0.dropid == "diamond" then
			return true
		end

		if arg_29_1.dropid == "diamond" then
			return false
		end

		return item_data[arg_29_0.dropid].bag_item_type > item_data[arg_29_1.dropid].bag_item_type
	end)

	return var_28_2
end

function ACTIVITY_OBJ_NEW:initBattlePassMaxLevel()
	self._maxLevel = 1

	while activity_proceed_data[self._id .. self.needKey .. self._maxLevel] do
		self._maxLevel = self._maxLevel + 1
	end
end

function ACTIVITY_OBJ_NEW:getBattlePassMaxLevel()
	return self._maxLevel
end

function ACTIVITY_OBJ_NEW:canLevelUp(arg_32_1)
	return arg_32_1 + self:getCurBattlePassLevel() <= self._maxLevel
end

function ACTIVITY_OBJ_NEW:getLevelupCanGetDrop(arg_33_1)
	local var_33_0 = self:getCurBattlePassLevel()

	if var_33_0 + arg_33_1 > self._maxLevel then
		return {}
	end

	local var_33_1 = 1
	local var_33_2 = {}

	while var_33_1 <= arg_33_1 do
		if activity_proceed_data[self._id .. self.needKey .. var_33_0 + 1 - 1].specialDrop then
			for iter_33_0, iter_33_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. self.needKey .. var_33_0 + 1 - 1].specialDrop))) do
				iter_33_1.level = var_33_0 + var_33_1 - 1
				var_33_2[var_33_1] = var_33_2[var_33_1] or {}

				table.insert(var_33_2[var_33_1], iter_33_1)
			end
		end

		if activity_proceed_data[self._id .. self.needKey .. var_33_0 + 1 - 1].drop then
			for iter_33_2, iter_33_3 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. self.needKey .. var_33_0 + 1 - 1].drop))) do
				iter_33_3.level = var_33_0 + var_33_1 - 1
				var_33_2[var_33_1] = var_33_2[var_33_1] or {}

				table.insert(var_33_2[var_33_1], iter_33_3)
			end
		end

		var_33_1 = var_33_1 + 1
	end

	return var_33_2
end

function ACTIVITY_OBJ_NEW:buyVipById(arg_34_1)
	local function var_34_0(arg_35_0, arg_35_1)
		if arg_35_0 ~= 1 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_VIP[arg_35_0])

			return
		end

		for iter_35_0, iter_35_1 in pairs(arg_35_1.costitems) do
			item_manager:deleteItem(iter_35_1.itemid, iter_35_1.costnum)
		end

		arg_35_1.items = arg_35_1.getitems

		local var_35_0 = {}
		local var_35_1 = {}

		for iter_35_2 = 1, #arg_35_1.items do
			if arg_35_1.items[iter_35_2].itemid == activity_vipbuy_data["vip_" .. self._id].checkitem or arg_35_1.items[iter_35_2].itemid == activity_vipbuy_data["svip_" .. self._id].checkitem then
				table.insert(var_35_1, arg_35_1.items[iter_35_2])
			else
				table.insert(var_35_0, arg_35_1.items[iter_35_2])
			end
		end

		global_gain({
			items = var_35_0
		})
		global_get({
			items = var_35_1
		})
		global_ShowBlockWords(L_BUY_BATTLEPASS_VIP[arg_35_0])
		self:getBattlePassLevelData()
		activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE)
	end

	self.buyLock = true

	if not activity_vipbuy_data[arg_34_1].costitem_1 then
		self:rechargeForVip(arg_34_1)

		return
	end

	local var_34_1
	local var_34_2 = activity_vipbuy_data[arg_34_1].costnum_1

	for iter_34_0, iter_34_1 in pairs((discount_manager:getCouponsByShopId(activity_vipbuy_data[arg_34_1].checkitem, activity_vipbuy_data[arg_34_1].costitem_1, activity_vipbuy_data[arg_34_1].costnum_1))) do
		if iter_34_1.discount1 == -1 then
			var_34_2 = 0
			var_34_1 = iter_34_1.id

			break
		elseif var_34_2 > activity_vipbuy_data[arg_34_1].costnum_1 - iter_34_1.discount1 then
			var_34_2 = math.max(0, activity_vipbuy_data[arg_34_1].costnum_1 - iter_34_1.discount1)
			var_34_1 = iter_34_1.id
		end
	end

	if not item_manager:isHaveEnoughItem(activity_vipbuy_data[arg_34_1].costitem_1, var_34_2) then
		LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
			targetlayer = "PopSupermarketLayer",
			jumpto = activity_vipbuy_data[arg_34_1].jumpto
		})
	else
		local var_34_3 = string.format(L_BATTLEPASS_BUY.des, var_34_2, item_data[activity_vipbuy_data[arg_34_1].costitem_1].name, activity_vipbuy_data[arg_34_1].name)

		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_BATTLEPASS_BUY.title,
				des = (var_34_2 ~= activity_vipbuy_data[arg_34_1].costnum_1 or nil) and string.format(L_BATTLEPASS_BUY.des_2, var_34_2, item_data[activity_vipbuy_data[arg_34_1].costitem_1].name, activity_vipbuy_data[arg_34_1].name),
				button = L_BATTLEPASS_BUY.button
			},
			surecallback = function()
				var_0_17:rpc("activity_bp_buy_vip", {
					activityid = self._id,
					id = arg_34_1,
					couponid = var_34_1
				}, function(arg_37_0)
					var_34_0(arg_37_0.result, arg_37_0)
				end)
			end
		})
	end
end

function ACTIVITY_OBJ_NEW.getbuyBpVipCouponid(arg_38_0, arg_38_1)
	local var_38_0
	local var_38_1 = activity_vipbuy_data[arg_38_1].costnum_1

	for iter_38_0, iter_38_1 in pairs((discount_manager:getCouponsByShopId(activity_vipbuy_data[arg_38_1].checkitem, activity_vipbuy_data[arg_38_1].costitem_1, activity_vipbuy_data[arg_38_1].costnum_1))) do
		if iter_38_1.discount1 == -1 then
			var_38_1 = 0
			var_38_0 = iter_38_1.id

			break
		elseif var_38_1 > activity_vipbuy_data[arg_38_1].costnum_1 - iter_38_1.discount1 then
			var_38_1 = math.max(0, activity_vipbuy_data[arg_38_1].costnum_1 - iter_38_1.discount1)
			var_38_0 = iter_38_1.id
		end
	end

	return var_38_0
end

function ACTIVITY_OBJ_NEW.rechargeForVip(arg_39_0, arg_39_1)
	local var_39_0 = activity_vipbuy_data[arg_39_1].rechargId

	var_0_17:rpc("check_recharge", {
		id = activity_vipbuy_data[arg_39_1].rechargId,
		client = config.clientmode
	}, function(arg_40_0)
		if arg_40_0.result == 1 then
			arg_39_0.recharging = false

			AnalyticManager.clickPurchaseItem({
				product = arg_39_1,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			recharge_manager:confirmPayment(var_39_0)
		elseif arg_40_0.result == 2 then
			print("测试模式")
		elseif arg_40_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_40_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_40_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_40_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function ACTIVITY_OBJ_NEW.isVIPBtnLock(arg_41_0)
	return false
end

function ACTIVITY_OBJ_NEW.getVipPriceById(arg_42_0, arg_42_1)
	return activity_vipbuy_data[arg_42_1].costnum_1
end

function ACTIVITY_OBJ_NEW:getLevelUpCost(arg_43_1)
	local var_43_0 = self:getCurBattlePassLevel() + arg_43_1 - 1

	if not activity_proceed_data[self._id .. self.needKey .. var_43_0] then
		return 0
	end

	local var_43_1 = item_manager:getItemNumber(activity_proceed_data[self._id .. self.needKey .. var_43_0].item1)
	local var_43_2 = activity_vipbuy_data["svip_" .. self._id].magnification or 1

	if self:isBattlePassSVIP() then
		var_43_1 = math.ceil(var_43_1 * var_43_2)
	end

	local var_43_3 = activity_proceed_data[self._id .. self.needKey .. var_43_0].num1 - var_43_1

	if self:isBattlePassSVIP() then
		var_43_3 = math.ceil(var_43_3 / var_43_2)
	end

	return math.abs(var_43_3 * activity_vipbuy_data["allvip_" .. self._id].proportion)
end

function ACTIVITY_OBJ_NEW:buyActivityLevel(arg_44_1, arg_44_2)
	local function var_44_0(arg_45_0, arg_45_1)
		if arg_45_0 ~= 1 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[arg_45_0])

			return
		end

		if arg_45_1.consumes then
			for iter_45_0, iter_45_1 in pairs(arg_45_1.consumes) do
				item_manager:deleteItem(iter_45_1.entityid, iter_45_1.num)
			end
		end

		playermodel.diamond = playermodel.diamond - arg_45_1.cost_diamond

		global_update_gold_stone_diamond(nil, nil, arg_45_1.cost_diamond)
		global_gain(arg_45_1)
		self:getBattlePassLevelData()
	end

	var_0_17:rpc("activity_bp_buy_proceed", {
		activityid = self._id,
		level = arg_44_1,
		uselegacy = arg_44_2
	}, function(arg_46_0)
		var_44_0(arg_46_0.result, arg_46_0)
	end)
end

local var_0_19 = 1

function ACTIVITY_OBJ_NEW:getGiftPreviewList()
	if activity_bp_conf[self._id].preview_drop_id then
		return self:getBattlePassDrop(activity_bp_conf[self._id].preview_drop_id)
	end

	local var_47_0 = {}
	local var_47_1 = 1

	while activity_proceed_data[self._id .. self.needKey .. var_47_1 * var_0_19] do
		if activity_proceed_data[self._id .. self.needKey .. var_47_1 * var_0_19].drop then
			for iter_47_0, iter_47_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. self.needKey .. var_47_1 * var_0_19].drop))) do
				iter_47_1.level = var_47_1 * var_0_19

				table.insert(var_47_0, iter_47_1)
			end
		end

		var_47_1 = var_47_1 + 1
	end

	local var_47_3 = {}

	for iter_47_2, iter_47_3 in pairs(var_47_0) do
		if not var_47_3[iter_47_3.dropid] then
			var_47_3[iter_47_3.dropid] = iter_47_3
		else
			var_47_3[iter_47_3.dropid].dropNum = var_47_3[iter_47_3.dropid].dropNum + iter_47_3.dropNum
		end
	end

	local var_47_4 = {}

	for iter_47_4, iter_47_5 in pairs(var_47_3) do
		table.insert(var_47_4, iter_47_5)
	end

	table.sort(var_47_4, function(arg_48_0, arg_48_1)
		return arg_48_0.level < arg_48_1.level
	end)

	return var_47_4
end

function ACTIVITY_OBJ_NEW:getSpGiftPreviewList()
	if activity_bp_conf[self._id].sp_preview_drop_id then
		return self:getBattlePassDrop(activity_bp_conf[self._id].sp_preview_drop_id)
	end

	local var_49_0 = {}
	local var_49_1 = 1

	while activity_proceed_data[self._id .. self.needKey .. var_49_1 * var_0_19] do
		if activity_proceed_data[self._id .. self.needKey .. var_49_1 * var_0_19].specialDrop then
			for iter_49_0, iter_49_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. self.needKey .. var_49_1 * var_0_19].specialDrop))) do
				iter_49_1.level = var_49_1 * var_0_19

				if iter_49_1.dropid ~= "diamond" then
					table.insert(var_49_0, iter_49_1)
				end
			end
		end

		var_49_1 = var_49_1 + 1
	end

	local var_49_3 = {}

	for iter_49_2, iter_49_3 in pairs(var_49_0) do
		if not var_49_3[iter_49_3.dropid] then
			var_49_3[iter_49_3.dropid] = iter_49_3
		else
			var_49_3[iter_49_3.dropid].dropNum = var_49_3[iter_49_3.dropid].dropNum + iter_49_3.dropNum
		end
	end

	local var_49_4 = self:getSpDiamondNum()

	if var_49_4 > 0 and #var_49_3 < 4 then
		table.insert(var_49_3, {
			dropid = "diamond",
			dropNum = var_49_4
		})
	end

	local var_49_5 = {}

	for iter_49_4, iter_49_5 in pairs(var_49_3) do
		table.insert(var_49_5, iter_49_5)
	end

	table.sort(var_49_5, function(arg_50_0, arg_50_1)
		return arg_50_0.level < arg_50_1.level
	end)

	return var_49_5
end

function ACTIVITY_OBJ_NEW:getSpDiamondNum()
	local var_51_1 = 1
	local var_51_2 = 0

	while activity_proceed_data[self._id .. self.needKey .. 1] do
		if activity_proceed_data[self._id .. self.needKey .. 1].specialDrop then
			for iter_51_0, iter_51_1 in pairs((self:getBattlePassDrop(activity_proceed_data[self._id .. self.needKey .. 1].specialDrop))) do
				if iter_51_1.dropid == "diamond" then
					var_51_2 = var_51_2 + iter_51_1.dropNum
				end
			end
		end

		var_51_1 = var_51_1 + 1
	end

	return var_51_2
end

function ACTIVITY_OBJ_NEW:getBuySVIPDrop()
	local var_52_0 = activity_vipbuy_data["allvip_" .. self._id].dropid or activity_vipbuy_data["vip_" .. self._id].dropid
	local var_52_1 = {}

	if var_52_0 then
		for iter_52_0, iter_52_1 in pairs((self:getBattlePassDrop(var_52_0))) do
			if iter_52_1.dropid ~= activity_vipbuy_data["allvip_" .. self._id].checkitem then
				table.insert(var_52_1, iter_52_1)
			end
		end
	end

	return var_52_1
end

function ACTIVITY_OBJ_NEW:getActivityEndTime()
	return global_get_time_by_date(activity_conf_data[self._id].finishtime) - time_check_manager:getCurTime()
end

function ACTIVITY_OBJ_NEW:getBattlePassLive2d()
	return activity_vipbuy_data["vip_" .. self._id].live2d
end

function ACTIVITY_OBJ_NEW:getBuyVipJumpTo()
	if activity_vipbuy_data["svip_" .. self._id].dropid then
		return "PopGetBianhuaBpVIPLayer"
	else
		return "PopGetBattlepassVIPLayer"
	end
end

function ACTIVITY_OBJ_NEW:isBPRewardCanGet(arg_56_1)
	if type(arg_56_1) ~= "number" then
		return false
	end

	local var_56_0 = self.battlePassStat[arg_56_1].stat

	if self.battlePassStat[arg_56_1].stat == var_0_3 then
		if activity_proceed_data[self._id .. self.needKey .. arg_56_1].drop ~= nil then
			return true
		end

		if self:isBattlePassVIP() then
			return true
		end
	end

	if var_56_0 == var_0_4 and self:isBattlePassVIP() then
		return true
	end

	return false
end

function ACTIVITY_OBJ_NEW:getActivityBPProceed(arg_57_1)
	if not self:isHaveModule("bp") then
		if arg_57_1 then
			arg_57_1(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_57_1 then
			arg_57_1(2)
		end

		return
	end

	var_0_17:rpc("get_activity_bp_proceed", {
		activityid = self._id
	}, function(arg_58_0)
		if arg_58_0.result == 1 then
			if arg_57_1 then
				arg_57_1(1, arg_58_0.list, arg_58_0.proceedid)
			end
		elseif arg_57_1 then
			arg_57_1(arg_58_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getActivityBPProceedAward(arg_59_1, arg_59_2)
	if not self:isHaveModule("bp") then
		if arg_59_2 then
			arg_59_2(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_59_2 then
			arg_59_2(2)
		end

		return
	end

	var_0_17:rpc("get_activity_bp_proceed_award", {
		activityid = self._id,
		index = arg_59_1
	}, function(arg_60_0)
		if arg_60_0.result == 1 then
			AnalyticManager.get_activity_proceed_award({
				activityid = self._id,
				index = arg_59_1
			})

			if arg_59_2 then
				arg_59_2(1, arg_60_0)
			end
		elseif arg_59_2 then
			arg_59_2(arg_60_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getBPReturnbackGuideList()
	self:getReturnbackGuideList(function(arg_62_0, arg_62_1)
		if arg_62_0 ~= 1 then
			return
		end

		self.guideids = arg_62_1

		activity_manager:fireEvent(activity_manager.activityEventId.RETURNBACK_GUIDE_LIST, {
			guideids = arg_62_1
		})
	end)
end

function ACTIVITY_OBJ_NEW:getReturnbackGuideList(arg_63_1)
	if not self:isHaveModule("bp") then
		if arg_63_1 then
			arg_63_1(0)
		end

		return
	end

	if self._status ~= ACTIVITY_ACTIVING then
		if arg_63_1 then
			arg_63_1(2)
		end

		return
	end

	var_0_17:rpc("returnback_guide_list", nil, function(arg_64_0)
		if arg_64_0.result == 1 then
			if arg_63_1 then
				arg_63_1(1, arg_64_0.guideids)
			end
		elseif arg_63_1 then
			arg_63_1(arg_64_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW.isRechargeBP(arg_65_0, arg_65_1)
	return activity_vipbuy_data[arg_65_1].rechargId ~= nil
end

function ACTIVITY_OBJ_NEW:getBPLayerName()
	return activity_bp_conf[self._id].layerName
end

function ACTIVITY_OBJ_NEW:getBPShowFurniture()
	return activity_bp_conf[self._id].show_furniture
end

function ACTIVITY_OBJ_NEW:getBPVipBuyBtnPos()
	return cc.p(activity_bp_conf[self._id].btn_pos_x or 172, activity_bp_conf[self._id].btn_pos_y or 26)
end

function ACTIVITY_OBJ_NEW:getBPVipBuyIncoPos()
	return cc.p(activity_bp_conf[self._id].icon_pos_x or 190, activity_bp_conf[self._id].icon_pos_y or 32)
end

function ACTIVITY_OBJ_NEW:getBPMaxLevel()
	return self._maxLevel
end

function ACTIVITY_OBJ_NEW:isGuideComplete()
	return not self.guideids or #self.guideids == 0
end

function ACTIVITY_OBJ_NEW:isBpComplete()
	local var_72_0 = self:getCurBattlePassLevel()
	local var_72_1 = self:getBattlePassMaxLevel()
	local var_72_2 = self._id == ACTIVITY_WARORDER_ID and self:isHasWarOrderRewardCanGet() or self:isHasRewardCanGet()
	local var_72_3 = self:isBattlePassSVIP()
	local var_72_4 = true

	for iter_72_0, iter_72_1 in ipairs(self.taskList) do
		if iter_72_1.status ~= 1 then
			var_72_4 = false

			break
		end
	end

	return var_72_0 == var_72_1 and var_72_3 and not var_72_2 and var_72_4
end

function ACTIVITY_OBJ_NEW:getBpLevelInheritItem()
	return activity_vipbuy_data["vip_" .. self._id].legacy_item
end

function ACTIVITY_OBJ_NEW:getActivityBPTaskUseModule()
	return self.needKey and string.match(self.needKey, "[%a]+") or "bp"
end
