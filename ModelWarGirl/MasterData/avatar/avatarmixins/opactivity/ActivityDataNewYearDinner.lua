-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataNewYearDinner.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityOnHookDetail = require("ClientData/ResOpActivityOnHookDetail")
local ResOpActivityOnHookLevel = require("ClientData/ResOpActivityOnHookLevel")
local ResOpActivityOnHookFood = require("ClientData/ResOpActivityOnHookFood")
local ResOpActivityOnHookMisc = require("ClientData/ResOpActivityOnHookMisc")
local UserData = require("Helper/UserData")
local ActivityDataNewYearDinner = Class("ActivityDataNewYearDinner", ActivityDataBase)

function ActivityDataNewYearDinner:ctor()
	self.level = 0
	self.exp = 0
	self.curCooking = {}
	self.cueQueue = {}
	self.curFinish = {}
	self.foodAwarded = {}
	self.foodDataRefreshTimer = {}
end

function ActivityDataNewYearDinner:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityOnHookDetail[actId]
	self.levelData = ResOpActivityOnHookLevel[actId]
	self.foodData = ResOpActivityOnHookFood[actId]
	self.miscData = ResOpActivityOnHookMisc[actId]
end

function ActivityDataNewYearDinner:updateRoleData(roleData)
	if roleData.on_hook.level > self.level and self.level ~= 0 then
		self.needLookedLevel = roleData.on_hook.level
	end

	self.level = roleData.on_hook.level
	self.exp = roleData.on_hook.exp

	if self.levelData and self.levelData[self.level] then
		self.exp = self.exp - self.levelData[self.level].need_exp
	end

	self.freezeTime = roleData.on_hook.freeze_time
	self.foodAwarded = ClientUtils.getBitsDictFromByteString(roleData.on_hook.food_awarded)
	self.foodItemData = roleData.on_hook.item

	self:refreshItemData()
	self:checkLevelChanged()

	local activityNewYearBonusDlg = UIManager.getUI("activityNewYearBonusDlg", nil, false)

	if activityNewYearBonusDlg then
		activityNewYearBonusDlg:onReceiveHalfPart(self.level, self.exp)
	end
end

function ActivityDataNewYearDinner:onStateChange(opActState)
	if self.actObject:inFreeze() then
		self:refreshItemData()

		local activityNewYearDinnerDlg = UIManager.tryGetUI("activityNewYearDinnerDlg")

		if activityNewYearDinnerDlg then
			activityNewYearDinnerDlg:leaveCloseMode()
			activityNewYearDinnerDlg:updateActivityData()
		end
	elseif self.actObject.curState == Const.OPACT_STATE_CLOSE then
		local activityNewYearDinnerDlg = UIManager.tryGetUI("activityNewYearDinnerDlg")

		if activityNewYearDinnerDlg then
			activityNewYearDinnerDlg:setVisible(false)
		end
	end
end

function ActivityDataNewYearDinner:refreshItemData()
	self.curCooking = {}
	self.cueQueue = {}
	self.curFinish = {}

	for pos, foodInfo in ipairs(self.foodItemData or {}) do
		self:refreshOneItemData(pos)
	end

	self.actObject:checkNew()
end

function ActivityDataNewYearDinner:timerRefreshItemData(pos)
	self:refreshOneItemData(pos)
	self.actObject:checkNew()
	self.actObject:refreshUI()
end

function ActivityDataNewYearDinner:refreshOneItemData(pos)
	local foodInfo = self.foodItemData[pos]
	local cooking, queue
	local finish = {}

	if not self.foodDataRefreshTimer[pos] then
		self.foodDataRefreshTimer[pos] = Timer.New(Functor(self.timerRefreshItemData, self, pos), 5, 1)
	end

	local now = ClientUtils.getServerTime()
	local timer = self.foodDataRefreshTimer[pos]

	timer:Stop()

	for index, food in ipairs(foodInfo.food) do
		if food.food_id ~= 0 and (not (food.start_time > self.freezeTime) or not self.actObject:inFreeze()) then
			if now >= food.end_time then
				table.insert(finish, self:getFoodData(food))
			elseif not cooking then
				timer.duration = food.end_time - now

				timer:Restart()

				cooking = self:getFoodData(food)
			else
				queue = queue or self:getFoodData(food)
			end
		end
	end

	self.curCooking[pos] = cooking
	self.cueQueue[pos] = queue
	self.curFinish[pos] = finish
