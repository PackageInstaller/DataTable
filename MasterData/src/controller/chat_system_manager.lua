local var_0_0 = {}
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local network = require("network.network")
local drop_data = require("data.drop_data")
local item_manager = require("controller.item_manager")
local friend_const_data = require("data.friend_const_data")
local playermodel = require("model.playermodel")
local family_chat_otherdata = require("data.family_chat_otherdata")
local family_systemchat_data = require("data.family_systemchat_data")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local var_0_13 = "recent_friend_chat_data.txt"
local var_0_14 = "chat_cachedata.txt"

var_0_0.player_friend_list = {}
var_0_0.chat_data_list = {}
var_0_0.chat_data_temp = {}
var_0_0.recent_friend_list = {}

local chat_emotion_item_data = require("data.chat_emotion_item_data")
local var_0_16 = {
	[3] = true
}
local var_0_17 = "在商城购买后即可解锁，点击后前往商城购买>>>>>>>>>>>>>>>"

var_0_0.apply1_left_num = 0
var_0_0.apply1_num = 1

function var_0_0.get_friend_list(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or 1
	arg_1_2 = arg_1_2 or 200

	network:rpc("get_friend_list", {
		start = arg_1_1,
		count = arg_1_2
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			arg_1_0.player_have_friend = arg_2_0.total
			arg_1_0.apply1_left_num = arg_1_0.player_have_friend - 200 * arg_1_0.apply1_num

			if arg_2_0.list and next(arg_2_0.list) then
				for iter_2_0, iter_2_1 in pairs(arg_2_0.list) do
					table.insert(arg_1_0.player_friend_list, iter_2_1)
				end
			end

			if arg_1_0.apply1_left_num <= 0 then
				if arg_1_3 then
					arg_1_3(arg_2_0.result, arg_1_0.player_friend_list)
				end
			else
				arg_1_0.apply1_num = arg_1_0.apply1_num + 1

				arg_1_0:get_friend_list(arg_1_0.apply1_num * 200 + 1, arg_1_0.apply1_num * 200 + 1 + 200, arg_1_3)
			end
		elseif arg_1_3 then
			arg_1_3(arg_2_0.result)
		end
	end)
end

function var_0_0.fetch_chat_message(arg_3_0, arg_3_1, arg_3_2)
	network:rpc("fetch_chat_message", {
		channel = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.finish then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.list) do
					table.insert(arg_3_0.chat_data_temp, iter_4_1)
				end

				arg_3_0:dealwithTheChatData(arg_3_0.chat_data_temp)

				if arg_3_2 then
					arg_3_2(arg_4_0.result, arg_3_0.chat_data_list)
				end
			else
				for iter_4_2, iter_4_3 in pairs(arg_4_0.list) do
					table.insert(arg_3_0.chat_data_temp, iter_4_3)
				end

				arg_3_0:fetch_chat_message(arg_3_1, arg_3_2)
			end
		elseif arg_3_2 then
			arg_3_2(arg_4_0)
		end
	end)
end

function var_0_0.send_chat_message(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	network:rpc("send_chat_message", {
		channel = arg_5_1,
		playerid = arg_5_2,
		message = arg_5_3
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			if arg_5_4 then
				arg_5_4(arg_6_0.result)
			end
		elseif arg_5_4 then
			arg_5_4(arg_6_0.result)
		end
	end)
end

function var_0_0.get_chat_data(arg_7_0, arg_7_1)
	network:rpc("get_chat_data", nil, function(arg_8_0)
		activity_manager:fireEvent(activity_manager.activityEventId.HAVE_PRIVATE_CHATE_DATA, {
			info = arg_8_0
		})
	end)
end

function var_0_0.getEmotionData(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = {}

	if chat_emotion_item_data then
		for iter_9_0, iter_9_1 in pairs(chat_emotion_item_data) do
			if iter_9_1.icontype == arg_9_1 then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	if next(var_9_0) then
		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			return arg_10_0.order < arg_10_1.order
		end)
	end

	return var_9_0
end

function var_0_0:getPlayerFriendList()
	return self.player_friend_list
end

function var_0_0.resetFriendListParam(arg_12_0)
	arg_12_0.player_friend_list = {}
	arg_12_0.apply1_left_num = 0
	arg_12_0.apply1_num = 1
end

function var_0_0:dealwithTheChatData(arg_13_1)
	if not arg_13_1 or not next(arg_13_1) then
		return
	end

	if self.chat_data_list then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			if self.chat_data_list["" .. iter_13_1.playerid] then
				table.insert(self.chat_data_list["" .. iter_13_1.playerid], {
					myself = false,
					isread = false,
					id = #self.chat_data_list["" .. iter_13_1.playerid] + 1,
					time = iter_13_1.time,
					message = iter_13_1.message,
					serveroder = iter_13_1.id
				})
			else
				self.chat_data_list["" .. iter_13_1.playerid] = {
					{
						myself = false,
						id = 1,
						isread = false,
						time = iter_13_1.time,
						message = iter_13_1.message,
						serveroder = iter_13_1.id
					}
				}
			end
		end
	end
end

function var_0_0:sortFrindListData(arg_14_1, arg_14_2)
	if not arg_14_1 then
		return
	end

	local var_14_0 = {}
	local var_14_1
	local var_14_2 = {}
	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if arg_14_2 and arg_14_2 == iter_14_1.playerid then
			var_14_1 = iter_14_1
		elseif self:getFriendNoReadNewsNum(iter_14_1.playerid) > 0 then
			table.insert(var_14_2, iter_14_1)
		elseif iter_14_1.lastlogin == "-1" then
			table.insert(var_14_3, iter_14_1)
		else
			table.insert(var_14_4, iter_14_1)
		end
	end

	if var_14_1 then
		table.insert(var_14_0, var_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_2) do
		table.insert(var_14_0, iter_14_3)
	end

	for iter_14_4, iter_14_5 in ipairs(var_14_3) do
		table.insert(var_14_0, iter_14_5)
	end

	if next(var_14_4) then
		table.sort(var_14_4, function(arg_15_0, arg_15_1)
			return global_get_time_by_date(arg_15_0.lastlogin) > global_get_time_by_date(arg_15_1.lastlogin)
		end)

		for iter_14_6, iter_14_7 in ipairs(var_14_4) do
			table.insert(var_14_0, iter_14_7)
		end
	end

	return var_14_0
end

function var_0_0:sortRecentFrindListData(arg_16_1, arg_16_2)
	if not arg_16_1 then
		return
	end

	local var_16_0 = {}
	local var_16_1
	local var_16_2 = {}
	local var_16_3 = {}
	local var_16_4 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_5 = self:getPlayerInfoByPlayerId(iter_16_1.playerid)

		if var_16_5 then
			if arg_16_2 and arg_16_2 == iter_16_1.playerid then
				var_16_1 = iter_16_1
			elseif self:getFriendNoReadNewsNum(iter_16_1.playerid) > 0 then
				table.insert(var_16_2, iter_16_1)
			elseif var_16_5.lastlogin == "-1" then
				table.insert(var_16_3, iter_16_1)
			else
				table.insert(var_16_4, iter_16_1)
			end
		else
			self:deletRecentFriend(iter_16_1.playerid)
		end
	end

	if var_16_1 then
		table.insert(var_16_0, var_16_1)
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_2) do
		table.insert(var_16_0, iter_16_3)
	end

	for iter_16_4, iter_16_5 in ipairs(var_16_3) do
		table.insert(var_16_0, iter_16_5)
	end

	if next(var_16_4) then
		table.sort(var_16_4, function(arg_17_0, arg_17_1)
			return global_get_time_by_date(self:getPlayerInfoByPlayerId(arg_17_0.playerid).lastlogin) > global_get_time_by_date(self:getPlayerInfoByPlayerId(arg_17_1.playerid).lastlogin)
		end)

		for iter_16_6, iter_16_7 in ipairs(var_16_4) do
			table.insert(var_16_0, iter_16_7)
		end
	end

	return var_16_0
end

function var_0_0.resetChatTempDate(arg_18_0)
	arg_18_0.chat_data_temp = {}
end

function var_0_0:getChatCachedata()
	return self.chat_data_list
end

function var_0_0:getRecentFriendData()
	return self.recent_friend_list
end

function var_0_0:inserChartData(arg_21_1)
	if not arg_21_1 or not next(arg_21_1) then
		return
	end

	if self.chat_data_list then
		if self.chat_data_list["" .. arg_21_1.playerid] then
			table.insert(self.chat_data_list["" .. arg_21_1.playerid], {
				id = #self.chat_data_list["" .. arg_21_1.playerid] + 1,
				time = arg_21_1.time,
				message = arg_21_1.message,
				isread = arg_21_1.isread,
				myself = arg_21_1.myself
			})
		else
			self.chat_data_list["" .. arg_21_1.playerid] = {
				{
					id = 1,
					time = arg_21_1.time,
					time = arg_21_1.time,
					message = arg_21_1.message,
					isread = arg_21_1.isread,
					myself = arg_21_1.myself
				}
			}
		end
	end
end

function var_0_0:getPlayerChatList(arg_22_1)
	if not arg_22_1 then
		return
	end

	local var_22_0 = self:getChatCachedata()

	if not var_22_0 then
		return
	end

	return var_22_0["" .. arg_22_1]
end

function var_0_0:initChatDataFromCache()
	self.chat_data_list = self:getChatCachedataFromlocal(var_0_14)
	self.recent_friend_list = self:getChatCachedataFromlocal(var_0_13)
end

function var_0_0.resetChatCachedata(arg_24_0)
	arg_24_0.chat_data_list = {}
end

function var_0_0.resetRecentFriendData(arg_25_0)
	arg_25_0.recent_friend_list = {}
end

function var_0_0:resetChatDataFromPlayerid(arg_26_1)
	if not arg_26_1 then
		return
	end

	if self.chat_data_list["" .. arg_26_1] then
		self.chat_data_list["" .. arg_26_1] = {}
	end
end

function var_0_0:getPlayerInfoByPlayerId(arg_27_1)
	local var_27_0 = self:getPlayerFriendList()

	if not arg_27_1 or not var_27_0 or not next(var_27_0) then
		return
	end

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1.playerid == arg_27_1 then
			return iter_27_1
		end
	end
end

function var_0_0:getFriendNoReadNewsNum(arg_28_1)
	if not arg_28_1 then
		return 0
	end

	local var_28_0 = 0
	local var_28_1 = self:getPlayerChatList(arg_28_1)

	if not var_28_1 then
		return 0
	end

	if var_28_1 and next(var_28_1) then
		for iter_28_0, iter_28_1 in pairs(var_28_1) do
			if not iter_28_1.isread then
				var_28_0 = var_28_0 + 1
			end
		end
	end

	return var_28_0
end

function var_0_0:addReadData(arg_29_1)
	if not arg_29_1 then
		return
	end

	local var_29_0 = self:getChatCachedata()

	if var_29_0["" .. arg_29_1] then
		for iter_29_0, iter_29_1 in pairs(var_29_0["" .. arg_29_1]) do
			iter_29_1.isread = true
		end
	end
end

function var_0_0:updateRecentFriend(arg_30_1)
	if not arg_30_1 then
		return
	end

	local var_30_0 = self:getRecentFriendData()
	local var_30_1 = true

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if arg_30_1 == iter_30_1.playerid then
			var_30_1 = false

			break
		end
	end

	local var_30_2 = self:getPlayerInfoByPlayerId(arg_30_1)

	if var_30_1 and var_30_2 then
		table.insert(var_30_0, {
			playerid = var_30_2.playerid,
			level = var_30_2.level,
			class = var_30_2.class,
			head_sculpture = var_30_2.head_sculpture
		})
	end
end

function var_0_0:deletRecentFriend(arg_31_1)
	if not arg_31_1 then
		return
	end

	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs((self:getRecentFriendData())) do
		if arg_31_1 ~= iter_31_1.playerid then
			table.insert(var_31_0, iter_31_1)
		end
	end

	self.recent_friend_list = var_31_0
end

function var_0_0:dealChatTime(arg_32_1)
	if not arg_32_1 then
		return ""
	end

	local var_32_0 = time_check_manager:getCurTime()
	local var_32_1 = type(arg_32_1) == "string" and var_32_0 - global_get_time_by_date(arg_32_1) or var_32_0 - arg_32_1
	local var_32_2 = os.date("*t", math.floor(var_32_0))

	if var_32_1 <= 86400 then
		return self:formateTheTime(arg_32_1)
	else
		local var_32_3 = math.floor(var_32_1 / 86400)

		if var_32_3 >= 365 then
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips6, 1)
		else
			return string.format(COMMUNITY_MANAGER_SYSTEM.tips5, var_32_3)
		end
	end
end

function var_0_0.formateTheTime(arg_33_0, arg_33_1)
	local var_33_1 = os.date("*t", math.floor(type(arg_33_1) == "string" and global_get_time_by_date(arg_33_1) or arg_33_1))

	return string.format("%02d:%02d", var_33_1.hour, var_33_1.min)
end

function var_0_0:updateFrinedChatData()
	self:updateChatCachedate(var_0_14, {
		["" .. playermodel.playerid] = self.chat_data_list
	})
end

function var_0_0:updateRecentFrinedData()
	self:updateChatCachedate(var_0_13, {
		["" .. playermodel.playerid] = self.recent_friend_list
	})
end

function var_0_0.updateChatCachedate(arg_36_0, arg_36_1, arg_36_2)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. arg_36_1) then
		local var_36_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. arg_36_1)

		if var_36_0 == "nil" then
			local var_36_1 = cc.FileUtils:getInstance()
			local var_36_2 = assert(io.open(var_36_1:getWritablePath() .. arg_36_1, "w+"))

			var_36_2.write(var_36_1, (json.encode(arg_36_2)))
			var_36_2:flush()
			var_36_2:close()
		else
			local var_36_3 = json.decode(var_36_0)

			var_36_3["" .. playermodel.playerid] = arg_36_2["" .. playermodel.playerid]

			local var_36_4 = cc.FileUtils:getInstance()
			local var_36_5 = assert(io.open(var_36_4:getWritablePath() .. arg_36_1, "w+"))

			var_36_5.write(var_36_4, (json.encode(var_36_3)))
			var_36_5:flush()
			var_36_5:close()
		end
	else
		local var_36_6 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. arg_36_1, "w+"))

		var_36_6:write((json.encode(arg_36_2)))
		var_36_6:flush()
		var_36_6:close()
	end
