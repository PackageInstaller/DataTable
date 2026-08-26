-- chunkname: @modules/logic/versionactivity2_5/act187/model/Activity187Model.lua

module("modules.logic.versionactivity2_5.act187.model.Activity187Model", package.seeall)

local Activity187Model = class("Activity187Model", BaseModel)

function Activity187Model:onInit()
	self:clearData()
end

function Activity187Model:reInit()
	self:clearData()
end

function Activity187Model:clearData()
	self:setLoginCount()
	self:setRemainPaintingCount()
	self:setFinishPaintingIndex()
	self:setAccrueRewardIndex()

	self._paintingRewardDict = {}
end

function Activity187Model:checkActId(actId)
	local curActId = self:getAct187Id()
	local result = actId == curActId

	if not result then
		logError(string.format("Activity187Model:setServerInfo error, not same actId, server:%s, local:%s", actId, curActId))
	end

	return result
end

function Activity187Model:setAct187Info(info)
	if not info then
		return
	end

	self:setLoginCount(info.loginCount)
	self:setRemainPaintingCount(info.haveGameCount)
	self:setFinishPaintingIndex(info.finishGameCount)
	self:setAccrueRewardIndex(info.acceptRewardGameCount)
	self:setAllPaintingReward(info.randomBonusInfos)
end

function Activity187Model:setLoginCount(index)
	self._loginCount = index or 0
end

function Activity187Model:setRemainPaintingCount(count)
	self._remainPaintingCount = count or 0
end

function Activity187Model:setFinishPaintingIndex(index)
	self._finishPaintingIndex = index or 0
end

function Activity187Model:setAccrueRewardIndex(index)
	self._accrueRewardIndex = index or 0
end

function Activity187Model:setAllPaintingReward(randomBonusInfos)
	if not randomBonusInfos then
		return
	end

	for index, randomBonusInfo in ipairs(randomBonusInfos) do
		self:setPaintingRewardList(index, randomBonusInfo.randomBonusList)
	end
end

function Activity187Model:setPaintingRewardList(index, matDataList)
	local list = {}

	for _, matData in ipairs(matDataList) do
		local matMO = MaterialDataMO.New()

		matMO:initValue(matData.materilType, matData.materilId, matData.quantity)
		table.insert(list, matMO)
	end

	self._paintingRewardDict[index] = list
end

function Activity187Model:getAct187Id()
	return VersionActivity2_5Enum.ActivityId.LanternFestival
end

function Activity187Model:isAct187Open(isToast)
	local status, toastId, toastParam
	local actId = self:getAct187Id()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	else
		toastId = ToastEnum.ActivityEnd
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	return status == ActivityEnum.ActivityStatus.Normal
end

function Activity187Model:getAct187RemainTimeStr()
	local result = ""
	local actId = self:getAct187Id()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		local timeStr = actInfoMo:getRemainTimeStr3()

		result = string.format(luaLang("remain"), timeStr)
	end

	return result
end

function Activity187Model:getLoginCount()
	return self._loginCount
end

function Activity187Model:getRemainPaintingCount()
	return self._remainPaintingCount
end

function Activity187Model:getFinishPaintingIndex()
	return self._finishPaintingIndex
end

function Activity187Model:getAccrueRewardIndex()
	return self._accrueRewardIndex
end

function Activity187Model:getPaintingRewardList(index)
	return (self._paintingRewardDict or nil) and (self._paintingRewardDict[index] or {})
end

function Activity187Model:getPaintingRewardId(index)
	local result
	local rewardList = self:getPaintingRewardList(index)

	if rewardList and #rewardList then
		for _, matMO in ipairs(rewardList) do
			local str = string.format("%s#%s", matMO.materilType, matMO.materilId)

			result = string.nilorempty(result) and str or string.format("%s|%s", result, str)
		end
	end

	return result
end

Activity187Model.instance = Activity187Model.New()

return Activity187Model
