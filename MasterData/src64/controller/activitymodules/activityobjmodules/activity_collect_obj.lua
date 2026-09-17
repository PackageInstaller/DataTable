local item_data = require("data.item_data")
local activity_collect_conf = require("data.activity_modules.activity_collect_conf")
local activity_collect_data = require("data.activity_collect_data")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_13 = 4
local var_0_14 = 5

function ACTIVITY_OBJ_NEW:initModulecollect(arg_1_1)
	self._collectstarttime = arg_1_1.starttime
	self._collectfinishtime = arg_1_1.finishtime

	self:initCollectData()
end

function ACTIVITY_OBJ_NEW:getActivityCollectStatus()
	network:rpc("get_activity_collect_status", {
		id = self._id
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			self._collectId = self._id .. "-" .. arg_3_0.phase
			self._collectList = {}

			for iter_3_0, iter_3_1 in pairs(arg_3_0.list) do
				if activity_collect_data[self._collectId .. "-" .. iter_3_1.index].collect_type == var_0_8 then
					table.insert(self._collectList, {
						index = iter_3_1.index,
						totalNum = iter_3_1.limit,
						lessNum = iter_3_1.limit - iter_3_1.finish,
						stat = self:getCollectStatByIndex(iter_3_1),
						drops = drop_manager:getAllDrops(activity_collect_data[self._collectId .. "-" .. iter_3_1.index].drop)
					})
				end
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_COLLECT_INFO_UPDATE)
		else
			global_ShowBlockWords(L_ACTIVITY_OUT_OF_TIME)
		end
	end)
end

