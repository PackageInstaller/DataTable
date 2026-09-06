-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/controller/FinalEchoController.lua

module("logic.extensions.finalecho.controller.FinalEchoController", package.seeall)

local FinalEchoController = class("FinalEchoController", BaseController)

function FinalEchoController:onInit()
	self:onReset()
end

function FinalEchoController:onReset()
	self._fmtMoMap = {}
end

function FinalEchoController:openMissionview(activityId, bossId)
	local fmtMo = self._fmtMoMap[activityId]

	if not fmtMo then
		fmtMo = FinalEchoFmtMo.New()
		self._fmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, bossId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function FinalEchoController:getInfo(activityId)
	FinalEchoAgent.instance:sendPM_FinalEchoInfoReq(activityId)
end

function FinalEchoController:handleGetInfo(msg)
	FinalEchoModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FinalEchoGetInfo)
end

function FinalEchoController:startFight(activityId, bossId, form_pb)
	FinalEchoAgent.instance:sendPM_FinalEchoChallengeReq(activityId, bossId, form_pb)
end

function FinalEchoController:confirmResult(activityId, bossId, save)
	FinalEchoAgent.instance:sendPM_FinalEchoConfirmReq(activityId, bossId, save)
end

function FinalEchoController:handleConfirmResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FinalEchoConfirmResult)
end

function FinalEchoController:resetInfo(activityId)
	FinalEchoAgent.instance:sendPM_FinalEchoResetReq(activityId)
end

function FinalEchoController:handleResetInfo(msg)
	FinalEchoModel.instance:onResetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FinalEchoResetInfo)
end

function FinalEchoController:getRankInfo(activityId)
	FinalEchoAgent.instance:sendPM_FinalEchoRankInfoReq(activityId)
end

function FinalEchoController:handleGetRankInfo(msg)
	FinalEchoModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FinalEchoGetRankInfo)
end

function FinalEchoController:handleNotifyClgFinish(msg)
	local activityId = checknumber(msg.activityId)
	local bossId = checknumber(msg.bossId)
	local newDamage = checknumber(msg.damage)
	local curDamage = 0
	local baseInfo = FinalEchoModel.instance:getBaseInfo(activityId)

	if baseInfo then
		if not baseInfo.boss then
			for _, bossInfo in ipairs(baseInfo.boss) do
				if bossInfo.bossId == bossId then
					curDamage = checknumber(bossInfo.damage)
				end
			end
		end
	end

	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleFacade.instance:registerResultHandler(function()
		local resultTxt = string.format("本次挑战造成伤害：%s\n上一次的成绩为：%s\n是否保留本次成绩？", newDamage, curDamage)

		TipsFacade.instance:openPopupWindow("战斗结束", resultTxt, function()
			self:confirmResult(activityId, bossId, true)
			BattleController.instance:endBattle()
		end, function()
			self:confirmResult(activityId, bossId, false)
			BattleController.instance:endBattle()
		end, "保存", "取消", UnityEngine.TextAnchor.MiddleCenter)

		return true
	end)
end

FinalEchoController.instance = FinalEchoController.New()

return FinalEchoController
