-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/model/OnlineTimeModel.lua

module("logic.extensions.onlinetime.model.OnlineTimeModel", package.seeall)

local OnlineTimeModel = class("OnlineTimeModel", BaseModel)

function OnlineTimeModel:onInit()
	self:onReset()
end

function OnlineTimeModel:onReset()
	self.startTime = 0
	self._itemDatas = {}

	self:_initItemDatas()
end

function OnlineTimeModel:initData(msg)
	print("init onlinetime model")

	self.onlinetimeToday = msg.onlineTime
	self.startTime = ServerTime.now()
	self.timePassed = 0
	self.prizedids = {}

	for i, v in ipairs(msg.prizedIds) do
		self.prizedids[v + 1] = 1
	end

	self.giftIdx = 1

	local t = math.floor(self:getTotalTime() / OnlineTimeConfig.TIME_MIN)

	for i, v in ipairs(OnlineTimeConfig.GIFT_TIME_ARR) do
		self.giftIdx = i

		if self.prizedids[i] == nil then
			break
		end
	end

	local hasSend = self:refreshItemStatus()

	if hasSend == false then
		print(">>>>  第一次更新在线时间")
		OnlineTimeController.instance:localNotify("ItemStatisRefreshed")
	end
end

function OnlineTimeModel:_initItemDatas()
	OnlineTimeConfig.GIFT_TIME_ARR = {}
	self._itemDatas = {}

	for i = 1, 6 do
		local cfg = ActivityParamsConfig.instance:getOnlineTimeCfgByKey(tostring(i - 1))

		self._itemDatas[i] = {}
		self._itemDatas[i].status = GameEnum.IconStatus.Cannot
		self._itemDatas[i].itemStr = cfg.material
		self._itemDatas[i].timeCfg = checknumber(cfg.time)

		table.insert(OnlineTimeConfig.GIFT_TIME_ARR, checknumber(cfg.time))
	end
end

function OnlineTimeModel:getItemData(idx)
	return self._itemDatas[idx]
end

function OnlineTimeModel:refreshItemStatus()
	local hasSend = false

	for i = 1, 6 do
		local preStatus = self._itemDatas[i].status

		self._itemDatas[i].status = self:isPrized(i) and GameEnum.IconStatus.Got or self:getTotalTime() >= self._itemDatas[i].timeCfg * 60 and GameEnum.IconStatus.Can or GameEnum.IconStatus.Cannot

		if preStatus ~= self._itemDatas[i].status then
			hasSend = true

			OnlineTimeController.instance:localNotify("ItemStatisRefreshed")
		end
	end

	return hasSend
end

function OnlineTimeModel:getTime()
	local conf = OnlineTimeConfig.GIFT_TIME_ARR[self:getGiftIdx()] * OnlineTimeConfig.TIME_MIN

	return (math.max(0, conf - self:getTotalTime()))
end

function OnlineTimeModel:addTime()
	self.timePassed = ServerTime.now() - self.startTime
end

function OnlineTimeModel:getTotalTime()
	return self.onlinetimeToday + self.timePassed
end

function OnlineTimeModel:getRotateIndex()
	local index = 0

	for i = 1, 6 do
		if self._itemDatas and self._itemDatas[i] and self:getTotalTime() > self._itemDatas[i].timeCfg * 60 then
			index = i
		end
	end

	return index
end

function OnlineTimeModel:isPrized(id)
	return self.prizedids[id] ~= nil
end

function OnlineTimeModel:checkHasGift()
	if self:getTime() <= 0 and not self:checkGiftAllget() and self.prizedids[self.giftIdx] == nil then
		return true
	else
		return false
	end
end

function OnlineTimeModel:checkGiftAllget()
	for i = 1, #OnlineTimeConfig.GIFT_TIME_ARR do
		if not self:isPrized(i) then
			return false
		end
	end

	return true
end

function OnlineTimeModel:setGiftIdx(idx)
	self.giftIdx = idx + 1

	if self.giftIdx > #OnlineTimeConfig.GIFT_TIME_ARR then
		self.giftIdx = #OnlineTimeConfig.GIFT_TIME_ARR
	end

	self.prizedids[idx] = 1
end

function OnlineTimeModel:getGiftIdx()
	return math.min(6, self:getRotateIndex() + 1)
end

OnlineTimeModel.instance = OnlineTimeModel.New()

return OnlineTimeModel
