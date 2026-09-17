local CostumeRoomCumulativeRewardManager = class("CostumeRoomCumulativeRewardManager", (require("controller.base_manager")))

CostumeRoomCumulativeRewardManager.MULTITON_MSG = "CostumeRoomCumulativeRewardManager instancealready constructed!"
CostumeRoomCumulativeRewardManager.RewardState = {
	NoGet = 0,
	Get = 1
}

function CostumeRoomCumulativeRewardManager:ctor()
	self.super.ctor(self)

	self._data = {
		reward = 0,
		clothesNum = 0,
		rewardState = {}
	}
	self.itemData = require("data.item_data")
	self.skinItemIdT = {}

	for iter_1_0, iter_1_1 in pairs(self.itemData) do
		if iter_1_1.bag_item_type == kITEM_SKIN and iter_1_1.group then
			table.insert(self.skinItemIdT, {
				itemId = iter_1_1.id
			})
		end
	end

	self.clothesCollectConfig = {}

	for iter_1_2, iter_1_3 in pairs((require("data.clothes_collect_data"))) do
		table.insert(self.clothesCollectConfig, iter_1_3)
	end

	table.sort(self.clothesCollectConfig, function(arg_2_0, arg_2_1)
		return arg_2_0.clothes_num < arg_2_1.clothes_num
	end)
end

function CostumeRoomCumulativeRewardManager:getHaveSkinNum()
	return self._data.clothesNum
end

function CostumeRoomCumulativeRewardManager:getDisplayInfo()
	local drop_data = require("data.drop_data")
	local var_4_1 = {}

	for iter_4_0 = 1, #self.clothesCollectConfig do
		if drop_data[self.clothesCollectConfig[iter_4_0].drop_id] then
			local var_4_2 = {
				rewards = {},
				needCumulativeNumber = self.clothesCollectConfig[iter_4_0].clothes_num
			}

			if drop_data[self.clothesCollectConfig[iter_4_0].drop_id].diamond then
				local var_4_3 = {}

				var_4_3.itemId = 0
				var_4_3.count = drop_data[self.clothesCollectConfig[iter_4_0].drop_id].diamond

				table.insert(var_4_2.rewards, var_4_3)
			end

			if drop_data[self.clothesCollectConfig[iter_4_0].drop_id].gold then
				local var_4_4 = {}

				var_4_4.itemId = 1
				var_4_4.count = drop_data[self.clothesCollectConfig[iter_4_0].drop_id].gold

				table.insert(var_4_2.rewards, var_4_4)
			end

			local var_4_5 = "drop_id"

			for iter_4_1 = 1, 4 do
				local var_4_6 = {
					itemId = drop_data[self.clothesCollectConfig[iter_4_0].drop_id][var_4_5 .. iter_4_1],
					count = drop_data[self.clothesCollectConfig[iter_4_0].drop_id]["drop_num" .. iter_4_1]
				}

				if var_4_6.itemId and var_4_6.count then
					table.insert(var_4_2.rewards, var_4_6)
				end
			end

			table.insert(var_4_1, var_4_2)
		end
	end

	return var_4_1
end

function CostumeRoomCumulativeRewardManager:requestInfo(arg_5_1)
	require("network.network"):rpc("get_clothes_reward_info", nil, function(arg_6_0)
		self:handlerInfo(arg_6_0)
		self:checlMainRed()
		self:checkOtherRed()

		if arg_5_1 then
			arg_5_1(arg_6_0)
		end
	end)
end

function CostumeRoomCumulativeRewardManager:requestGetReward(arg_7_1, arg_7_2)
	require("network.network"):rpc("do_clothes_reward", {
		id = tonumber(arg_7_1)
	}, function(arg_8_0)
		self._data.rewardState[tonumber(arg_7_1)] = self.RewardState.Get

		global_gain(arg_8_0)
		self:checlMainRed()
		self:checkOtherRed()
		self:getRewardSuccess(arg_8_0, arg_7_1)

		if arg_7_2 then
			arg_7_2(arg_8_0)
		end
	end)
end

function CostumeRoomCumulativeRewardManager:handlerInfo(arg_9_1)
	self._data.clothesNum = arg_9_1.clothesNum
	self._data.reward = arg_9_1.reward
	self._data.rewardState = {}

	local var_9_0 = (function(arg_10_0)
		local var_10_0 = {}

		for iter_10_0 = 31, 0, -1 do
			var_10_0[#var_10_0 + 1] = math.floor(arg_10_0 / 2^iter_10_0)
			arg_10_0 = arg_10_0 % 2^iter_10_0
		end

		return table.concat(var_10_0)
	end)(self._data.reward)

	for iter_9_0 = string.len(var_9_0), 1, -1 do
		table.insert(self._data.rewardState, tonumber(string.sub(var_9_0, iter_9_0, iter_9_0)))
	end
end

function CostumeRoomCumulativeRewardManager:getRewardStateByIndex(arg_11_1)
	if self._data.rewardState[arg_11_1] then
		return self._data.rewardState[arg_11_1]
	end

	return self.RewardState.NoGet
end

function CostumeRoomCumulativeRewardManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function CostumeRoomCumulativeRewardManager:getRewardSuccess(arg_13_1, arg_13_2)
	if self.layer then
		self.layer:getRewardSuccess(arg_13_2)
	end
end

function CostumeRoomCumulativeRewardManager:checkRed()
	local var_14_0 = false
	local var_14_1 = self:getDisplayInfo()
	local var_14_2 = self:getHaveSkinNum()

	for iter_14_0 = 1, #var_14_1 do
		if var_14_2 >= var_14_1[iter_14_0].needCumulativeNumber and self._data.rewardState[iter_14_0] == self.RewardState.NoGet then
			var_14_0 = true

			break
		end
	end

	return var_14_0
end

function CostumeRoomCumulativeRewardManager:checlMainRed()
	if not self:checkRed() then
		require("controller.alert_manager"):unregister_alert(ALERT_CLOTHES_REWRAD, true)
	end
end

function CostumeRoomCumulativeRewardManager:checkOtherRed()
	require("controller.costume_room_manager"):getInstance():updateRed()
	require("controller.dormitory_manager"):updateRed()
end

return CostumeRoomCumulativeRewardManager
