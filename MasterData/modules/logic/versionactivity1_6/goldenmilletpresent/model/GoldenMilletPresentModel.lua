-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/model/GoldenMilletPresentModel.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.model.GoldenMilletPresentModel", package.seeall)

local GoldenMilletPresentModel = class("GoldenMilletPresentModel", BaseModel)

function GoldenMilletPresentModel:getGoldenMilletPresentActId()
	return ActivityConfig.instance:getConstAsNum(30700, ActivityEnum.Activity.V3a4_GoldenMilletPresent)
end

function GoldenMilletPresentModel:isGoldenMilletPresentOpen(notOpenToast)
	local actId = self:getGoldenMilletPresentActId()
	local result = ActivityType101Model.instance:isOpen(actId)

	if not result and notOpenToast then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	return result
end

function GoldenMilletPresentModel:haveReceivedSkin()
	local actId = self:getGoldenMilletPresentActId()
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, GoldenMilletEnum.REWARD_INDEX)

	return not canReceive
end

function GoldenMilletPresentModel:isShowRedDot()
	local result = false
	local isOpen = self:isGoldenMilletPresentOpen()

	if isOpen then
		local actId = self:getGoldenMilletPresentActId()

		result = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
	end

	return result
end

GoldenMilletPresentModel.instance = GoldenMilletPresentModel.New()

return GoldenMilletPresentModel