end

function var_0_0.getChatCachedataFromlocal(arg_37_0, arg_37_1)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. arg_37_1) then
		local var_37_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. arg_37_1)

		if var_37_0 == "nil" then
			return {}
		elseif var_37_0 then
			local var_37_1 = json.decode(var_37_0)

			if var_37_1["" .. playermodel.playerid] then
				return var_37_1["" .. playermodel.playerid]
			else
				return {}
			end
		end
	else
		return {}
	end
end

function var_0_0.clearLocalChatDataByPlayerid(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not arg_38_1 or not arg_38_2 or not arg_38_3 then
		return
	end

	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. arg_38_2) then
		local var_38_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. arg_38_2)

		if var_38_0 == "nil" then
			return
		elseif var_38_0 then
			local var_38_1 = json.decode(var_38_0)

			if var_38_1["" .. playermodel.playerid] then
				if arg_38_3 == 1 then
					if var_38_1["" .. playermodel.playerid]["" .. arg_38_1] then
						var_38_1["" .. playermodel.playerid]["" .. arg_38_1] = {}

						local var_38_2 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. arg_38_2, "w+"))

						var_38_2:write((json.encode(var_38_1)))
						var_38_2:flush()
						var_38_2:close()
					else
						return
					end
				elseif arg_38_3 == 2 then
					for iter_38_0, iter_38_1 in ipairs(var_38_1["" .. playermodel.playerid]) do
						if iter_38_1.playerid == arg_38_1 then
							iter_38_1 = nil

							break
						end
					end

					local var_38_4 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. arg_38_2, "w+"))

					var_38_4:write((json.encode(var_38_1)))
					var_38_4:flush()
					var_38_4:close()
				end
			else
				return
			end
		end
	end
