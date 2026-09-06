-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/model/SaintKnightCardModel.lua

module("logic.extensions.saintknightcard.model.SaintKnightCardModel", package.seeall)

local SaintKnightCardModel = class("SaintKnightCardModel", BaseModel)

function SaintKnightCardModel:ctor()
	return
end

function SaintKnightCardModel:onInit()
	self:onReset()
end

function SaintKnightCardModel:onReset()
	self._actId = 0
	self._cardPlanInfoMap = {}
	self._recordInfoList = {}
end

function SaintKnightCardModel:handleSaintKnightCardGetInfoRes(msg)
	self._actId = msg.actId

	local configInstance = SaintKnightCardConfig.instance

	for _, info in ipairs(msg.infos) do
		local drawPlanId = info.drawPlanId
		local config = configInstance:getSkcDrawData(drawPlanId)

		self._cardPlanInfoMap[drawPlanId] = {
			drawPlanId = drawPlanId,
			payTime = (config.payType == SaintKnightCardConfig.PT_FREE or nil) and ServerTime.nowMs(),
			spacePayNum = info.spacePayNum,
			drawInfos = info.drawInfos,
			isGainExtraPrize = info.isGainExtraPrize
		}
	end
end

function SaintKnightCardModel:handleSaintKnightCardGetRankInfoRes(msg)
	return
end

function SaintKnightCardModel:handleSaintKnightCardDrawRes(msg)
	self._drawPrizeChangeSetId = msg.changeSetId
end

function SaintKnightCardModel:handleSaintKnightCardGetRecordRes(msg)
	self._recordInfoList = msg.infos
end

function SaintKnightCardModel:handleSaintKnightCardGainExPrizeRes(msg)
	return
end

function SaintKnightCardModel:handleSaintKnightCardNotifyRes(msg)
	return
end

function SaintKnightCardModel:getCurActivityId()
	return self._activityId
end

function SaintKnightCardModel:isDrawActivated(drawPlanId)
	return self:getPlanPayTime(drawPlanId) ~= 0
end

function SaintKnightCardModel:getPlanPayTime(drawPlanId)
	local cardMainInfo = self:_getCardPlanInfo(drawPlanId)

	if cardMainInfo then
		if not cardMainInfo.payTime then
			local payTime = 0

			return payTime / 1000
		end
	end
end

function SaintKnightCardModel:getDrawSpacePayNum(drawPlanId)
	local cardMainInfo = self:_getCardPlanInfo(drawPlanId)

	return (cardMainInfo or nil) and (cardMainInfo.spacePayNum or 0)
end

function SaintKnightCardModel:isGainPrizeInDrawGroup(drawPlanId, groupId)
	local info = self:_getDrawGroupInfo(drawPlanId, groupId)

	return info and info.isGainPrize == true or false
end

function SaintKnightCardModel:isGainRatePrizeInDrawGroup(drawPlanId, groupId)
	local info = self:_getDrawGroupInfo(drawPlanId, groupId)

	return info and info.isGainRatePrize == true or false
end

function SaintKnightCardModel:isGainExTraPrizeInDraw(drawPlanId)
	local info = self:_getCardPlanInfo(drawPlanId)

	return info and info.isGainExtraPrize == true or false
end

function SaintKnightCardModel:_getCardPlanInfo(drawPlanId)
	return self._cardPlanInfoMap[drawPlanId]
end

function SaintKnightCardModel:_getDrawGroupInfo(drawPlanId, groupId)
	local targetInfo
	local cardMainInfo = self:_getCardPlanInfo(drawPlanId)

	if cardMainInfo == nil then
		return targetInfo
	end

	for _, info in ipairs(cardMainInfo.drawInfos) do
		if info.groupId == groupId then
			targetInfo = info

			break
		end
	end

	return targetInfo
end

function SaintKnightCardModel:getDrawChangeSetId()
	return self._drawPrizeChangeSetId
end

function SaintKnightCardModel:getRecordInfoList()
	return self._recordInfoList or {}
end

SaintKnightCardModel.instance = SaintKnightCardModel.New()

return SaintKnightCardModel
