local SupermarketLimitedTimePackageManager = class("SupermarketLimitedTimePackageManager", (require("controller.base_manager")))

SupermarketLimitedTimePackageManager.MULTITON_MSG = "SupermarketLimitedTimePackageManager instancealready constructed!"

local recharge_data = require("data.recharge_data")

SupermarketLimitedTimePackageManager.SHOW_DIR = {
	UP_DOWN = 1,
	LEFT_RIGHT = 2
}
SupermarketLimitedTimePackageManager.BUY_STATE = {
	OWNED = 1,
	LOCK = 2
}
SupermarketLimitedTimePackageManager.ReceiveType = {
	ManualDaily = 4,
	DailyDistribution = 3,
	Accumulative = 5
}
SupermarketLimitedTimePackageManager.SpecialGroup = {}

local var_0_2 = {
	fontColor_86514 = "#000000",
	fontColor_83005 = "#9b9bf7",
	fontColor_87805 = "#000000",
	fontColor_88104 = "#615d5e",
	fontColor_88812 = "#000000",
	fontColor_85512 = "#818bb6",
	fontColor_87205 = "#000000",
	fontColor_85511 = "#818bb6",
	fontColor_88811 = "#000000",
	fontColor_86513 = "#000000",
	fontColor_88705 = "#000000",
	fontColor_85805 = "#818bb6",
	fontColor_85005 = "#ad8731",
	fontColor_89105 = "#000000"
}
local var_0_3 = {
	Day = "%d天",
	Hour = "%d时",
	Minute = "%d分",
	Less = "剩余时间小于1分钟"
}
local var_0_4 = {
	"%d天%d时",
	"%d时%d分",
	"%d分钟",
	"%d分%d秒",
	"%d秒"
}