end

function var_0_0.getDefulatFaceid(arg_39_0)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(chat_emotion_item_data) do
		table.insert(var_39_0, iter_39_1)
	end

	table.sort(var_39_0, function(arg_40_0, arg_40_1)
		return arg_40_0.id < arg_40_1.id
	end)

	return var_39_0[1].id
end

function var_0_0.getEmotionTypeData(arg_41_0, arg_41_1)
	arg_41_1 = arg_41_1 or 1

	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(chat_emotion_item_data) do
		if arg_41_1 == 1 then
			if iter_41_1.default and iter_41_1.image_id and not iter_41_1.spine then
				table.insert(var_41_0, iter_41_1)
			end
		elseif arg_41_1 == 2 and iter_41_1.default and iter_41_1.spine then
			table.insert(var_41_0, iter_41_1)
		end
	end

	if next(var_41_0) then
		table.sort(var_41_0, function(arg_42_0, arg_42_1)
			return arg_42_0.icontype < arg_42_1.icontype
		end)
	end

	return var_41_0
end

function var_0_0.getChatOtherData(arg_43_0, arg_43_1)
	if not arg_43_1 then
		return false
	end

	if arg_43_1 == 1 then
		return family_chat_otherdata.commity_privatechat_info
	elseif arg_43_1 == 2 then
		return family_chat_otherdata.commity_chat_info
	end