end

function ActivityDataNewYearDinner:willEnd()
	local remOpenTime = self:getRemainOpenTime()

	if remOpenTime > 0 then
		local remFreezeTime = self:getFreezeOpenTime()

		return remFreezeTime <= 86400
	end
end

function ActivityDataNewYearDinner:getCookingData(pos)
	if self:isPosLocked(pos) then
		return false, self.clientData[pos]
	else
		return self.clientData[pos], {
			self.curCooking[pos],
			self.cueQueue[pos],
			self.curFinish[pos]
		}
	end
end

function ActivityDataNewYearDinner:getLevelPosNum(level)
	local posNum = 0

	for pos, detailData in ipairs(self.clientData) do
		if detailData.unlock_type == 1 and level >= (detailData.unlock_args[1] or 0) then
			posNum = posNum + 1
		end
	end

	return posNum
end

function ActivityDataNewYearDinner:isPosLocked(pos)
	local detailData = self.clientData[pos]

	if detailData.unlock_type == 1 then
		return self.level < (detailData.unlock_args[1] or 0)
	elseif detailData.unlock_type == 2 then
		local needHero = detailData.unlock_args[1]
		local needStar = detailData.unlock_args[2]

		return not CurAvatar:hasLimitStarByHeroId(needHero, needStar)
	end

	return true
end

function ActivityDataNewYearDinner:isQueueLocked(pos, level)
	level = level or self.level

	local detailData = self.clientData[pos]

	if detailData.queue_unlock_type == 1 then
		return level < detailData.queue_unlock_args[1]
	elseif detailData.queue_unlock_type == 2 then
		local needHero = detailData.queue_unlock_args[1]
		local needStar = detailData.queue_unlock_args[2]

		return not CurAvatar:hasLimitStarByHeroId(needHero, needStar)
	end

	return true
end

function ActivityDataNewYearDinner:willEndCountDown()
	return 86400 - (self.allOverTime - self.endTime)
end

function ActivityDataNewYearDinner:checkNew()
	local inFreeze = self.actObject:inFreeze()

	if self.level == 0 then
		if inFreeze then
			return false
		else
			return true
		end
	end

	local hasFood = self:hasFood()

	for pos, detailData in ipairs(self.clientData) do
		local unlock, posInfo = self:getCookingData(pos)

		if unlock then
			local cooking = posInfo[1]

			if cooking == nil and hasFood and not inFreeze then
				return true
			end

			local finish = posInfo[3]

			if finish and #finish > 0 then
				return true
			end
		end
	end

	return false
end

function ActivityDataNewYearDinner:hasFood()
	for _, foodInfo in ipairs(self.foodData or {}) do
		local nowNum = CurAvatar:getItemNumById(foodInfo.cost_item) or 0

		if nowNum > 0 then
			return true
		end
	end
end

function ActivityDataNewYearDinner:getFoodData(serverData)
	local foodId = serverData.food_id
	local foodData = {}

	foodData.resData = ResOpActivityOnHookFood[self.actId][foodId]
	foodData.startTime = serverData.start_time
	foodData.endTime = serverData.end_time
	foodData.gotBonus = self.foodAwarded[foodId]

	return foodData
end

local function sortFood(A, B)
	if A[1] == B[1] then
		return A[2].food_id < B[2].food_id
	elseif A[1] then
		return true
	else
		return false
	end
end

