-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/agent/PlayerAgent.lua

module("logic.extensions.player.agent.PlayerAgent", package.seeall)

local PlayerAgent = class("PlayerAgent", BaseAgent)

PlayerAgent.CreatePlayerRes = "PlayerAgent_CreatePlayerRes"
PlayerAgent.GetUserInitInfoRes = "PlayerAgent_GetUserInitInfoRes"
PlayerAgent.GetMsgBoxInfoRes = "PlayerAgent_GetMsgBoxInfoRes"
PlayerAgent.GetSomeMsgBoxInfoRes = "PlayerAgent_GetSomeMsgBoxInfoRes"
PlayerAgent.NotifyEverMaxZdlChangedRes = "PlayerAgent_NotifyEverMaxZdlChangedRes"
PlayerAgent.UpdatePlayerSettingsRes = "PlayerAgent_UpdatePlayerSettingsRes"
PlayerAgent.GetMyDisplayCardInfoRes = "PlayerAgent_GetMyDisplayCardInfoRes"
PlayerAgent.GetOtherDisplayCardInfoRes = "PlayerAgent_GetOtherDisplayCardInfoRes"
PlayerAgent.GetExpGainBitRes = "PlayerAgent_GetExpGainBitRes"
PlayerAgent.GainExpGiftRes = "PlayerAgent_GainExpGiftRes"
PlayerAgent.TransformGenderRes = "PlayerAgent_TransformGenderRes"
PlayerAgent.PM_ChangeUserNameRes = "PlayerAgent_PM_ChangeUserNameRes"
PlayerAgent.PM_GetChangeUserNameCdRes = "PlayerAgent_PM_GetChangeUserNameCdRes"
PlayerAgent.PM_ChangeBadgeRes = "PlayerAgent_PM_ChangeBadgeRes"
PlayerAgent.PM_GetCheckInInfoRes = "PlayerAgent_PM_GetCheckInInfoRes"
PlayerAgent.PM_SubmitCheckInInfoRes = "PlayerAgent_PM_SubmitCheckInInfoRes"
PlayerAgent.PM_GainCheckInPrizeRes = "PlayerAgent_PM_GainCheckInPrizeRes"

function PlayerAgent:ctor()
	return
end

