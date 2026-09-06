-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumediamondgift/model/ConsumediamondgiftModel.lua

module("logic.extensions.consumediamondgift.view.ConsumediamondgiftModel", package.seeall)

local ConsumediamondgiftModel = class("ConsumediamondgiftModel", BaseModel)

function ConsumediamondgiftModel:ctor()
	return
end

function ConsumediamondgiftModel:onInit()
	self:onReset()
end

function ConsumediamondgiftModel:onReset()
	self._hasGainPrizeIds = {}
	self._consumeNums = 0
	self._activityId = nil
	self._currGainPrizeId = nil
	self._isGetServerInfo = false
end

function ConsumediamondgiftModel:setActInfo(msg)
	self._consumeNums = msg.consumeNums

	for i, v in ipairs(msg.hasGainPrizeIds) do
		self._hasGainPrizeIds[v] = true
	end

	self._isGetServerInfo = true
end

function ConsumediamondgiftModel:getActInfo()
	return self._consumeNums, self._hasGainPrizeIds
end

function ConsumediamondgiftModel:gainPrizeRes()
	if self._currGainPrizeId then
		self._hasGainPrizeIds[self._currGainPrizeId] = true
		self._currGainPrizeId = nil
	end
end

function ConsumediamondgiftModel:setCurrGainPrizeId(id)
	self._currGainPrizeId = id
end

function ConsumediamondgiftModel:setActId(id)
	self._activityId = id
end

function ConsumediamondgiftModel:isAllPrizeGain()
	if not self._isGetServerInfo then
		return true
	end

	local allGet = true
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ConsumeDiamondGift)

	if cfg then
		local acfgs = ConsumediamondgiftConfig.instance:getActCfg(cfg.activityId)

		for i, v in ipairs(acfgs) do
			if not self._hasGainPrizeIds[v.prizeId] then
				allGet = false

				break
			end
		end
	end

	return allGet
end

ConsumediamondgiftModel.instance = ConsumediamondgiftModel.New()

return ConsumediamondgiftModel