function ACTIVITY_OBJ_NEW:collectActivityItems(arg_4_1, arg_4_2)
	if self._status ~= ACTIVITY_ACTIVING then
		if callback then
			callback(2)
		end

		return
	end

	network:rpc("activity_collect_items", {
		id = self._id,
		index = arg_4_1,
		costitems = arg_4_2
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			global_gain(arg_5_0)

			if arg_5_0.consumes then
				for iter_5_0, iter_5_1 in pairs(arg_5_0.consumes) do
					item_manager:deleteItem(iter_5_1.entityid, iter_5_1.num)
				end
			end
		end

		self:getActivityCollectStatus()
	end)
end

function ACTIVITY_OBJ_NEW:get_collection_status(arg_6_1)
	network:rpc("get_collection_status", {
		activityid = self._id
	}, function(arg_7_0)
		if arg_7_0.result == 1 and arg_6_1 then
			arg_6_1(arg_7_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_collection_reward(arg_8_1)
	network:rpc("get_collection_reward", {
		activityid = self._id
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			AnalyticManager.get_collection_reward({
				activityid = self._id
			})

			if arg_8_1 then
				arg_8_1(arg_9_0)
			end
		elseif arg_9_0.result == 2 then
			global_ShowBlockWords("已领取")
		end
	end)
end

function ACTIVITY_OBJ_NEW:collectRanDomActivityItems(arg_10_1)
	network:rpc("activity_collect_items", {
		id = self._id,
		index = self._randomIndex,
		costitems = arg_10_1
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			global_gain(arg_11_0)

			if arg_11_0.consumes then
				for iter_11_0, iter_11_1 in pairs(arg_11_0.consumes) do
					item_manager:deleteItem(iter_11_1.entityid, iter_11_1.num)
				end
			end

			self:getActivityCollectStatus()
		end
	end)
end

function ACTIVITY_OBJ_NEW:collectItemsOneKey()
	network:rpc("activity_collect_items_one_key", {
		activityid = self._id
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			global_gain(arg_13_0)

			if arg_13_0.consumes then
				for iter_13_0, iter_13_1 in pairs(arg_13_0.consumes) do
					item_manager:deleteItem(iter_13_1.itemid, iter_13_1.num)
				end
			end

			self:getActivityCollectStatus()
		elseif arg_13_0.result == 2 then
			global_ShowBlockWords("物品不足")
		end
	end)
end

function ACTIVITY_OBJ_NEW:getCollectLayerName()
	return activity_collect_conf[self._id .. "-1"].layerName
end

function ACTIVITY_OBJ_NEW:getCollectBoxDataList()
	return self._collectList
end

function ACTIVITY_OBJ_NEW:initCollectData()
	self._collectId = self._collectId or self._id .. "-" .. self:getCurCollectphase()

	for iter_16_0 = 1, 1000 do
		if not activity_collect_data[self._collectId .. "-" .. iter_16_0] then
			break
		end

		if activity_collect_data[self._collectId .. "-" .. iter_16_0].collect_type == var_0_9 then
			self._randomItemType = activity_collect_data[self._collectId .. "-" .. iter_16_0].needitemtype
			self._randomNeedCount = activity_collect_data[self._collectId .. "-" .. iter_16_0].needcount
			self._randomStartTime = activity_collect_data[self._collectId .. "-" .. iter_16_0].starttime
			self._randomIndex = iter_16_0
		end
	end
end

function ACTIVITY_OBJ_NEW:getRandomCollectNeedCount()
	return self._randomNeedCount
end

function ACTIVITY_OBJ_NEW:getAllWordCollectItem()
	if not self._randomItemType then
		return {}
	end

	local var_18_0 = item_manager:filterItem(self._randomItemType)
	local var_18_1 = {}

	for iter_18_0 = 1, (math.floor(#var_18_0 / var_0_14) + 1) * var_0_14 do
		if var_18_0[iter_18_0] and item_data[var_18_0[iter_18_0]].activity_id == self._id then
			table.insert(var_18_1, {
				id = var_18_0[iter_18_0],
				hasNum = item_manager:getItemNumber(var_18_0[iter_18_0])
			})
		else
			table.insert(var_18_1, {
				id = -1,
				hasNum = item_manager:getItemNumber(var_18_0[iter_18_0])
			})
		end
	end

	table.sort(var_18_1, function(arg_19_0, arg_19_1)
		return arg_19_0.id > arg_19_1.id
	end)

	return var_18_1
end

function ACTIVITY_OBJ_NEW:getCollectStatByIndex(arg_20_1)
	if arg_20_1.limit > 0 and arg_20_1.limit - arg_20_1.finish <= 0 then
		return var_0_13
	end

	local var_20_0 = activity_collect_data[self._collectId .. "-" .. arg_20_1.index]
	local var_20_1 = 0

	for iter_20_0 = 1, 1000 do
		if not var_20_0["item" .. iter_20_0] then
			break
		end

		local var_20_2 = item_manager:getItemNumber(var_20_0["item" .. iter_20_0])

		var_20_1 = var_20_2 < var_20_0["num" .. iter_20_0] and var_20_1 + var_20_0["num" .. iter_20_0] - var_20_2 or var_20_1
	end

	if var_20_1 > 0 then
		local var_20_3 = self:getUniversalItemId()

		if not var_20_3 then
			return var_0_12
		elseif item_manager:isHaveEnoughItem(var_20_3, var_20_1) then
			return var_0_11
		else
			return var_0_12
		end
	end

	return var_0_10
end

function ACTIVITY_OBJ_NEW:getWordCollectDataByIndex(arg_21_1)
	local var_21_0 = {}

	while activity_collect_data[self._collectId .. "-" .. arg_21_1]["item" .. 1] do
		table.insert(var_21_0, {
			id = activity_collect_data[self._collectId .. "-" .. arg_21_1]["item" .. 1],
			hasNum = item_manager:getItemNumber(activity_collect_data[self._collectId .. "-" .. arg_21_1]["item" .. 1]),
			needNum = activity_collect_data[self._collectId .. "-" .. arg_21_1]["num" .. 1]
		})
	end

	return var_21_0
end

function ACTIVITY_OBJ_NEW:getCurCollectphase()
	local var_22_0 = 1
	local var_22_1 = time_check_manager:getCurTime()

	while activity_collect_conf[self._id .. "-" .. 1] do
		if var_22_1 < os.time(parse_time(activity_collect_conf[self._id .. "-" .. 1].finishtime)) then
			return var_22_0
		end

		var_22_0 = var_22_0 + 1
	end
end

function ACTIVITY_OBJ_NEW:getUniversalItemId()
	self._collectId = self._collectId or self._id .. "-" .. self:getCurCollectphase()

	return activity_collect_conf[self._collectId].universal_itemid
end

function ACTIVITY_OBJ_NEW:getCollectRandomStartTime()
	local var_24_0

	if not self._randomStartTime then
		do return true end

		var_24_0 = parse_time(self._randomStartTime)
	end

	if time_check_manager:getCurTime() >= os.time(var_24_0) then
		return true
	end

	return false, string.format(L_COLLECT_REDOM_UN_ONEN, var_24_0.year, var_24_0.month, var_24_0.day, var_24_0.hour)
end
