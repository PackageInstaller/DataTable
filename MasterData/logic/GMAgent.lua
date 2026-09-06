-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/agent/GMAgent.lua

module("logic.extensions.gm.agent.GMAgent", package.seeall)

local GMAgent = class("GMAgent", BaseAgent)

GMAgent.PM_CreateBtlDemoRes = "GMAgent_PM_CreateBtlDemoRes"
GMAgent.PM_CreateActionBtlDemoRes = "GMAgent_PM_CreateActionBtlDemoRes"
GMAgent.PM_CustomBattleRes = "GMAgent_PM_CustomBattleRes"
GMAgent.PM_CustomFightMonsterRes = "GMAgent_PM_CustomFightMonsterRes"
GMAgent.PM_UserFightMonsterRes = "GMAgent_PM_UserFightMonsterRes"
GMAgent.PM_ClearBattleCdRes = "GMAgent_PM_ClearBattleCdRes"
GMAgent.PM_AddMaterialsRes = "GMAgent_PM_AddMaterialsRes"
GMAgent.PM_SetOnlineTimeRes = "GMAgent_PM_SetOnlineTimeRes"
GMAgent.PM_DecMaterialsRes = "GMAgent_PM_DecMaterialsRes"
GMAgent.PM_MultiCustomBattleRes = "GMAgent_PM_MultiCustomBattleRes"
GMAgent.PM_NormalEvolveRes = "GMAgent_PM_NormalEvolveRes"
GMAgent.PM_SendMailRes = "GMAgent_PM_SendMailRes"
GMAgent.PM_EVEMonsterFightRes = "GMAgent_PM_EVEMonsterFightRes"
GMAgent.PM_ViewUserFightMonsterBtlResultRes = "GMAgent_PM_ViewUserFightMonsterBtlResultRes"
GMAgent.PM_RandomDelBuddyRes = "GMAgent_PM_RandomDelBuddyRes"
GMAgent.PM_HandleABuddyRequestRes = "GMAgent_PM_HandleABuddyRequestRes"
GMAgent.PM_StepOverTaskStepRes = "GMAgent_PM_StepOverTaskStepRes"
GMAgent.PM_StepOverTaskRes = "GMAgent_PM_StepOverTaskRes"
GMAgent.PM_SubmitRankRes = "GMAgent_PM_SubmitRankRes"
GMAgent.PM_ViewRankRes = "GMAgent_PM_ViewRankRes"
GMAgent.PM_GotoTaskStepRes = "GMAgent_PM_GotoTaskStepRes"
GMAgent.PM_ChangeUserBanStateRes = "GMAgent_PM_ChangeUserBanStateRes"
GMAgent.PM_ArenaChallengeRes = "GMAgent_PM_ArenaChallengeRes"
GMAgent.PM_BgmSendBroadcastRes = "GMAgent_PM_BgmSendBroadcastRes"
GMAgent.PM_BgmDeleteBroadcastRes = "GMAgent_PM_BgmDeleteBroadcastRes"
GMAgent.PM_TestBroadcastRes = "GMAgent_PM_TestBroadcastRes"
GMAgent.PM_AddThreeHeroesPointReq = "GMAgent_PM_AddThreeHeroesPointReq"
GMAgent.PM_LotterySimulateTimesRes = "GMAgent_PM_LotterySimulateTimesRes"
GMAgent.PM_LotterySimulateTargetsRes = "GMAgent_PM_LotterySimulateTargetsRes"
GMAgent.PM_PlotPassStageRes = "GMAgent_PM_PlotPassStageRes"
GMAgent.PM_AddFamilyScoreRes = "GMAgent_PM_AddFamilyScoreRes"
GMAgent.PM_ModifyDonateValueRes = "GMAgent_PM_ModifyDonateValueRes"
GMAgent.PM_RefreshFamilyListRes = "GMAgent_PM_RefreshFamilyListRes"
GMAgent.PM_DeleteAllEquipmentsRes = "GMAgent_PM_DeleteAllEquipmentsRes"
GMAgent.PM_GetUserPetPropertyRes = "GMAgent_PM_GetUserPetPropertyRes"
GMAgent.PM_DeletePetsRes = "GMAgent_PM_DeletePetsRes"
GMAgent.PM_ResetFamilyBossClgTimesRes = "GMAgent_PM_ResetFamilyBossClgTimesRes"
GMAgent.PM_FakeFinishPayOrderRes = "GMAgent_PM_FakeFinishPayOrderRes"
GMAgent.PM_GenUserPetRes = "GMAgent_PM_GenUserPetRes"
GMAgent.PM_RefreshKingRoadInfoRes = "GMAgent_PM_RefreshKingRoadInfoRes"
GMAgent.PM_LotteryCycleRes = "GMAgent_PM_LotteryCycleRes"
GMAgent.PM_GenTempLoginAuthCodeRes = "GMAgent_PM_GenTempLoginAuthCodeRes"
GMAgent.PM_GmZooHatchSlotProcessRes = "GMAgent_PM_GmZooHatchSlotProcessRes"
GMAgent.PM_SeasonModePveMapJumpRes = "GMAgent_PM_SeasonModePveMapJumpRes"

