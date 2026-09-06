-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/ElizabethModel.lua

module("logic.extensions.timelimitedchallenge.model.ElizabethModel", package.seeall)

local ElizabethModel = class("ElizabethModel", TLCBaseGameModel)

function ElizabethModel:onInit()
	self:onReset()
end

local Daily_First_In_Elizabeth_Main_View_Key = "Daily_First_In_Elizabeth_Main_View_Key"

function ElizabethModel:onReset()
	local key = Daily_First_In_Elizabeth_Main_View_Key

	self._isDailyFirstIn = Framework.LocalStorage.Instance:GetInt(key, 0) == 0

	print("self._isDailyFirstIn = " .. tostring(self._isDailyFirstIn))
end

function ElizabethModel:setInfo(msg)
	self._flowerNums = msg.flowerNums
	self._gainedPrizeIds = msg.gianPrizeIds or {}
	self._clgTimes = msg.clgTimes
	self._buyTimes = msg.buyTimes
	self._rankSize = msg.rankSize
end

function ElizabethModel:getRankSize()
	return checknumber(self._rankSize)
end

function ElizabethModel:getFlowerNums()
	return checknumber(self._flowerNums)
end

function ElizabethModel:isPrizeGained(id)
	if self._gainedPrizeIds then
		return checknumber(table.indexof(self._gainedPrizeIds, id)) > 0
	else
		return false
	end
end

function ElizabethModel:setPrizeGained(id)
	table.insert(self._gainedPrizeIds, id)
end

function ElizabethModel:getBuyedTimes()
	return checknumber(self._buyTimes)
end

function ElizabethModel:addBuyedTimes()
	self._buyTimes = checknumber(self._buyTimes) + 1
end

function ElizabethModel:getUsedTimes()
	return checknumber(self._clgTimes)
end

function ElizabethModel:addUsedTimes()
	self._clgTimes = checknumber(self._clgTimes) + 1
end

function ElizabethModel:getCurPlanId()
	return ElizabethConfig.instance:getConstantValue("GAME_PLAN_ID", true)
end

function ElizabethModel:getTimesPlanId()
	return ElizabethConfig.instance:getConstantValue("GAME_BUY_TIMES_PLAN_ID", true)
end

function ElizabethModel:getCurPrizePlanId()
	return ElizabethConfig.instance:getConstantValue("PRIZE_PLAN_ID", true)
end

function ElizabethModel:getScalePrizePlanId()
	return ElizabethConfig.instance:getConstantValue("SCALE_PRIZE_PLAN_ID", true)
end

function ElizabethModel:setReliveTimes(value)
	self._reliveTimes = value
end

function ElizabethModel:getReliveTimes()
	return checknumber(self._reliveTimes)
end

function ElizabethModel:isDailyFirstIn()
	return self._isDailyFirstIn
end

function ElizabethModel:setDailyFirstIn(value)
	if self._isDailyFirstIn ~= value then
		self._isDailyFirstIn = value

		local key = Daily_First_In_Elizabeth_Main_View_Key

		Framework.LocalStorage.Instance:SetInt(key, 1)
	end
end

ElizabethModel.instance = ElizabethModel.New()

return ElizabethModel