end

function var_0_0:getChatCD(arg_44_1)
	if not arg_44_1 then
		return 0
	end

	if arg_44_1 == 1 then
		return 0
	end

	local var_44_0 = self:getChatOtherData(arg_44_1)

	if not var_44_0 then
		return 0
	end

	return var_44_0.cd or 0
end

function var_0_0:getChatMaxLine(arg_45_1)
	if not arg_45_1 then
		return 30
	end

	local var_45_0 = self:getChatOtherData(arg_45_1)

	if not var_45_0 then
		return 30
	end

	return var_45_0.maxline or 0
end

function var_0_0.getSystemTipsText(arg_46_0, arg_46_1, arg_46_2)
	if not arg_46_1 then
		return
	end

	local var_46_0

	for iter_46_0, iter_46_1 in pairs(family_systemchat_data) do
		if iter_46_1.type == arg_46_1 then
			var_46_0 = iter_46_1.msg
		end
	end

	if not var_46_0 then
		return "未配置系统广播" .. arg_46_1
	end

	return ({
		[-1] = function()
			local var_47_0 = {
				name = function(arg_48_0)
					return arg_48_0
				end
			}

			return string.gsub(var_46_0, "(%w+)|(%w+)", function(arg_49_0, arg_49_1)
				local var_49_0 = arg_46_2[arg_49_1] or ""

				return var_47_0[arg_49_0] and var_49_0 and var_47_0[arg_49_0](var_49_0) or var_49_0
			end)
		end,
		[-2] = function()
			local var_50_0 = ""

			for iter_50_0, iter_50_1 in pairs(arg_46_2.item_list) do
				if iter_50_0 > 1 then
					var_50_0 = var_50_0 .. ","
				end

				var_50_0 = var_50_0 .. item_data[iter_50_1].name .. major_factor_data[servant_data[item_data[iter_50_1].servant].major].name
			end

			return string.format(var_46_0, arg_46_2.playername, "扩招", var_50_0)
		end
	})[arg_46_1]()
