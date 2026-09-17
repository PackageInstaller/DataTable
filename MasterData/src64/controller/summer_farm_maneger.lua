local network = require("network.network")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_3 = {
	"watermelon_",
	"strawberry_",
	"grape_",
	"pineapple_"
}
local var_0_4 = {}
local var_0_5 = {}
local farmplant_data = require("data.farmplant_data")

for iter_0_0, iter_0_1 in pairs((require("data.farmlevel_data"))) do
	iter_0_1.level = iter_0_1.group_order

	table.insert(var_0_4, iter_0_1)
end

for iter_0_2 = 1, 4 do
	local var_0_7 = {}
	local var_0_8 = {}
	local var_0_9 = {}
	local var_0_10 = {}
	local var_0_11 = {}
	local var_0_12 = 0

	for iter_0_3, iter_0_4 in pairs(farmplant_data) do
		if iter_0_2 == iter_0_4.plant_group_id then
			var_0_7[iter_0_4.plant_level] = iter_0_4.levelup_need_exp
			var_0_8[iter_0_4.plant_level] = iter_0_4.growup_need_times
			var_0_9[iter_0_4.plant_level] = iter_0_4.reward_num
			var_0_10[iter_0_4.plant_level] = iter_0_4.harvest_exp
			var_0_11[iter_0_4.plant_level] = iter_0_4.extra_drop_rate or 0
			var_0_12 = iter_0_4.unlocked_level % 72200
		end
	end

	var_0_5[iter_0_2] = {
		levelup_need_exp = var_0_7,
		growup_need_times = var_0_8,
		reward_num = var_0_9,
		harvest_exp = var_0_10,
		unlocked_level = var_0_12,
		extra_drop_rate = var_0_11
	}
end

summerFarmManager = {}

function summerFarmManager.initData(arg_1_0)
	arg_1_0.UIRef = nil
	arg_1_0.level = 0
	arg_1_0.score = 0
	arg_1_0.remainTime = 0
	arg_1_0.maxscore = 0
	arg_1_0.soils = {}
	arg_1_0.plantInfo = {}
	arg_1_0.ordersInfo = {}
	arg_1_0.isPlayAni = false
end

function summerFarmManager:loadData(arg_2_1)
	self.level = 1
	self.score = 0

	for iter_2_0 = 1, 4 do
		self.plantInfo[iter_2_0] = {
			warehouseNum = 0,
			exp = 0,
			level = 1,
			locked = self.level < var_0_5[iter_2_0].unlocked_level,
			needTime = var_0_5[iter_2_0].growup_need_times[1],
			levelup_need_exp = var_0_5[iter_2_0].levelup_need_exp[1],
			rewardNum = var_0_5[iter_2_0].reward_num[1],
			harvest_exp = var_0_5[iter_2_0].harvest_exp[1],
			extra_drop_rate = var_0_5[iter_2_0].extra_drop_rate[1]
		}
	end

	self:loadLevelData(self.level)
end

