-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/controller/DragonXiuerController.lua

module("logic.extensions.dragonxiuer.controller.DragonXiuerController", package.seeall)

local DragonXiuerController = class("DragonXiuerController", BaseController)

function DragonXiuerController:onInit()
	self:onReset()
end

function DragonXiuerController:onReset()
	self._needNotifyReset = nil
end

function DragonXiuerController:handlePM_DragonXiuerGetInfoRes(msg)
	DragonXiuerModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DragonXiuerGetInfoRes)
end

function DragonXiuerController:sendPM_DragonXiuerChallengeDestroyModeReq(activityId, stageId, teamIndex, form)
	self._tempActId = activityId
	self._tempStageId = stageId
	self._tempIndex = teamIndex + 1

	DragonXiuerAgent.instance:sendPM_DragonXiuerChallengeDestroyModeReq(activityId, stageId, teamIndex, form)
end

function DragonXiuerController:handlePM_DragonXiuerChallengeDestroyModeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DragonXiuerChallengeDestroyModeRes)
end

function DragonXiuerController:sendPM_DragonXiuerChallengeSoulModeReq(activityId, form)
	self._tempActId = activityId

	DragonXiuerAgent.instance:sendPM_DragonXiuerChallengeSoulModeReq(activityId, form)
end

function DragonXiuerController:handlePM_DragonXiuerChallengeSoulModeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DragonXiuerChallengeSoulModeRes)
end

function DragonXiuerController:sendPM_DragonXiuerResetDestroyModeTeamReq(activityId, stageId, teamIndex)
	DragonXiuerModel.instance:resetStageInfo(activityId, stageId, teamIndex)
	DragonXiuerAgent.instance:sendPM_DragonXiuerResetDestroyModeTeamReq(activityId, stageId, teamIndex - 1)
end

function DragonXiuerController:handlePM_DragonXiuerResetDestroyModeTeamRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DragonXiuerResetDestroyModeTeamRes)
end

function DragonXiuerController:handlePM_Notify_DragonXiuerDestroyModeRes(msg)
	if msg.win then
		DragonXiuerModel.instance:setFromStageEnd(msg, self._tempActId, self._tempStageId, self._tempIndex)
	end

	self._tempActId = nil
	self._tempStageId = nil
	self._tempIndex = nil

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_Notify_DragonXiuerDestroyModeRes)
end

function DragonXiuerController:handlePM_Notify_DragonXiuerSoulModeRes(msg)
	local params = {}

	params.curNumA = 50
	params.totalNumA = 100
	params.descA = langPara("%s血量", "王者")
	params.colorA = "#EB4642FF"
	params.curNumB = 70
	params.totalNumB = 100
	params.descB = langPara("%s血量", "霸业")
	params.title = lang("Boss剩余血量")
	params.colorB = "#00FF2CFF"

	if msg.currentInfo then
		DragonXiuerModel.instance:saveBossInfo(msg.currentInfo, self._tempActId)

		local bossCfgInfo = DragonXiuerModel.instance:getBossCfgInfo()

		params.descA = langPara("%s血量 ", bossCfgInfo[1].name)
		params.descB = langPara("%s血量 ", bossCfgInfo[2].name)
		params.totalNumA = bossCfgInfo[1].totalHp
		params.totalNumB = bossCfgInfo[2].totalHp

		local bossAInfo = DragonXiuerModel.instance:getBossInfo(self._tempActId, 1)
		local bossBInfo = DragonXiuerModel.instance:getBossInfo(self._tempActId, 2)

		params.curNumA = bossAInfo and bossAInfo.bossHp or msg.currentInfo.passed == true and 0 or bossCfgInfo[1].totalHp
		params.curNumB = bossBInfo and bossBInfo.bossHp or msg.currentInfo.passed == true and 0 or bossCfgInfo[2].totalHp

		if not msg.currentInfo.passed and checknumber(msg.currentInfo.hasChallengeTimes) <= 0 then
			self._needNotifyReset = true
		end

		if msg.changeSetId then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end
	end

	self._tempActId = nil

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DragonXiuerBossChallenge, params)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_Notify_DragonXiuerSoulModeRes)
end

function DragonXiuerController:openBattleResultView()
	ViewMgr.instance:open(DragonXiuerModel.instance:getResultViewName())
end

function DragonXiuerController:isNeedNotifyReset()
	return self._needNotifyReset
end

function DragonXiuerController:resetNeedNotifyReset()
	self._needNotifyReset = nil
end

DragonXiuerController.instance = DragonXiuerController.New()

return DragonXiuerController
