local birthday_party_data = require("data.birthday_party_data")
local BirthdayPartyManager = class("BirthdayPartyManager")
local time_check_manager = require("controller.time_check_manager")
local shop_manager = require("controller.shop_manager")
local shop_data = require("data.shop_data")
local network = require("network.network")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local level_manager = require("controller.level_manager")
local item_manager = require("controller.item_manager")
local activity_entrance_data = require("data.activity_entrance_data")
local account_manager = require("controller.account_manager")
local servant_data = require("data.servant_data")
local favorfile_data = require("data.favorfile_data")
local dropcache_manager = require("controller.dropcache_manager")
local var_0_17 = require("data.item_data")

function BirthdayPartyManager:init(arg_1_1)
	self.birthdayPartyInfo = {}

	self:requestBirthdayPartyInfo(arg_1_1)
end

function BirthdayPartyManager:requestBirthdayPartyInfo(arg_2_1)
	local var_2_0 = account_manager:getChannel()

	shop_manager:get_shop_data(self:getShopType(), function(arg_3_0)
		self.marketList = arg_3_0

		self:initBirthdayPartyInfo()

		if type(arg_2_1) == "function" then
			arg_2_1()
		end
	end)
end

function BirthdayPartyManager:initBirthdayPartyInfo(arg_4_1)
	arg_4_1 = arg_4_1 or birthday_party_data

	local var_4_0 = time_check_manager:getCurTime()
	local var_4_1 = os.date("*t", var_4_0)

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_2

		for iter_4_2, iter_4_3 in pairs(self.marketList) do
			if iter_4_3.shopid == iter_4_1.shop_id then
				var_4_2 = iter_4_3

				break
			end
		end

		local var_4_4 = false

		if var_4_2 ~= nil then
			string.gsub(string.split(var_4_2.start_time, " ")[1], "-", "/")
			string.gsub(string.split(var_4_2.finish_time, " ")[1], "-", "/")

			shop1price = var_4_2.price

			if var_4_2.buy_limit > var_4_2.have_bought then
				var_4_4 = true
			end
		end

		local var_4_8 = iter_4_1.mainmidoffset and string.split(iter_4_1.mainmidoffset, ",") or nil
		local var_4_10

		if var_4_8 then
			var_4_10 = cc.p(var_4_8[1] or 0, var_4_8[2] or 0) or cc.p(0, 0)
		end

		local var_4_11 = 0
		local var_4_12 = false
		local var_4_13 = activity_entrance_data[tonumber(iter_4_1.into_twist)]

		if var_4_13 == nil then
			var_4_11 = 0
		end

		local var_4_14 = not not var_4_13
		local var_4_15 = var_4_13 and var_4_13.jump
		local var_4_16 = global_get_time_by_date(var_4_13 and var_4_13.starttime)
		local var_4_17 = global_get_time_by_date(var_4_13 and var_4_13.finishtime)

		if var_4_16 <= var_4_0 and var_4_0 <= var_4_17 then
			var_4_12 = true
			var_4_11 = 2
		elseif var_4_0 < var_4_16 then
			var_4_11 = 1
		elseif var_4_17 < var_4_0 then
			var_4_11 = 3
		end

		local var_4_18 = var_4_13 and string.gsub(string.split(var_4_13.starttime, " ")[1], "-", "/") or ""

		if not var_4_13 or not string.gsub(string.split(var_4_13.finishtime, " ")[1], "-", "/") then
			-- block empty
		end

		local var_4_20 = string.gsub(string.split(iter_4_1.battlestatus_starttime, " ")[1], "-", "/") or ""
		local var_4_21 = string.gsub(string.split(iter_4_1.battlestatus_finishtime, " ")[1], "-", "/") or ""
		local var_4_22 = "霓昂"
		local var_4_23 = "10.24"

		if model_data[iter_4_1.model] then
			var_4_22 = model_data[iter_4_1.model].name_Q
			var_4_23 = favorfile_data[11][model_data[iter_4_1.model].photofile_model]
		end

		local var_4_24 = false
		local var_4_25 = self:getShopInfoById(iter_4_1.shop_id)

		if var_4_25 and var_4_25.discount < var_4_25.price then
			var_4_24 = true
		end

		local var_4_26 = false
		local var_4_27, var_4_28 = var_4_23:match("(%d+)月(%d+)日")
		local var_4_29 = global_get_time_by_date((string.format("%d-%s-%s 23:59:59", var_4_1.year, var_4_27, var_4_28)))

		if global_get_time_by_date((string.format("%d-%s-%s 00:00:00", var_4_1.year, var_4_27, var_4_28))) <= var_4_0 and var_4_0 <= var_4_29 then
			var_4_26 = true
		end

		local var_4_30 = iter_4_1.porpertyoffset and string.split(iter_4_1.porpertyoffset, ",") or nil
		local var_4_32

		if var_4_30 then
			var_4_32 = cc.p(var_4_30[1] or 0, var_4_30[2] or 0) or cc.p(0, 0)
		end

		local var_4_33 = {
			isCanSwitchLeft = 1,
			isCanSwitchRight = 1,
			id = iter_4_1.id,
			twiggestEggId = var_4_15,
			shopId1 = iter_4_1.shop_id,
			modelId = iter_4_1.model
		}

		var_4_33.readType = iter_4_1.read_type or 1
		var_4_33.name = var_4_22
		var_4_33.starttime = iter_4_1.starttime
		var_4_33.finishtime = iter_4_1.finishtime
		var_4_33.shop1price = shop1price
		var_4_33.shop1iscanbuy = var_4_4
		var_4_33.spineScale = iter_4_1.modelscale or 1
		var_4_33.spinePos = var_4_10
		var_4_33.sort = iter_4_1.id
		var_4_33.battlestatus = iter_4_1.battlestatus
		var_4_33.eggisunlock = var_4_12
		var_4_33.unlocklevel = var_4_18
		var_4_33.eggishave = var_4_14
		var_4_33.battleFiledTime = var_4_20 .. "-" .. var_4_21
		var_4_33.battleFiledStartTime = global_get_time_by_date(iter_4_1.battlestatus_starttime)
		var_4_33.battleFiledEndTime = global_get_time_by_date(iter_4_1.battlestatus_finishtime)
		var_4_33.istodaybirthday = var_4_26
		var_4_33.birthdayEndTime = var_4_29
		var_4_33.eggstatus = var_4_11
		var_4_33.birth = var_4_23
		var_4_33.monthid = iter_4_1.monthid
		var_4_33.ishavediscount = var_4_24
		var_4_33.porpertyoffset = var_4_32

		table.insert(self.birthdayPartyInfo, var_4_33)
	end

	if #self.birthdayPartyInfo > 0 then
		table.sort(self.birthdayPartyInfo, function(arg_5_0, arg_5_1)
			return arg_5_0.sort < arg_5_1.sort
		end)

		for iter_4_4 = 1, #self.birthdayPartyInfo do
			self.birthdayPartyInfo[iter_4_4].index = iter_4_4
		end

		self.birthdayPartyInfo[1].isCanSwitchLeft = 0
		self.birthdayPartyInfo[#self.birthdayPartyInfo].isCanSwitchRight = 0
	end
end

function BirthdayPartyManager:getCurBirthdayCongratulationStatus(arg_6_1)
	local var_6_0 = BIRTHDAY_PARTY.CongratulationStatus.NOT_START
	local var_6_1 = arg_6_1.birthday or "2021-08-23"
	local var_6_2 = arg_6_1.lastcongratulationtime
	local var_6_3 = os.date("*t", time_check_manager:getCurTime())
	local var_6_4 = string.format("%04d-%02d-%02d", var_6_3.year, var_6_3.month, var_6_3.day)

	if arg_6_1.lastcongratulationtime == 0 then
		if var_6_1 <= var_6_4 then
			var_6_0 = BIRTHDAY_PARTY.CongratulationStatus.CAN_USE
		elseif var_6_4 < var_6_1 then
			var_6_0 = BIRTHDAY_PARTY.CongratulationStatus.NOT_START
		end
	elseif var_6_1 <= var_6_4 and var_6_2 < var_6_1 then
		var_6_0 = BIRTHDAY_PARTY.CongratulationStatus.CAN_USE
	elseif var_6_1 <= var_6_4 and var_6_1 <= var_6_2 then
		var_6_0 = BIRTHDAY_PARTY.CongratulationStatus.HAVE_UESD
	elseif var_6_4 < var_6_1 then
		var_6_0 = BIRTHDAY_PARTY.CongratulationStatus.NOT_START
	end

	return var_6_0
end

function BirthdayPartyManager:getBirthdayPartyInfo(arg_7_1)
	if arg_7_1 == nil then
		return self.birthdayPartyInfo
	else
		return self.birthdayPartyInfo[arg_7_1]
	end
end

function BirthdayPartyManager:isCanSwitch()
	return false
end

local function var_0_18(arg_9_0)
	if not arg_9_0 then
		return
	end

	if arg_9_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_9_0 / 86400), math.floor(arg_9_0 % 86400 / 3600))
	elseif arg_9_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_9_0 / 3600), math.floor(arg_9_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_9_0 / 60))
	end
