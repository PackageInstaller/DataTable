-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/controller/GodLongYanController.lua

module("logic.extensions.godlongyan.controller.GodLongYanController", package.seeall)

local GodLongYanController = class("GodLongYanController", BaseController)

function GodLongYanController:ctor()
	return
end

function GodLongYanController:onInit()
	self:onReset()
end

function GodLongYanController:onReset()
	return
end

function GodLongYanController:onSendGodLongYanChallengeGetInfoReq()
	GodLongYanAgent.instance:sendPM_GodLongYanChallengeGetInfoReq()
end

function GodLongYanController:onHandleGodLongYanChallengeGetInfoRes(msg)
	GodLongYanModel.instance:onHandleGodLongYanChallengeGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanChallengeGetInfoRes)
end

function GodLongYanController:onSendGodLongYanChallengeUpgradeBuffReq(buffType)
	GodLongYanAgent.instance:sendPM_GodLongYanChallengeUpgradeBuffReq(buffType)
end

function GodLongYanController:onHandleGodLongYanChallengeUpgradeBuffRes(msg)
	GodLongYanModel.instance:onHandleGodLongYanChallengeUpgradeBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanUpgradeBuff)
end

function GodLongYanController:onSendGodLongYanChallengeFightReq()
	GodLongYanAgent.instance:sendPM_GodLongYanChallengeFightReq()
end

function GodLongYanController:onHandleGodLongYanChallengeFightRes(msg)
	GodLongYanModel.instance:onHandleGodLongYanChallengeFightRes(msg)
end

function GodLongYanController:onSendGodLongYanChallengeStartGameReq()
	local clientKey = math.random(1, 100000)

	GodLongYanAgent.instance:sendPM_GodLongYanChallengeStartGameReq(clientKey)
end

function GodLongYanController:onHandleGodLongYanChallengeStartGameRes(msg)
	GodLongYanModel.instance:onHandleGodLongYanChallengeStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanChallengeStartGameRes)
end

function GodLongYanController:onSendGodLongYanChallengeEndGameReq()
	local score = GodLongYanModel.instance:getGameScore()
	local encryptedKey = GodLongYanModel.instance:getEncryptedKey()

	GodLongYanAgent.instance:sendPM_GodLongYanChallengeEndGameReq(score, encryptedKey)
end

function GodLongYanController:onHandleGodLongYanChallengeEndGameRes(msg)
	GodLongYanModel.instance:onHandleGodLongYanChallengeEndGameRes(msg)

	local changeSetId = checknumber(msg.changeSetId)
	local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
	local prizeStrList = {}

	for _, mo in ipairs(matMos) do
		local prizeStr = mo:toString()

		table.insert(prizeStrList, prizeStr)
	end

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanChallengeEndGameRes, msg.changeSetId, prizeStrList)
end

function GodLongYanController:onHandleGodLongYanChallengeFinishRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)

	local oldCurStage = GodLongYanModel.instance:getCurStage()
	local newCurStage = msg.curStage

	if oldCurStage ~= newCurStage and newCurStage % 5 == 0 then
		GodLongYanModel.instance:setShowLevelTip()
	end

	GodLongYanModel.instance:onHandleGodLongYanChallengeFinishRes(msg)
end

function GodLongYanController:onGodLongYanChallengeOneKeyPassRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GodLongYanModel.instance:onGodLongYanChallengeOneKeyPassRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanChallengeOneKeyPassRes)
end

function GodLongYanController:onChallengeResetBuffRes(msg)
	GodLongYanModel.instance:onChallengeResetBuffRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodLongYanChallengeResetBuffRes)
end

function GodLongYanController:dailyRefresh()
	return
end

function GodLongYanController:showOneKeyReward()
	local changeSetId = GodLongYanModel.instance:getOneKeyChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

GodLongYanController.instance = GodLongYanController.New()

return GodLongYanController
