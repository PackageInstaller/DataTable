-- chunkname: @modules/logic/versionactivity1_6/decalogpresent/model/DecalogPresentModel.lua

module("modules.logic.versionactivity1_6.decalogpresent.model.DecalogPresentModel", package.seeall)

local DecalogPresentModel = class("DecalogPresentModel", BaseModel)

DecalogPresentModel.REWARD_INDEX = 1

function DecalogPresentModel:getDecalogPresentActId()
	return ActivityEnum.Activity.V2a8_DecaLogPresent
end

function DecalogPresentModel:isDecalogPresentOpen()
	local actId = self:getDecalogPresentActId()

	return (ActivityType101Model.instance:isOpen(actId) or nil) and true
end

function DecalogPresentModel:isShowRedDot()
	local actId = self:getDecalogPresentActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	return (isOpen or nil) and ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

DecalogPresentModel.instance = DecalogPresentModel.New()

return DecalogPresentModel
