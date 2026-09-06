-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/model/RedLotusDinnerPartyModel.lua

module("logic.extensions.redlotusdinnerparty.model.RedLotusDinnerPartyModel", package.seeall)

local RedLotusDinnerPartyModel = class("RedLotusDinnerPartyModel", BaseModel)

function RedLotusDinnerPartyModel:ctor()
	RedLotusDinnerPartyModel.super.ctor(self)
end

function RedLotusDinnerPartyModel:onInit()
	self:onReset()
end

function RedLotusDinnerPartyModel:onReset()
	self.actInfoMap = {}
end

function RedLotusDinnerPartyModel:getActivityId()
	return 269001
end

function RedLotusDinnerPartyModel:onGetInfo(msg)
	local actId = msg.actId
	local info = GameUtil.pbToTable(msg.info)

	self.actInfoMap[actId] = {}
	self.actInfoMap[actId][info.gameId] = info
end

function RedLotusDinnerPartyModel:getGalaInfo(actId, gameId)
	if self.actInfoMap[actId] then
		return self.actInfoMap[actId][gameId]
	end
end

function RedLotusDinnerPartyModel:updateBuyTimes(msg)
	local info = self:getGalaInfo(msg.actId, msg.gameId)

	if info then
		info.buyGameTimes = msg.buyGameTimes
	end
end

function RedLotusDinnerPartyModel:updateGainPrize(msg)
	local info = self:getGalaInfo(msg.actId, msg.gameId)

	if info then
		info.gainPrizeIds = msg.gainPrizeIds
	end
end

RedLotusDinnerPartyModel.instance = RedLotusDinnerPartyModel.New()

return RedLotusDinnerPartyModel