end

function BirthdayPartyManager:getLeftTimeStr(arg_10_1)
	local var_10_1 = time_check_manager:getCurTime()
	local var_10_2

	if self.birthdayPartyInfo[arg_10_1] then
		var_10_2 = self.birthdayPartyInfo[arg_10_1].finishtime or ""

		if var_10_2 == "" then
			return
		end
	end

	local var_10_3 = global_get_time_by_date(var_10_2) - var_10_1

	return (var_10_3 > 0 or nil) and var_0_18(var_10_3)
end

function BirthdayPartyManager:getBirthdayPartyInfoLength()
	return #self.birthdayPartyInfo
end

function BirthdayPartyManager:getShopInfoById(arg_12_1)
	if self.marketList == nil or arg_12_1 == nil then
		return nil
	end

	local var_12_0

	for iter_12_0, iter_12_1 in pairs(self.marketList) do
		if iter_12_1.shopid == arg_12_1 then
			var_12_0 = iter_12_1

			break
		end
	end

	return var_12_0
end

function BirthdayPartyManager:getShopType()
	return 15
end

function BirthdayPartyManager:useBirthdayPartyBarrage(arg_14_1, arg_14_2)
	network:rpc("birthday_party_use_barrage", arg_14_1, function(arg_15_0)
		if arg_15_0.result == 1 then
			if type(arg_14_2) == "function" then
				arg_14_2(arg_15_0)
			end
		elseif arg_15_0.result == 2 then
			global_ShowBlockWords("大弹幕道具不足")
		elseif arg_15_0.result == 3 then
			global_ShowBlockWords("小弹幕道具不足")
		elseif arg_15_0.result == 4 then
			global_ShowBlockWords("道具使用出错")
		end
	end)
