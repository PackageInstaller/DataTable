-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/model/FirstChargeModel.lua

module("logic.extensions.firstcharge.model.FirstChargeModel", package.seeall)

local FirstChargeModel = class("FirstChargeModel", BaseModel)

function FirstChargeModel:ctor()
	return
end

function FirstChargeModel:onInit()
	self:onReset()
end

function FirstChargeModel:onReset()
	self._activityId = nil
	self._chargeMoney = 0
	self._hasSignDay = 0
	self._hasGainGifts = {}
	self._hasSignGiftS = {}
	self._isShowHub = false
	self._tryGetPrizeId = nil
end

function FirstChargeModel:updateAfterGetInfo(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end

	self._activityId = msg.activityId
	self._chargeMoney = tonumber(msg.money)
	self._hasSignDay = tonumber(msg.loginDay)
	self._hasGainGifts = {}
	self._tryGetPrizeId = nil

	for _, v in ipairs(msg.hasGainGifts) do
		table.insert(self._hasGainGifts, checkbool(v))
	end

	self._hasSignGiftS = {}

	for _, v in ipairs(msg.signPrizeInfos) do
		self._hasSignGiftS[v.money] = {}

		for _1, v1 in ipairs(v.hasGainSignPrizeDay) do
			table.insert(self._hasSignGiftS[v.money], v1)
		end
	end
end

function FirstChargeModel:updateAfterGetGift(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end

	if self._tryGetPrizeId then
		self._hasGainGifts[self._tryGetPrizeId] = true

		if self._tryGetPrizeId == 1 then
			local money = FirstChargeConfig.instance:getActCfgsById(self._activityId, 1).consumeMoney
			local signCfgs = FirstChargeConfig.instance:getActSignCfgsById(self._activityId, money)

			if signCfgs then
				table.insert(self._hasSignGiftS[money], self:getSignIndex(money))
			end
		end

		self._tryGetPrizeId = nil
	end
end

function FirstChargeModel:setIsShowHub(isShow)
	self._isShowHub = checkbool(isShow)
end

function FirstChargeModel:tryGetPirze(id)
	self._tryGetPrizeId = checkint(id)
end

function FirstChargeModel:setShowIndex(id)
	self._showIndex = checkint(id)
end

function FirstChargeModel:tryGetSignPirze(id)
	self._tryGetPrizeId = checkint(id)
end

function FirstChargeModel:getChargeMoney()
	return self._chargeMoney
end

function FirstChargeModel:getIsHasSign(money, dayId)
	local signCfgs = FirstChargeConfig.instance:getActSignCfgsById(self._activityId, money)

	if not signCfgs then
		return false
	end

	return self._hasSignGiftS[money][dayId]
end

function FirstChargeModel:getSignIndex(money)
	local signCfgs = FirstChargeConfig.instance:getActSignCfgsById(self._activityId, money)

	if not signCfgs then
		return nil
	end

	return #self._hasSignGiftS[money] + 1
end

function FirstChargeModel:getIsHasAllSign(money)
	local signCfgs = FirstChargeConfig.instance:getActSignCfgsById(self._activityId, money)

	if not signCfgs then
		return false
	end

	return #signCfgs <= #self._hasSignGiftS[money]
end

function FirstChargeModel:getIsAbleToSign(money)
	local signCfgs = FirstChargeConfig.instance:getActSignCfgsById(self._activityId, money)

	if not signCfgs then
		return false
	end

	return self._hasSignDay >= self:getSignIndex(money) and not self:getIsHasAllSign(money)
end

function FirstChargeModel:getCurActivityId()
	return self._activityId
end

function FirstChargeModel:getCurPetSkinGoodId()
	return 9001
end

function FirstChargeModel:getCurPigSkinGoodId()
	return 4013
end

function FirstChargeModel:getHasGainGiftByIndex(id)
	if id == 1 then
		local money = FirstChargeConfig.instance:getActCfgsById(self._activityId, 1).consumeMoney

		return money <= self._chargeMoney and not self:getIsAbleToSign(money)
	end

	return self._hasGainGifts[id]
end

function FirstChargeModel:getCurActCfgs()
	return FirstChargeConfig.instance:getActCfgsById(self._activityId)
end

function FirstChargeModel:getTemResByActcfg(actCfg)
	local res = {}

	if actCfg then
		local cfgs = FirstChargeConfig.instance:getActCfgsById(actCfg.activityId)

		if cfgs then
			for k, v in pairs(cfgs) do
				table.insert(res, GameUrl.getFirstChargeBGUrl(v.BG))
			end

			table.remove(res)
		end
	end

	return res
end

function FirstChargeModel:getIsShowHub()
	return self._isShowHub
end

function FirstChargeModel:getShowIndex()
	return self._showIndex
end

FirstChargeModel.instance = FirstChargeModel.New()

return FirstChargeModel
