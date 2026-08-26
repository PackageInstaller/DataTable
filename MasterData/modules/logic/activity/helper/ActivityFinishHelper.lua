-- chunkname: @modules/logic/activity/helper/ActivityFinishHelper.lua

module("modules.logic.activity.helper.ActivityFinishHelper", package.seeall)

local ActivityFinishHelper = _M

function ActivityFinishHelper.CheckActivity13746Finish(actId)
	if ActivityType101Model.instance:isType101RewardGet(actId, 1) then
		local config = ActivityConfig.instance:getActivityCo(actId)
		local packageId = tonumber(config.patFaceParam)
		local storeGoodsMo = StoreModel.instance:getGoodsMO(packageId)

		if storeGoodsMo and storeGoodsMo:isSoldOut() then
			return true
		end
	end

	return false
end

function ActivityFinishHelper.CheckActivity138517Finish(actId)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	if not activityConfig then
		return true
	end

	if not ActivityType101Model.instance:hasReceiveAllReward(actId) then
		return false
	end

	local linkGiftList = string.splitToNumber(activityConfig.patFaceParam, "#")

	if not linkGiftList or next(linkGiftList) == nil then
		return true
	end

	for _, linkGiftId in ipairs(linkGiftList) do
		local chargeGoodsMO = StoreModel.instance:getGoodsMO(linkGiftId)

		if not chargeGoodsMO or not chargeGoodsMO:isSoldOut() then
			return false
		end

		local config = StoreConfig.instance:getChargeGoodsConfig(linkGiftId)

		if config.taskid and config.taskid ~= 0 and StoreCharageConditionalHelper.isHasCanFinishGoodsTask(linkGiftId) then
			return false
		end
	end

	return true
end

function ActivityFinishHelper.CheckActivity130531Finish(actId)
	local bonusConfigList = Act208Config.instance:getBonusListById(actId)

	if not bonusConfigList or next(bonusConfigList) == nil then
		return true
	end

	local infoMo = Act208Model.instance:getInfo(actId)

	if not infoMo then
		return true
	end

	for _, bonusConfig in pairs(bonusConfigList) do
		local bonusMo = infoMo.bonusDic[bonusConfig.id]

		if bonusMo and bonusMo.status ~= Act208Enum.BonusState.HaveGet then
			return false
		end
	end

	return true
end

function ActivityFinishHelper.CheckActivity13930Finish(actId)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	if not activityConfig then
		return true
	end

	if not ActivityType101Model.instance:hasReceiveAllReward(actId) then
		return false
	end

	if string.nilorempty(activityConfig.param) then
		return true
	end

	local packageId = tonumber(activityConfig.param)
	local storeGoodsMo = StoreModel.instance:getGoodsMO(packageId)

	if storeGoodsMo and not storeGoodsMo:isSoldOut() then
		return false
	end

	return true
end

return ActivityFinishHelper
