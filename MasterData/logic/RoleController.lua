-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/controller/RoleController.lua

module("logic.extensions.role.controller.RoleController", package.seeall)

local RoleController = class("RoleController", BaseController)

RoleController.ON_PRE_ROLE_CLICK_ENTER = "on_pre_role_click_enter"

function RoleController:onInit()
	RoleController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.SelectOtherPlayer, self._onClickPlayer, self)
	GlobalDispatcher:addListener(GlobalNotify.SelectMainPlayer, self.openMyInfoCard, self)
	PlayerAgent.instance:addListener(PlayerAgent.NotifyEverMaxZdlChangedRes, self.onMaxZdlChange, self)
	self:onReset()
end

function RoleController:onReset()
	RoleController.super.onReset(self)

	self._cachePetTitleIds = nil
	self.renameTime = -1
	self._isReqingRoleInfo = false
	self._syncTimeInterval = 10

	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationQuit, self._onApplicationQuit, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._tickCheck, self)
end

function RoleController:sendPM_SelectGuideModeReq(guideMode)
	RoleModel.instance:setGuideMode(guideMode)
	PlayerAgent.instance:sendPM_SelectGuideModeReq(guideMode)
end

function RoleController:handlePM_SelectGuideModeRes(status, msg)
	if status == 0 and msg.guideMode == 1 then
		local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

		if Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= 1100 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode >= 1100 or Framework.OSDef.isEditor then
			-- block empty
		else
			LebianFenbaoManager.downloadFullRes(false)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_SelectGuideModeRes, status)
end

function RoleController:sendUpdatePlayerSettingsReq(playerSettings)
	PlayerAgent.instance:sendUpdatePlayerSettingsReq(playerSettings)
end

function RoleController:handleUpdatePlayerSettingsRes(msg)
	RoleModel.instance:setSettings(msg.changeSet)
	GlobalDispatcher:dispatch(GlobalNotify.HandleUpdatePlayerSettingsRes)
end

function RoleController:onMaxZdlChange(status, msg)
	if status == 0 then
		RoleModel.instance:setMaxPower(msg.everMaxZdl)
		GlobalDispatcher:dispatch(GlobalNotify.RoleInfoPushed)
	end
end

function RoleController:_onRoleLogined(isSucc)
	if isSucc then
		GlobalDispatcher:removeListener(GlobalNotify.RoleLogined, self._onRoleLogined, self)
		PlayerAgent.instance:sendGetUserInitInfoReq(self.onGetUserInitInfoRes, self, self.onGetUserInitInfoError)
	end
end

function RoleController:onGetUserInitInfoRes(msg)
	if not msg or not msg.info or msg.info.currentTimeMillis == 0 then
		RoleModel.instance:onSetPreCreatePlayerInfo(msg.PreCreatePlayerInfo)
		GlobalDispatcher:dispatch(GlobalNotify.NeedCreateRole, msg)
	else
		self:_handleUserInfo(msg.info)
	end
end

function RoleController:showRenameView()
	if self.renameTime == -1 then
		PlayerAgent.instance:sendPM_GetChangeUserNameCdReq(function(msg)
			self.renameTime = checknumber(msg.cdEndTime)

			self:checkAndShowRenameView()
		end)
	else
		self:checkAndShowRenameView()
	end
end

function RoleController:checkAndShowRenameView()
	local now = ServerTime.now() * 1000

	if now >= self.renameTime then
		UIStateManager.instance:push(ViewName.RenameView)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("亲爱的奥奇，频繁改名会让你的好友懵圈的哦\n改名成功后需要间隔<color=#eb4642>【24小时】</color>，才能再次改名，请稍后再尝试"))
	end
end

function RoleController:onGetUserInitInfoError(msg, status)
	TipsFacade.instance:openTipWindow("提示", "服务器爆满, 请选择其他服务器(" .. status .. ")", function()
		WaitingView.instance:hide()
		RoleAgent.instance:sendExitGameReq()
	end, "确定")
end

function RoleController:_handleUserInfo(msg)
	local offsetSecs = math.ceil(msg.zoneOffSetMillis / 1000)

	ServerTime.init(offsetSecs)
	self:syncServerTime(msg.currentTimeMillis)
	VipModel.instance:updateVipDataInputExp(msg.vipExp)
	RoleModel.instance:onSetMo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RoleInfoPushed)
end

function RoleController:syncServerTime(serverMillis)
	local timeSecs = math.ceil(serverMillis / 1000)

	AcceleratorCheckController.instance:syncTime(timeSecs)
	ServerTime.sync(timeSecs)
	PreciseServerTime.sync(serverMillis)
	GlobalDispatcher:dispatch(GlobalNotify.ServerTimeSync)
end

function RoleController:startSyncTime()
	settimer(self._syncTimeInterval, self._tickCheck, self, true)
end

function RoleController:_tickCheck()
	RoleAgent.instance:sendHeartBeatReq()
end

function RoleController:_onClickPlayer(uid)
	local viewName = UIStateManager.instance:getTopName()

	print("top viewName = " .. viewName)

	if viewName ~= ViewName.MainUI then
		return
	end

	self:openCardByUserId(uid)
end

function RoleController:stopSyncTime()
	removetimer(self._tickCheck, self)
end

function RoleController:changeSyncTime(newSyncTimeInterval)
	removetimer(self._tickCheck, self)
	settimer(newSyncTimeInterval, self._tickCheck, self, true)
end

