-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/controller/NianNianChallController.lua

module("logic.extensions.niannianchall.controller.NianNianChallController", package.seeall)

local NianNianChallController = class("NianNianChallController", BaseController)

NianNianChallController.handlePM_ResetKamuiRes = "handlePM_ResetKamuiRes"
NianNianChallController.handlePM_ConfirmResetKamuiRes = "handlePM_ConfirmResetKamuiRes"

function NianNianChallController:ctor()
	return
end

function NianNianChallController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.NianNianChallResult, self.handleBattleRes, self)
	NianChallengeAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onShowChangeSet, self))
end

function NianNianChallController:onReset()
	return
end

function NianNianChallController:openMainView()
	if not NianNianChallModel.instance:getHasGetInfo() then
		GlobalDispatcher:addListener(GlobalNotify.NianNianChallGetInfo, self.doOpen, self)
		self:getInfo()
	else
		self:doOpen()
	end
end

function NianNianChallController:doOpen()
	GlobalDispatcher:removeListener(GlobalNotify.NianNianChallGetInfo, self.doOpen, self)
	UIStateManager.instance:push(ViewName.NianNianChallMainView)
end

function NianNianChallController:getInfo()
	if not NianNianChallModel.instance:getHasGetInfo() then
		NianChallengeAgent.instance:sendPM_NianChallengeInfoReq()
		NianNianChallModel.instance:setHasGetInfo(true)
	end
end

function NianNianChallController:sendChall()
	local formMo = NianNianChallModel.instance:getFormation()
	local simpleForm = formMo:createFormPb()

	simpleForm.formId = 0

	BattleFacade.instance:startNNCBattle()
	NianChallengeAgent.instance:sendPM_NianChallengeReq(simpleForm)
end

function NianNianChallController:sendGetBuff()
	NianChallengeAgent.instance:sendPM_NianChallengeGetBuffReq()
end

function NianNianChallController:sendGetPrize(id)
	NianChallengeAgent.instance:sendPM_NianChallengeGainProcessPrizeReq(id)
end

function NianNianChallController:openMission(stageId)
	local stageCfg = NianNianChallConfig.instance:getStageCfg(stageId)
	local supportPet = NianNianChallConfig.instance:getSupportCfg(stageCfg.supportCreepsId)

	NianNianChallModel.instance:setSupportPetCfg(supportPet)
	NianNianChallModel.instance:setFormation()
	UIStateManager.instance:push(ViewName.NNCMissionView)
end

function NianNianChallController:handleBattleRes(msg)
	BattleSettlementModel.instance:setRewardChangeSetId(msg.changeSetId, nil)
end

function NianNianChallController:saveFormation()
	local nncFmt = NianNianChallModel.instance:getFormation()
	local nncFormPos = nncFmt:GetPositions()
	local supportCfg = NianNianChallModel.instance:getSupportPetCfg()
	local outFmt = NianNianChallModel.instance._tempFormation
	local pos = {}

	for i = 1, 9 do
		pos[i] = supportCfg.creepsId ~= nncFormPos[i] and nncFormPos[i] or 0
	end

	outFmt:setPositionForce(pos)
end

function NianNianChallController:onShowChangeSet(changeSetId, msgName)
	if changeSetId == nil or changeSetId < 0 or msgName == "handlePM_NotifyNianChallengeEndRes" then
		-- block empty
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

NianNianChallController.instance = NianNianChallController.New()

return NianNianChallController
