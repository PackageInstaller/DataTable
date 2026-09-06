-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/agent/FamilyAgent.lua

module("logic.extensions.family.agent.FamilyAgent", package.seeall)

local FamilyAgent = class("FamilyAgent", BaseAgent)

FamilyAgent.GetFamilyViewsRes = "FamilyAgent_GetFamilyViewsRes"
FamilyAgent.SearchFamilyRes = "FamilyAgent_SearchFamilyRes"
FamilyAgent.CreateFamilyRes = "FamilyAgent_CreateFamilyRes"
FamilyAgent.ModifyFamilyDeclarationRes = "FamilyAgent_ModifyFamilyDeclarationRes"
FamilyAgent.ApplyJoinFamilyReq = "FamilyAgent_ApplyJoinFamilyReq"
FamilyAgent.OneKeyApplyJoinFamilyRes = "FamilyAgent_OneKeyApplyJoinFamilyRes"
FamilyAgent.CancelApplyJoinRes = "FamilyAgent_CancelApplyJoinRes"
FamilyAgent.GetMyFamilySimpleInfoRes = "FamilyAgent_GetMyFamilySimpleInfoRes"
FamilyAgent.GetMyFamilyInfoRes = "FamilyAgent_GetMyFamilyInfoRes"
FamilyAgent.GetFamilyApplyListRes = "FamilyAgent_GetFamilyApplyListRes"
FamilyAgent.HandleFamilyApplyRes = "FamilyAgent_HandleFamilyApplyRes"
FamilyAgent.BatchHandleFamilyApplyRes = "FamilyAgent_BatchHandleFamilyApplyRes"
FamilyAgent.GetFamilyMemberListRes = "FamilyAgent_GetFamilyMemberListRes"
FamilyAgent.LeaveFamilyRes = "FamilyAgent_LeaveFamilyRes"
FamilyAgent.KickUserOutFamilyRes = "FamilyAgent_KickUserOutFamilyRes"
FamilyAgent.ChangeFamilyRoleRes = "FamilyAgent_ChangeFamilyRoleRes"
FamilyAgent.GetFamilyEventLogsRes = "FamilyAgent_GetFamilyEventLogsRes"
FamilyAgent.ModifySettingsRes = "FamilyAgent_ModifySettingsRes"
FamilyAgent.NotifyJoinLeaveFamilyRes = "FamilyAgent_NotifyJoinLeaveFamilyRes"
FamilyAgent.NotifyFamilyLevelUpRes = "FamilyAgent_NotifyFamilyLevelUpRes"
FamilyAgent.GetDonatePoolInfoRes = "FamilyAgent_GetDonatePoolInfoRes"
FamilyAgent.FamilyDonateRes = "FamilyAgent_FamilyDonateRes"
FamilyAgent.GetUnlockedBossInfosRes = "FamilyAgent_GetUnlockedBossInfosRes"
FamilyAgent.OpenBossChallengeRes = "FamilyAgent_OpenBossChallengeRes"
FamilyAgent.ChallengeBossRes = "FamilyAgent_ChallengeBossRes"
FamilyAgent.SweepBossRes = "FamilyAgent_SweepBossRes"
FamilyAgent.BossClgEndRes = "FamilyAgent_BossClgEndRes"
FamilyAgent.DismissFamilyRes = "FamilyAgent_DismissFamilyRes"

function FamilyAgent:ctor()
	return
end

function FamilyAgent:setExtId(extId)
	FamilyAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
	MsgFlowMgr.instance:setIgoreOrderMsg(self._extId, 1)
end

function FamilyAgent:sendGetFamilyViewsReq(originIndex, lastEndIndex, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetFamilyViewsReq()

	req.originIndex = originIndex
	req.lastEndIndex = lastEndIndex

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetFamilyViewsRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetFamilyViewsRes(status, msg)
	self:dispatch(FamilyAgent.GetFamilyViewsRes, status, msg)
end

function FamilyAgent:sendSearchFamilyReq(keyword, familyId, moreDetail)
	local req = FamilyExtension_pb.SearchFamilyReq()

	req.keyword = keyword

	if familyId then
		req.familyId = familyId
	end

	if moreDetail then
		req.moreDetail = moreDetail
	end

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.SearchFamilyRes)
end

