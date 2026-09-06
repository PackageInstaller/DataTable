-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/model/LuckyDrawNewSkinModel.lua

module("logic.extensions.luckyskinlottery.model.LuckyDrawNewSkinModel", package.seeall)

local LuckyDrawNewSkinModel = class("LuckyDrawNewSkinModel", BaseModel)

function LuckyDrawNewSkinModel:ctor()
	return
end

function LuckyDrawNewSkinModel:onInit()
	self:onReset()
end

function LuckyDrawNewSkinModel:onReset()
	self._activityId2MoMap = {}
	self._freeRankInfo = {}
end

function LuckyDrawNewSkinModel:getActId()
	if self._activityId == 0 then
		local cfg = LuckySkinLotteryConfig.instance:getOpenActivityCfg()

		self._activityId = cfg.activityId
	end

	return self._activityId
end

function LuckyDrawNewSkinModel:getMoOrCreate(activityId)
	self._activityId2MoMap[activityId] = self._activityId2MoMap[activityId] or LuckyDrawNewSkinMo.New(activityId)

	return self._activityId2MoMap[activityId]
end

function LuckyDrawNewSkinModel:getFreeRankInfo(activityId)
	return self._freeRankInfo[activityId]
end

function LuckyDrawNewSkinModel:setViewInfo(msg)
	local mo = self:getMoOrCreate(msg.activityId)

	mo:setViewInfo(msg)
end

function LuckyDrawNewSkinModel:setSkinLotteryInfo(msg)
	local mo = self:getMoOrCreate(msg.activityId)

	mo:setSkinLotteryInfo(msg)
end

function LuckyDrawNewSkinModel:setRankRollTextInfo(msg, activityId)
	local mo = self:getMoOrCreate(activityId)

	mo:setRankRollTextInfo(msg)
end

function LuckyDrawNewSkinModel:setSkinLotteryGetProcessReward(msg)
	local mo = self:getMoOrCreate(msg.activityId)

	mo:setSkinLotteryGetProcessReward(msg)
end

function LuckyDrawNewSkinModel:setRankInfo(msg)
	local mo = self:getMoOrCreate(msg.activityId)

	mo:setRankInfo(msg)
end

function LuckyDrawNewSkinModel:handlePM_SkinLotteryFreeChargeRankRes(msg)
	self._freeRankInfo[msg.activityId] = GameUtil.pbToTable(msg)

	local freeRankInfo = self._freeRankInfo[msg.activityId]

	freeRankInfo.infoList = freeRankInfo.infoList or {}
end

LuckyDrawNewSkinModel.instance = LuckyDrawNewSkinModel.New()

return LuckyDrawNewSkinModel
