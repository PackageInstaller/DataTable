-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/model/GodgemconsumeModel.lua

module("logic.extensions.godgemconsume.view.GodgemconsumeModel", package.seeall)

local GodgemconsumeModel = class("GodgemconsumeModel", BaseModel)

function GodgemconsumeModel:ctor()
	return
end

function GodgemconsumeModel:onInit()
	self._activityType = GameEnum.ActivityType.Godgemconsume

	self:onReset()
end

function GodgemconsumeModel:onReset()
	self._currActEndTime = nil
	self._activityId = 0
	self._gainedRealityPrizeCount = 0
	self._progress = 0
	self._gainedProgressPrizeIds = {}
	self._recipientInfo = false
	self._needFillData = false
	self._rankInfos = {}
	self._myRank = -1
end

function GodgemconsumeModel:getCurrActivityId()
	if self._currActEndTime and ServerTime.nowServerLook() < self._currActEndTime then
		return self._activityId
	end

	local acfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, acfg.activityId)

	self._currActEndTime = etime
	self._activityId = acfg.activityId

	return self._activityId
end

function GodgemconsumeModel:setActInfo(msg)
	self._gainedRealityPrizeCount = msg.gainedRealityPrizeCount
	self._progress = msg.progress
	self._gainedProgressPrizeIds = {}

	table.insertto(self._gainedProgressPrizeIds, msg.gainedProgressPrizeIds)

	self._recipientInfo = GameUtil.pbToTable(msg.recipientInfo)
	self._needFillData = msg.needFillData
end

function GodgemconsumeModel:setRankMo(msg)
	self._rankInfos = msg.infoList
	self._myRank = msg.myRank
end

function GodgemconsumeModel:getRankInfos()
	return self._rankInfos
end

function GodgemconsumeModel:getMyRank()
	return self._myRank
end

function GodgemconsumeModel:isNeedFillData()
	return self._needFillData
end

function GodgemconsumeModel:getGainedRealityPrizeCount()
	return self._gainedRealityPrizeCount
end

function GodgemconsumeModel:getCurrConsumValue()
	return self._progress
end

function GodgemconsumeModel:getRecipientInfo()
	return self._recipientInfo
end

function GodgemconsumeModel:changeRecipientInfo(info)
	self._needFillData = false

	if not self._recipientInfo then
		self._recipientInfo = info
	else
		self._recipientInfo.recipient = info.recipient
		self._recipientInfo.telephone = info.telephone
		self._recipientInfo.qq = info.qq
		self._recipientInfo.province = info.province
		self._recipientInfo.city = info.city
		self._recipientInfo.area = info.area
		self._recipientInfo.addressDetail = info.addressDetail
	end
end

function GodgemconsumeModel:gainProgressPrizeRes(msg)
	if self._activityId == msg.activityId then
		table.insert(self._gainedProgressPrizeIds, msg.prizeId)
	end
end

function GodgemconsumeModel:oneKeyGainProgressPrizeRes(_msg)
	local msg = GameUtil.pbToTable(_msg)

	if self._activityId == msg.activityId then
		local prizeIds = {}

		for i, v in ipairs(msg.prizeIds) do
			table.insert(prizeIds, checknumber(v))
		end

		table.insertto(self._gainedProgressPrizeIds, prizeIds)
	end
end

function GodgemconsumeModel:isGainPrize(prizeId)
	return table.indexof(self._gainedProgressPrizeIds, prizeId) ~= false
end

function GodgemconsumeModel:checkCanGainPrize(prizeId)
	if not self:isGainPrize(prizeId) then
		local activityId = self:getCurrActivityId()
		local curValue = self:getCurrConsumValue()
		local cfg = GodgemconsumeConfig.instance:getPrizeCfg(activityId, prizeId)

		return curValue >= cfg.progressReq
	end

	return false
end

function GodgemconsumeModel:canBeGainPrizeIds()
	local prizeIds = {}
	local activityId = self:getCurrActivityId()
	local curValue = self:getCurrConsumValue()
	local cfg = GodgemconsumeConfig.instance:getPrizeCfgs(activityId)

	for i, v in ipairs(cfg) do
		if curValue >= v.progressReq and not self:isGainPrize(i) then
			table.insert(prizeIds, i)
		end
	end

	return prizeIds
end

GodgemconsumeModel.instance = GodgemconsumeModel.New()

return GodgemconsumeModel
