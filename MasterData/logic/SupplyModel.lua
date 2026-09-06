-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/model/SupplyModel.lua

module("logic.extensions.strength.model.SupplyModel", package.seeall)

local SupplyModel = class("SupplyModel", BaseModel)

function SupplyModel:ctor()
	SupplyModel.super.ctor(self)
end

function SupplyModel:onInit()
	self:onReset()
end

function SupplyModel:onReset()
	removetimer(self.TiliIntervalTime, self)

	self.isInitedSupplyInfo = false
	self.isHasGiftCanGet = false
	self.gotStates = {}

	self:_initTiliCommonInfo()
	removetimer(self.onRedPointTimer, self)
end

function SupplyModel:setSupply(msg)
	self.gotStates = {}

	for k, v in pairs(msg.gotStrengths or {}) do
		self.gotStates[v] = true
	end

	self.buyCount = checknumber(msg.buyStrengthTimes)
	self.useFreeCount = checknumber(msg.buyFreeTimes)
	self.isInitedSupplyInfo = true

	self:receiveTiliTime(msg.curStrength, msg.nextHpLeftTime)
	self:updateRedPoint()
	removetimer(self.onRedPointTimer, self)
	settimer(300, self.onRedPointTimer, self)
end

function SupplyModel:onRedPointTimer()
	if self.isInitedSupplyInfo == true then
		self:updateRedPoint()
	end
end

function SupplyModel:updateRedPoint()
	self.isHasGiftCanGet = false

	local isAll = true
	local cfgs = SupplyConfig.instance:getDailyCfgs()

	for k, cfg in pairs(cfgs) do
		local index = cfg.index
		local state = SupplyModel.instance:getGotStates(index)

		if state == false then
			isAll = false
		end

		local timeFlag = GameUtil.getTimePeriodType(cfg.startTime, cfg.endTime, true)

		if timeFlag ~= GameUtil.inTimePeriod or state then
			-- block empty
		else
			self.isHasGiftCanGet = true

			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GetSUPPLY, self.isHasGiftCanGet)

	if isAll then
		removetimer(self.onRedPointTimer, self)
	end
end

function SupplyModel:isRedPoint()
	return self.isHasGiftCanGet
end

function SupplyModel:getGotStates(idx)
	return checkbool(self.gotStates[idx])
end

function SupplyModel:setGotStates(idx)
	self.gotStates[idx] = true

	self:updateRedPoint()
end

function SupplyModel:getHaveTiliCount()
	return MaterialModel.instance:getMaterialsNumber(MatType.Strength, 1)
end

function SupplyModel:_initTiliCommonInfo()
	local content = SupplyConfig.instance:getCommonCfgs()

	self.consumeCount = checknumber(content.DAILY_FREE_COMPENSTAE_CONSUME.value)
	self.freeMaxLQ = checknumber(content.DAILY_FREE_STRENGTH.value)
	self.freeMaxHF = checknumber(content.STRENGTH_LIMIT.value)
	self.recoveryTime = checknumber(content.STRENGTH_RECOVERY_EFFICIENCY.value)
	self.oneBuyCount = checknumber(content.BUY_STRENGTH_GET_NUMBER.value)
	self.tiliNowCount = 0
	self.buyCount = 0
	self.useFreeCount = 0
end

function SupplyModel:getTiliCommonInfo()
	return self
end

function SupplyModel:receiveTiliTime(tili, timer)
	removetimer(self.TiliIntervalTime, self)

	self.tiliNowCount = tili
	self.endTime = ServerTime.now() + timer

	local _fullTime = (self.freeMaxHF - tili - 1) * self.recoveryTime + timer

	GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
		1
	}, _fullTime)
	SupplyController.instance:notify(GlobalNotify.UpdataTiliCount)
	settimer(1, self.TiliIntervalTime, self, true)
end

function SupplyModel:TiliIntervalTime()
	if self.tiliNowCount >= self.freeMaxHF then
		self.endTime = 0

		removetimer(self.TiliIntervalTime, self)

		return
	end

	if ServerTime.now() >= self.endTime then
		self.tiliNowCount = self.tiliNowCount + 1

		SupplyController.instance:notify(GlobalNotify.UpdataTiliCount)

		self.endTime = ServerTime.now() + self.recoveryTime
	end
end

function SupplyModel:buyTiliResult(buyTime)
	self.buyCount = self.buyCount + buyTime
	self.useFreeCount = self.useFreeCount + buyTime

	SupplyController.instance:notify(GlobalNotify.UpdataTiliCount)
end

SupplyModel.instance = SupplyModel.New()

return SupplyModel
