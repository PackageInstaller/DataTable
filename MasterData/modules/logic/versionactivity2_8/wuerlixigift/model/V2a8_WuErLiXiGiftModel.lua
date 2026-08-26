-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/model/V2a8_WuErLiXiGiftModel.lua

module("modules.logic.versionactivity2_8.wuerlixigift.model.V2a8_WuErLiXiGiftModel", package.seeall)

local V2a8_WuErLiXiGiftModel = class("V2a8_WuErLiXiGiftModel", BaseModel)

V2a8_WuErLiXiGiftModel.REWARD_INDEX = 1

function V2a8_WuErLiXiGiftModel:getV2a8_WuErLiXiGiftActId()
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.Gifg6StarCharacter, ActivityEnum.Activity.V2a8_WuErLiXiGift)
end

function V2a8_WuErLiXiGiftModel:isV2a8_WuErLiXiGiftOpen()
	local actId = self:getV2a8_WuErLiXiGiftActId()

	return (ActivityType101Model.instance:isOpen(actId) or nil) and true
end

function V2a8_WuErLiXiGiftModel:isShowRedDot()
	local actId = self:getV2a8_WuErLiXiGiftActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	return (isOpen or nil) and ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

V2a8_WuErLiXiGiftModel.instance = V2a8_WuErLiXiGiftModel.New()

return V2a8_WuErLiXiGiftModel
