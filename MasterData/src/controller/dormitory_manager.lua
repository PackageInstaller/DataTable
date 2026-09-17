local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local cook_manager = require("controller.cook_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local time_check_manager = require("controller.time_check_manager")
local travel_event_data = require("data.travel_event_data")
local dorm_rooms_data = require("data.dorm_rooms_data")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local furnituresuit_data = require("data.furnituresuit_data")
local favor_daily_class_data = require("data.favor_daily_class_data")
local favor_data = require("data.favor_data")
local servant_data = require("data.servant_data")
local var_0_18 = {
	NEXTLOCK = 10,
	BUILDING = 11,
	BUILDED = 12,
	PLOT = 4,
	EXPLORING = 5,
	LOCK = 1,
	ATHOME = 3,
	TRAVELBACK = 6,
	UNLOCK = 2
}
local var_0_19 = -1
local var_0_20 = 0
local var_0_25 = 1
local var_0_26 = 2

FAVOR_POOL_LIMIT = 175

local function var_0_29(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 1, 5 do
		var_1_0[iter_1_0] = dorm_rooms_data[arg_1_0]["furniture" .. iter_1_0]
	end

	return var_1_0
end

function var_0_0:init(arg_2_1)
	self.travelList = nil
	self.soul_to_index = {}
	self.roomInfos = {}
	self.soulConversations = {}

	self:getShopSkinData()
	self:getTravelList(function()
		if not self.soul_to_index then
			return
		end

		self:initDormRooms()

		if arg_2_1 then
			arg_2_1({
				infos = self.roomInfos,
				indexs = self.soul_to_index
			})
		end
	end)
end

function var_0_0:initDormRooms()
	local var_4_0 = PlotManager:get_running_favor_plot_souls()

	for iter_4_0, iter_4_1 in pairs(playermodel.dormRoomConfig) do
		if iter_4_1.soulid > 0 then
			self.roomInfos[iter_4_0] = {
				soulid = iter_4_1.soulid
			}
			self.soul_to_index[iter_4_1.soulid] = iter_4_0

			if self.exploreingSouls[iter_4_1.soulid] then
				self.roomInfos[iter_4_0].state = var_0_18.EXPLORING
			elseif self.travelList[iter_4_1.soulid] then
				if self.travelList[iter_4_1.soulid].state == var_0_25 then
					self.roomInfos[iter_4_0].state = var_0_18.ATHOME
				elseif self.travelList[iter_4_1.soulid].state == var_0_26 then
					self.roomInfos[iter_4_0].state = var_0_18.TRAVELBACK
					self.roomInfos[iter_4_0].conversation = self:getConverstaionId(iter_4_1.soulid)
				else
					self.roomInfos[iter_4_0].state = var_0_18.ATHOME
				end
			else
				self.roomInfos[iter_4_0].state = var_0_18.ATHOME
			end
		elseif iter_4_1.soulid == 0 then
			self.roomInfos[iter_4_0] = {
				state = var_0_18.UNLOCK
			}
		elseif iter_4_1.soulid < 0 then
			if self:checkIsCanUnlockRoom(iter_4_0) then
				if self.unlock_running_rooms[iter_4_0] then
					if self.unlock_running_rooms[iter_4_0].status == var_0_19 then
						self.roomInfos[iter_4_0] = {
							state = var_0_18.BUILDING,
							last_time = self.unlock_running_rooms[iter_4_0].time
						}
					elseif self.unlock_running_rooms[iter_4_0].status == var_0_20 then
						self.roomInfos[iter_4_0] = {
							state = var_0_18.BUILDED
						}
					end
				else
					self.roomInfos[iter_4_0] = {
						state = var_0_18.NEXTLOCK
					}
				end
			elseif playermodel.dormRoomConfig[iter_4_0 - 1].soulid < 0 then
				self.roomInfos[iter_4_0] = {
					state = var_0_18.LOCK
				}
			end
		end
	end
end

function var_0_0.checkIsCanUnlockRoom(arg_5_0, arg_5_1)
	if arg_5_1 % 20 == 1 then
		return true
	end

	if playermodel.dormRoomConfig[arg_5_1 - 1].soulid >= 0 then
		return true
	end

	return false
end

function var_0_0.quick_unlock_room(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if type(arg_6_2) == "string" then
		arg_6_2 = CURRENCY_STR[arg_6_2]
	end

	network:rpc("quick_unlock_room", {
		roomid = arg_6_1,
		itemid = arg_6_2,
		num = arg_6_3
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			if arg_7_0.time == 0 then
				playermodel.dormRoomConfig[arg_6_1].soulid = 0
				playermodel.dormRoomConfig[arg_6_1].furnitures = var_0_29(arg_6_1)

				AnalyticManager.unlock_room({
					unlock_rooms = arg_6_0:get_unlock_rooms(),
					class = playermodel.class,
					level = playermodel.grade,
					souls = playermodel:getHavedSoulNum()
				})
			end

			arg_6_0.roomInfos[arg_6_1].last_time = arg_7_0.time

			if arg_7_0.items then
				for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
					item_manager:setItemByServerItem(iter_7_1)
				end
			end

			if arg_7_0.cost_num then
				item_manager:deleteItem(arg_6_2, arg_7_0.cost_num)
			end
		elseif arg_7_0.result == 0 then
			cclog("参数不正确")
		elseif arg_7_0.result == 2 then
			global_ShowBlockWords(L_DORMROOM_QUICK_UNLOCK_MSG[2])
		elseif arg_7_0.result == 3 then
			global_ShowBlockWords(L_DORMROOM_QUICK_UNLOCK_MSG[3])
		end

		if arg_6_4 then
			arg_6_4(arg_7_0)
		end
	end)
end

function var_0_0.open_room(arg_8_0, arg_8_1, arg_8_2)
	network:rpc("open_room", {
		roomid = arg_8_1
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			playermodel.dormRoomConfig[arg_8_1].soulid = 0
			playermodel.dormRoomConfig[arg_8_1].furnitures = var_0_29(arg_8_1)

			if arg_9_0.items then
				for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
					item_manager:setItemByServerItem(iter_9_1)
				end
			end

			AnalyticManager.unlock_room({
				unlock_rooms = arg_8_0:get_unlock_rooms(),
				class = playermodel.class,
				level = playermodel.grade,
				souls = playermodel:getHavedSoulNum()
			})
		elseif arg_9_0.result == 0 then
			cclog("房间解锁信息不存在")
		elseif arg_9_0.result == 2 then
			cclog("房间建设未完成")
		end

		if arg_8_2 then
			arg_8_2(arg_9_0)
		end
	end)
end

function var_0_0:updateDormRooms(arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(playermodel.dormRoomConfig) do
		if iter_10_1.soulid > 0 and self.travelList[iter_10_1.soulid] then
			if arg_10_1 == "travel_back" then
				if self.travelList[iter_10_1.soulid].state == var_0_26 and self.roomInfos[iter_10_0].state == var_0_18.TRAVELING then
					self.roomInfos[iter_10_0].state = var_0_18.TRAVELBACK
					self.roomInfos[iter_10_0].conversation = self:getConverstaionId(iter_10_1.soulid)

					if arg_10_2 then
						arg_10_2(iter_10_0)
					end
				end
			elseif arg_10_1 == "go_travel" and self.travelList[iter_10_1.soulid].state == var_0_25 and self.roomInfos[iter_10_0].state ~= var_0_18.TRAVELING then
				self.roomInfos[iter_10_0].state = var_0_18.TRAVELING

				if arg_10_2 then
					arg_10_2(iter_10_0)
				end
			end
		end
	end
end

function var_0_0.getShopSkinData(arg_11_0)
	arg_11_0.skinshops = {}

	require("controller.shop_manager"):get_shop_clothes_data(function(arg_12_0)
		arg_11_0.skinshops = arg_12_0
	end)
end

function var_0_0.getTravelList(arg_13_0, arg_13_1)
	network:rpc("get_travel_list", nil, function(arg_14_0)
		arg_13_0.travelList = {}
		arg_13_0.exploreingSouls = {}
		arg_13_0.unlock_running_rooms = {}
		arg_13_0.dormshops = {
			gift = {},
			furniture = {},
			skin = {},
			ring = {}
		}

		if arg_14_0.travel.list then
			for iter_14_0, iter_14_1 in pairs(arg_14_0.travel.list) do
				arg_13_0.travelList[iter_14_1.soulid] = {
					state = arg_14_0.travel.infos[iter_14_1.soulid].status,
					events = iter_14_1.events
				}
			end
		end

		if arg_14_0.exploreing_souls then
			for iter_14_2, iter_14_3 in pairs(arg_14_0.exploreing_souls) do
				arg_13_0.exploreingSouls[iter_14_3] = true
			end
		end

		if arg_14_0.shoplist then
			arg_13_0:initDormShop(arg_14_0.shoplist)
		end

		if arg_14_0.rooms then
			arg_13_0:updateRoomsData(arg_14_0.rooms)
		end

		if arg_14_0.room_lock_info then
			for iter_14_4, iter_14_5 in pairs(arg_14_0.room_lock_info) do
				if iter_14_5.status == var_0_20 or iter_14_5.status == var_0_19 then
					arg_13_0.unlock_running_rooms[iter_14_4] = iter_14_5
				end
			end
		end

		if arg_14_0.double_finish_time then
			arg_13_0.double_finish_time = os.time(parse_time(arg_14_0.double_finish_time))
		end

		if arg_14_0.activity_souls then
			arg_13_0.activity_souls = {}

			for iter_14_6, iter_14_7 in pairs(arg_14_0.activity_souls) do
				arg_13_0.activity_souls[iter_14_7] = true
			end

			if next(arg_13_0.activity_souls) ~= nil then
				arg_13_0.activity_souls = arg_13_0.activity_souls or nil
			end
		end

		if arg_14_0.gift_finish_time then
			arg_13_0.gift_finish_time = os.time(parse_time(arg_14_0.gift_finish_time))
		end

		if arg_13_1 then
			arg_13_1()
		end
	end)
end

function var_0_0.initDormShop(arg_15_0, arg_15_1)
	local var_15_0 = {
		[kITEM_GIFT_FOR_FRIEND] = function(arg_16_0)
			arg_15_0.dormshops.gift[arg_16_0.soulid] = arg_15_0.dormshops.gift[arg_16_0.soulid] or {}

			table.insert(arg_15_0.dormshops.gift[arg_16_0.soulid], arg_16_0)
		end,
		[kITEM_FURNITURE_GIFT] = function(arg_17_0)
			arg_15_0.dormshops.furniture[arg_17_0.soulid] = arg_15_0.dormshops.furniture[arg_17_0.soulid] or {}

			table.insert(arg_15_0.dormshops.furniture[arg_17_0.soulid], arg_17_0)
		end,
		[kITEM_SKIN] = function(arg_18_0)
			arg_15_0.dormshops.skin[arg_18_0.soulid] = arg_15_0.dormshops.skin[arg_18_0.soulid] or {}

			if arg_18_0.shopinfo.have_bought < arg_18_0.shopinfo.buy_limit then
				arg_15_0.dormshops.skin[arg_18_0.soulid][item_data[arg_18_0.shopinfo.itemtype].model] = arg_18_0
			end
		end,
		[kITEM_SKIN_GIFT] = function(arg_19_0)
			arg_15_0.dormshops.skin[arg_19_0.soulid] = arg_15_0.dormshops.skin[arg_19_0.soulid] or {}

			if arg_19_0.shopinfo.have_bought < arg_19_0.shopinfo.buy_limit then
				arg_15_0.dormshops.skin[arg_19_0.soulid][item_data[arg_19_0.shopinfo.itemtype].model] = arg_19_0
			end
		end,
		[KITEM_RING] = function(arg_20_0)
			arg_15_0.dormshops.ring[arg_20_0.soulid] = arg_20_0
		end
	}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		itemtype = item_data[iter_15_1.shopinfo.itemtype].bag_item_type

		if var_15_0[itemtype] then
			var_15_0[itemtype](iter_15_1)
		end
	end
end

function var_0_0.updateRoomsData(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		playermodel.dormRoomConfig[iter_21_0] = iter_21_1
	end
end

function var_0_0:getDRSoulList()
	self.DRList = {}

	for iter_22_0, iter_22_1 in pairs(playermodel.soulsDRstatus) do
		if iter_22_1 > 0 then
			self.DRList[iter_22_0] = iter_22_1
		end
	end
end

function var_0_0:getSoulConversation()
	local var_23_0 = RoleDefault:getInstance():getStringForKey("dormConversation", "")

	if var_23_0 then
		for iter_23_0, iter_23_1 in string.gmatch(var_23_0, "([^&]+)=([^&]+)") do
			self.soulConversations[tonumber(iter_23_0)] = tonumber(iter_23_1)
		end
	end
end

function var_0_0:updateRoomConversation()
	local var_24_0 = ""

	for iter_24_0, iter_24_1 in pairs(self.soulConversations) do
		var_24_0 = var_24_0 .. tostring(iter_24_0) .. "=" .. tostring(iter_24_1) .. "&"
	end

	RoleDefault:getInstance():setStringForKey("dormConversation", var_24_0)
end

function var_0_0:getConverstaionId(arg_25_1)
	local var_25_0 = math.random(#self.travelList[arg_25_1].events)

	assert(travel_event_data[self.travelList[arg_25_1].events[var_25_0].eventid], self.travelList[arg_25_1].events[var_25_0].eventid)

	return travel_event_data[self.travelList[arg_25_1].events[var_25_0].eventid].conversation
end

function var_0_0.release(arg_26_0)
	arg_26_0.soul_to_index = nil
	arg_26_0.groupId = nil
	arg_26_0.travelList = nil
	arg_26_0.soulConversations = nil
	arg_26_0.dormshops = nil
	arg_26_0.skinshops = nil
end

function var_0_0.unlock_room(arg_27_0, arg_27_1, arg_27_2)
	network:rpc("unlock_room", {
		roomid = arg_27_1
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			if dorm_rooms_data[arg_27_1].costdiamond then
				playermodel.diamond = playermodel.diamond - dorm_rooms_data[arg_27_1].costdiamond
			end

			if dorm_rooms_data[arg_27_1].gold then
				playermodel.gold = playermodel.gold - dorm_rooms_data[arg_27_1].gold
			end

			if dorm_rooms_data[arg_27_1].material1 then
				while dorm_rooms_data[arg_27_1]["material" .. 1] do
					item_manager:deleteItem(dorm_rooms_data[arg_27_1]["material" .. 1], dorm_rooms_data[arg_27_1]["material" .. 1 .. "_num"])
				end
			end

			if arg_28_0.unlock_time then
				arg_27_0.roomInfos[arg_27_1].last_time = arg_28_0.unlock_time
			end

			global_update_gold_stone_diamond(playermodel.gold, nil, arg_28_0.cost)

			if arg_27_2 then
				arg_27_2()
			end
		elseif arg_28_0.result == 2 then
			global_ShowBlockWords(L_DORM_UNLOCK_ROOM_WARNING[2])
		elseif arg_28_0.result == 3 then
			global_ShowBlockWords(L_DORM_UNLOCK_ROOM_WARNING[3])
		elseif arg_28_0.result == 4 then
			global_ShowBlockWords(L_DORM_UNLOCK_ROOM_WARNING[4])
		end
	end)
end

function var_0_0.unlock_live_room(arg_29_0, arg_29_1, arg_29_2)
	network:rpc("unlock_live_room", {
		roomid = arg_29_1
	}, function(arg_30_0)
		if arg_30_0.result == 1 then
			if arg_29_1 == 1 then
				if arg_30_0.host then
					playermodel.dormLiveRoomConfig[arg_29_1].status = arg_30_0.host

					arg_29_0:updateRoomInfos(arg_30_0.host, var_0_18.RESTAURANT)

					playermodel.soulsDRstatus[arg_30_0.host] = arg_30_0.menuid

					if arg_30_0.guest then
						playermodel.soulsDRstatus[arg_30_0.guest] = 1

						arg_29_0:updateRoomInfos(arg_30_0.guest, var_0_18.RESTAURANT)
					end
				else
					playermodel.dormLiveRoomConfig[arg_29_1].status = 0
				end
			else
				playermodel.dormLiveRoomConfig[arg_29_1].status = 0
			end

			playermodel.gold = playermodel.gold - arg_30_0.costgold

			global_update_gold_stone_diamond(arg_30_0.costgold)
		elseif arg_30_0.result == 2 then
			global_ShowBlockWords(L_DORM_UNLOCK_LIVING_ROOM_WARNING[2])
		elseif arg_30_0.result == 3 then
			global_ShowBlockWords(L_GOLD_LACK)
		end

		if arg_29_2 then
			arg_29_2(arg_30_0)
		end
	end)
end

function var_0_0.settle_in(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not playermodel.haveSuit[arg_31_1] then
		global_ShowBlockWords(L_DORM_SETTLE_IN_WARNING[3])

		return
	end

	network:rpc("allocate_soul", {
		soulid = arg_31_1,
		roomid = arg_31_2
	}, function(arg_32_0)
		if arg_32_0.result == 1 then
			playermodel.dormRoomConfig[arg_31_2].soulid = arg_31_1

			AnalyticManager.dorm_settle_in({
				soulid = arg_31_1,
				favorlevel = playermodel.favor[arg_31_1].favorlevel
			})
		elseif arg_32_0.result == 2 then
			global_ShowBlockWords(L_DORM_SETTLE_IN_WARNING[2])
		elseif arg_32_0.result == 3 then
			global_ShowBlockWords(L_DORM_SETTLE_IN_WARNING[3])
		elseif arg_32_0.result == 4 then
			global_ShowBlockWords(L_DORM_SETTLE_IN_WARNING[4])
		end

		if arg_31_3 then
			arg_31_3(arg_32_0.result)
		end
	end)
end

function var_0_0.move_away(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	network:rpc("soul_move_away", {
		soulid = arg_33_1,
		roomid = arg_33_2
	}, function(arg_34_0)
		if arg_34_0.result == 1 then
			playermodel.dormRoomConfig[arg_33_2].soulid = 0
			playermodel.dormRoomConfig[arg_33_2].favorpool = 0
			arg_33_0.soul_to_index[arg_33_1] = nil

			AnalyticManager.dorm_move_away({
				soulid = arg_33_1,
				favorlevel = playermodel.favor[arg_33_1].favorlevel
			})
		elseif arg_34_0.result == 2 then
			global_ShowBlockWords(L_DORM_MOVE_AWAY_WARNING[2])
		elseif arg_34_0.result == 3 then
			global_ShowBlockWords(L_DORM_MOVE_AWAY_WARNING[3])
		end

		if arg_33_3 then
			arg_33_3(arg_34_0.result)
		end
	end)
end

function var_0_0.gainTravelAwards(arg_35_0, arg_35_1, arg_35_2)
	network:rpc("gain_travel_awards", {
		soulid = arg_35_1
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			local var_36_0 = {}

			if arg_36_0.items then
				for iter_36_0, iter_36_1 in pairs(arg_36_0.items) do
					local var_36_1 = item_manager:setItemByServerItem(iter_36_1)

					if var_36_1 > 0 then
						table.insert(var_36_0, {
							dropid = iter_36_1.itemid,
							dropNum = var_36_1,
							entityid = iter_36_1.entityid
						})
					end
				end
			end

			if arg_35_0.soulConversations[arg_35_1] then
				arg_35_0.soulConversations[arg_35_1] = nil
			else
				arg_35_0.roomInfos[arg_35_0.soul_to_index[arg_35_1]].conversation = arg_35_0:getConverstaionId(arg_35_1)
				arg_35_0.soulConversations[arg_35_1] = arg_35_0.roomInfos[arg_35_0.soul_to_index[arg_35_1]].conversation
			end

			if arg_36_0.plotinfo then
				PlotManager:trigger_plot_by_server({
					arg_36_0.plotinfo
				})
			end

			if arg_35_2 then
				arg_35_2(var_36_0, arg_36_0.postcards, arg_36_0.plotinfo)
			end
		end
	end)
end

function var_0_0.driveSoulAwayFromDR(arg_37_0, arg_37_1)
	if playermodel.dormLiveRoomConfig[DORM_DR_ID].status <= 0 then
		global_ShowBlockWords(L_DORM_LEAVE_DR_WARNING[0])

		if arg_37_1 then
			arg_37_1(7)
		end
	end

	network:rpc("DR_drive_away", nil, function(arg_38_0)
		if arg_38_0.result == 1 then
			local var_38_0, var_38_1 = arg_37_0:getDRInfosByClient()

			playermodel.soulsDRstatus[var_38_0] = 0

			arg_37_0:updateRoomInfos(var_38_0, var_0_18.ATHOME)

			if var_38_1 then
				playermodel.soulsDRstatus[var_38_1] = 0

				arg_37_0:updateRoomInfos(var_38_1, var_0_18.ATHOME)
			end

			playermodel.dormLiveRoomConfig[DORM_DR_ID].status = arg_38_0.host
			playermodel.soulsDRstatus[arg_38_0.host] = arg_38_0.menuid

			arg_37_0:updateRoomInfos(arg_38_0.host, var_0_18.RESTAURANT)

			if arg_38_0.guest then
				playermodel.soulsDRstatus[arg_38_0.guest] = 1

				arg_37_0:updateRoomInfos(arg_38_0.guest, var_0_18.RESTAURANT)
			end
		elseif arg_38_0.result == 2 then
			global_ShowBlockWords(L_DORM_LEAVE_DR_WARNING[2])

			local var_38_2, var_38_3 = arg_37_0:getDRInfosByClient()

			playermodel.soulsDRstatus[var_38_2] = 0

			arg_37_0:updateRoomInfos(var_38_2, var_0_18.ATHOME)

			if var_38_3 then
				playermodel.soulsDRstatus[var_38_3] = 0

				arg_37_0:updateRoomInfos(var_38_3, var_0_18.ATHOME)
			end

			playermodel.dormLiveRoomConfig[DORM_DR_ID].status = 0
		elseif arg_38_0.result == 3 then
			cclog("大家都吃完了,没有下一桌了")

			local var_38_4, var_38_5 = arg_37_0:getDRInfosByClient()

			playermodel.soulsDRstatus[var_38_4] = 0

			arg_37_0:updateRoomInfos(var_38_4, var_0_18.ATHOME)

			if var_38_5 then
				playermodel.soulsDRstatus[var_38_5] = 0

				arg_37_0:updateRoomInfos(var_38_5, var_0_18.ATHOME)
			end

			playermodel.dormLiveRoomConfig[DORM_DR_ID].status = 0
		elseif arg_38_0.result == 4 then
			cclog("随机的时候,宿舍status异常")
		elseif arg_38_0.result == 5 then
			global_ShowBlockWords(L_DORM_LEAVE_DR_WARNING[5])
		elseif arg_38_0.result == 6 then
			global_ShowBlockWords(L_DORM_LEAVE_DR_WARNING[6])
		end

		if arg_37_1 then
			arg_37_1(arg_38_0)
		end
	end)
end

function var_0_0.getDRInfoByServer(arg_39_0, arg_39_1)
	if playermodel.dormLiveRoomConfig[DORM_DR_ID].status < 0 then
		return
	end

	network:rpc("get_DR_status", nil, function(arg_40_0)
		if arg_40_0.result == 1 then
			local var_40_0 = {}
			local var_40_1, var_40_2, var_40_3 = arg_39_0:getDRInfosByClient()

			if var_40_1 and var_40_1 > 0 then
				var_40_0.old_host = var_40_1
				var_40_0.old_menuid = var_40_3
				playermodel.dormLiveRoomConfig[DORM_DR_ID].status = 0
				playermodel.soulsDRstatus[var_40_1] = 0

				arg_39_0:updateRoomInfos(var_40_1, var_0_18.ATHOME)

				if var_40_2 then
					var_40_0.old_guest = var_40_2
					playermodel.soulsDRstatus[var_40_2] = 0

					arg_39_0:updateRoomInfos(var_40_2, var_0_18.ATHOME)
				end
			end

			if arg_40_0.host then
				var_40_0.new_host = arg_40_0.host
				var_40_0.new_menuid = arg_40_0.menuid
				playermodel.dormLiveRoomConfig[DORM_DR_ID].status = arg_40_0.host
				playermodel.soulsDRstatus[arg_40_0.host] = arg_40_0.menuid

				arg_39_0:updateRoomInfos(arg_40_0.host, var_0_18.RESTAURANT)

				if arg_40_0.guest then
					var_40_0.new_guest = arg_40_0.guest
					playermodel.soulsDRstatus[arg_40_0.guest] = 1

					arg_39_0:updateRoomInfos(arg_40_0.guest, var_0_18.RESTAURANT)
				end
			end

			if calllback then
				arg_39_1(var_40_0)
			end
		end
	end)
end

function var_0_0.getDRInfosByClient(arg_41_0)
	if playermodel.dormLiveRoomConfig[DORM_DR_ID].status > 0 then
		return playermodel.dormLiveRoomConfig[DORM_DR_ID].status, require("data.food_production.menu.menu" .. playermodel.dormLiveRoomConfig[DORM_DR_ID].status .. "_data")[playermodel.soulsDRstatus[playermodel.dormLiveRoomConfig[DORM_DR_ID].status]].guest, playermodel.soulsDRstatus[playermodel.dormLiveRoomConfig[DORM_DR_ID].status]
	else
		return playermodel.dormLiveRoomConfig[DORM_DR_ID].status
	end
end

function var_0_0:updateRoomInfos(arg_42_1, arg_42_2)
	if not self.soul_to_index then
		return
	end

	if not self.soul_to_index[arg_42_1] then
		return
	end

	self.roomInfos[self.soul_to_index[arg_42_1]].state = arg_42_2
end

function var_0_0.getDRscriptByHostSoulid(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = require("data.food_production.script/restaurant_script" .. arg_43_1 .. "_data")

	return require("data.food_production.menu.menu" .. arg_43_1 .. "_data")[arg_43_2][arg_43_3]
end

function var_0_0.getUsedFurniture(arg_44_0)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(playermodel.dormRoomConfig) do
		if iter_44_1.soulid >= 0 then
			iter_44_1.furnitures = iter_44_1.furnitures or var_0_29(iter_44_0)

			for iter_44_2, iter_44_3 in pairs(iter_44_1.furnitures) do
				var_44_0[iter_44_3] = var_44_0[iter_44_3] and var_44_0[iter_44_3] + 1 or 1
			end
		end
	end

	return var_44_0
end

function var_0_0:getLeftoverFurniture(arg_45_1)
	if playermodel.items[arg_45_1] then
		local var_45_0 = self:getUsedFurniture()

		if var_45_0[arg_45_1] then
			return playermodel.items[arg_45_1].number - var_45_0[arg_45_1]
		else
			return playermodel.items[arg_45_1].number
		end
	else
		return 0
	end
end

function var_0_0:filterSortFurniture(arg_46_1)
	local var_46_0
	local var_46_1

	if arg_46_1.f_type and next(arg_46_1.f_type) ~= nil then
		var_46_0 = {}

		for iter_46_0, iter_46_1 in pairs(arg_46_1.f_type) do
			var_46_0[iter_46_1] = true
		end
	end

	if arg_46_1.usedItems then
		var_46_1 = {}

		for iter_46_2, iter_46_3 in pairs(arg_46_1.usedItems) do
			if iter_46_3 > 0 then
				var_46_1[iter_46_3] = true
			end
		end

		var_46_1 = next(var_46_1) ~= nil and var_46_1 or nil
	end

	local var_46_2 = self:getUsedFurniture()
	local var_46_3 = {}

	for iter_46_4, iter_46_5 in pairs(playermodel.items) do
		if item_data[iter_46_5.itemid].bag_item_type == kITEM_FURNITURE and (not var_46_2[iter_46_5.itemid] or var_46_2[iter_46_5.itemid] < iter_46_5.number) and (not var_46_0 or var_46_0[item_data[iter_46_5.itemid].furniture_type]) and (not var_46_1 or not var_46_1[iter_46_4]) then
			table.insert(var_46_3, {
				itemid = iter_46_5.itemid,
				entityid = iter_46_4,
				quality = item_data[iter_46_5.itemid].equip_quality
			})
		end
	end

	if arg_46_1.orderType == 0 then
		table.sort(var_46_3, function(arg_47_0, arg_47_1)
			if arg_47_0.quality == arg_47_1.quality then
				return arg_47_0.itemid < arg_47_1.itemid
			else
				return arg_47_0.quality < arg_47_1.quality
			end
		end)
	elseif arg_46_1.orderType == 1 then
		table.sort(var_46_3, function(arg_48_0, arg_48_1)
			if arg_48_0.quality == arg_48_1.quality then
				return arg_48_0.itemid > arg_48_1.itemid
			else
				return arg_48_0.quality > arg_48_1.quality
			end
		end)
	end

	local var_46_4 = {}

	for iter_46_6, iter_46_7 in ipairs(var_46_3) do
		var_46_4[iter_46_6] = iter_46_7.entityid
	end

	return var_46_4
end

function var_0_0:changeRoomFurniture(arg_49_1, arg_49_2, arg_49_3)
	if #arg_49_2 ~= 5 then
		cclog("数据异常!!!")

		return
	else
		for iter_49_0 = 1, 5 do
			if arg_49_2[iter_49_0] ~= playermodel.dormRoomConfig[arg_49_1].furnitures[iter_49_0] and arg_49_2[iter_49_0] > 0 and self:getCurFurnitureNum(arg_49_2[iter_49_0]) <= 0 then
				global_ShowBlockWords(L_DORMROOM_CHANGE_FURNTURE_MSG[4])

				return
			end
		end
	end

	network:rpc("change_room_furniture", {
		roomid = arg_49_1,
		furnitureConfig = arg_49_2
	}, function(arg_50_0)
		if arg_50_0.result == 1 then
			for iter_50_0, iter_50_1 in pairs(playermodel.dormRoomConfig[arg_49_1].furnitures) do
				if iter_50_1 > 0 then
					item_manager:add_bag_weight(iter_50_1, 1)
				end
			end

			for iter_50_2, iter_50_3 in pairs(arg_49_2) do
				if iter_50_3 > 0 then
					item_manager:remove_bag_weight(iter_50_3, 1)
				end
			end

			playermodel.dormRoomConfig[arg_49_1].furnitures = arg_49_2

			local var_50_0 = {
				soulid = playermodel.dormRoomConfig[arg_49_1].soulid
			}

			if playermodel.dormRoomConfig[arg_49_1].soulid > 0 then
				var_50_0.favorlevel = playermodel.favor[playermodel.dormRoomConfig[arg_49_1].soulid].favorlevel or nil
			end

			AnalyticManager.change_furniture(var_50_0)

			if arg_49_3 then
				arg_49_3()
			end
		elseif arg_50_0.result == 2 then
			global_ShowBlockWords(L_DORMROOM_CHANGE_FURNTURE_MSG[2])
		elseif arg_50_0.result == 3 then
			global_ShowBlockWords(L_DORMROOM_CHANGE_FURNTURE_MSG[3])
		elseif arg_50_0.result == 4 then
			global_ShowBlockWords(L_DORMROOM_CHANGE_FURNTURE_MSG[4])
		end
	end)
end

function var_0_0.addFavorDegree(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if not playermodel.haveSuit[arg_51_1] then
		if arg_51_3 then
			arg_51_3(2)
		end

		return
	end

	network:rpc("click_add_favor", {
		soulid = arg_51_1,
		favor = arg_51_2
	}, function(arg_52_0)
		if arg_52_0.result == 1 then
			playermodel.favor[arg_51_1].favorlevel = arg_52_0.favorlevel
			playermodel.favor[arg_51_1].favordegree = arg_52_0.favordegree

			if arg_51_3 then
				arg_51_3(1)
			end
		elseif arg_52_0.result == 2 then
			if arg_51_3 then
				arg_51_3(2)
			end
		elseif arg_52_0.result == 3 then
			if arg_51_3 then
				arg_51_3(3)
			end
		elseif arg_51_3 then
			arg_51_3(0)
		end
	end)
end

function var_0_0.getRoomIdBySoulid(arg_53_0, arg_53_1, arg_53_2)
	arg_53_2 = arg_53_2 or false

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(playermodel.dormRoomConfig) do
		var_53_0[iter_53_1.soulid] = iter_53_0
	end

	if arg_53_2 then
		return var_53_0
	else
		return var_53_0[arg_53_1]
	end
end

function var_0_0.getDormfavorLimit(arg_54_0, arg_54_1)
	network:rpc("get_dormfavor_limit", nil, function(arg_55_0)
		if arg_55_0.dormfavor_limit then
			for iter_55_0, iter_55_1 in pairs(arg_55_0.dormfavor_limit) do
				playermodel.dormfavor_limit[iter_55_1.soulid] = DORMFAVOR_LIMIT - iter_55_1.favor
			end

			if arg_54_1 then
				arg_54_1()
			end
		end
	end)
end

local function var_0_30(arg_56_0, arg_56_1)
	while item_data[arg_56_0]["free_send_soul_" .. 1] do
		if item_data[arg_56_0]["free_send_soul_" .. 1] == arg_56_1 then
			return true
		end
	end

	return false
end

function var_0_0.sendGift(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	print(arg_57_1)
	network:rpc("give_favor_gift", {
		is_send_more = true,
		soulid = arg_57_1,
		giftid = arg_57_2
	}, function(arg_58_0)
		print(dump(arg_58_0))

		local var_58_0 = false

		if arg_58_0.result == 1 then
			local var_58_1 = not not (arg_58_0.favorlevel == playermodel.favor[arg_57_1].favorlevel and playermodel.favor[arg_57_1].favordegree == arg_58_0.favordegree and (arg_57_0:is_favor_max(arg_57_1) or arg_57_0:is_marry_favor_max(arg_57_1)))

			if arg_58_0.favorlevel > playermodel.favor[arg_57_1].favorlevel then
				var_58_0 = true

				if LayerManager:getCurrentLayerName() == "DormRoomLayer" then
					LayerManager:getCurrentLayerObj():triggerFavorUpTalk(arg_57_1, playermodel.favor[arg_57_1].favorlevel, arg_58_0.plotinfo)
				elseif LayerManager:getCurrentLayerObj():getName() == "DormRoomPopLayer" then
					LayerManager:getCurrentLayerObj():triggerFavorUpTalk(arg_57_1, playermodel.favor[arg_57_1].favorlevel, arg_58_0.plotinfo)
				end
			end

			playermodel.favor[arg_57_1].favorlevel = arg_58_0.favorlevel
			playermodel.favor[arg_57_1].favordegree = arg_58_0.favordegree

			if var_58_0 and playermodel:isMajorInFight(arg_57_1) then
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			if not var_0_30(arg_57_2, arg_57_1) and not item_data[arg_57_2].is_free_send then
				if playermodel.gift_limit[arg_57_1] > 0 then
					playermodel.gift_limit[arg_57_1] = playermodel.gift_limit[arg_57_1] - 1
				else
					local var_58_2 = math.ceil((playermodel.gift_send_times[arg_57_1] - GIFT_LIMIT + 1) / 10)

					playermodel.diamond = playermodel.diamond - 20

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
				end

				playermodel.gift_send_times[arg_57_1] = playermodel.gift_send_times[arg_57_1] + 1
			end

			item_manager:deleteItem(arg_57_2, 1)

			local var_58_3 = item_data[arg_57_2]["special_favor" .. arg_57_1] or item_data[arg_57_2].favor
			local activity_return_manager = require("controller.activity_return_manager")

			if not var_58_1 then
				audio_manager:playeffectMusic(DORM_FAVOR_UP)
				global_favor_show(var_58_3, function()
					if var_58_0 then
						if DormRoomLayer and DormRoomLayer.getInstance() then
							DormRoomLayer.getInstance():playFavorUpAni()
						elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
							DormRoomPopLayer.getInstance():playFavorUpAni()
						end
					end
				end, (arg_58_0.add_favor and var_58_3 < arg_58_0.add_favor and (arg_57_0:is_add_favor_double(arg_57_1) or (activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_SEND_GIFT_FAVOR) or nil) and true) or nil) and arg_58_0.add_favor - var_58_3)
			end

			if arg_58_0.plotinfo then
				PlotManager:trigger_plot_by_server({
					arg_58_0.plotinfo
				})
			end

			if arg_58_0.back_gift then
				global_gain({
					gold = arg_58_0.back_gift.gold,
					diamond = arg_58_0.back_gift.diamond,
					items = arg_58_0.back_gift.items
				})
			end

			if arg_58_0.items and next(arg_58_0.items) then
				global_gain(arg_58_0)
			end

			AnalyticManager.send_gift({
				itemid = arg_57_2,
				last_time = playermodel.gift_limit[arg_57_1],
				soulid = arg_57_1,
				favorlevel = playermodel.favor[arg_57_1].favorlevel
			})
		elseif arg_58_0.result == 2 then
			cclog("礼物不足")
		elseif arg_58_0.result == 3 then
			cclog("学员未解锁")
			global_ShowBlockWords("学员未解锁")
		elseif arg_58_0.result == 4 then
			global_ShowBlockWords(L_DORM_SEND_GIFT_WARNING[4])
		elseif arg_58_0.result == 5 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end

		if arg_57_3 then
			arg_57_3(arg_58_0.result, var_58_0, arg_57_0:getGiftTalkType(arg_58_0, arg_57_1, arg_57_2), arg_58_0.gift_time)
		end
	end)
end

function var_0_0.getGiftTalkType(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_1.gift_time then
		return ROLE_CONVERSATION_TYPE.gift
	end

	if arg_60_1.items and next(arg_60_1.items) then
		return ROLE_CONVERSATION_TYPE.act_get
	end

	local activity_send_gift_conf_data = require("data.activity_send_gift.activity_send_gift_conf_data")

	if not activity_send_gift_conf_data[arg_60_2] then
		return ROLE_CONVERSATION_TYPE.act_false
	end

	local var_60_1 = activity_send_gift_conf_data[arg_60_2].drop_item

	if activity_send_gift_conf_data[arg_60_2] and activity_send_gift_conf_data[arg_60_2].itemid ~= arg_60_3 then
		return ROLE_CONVERSATION_TYPE.act_false
	end

	if item_manager:haveItem(var_60_1) then
		return ROLE_CONVERSATION_TYPE.act_got
	end

	if arg_60_1.gift_stat then
		return ROLE_CONVERSATION_TYPE.act_gift
	else
		return ROLE_CONVERSATION_TYPE.act_false
	end
end

local function var_0_31(arg_61_0, arg_61_1)
	return not global_is_hide_skin_by_itemid(arg_61_0, arg_61_1)
end

function var_0_0.getSoulDresses(arg_62_0, arg_62_1)
	local var_62_0 = {}
	local var_62_1 = {}

	while major_factor_data[arg_62_1]["item" .. 1] do
		if var_0_31(major_factor_data[arg_62_1]["item" .. 1], major_factor_data[arg_62_1]["item" .. 1 .. "_hide"]) then
			table.insert(var_62_1, {
				modelid = item_data[major_factor_data[arg_62_1]["item" .. 1]].model,
				order = 1,
				count = item_manager:getItemNumber(major_factor_data[arg_62_1]["item" .. 1])
			})
		end
	end

	table.sort(var_62_1, function(arg_63_0, arg_63_1)
		if arg_63_0.count == arg_63_1.count then
			return arg_63_0.order < arg_63_1.order
		else
			return arg_63_0.count > arg_63_1.count
		end
	end)
	table.insert(var_62_1, 1, {
		modelid = major_factor_data[arg_62_1].model
	})

	for iter_62_0, iter_62_1 in ipairs(var_62_1) do
		table.insert(var_62_0, iter_62_1.modelid)
	end

	return var_62_0
end

function var_0_0.getSoulDressesFromServant(arg_64_0, arg_64_1)
	local servant_data = require("data.servant_data")
	local var_64_1 = {}
	local var_64_2 = {}

	while major_factor_data[servant_data[arg_64_1].major]["item" .. 1] do
		if var_0_31(major_factor_data[servant_data[arg_64_1].major]["item" .. 1], major_factor_data[servant_data[arg_64_1].major]["item" .. 1 .. "_hide"]) then
			table.insert(var_64_2, {
				modelid = item_data[major_factor_data[servant_data[arg_64_1].major]["item" .. 1]].model,
				order = 1,
				count = item_manager:getItemNumber(major_factor_data[servant_data[arg_64_1].major]["item" .. 1])
			})
		end
	end

	table.sort(var_64_2, function(arg_65_0, arg_65_1)
		if arg_65_0.count == arg_65_1.count then
			return arg_65_0.order < arg_65_1.order
		else
			return arg_65_0.count > arg_65_1.count
		end
	end)
	table.insert(var_64_2, 1, {
		modelid = servant_data[arg_64_1].modelid
	})

	for iter_64_0, iter_64_1 in ipairs(var_64_2) do
		table.insert(var_64_1, iter_64_1.modelid)
	end

	return var_64_1
end

function var_0_0.getSoulDressModelid(arg_66_0, arg_66_1)
	if playermodel.dress[arg_66_1] and playermodel.dress[arg_66_1] ~= -1 then
		return item_data[playermodel.dress[arg_66_1]].model
	else
		return
	end
end

function var_0_0.changeSoulDress(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	if arg_67_2 > 0 and not item_manager:haveItem(arg_67_2) then
		if arg_67_3 then
			arg_67_3(4)
		end

		return {
			result = 4
		}
	end

	if not playermodel.haveSuit[arg_67_1] then
		if arg_67_3 then
			arg_67_3(2)
		end

		return {
			result = 2
		}
	end

	network:rpc("change_soul_dress", {
		soulid = arg_67_1,
		dress = arg_67_2
	}, function(arg_68_0)
		local var_68_0 = false

		if arg_68_0.result == 1 then
			if arg_68_0.favorlevel then
				local var_68_1 = not not (arg_68_0.favorlevel == playermodel.favor[arg_67_1].favorlevel and playermodel.favor[arg_67_1].favordegree == arg_68_0.favordegree and (arg_67_0:is_favor_max(arg_67_1) or arg_67_0:is_marry_favor_max(arg_67_1)))

				if arg_68_0.favorlevel > playermodel.favor[arg_67_1].favorlevel then
					var_68_0 = true

					if LayerManager:getCurrentLayerName() == "DormRoomLayer" then
						LayerManager:getCurrentLayerObj():triggerFavorUpTalk(arg_67_1, playermodel.favor[arg_67_1].favorlevel, arg_68_0.plotinfo)
					elseif LayerManager:getCurrentLayerObj():getName() == "DormRoomPopLayer" then
						LayerManager:getCurrentLayerObj():triggerFavorUpTalk(arg_67_1, playermodel.favor[arg_67_1].favorlevel, arg_68_0.plotinfo)
					end
				end

				playermodel.favor[arg_67_1].favorlevel = arg_68_0.favorlevel
				playermodel.favor[arg_67_1].favordegree = arg_68_0.favordegree

				if not var_68_1 and item_data[arg_67_2].favor and item_data[arg_67_2].favor ~= 0 then
					audio_manager:playeffectMusic(DORM_FAVOR_UP)
					global_favor_show(item_data[arg_67_2].favor, function()
						if var_68_0 then
							if DormRoomLayer and DormRoomLayer.getInstance() then
								DormRoomLayer.getInstance():playFavorUpAni()
							elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
								DormRoomPopLayer.getInstance():playFavorUpAni()
							end
						end
					end)
				end
			end

			playermodel.dress[arg_67_1] = arg_67_2

			if arg_68_0.plotinfo then
				PlotManager:trigger_plot_by_server({
					arg_68_0.plotinfo
				})
			end

			if arg_68_0.back_gift then
				global_gain({
					gold = arg_68_0.back_gift.gold,
					diamond = arg_68_0.back_gift.diamond,
					items = arg_68_0.back_gift.items
				})
			end

			if arg_68_0.items and next(arg_68_0.items) then
				global_gain(arg_68_0.items)
			end

			if arg_68_0.servant_skin_list and next(arg_68_0.servant_skin_list) then
				for iter_68_0, iter_68_1 in pairs(arg_68_0.servant_skin_list) do
					playermodel.servantUsedskin[iter_68_1.servantid] = iter_68_1.skin

					local array_manager = require("controller.array_manager")
					local var_68_3 = array_manager:getArrayByServantID(iter_68_1.servantid)

					if var_68_3 and array_manager:isArrayCurHangup(var_68_3) then
						array_manager:registerHangupArrayChange()
						array_manager:executeHangupArrayChange()
					end

					AnalyticManager.servant_set_skin({
						servantid = iter_68_1.servantid,
						skin_itemid = iter_68_1.skin
					})
				end
			end
		elseif arg_68_0.result == 2 then
			cclog("学员未解锁")
			global_ShowBlockWords("学员未解锁")
		elseif arg_68_0.result == 4 then
			cclog("服装不存在")
		end

		if arg_67_3 then
			arg_67_3(arg_68_0.result, var_68_0)
		end
	end)
end

function var_0_0.checkIsCanSendGift(arg_70_0, arg_70_1)
	if playermodel.gift_limit[arg_70_1] <= 0 then
		return
	end

	return #item_manager:filterItem({
		kITEM_GIFT_FOR_FRIEND
	}) > 0
end

function var_0_0.getFurnituresAdd(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = 0

	local function var_71_1(arg_72_0)
		local var_72_0 = {}

		while item_data[arg_72_0]["extra_soul" .. 1] do
			var_72_0[item_data[arg_72_0]["extra_soul" .. 1]] = true
		end

		return var_72_0
	end

	local function var_71_2(arg_73_0)
		if var_71_1(arg_73_0)[arg_71_2] then
			return 0.06
		else
			return ({
				0,
				0.01,
				0.02,
				0.03,
				0.04,
				0.05
			})[item_data[arg_73_0].equip_quality]
		end
	end

	for iter_71_0, iter_71_1 in pairs(arg_71_1) do
		if iter_71_1 > 0 then
			var_71_0 = var_71_0 + var_71_2(iter_71_1)
		end
	end

	return var_71_0
end

function var_0_0:getSoulGiftList(arg_74_1)
	local var_74_0 = item_manager:filterItem({
		kITEM_GIFT_FOR_FRIEND
	})
	local var_74_1 = {}
	local var_74_2 = {}

	local function var_74_3(arg_75_0)
		local var_75_0 = {}

		if not arg_75_0 then
			return var_75_0
		end

		if type(arg_75_0) == "number" then
			var_75_0[arg_75_0] = true
		elseif type(arg_75_0) == "string" then
			for iter_75_0 in arg_75_0:gmatch("([^,]+)") do
				var_75_0[tonumber(iter_75_0)] = true
			end
		end

		return var_75_0
	end

	local function var_74_4(arg_76_0)
		if global_get_model_attr(servant_data[major_factor_data[arg_74_1].servant].modelid) ~= "umaru" then
			return true
		end

		if arg_76_0 == 6700103 or arg_76_0 == 6700104 then
			return false
		end

		return true
	end

	for iter_74_0 = 1, #var_74_0 do
		if var_74_4(var_74_0[iter_74_0]) then
			if var_74_3(item_data[var_74_0[iter_74_0]].exclusive)[arg_74_1] then
				var_74_2[#var_74_2 + 1] = var_74_0[iter_74_0]
			elseif not item_data[var_74_0[iter_74_0]].exclusive then
				var_74_2[#var_74_2 + 1] = var_74_0[iter_74_0]
			end
		end
	end

	for iter_74_1, iter_74_2 in pairs(var_74_2) do
		var_74_1[iter_74_2] = true
	end

	table.sort(var_74_2, function(arg_77_0, arg_77_1)
		return item_data[arg_77_0].favor > item_data[arg_77_1].favor
	end)

	local var_74_5 = {}

	if self.dormshops.gift[arg_74_1] then
		for iter_74_3, iter_74_4 in pairs(self.dormshops.gift[arg_74_1]) do
			if not var_74_1[iter_74_4.shopinfo.itemtype] then
				table.insert(var_74_5, iter_74_4)
			end
		end

		table.sort(var_74_5, function(arg_78_0, arg_78_1)
			return arg_78_0.order < arg_78_1.order
		end)
	end

	return var_74_2, var_74_5
end

function var_0_0:getCurFurnitureNum(arg_79_1)
	if not item_manager:haveItem(arg_79_1) then
		return 0
	end

	local var_79_0 = self:getUsedFurniture()

	if var_79_0[arg_79_1] then
		return playermodel.items[arg_79_1].number - var_79_0[arg_79_1]
	else
		return playermodel.items[arg_79_1].number
	end
end

function var_0_0:getHavedFurnitureSuits(arg_80_1, arg_80_2)
	local var_80_0 = {}
	local var_80_1 = playermodel.dormRoomConfig[arg_80_1].furnitures

	if playermodel.dormRoomConfig[arg_80_1].soulid >= 0 then
		var_80_1 = var_80_1 or var_0_29(k)

		for iter_80_0, iter_80_1 in pairs(var_80_1) do
			if iter_80_1 > 0 then
				var_80_0[iter_80_1] = true
			end
		end

		local var_80_2 = true

		for iter_80_2 = 1, 5 do
			if not var_80_1[iter_80_2] or var_80_1[iter_80_2] < 0 then
				var_80_2 = false

				break
			elseif item_data[var_80_1[1]].suit_id ~= item_data[var_80_1[iter_80_2]].suit_id then
				var_80_2 = false

				break
			end
		end

		if var_80_2 then
			var_80_0 = {}
		end
	end

	local var_80_3 = {}

	for iter_80_3, iter_80_4 in pairs(furnituresuit_data) do
		local var_80_4 = 0

		for iter_80_5 = 1, 5 do
			if var_80_0[iter_80_4["furniture" .. iter_80_5]] or self:getCurFurnitureNum(iter_80_4["furniture" .. iter_80_5]) > 0 then
				var_80_4 = var_80_4 + 1
			end
		end

		if var_80_4 == 5 then
			table.insert(var_80_3, iter_80_3)
		end
	end

	if next(var_80_3) ~= nil then
		table.sort(var_80_3, function(arg_81_0, arg_81_1)
			local var_81_0 = self:get_furniture_add_favor_by_suitid(arg_81_0, arg_80_2)
			local var_81_1 = self:get_furniture_add_favor_by_suitid(arg_81_1, arg_80_2)

			if var_81_0 == var_81_1 then
				return (furnituresuit_data[arg_81_1].order_type or 0) < (furnituresuit_data[arg_81_0].order_type or 0)
			else
				return var_81_1 < var_81_0
			end
		end)
	end

	local var_80_5 = {}

	if self.dormshops.furniture[playermodel.dormRoomConfig[arg_80_1].soulid] then
		for iter_80_6, iter_80_7 in pairs(self.dormshops.furniture[playermodel.dormRoomConfig[arg_80_1].soulid]) do
			suitid = item_data[iter_80_7.shopinfo.itemtype].suit_id

			local var_80_6 = true

			for iter_80_8 = 1, 5 do
				if not item_manager:haveItem(furnituresuit_data[suitid]["furniture" .. iter_80_8]) then
					var_80_6 = false

					break
				end
			end

			if not var_80_6 then
				iter_80_7.suitid = suitid

				table.insert(var_80_5, iter_80_7)
			end
		end

		table.sort(var_80_5, function(arg_82_0, arg_82_1)
			return arg_82_0.order < arg_82_1.order
		end)
	end

	return var_80_3, var_80_5
end

function var_0_0.add_favor_from_pool(arg_83_0, arg_83_1, arg_83_2)
	network:rpc("add_favor_from_pool", {
		roomid = arg_83_1
	}, function(arg_84_0)
		if arg_84_0.result == 1 then
			playermodel.dormRoomConfig[arg_83_1].favorpool = 0

			local var_84_0

			if arg_84_0.back_gift then
				var_84_0 = arg_84_0.back_gift.items[1].itemcount - item_manager:getItemNumber(6800401)

				AnalyticManager.gain_favor_coin({
					soulid = playermodel.dormRoomConfig[arg_83_1].soulid,
					gain_num = var_84_0
				})
				global_get({
					gold = arg_84_0.back_gift.gold,
					diamond = arg_84_0.back_gift.diamond,
					items = arg_84_0.back_gift.items
				})
				arg_83_0:checkRed()
			end

			if arg_83_2 then
				arg_83_2(arg_84_0.result, var_84_0)
			end
		elseif arg_84_0.result == 2 or arg_84_0.result == 4 then
			global_ShowBlockWords(L_FAVOR_POOL_EMPTY)

			if arg_83_2 then
				arg_83_2(arg_84_0.result)
			end
		elseif arg_84_0.result == 3 then
			cclog("未放入学员")

			if arg_83_2 then
				arg_83_2(arg_84_0.result)
			end
		end
	end)
end

function var_0_0.get_furniture_add_favor(arg_85_0, arg_85_1, arg_85_2)
	arg_85_2 = arg_85_2 or 1

	local var_85_0 = 0

	for iter_85_0, iter_85_1 in pairs(arg_85_1) do
		if iter_85_1 > 0 then
			var_85_0 = var_85_0 + (item_data[iter_85_1]["soul" .. arg_85_2 .. "_favor"] or 0)
		end
	end

	for iter_85_2, iter_85_3 in ipairs(favor_daily_class_data) do
		if var_85_0 < iter_85_3.max_value then
			return iter_85_3.favor_add
		end
	end

	return favor_daily_class_data[#favor_daily_class_data].favor_add
end

function var_0_0:get_furniture_add_favor_by_suitid(arg_86_1, arg_86_2)
	local var_86_0 = {}

	for iter_86_0 = 1, 5 do
		table.insert(var_86_0, furnituresuit_data[arg_86_1]["furniture" .. iter_86_0])
	end

	return self:get_furniture_add_favor(var_86_0, arg_86_2)
end

function var_0_0.get_favor_gift_limit(arg_87_0, arg_87_1, arg_87_2)
	network:rpc("get_favor_gift_limit", {
		soulid = arg_87_1
	}, function(arg_88_0)
		if arg_88_0.gift_limit then
			for iter_88_0, iter_88_1 in pairs(arg_88_0.gift_limit) do
				if iter_88_1.free_limit - iter_88_1.send_times >= 0 then
					playermodel.gift_limit[iter_88_1.soulid] = iter_88_1.free_limit - iter_88_1.send_times or 0
				end

				playermodel.gift_send_times[iter_88_1.soulid] = iter_88_1.send_times
				GIFT_LIMIT = iter_88_1.free_limit
			end
		end

		if arg_87_2 then
			arg_87_2(arg_87_1)
		end
	end)
end

function var_0_0.is_favor_max(arg_89_0, arg_89_1)
	if playermodel.favor[arg_89_1].favorlevel == #favor_data then
		return true
	end

	return false
end

function var_0_0.is_marry_favor_max(arg_90_0, arg_90_1)
	if playermodel.marrytimes[arg_90_1] then
		return false
	end

	if 10 <= playermodel.favor[arg_90_1].favorlevel and playermodel.favor[arg_90_1].favordegree >= favor_data[10].experience then
		return true
	end

	return false
end

function var_0_0.can_show_marry_ui(arg_91_0, arg_91_1)
	return require("controller.hexie_manager"):canShowMarry()
end

function var_0_0.get_unlock_rooms(arg_92_0)
	local var_92_0 = 0

	for iter_92_0, iter_92_1 in pairs(playermodel.dormRoomConfig) do
		if iter_92_1.soulid >= 0 then
			var_92_0 = var_92_0 + 1
		end
	end

	return var_92_0
end

function var_0_0:is_add_favor_double(arg_93_1)
	if not self.double_finish_time then
		return false
	end

	if time_check_manager:getCurTime() > self.double_finish_time then
		return false
	end

	if self.activity_souls and next(self.activity_souls) ~= nil and not self.activity_souls[arg_93_1] then
		return false
	end

	return true
end

function var_0_0:is_more_send_gift()
	if not self.gift_finish_time then
		return false
	end

	if time_check_manager:getCurTime() > self.gift_finish_time then
		return false
	end

	return true
end

function var_0_0.getAllFavorFromPool(arg_95_0, arg_95_1)
	network:rpc("add_favor_one_key", nil, function(arg_96_0)
		if arg_96_0.result == 1 then
			for iter_96_0, iter_96_1 in pairs(playermodel.dormRoomConfig) do
				iter_96_1.favorpool = 0
			end

			if arg_96_0.back_gift then
				global_gain({
					gold = arg_96_0.back_gift.gold,
					diamond = arg_96_0.back_gift.diamond,
					items = arg_96_0.back_gift.items
				})
			end

			arg_95_0:checkRed()

			if arg_95_1 then
				arg_95_1(arg_96_0)
			end
		end
	end)
end

function var_0_0:checkOverflowFavorpool()
	for iter_97_0, iter_97_1 in pairs(self.roomInfos) do
		if iter_97_1.soulid and 25 + playermodel.favor[iter_97_1.soulid].favorlevel * 4 <= playermodel.dormRoomConfig[iter_97_0].favorpool then
			return true
		end
	end

	return false
end

function var_0_0:checkRoleSpillageFavorByIndex(arg_98_1)
	if self.roomInfos[arg_98_1] and self.roomInfos[arg_98_1].soulid and 25 + playermodel.favor[self.roomInfos[arg_98_1].soulid].favorlevel * 4 <= playermodel.dormRoomConfig[arg_98_1].favorpool then
		return true
	end

	return false
end

function var_0_0:checkHaveFavour()
	for iter_99_0, iter_99_1 in pairs(self.roomInfos) do
		if iter_99_1.soulid and playermodel.dormRoomConfig[iter_99_0].favorpool > 0 then
			return true
		end
	end

	return false
end

function var_0_0:checkRed()
	if not self:checkOverflowFavorpool() then
		require("controller.alert_manager"):unregister_alert(ALERT_DORMITORY_FAVOUR, true)
	end
end

function var_0_0:layerOnEnter(arg_101_1)
	self.layer = self.layer or arg_101_1
end

function var_0_0:layerOnExit()
	if self.layer then
		self.layer = nil
	end
end

function var_0_0:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function var_0_0:jumpToTarSoulId(arg_104_1)
	if self.layer then
		self.layer:jumpToTarSoulId(arg_104_1)
	end
end

return var_0_0
