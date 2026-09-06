-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/controller/ExploreUnderController.lua

module("logic.extensions.exploreunder.controller.ExploreUnderController", package.seeall)

local ExploreUnderController = class("ExploreUnderController", BaseController)

function ExploreUnderController:onInit()
	return
end

function ExploreUnderController:getInfo()
	local actId = ExploreUnderModel.instance:getActId()

	ExploreUnderAgent.instance:sendPM_ExploreUnderInfoReq(actId)
end

function ExploreUnderController:handleGetInfo(msg)
	ExploreUnderModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ExploreUnderInfoUpdate)
end

function ExploreUnderController:dice(diceNum)
	local actId = ExploreUnderModel.instance:getActId()

	ExploreUnderModel.instance:checkIsSpecialDice(diceNum)
	ExploreUnderAgent.instance:sendPM_ExploreUnderDiceReq(actId, diceNum)
end

function ExploreUnderController:handleDice(msg)
	ExploreUnderModel.instance:onDice(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ExploreUnderPlayDice)
end

function ExploreUnderController:dealEvent(action, actionParam)
	local actId = ExploreUnderModel.instance:getActId()
	local req = ExploreUnderExtension_pb.PM_ExploreUnderDoEventReq()
	local arr = {}

	if actionParam and #actionParam > 0 then
		for i = 1, #actionParam do
			local param = req.actionParam:add()

			param.key = actionParam[i].key
			param.value = actionParam[i].value

			table.insert(arr, param)
		end
	end

	ExploreUnderAgent.instance:sendPM_ExploreUnderDoEventReq(actId, action, arr)
end

function ExploreUnderController:handleDealEvent(status, msg)
	if status == 0 then
		ExploreUnderModel.instance:onDealEvent(status, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandleDealEvent, status, msg)
end

function ExploreUnderController:handleNotifyEventInfoChanged(msg)
	ExploreUnderModel.instance:onNotifyEventInfoChanged(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ExploreUnderEventInfoChange, msg)
	GlobalDispatcher:dispatch(GlobalNotify.ExploreUnderPlayerMove)
end

function ExploreUnderController:sendPM_ExploreUnderDialogueFightReq(activityId, form)
	ExploreUnderAgent.instance:sendPM_ExploreUnderDialogueFightReq(activityId, form)
end

function ExploreUnderController:handlePM_ExploreUnderDialogueFightRes(status, msg)
	return
end

function ExploreUnderController:showDealEventView(info, isOnlyShow)
	local gridId = info.id
	local eventType = info.eventType
	local param = info.eventParm

	if eventType == 1 then
		UIStateManager.instance:push(ViewName.ExploreUnderPrizeEventView, param, isOnlyShow)
	elseif eventType == 2 then
		UIStateManager.instance:push(ViewName.ExploreUnderMoveEventView, param, isOnlyShow)
	elseif eventType == 3 then
		UIStateManager.instance:push(ViewName.ExploreUnderGameEventView, param, isOnlyShow)
	elseif eventType == 4 then
		UIStateManager.instance:push(ViewName.ExploreUnderShopEventView, isOnlyShow)
	elseif eventType == 5 then
		UIStateManager.instance:push(ViewName.ExploreUnderFightEventView, isOnlyShow)
	elseif eventType == 6 then
		local curGridId = ExploreUnderModel.instance:getCurGridId()

		if not isOnlyShow or curGridId == gridId then
			UIStateManager.instance:push(ViewName.ExploreUnderChatEventView, param)
		else
			FloatWordMgr.instance:show("对话事件")
		end
	end
end

function ExploreUnderController:enterBattleInDialogue(activityId, creepsMasterId, dialogueId)
	local fmtMo = ExploreUnderModel.instance:getDialogueFmtMo()

	fmtMo:updateCfg(activityId, creepsMasterId, dialogueId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

ExploreUnderController.instance = ExploreUnderController.New()

return ExploreUnderController
