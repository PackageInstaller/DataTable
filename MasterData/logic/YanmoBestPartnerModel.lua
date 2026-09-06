-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yanmobestpartner/model/YanmoBestPartnerModel.lua

module("logic.extensions.yanmobestpartner.model.YanmoBestPartnerModel", package.seeall)

local YanmoBestPartnerModel = class("YanmoBestPartnerModel", BaseModel)

function YanmoBestPartnerModel:ctor()
	return
end

function YanmoBestPartnerModel:onInit()
	self:onReset()
end

function YanmoBestPartnerModel:onReset()
	self._activityId = 0
	self._gainedPrizeMap = {}
end

function YanmoBestPartnerModel:getActivityId()
	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.YanmoBestPartner)
	end

	return self._activityId
end

function YanmoBestPartnerModel:setInfoRes(msg)
	local gainedPrizeIds = GameUtil.pbToTable(msg.gainPrizeIds) or {}

	self._gainedPrizeMap = {}

	for i, id in ipairs(gainedPrizeIds) do
		self._gainedPrizeMap[id] = true
	end
end

function YanmoBestPartnerModel:setGainedPrizeMap(msg)
	self._gainedPrizeMap[msg.prizeId] = true
end

function YanmoBestPartnerModel:getPetList()
	local list = {}
	local petCfg = YanmoBestPartnerConfig.instance:getPetById(self:getActivityId())

	for i, v in ipairs(petCfg) do
		v.isGray = HandbookModel.instance:isHasPet(v.raceId)

		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		if not a.isGray and not b.isGray then
			if a.isNew and b.isNew then
				return a.id < b.id
			end

			return a.isNew
		end

		return not a.isGray
	end)

	return list
end

function YanmoBestPartnerModel:getAllScore()
	local petCfg = self:getPetList()
	local score = 0

	for i, v in ipairs(petCfg) do
		if v.isGray then
			score = score + v.score
		end
	end

	return score
end

function YanmoBestPartnerModel:isRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self:getAllScore()

	if isScoreEnough then
		local isGeted = self:isRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function YanmoBestPartnerModel:isRewardGeted(prizeId)
	return self._gainedPrizeMap[prizeId] == true
end

YanmoBestPartnerModel.instance = YanmoBestPartnerModel.New()

return YanmoBestPartnerModel
