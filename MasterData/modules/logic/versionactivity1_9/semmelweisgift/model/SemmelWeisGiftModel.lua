-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/model/SemmelWeisGiftModel.lua

module("modules.logic.versionactivity1_9.semmelweisgift.model.SemmelWeisGiftModel", package.seeall)

local SemmelWeisGiftModel = class("SemmelWeisGiftModel", BaseModel)

SemmelWeisGiftModel.REWARD_INDEX = 1

function SemmelWeisGiftModel:getSemmelWeisGiftActId()
	return ActivityEnum.Activity.V1a9_SemmelWeisGift
end

function SemmelWeisGiftModel:isSemmelWeisGiftOpen()
	local actId = self:getSemmelWeisGiftActId()

	return (ActivityType101Model.instance:isOpen(actId) or nil) and true
end

function SemmelWeisGiftModel:isShowRedDot()
	local actId = self:getSemmelWeisGiftActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	return (isOpen or nil) and ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

SemmelWeisGiftModel.instance = SemmelWeisGiftModel.New()

return SemmelWeisGiftModel
