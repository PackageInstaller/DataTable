-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/model/ReviveElizabethModel.lua

module("logic.extensions.reviveelizabeth.model.ReviveElizabethModel", package.seeall)

local ReviveElizabethModel = class("ReviveElizabethModel", BaseModel)

function ReviveElizabethModel:onInit()
	self:onReset()
end

function ReviveElizabethModel:onReset()
	self._info = {}
	self._fieldInfo = {}
	self._lastPrizeInfo = {}
end

function ReviveElizabethModel:onReviveElizabethGetInfoRes(msg)
	self._info[msg.activityId] = msg
end

function ReviveElizabethModel:onReviveElizabethHandleFieldRes(msg)
	ReviveElizabethAgent.instance:sendPM_ReviveElizabethGetInfoReq(msg.activityId)
end

function ReviveElizabethModel:onReviveElizabethGainPrizeRes(msg)
	if msg.activityId and self._info[msg.activityId] then
		print("[YuTestPrint] =====>\t 领取奖励成功，获取活动信息。")

		self._lastPrizeInfo[msg.activityId] = msg

		ReviveElizabethAgent.instance:sendPM_ReviveElizabethGetInfoReq(msg.activityId)
	end
end

function ReviveElizabethModel:onReviveElizabethInjectSoulRes(msg)
	if msg.activityId and self._info[msg.activityId] then
		print("[YuTestPrint] =====>\t 注入花魂成功，获取活动信息。")
		ReviveElizabethAgent.instance:sendPM_ReviveElizabethGetInfoReq(msg.activityId)
	end
end

function ReviveElizabethModel:getInfo(activityId)
	if self._info[activityId] then
		return self._info[activityId]
	end

	return nil
end

function ReviveElizabethModel:getLastPrizeInfo(activityId)
	if self._lastPrizeInfo[activityId] then
		return self._lastPrizeInfo[activityId]
	end

	return nil
end

function ReviveElizabethModel:getWorldPrizeState(activityId)
	local info = self:getInfo(activityId)
	local cfg = ReviveElizabethConfig.instance:getWorldProgressPrizeCfg(activityId)
	local state = false

	if not info or not cfg or not info.gainWorldPrizeIds then
		return state
	end

	for i, data in ipairs(cfg) do
		if info.worldProgress >= data.progress and table.keyof(info.gainWorldPrizeIds, data.prizeId) == nil then
			state = true

			break
		end
	end

	return state
end

function ReviveElizabethModel:getUserPrizeState(activityId)
	local info = self:getInfo(activityId)
	local cfg = ReviveElizabethConfig.instance:getUserProgressPrizeCfg(activityId)
	local state = false

	if not info or not cfg or not info.gainUserPrizeIds then
		return state
	end

	for i, data in ipairs(cfg) do
		if info.progress >= data.progress and table.keyof(info.gainUserPrizeIds, data.prizeId) == nil then
			state = true

			break
		end
	end

	return state
end

function ReviveElizabethModel:getFlowerSoulState(activityId)
	local info = self:getInfo(activityId)
	local cfg = ReviveElizabethConfig.instance:getSoulConfig(activityId)
	local state = false

	if not info or not cfg or not info.gainUserPrizeIds then
		return state
	end

	for i, data in ipairs(cfg) do
		if info.progress >= data.progress and table.keyof(info.hasInjectSoulPrizeIds, data.prizeId) == nil then
			state = true

			break
		end
	end

	return state
end

ReviveElizabethModel.instance = ReviveElizabethModel.New()

return ReviveElizabethModel