end

function BirthdayPartyManager:getServantBirthdayFiledStatus(arg_16_1)
	local var_16_0 = time_check_manager:getCurTime()
	local var_16_1

	for iter_16_0, iter_16_1 in pairs(self.birthdayPartyInfo) do
		if type(iter_16_1) == "table" then
			assert(model_data[iter_16_1.modelId], " modelData is nil,curModelId is" .. iter_16_1.modelId)

			local var_16_2 = {}

			for iter_16_2, iter_16_3 in pairs(servant_data) do
				if iter_16_3.major == model_data[iter_16_1.modelId].major then
					table.insert(var_16_2, iter_16_3)
				end
			end

			for iter_16_4, iter_16_5 in pairs(var_16_2) do
				if iter_16_5.id == arg_16_1 and iter_16_1.battleFiledStartTime <= var_16_0 and var_16_0 <= iter_16_1.battleFiledEndTime then
					var_16_1 = iter_16_1.battlestatus

					break
				end
			end
		end

		if var_16_1 ~= nil then
			break
		end
	end

	return var_16_1
end

function BirthdayPartyManager:isHaveBirthdayPartyEffect()
	local var_17_0 = time_check_manager:getCurTime()
	local var_17_1 = false
	local var_17_2 = type(FightManager.getPlayerConf) == "function" and FightManager:getPlayerConf()

	if type(var_17_2) == "table" then
		for iter_17_0, iter_17_1 in pairs(var_17_2) do
			if iter_17_1.servantid then
				if self.birthdayPartyInfo then
					for iter_17_2, iter_17_3 in pairs(self.birthdayPartyInfo) do
						if type(iter_17_3) == "table" then
							local var_17_3 = {}

							for iter_17_4, iter_17_5 in pairs(servant_data) do
								if iter_17_5.major == model_data[iter_17_3.modelId].major then
									table.insert(var_17_3, iter_17_5)
								end
							end

							for iter_17_6, iter_17_7 in pairs(var_17_3) do
								if iter_17_7.id == iter_17_1.servantid and iter_17_3.battleFiledStartTime <= var_17_0 and var_17_0 <= iter_17_3.battleFiledEndTime then
									var_17_1 = true

									break
								end
							end
						end

						if var_17_1 == true then
							break
						end
					end
				end

				if var_17_1 == true then
					break
				end
			end
		end
	end

	return var_17_1
