local activity_airPlane_data = require("data.activity_airPlane_data")
local airPlane_shop_data = require("data.airPlane_shop_data")
local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")

function ACTIVITY_OBJ_NEW:enter_airplane_get_conf(arg_1_1)
	network:rpc("enter_airplane_get_conf", {
		activityid = self._id
	}, function(arg_2_0)
		print("enter_airplane_get_conf")
		print_lua_table(arg_2_0)

		if arg_2_0.result == 1 then
			self:setAPTaskTurns(arg_2_0.taskTurns)
			self:setAPShopTurns(arg_2_0.shopTurns)
			self:setAPShopData(arg_2_0.airplaneShop)
			self:setAPTurns(arg_2_0.APTurns)
			self:setAPTurnsShopData(arg_2_0.APTurns)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, arg_2_0)
		else
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:go_next_turns_tasks(arg_3_1)
	network:rpc("go_next_turns_tasks", {
		activityid = self._id
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			self:setAPTaskTurns(arg_4_0.taskTurns)
			item_manager:deleteItem(self:getAPKeyItem(), arg_4_0.keyItemCost)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, arg_4_0)
		elseif arg_4_0.result == 2 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[3])
		elseif arg_4_0.result == 3 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[4])
		elseif arg_4_0.result == 4 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[5])
		else
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:buy_airplane_shop(arg_5_1, arg_5_2, arg_5_3)
	network:rpc("buy_airplane_shop", {
		activityid = self._id,
		turns = arg_5_1,
		id = arg_5_2
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			global_gain(arg_6_0)
			item_manager:deleteItem(self:getAPKeyPoint(), arg_6_0.keyPointCost)
			self:setAPShopTurns(arg_6_0.shopTurns)
			self:setAPShopData(arg_6_0.airplaneShop)
			self:updateShopPanelData(arg_5_1)
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[6])
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[7])
		elseif arg_6_0.result == 4 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[3])
		elseif arg_6_0.result == 5 then
			global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[8])
		else
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end

function ACTIVITY_OBJ_NEW:updateShopPanelData(arg_7_1)
	if arg_7_1 > self:getAPShopTurns() then
		global_ShowBlockWords(L_COMMON_AIRPLANE_TEXT[6])
	end

	if not self:getAPShopData() then
		global_ShowBlockWords("illegal error!!!")
	end

	local var_7_0 = self:getAPShopData()[arg_7_1] and self:getAPShopData()[arg_7_1].shopturn_data or {}
	local var_7_1 = {}
	local var_7_2 = self:getAPTurnsShopData()

	for iter_7_0 = 1, 3 do
		local var_7_3 = {}

		if var_7_0[iter_7_0] and var_7_0[iter_7_0].count then
			var_7_3.buy_count = var_7_0[iter_7_0].count or 0
		end

		var_7_3.dropid = var_7_2[arg_7_1]["shop_item" .. iter_7_0]
		var_7_3.need = var_7_2[arg_7_1]["shop_cost" .. iter_7_0]
		var_7_3.limit = var_7_2[arg_7_1]["item_buy_limit" .. iter_7_0]
		var_7_1[iter_7_0] = var_7_3
	end

	var_7_1.index = arg_7_1
	var_7_1.shop_turns = self:getAPShopTurns()
	var_7_1.pointnum = item_manager:getItemNumber(self:getAPKeyPoint())
	self.curShopIndex = arg_7_1

	activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_AIRPLANE_DATA_UPDATE, var_7_1)

	return var_7_1
end

function ACTIVITY_OBJ_NEW:getAPKeyItem()
	return activity_airPlane_data[self.APTurns].key_item
end

function ACTIVITY_OBJ_NEW:getAPKeyPoint()
	return activity_airPlane_data[self.APTurns].key_point
end

function ACTIVITY_OBJ_NEW.setAPTaskTurns(arg_10_0, arg_10_1)
	arg_10_0.task_turns = arg_10_1
end

function ACTIVITY_OBJ_NEW:getAPTaskTurns()
	return self.task_turns
end

function ACTIVITY_OBJ_NEW.setAPShopTurns(arg_12_0, arg_12_1)
	arg_12_0.shop_turns = arg_12_1
end

function ACTIVITY_OBJ_NEW:getAPShopTurns()
	return self.shop_turns
end

function ACTIVITY_OBJ_NEW.setAPShopData(arg_14_0, arg_14_1)
	arg_14_0.airplane_shop = arg_14_1
end

function ACTIVITY_OBJ_NEW:getAPShopData()
	return self.airplane_shop
end

function ACTIVITY_OBJ_NEW.setAPTurns(arg_16_0, arg_16_1)
	arg_16_0.APTurns = arg_16_1
end

function ACTIVITY_OBJ_NEW:getAPTurns(arg_17_1)
	return self.APTurns
end

function ACTIVITY_OBJ_NEW.setAPTurnsShopData(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(airPlane_shop_data) do
		if iter_18_1.turns == arg_18_1 then
			var_18_0[iter_18_1.class] = iter_18_1
		end
	end

	arg_18_0.APTurnsShopData = var_18_0
end

function ACTIVITY_OBJ_NEW:getAPTurnsShopData(arg_19_1)
	return self.APTurnsShopData
end

function ACTIVITY_OBJ_NEW:getAPMaxTaskTurns()
	return activity_airPlane_data[self.APTurns].max_task_turns
end

function ACTIVITY_OBJ_NEW:getGiftBuyJump()
	return activity_airPlane_data[self.APTurns].gift_jump
end
