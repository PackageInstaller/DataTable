-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/controller/NuoYaSisterClgController.lua

module("logic.extensions.nuoyasisterclg.controller.NuoYaSisterClgController", package.seeall)

local NuoYaSisterClgController = class("NuoYaSisterClgController", BaseController)

function NuoYaSisterClgController:ctor()
	return
end

function NuoYaSisterClgController:onInit()
	self:onReset()
end

function NuoYaSisterClgController:onReset()
	GlobalDispatcher:addListener("enternuoyasisterclg", self._enterNuoYaSisterClg, self)
end

function NuoYaSisterClgController:sendPM_NuoYaSisterExtremeClgReq(activityId, stageId, typeId, simpleForm)
	NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterExtremeClgReq(activityId, stageId, typeId, simpleForm)
end

function NuoYaSisterClgController:handlePM_NuoYaSisterExtremeClgRes(msg)
	return
end

function NuoYaSisterClgController:handlePM_NuoYaSisterExtremeClgInfoRes(msg)
	NuoYaSisterClgModel.instance:saveExtremeClgInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NuoYaSisterExtremeClgInfoRes)
end

function NuoYaSisterClgController:sendPM_NuoYaSisterExtremeClgSeletPetReq(activityId, teamPetLists)
	local selects = {}

	for i, teamPetList in ipairs(teamPetLists) do
		local selectInfo = NuoYaSisterClgExtension_pb.NuoYaSisterExtremeSelect()

		selectInfo.typeId = i

		for j, petMo in ipairs(teamPetList) do
			selectInfo.petIds:append(petMo.petId)
		end

		table.insert(selects, selectInfo)
	end

	NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterExtremeClgSeletPetReq(activityId, selects)
end

function NuoYaSisterClgController:handlePM_NuoYaSisterExtremeClgSeletPetRes(msg)
	NuoYaSisterClgModel.instance:saveExtremeClgTeamInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NuoYaSisterExtremeClgSeletPetRes)
end

function NuoYaSisterClgController:handlePM_NotifyNuoYaSisterExtremeClgFinishRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local activityId = msg.activityId
		local stageId = msg.stageId
		local typeId = msg.typeId
		local isWin = msg.isWin
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = self:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		if isWin then
			result = true

			local hpInfo = self:_calcHpRate()

			UIStateManager.instance:push(ViewName.NuoYaSisterClgResultView, activityId, stageId, typeId, hpInfo)
		end

		return result
	end)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.NuoYaSisterClgExtreme)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyNuoYaSisterExtremeClgFinishRes)
end

function NuoYaSisterClgController:_calcHpRate()
	local units = BattleModel.instance:getUnits()
	local curViewDatas = {}

	for i, v in pairs(units) do
		if not v.attrs:isDoppelganger() and not v.attrs:IsOraclePet() then
			table.insert(curViewDatas, {
				id = v.id,
				hpRate = v.attrs:getCurHp() / v.attrs:getMaxHp()
			})
		end
	end

	return curViewDatas
end

function NuoYaSisterClgController:handlePM_NuoYaSisterExtremeClgResultConfirmRes(status, msg)
	if status == 0 and msg.confirm == true then
		NuoYaSisterClgModel.instance:saveExtremeClgBattle(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyNuoYaSisterExtremeClgFinishRes, status)
end

function NuoYaSisterClgController:handlePM_NuoYaSisterExtremeClgResetRes(msg)
	NuoYaSisterClgModel.instance:saveExtremeClgResetInfo(msg)
	UIStateManager.instance:push(ViewName.NuoYaSisterClgTeamView, msg.activityId)
	UIStateManager.instance:popByName(ViewName.NuoYaSisterClgExtremeView)
end

function NuoYaSisterClgController:handlePM_NuoYaSisterCommonClgInfoRes(msg)
	NuoYaSisterClgModel.instance:saveCommonClgInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NuoYaSisterCommonClgInfoRes)
end

function NuoYaSisterClgController:handlePM_NotifyNuoYaSisterCommonClgFinishRes(msg)
	NuoYaSisterClgModel.instance:saveCommonClgBattle(msg)

	local content = langPara("本次伤害：%d\n\n今日最高伤害：%d", msg.curDamage, msg.maxDamage)

	BattleFacade.instance:registerResultHandler(function()
		TipsFacade.instance:openTipWindow(lang("战斗胜利"), content, function()
			BattleController.instance:endBattle()
		end, lang("确认"), UnityEngine.TextAnchor.MiddleCenter)

		return true
	end)
end

function NuoYaSisterClgController:handlePM_NuoYaSisterCommonClgGainPrizeRes(msg)
	NuoYaSisterClgModel.instance:saveCommonPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NuoYaSisterCommonClgInfoRes)
end

function NuoYaSisterClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function NuoYaSisterClgController:getActivityType()
	return GameEnum.ActivityType.NuoYaSisterClg
end

function NuoYaSisterClgController:isInActivityTime(activityId)
	return ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
end

function NuoYaSisterClgController:_enterNuoYaSisterClg(params)
	self:enterNuoYaSisterClg(checknumber(params[1]))
end

function NuoYaSisterClgController:enterNuoYaSisterClg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.NuoYaSisterClgMainView, activityId)
end

NuoYaSisterClgController.instance = NuoYaSisterClgController.New()

return NuoYaSisterClgController