end

function var_0_0.getSystemTipsTitle(arg_51_0, arg_51_1)
	if not arg_51_1 then
		return
	end

	for iter_51_0, iter_51_1 in pairs(family_systemchat_data) do
		if iter_51_1.type == arg_51_1 then
			return iter_51_1.title or COMMUNITY_CHAT_SYSTEM.tips12
		end
	end

	return COMMUNITY_CHAT_SYSTEM.tips12
end

function var_0_0.checkIsSpineEmotion(arg_52_0, arg_52_1)
	if not arg_52_1 then
		return false
	end

	if chat_emotion_item_data[arg_52_1] and chat_emotion_item_data[arg_52_1].spine then
		return true
	else
		return false
	end
end

function var_0_0.getDefaultEmotionInfo(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return false
	end

	local var_53_0

	for iter_53_0, iter_53_1 in pairs(chat_emotion_item_data) do
		if iter_53_1.icontype and iter_53_1.icontype == arg_53_1 and iter_53_1.default then
			var_53_0 = iter_53_1

			break
		end
	end

	return var_53_0
end

function var_0_0:checkEmotionIsHave(arg_54_1)
	local var_54_1 = self:getDefaultEmotionInfo(arg_54_1)

	return (var_54_1 and var_0_16[arg_54_1] or nil) and not not (var_54_1.id and playermodel.items[var_54_1.id] and playermodel.items[var_54_1.id].itemtype == CHAT_EMOTION_VALUE)
end

function var_0_0:getMaskLayerTips(arg_55_1)
	local var_55_0 = self:getDefaultEmotionInfo(arg_55_1)

	return (var_55_0 and var_0_16[arg_55_1] and var_55_0.shoptips or nil) and var_55_0.shoptips
end

function var_0_0:getMaskLayerJumpID(arg_56_1)
	local var_56_0 = self:getDefaultEmotionInfo(arg_56_1)

	return (var_56_0 and var_0_16[arg_56_1] and var_56_0.jumpshop or nil) and var_56_0.jumpshop
end

return var_0_0