function RoleController:resumeSyncTime()
	removetimer(self._tickCheck, self)
	settimer(self._syncTimeInterval, self._tickCheck, self, true)
end

function RoleController:getMsgBoxInfoReq()
	return
end

function RoleController:_onApplicationQuit()
	RoleAgent.instance:sendExitGameReq()
end

function RoleController:openMyInfoCard(cb, ...)
	if RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My) ~= nil then
		-- block empty
	end

	do
		local params = {
			...
		}

		self._isReqingRoleInfo = true

		PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
			self._isReqingRoleInfo = false

			RoleModel.instance:setMyCardInfo(msg)
			ViewAutoShowController.instance:saveCurModalView()
			UIStateManager.instance:push(ViewName.MyCardView, unpack(params))
			GameUtil.callBack(cb)
		end, nil, function()
			self._isReqingRoleInfo = false
		end)
	end
end

function RoleController:openOtherInfoCard(uid)
	if checknumber(uid) > 0 then
		self._isReqingRoleInfo = true

		PlayerAgent.instance:sendGetOtherDisplayCardInfoReq(uid, function(msg)
			self._isReqingRoleInfo = false

			RoleModel.instance:setCurOtherCardInfo(msg)
			ViewAutoShowController.instance:saveCurModalView()
			UIStateManager.instance:push(ViewName.OtherCardView)
		end, nil, function()
			self._isReqingRoleInfo = false
		end)
	end
end

function RoleController:getIsReqingRoleInfo()
	return self._isReqingRoleInfo == true
end

function RoleController:openCardByUserId(uid)
	if tostring(uid) == tostring(LoginModel.instance.userId) then
		self:openMyInfoCard()
	else
		self:openOtherInfoCard(uid)
	end
end

function RoleController:showBanTips(banType)
	banType = banType or 2

	if not self:getIsRoleBaned(banType) then
		return
	end

	local endTime = GameUtil.time2date(RoleModel.instance.banInfos[banType])
	local content = ""

	if banType == 1 then
		content = string.format("您由于不当游戏行为已被封禁，解封时间%d年%d月%d日%d时，如有疑问请联系客服", endTime.year, endTime.month, endTime.day, endTime.hour)
	elseif banType == 2 then
		content = string.format("您由于不当发言已被禁言，解封时间%d年%d月%d日%d时，如有疑问请联系客服", endTime.year, endTime.month, endTime.day, endTime.hour)
	end

	TipsFacade.instance:openTipWindow("账号冻结", content, nil, "确定")
end

function RoleController:getIsRoleBaned(banType)
	banType = banType or 2

	local t = RoleModel.instance.banInfos

	print("getIsRoleBaned " .. banType .. tostring(checknumber(ServerTime.now()) < checknumber(t[banType])))

	if not t[banType] then
		return false
	else
		return checknumber(ServerTime.now()) < checknumber(t[banType])
	end
end

function RoleController:createPlayerName(name, sex, callBack, selfObj, finishCall)
	PlayerAgent.instance:sendCreatePlayerReq(name, sex, function(msg)
		self:_handleUserInfo(msg.info)
		SDKGameRoleInfoController.instance:createRole()
		GameUtil.callBack(finishCall, selfObj)
	end, nil, function(msg, status)
		local str = MsgFlowMgr.instance:getResultCodeStr(status)

		GameUtil.callBack(finishCall, selfObj)

		if status == -54 then
			TipsFacade.instance:openTipWindow("提示", str, function()
				LoginController.instance:disconnect(function()
					ReConnectionMgr.instance:returnToLogin()
				end)
			end, "确定")
		elseif status == -32005 then
			LoginController.instance:disconnect(function()
				TipsFacade.instance:openTipWindowNoX(lang("tip"), BootstrapLanguage.a47, nil, BootstrapLanguage.sure)
			end)
		else
			GameUtil.callBack(callBack, selfObj, status)
		end
	end)
end

function RoleController:addClockListener()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyResetData, self)
end

function RoleController:removeClockListener()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyResetData, self)
end

function RoleController:_dailyResetData()
	self._isReqingRoleInfo = true

	PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
		self._isReqingRoleInfo = false

		RoleModel.instance:setMyCardInfo(msg)
		DressController.instance:sendGetNotoutInfoReq()
		GlobalDispatcher:dispatch(GlobalNotify.UpdateDressInfoDaily)
	end, nil, function()
		self._isReqingRoleInfo = false
	end)
end

function RoleController:handleSexChange()
	UIStateManager.instance:push(ViewName.SexchangedressView)
end

function RoleController:reqCardPetTitleChange(petTitleIds)
	self._cachePetTitleIds = petTitleIds

	PlayerAgent.instance:sendPM_ChangePetTitleReq(petTitleIds)
end

function RoleController:handleCardPetTitleChanged(status, msg)
	if status == 0 then
		local myCardInfoMo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

		if myCardInfoMo and self._cachePetTitleIds then
			myCardInfoMo:setMyCardPetTitles(self._cachePetTitleIds)
			GlobalDispatcher:dispatch(GlobalNotify.UserCardPetTitleChange, myCardInfoMo.petTitles)
		end
	end

	self._cachePetTitleIds = nil
end

function RoleController:sendPM_ChangePetFavorPetsReq(petIds)
	PlayerAgent.instance:sendPM_ChangePetFavorPetsReq(petIds)
end

function RoleController:handlePM_ChangePetFavorPetsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ChangePetFavorPetsRes)
end

RoleController.instance = RoleController.New()

return RoleController
