-- chunkname: @modules/logic/versionactivity1_9/matildagift/model/V1a9_MatildaGiftModel.lua

module("modules.logic.versionactivity1_9.matildagift.model.V1a9_MatildaGiftModel", package.seeall)

local V1a9_MatildaGiftModel = class("V1a9_MatildaGiftModel", BaseModel)

function V1a9_MatildaGiftModel:getMatildagiftActId()
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.Gifg5StarCharacter, ActivityEnum.Activity.V2a8_Matildagift)
end

function V1a9_MatildaGiftModel:isMatildaGiftOpen(notOpenToast)
	local actId = self:getMatildagiftActId()
	local result = ActivityType101Model.instance:isOpen(actId)

	if not result and notOpenToast then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	return result
end

function V1a9_MatildaGiftModel:isShowRedDot()
	local result = false
	local isOpen = self:isMatildaGiftOpen()

	if isOpen then
		local actId = self:getMatildagiftActId()

		result = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
	end

	return result
end

function V1a9_MatildaGiftModel:couldGet()
	local actId = self:getMatildagiftActId()

	return (ActivityType101Model.instance:isType101RewardCouldGet(actId, 1))
end

function V1a9_MatildaGiftModel:onGetBonus()
	local couldGet = self:couldGet()

	if couldGet then
		local actId = self:getMatildagiftActId()

		Activity101Rpc.instance:sendGet101BonusRequest(actId, 1)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

V1a9_MatildaGiftModel.instance = V1a9_MatildaGiftModel.New()

return V1a9_MatildaGiftModel