function GMAgent:ctor()
	return
end

function GMAgent:setExtId(extId)
	GMAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function GMAgent:sendPM_CreateBtlDemoReq(changeSetId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_CreateBtlDemoReq()

	req.changeSetId = changeSetId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_CreateBtlDemoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_CreateBtlDemoRes(status, msg)
	self:dispatch(GMAgent.PM_CreateBtlDemoRes, status, msg)
end

function GMAgent:sendPM_CreateActionBtlDemoReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_CreateActionBtlDemoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_CreateActionBtlDemoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_CreateActionBtlDemoRes(status, msg)
	self:dispatch(GMAgent.PM_CreateActionBtlDemoRes, status, msg)
end

function GMAgent:sendPM_CustomBattleReq(customMasterA_pb, customMasterB_pb, battleBackground, battleMode, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_CustomBattleReq()

	if customMasterA_pb ~= nil then
		req.customMasterA:ParseFromString(customMasterA_pb:SerializeToString())
	end

	if customMasterB_pb ~= nil then
		req.customMasterB:ParseFromString(customMasterB_pb:SerializeToString())
	end

	req.battleBackground = battleBackground
	req.battleMode = battleMode

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_CustomBattleRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_CustomBattleRes(status, msg)
	if status ~= 0 then
		BattleModel.instance.testBattleSkinId = 0
		BattleModel.instance.testBattleUISkinId = 0
	end

	self:dispatch(GMAgent.PM_CustomBattleRes, status, msg)
end

function GMAgent:sendPM_CustomFightMonsterReq(myCustomMaster_pb, monsterId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_CustomFightMonsterReq()

	if myCustomMaster_pb ~= nil then
		req.myCustomMaster:ParseFromString(myCustomMaster_pb:SerializeToString())
	end

	req.monsterId = monsterId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_CustomFightMonsterRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_CustomFightMonsterRes(status, msg)
	self:dispatch(GMAgent.PM_CustomFightMonsterRes, status, msg)
end

function GMAgent:sendPM_UserFightMonsterReq(configNumber, monsterId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_UserFightMonsterReq()

	req.configNumber = configNumber
	req.monsterId = monsterId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_UserFightMonsterRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_UserFightMonsterRes(status, msg)
	self:dispatch(GMAgent.PM_UserFightMonsterRes, status, msg)
end

function GMAgent:sendPM_ClearBattleCdReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ClearBattleCdReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ClearBattleCdRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ClearBattleCdRes(status, msg)
	self:dispatch(GMAgent.PM_ClearBattleCdRes, status, msg)
end

function GMAgent:sendPM_AddMaterialsReq(materials, getApproachId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_AddMaterialsReq()

	req.materials = materials

	if getApproachId ~= nil then
		req.getApproachId = getApproachId
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_AddMaterialsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_AddMaterialsRes(status, msg)
	self:dispatch(GMAgent.PM_AddMaterialsRes, status, msg)
end

function GMAgent:sendPM_SetOnlineTimeReq(onlineSec, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_SetOnlineTimeReq()

	req.onlineSec = onlineSec

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_SetOnlineTimeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_SetOnlineTimeRes(status, msg)
	self:dispatch(GMAgent.PM_SetOnlineTimeRes, status, msg)
end

function GMAgent:sendPM_DecMaterialsReq(materials, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_DecMaterialsReq()

	req.materials = materials

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_DecMaterialsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_DecMaterialsRes(status, msg)
	self:dispatch(GMAgent.PM_DecMaterialsRes, status, msg)
end

function GMAgent:sendPM_MultiCustomBattleReq(customMasterA_pb, customMasterB_pb, battleBackground, fightCount, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_MultiCustomBattleReq()

	if customMasterA_pb ~= nil then
		req.customMasterA:ParseFromString(customMasterA_pb:SerializeToString())
	end

	if customMasterB_pb ~= nil then
		req.customMasterB:ParseFromString(customMasterB_pb:SerializeToString())
	end

	req.battleBackground = battleBackground
	req.fightCount = fightCount

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_MultiCustomBattleRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_MultiCustomBattleRes(status, msg)
	self:dispatch(GMAgent.PM_MultiCustomBattleRes, status, msg)
end

function GMAgent:sendPM_NormalEvolveReq(packPetId, targetRaceId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_NormalEvolveReq()

	req.packPetId = packPetId
	req.targetRaceId = targetRaceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_NormalEvolveRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_NormalEvolveRes(status, msg)
	self:dispatch(GMAgent.PM_NormalEvolveRes, status, msg)
end

function GMAgent:sendPM_SendMailReq(receiveName, senderName, templateId, title, content, mailParams, attachment, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_SendMailReq()

	req.receiveName = receiveName

	if senderName ~= nil then
		req.senderName = senderName
	end

	if templateId ~= nil then
		req.templateId = templateId
	end

	if title ~= nil then
		req.title = title
	end

	if content ~= nil then
		req.content = content
	end

	if mailParams ~= nil then
		req.mailParams = mailParams
	end

	if attachment ~= nil then
		req.attachment = attachment
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_SendMailRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_SendMailRes(status, msg)
	self:dispatch(GMAgent.PM_SendMailRes, status, msg)
end

function GMAgent:sendPM_EVEMonsterFightReq(monsterAId, monsterBId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_EVEMonsterFightReq()

	req.monsterAId = monsterAId
	req.monsterBId = monsterBId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_EVEMonsterFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_EVEMonsterFightRes(status, msg)
	self:dispatch(GMAgent.PM_EVEMonsterFightRes, status, msg)
end

function GMAgent:sendPM_ViewUserFightMonsterBtlResultReq(battleId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ViewUserFightMonsterBtlResultReq()

	req.battleId = battleId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ViewUserFightMonsterBtlResultRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ViewUserFightMonsterBtlResultRes(status, msg)
	self:dispatch(GMAgent.PM_ViewUserFightMonsterBtlResultRes, status, msg)
end

function GMAgent:sendPM_RandomDelBuddyReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_RandomDelBuddyReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_RandomDelBuddyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_RandomDelBuddyRes(status, msg)
	self:dispatch(GMAgent.PM_RandomDelBuddyRes, status, msg)
end

function GMAgent:sendPM_HandleABuddyRequestReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_HandleABuddyRequestReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_HandleABuddyRequestRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_HandleABuddyRequestRes(status, msg)
	self:dispatch(GMAgent.PM_HandleABuddyRequestRes, status, msg)
end

function GMAgent:sendPM_StepOverTaskStepReq(taskId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_StepOverTaskStepReq()

	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_StepOverTaskStepRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_StepOverTaskStepRes(status, msg)
	self:dispatch(GMAgent.PM_StepOverTaskStepRes, status, msg)
end

function GMAgent:sendPM_StepOverTaskReq(taskId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_StepOverTaskReq()

	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_StepOverTaskRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_StepOverTaskRes(status, msg)
	self:dispatch(GMAgent.PM_StepOverTaskRes, status, msg)
end

function GMAgent:sendPM_SubmitRankReq(rankId, termId, value, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_SubmitRankReq()

	req.rankId = rankId
	req.termId = termId
	req.value = value

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_SubmitRankRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_SubmitRankRes(status, msg)
	self:dispatch(GMAgent.PM_SubmitRankRes, status, msg)
end

function GMAgent:sendPM_ViewRankReq(rankId, startRank, endRank, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ViewRankReq()

	req.rankId = rankId
	req.startRank = startRank
	req.endRank = endRank

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ViewRankRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ViewRankRes(status, msg)
	self:dispatch(GMAgent.PM_ViewRankRes, status, msg)
end

function GMAgent:sendPM_GotoTaskStepReq(taskId, stepId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_GotoTaskStepReq()

	req.taskId = taskId
	req.stepId = stepId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_GotoTaskStepRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_GotoTaskStepRes(status, msg)
	self:dispatch(GMAgent.PM_GotoTaskStepRes, status, msg)
end

function GMAgent:sendPM_ChangeUserBanStateReq(account, banOpType, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ChangeUserBanStateReq()

	req.account = account
	req.banOpType = banOpType

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ChangeUserBanStateRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ChangeUserBanStateRes(status, msg)
	self:dispatch(GMAgent.PM_ChangeUserBanStateRes, status, msg)
end

function GMAgent:sendPM_ArenaChallengeReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ArenaChallengeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ArenaChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ArenaChallengeRes(status, msg)
	self:dispatch(GMAgent.PM_ArenaChallengeRes, status, msg)
end

function GMAgent:sendPM_BgmSendBroadcastReq(id, showdMode_s_Ary, startTime, endTime, frequency, content, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_BgmSendBroadcastReq()

	req.id = id

	for i, v1 in ipairs(showdMode_s_Ary) do
		req.showdMode:append(v1)
	end

	req.startTime = startTime
	req.endTime = endTime
	req.frequency = frequency
	req.content = content

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_BgmSendBroadcastRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_BgmSendBroadcastRes(status, msg)
	self:dispatch(GMAgent.PM_BgmSendBroadcastRes, status, msg)
end

function GMAgent:sendPM_BgmDeleteBroadcastReq(id, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_BgmDeleteBroadcastReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_BgmDeleteBroadcastRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_BgmDeleteBroadcastRes(status, msg)
	self:dispatch(GMAgent.PM_BgmDeleteBroadcastRes, status, msg)
end

function GMAgent:sendPM_TestBroadcastReq(msg, sync, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_TestBroadcastReq()

	req.msg = msg
	req.sync = sync

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_TestBroadcastRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_TestBroadcastRes(status, msg)
	self:dispatch(GMAgent.PM_TestBroadcastRes, status, msg)
end

function GMAgent:sendPM_AddThreeHeroesPointReq(challengeId, addPoint, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_AddThreeHeroesPointReq()

	req.challengeId = challengeId
	req.addPoint = addPoint

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_AddThreeHeroesPointReq, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_AddThreeHeroesPointReq(status, msg)
	self:dispatch(GMAgent.PM_AddThreeHeroesPointReq, status, msg)
end

function GMAgent:sendPM_LotterySimulateTimesReq(poolId, drawTimes, repeatTimes, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_LotterySimulateTimesReq()

	req.poolId = poolId
	req.drawTimes = drawTimes
	req.repeatTimes = repeatTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_LotterySimulateTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_LotterySimulateTimesRes(status, msg)
	self:dispatch(GMAgent.PM_LotterySimulateTimesRes, status, msg)
end

function GMAgent:sendPM_LotterySimulateTargetsReq(poolId, targetRaceIds_i32_Ary, repeatTimes, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_LotterySimulateTargetsReq()

	req.poolId = poolId

	for i, v2 in ipairs(targetRaceIds_i32_Ary) do
		req.targetRaceIds:append(v2)
	end

	req.repeatTimes = repeatTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_LotterySimulateTargetsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_LotterySimulateTargetsRes(status, msg)
	self:dispatch(GMAgent.PM_LotterySimulateTargetsRes, status, msg)
end

function GMAgent:sendPM_PlotPassStageReq(chapterId, stageId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_PlotPassStageReq()

	req.chapterId = chapterId
	req.stageId = stageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_PlotPassStageRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_PlotPassStageRes(status, msg)
	self:dispatch(GMAgent.PM_PlotPassStageRes, status, msg)
end

function GMAgent:sendPM_AddFamilyScoreReq(familyScore, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_AddFamilyScoreReq()

	req.familyScore = familyScore

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_AddFamilyScoreRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_AddFamilyScoreRes(status, msg)
	self:dispatch(GMAgent.PM_AddFamilyScoreRes, status, msg)
end

function GMAgent:sendPM_ModifyDonateValueReq(donateValue, isAdd, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ModifyDonateValueReq()

	req.donateValue = donateValue
	req.isAdd = isAdd

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ModifyDonateValueRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ModifyDonateValueRes(status, msg)
	self:dispatch(GMAgent.PM_ModifyDonateValueRes, status, msg)
end

function GMAgent:sendPM_RefreshFamilyListReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_RefreshFamilyListReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_RefreshFamilyListRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_RefreshFamilyListRes(status, msg)
	self:dispatch(GMAgent.PM_RefreshFamilyListRes, status, msg)
end

function GMAgent:sendPM_DeleteAllEquipmentsReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_DeleteAllEquipmentsReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_DeleteAllEquipmentsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_DeleteAllEquipmentsRes(status, msg)
	self:dispatch(GMAgent.PM_DeleteAllEquipmentsRes, status, msg)
end

function GMAgent:sendPM_GetUserPetPropertyReq(petId, fullPublicStrengthens, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_GetUserPetPropertyReq()

	req.petId = petId

	if fullPublicStrengthens then
		req.fullPublicStrengthens = fullPublicStrengthens
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_GetUserPetPropertyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_GetUserPetPropertyRes(status, msg)
	self:dispatch(GMAgent.PM_GetUserPetPropertyRes, status, msg)
end

function GMAgent:sendPM_DeletePetsReq(petId_i32_Ary, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_DeletePetsReq()

	for i, v3 in ipairs(petId_i32_Ary) do
		req.petId:append(v3)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_DeletePetsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_DeletePetsRes(status, msg)
	self:dispatch(GMAgent.PM_DeletePetsRes, status, msg)
end

function GMAgent:sendPM_ResetFamilyBossClgTimesReq(bossId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_ResetFamilyBossClgTimesReq()

	req.bossId = bossId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_ResetFamilyBossClgTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_ResetFamilyBossClgTimesRes(status, msg)
	self:dispatch(GMAgent.PM_ResetFamilyBossClgTimesRes, status, msg)
end

function GMAgent:sendPM_FakeFinishPayOrderReq(orderNo, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_FakeFinishPayOrderReq()

	req.orderNo = orderNo

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_FakeFinishPayOrderRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_FakeFinishPayOrderRes(status, msg)
	self:dispatch(GMAgent.PM_FakeFinishPayOrderRes, status, msg)
end

function GMAgent:sendPM_GenUserPetReq(raceId, curLv, talentLv, awakenLv, num, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_GenUserPetReq()

	req.raceId = raceId
	req.curLv = curLv
	req.talentLv = talentLv
	req.awakenLv = awakenLv
	req.num = num

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_GenUserPetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_GenUserPetRes(status, msg)
	self:dispatch(GMAgent.PM_GenUserPetRes, status, msg)
end

function GMAgent:sendPM_RefreshKingRoadInfoReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_RefreshKingRoadInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_RefreshKingRoadInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_RefreshKingRoadInfoRes(status, msg)
	self:dispatch(GMAgent.PM_RefreshKingRoadInfoRes, status, msg)
end

function GMAgent:sendPM_LotteryCycleReq(poolId, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_LotteryCycleReq()

	req.poolId = poolId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_LotteryCycleRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_LotteryCycleRes(status, msg)
	self:dispatch(GMAgent.PM_LotteryCycleRes, status, msg)
end

function GMAgent:sendPM_GenTempLoginAuthCodeReq(handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_GenTempLoginAuthCodeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_GenTempLoginAuthCodeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_GenTempLoginAuthCodeRes(status, msg)
	self:dispatch(GMAgent.PM_GenTempLoginAuthCodeRes, status, msg)
end

function GMAgent:sendPM_GmZooHatchSlotProcessReq(type, slotId, name, handler, handlerObj, errHandler)
	local req = GMExtension_pb.PM_GmZooHatchSlotProcessReq()

	req.type = type

	if slotId ~= nil then
		req.slotId = slotId
	end

	if name ~= nil then
		req.name = name
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GMAgent.PM_GmZooHatchSlotProcessRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GMAgent:handlePM_GmZooHatchSlotProcessRes(status, msg)
	self:dispatch(GMAgent.PM_GmZooHatchSlotProcessRes, status, msg)
end

function GMAgent:sendPM_SeasonModePveMapJumpReq(targetPointId, teamId)
	local req = GMExtension_pb.PM_SeasonModePveMapJumpReq()

	req.targetPointId = targetPointId
	req.teamId = teamId

	self:sendMsg(req)
end

function GMAgent:handlePM_SeasonModePveMapJumpRes(status, msg)
	self:dispatch(GMAgent.PM_SeasonModePveMapJumpRes, status, msg)
end

function GMAgent:sendPM_GM_DomainAdventureIncProgressReq(activityId, blockId, incProgress)
	local req = GMExtension_pb.PM_GM_DomainAdventureIncProgressReq()

	req.activityId = activityId
	req.blockId = blockId
	req.incProgress = incProgress

	self:sendMsg(req)
end

function GMAgent:handlePM_GM_DomainAdventureIncProgressRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GMAgent:sendPM_GM_AddAllSsrAndSkinsReq()
	local req = GMExtension_pb.PM_GM_AddAllSsrAndSkinsReq()

	self:sendMsg(req)
end

function GMAgent:handlePM_GM_AddAllSsrAndSkinsRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GMAgent:sendPM_RejectShutdownServerReq()
	local req = GMExtension_pb.PM_RejectShutdownServerReq()

	self:sendMsg(req)
end

function GMAgent:handlePM_RejectShutdownServerRes(status, msg)
	return
end

function GMAgent:handlePM_ReceivedShutdownServerRequestRes(status, msg)
	GlobalDispatcher:dispatch(GMModel.Notify.RECEIVED_SHUTDOWN_SERVER_REQUEST, checknumber(msg.delaySeconds))
end

function GMAgent:sendPM_MahjongBattleCoverMahjongReq(activityId, coverMahjongId_i32_Ary)
	local req = GMExtension_pb.PM_MahjongBattleCoverMahjongReq()

	req.activityId = activityId

	for i, v5 in ipairs(coverMahjongId_i32_Ary) do
		req.coverMahjongId:append(checknumber(v5))
	end

	self:sendMsg(req)
end

function GMAgent:handlePM_MahjongBattleCoverMahjongRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleGmCoverHandRes(msg)
	end
end

function GMAgent:sendPM_MahjongBattleChangeDrawMahjongReq(activityId, changeDrawMahjongId_i32_Ary)
	local req = GMExtension_pb.PM_MahjongBattleChangeDrawMahjongReq()

	req.activityId = activityId

	for i, v6 in ipairs(changeDrawMahjongId_i32_Ary) do
		req.changeDrawMahjongId:append(checknumber(v6))
	end

	self:sendMsg(req)
end

function GMAgent:handlePM_MahjongBattleChangeDrawMahjongRes(status, msg)
	if status == 0 then
		MahjongBattleController.instance:handleGmCoverSystemCardRes(msg)
	end
end

function GMAgent:sendPM_BattleKMPLogSwitchReq(switch)
	local req = GMExtension_pb.PM_BattleKMPLogSwitchReq()

	req.switch = switch

	self:sendMsg(req)
end

function GMAgent:handlePM_BattleKMPLogSwitchRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GMAgent:handlePM_NotifyBattleKMPLogIdRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

GMAgent.instance = GMAgent.New()

return GMAgent