function FamilyAgent:handleSearchFamilyRes(status, msg)
	FamilyController.instance:handleSearchFamilyRes(msg)
	self:dispatch(FamilyAgent.SearchFamilyRes, status, msg)
end

function FamilyAgent:sendCreateFamilyReq(createFamilyParam_pb, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.CreateFamilyReq()

	if createFamilyParam_pb ~= nil then
		req.createFamilyParam:ParseFromString(createFamilyParam_pb:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.CreateFamilyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleCreateFamilyRes(status, msg)
	self:dispatch(FamilyAgent.CreateFamilyRes, status, msg)
end

function FamilyAgent:sendModifyFamilyDeclarationReq(declaration, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.ModifyFamilyDeclarationReq()

	req.declaration = declaration

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.ModifyFamilyDeclarationRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleModifyFamilyDeclarationRes(status, msg)
	self:dispatch(FamilyAgent.ModifyFamilyDeclarationRes, status, msg)
end

function FamilyAgent:sendApplyJoinFamilyReq(familyId, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.ApplyJoinFamilyReq()

	req.familyId = familyId

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.ApplyJoinFamilyReq, handler, handlerObj, errHandler)
end

function FamilyAgent:handleApplyJoinFamilyReq(status, msg)
	self:dispatch(FamilyAgent.ApplyJoinFamilyReq, status, msg)
end

function FamilyAgent:sendOneKeyApplyJoinFamilyReq(familyIds_i32_Ary, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.OneKeyApplyJoinFamilyReq()

	for i, v1 in ipairs(familyIds_i32_Ary) do
		req.familyIds:append(v1)
	end

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.OneKeyApplyJoinFamilyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleOneKeyApplyJoinFamilyRes(status, msg)
	self:dispatch(FamilyAgent.OneKeyApplyJoinFamilyRes, status, msg)
end

function FamilyAgent:sendCancelApplyJoinReq(familyId, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.CancelApplyJoinReq()

	req.familyId = familyId

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.CancelApplyJoinRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleCancelApplyJoinRes(status, msg)
	self:dispatch(FamilyAgent.CancelApplyJoinRes, status, msg)
end

function FamilyAgent:sendGetMyFamilySimpleInfoReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetMyFamilySimpleInfoReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetMyFamilySimpleInfoRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetMyFamilySimpleInfoRes(status, msg)
	self:dispatch(FamilyAgent.GetMyFamilySimpleInfoRes, status, msg)
end

function FamilyAgent:sendGetMyFamilyInfoReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetMyFamilyInfoReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetMyFamilyInfoRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetMyFamilyInfoRes(status, msg)
	self:dispatch(FamilyAgent.GetMyFamilyInfoRes, status, msg)
end

function FamilyAgent:sendGetFamilyApplyListReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetFamilyApplyListReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetFamilyApplyListRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetFamilyApplyListRes(status, msg)
	self:dispatch(FamilyAgent.GetFamilyApplyListRes, status, msg)
end

function FamilyAgent:sendHandleFamilyApplyReq(applyUserId, agree, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.HandleFamilyApplyReq()

	req.applyUserId = applyUserId
	req.agree = agree

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.HandleFamilyApplyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleHandleFamilyApplyRes(status, msg)
	self:dispatch(FamilyAgent.HandleFamilyApplyRes, status, msg)
end

function FamilyAgent:sendBatchHandleFamilyApplyReq(applyUserIdList_i64_Ary, agree, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.BatchHandleFamilyApplyReq()

	for i, v2 in ipairs(applyUserIdList_i64_Ary) do
		req.applyUserIdList:append(v2)
	end

	req.agree = agree

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.BatchHandleFamilyApplyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleBatchHandleFamilyApplyRes(status, msg)
	self:dispatch(FamilyAgent.BatchHandleFamilyApplyRes, status, msg)
end

function FamilyAgent:sendGetFamilyMemberListReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetFamilyMemberListReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetFamilyMemberListRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetFamilyMemberListRes(status, msg)
	self:dispatch(FamilyAgent.GetFamilyMemberListRes, status, msg)
end

function FamilyAgent:sendLeaveFamilyReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.LeaveFamilyReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.LeaveFamilyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleLeaveFamilyRes(status, msg)
	self:dispatch(FamilyAgent.LeaveFamilyRes, status, msg)
end

function FamilyAgent:sendKickUserOutFamilyReq(userIds, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.KickUserOutFamilyReq()

	for i = 1, #userIds do
		req.kickUserId:append(userIds[i])
	end

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.KickUserOutFamilyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleKickUserOutFamilyRes(status, msg)
	self:dispatch(FamilyAgent.KickUserOutFamilyRes, status, msg)
end

function FamilyAgent:sendChangeFamilyRoleReq(memberId, newRole_pb, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.ChangeFamilyRoleReq()

	req.memberId = memberId
	req.newRole = newRole_pb

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.ChangeFamilyRoleRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleChangeFamilyRoleRes(status, msg)
	self:dispatch(FamilyAgent.ChangeFamilyRoleRes, status, msg)
end

function FamilyAgent:sendGetFamilyEventLogsReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetFamilyEventLogsReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetFamilyEventLogsRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetFamilyEventLogsRes(status, msg)
	self:dispatch(FamilyAgent.GetFamilyEventLogsRes, status, msg)
end

function FamilyAgent:sendModifySettingsReq(settings_pb, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.ModifySettingsReq()

	if settings_pb ~= nil then
		req.settings:ParseFromString(settings_pb:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.ModifySettingsRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleModifySettingsRes(status, msg)
	self:dispatch(FamilyAgent.ModifySettingsRes, status, msg)
end

function FamilyAgent:handleNotifyJoinLeaveFamilyRes(status, msg)
	self:dispatch(FamilyAgent.NotifyJoinLeaveFamilyRes, status, msg)
end

function FamilyAgent:handleNotifyFamilyLevelUpRes(status, msg)
	self:dispatch(FamilyAgent.NotifyFamilyLevelUpRes, status, msg)
end

function FamilyAgent:sendGetDonatePoolInfoReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetDonatePoolInfoReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetDonatePoolInfoRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetDonatePoolInfoRes(status, msg)
	self:dispatch(FamilyAgent.GetDonatePoolInfoRes, status, msg)
end

function FamilyAgent:sendFamilyDonateReq(donateCount, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.FamilyDonateReq()

	req.donateCount = donateCount

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.FamilyDonateRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleFamilyDonateRes(status, msg)
	self:dispatch(FamilyAgent.FamilyDonateRes, status, msg)
end

function FamilyAgent:sendGetUnlockedBossInfosReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.GetUnlockedBossInfosReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.GetUnlockedBossInfosRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleGetUnlockedBossInfosRes(status, msg)
	self:dispatch(FamilyAgent.GetUnlockedBossInfosRes, status, msg)
end

function FamilyAgent:sendOpenBossChallengeReq(bossId, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.OpenBossChallengeReq()

	req.bossId = bossId

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.OpenBossChallengeRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleOpenBossChallengeRes(status, msg)
	self:dispatch(FamilyAgent.OpenBossChallengeRes, status, msg)
end

function FamilyAgent:sendChallengeBossReq(bossId, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.ChallengeBossReq()

	req.bossId = bossId

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.ChallengeBossRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleChallengeBossRes(status, msg)
	self:dispatch(FamilyAgent.ChallengeBossRes, status, msg)
end

function FamilyAgent:sendSweepBossReq(bossId, handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.SweepBossReq()

	req.bossId = bossId

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.SweepBossRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleSweepBossRes(status, msg)
	self:dispatch(FamilyAgent.SweepBossRes, status, msg)
end

function FamilyAgent:handleBossClgEndRes(status, msg)
	self:dispatch(FamilyAgent.BossClgEndRes, status, msg)
end

function FamilyAgent:sendDismissFamilyReq(handler, handlerObj, errHandler)
	local req = FamilyExtension_pb.DismissFamilyReq()

	self:sendMsg(req)
	self:addEventOnce(FamilyAgent.DismissFamilyRes, handler, handlerObj, errHandler)
end

function FamilyAgent:handleDismissFamilyRes(status, msg)
	self:dispatch(FamilyAgent.DismissFamilyRes, status, msg)
end

function FamilyAgent:sendSendAllMemberMailReq(title, content)
	local req = FamilyExtension_pb.SendAllMemberMailReq()

	req.title = title
	req.content = content

	self:sendMsg(req)
end

function FamilyAgent:handleSendAllMemberMailRes(status, msg)
	if status == 0 then
		FamilyModel.instance:onSendAllMainRes(msg)
		FloatWordMgr.instance:show("发送成功")
		GlobalDispatcher:dispatch(GlobalNotify.SendAllMemberMailRes)
	end
end

function FamilyAgent:sendGetFamilyActivityPanelInfoReq()
	local req = FamilyExtension_pb.GetFamilyActivityPanelInfoReq()

	self:sendMsg(req)
end

function FamilyAgent:handleGetFamilyActivityPanelInfoRes(status, msg)
	if status == 0 then
		FamilyController.instance:handleGetFamilyActivityPanelInfoRes(msg)
	end
end

function FamilyAgent:sendGetFamilyManagePanelInfoReq()
	local req = FamilyExtension_pb.GetFamilyManagePanelInfoReq()

	self:sendMsg(req)
end

function FamilyAgent:handleGetFamilyManagePanelInfoRes(status, msg)
	if status == 0 then
		FamilyModel.instance:setManagePanelInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GetFamilyManagePanelInfoRes)
	end
end

function FamilyAgent:sendGetSendEnlistMsgReq(templateId)
	local req = FamilyExtension_pb.GetSendEnlistMsgReq()

	req.templateId = templateId

	self:sendMsg(req)
end

function FamilyAgent:handleGetSendEnlistMsgRes(status, msg)
	if status == 0 then
		FamilyModel.instance:onSendEnlistMsgRes(msg)
		FloatWordMgr.instance:show("发送成功")
		GlobalDispatcher:dispatch(GlobalNotify.GetSendEnlistMsgRes)
	end
end

function FamilyAgent:sendScheduleOpenPartyReq(schedule)
	local req = FamilyExtension_pb.ScheduleOpenPartyReq()

	req.schedule:ParseFromString(schedule:SerializeToString())
	self:sendMsg(req)
end

function FamilyAgent:handleScheduleOpenPartyRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("设置成功")
		FamilyController.instance:handleScheduleOpenPartyRes()
		GlobalDispatcher:dispatch(GlobalNotify.ScheduleOpenPartyRes)
	end
end

function FamilyAgent:sendGetFamilyTotemInfoReq()
	local req = FamilyExtension_pb.GetFamilyTotemInfoReq()

	self:sendMsg(req)
end

function FamilyAgent:handleGetFamilyTotemInfoRes(status, msg)
	if status == 0 then
		FamilyController.instance:onGetFamilyTotemInfoReq(msg)
	end
end

function FamilyAgent:sendInvokeFamilyTotemReq(totemIdList_i32_Ary)
	local req = FamilyExtension_pb.InvokeFamilyTotemReq()

	for i, v4 in ipairs(totemIdList_i32_Ary) do
		req.totemIdList:append(v4)
	end

	self:sendMsg(req)
end

function FamilyAgent:handleInvokeFamilyTotemRes(status, msg)
	if status == 0 then
		FamilyController.instance:onUpdateFamilyTotemInfoReq(msg)
	end
end

FamilyAgent.instance = FamilyAgent.New()

return FamilyAgent
