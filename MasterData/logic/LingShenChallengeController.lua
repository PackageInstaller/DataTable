-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/controller/LingShenChallengeController.lua

module("logic.extensions.lingshenchallenge.controller.LingShenChallengeController", package.seeall)

local LingShenChallengeController = class("LingShenChallengeController", BaseController)

function LingShenChallengeController:onInit()
	self:onReset()
end

function LingShenChallengeController:onReset()
	self._formTeamEnd = false
	self.tempHandler = nil
end

function LingShenChallengeController:onFormTeamEnd()
	self._formTeamEnd = true

	if self._formTeamEnd and self._formationStart then
		self:onEnterFormation()
	end
end

function LingShenChallengeController:onEnterFormation()
	local fightInfo = LingShenChallengeModel.instance:getFightInfo()
	local mo = LingShenChallengeModel.instance:getFightFmtMo()
	local playerPosId

	for i, v in ipairs(fightInfo.playerList) do
		if checknumber(v.playerId) == checknumber(RoleModel.instance:getUserId()) then
			playerPosId = v.playerPosId

			break
		end
	end

	mo:initParams(fightInfo.activityId, fightInfo.bossId, playerPosId)
	CustomFmtController.instance:showMissionView(mo)

	self._formTeamEnd = false
	self._formationStart = false
end

function LingShenChallengeController:checkFormation(activityId)
	local formPetList = LingShenChallengeModel.instance:getPetFormPosPet(activityId)

	if formPetList then
		for i = 1, 3 do
			if checknumber(formPetList[i]) == 0 or not BagModel.instance:getBagPetById(formPetList[i]) then
				return false
			end
		end

		return true
	end

	return false
end

function LingShenChallengeController:getCurBoss(activityId)
	for i, v in ipairs(LingShenChallengeConfig.instance:getBossCfgs(activityId)) do
		local startTime, endTime = LingShenChallengeConfig.instance:getBossOpenTime(activityId, v.bossId)
		local isOpen = GameUtil.checkIsInTimePeriod(startTime, endTime)

		if isOpen == true then
			return v.bossId
		end
	end

	return 1
end

function LingShenChallengeController:sendPM_LingShenClgGetInfoReq(activityId)
	local targetActivityId = LingShenChallengeModel.instance:getCurrActId()

	LingShenChallengeAgent.instance:sendPM_LingShenClgGetInfoReq((activityId or nil) and activityId)
end

function LingShenChallengeController:handlePM_LingShenClgGetInfoRes(msg)
	LingShenChallengeModel.instance:saveInfo(msg)

	if self.tempHandler then
		if LingShenChallengeController.instance:checkFormation(msg.activityId) == true then
			self.tempHandler()
		else
			FloatWordMgr.instance:show(lang("前往决战领神中设置好阵容再进入~"))
		end

		self.tempHandler = nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgGetInfoRes)
end

function LingShenChallengeController:handlePM_LingShenClgGainDamagePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgGetInfoRes)
end

function LingShenChallengeController:handlePM_LingShenClgSetPreFormRes(msg)
	FloatWordMgr.instance:show(lang("设置成功"))
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgSetPreFormRes)
end

function LingShenChallengeController:handlePM_LingShenClgSetFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgSetFormRes)
end

function LingShenChallengeController:handlePM_LingShenClgReadyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgReadyRes)
end

function LingShenChallengeController:handlePM_LingShenClgNotifyStartRes(msg)
	LingShenChallengeModel.instance:resetFightInfo()
	LingShenChallengeModel.instance:saveFightInfo(msg)

	self._formationStart = true

	if self._formTeamEnd and self._formationStart then
		self:onEnterFormation()
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgNotifyStartRes)
end

function LingShenChallengeController:handlePM_LingShenClgNotifyFormChangeRes(msg)
	LingShenChallengeModel.instance:saveFightInfoFrom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgNotifyFormChangeRes, msg.formPlayerId, msg.formSuc)
end

function LingShenChallengeController:handlePM_LingShenClgNotifyReadyRes(msg)
	if msg.readySuc == true then
		LingShenChallengeModel.instance:setReadyStatus(msg.readPlayerId)
	end

	LingShenChallengeModel.instance:saveFightInfoFrom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgNotifyReadyRes, msg.readPlayerId, msg.readySuc)
end

function LingShenChallengeController:handlePM_LingShenClgNotifyResultRes(status, msg)
	if checknumber(status) ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgNotifyResultErrorRes)
		UIJumper.instance:pushOneStack(ViewName.FormTeamCurTeamView, true)

		return
	end

	LingShenChallengeModel.instance:setBossInfo(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	self:handleBattleResults(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgNotifyResultRes)
end

function LingShenChallengeController:handleBattleResults(msg)
	FormTeamModel.instance:resetCurTeamData()

	self._curBtlResultIdx = 1
	self._btlResultList = msg.btlResult

	local btlResult = msg.btlResult

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
		GlobalDispatcher:dispatch(GlobalNotify.PM_LingShenClgNotifyResultErrorRes)
		UIJumper.instance:pushOneStack(ViewName.FormTeamCurTeamView, true)
	else
		local params = {}
		local bossInfo = LingShenChallengeModel.instance:getBossInfo(msg.activityId, msg.bossId)

		params.curTotalDamage = checknumber(msg.damage)
		params.maxBossHp = checknumber(bossInfo.bossTotalHp)
		params.conditionStr = lang("造成伤害")

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.LingShenChallenge, params)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
		BattleFacade.instance:registerResultHandler(function()
			ViewMgr.instance:open(ViewName.LingShenChallengeResultView)

			return true
		end)
		UIJumper.instance:pushOneStack(ViewName.FormTeamCurTeamView, true)
	end
end

function LingShenChallengeController:handlerInviteInChat(handler)
	self.tempHandler = handler

	self:sendPM_LingShenClgGetInfoReq()
end

LingShenChallengeController.instance = LingShenChallengeController.New()

return LingShenChallengeController