function ActivityDataNewYearDinner:getSortedAllFood()
	local allFood = {}

	for _, foodInfo in ipairs(self.foodData or {}) do
		local nowNum = CurAvatar:getItemNumById(foodInfo.cost_item) or 0

		table.insert(allFood, {
			nowNum > 0,
			foodInfo
		})
	end

	table.sort(allFood, sortFood)

	return allFood
end

function ActivityDataNewYearDinner:getFoodFinishCount(foodId)
	if self.foodAwarded[foodId] then
		return 1
	else
		return 0
	end
end

function ActivityDataNewYearDinner:rpcFirstIn()
	RPC.opActOnHookRoleFirstIn(self.actObject.opId)

	self.needLookedLevel = 1
end

function ActivityDataNewYearDinner:rpcGetBonus(pos)
	local finish = self.curFinish[pos]

	if finish and #finish > 0 then
		local finishFood = finish[1]

		if not finishFood.gotBonus and finishFood.resData.get_avg then
			UIManager.playAVG(finishFood.resData.get_avg, nil, Functor(self.realGetBonus, self, pos), true)
		else
			self:realGetBonus(pos)
		end
	end
end

function ActivityDataNewYearDinner:realGetBonus(pos)
	if self.actObject:isValid() then
		RPC.opActOnHookRoleDeliver(self.actObject.opId, pos)
	else
		CurAvatar:activityRPC(RPC.opActOnHookRoleDeliver, self.actObject.opId, self.actObject.opId, pos)
	end

	local activityNewYearDinnerDlg = UIManager.tryGetUI("activityNewYearDinnerDlg")

	if activityNewYearDinnerDlg then
		activityNewYearDinnerDlg:bgmOn()
	end
end

function ActivityDataNewYearDinner:onGetFood(pos, foodId)
	UIManager.getUI("activityNewYearBonusDlg", true):onShow(self, foodId, self.level, self.exp)
end

function ActivityDataNewYearDinner:checkLevelChanged()
	if not UIManager.tryGetUI("activityNewYearBonusDlg") and UIManager.tryGetUI("activityNewYearDinnerDlg") and self.needLookedLevel then
		UIManager.getUI("activityNewYearLevelUpDlg", true):onShow(self)

		self.needLookedLevel = nil
	end
end

function ActivityDataNewYearDinner:getLevelUnlockPos()
	local unlockPos = {}
	local cachedData = UserData.getClientData(Const.USER_KEY_NEW_YEAR_DINNER) or {}
	local posLooked = cachedData.posLooked

	if posLooked then
		for pos, detailData in ipairs(self.clientData) do
			if not self:isPosLocked(pos) and not posLooked[pos] then
				table.insert(unlockPos, pos)
			end
		end
	elseif self.level == 1 then
		for pos, detailData in ipairs(self.clientData) do
			if not self:isPosLocked(pos) then
				table.insert(unlockPos, pos)
			end
		end
	else
		self:saveLevelUnlockPos()
	end

	return unlockPos
end

function ActivityDataNewYearDinner:saveLevelUnlockPos()
	local unlockPos = {}
	local cachedData = UserData.getClientData(Const.USER_KEY_NEW_YEAR_DINNER) or {}

	for pos, detailData in ipairs(self.clientData) do
		if not self:isPosLocked(pos) then
			unlockPos[pos] = 1
		end
	end

	cachedData.posLooked = unlockPos

	UserData.setClientData(Const.USER_KEY_NEW_YEAR_DINNER, cachedData)
end

function ActivityDataNewYearDinner:getFoodCookTimeStr(foodId)
	local foodData = self.foodData[foodId]

	if foodData and foodData.cost_time then
		local costTime = foodData.cost_time
		local levelData = self.levelData[self.level]

		if levelData and levelData.time_up then
			costTime = math.floor(costTime * (1 - levelData.time_up * 0.0001))
		end

		return utils.calcTimeTxt(costTime)
	end

	return ""
end

function ActivityDataNewYearDinner:destroy()
	for pos, cookTimer in pairs(self.foodDataRefreshTimer) do
		cookTimer:Stop()
	end
end

return ActivityDataNewYearDinner
