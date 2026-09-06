-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/controller/DivineAoJiuController.lua

module("logic.extensions.divineaojiu.controller.DivineAoJiuController", package.seeall)

local DivineAoJiuController = class("DivineAoJiuController", BaseController)

DivineAoJiuController.ShopViewClose = "DivineBountyBuyViewClose"

function DivineAoJiuController:ctor()
	return
end

function DivineAoJiuController:onInit()
	self:onReset()
end

function DivineAoJiuController:onReset()
	return
end

function DivineAoJiuController:openExtraMissionView(activityId, stageId)
	local fmtMo = DivineAoJiuModel.instance:getExtraFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineAoJiuController:openNormalMissionView(activityId, stageId)
	local fmtMo = DivineAoJiuModel.instance:getNormalFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineAoJiuController:handlePM_DivineAoJiuClgGetInfoRes(msg)
	DivineAoJiuModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineAoJiuClgGetInfo)
end

function DivineAoJiuController:handlePM_DivineAoJiuClgNotifyExtremeClgRes(msg)
	if msg.isWin then
		DivineAoJiuModel.instance:saveTempResultData(msg)
	end
end

function DivineAoJiuController:handlePM_DivineAoJiuClgConfirmRes(msg)
	DivineAoJiuModel.instance:saveComfirmResult(msg)
	DivineAoJiuModel.instance:resetTempResultData()
	GlobalDispatcher:dispatch(GlobalNotify.DivineAoJiuClgGetInfo)
end

function DivineAoJiuController:handlePM_DivineAoJiuClgNotifyNormalClgRes(msg)
	if msg.isWin == true then
		DivineAoJiuModel.instance:saveNormalBattleInfo(msg)

		if msg.changeSetId then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineAoJiuClgGetInfo)
end

function DivineAoJiuController:handlePM_DivineAoJiuClgBuyPassRes(msg)
	DivineAoJiuModel.instance:saveBuyPassInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineAoJiuClgGetInfo)
end

DivineAoJiuController.instance = DivineAoJiuController.New()

return DivineAoJiuController