function PlayerAgent:setExtId(extId)
	PlayerAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PlayerAgent:sendCreatePlayerReq(userName, gender, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.CreatePlayerReq()

	req.userName = userName
	req.gender = gender

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.CreatePlayerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleCreatePlayerRes(status, msg)
	self:dispatch(PlayerAgent.CreatePlayerRes, status, msg)
end

function PlayerAgent:sendGetUserInitInfoReq(handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GetUserInitInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GetUserInitInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGetUserInitInfoRes(status, msg)
	self:dispatch(PlayerAgent.GetUserInitInfoRes, status, msg)
end

function PlayerAgent:sendGetMsgBoxInfoReq(handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GetMsgBoxInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GetMsgBoxInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGetMsgBoxInfoRes(status, msg)
	self:dispatch(PlayerAgent.GetMsgBoxInfoRes, status, msg)
end

function PlayerAgent:sendGetSomeMsgBoxInfoReq(msgKey, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GetSomeMsgBoxInfoReq()

	req.msgKey = msgKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GetSomeMsgBoxInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGetSomeMsgBoxInfoRes(status, msg)
	self:dispatch(PlayerAgent.GetSomeMsgBoxInfoRes, status, msg)
end

function PlayerAgent:handleNotifyEverMaxZdlChangedRes(status, msg)
	self:dispatch(PlayerAgent.NotifyEverMaxZdlChangedRes, status, msg)
end

function PlayerAgent:sendUpdatePlayerSettingsReq(changeSet)
	local req = PlayerExtension_pb.UpdatePlayerSettingsReq()
	local changeSet_pb = req.changeSet

	for k, v in pairs(changeSet) do
		changeSet_pb[k] = v
	end

	self:sendMsg(req)
end

function PlayerAgent:handleUpdatePlayerSettingsRes(status, msg)
	if status == 0 then
		RoleController.instance:handleUpdatePlayerSettingsRes(msg)
	end
end

function PlayerAgent:sendGetMyDisplayCardInfoReq(handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GetMyDisplayCardInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GetMyDisplayCardInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGetMyDisplayCardInfoRes(status, msg)
	self:dispatch(PlayerAgent.GetMyDisplayCardInfoRes, status, msg)
end

function PlayerAgent:sendGetOtherDisplayCardInfoReq(targetUserId, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GetOtherDisplayCardInfoReq()

	req.targetUserId = targetUserId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GetOtherDisplayCardInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGetOtherDisplayCardInfoRes(status, msg)
	self:dispatch(PlayerAgent.GetOtherDisplayCardInfoRes, status, msg)
end

function PlayerAgent:sendGetExpGainBitReq(handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GetExpGainBitReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GetExpGainBitRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGetExpGainBitRes(status, msg)
	self:dispatch(PlayerAgent.GetExpGainBitRes, status, msg)
end

function PlayerAgent:sendGainExpGiftReq(level, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.GainExpGiftReq()

	req.level = level

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.GainExpGiftRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleGainExpGiftRes(status, msg)
	self:dispatch(PlayerAgent.GainExpGiftRes, status, msg)
end

function PlayerAgent:sendTransformGenderReq(targetGender, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.TransformGenderReq()

	req.targetGender = targetGender

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.TransformGenderRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handleTransformGenderRes(status, msg)
	if status == 0 then
		RoleController.instance:handleSexChange()
	end

	self:dispatch(PlayerAgent.TransformGenderRes, status, msg)
end

function PlayerAgent:sendPM_ChangeUserNameReq(newName, useDiamond, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.PM_ChangeUserNameReq()

	req.newName = newName
	req.useDiamond = useDiamond

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.PM_ChangeUserNameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handlePM_ChangeUserNameRes(status, msg)
	self:dispatch(PlayerAgent.PM_ChangeUserNameRes, status, msg)
end

function PlayerAgent:sendPM_GetChangeUserNameCdReq(handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.PM_GetChangeUserNameCdReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.PM_GetChangeUserNameCdRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handlePM_GetChangeUserNameCdRes(status, msg)
	self:dispatch(PlayerAgent.PM_GetChangeUserNameCdRes, status, msg)
end

function PlayerAgent:sendPM_ChangeBadgeReq(badgeIds_i32_Ary, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.PM_ChangeBadgeReq()

	for i, v1 in ipairs(badgeIds_i32_Ary) do
		req.badgeIds:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.PM_ChangeBadgeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handlePM_ChangeBadgeRes(status, msg)
	self:dispatch(PlayerAgent.PM_ChangeBadgeRes, status, msg)
end

function PlayerAgent:sendPM_GetCheckInInfoReq(handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.PM_GetCheckInInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.PM_GetCheckInInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handlePM_GetCheckInInfoRes(status, msg)
	self:dispatch(PlayerAgent.PM_GetCheckInInfoRes, status, msg)
end

function PlayerAgent:sendPM_SubmitCheckInInfoReq(checkInType, param, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.PM_SubmitCheckInInfoReq()

	req.checkInType = checkInType
	req.param = param

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.PM_SubmitCheckInInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handlePM_SubmitCheckInInfoRes(status, msg)
	self:dispatch(PlayerAgent.PM_SubmitCheckInInfoRes, status, msg)
end

function PlayerAgent:sendPM_GainCheckInPrizeReq(checkInType, handler, handlerObj, errHandler)
	local req = PlayerExtension_pb.PM_GainCheckInPrizeReq()

	req.checkInType = checkInType

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlayerAgent.PM_GainCheckInPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlayerAgent:handlePM_GainCheckInPrizeRes(status, msg)
	self:dispatch(PlayerAgent.PM_GainCheckInPrizeRes, status, msg)
end

function PlayerAgent:sendPM_ChangePetTitleReq(petTitleIds)
	local req = PlayerExtension_pb.PM_ChangePetTitleReq()

	for i, v in ipairs(petTitleIds) do
		req.petTitleIds:append(v)
	end

	self:sendMsg(req)
end

function PlayerAgent:handlePM_ChangePetTitleRes(status, msg)
	RoleController.instance:handleCardPetTitleChanged(status, msg)
end

function PlayerAgent:sendPM_ChangePetFavorPetsReq(petIds)
	local req = PlayerExtension_pb.PM_ChangePetFavorPetsReq()

	for i, v in ipairs(petIds) do
		req.petIds:append(v)
	end

	self:sendMsg(req)
end

function PlayerAgent:handlePM_ChangePetFavorPetsRes(status, msg)
	if status == 0 then
		RoleController.instance:handlePM_ChangePetFavorPetsRes(msg)
	end
end

function PlayerAgent:sendPM_GetSecondaryPwdInfoReq()
	local req = PlayerExtension_pb.PM_GetSecondaryPwdInfoReq()

	self:sendMsg(req)
end

function PlayerAgent:handlePM_GetSecondaryPwdInfoRes(status, msg)
	if status == 0 then
		local pwdInfo = msg.pwdInfo

		PasswordLockModel.instance:setPwdInfo(pwdInfo)
		PasswordLockController.instance:tryStartResetTimer(pwdInfo.reqResetPwdEndTime)
		GlobalDispatcher:dispatch(GlobalNotify.GetSecondaryPwdInfoRes)
	end
end

function PlayerAgent:sendPM_SetSecondaryPwdReq(newPwd, newPwdType)
	local req = PlayerExtension_pb.PM_SetSecondaryPwdReq()

	req.newPwd = newPwd
	req.newPwdType = newPwdType
	self._setSecondaryPwd = newPwd
	self._setSecondaryPwdType = newPwdType

	self:sendMsg(req)
end

function PlayerAgent:handlePM_SetSecondaryPwdRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("密码设置成功")

		local pwdInfo = msg.pwdInfo

		PasswordLockController.instance:savePasswordType(self._setSecondaryPwdType)
		PasswordLockController.instance:onSetSecondaryPwdRes(pwdInfo, self._setSecondaryPwd, self._setSecondaryPwdType)
		GlobalDispatcher:dispatch(GlobalNotify.SetSecondaryPwdRes)
	end
end

function PlayerAgent:sendPM_ClearSecondaryPwdReq(curPwd, curPwdSalt)
	local req = PlayerExtension_pb.PM_ClearSecondaryPwdReq()

	req.curPwd = curPwd
	req.curPwdSalt = curPwdSalt

	self:sendMsg(req)
end

function PlayerAgent:handlePM_ClearSecondaryPwdRes(status, msg)
	if status == 0 then
		local pwdInfo = msg.pwdInfo

		PasswordLockModel.instance:setPwdInfo(pwdInfo)
		GlobalDispatcher:dispatch(GlobalNotify.ClearSecondaryPwdRes)
	end
end

function PlayerAgent:sendPM_ChangeSecondaryPwdReq(curPwd, curPwdSalt, newPwd, newPwdType)
	local req = PlayerExtension_pb.PM_ChangeSecondaryPwdReq()

	req.curPwd = curPwd
	req.curPwdSalt = curPwdSalt
	req.newPwd = newPwd
	req.newPwdType = newPwdType
	self._changeSecondaryPwd = newPwd
	self._changeSecondaryPwdType = newPwdType

	self:sendMsg(req)
end

function PlayerAgent:handlePM_ChangeSecondaryPwdRes(status, msg)
	if status == 0 then
		local todayInputPwdFailCount = msg.todayInputPwdFailCount
		local pwdInfo = msg.pwdInfo

		FloatWordMgr.instance:show("密码修改成功")
		PasswordLockController.instance:savePasswordType(self._changeSecondaryPwdType)
		PasswordLockController.instance:onChangeSecondaryPwdRes(pwdInfo, todayInputPwdFailCount, self._changeSecondaryPwd, self._changeSecondaryPwdType)
		GlobalDispatcher:dispatch(GlobalNotify.ChangeSecondaryPwdRes)
	end
end

function PlayerAgent:sendPM_ValidInputSecondaryPwdReq(curPwd)
	local req = PlayerExtension_pb.PM_ValidInputSecondaryPwdReq()

	req.curPwd = curPwd

	self:sendMsg(req)
end

function PlayerAgent:handlePM_ValidInputSecondaryPwdRes(status, msg)
	if status == 0 then
		local curPwd = msg.curPwd
		local curPwdSalt = msg.curPwdSalt

		PasswordLockController.instance:onSetPassword(curPwd, curPwdSalt)
		PasswordLockModel.instance:setClientStatus(PasswordLockController.ClientLocalStatus.VALID_PASS)
	elseif status == -2630 then
		local todayInputPwdFailCount = msg.todayInputPwdFailCount

		PasswordLockModel.instance:setTodayInputPwdFailCount(todayInputPwdFailCount)

		local str = string.format("密码错误，今日剩余机会：%s", PasswordLockController.MAX_VALID_TIEMS - todayInputPwdFailCount)

		FloatWordMgr.instance:show(str)
	else
		local str = MsgFlowMgr.instance:getResultCodeStr(status)

		FloatWordMgr.instance:show(str)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ValidInputSecondaryPwdRes, status)
end

function PlayerAgent:sendPM_ReqResetSecondaryPwdReq()
	local req = PlayerExtension_pb.PM_ReqResetSecondaryPwdReq()

	self:sendMsg(req)
end

function PlayerAgent:handlePM_ReqResetSecondaryPwdRes(status, msg)
	if status == 0 then
		local pwdInfo = msg.pwdInfo

		PasswordLockModel.instance:setPwdInfo(pwdInfo)
		PasswordLockController.instance:tryStartResetTimer(pwdInfo.reqResetPwdEndTime)
		GlobalDispatcher:dispatch(GlobalNotify.ReqResetSecondaryPwdRes)
	end
end

function PlayerAgent:sendPM_CancelResetSecondaryPwdReq()
	local req = PlayerExtension_pb.PM_CancelResetSecondaryPwdReq()

	self:sendMsg(req)
end

function PlayerAgent:handlePM_CancelResetSecondaryPwdRes(status, msg)
	if status == 0 then
		local pwdInfo = msg.pwdInfo

		PasswordLockModel.instance:setPwdInfo(pwdInfo)
		PasswordLockController.instance:tryStartResetTimer(pwdInfo.reqResetPwdEndTime)
		GlobalDispatcher:dispatch(GlobalNotify.CancelResetSecondaryPwdRes)
	end
end

function PlayerAgent:sendPM_SelectGuideModeReq(guideMode)
	local req = PlayerExtension_pb.PM_SelectGuideModeReq()

	req.guideMode = guideMode

	self:sendMsg(req)
end

function PlayerAgent:handlePM_SelectGuideModeRes(status, msg)
	RoleController.instance:handlePM_SelectGuideModeRes(status, msg)
end

function PlayerAgent:handlePM_MustInputValidSecondaryPwdRes(status, msg)
	if status == 0 then
		PasswordLockController.instance:onMustInputValidSecondaryPwdRes()
		GlobalDispatcher:dispatch(GlobalNotify.MustInputValidSecondaryPwdRes)
	end
end

function PlayerAgent:handlePM_RefreshSecondaryPwdInfoRes(status, msg)
	if status == 0 then
		local pwdInfo = msg.pwdInfo

		PasswordLockModel.instance:setPwdInfo(pwdInfo)
		PasswordLockController.instance:tryStartResetTimer(pwdInfo.reqResetPwdEndTime)
		GlobalDispatcher:dispatch(GlobalNotify.RefreshSecondaryPwdInfoRes)
	end
end

PlayerAgent.instance = PlayerAgent.New()

return PlayerAgent