function summerFarmManager:loadLevelData(arg_3_1)
	local var_3_0 = {
		0,
		0,
		0,
		0
	}

	for iter_3_0, iter_3_1 in pairs(self.ordersInfo) do
		var_3_0[iter_3_1.type] = iter_3_1.num
	end

	self.ordersInfo = {}

	local var_3_1 = {}
	local var_3_2

	for iter_3_2, iter_3_3 in ipairs(var_0_4) do
		if iter_3_3.level == arg_3_1 and not iter_3_3.infinite_level then
			table.insert(var_3_1, iter_3_3)
		end

		if iter_3_3.infinite_level and iter_3_3.infinite_level == 1 then
			var_3_2 = iter_3_3
		end
	end

	local var_3_3 = math.random(#var_3_1)

	if #var_3_1 == 0 then
		var_3_1 = {
			{
				times = var_3_2.times,
				watermelon_num = var_3_0[1],
				watermelon_rand = var_3_2.watermelon_rand,
				strawberry_num = var_3_0[2],
				strawberry_rand = var_3_2.strawberry_rand,
				grape_num = var_3_0[3],
				grape_rand = var_3_2.grape_rand,
				pineapple_num = var_3_0[4],
				pineapple_rand = var_3_2.pineapple_rand
			}
		}
	end

	for iter_3_4, iter_3_5 in ipairs(var_0_3) do
		if var_3_1[var_3_3][iter_3_5 .. "num"] then
			local var_3_4 = var_3_1[var_3_3][iter_3_5 .. "rand"] and var_3_1[var_3_3][iter_3_5 .. "rand"] ~= 0 and math.random(var_3_1[var_3_3][iter_3_5 .. "rand"]) or 0

			if var_3_1[var_3_3][iter_3_5 .. "num"] + var_3_4 > 0 then
				table.insert(self.ordersInfo, {
					type = iter_3_4,
					num = var_3_1[var_3_3][iter_3_5 .. "num"] + var_3_4
				})
			end
		end
	end

	self.remainTime = var_3_1[var_3_3].times
end

function summerFarmManager.registeredUIRef(arg_4_0, arg_4_1)
	arg_4_0.UIRef = arg_4_1
end

function summerFarmManager:clickOrderFinishHandle()
	if self.isPlayAni then
		return
	end

	if self:checkOrderFinished() then
		audio_manager:playeffectMusicTest("sound/farm_victory")

		self.level = self.level + 1

		local var_5_0 = 0

		for iter_5_0, iter_5_1 in ipairs(self.ordersInfo) do
			var_5_0 = var_5_0 + self.plantInfo[iter_5_1.type].level * iter_5_1.num
			self.plantInfo[iter_5_1.type].warehouseNum = self.plantInfo[iter_5_1.type].warehouseNum - iter_5_1.num
		end

		for iter_5_2 = 1, 4 do
			if not self.plantInfo[iter_5_2].locked then
				self.plantInfo[iter_5_2].exp = self.plantInfo[iter_5_2].exp + self.remainTime

				while self.plantInfo[iter_5_2].exp >= self.plantInfo[iter_5_2].levelup_need_exp do
					if self.plantInfo[iter_5_2].level >= #var_0_5[iter_5_2].growup_need_times then
						break
					end

					self.plantInfo[iter_5_2].level = self.plantInfo[iter_5_2].level + 1
					self.plantInfo[iter_5_2].needTime = var_0_5[iter_5_2].growup_need_times[self.plantInfo[iter_5_2].level]
					self.plantInfo[iter_5_2].levelup_need_exp = var_0_5[iter_5_2].levelup_need_exp[self.plantInfo[iter_5_2].level]
					self.plantInfo[iter_5_2].rewardNum = var_0_5[iter_5_2].reward_num[self.plantInfo[iter_5_2].level]
					self.plantInfo[iter_5_2].harvest_exp = var_0_5[iter_5_2].harvest_exp[self.plantInfo[iter_5_2].level]
					self.plantInfo[iter_5_2].extra_drop_rate = var_0_5[iter_5_2].extra_drop_rate[self.plantInfo[iter_5_2].level]
				end
			end

			self.plantInfo[iter_5_2].locked = self.level < var_0_5[iter_5_2].unlocked_level

			self.UIRef:updatePlantSelectPanel(self.plantInfo[iter_5_2], iter_5_2)
		end

		self.score = self.score + var_5_0 * (10 + self.remainTime)

		network:rpc("activity_update_farm_info", {
			activityid = 722,
			harvestTimes = 0,
			finished = 1,
			score = self.score
		}, function(arg_6_0)
			return
		end)
		self:loadLevelData(self.level)
		self.UIRef:updateUI()
		self.UIRef:initOrders(self.ordersInfo)
		self.UIRef:initNextLevelPanel(self.ordersInfo)
		self:saveLocalData()
	else
		if self.remainTime <= 0 then
			if not self:checkGameFailed() then
				global_ShowBlockWords("订单还未完成,还有作物没有收获哦！")
			end

			return
		end

		global_ShowBlockWords("订单还未完成哦！")
	end
end

function summerFarmManager:checkOrderFinished()
	for iter_7_0, iter_7_1 in ipairs(self.ordersInfo) do
		if iter_7_1.num > self.plantInfo[iter_7_1.type].warehouseNum then
			return false
		end
	end

	return true
end

function summerFarmManager:plantHandle(arg_8_1, arg_8_2)
	if self.isPlayAni then
		return
	end

	if self.soils[arg_8_1].plant then
		return
	end

	self.isPlayAni = true

	self.UIRef.seedAni:setVisible(true)
	self.UIRef.seedAni:setPosition(self.soils[arg_8_1].soil:getPosition())
	self.UIRef.seedAni:setAnimation(0, "seed", false)
	audio_manager:playeffectMusicTest("sound/farm_act")
	self.UIRef.seedAni:registerSpineEventHandler(function()
		self:timeReduce()

		self.soils[arg_8_1].plant = arg_8_2
		self.soils[arg_8_1].growTimes = 0
		self.soils[arg_8_1].rewardNeedTimes = self.plantInfo[arg_8_2].needTime

		self.soils[arg_8_1].soil:updateSoil(self.soils[arg_8_1])
		self.UIRef.seedAni:setVisible(false)

		self.isPlayAni = false

		self:checkGameFailed()
	end, SP_ANIMATION_COMPLETE)
end

function summerFarmManager:harvestExpUp(arg_10_1)
	self.plantInfo[arg_10_1].exp = self.plantInfo[arg_10_1].exp + var_0_5[arg_10_1].harvest_exp[self.plantInfo[arg_10_1].level]

	while self.plantInfo[arg_10_1].exp >= self.plantInfo[arg_10_1].levelup_need_exp do
		if self.plantInfo[arg_10_1].level >= #var_0_5[arg_10_1].growup_need_times then
			break
		end

		self.plantInfo[arg_10_1].level = self.plantInfo[arg_10_1].level + 1
		self.plantInfo[arg_10_1].needTime = var_0_5[arg_10_1].growup_need_times[self.plantInfo[arg_10_1].level]
		self.plantInfo[arg_10_1].levelup_need_exp = var_0_5[arg_10_1].levelup_need_exp[self.plantInfo[arg_10_1].level]
		self.plantInfo[arg_10_1].rewardNum = var_0_5[arg_10_1].reward_num[self.plantInfo[arg_10_1].level]
		self.plantInfo[arg_10_1].harvest_exp = var_0_5[arg_10_1].harvest_exp[self.plantInfo[arg_10_1].level]
		self.plantInfo[arg_10_1].extra_drop_rate = var_0_5[arg_10_1].extra_drop_rate[self.plantInfo[arg_10_1].level]
	end

	self.UIRef:updatePlantSelectPanel(self.plantInfo[arg_10_1], arg_10_1)
end

function summerFarmManager:timeReduce()
	for iter_11_0, iter_11_1 in ipairs(self.soils) do
		if iter_11_1.plant then
			iter_11_1.growTimes = iter_11_1.growTimes + 1

			iter_11_1.soil:updateSoil(iter_11_1)
		end
	end

	self.remainTime = self.remainTime - 1

	self.UIRef:updateUI()
end

function summerFarmManager:soilTouchHandle(arg_12_1)
	if self.isPlayAni then
		return
	end

	if not self.soils[arg_12_1].plant then
		return
	end

	if self.soils[arg_12_1].growTimes >= self.soils[arg_12_1].rewardNeedTimes then
		local function var_12_0()
			self.plantInfo[self.soils[arg_12_1].plant].warehouseNum = self.plantInfo[self.soils[arg_12_1].plant].warehouseNum + self.plantInfo[self.soils[arg_12_1].plant].rewardNum

			self.UIRef:updatePlantSelectPanel(self.plantInfo[self.soils[arg_12_1].plant], self.soils[arg_12_1].plant)
			self:harvestExpUp(self.soils[arg_12_1].plant)

			if self.soils[arg_12_1].plant == 2 then
				if math.random(100) > (1 - self.plantInfo[2].extra_drop_rate) * 100 then
					self.plantInfo[self.soils[arg_12_1].plant].warehouseNum = self.plantInfo[self.soils[arg_12_1].plant].warehouseNum + self.plantInfo[self.soils[arg_12_1].plant].rewardNum

					self.UIRef:updatePlantSelectPanel(self.plantInfo[self.soils[arg_12_1].plant], self.soils[arg_12_1].plant)
				end
			elseif self.soils[arg_12_1].plant == 3 then
				self.soils[arg_12_1].plant = 3
				self.soils[arg_12_1].growTimes = 0
				self.soils[arg_12_1].rewardNeedTimes = self.plantInfo[3].needTime

				self.soils[arg_12_1].soil:updateSoil(self.soils[arg_12_1])

				return
			elseif self.soils[arg_12_1].plant == 4 then
				-- block empty
			end

			self.soils[arg_12_1].plant = nil
			self.soils[arg_12_1].growTimes = 0
			self.soils[arg_12_1].rewardNeedTimes = 0

			self.soils[arg_12_1].soil:updateSoil(self.soils[arg_12_1])
		end

		self.isPlayAni = true

		self.UIRef.harvestAni:setVisible(true)
		self.UIRef.harvestAni:setPosition(self.soils[arg_12_1].soil:getPositionX() + 20, self.soils[arg_12_1].soil:getPositionY())
		self.UIRef.harvestAni:setAnimation(0, "harvest", false)
		self.UIRef.harvestAni:registerSpineEventHandler(function()
			var_12_0()
			self.UIRef:updateOrders()
			self.UIRef.harvestAni:setVisible(false)

			self.isPlayAni = false

			self:checkGameFailed()
		end, SP_ANIMATION_COMPLETE)
	else
		if self.remainTime <= 0 then
			global_ShowBlockWords("剩余时间不足哦~")

			return
		end

		self.isPlayAni = true

		self.UIRef.waterAni:setVisible(true)
		self.UIRef.waterAni:setPosition(self.soils[arg_12_1].soil:getPosition())
		self.UIRef.waterAni:setAnimation(0, "farm_water", false)
		audio_manager:playeffectMusicTest("sound/farm_act")

		local var_12_1 = 1

		self.UIRef.waterAni:registerSpineEventHandler(function()
			if var_12_1 == 2 then
				self.soils[arg_12_1].growTimes = self.soils[arg_12_1].growTimes + 1

				if self.soils[arg_12_1].plant == 4 then
					if arg_12_1 - 4 > 0 and arg_12_1 - 4 < 12 and self.soils[arg_12_1 - 4].plant then
						self.soils[arg_12_1 - 4].growTimes = self.soils[arg_12_1 - 4].growTimes + 1

						self.soils[arg_12_1 - 4].soil:updateSoil(self.soils[arg_12_1 - 4])
					end

					if arg_12_1 + 4 > 0 and arg_12_1 + 4 < 12 and self.soils[arg_12_1 + 4].plant then
						self.soils[arg_12_1 + 4].growTimes = self.soils[arg_12_1 + 4].growTimes + 1

						self.soils[arg_12_1 + 4].soil:updateSoil(self.soils[arg_12_1 + 4])
					end

					if arg_12_1 - 1 > 0 and arg_12_1 - 1 < 12 and (arg_12_1 - 1) % 4 ~= 0 and self.soils[arg_12_1 - 1].plant then
						self.soils[arg_12_1 - 1].growTimes = self.soils[arg_12_1 - 1].growTimes + 1

						self.soils[arg_12_1 - 1].soil:updateSoil(self.soils[arg_12_1 - 1])
					end

					if arg_12_1 + 1 > 0 and arg_12_1 + 1 < 12 and (arg_12_1 + 1) % 4 ~= 1 and self.soils[arg_12_1 + 1].plant then
						self.soils[arg_12_1 + 1].growTimes = self.soils[arg_12_1 + 1].growTimes + 1

						self.soils[arg_12_1 + 1].soil:updateSoil(self.soils[arg_12_1 + 1])
					end
				end

				self:timeReduce()
				self.UIRef.waterAni:setVisible(false)

				self.isPlayAni = false

				self:checkGameFailed()

				return
			end

			var_12_1 = var_12_1 + 1

			self.UIRef.waterAni:setAnimation(0, "farm_water", false)
		end, SP_ANIMATION_COMPLETE)
	end
end

function summerFarmManager:shovelHandle(arg_16_1)
	if self.isPlayAni then
		return
	end

	if not self.soils[arg_16_1].plant then
		global_ShowBlockWords("该土地没有植物可以铲除哦~")

		return
	end

	self.UIRef:shovelBtnHandle()

	self.isPlayAni = true

	self.UIRef.shovelAni:setVisible(true)
	self.UIRef.shovelAni:setPosition(self.soils[arg_16_1].soil:getPosition())
	self.UIRef.shovelAni:setAnimation(0, "farm_shovel", false)

	local var_16_0 = 1

	self.UIRef.shovelAni:registerSpineEventHandler(function()
		if var_16_0 == 2 then
			self.soils[arg_16_1].plant = nil
			self.soils[arg_16_1].growTimes = 0
			self.soils[arg_16_1].rewardNeedTimes = 0

			self.soils[arg_16_1].soil:updateSoil(self.soils[arg_16_1])
			self.UIRef.shovelAni:setVisible(false)

			self.isPlayAni = false

			return
		end

		var_16_0 = var_16_0 + 1

		self.UIRef.shovelAni:setAnimation(0, "farm_shovel", false)
	end, SP_ANIMATION_COMPLETE)
end

function summerFarmManager:testUpdate()
	self.UIRef:initOrders(self.ordersInfo)

	for iter_18_0 = 1, 4 do
		self.UIRef:updatePlantSelectPanel(self.plantInfo[iter_18_0], iter_18_0)
	end

	self:getGameInfo()
end

function summerFarmManager:checkGameFailed()
	if self.remainTime > 0 then
		return false
	end

	for iter_19_0, iter_19_1 in ipairs(self.soils) do
		if iter_19_1.growTimes >= iter_19_1.rewardNeedTimes and iter_19_1.rewardNeedTimes ~= 0 then
			return false
		end
	end

	if self:checkOrderFinished() then
		return false
	end

	audio_manager:playeffectMusicTest("sound/farm_failure")
	cc.UserDefault:getInstance():setStringForKey("SummerFarmPlantData" .. playermodel.playerid, "")
	cc.UserDefault:getInstance():setStringForKey("SummerFarmSoils" .. playermodel.playerid, "")
	cc.UserDefault:getInstance():setStringForKey("SummerFarmOrders" .. playermodel.playerid, "")
	cc.UserDefault:getInstance():setIntegerForKey("SummerFarmLevel" .. playermodel.playerid, -1)
	cc.UserDefault:getInstance():setIntegerForKey("SummerFarmScore" .. playermodel.playerid, -1)
	cc.UserDefault:getInstance():setIntegerForKey("SummerFarmRemainTime" .. playermodel.playerid, -1)

	self.saveLastGame = false

	self.UIRef:initEndPanel(self.ordersInfo)

	return true
end

function summerFarmManager.getGameInfo(arg_20_0)
	network:rpc("activity_get_farm_info", {
		activityid = 722
	}, function(arg_21_0)
		arg_20_0.maxscore = arg_21_0.maxScore

		if not tolua.isnull(arg_20_0.UIRef) then
			arg_20_0.UIRef:updateUI()
		end
	end)
end

function summerFarmManager.checkLocalData(arg_22_0)
	local var_22_0 = cc.UserDefault:getInstance():getStringForKey("SummerFarmPlantData" .. playermodel.playerid, "")
	local var_22_1 = cc.UserDefault:getInstance():getStringForKey("SummerFarmSoils" .. playermodel.playerid, "")
	local var_22_2 = cc.UserDefault:getInstance():getStringForKey("SummerFarmOrders" .. playermodel.playerid, "")
	local var_22_3 = cc.UserDefault:getInstance():getIntegerForKey("SummerFarmLevel" .. playermodel.playerid, -1)
	local var_22_4 = cc.UserDefault:getInstance():getIntegerForKey("SummerFarmScore" .. playermodel.playerid, -1)
	local var_22_5 = cc.UserDefault:getInstance():getIntegerForKey("SummerFarmRemainTime" .. playermodel.playerid, -1)

	if var_22_0 == "" or var_22_1 == "" or var_22_2 == "" or var_22_3 < 0 or var_22_4 < 0 or var_22_5 < 0 then
		return false
	end

	arg_22_0.plantInfo = json.decode(var_22_0)
	arg_22_0.soils = json.decode(var_22_1)
	arg_22_0.ordersInfo = json.decode(var_22_2)
	arg_22_0.level = var_22_3
	arg_22_0.score = var_22_4
	arg_22_0.remainTime = var_22_5

	return true
end

function summerFarmManager:saveLocalData()
	local var_23_0 = clone(self.soils)

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		iter_23_1.soil = nil
	end

	print(json.encode(self.plantInfo))
	print(json.encode(var_23_0))
	print(json.encode(self.ordersInfo))
	cc.UserDefault:getInstance():setStringForKey("SummerFarmPlantData" .. playermodel.playerid, json.encode(self.plantInfo))
	cc.UserDefault:getInstance():setStringForKey("SummerFarmSoils" .. playermodel.playerid, json.encode(var_23_0))
	cc.UserDefault:getInstance():setStringForKey("SummerFarmOrders" .. playermodel.playerid, json.encode(self.ordersInfo))
	cc.UserDefault:getInstance():setIntegerForKey("SummerFarmLevel" .. playermodel.playerid, self.level)
	cc.UserDefault:getInstance():setIntegerForKey("SummerFarmScore" .. playermodel.playerid, self.score)
	cc.UserDefault:getInstance():setIntegerForKey("SummerFarmRemainTime" .. playermodel.playerid, self.remainTime)
end

return summerFarmManager
