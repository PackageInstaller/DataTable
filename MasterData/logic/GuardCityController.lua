-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/controller/GuardCityController.lua

module("logic.extensions.guardcity.controller.GuardCityController", package.seeall)

local GuardCityController = class("GuardCityController", BaseController)

GuardCityController.HMode_Default = 1
GuardCityController.HMode_Help = 2

function GuardCityController:ctor()
	return
end

function GuardCityController:onInit()
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityGetInfoRes, self.handlePM_GuardCityGetInfoRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityChallengeRes, self.handlePM_GuardCityChallengeRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityChallengeResultRes, self.handlePM_GuardCityChallengeResultRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityRefreshRes, self.handlePM_GuardCityRefreshRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityGetPrizeInfoRes, self.handlePM_GuardCityGetPrizeInfoRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityGainPrizeRes, self.handlePM_GuardCityGainPrizeRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityGetReportInfoRes, self.handlePM_GuardCityGetReportInfoRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityConveneFriendRes, self.handlePM_GuardCityConveneFriendRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityViewSeekHelpRes, self.handlePM_GuardCityViewSeekHelpRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityViewFriendScoreRes, self.handlePM_GuardCityViewFriendScoreRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityGainFriendPrizeRes, self.handlePM_GuardCityGainFriendPrizeRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityGainProgressPrizeRes, self.handlePM_GuardCityGainProgressPrizeRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityViewRankRes, self.handlePM_GuardCityViewRankRes, self)
	GlobalDispatcher:addListener(GuardCityAgent.PM_GuardCityBuyStrengthRes, self.handlePM_GuardCityBuyStrengthRes, self)
	self:onReset()
end

function GuardCityController:onReset()
	self._helpMode = GuardCityController.HMode_Default

	self:onEndBattleAnim()
end

function GuardCityController:startHelp()
	self._helpMode = GuardCityController.HMode_Help
	self._sendingId = nil

	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function GuardCityController:endHelp()
	self._helpMode = GuardCityController.HMode_Default
	self._sendingId = nil

	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function GuardCityController:getHelpMode()
	return self._helpMode
end

function GuardCityController:readySendHelp(masterUniqueId)
	self._sendingId = masterUniqueId
end

function GuardCityController:_onSelectFriend(ids)
	if self._sendingId and #ids > 0 then
		local info = GuardCiytModel.instance:getMasterInfo(self._sendingId)

		if info then
			GuardCityAgent.instance:sendPM_GuardCityConveneFriendReq(GuardCiytModel.instance:getCurActId(), self._sendingId, ids, info.creepsMasterId)
		end
	end

	self._sendingId = nil
end

function GuardCityController:getIsWin()
	return self._isWin or false
end

function GuardCityController:getIsFail()
	return self._isFail or false
end

function GuardCityController:getIsInAmin()
	return self._isInAmin
end

function GuardCityController:getIsFromBattle()
	return self._isFromBattle
end

function GuardCityController:getAttackId()
	return self._battleAttackId
end

function GuardCityController:getIsKillBoss()
	return self._isKillBoss
end

function GuardCityController:resetMapStage()
	self._isWin = false
	self._isFail = false
	self._isInAmin = false
end

function GuardCityController:onEndBattleAnim()
	self._isInAmin = false
	self._isFromBattle = false
	self._isWin = false
	self._isFail = false
	self._isKillBoss = false
	self._battleAttackId = 0
end

function GuardCityController:onCostAutoChange()
	GuardCiytModel.instance:onClockStrengthChange()
	GlobalDispatcher:dispatch(GlobalNotify.GuardCityCostChange)
end

function GuardCityController:handlePM_GuardCityGetInfoRes(status, msg)
	GuardCiytModel.instance:saveGameInfo(msg)
	self:resetMapStage()

	if self._isFromBattle and self._isFromBattle == true then
		local preData = GuardCiytModel.instance:getPreData()
		local readyAttackNum = #preData.readyAttack
		local totalMaster = preData.masterCount

		if self._isKillBoss == true then
			for i, v in ipairs(preData.readyAttack) do
				if v.masterUniqueId == self._battleAttackId then
					readyAttackNum = readyAttackNum - 1

					break
				end
			end

			totalMaster = totalMaster - 1
		end

		if totalMaster <= 0 then
			self._isWin = true
		end

		if readyAttackNum >= preData.cityHp then
			self._isFail = true
		elseif totalMaster <= readyAttackNum then
			self._isWin = true
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityGetInfoRes, status)
end

function GuardCityController:sendPM_GuardCityChallengeReq(activityId, targetPlayerId, masterUniqueId, form, strongChallenge, creepsMasterId)
	self._battleAttackId = masterUniqueId
	self._challengeCreepsMasterId = creepsMasterId
	self._challengeActivityId = activityId

	GuardCityAgent.instance:sendPM_GuardCityChallengeReq(activityId, targetPlayerId, masterUniqueId, form, strongChallenge)
end

function GuardCityController:handlePM_GuardCityChallengeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityChallengeRes)

	if status < 0 then
		FloatWordMgr.instance:show(lang("恶灵已消失"))
		GlobalDispatcher:dispatch(GlobalNotify.GuardCityMasterDeadByOther)
	end
end

function GuardCityController:handlePM_GuardCityChallengeResultRes(msg)
	self._isFromBattle = true

	if msg.win == true then
		self._isKillBoss = true
	end

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GuardCiytModel.instance:setBossInfo(msg)
	BattleFacade.instance:startGuardCityChallengeBattle(self._challengeActivityId, self._challengeCreepsMasterId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityChallengeResultRes)
end

function GuardCityController:handlePM_GuardCityRefreshRes(msg)
	GuardCiytModel.instance:setRefreshInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityRefreshRes)
end

function GuardCityController:handlePM_GuardCityGetPrizeInfoRes(msg)
	GuardCiytModel.instance:setRewardScoreInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityGetPrizeInfoRes)
end

function GuardCityController:handlePM_GuardCityGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityGainPrizeRes)
end

function GuardCityController:handlePM_GuardCityGetReportInfoRes(msg)
	GuardCiytModel.instance:setReportInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityGetReportInfoRes)
end

function GuardCityController:handlePM_GuardCityConveneFriendRes(msg)
	FloatWordMgr.instance:show(lang("求助请求发送成功"))
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityConveneFriendRes)
end

function GuardCityController:handlePM_GuardCityViewSeekHelpRes(msg)
	GuardCiytModel.instance:setHelpInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityViewSeekHelpRes)
end

function GuardCityController:handlePM_GuardCityViewFriendScoreRes(msg)
	GuardCiytModel.instance:setFriendScoreInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityViewFriendScoreRes)
end

function GuardCityController:handlePM_GuardCityGainFriendPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityGainFriendPrizeRes)
end

function GuardCityController:handlePM_GuardCityGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityGainProgressPrizeRes)
end

function GuardCityController:handlePM_GuardCityViewRankRes(msg)
	GuardCiytModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityViewRankRes)
end

function GuardCityController:handlePM_GuardCityBuyStrengthRes(msg)
	GuardCiytModel.instance:setBuyStrengeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GuardCityBuyStrengthRes)
end

GuardCityController.instance = GuardCityController.New()

return GuardCityController
