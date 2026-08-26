-- chunkname: @modules/logic/versionactivity1_4/act136/model/Activity136Model.lua

module("modules.logic.versionactivity1_4.act136.model.Activity136Model", package.seeall)

local Activity136Model = class("Activity136Model", BaseModel)

function Activity136Model:onInit()
	self:clear()
end

function Activity136Model:reInit()
	self:clear()
end

function Activity136Model:setActivityInfo(severInfo)
	self.curActivity136Id = severInfo.activityId
	self.alreadyReceivedCharacterId = severInfo.selectHeroId

	Activity136Controller.instance:dispatchEvent(Activity136Event.ActivityDataUpdate)
end

function Activity136Model:isActivity136InOpen(isTipNotOpen)
	local result = false
	local curActId = self:getCurActivity136Id()

	if curActId then
		local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(curActId)

		if status == ActivityEnum.ActivityStatus.Normal then
			result = true
		elseif toastId and isTipNotOpen then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end
	end

	return result
end

function Activity136Model:hasReceivedCharacter()
	local alreadyReceivedCharacterId = self:getAlreadyReceivedCharacterId()

	return alreadyReceivedCharacterId and alreadyReceivedCharacterId ~= 0
end

function Activity136Model:isShowRedDot()
	local isInOpen = self:isActivity136InOpen()

	return (isInOpen or nil) and not self:hasReceivedCharacter()
end

function Activity136Model:getAlreadyReceivedCharacterId()
	return self.alreadyReceivedCharacterId
end

function Activity136Model:getCurActivity136Id()
	if not self.curActivity136Id then
		return Activity136Config.instance:getActivityId()
	end

	return self.curActivity136Id
end

function Activity136Model:clear()
	self.curActivity136Id = nil
	self.alreadyReceivedCharacterId = 0

	Activity136Model.super.clear(self)
end

Activity136Model.instance = Activity136Model.New()

return Activity136Model