local function var_0_5(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_0 then
		return ""
	end

	local var_1_0 = global_get_time_by_date(arg_1_0) - arg_1_1

	if var_1_0 < 0 then
		return ""
	end

	local var_1_1 = ""
	local var_1_6 = math.floor(var_1_0 / 24 / 3600)
	local var_1_7 = math.floor((var_1_0 - var_1_6 * 24 * 3600) / 3600)
	local var_1_8 = math.floor((var_1_0 - var_1_6 * 24 * 3600 - var_1_7 * 3600) / 60)

	var_1_1 = arg_1_3 == 1 and (var_1_6 ~= 0 and string.format(var_0_3.Day, var_1_6) or var_1_7 ~= 0 and string.format(var_0_3.Hour, var_1_7) or string.format(var_0_3.Minute, var_1_8)) or var_1_6 ~= 0 and string.format(var_0_4[1], var_1_6, var_1_7) or var_1_7 ~= 0 and string.format(var_0_4[2], var_1_7, var_1_8) or string.format(var_0_4[3], var_1_8)

	return (arg_1_2 or nil) and (arg_1_2 .. var_1_1 or L_TIME_REST2 .. L_TIME .. var_1_1)
end

function SupermarketLimitedTimePackageManager:ctor()
	SupermarketLimitedTimePackageManager.super.ctor(self)

	self._data = {}
	self._info = {}
	self._group = nil
	self._config = require("data.recharge_data")
end

function SupermarketLimitedTimePackageManager:getRuleId(arg_3_1)
	for iter_3_0, iter_3_1 in pairs((require("data.global_constants_data"))) do
		local var_3_0 = string.split(iter_3_1.value, "#")

		for iter_3_2 = 1, #var_3_0 do
			if tonumber(string.split(var_3_0[iter_3_2], "&")[1]) == arg_3_1 then
				return iter_3_1.id
			end
		end
	end
end

function SupermarketLimitedTimePackageManager:requestInfo(arg_4_1, arg_4_2)
	self.ruleId = self:getRuleId(arg_4_1)

	local var_4_0 = string.split(require("controller.GlobalConstantsManager"):getInstance():getValueById(self.ruleId), "#")

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = string.split(var_4_0[iter_4_0], "&")

		SupermarketLimitedTimePackageManager.SpecialGroup[tonumber(var_4_1[1])] = tonumber(var_4_1[2])
	end

	require("network.network"):rpc("get_recharge_info", {
		client = config.clientmode
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			self._group = arg_4_1

			local var_5_0 = {}

			for iter_5_0, iter_5_1 in pairs(arg_5_0.products) do
				if recharge_data[iter_5_1.id] and recharge_data[iter_5_1.id].group == arg_4_1 then
					table.insert(var_5_0, iter_5_1)
				end
			end

			table.sort(var_5_0, function(arg_6_0, arg_6_1)
				if arg_6_0.rmb ~= arg_6_1.rmb then
					return arg_6_0.rmb < arg_6_1.rmb
				else
					local var_6_0 = global_get_time_by_date(self._config[arg_6_0.id].starttime)
					local var_6_1 = global_get_time_by_date(self._config[arg_6_1.id].starttime)

					if var_6_0 and var_6_1 and var_6_0 ~= var_6_1 then
						return var_6_1 < var_6_0
					else
						return arg_6_0.id < arg_6_1.id
					end
				end
			end)

			if next(var_5_0) then
				self._info[arg_4_1] = var_5_0
			end

			self:handlerInfo(arg_5_0)

			if arg_4_2 then
				arg_4_2()
			end
		elseif arg_5_0.result == 2 then
			global_riseWord(L_RECHARGE_GET_INFO[2])
		elseif arg_5_0.result == 3 then
			global_riseWord(L_RECHARGE_GET_INFO[3])
		end
	end)
end

function SupermarketLimitedTimePackageManager:requestBuy(arg_7_1, arg_7_2)
	if self._info[self._group][arg_7_1] then
		local var_7_0, var_7_1 = self:canBuy(arg_7_1)

		if var_7_0 then
			local var_7_2 = self._info[self._group][arg_7_1]

			require("network.network"):rpc("get_recharge_items_drop", {
				id = self._info[self._group][arg_7_1].id
			}, function(arg_8_0)
				local function var_8_0(arg_9_0)
					if self._config[var_7_2.id].dropid_ext then
						if var_7_2.have_bought and var_7_2.buy_limit and var_7_2.have_bought >= var_7_2.buy_limit and var_7_2.have_bought_ext and var_7_2.have_bought_ext >= var_7_2.buy_limit then
							global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

							return
						end
					elseif var_7_2.have_bought and var_7_2.buy_limit and var_7_2.have_bought >= var_7_2.buy_limit then
						global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

						return
					end

					self:requestCheck(arg_7_1, arg_9_0)
				end

				if arg_7_2 then
					var_8_0()
				else
					arg_8_0.id = var_7_2.id
					arg_8_0.sureCallback = var_8_0

					LayerManager:pushInLayer("PopBuyRechargeLayer", arg_8_0, var_7_2)
				end
			end)
		elseif var_7_1 == SupermarketLimitedTimePackageManager.BUY_STATE.LOCK then
			global_ShowBlockWords(L_RECHARGE_BOUGHT_LOCK)
		elseif var_7_1 == SupermarketLimitedTimePackageManager.BUY_STATE.OWNED then
			-- block empty
		end
	end
end

function SupermarketLimitedTimePackageManager:requestCheck(arg_10_1, arg_10_2)
	local var_10_0 = self._info[self._group][arg_10_1]

	require("network.network"):rpc("check_recharge", {
		id = self._info[self._group][arg_10_1].id,
		client = config.clientmode
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			local playermodel = require("model.playermodel")

			AnalyticManager.clickPurchaseItem({
				product = var_10_0.id,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			require("controller.recharge_manager"):confirmPayment(var_10_0.id)

			if arg_10_2 then
				arg_10_2(arg_11_0)
			end
		elseif arg_11_0.result == 2 then
			print("测试模式")
		elseif arg_11_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_11_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_11_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_11_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function SupermarketLimitedTimePackageManager:requestReceiveAccumulatedRewards(arg_12_1)
	if self._info[self._group][arg_12_1].have_bought <= 0 then
		global_ShowBlockWords(L_SUPERMARKET_LIMITED_TIME_PACKAGE[1])

		return
	end

	if self._info[self._group][arg_12_1].logindays < self._config[self._info[self._group][arg_12_1].id].cum_days then
		global_ShowBlockWords(L_SUPERMARKET_LIMITED_TIME_PACKAGE[2] .. self._config[self._info[self._group][arg_12_1].id].cum_days - self._info[self._group][arg_12_1].logindays .. L_SUPERMARKET_LIMITED_TIME_PACKAGE[3])

		return
	end

	require("network.network"):rpc("get_returnback_recharge_loin_reward", {
		rechargeid = self._info[self._group][arg_12_1].id
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			global_gain(arg_13_0)

			self._info[self._group][arg_12_1].logindays = -1

			self:onReceiveAccumulatedRewardsSuccess()

			local var_13_0 = {
				bRed = false,
				group = self._group,
				type = self._info[self._group][arg_12_1].shop_type
			}

			for iter_13_0 = 1, #self._info[self._group] do
				if self:haveCumulativeReward(self._info[self._group][iter_13_0]) then
					var_13_0.bRed = true

					break
				end

				if self:haveDailyReward(self._info[self._group][iter_13_0]) then
					var_13_0.bRed = true

					break
				end
			end

			require("controller.supermarket_manager"):updateLimitedTimePackageReddot(var_13_0)
		elseif arg_13_0.result == 3 then
			global_ShowBlockWords(L_SUPERMARKET_LIMITED_TIME_PACKAGE[4])
		end
	end)
end

function SupermarketLimitedTimePackageManager:requestReceiveGiftDailyReward(arg_14_1)
	local var_14_0 = self._info[self._group][arg_14_1]

	if self._info[self._group][arg_14_1].have_bought <= 0 then
		global_ShowBlockWords(L_SUPERMARKET_LIMITED_TIME_PACKAGE[1])

		return
	end

	if var_14_0.logindays <= 0 then
		if var_14_0.manual_award then
			global_ShowBlockWords(L_MANAGE_MONEY_GET_REWARD[5])

			return
		end
	elseif not var_14_0.manual_award then
		global_ShowBlockWords(NIANSHOU_REWARD_WARN[3])

		return
	end

	require("network.network"):rpc("get_active_gift_daily_reward", {
		rechargeid = var_14_0.id
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			global_gain(arg_15_0)

			self._info[self._group][arg_14_1].manual_award = false

			self:onReceiveGiftDailyReward()

			local var_15_0 = {
				bRed = false,
				group = self._group,
				type = self._info[self._group][arg_14_1].shop_type
			}

			for iter_15_0 = 1, #self._info[self._group] do
				if self:haveCumulativeReward(self._info[self._group][iter_15_0]) then
					var_15_0.bRed = true

					break
				end

				if self:haveDailyReward(self._info[self._group][iter_15_0]) then
					var_15_0.bRed = true

					break
				end
			end

			require("controller.supermarket_manager"):updateLimitedTimePackageReddot(var_15_0)
		elseif arg_15_0.result == 2 then
			global_ShowBlockWords(NIANSHOU_REWARD_WARN[3])
		end
	end)
end

function SupermarketLimitedTimePackageManager:handlerInfo(arg_16_1)
	self:updateLayer()
end

function SupermarketLimitedTimePackageManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function SupermarketLimitedTimePackageManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function SupermarketLimitedTimePackageManager:haveCumulativeReward(arg_19_1)
	if self._config[arg_19_1.id].last_dropid and self._config[arg_19_1.id].cum_days <= arg_19_1.logindays then
		return true
	end

	return false
end

function SupermarketLimitedTimePackageManager:haveDailyReward(arg_20_1)
	if arg_20_1.manual_award then
		return true
	else
		return false
	end
end

function SupermarketLimitedTimePackageManager:getInfo()
	return self._info[self._group]
end

function SupermarketLimitedTimePackageManager:canBuy(arg_22_1)
	if self._info[self._group][arg_22_1].have_bought > 0 then
		return false, SupermarketLimitedTimePackageManager.BUY_STATE.OWNED
	else
		local var_22_0 = self._info[self._group][arg_22_1].pre_rechargeid

		if self._info[self._group][arg_22_1].pre_rechargeid then
			for iter_22_0, iter_22_1 in pairs(self._info[self._group]) do
				if var_22_0 == iter_22_1.id then
					if iter_22_1.have_bought > 0 then
						return true
					else
						return false, SupermarketLimitedTimePackageManager.BUY_STATE.LOCK
					end
				end
			end
		end
	end

	return true
end

function SupermarketLimitedTimePackageManager:getExtraGiftInfo()
	local function var_23_0(arg_24_0)
		local var_24_0 = require("controller.drop_manager"):getEquipAllDrops(arg_24_0)

		if var_24_0[1] then
			PopLayer:Item({
				hideGainButton = true,
				itemid = var_24_0[1].dropid
			})
		end
	end

	local var_23_1 = self._info[self._group]
	local var_23_2 = {}
	local var_23_3 = "#9b9bf7"
	local var_23_4 = 14

	if SupermarketLimitedTimePackageManager.SpecialGroup[self._group] then
		var_23_3 = "#ffffff"
		var_23_4 = 22
	end

	var_23_3 = var_0_2["fontColor_" .. self._group] or var_23_3

	for iter_23_0 = 1, #var_23_1 do
		local var_23_5 = var_23_1[iter_23_0].id

		if self._config[var_23_1[iter_23_0].id] then
			local var_23_6 = {}

			if self._config[var_23_1[iter_23_0].id].last_dropid then
				local var_23_7 = self._config[var_23_1[iter_23_0].id].cum_days
				local var_23_8 = {}

				var_23_8.typeImgName = "extra_type.png"
				var_23_8.receiveType = SupermarketLimitedTimePackageManager.ReceiveType.Accumulative

				function var_23_8.callBack()
					if var_23_1[iter_23_0].have_bought > 0 then
						if var_23_1[iter_23_0].logindays == -1 then
							var_23_0(self._config[var_23_5].last_dropid)
						elseif var_23_1[iter_23_0].logindays < var_23_7 then
							var_23_0(self._config[var_23_5].last_dropid)
						else
							self:requestReceiveAccumulatedRewards(iter_23_0)
						end
					else
						var_23_0(self._config[var_23_5].last_dropid)
					end
				end

				if SupermarketLimitedTimePackageManager.SpecialGroup[self._group] then
					var_23_8.btnImage = ""
					var_23_8.btnImage = var_23_1[iter_23_0].have_bought > 0 and (var_23_1[iter_23_0].logindays == -1 and "received_btn.png" or var_23_7 > var_23_1[iter_23_0].logindays and "discontent_btn.png" or "unreceived_btn.png") or "no_buy_btn.png"

					function var_23_8.btnCallBack()
						if var_23_1[iter_23_0].have_bought > 0 then
							if var_23_1[iter_23_0].logindays == -1 then
								global_ShowBlockWords(NIANSHOU_REWARD_WARN[3])
							elseif var_23_1[iter_23_0].logindays < var_23_7 then
								global_ShowBlockWords(string.format(L_SUPERMARKET_LIMITED_TIME_PACKAGE[5], var_23_7))
							else
								self:requestReceiveAccumulatedRewards(iter_23_0)
							end
						else
							self:requestBuy(iter_23_0, true)
						end
					end
				end

				if var_23_1[iter_23_0].have_bought > 0 then
					var_23_8.tipsStr = SupermarketLimitedTimePackageManager.SpecialGroup[self._group] and string.format(L_SUPERMARKET_LIMITED_TIME_PACKAGE[6], var_23_7) or string.format(L_SUPERMARKET_LIMITED_TIME_PACKAGE[5], var_23_7)
					var_23_8.tipsStrFontInfo = {
						font = FONT_NAME,
						size = var_23_4,
						color = var_23_3
					}
					var_23_8.imgName = self.ruleId == 11 and "reward.png" or var_23_1[iter_23_0].logindays == -1 and "reward_received" .. var_23_1[iter_23_0].id .. ".png" or var_23_7 > var_23_1[iter_23_0].logindays and "reward_buy" .. var_23_1[iter_23_0].id .. ".png" or "reward_unreceived" .. var_23_1[iter_23_0].id .. ".png"
				else
					var_23_8.tipsStr = SupermarketLimitedTimePackageManager.SpecialGroup[self._group] and string.format(L_SUPERMARKET_LIMITED_TIME_PACKAGE[6], var_23_7) or string.format(L_SUPERMARKET_LIMITED_TIME_PACKAGE[5], var_23_7)
					var_23_8.tipsStrFontInfo = {
						font = FONT_NAME,
						size = var_23_4,
						color = var_23_3
					}
					var_23_8.imgName = self.ruleId == 11 and "reward_no_buy.png" or "reward_no_buy" .. var_23_1[iter_23_0].id .. ".png"
				end

				var_23_6[#var_23_6 + 1] = var_23_8
			end

			if self._config[var_23_1[iter_23_0].id].dropid then
				local var_23_9 = {}

				var_23_9.typeImgName = "sustained_type.png"
				var_23_9.receiveType = SupermarketLimitedTimePackageManager.ReceiveType.DailyDistribution
				var_23_9.imgName = "reward_sustained.png"
				var_23_9.tipsStr = L_SUPERMARKET_LIMITED_TIME_PACKAGE[7]

				if self._config[var_23_1[iter_23_0].id].expiry_day then
					var_23_9.tipsStr = string.format(var_23_9.tipsStr, self._config[var_23_1[iter_23_0].id].expiry_day)
				end

				var_23_9.tipsStrFontInfo = {
					font = FONT_NAME,
					size = var_23_4,
					color = var_23_3
				}

				function var_23_9.callBack()
					var_23_0(self._config[var_23_5].dropid)
				end

				var_23_6[#var_23_6 + 1] = var_23_9
			end

			if self._config[var_23_1[iter_23_0].id].dailyDropid then
				local var_23_10 = {
					receiveType = SupermarketLimitedTimePackageManager.ReceiveType.ManualDaily
				}

				var_23_10.typeImgName = "daily_sustained_type.png"
				var_23_10.imgName = ""
				var_23_10.tipsStr = L_SUPERMARKET_LIMITED_TIME_PACKAGE[8] .. "%d/%d"

				if self._config[var_23_1[iter_23_0].id].daily_expiry_day then
					local var_23_12 = self._config[var_23_1[iter_23_0].id].daily_expiry_day - ((var_23_1[iter_23_0].logindays == -1 or nil) and self._config[var_23_1[iter_23_0].id].daily_expiry_day)

					if var_23_1[iter_23_0].manual_award then
						var_23_12 = var_23_12 + 1
					end

					var_23_10.tipsStr = string.format(var_23_10.tipsStr, var_23_12, self._config[var_23_1[iter_23_0].id].daily_expiry_day)
				end

				var_23_10.tipsStrFontInfo = {
					font = FONT_NAME,
					size = var_23_4,
					color = var_23_3
				}

				function var_23_10.callBack()
					var_23_0(self._config[var_23_5].dailyDropid)
				end

				var_23_10.imgName = self.ruleId == 11 and "daily_reward.png" or var_23_1[iter_23_0].have_bought > 0 and (var_23_1[iter_23_0].manual_award and "daily_reward_unreceived" .. var_23_1[iter_23_0].id .. ".png" or var_23_1[iter_23_0].logindays == 0 and "daily_reward_received" .. var_23_1[iter_23_0].id .. ".png" or "daily_reward_received" .. var_23_1[iter_23_0].id .. ".png") or "daily_reward_no_buy" .. var_23_1[iter_23_0].id .. ".png"

				if SupermarketLimitedTimePackageManager.SpecialGroup[self._group] then
					var_23_10.btnImage = ""
					var_23_10.btnImage = var_23_1[iter_23_0].have_bought > 0 and (var_23_1[iter_23_0].logindays == 0 and "next_day_btn.png" or var_23_1[iter_23_0].manual_award and "unreceived_btn.png" or "received_btn.png") or "no_buy_btn.png"

					function var_23_10.btnCallBack()
						if var_23_1[iter_23_0].have_bought > 0 then
							if var_23_1[iter_23_0].logindays == 0 then
								global_ShowBlockWords(L_MANAGE_MONEY_GET_REWARD[5])
							elseif var_23_1[iter_23_0].manual_award then
								self:requestReceiveGiftDailyReward(iter_23_0)
							else
								global_ShowBlockWords(NIANSHOU_REWARD_WARN[3])
							end
						else
							self:requestBuy(iter_23_0, true)
						end
					end
				end

				var_23_6[#var_23_6 + 1] = var_23_10
			end

			table.sort(var_23_6, function(arg_30_0, arg_30_1)
				return arg_30_0.receiveType < arg_30_1.receiveType
			end)

			var_23_2[iter_23_0] = var_23_6
		end
	end

	return var_23_2
end

function SupermarketLimitedTimePackageManager:onReceiveAccumulatedRewardsSuccess()
	if self.layer then
		self.layer:receiveAccumulatedRewardsSuccess()
	end
end

function SupermarketLimitedTimePackageManager:buySuccess(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self._info[self._group]) do
		if iter_32_1.id == arg_32_1.id then
			iter_32_1.remain = arg_32_1.remain or iter_32_1.remain
			iter_32_1.logindays = arg_32_1.logindays or iter_32_1.logindays
			iter_32_1.have_bought = iter_32_1.have_bought + 1

			break
		end
	end

	if self.layer then
		self.layer:buySuccess()
	end
end

function SupermarketLimitedTimePackageManager:getCurCanBuyIndex()
	for iter_33_0 = 1, #self._info[self._group] do
		if self:canBuy(iter_33_0) then
			return iter_33_0
		end
	end

	return nil
end

function SupermarketLimitedTimePackageManager:onReceiveGiftDailyReward()
	if self.layer then
		self.layer:onReceiveGiftDailyReward()
	end
end

function SupermarketLimitedTimePackageManager:haveBuyGift()
	for iter_35_0 = 1, #self._info[self._group] do
		if self._info[self._group][iter_35_0].have_bought > 0 then
			return true
		end
	end

	return false
end

function SupermarketLimitedTimePackageManager:getFinishTime()
	for iter_36_0 = 1, #self._info[self._group] do
		if self._info[self._group][iter_36_0].finishtime then
			return self._info[self._group][iter_36_0].finishtime
		end
	end

	return nil
end

function SupermarketLimitedTimePackageManager:getFinishTimeShowString()
	local var_37_0 = self:getFinishTime()

	if var_37_0 then
		return (var_0_5(var_37_0, require("controller.time_check_manager"):getCurTime()))
	end

	return nil
end

function SupermarketLimitedTimePackageManager:canShowFinishTimeString()
	if self:haveBuyGift() then
		return false
	end

	if not self:getFinishTimeShowString() then
		return false
	end

	return true
end

function SupermarketLimitedTimePackageManager:getSpecialPacksInfo(arg_39_1)
	require("network.network"):rpc("get_special_packs_info", nil, function(arg_40_0)
		if arg_40_0.result == 1 and arg_39_1 then
			arg_39_1(arg_40_0)
		end
	end)
end

return SupermarketLimitedTimePackageManager