end

function BirthdayPartyManager:getBarrageItemInfo()
	self.barrageItemInfo = {}
	self.barrageItemInfo[101100001] = item_manager:getItemNumber(101100001)
	self.barrageItemInfo[101100002] = item_manager:getItemNumber(101100002)

	return self.barrageItemInfo
end

function BirthdayPartyManager:getBirthdayPartyBattleFiled()
	return #self.birthdayPartyInfo > 0 and self.birthdayPartyInfo[1].battlestatus
end

function BirthdayPartyManager:getLastNearBirthdayIndex()
	local var_20_0
	local var_20_1 = time_check_manager:getCurTime()
	local var_20_2

	for iter_20_0 = 1, #self.birthdayPartyInfo do
		if var_20_1 <= self.birthdayPartyInfo[iter_20_0].birthdayEndTime then
			if var_20_2 == nil then
				var_20_2 = self.birthdayPartyInfo[iter_20_0].birthdayEndTime - var_20_1
				var_20_0 = iter_20_0
			elseif var_20_2 > self.birthdayPartyInfo[iter_20_0].birthdayEndTime - var_20_1 then
				var_20_2 = self.birthdayPartyInfo[iter_20_0].birthdayEndTime - var_20_1
				var_20_0 = iter_20_0
			end
		end
	end

	return var_20_0
end

function BirthdayPartyManager:getTodayBirthdayIndex()
	local var_21_0
	local var_21_1 = time_check_manager:getCurTime()
	local var_21_2

	for iter_21_0 = 1, #self.birthdayPartyInfo do
		if self.birthdayPartyInfo[iter_21_0].istodaybirthday == true then
			if var_21_2 == nil then
				var_21_2 = var_21_1 - self.birthdayPartyInfo[iter_21_0].battleFiledStartTime
				var_21_0 = iter_21_0
			elseif var_21_2 > var_21_1 - self.birthdayPartyInfo[iter_21_0].battleFiledStartTime then
				var_21_2 = var_21_1 - self.birthdayPartyInfo[iter_21_0].battleFiledStartTime
				var_21_0 = iter_21_0
			end
		end
	end

	return var_21_0
end

function BirthdayPartyManager:getTodayBirthdayEntracePath(arg_22_1)
	local var_22_0 = ""

	self:init(function()
		local var_23_0 = self:getTodayBirthdayIndex()

		if var_23_0 ~= nil then
			var_22_0 = "mainScenebg/birthdayparty/entrance/entrance" .. self.birthdayPartyInfo[var_23_0].id .. ".png" or "mainScenebg/activity/birthday/birthday.png"
		end

		if type(arg_22_1) == "function" then
			arg_22_1(var_22_0)
		end
	end)
end

