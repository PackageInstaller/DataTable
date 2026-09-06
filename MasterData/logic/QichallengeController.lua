-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/controller/QichallengeController.lua

module("logic.extensions.qichallenge.controller.QichallengeController", package.seeall)

local QichallengeController = class("QichallengeController", BaseController)

function QichallengeController:onReset()
	return
end

function QichallengeController:handlePM_QiChallengeGetInfoRes(msg)
	QiChallengeModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeGetInfoRes)
end

function QichallengeController:handlePM_QiChallengeAllSealRes(msg)
	QiChallengeModel.instance:setBlockRaceInfo(msg)
	FloatWordMgr.instance:show(lang("封印成功，被封印的精灵上场将无法拥有气势"))
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeAllSealRes)
end

function QichallengeController:handlePM_QiChallengeAllRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeAllRes)
end

function QichallengeController:handlePM_QiChallengeAllResultRes(msg)
	if msg.changeSetId ~= nil then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	if msg.win and msg.win == true then
		QiChallengeModel.instance:setAllBattleEnd(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeAllResultRes)
end

function QichallengeController:handlePM_QiChallengeExtremeResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeExtremeResetRes)
end

function QichallengeController:handlePM_QiChallengeExtremeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeExtremeRes)
end

function QichallengeController:handlePM_QiChallengeExtremeResultRes(msg)
	if msg.changeSetId ~= nil then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_QiChallengeExtremeResultRes)
end

QichallengeController.instance = QichallengeController.New()

return QichallengeController
