-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/model/MakingMoonCakeModel.lua

module("logic.extensions.makingmooncake.model.MakingMoonCakeModel", package.seeall)

local MakingMoonCakeModel = class("MakingMoonCakeModel", BaseModel)

function MakingMoonCakeModel:ctor()
	MakingMoonCakeModel.super.ctor(self)
end

function MakingMoonCakeModel:onInit()
	MakingMoonCakeModel.super.onInit(self)
end

function MakingMoonCakeModel:onReset()
	MakingMoonCakeModel.super.onReset(self)

	self._surplusTimes = nil
	self._curCumulativeScore = nil
	self._receivedCumulativePrizeIds = nil
	self._mixedKey = nil
	self._scorePrizePlanId = nil
	self._clientKey = nil
	self._setBuyTimes = nil
end

function MakingMoonCakeModel:handlePM_MakingMoonCakeReceiveAllPrizeRes(msg)
	self._receivedCumulativePrizeIds = msg.receivedCumulativePrizeIds
	self._changeSetIdAsReceiveAll = msg.changeSetId
end

function MakingMoonCakeModel:handlePM_MakingMoonCakeGainRoleProgressPrizeRes(msg)
	local roleId = msg.roleId
	local role = self._roles[roleId]

	role.gainedPirze = true
end

function MakingMoonCakeModel:getRoleUrl()
	return "lihui_spine/15024_shenyaozhengli02_lihui/15024_shenyaozhengli02_lihui-ui_p.prefab"
end

function MakingMoonCakeModel:setSurplusTimes(surplusTimes)
	self._surplusTimes = surplusTimes
end

function MakingMoonCakeModel:getSurplusTimes()
	return self._surplusTimes
end

function MakingMoonCakeModel:setCurCumulativeScore(curCumulativeScore)
	self._curCumulativeScore = curCumulativeScore
end

function MakingMoonCakeModel:getCurCumulativeScore()
	return self._curCumulativeScore
end

function MakingMoonCakeModel:setReceivedCumulativePrizeIds(receivedCumulativePrizeIds)
	self._receivedCumulativePrizeIds = {}

	for i, v in ipairs(receivedCumulativePrizeIds) do
		self._receivedCumulativePrizeIds[v] = true
	end
end

function MakingMoonCakeModel:getReceivedCumulativePrizeIds()
	return self._receivedCumulativePrizeIds
end

function MakingMoonCakeModel:setClientKey(clientKey)
	self._clientKey = clientKey
end

function MakingMoonCakeModel:getClientKey()
	return self._clientKey
end

function MakingMoonCakeModel:setMixedKey(mixedKey)
	self._mixedKey = mixedKey
end

function MakingMoonCakeModel:getMixedKey()
	return self._mixedKey
end

function MakingMoonCakeModel:setScorePrizePlanId(planId)
	self._scorePrizePlanId = planId
end

function MakingMoonCakeModel:getScorePrizePlanId()
	return self._scorePrizePlanId or 1
end

function MakingMoonCakeModel:setBuyTimes(setBuyTimes)
	self._setBuyTimes = setBuyTimes
end

function MakingMoonCakeModel:getBuyTimes()
	return self._setBuyTimes
end

function MakingMoonCakeModel:setWeekScore(weekScore)
	self._weekScore = weekScore
end

function MakingMoonCakeModel:getWeekScore()
	return self._weekScore
end

function MakingMoonCakeModel:setRoles(roles)
	self._roles = roles
end

function MakingMoonCakeModel:getRoles()
	return self._roles
end

function MakingMoonCakeModel:getChangeSetIdAsReceiveAll()
	return self._changeSetIdAsReceiveAll
end

MakingMoonCakeModel.instance = MakingMoonCakeModel.New()

return MakingMoonCakeModel