function BirthdayPartyManager:do_congratulations(arg_24_1, arg_24_2)
	local var_24_0 = self:getBirthdayPartyInfo(arg_24_1)
	local var_24_1 = model_data[var_24_0.modelId]

	assert(model_data[var_24_0.modelId], string.format("curModelData is nil,the modelId is %s", var_24_0.modelId))

	if var_24_0.congratulationstatus == BIRTHDAY_PARTY.CongratulationStatus.NOT_START then
		global_ShowBlockWords("还没有到" .. model_data[var_24_0.modelId].name .. "的生日哦！")

		return
	elseif var_24_0.congratulationstatus == BIRTHDAY_PARTY.CongratulationStatus.HAVE_UESD then
		global_ShowBlockWords("已经祝贺过" .. model_data[var_24_0.modelId].name .. "啦！")

		return
	end

	network:rpc("birthdayparty_do_congratulations", {
		itemid = var_24_0.id
	}, function(arg_25_0)
		if arg_25_0.result == 1 then
			local var_25_0 = self:dealWithDropData(arg_25_0.drop)

			if var_25_0.items and #var_25_0.items > 0 then
				LayerManager:pushInLayer("PopPurchaseResultLayer", {
					items = var_25_0.items
				})
			end

			var_24_0.congratulationstatus = BIRTHDAY_PARTY.CongratulationStatus.HAVE_UESD

			if type(arg_24_2) == "function" then
				arg_24_2()
			end
		elseif arg_25_0.result == 2 then
			global_ShowBlockWords("还没有到" .. var_24_1.name .. "的生日哦！")
		elseif arg_25_0.result == 3 then
			global_ShowBlockWords("已经祝贺过" .. var_24_1.name .. "啦！")
		end
	end)
end

function BirthdayPartyManager:isNeedShowRedDot()
	local var_26_0 = false

	for iter_26_0, iter_26_1 in pairs(self.birthdayPartyInfo) do
		if iter_26_1.congratulationstatus == BIRTHDAY_PARTY.CongratulationStatus.CAN_USE then
			var_26_0 = true

			break
		end
	end

	return var_26_0
end

function BirthdayPartyManager:dealWithDropData(arg_27_1)
	local var_27_0 = {}

	if arg_27_1.gold and arg_27_1.gold > 0 then
		playermodel.gold = playermodel.gold + arg_27_1.gold

		table.insert(var_27_0, {
			entityid = "gold",
			dropNum = arg_27_1.gold
		})
	end

	if arg_27_1.items then
		for iter_27_0, iter_27_1 in pairs(arg_27_1.items) do
			dropcache_manager:insertItemCache(iter_27_1)
		end
	end

	if arg_27_1.gainitems then
		for iter_27_2, iter_27_3 in pairs(arg_27_1.gainitems) do
			local var_27_2 = {}
			local var_27_3 = item_manager:setItemByServerItem(iter_27_3)

			var_27_2.entityid = iter_27_3.entityid
			var_27_2.dropNum = var_27_3
			var_27_2.number = var_27_3

			if var_27_3 > 0 then
				table.insert(var_27_0, var_27_2)
			end

			if var_0_17[iter_27_3.itemid].bag_item_type == kITEM_HERO or var_0_17[iter_27_3.itemid].bag_item_type == kITEM_SKIN then
				require("view.Layer.GetRoleAnimationLayer")

				local var_27_4 = GetRoleAnimationLayer:create(iter_27_3.itemid)

				if not var_27_4:getParent() then
					global_basic_scene:addChild(var_27_4, 999)
				end
			end
		end
	end

	if arg_27_1.sp then
		playermodel.strengthpoint = playermodel.strengthpoint + arg_27_1.sp

		global_update_strengthpoint(true)
		AlertManager:check_servant_strenghth(true)
	end

	if arg_27_1.honor and arg_27_1.honor > 0 then
		playermodel.honor = playermodel.honor + arg_27_1.honor
	end

	if arg_27_1.diamond then
		playermodel.diamond = playermodel.diamond + arg_27_1.diamond

		global_update_gold_stone_diamond(nil, nil, arg_27_1.diamond)
	end

	return {
		gold = arg_27_1.gold,
		diamond = arg_27_1.diamond,
		honor = arg_27_1.honor,
		score = arg_27_1.score,
		items = var_27_0
	}
end

function BirthdayPartyManager:isOpenBirthdayParty()
	local var_28_0 = false

	for iter_28_0, iter_28_1 in pairs((require("controller.activity_manager"):getActivityEntranceList())) do
		if iter_28_0 == ACTIVITY_BIRTHDAYPARTY_ENTRANCE_ID then
			var_28_0 = true

			break
		end
	end

	return var_28_0
end

return BirthdayPartyManager
