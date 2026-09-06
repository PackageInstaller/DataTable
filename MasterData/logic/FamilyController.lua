-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/controller/FamilyController.lua

module("logic.extensions.family.controller.FamilyController", package.seeall)

local FamilyController = class("FamilyController", BaseController)

FamilyController.GetMyFamilySimpleDataRes = "FamilyController.GetMyFamilySimpleDataRes"
FamilyController.OnGetMyFamilyInfoRes = "FamilyController.OnGetMyFamilyInfoRes"
FamilyController.GetDonatePoolInfoRes = "FamilyController.GetDonatePoolInfoRes"
FamilyController.RedpackTab = {
	TaskTab = 2,
	FamilyTab = 1
}

function FamilyController:ctor()
	self._curSendTaskId = nil
end

function FamilyController:onInit()
	self:onReset()
	FamilyAgent.instance:addHandler(FamilyAgent.NotifyJoinLeaveFamilyRes, self._onJoinLeaveFamilyRes, self)
	FamilyAgent.instance:addHandler(FamilyAgent.NotifyFamilyLevelUpRes, self._onFamilyLevelUpRes, self)
	GlobalDispatcher:addListener(FamilyAgent.BossClgEndRes, self.handleBossClgEndRes, self)

	function FamilyAgent.instance.showChangeSet(ref, changeSetId, name)
		if name == "handleBossClgEndRes" then
			FamilyModel.instance.bossChangeSetId = changeSetId
		else
			FamilyAgent.super.showChangeSet(ref, changeSetId, name)
		end
	end
end

function FamilyController:onReset()
	self._endIndex = -1
	self._isDataInit = false
	self._needOpen = false
	self._level = 0
	self._familyId = 0
	self._handler = nil
	self._handlerObj = nil
	self._curSendTaskId = nil
	self._familyViewTab = nil
	self._redpackViewTab = nil
	self._handler = nil
	self._handlerObj = nil
end

function FamilyController:getFamilyViewTab()
	return math.max(1, checknumber(self._familyViewTab))
end

function FamilyController:setFamilyViewTab(value)
	self._familyViewTab = value
end

function FamilyController:getRedpackViewTab()
	return math.max(1, checknumber(self._redpackViewTab))
end

function FamilyController:setRedpackViewTab(value)
	self._redpackViewTab = value
end

function FamilyController:openFamilyView(...)
	local params = {
		...
	}

	if params then
		if not params[1] then
			local openType = ""

			openType = tostring(openType)

			if openType == "contri" then
				if self:checkFamilyOpen(true) then
					self:getMyFamilyInfoReq(function()
						UIStateManager.instance:push(ViewName.FamilyContribution)
					end)
				end
			elseif openType == "boss" then
				if self:checkFamilyOpen(true) then
					FamilyController.instance:openFamilyView("activity")
					FamilyHoudingClgController.instance:enterFamilyHoudingClg()
				end
			elseif openType == "activity" then
				if self:checkFamilyOpen(true) then
					self:setFamilyViewTab(3)
					UIStateManager.instance:push(ViewName.Family)
				end
			elseif openType == "familyescort" or openType == "escortbattle" then
				if self:checkFamilyOpen(true) then
					if not EscortModel.instance:IsOpenEscortView() then
						FloatWordMgr.instance:show("家族护送尚未开启")
						self:setFamilyViewTab(3)
						UIStateManager.instance:push(ViewName.Family)
					elseif not EscortModel.instance:IsPickupEscort() then
						UIStateManager.instance:clear()
						EscortModel.instance:StartFindGotoNPC()
					else
						local viewName = ViewName.EscortGoods

						if openType == "escortbattle" then
							viewName = ViewName.EscortBattle
						end

						UIStateManager.instance:clear()
						UIStateManager.instance:open(viewName)
					end
				end
			elseif openType == "honor" then
				if self:checkFamilyOpen(true) then
					self:setFamilyViewTab(5)
					UIStateManager.instance:push(ViewName.Family)
				end
			elseif openType == "godstatueswar" then
				if self:checkFamilyOpen(true) then
					GodStatuesWarController.instance:enterGodStatuesWar()
				end
			elseif self._isDataInit then
				if self:isHasFamily() then
					self:setFamilyViewTab(1)
					UIStateManager.instance:push(ViewName.Family)
				else
					self._originIndex = -1
					self._endIndex = -1
					self._canKeepOnReqing = true

					FamilyModel.instance:clearFamilyViews()
					UIStateManager.instance:push(ViewName.FamilyList)
				end
			else
				self._needOpen = true
			end
		end
	end
end

function FamilyController:checkFamilyOpen(isTip)
	if not FuncOpenModel.instance:getFuncIsOpen(60) then
		if isTip then
			local cfg = FuncOpenConfig.instance:getFunctionOpenById(60)

			FloatWordMgr.instance:show(cfg.lockedTips)
		end

		return false
	elseif not self:isHasFamily() then
		if isTip then
			FloatWordMgr.instance:show("你还未加入家族喔")
		end

		return false
	end

	return true
end

function FamilyController:getSearchList(text)
	local list = {}
	local t = FamilyModel.instance:getFamilyList()

	for _, v in ipairs(t) do
		if string.find(v.familyName, text) then
			table.insert(list, v)
		end
	end

	return list
end

function FamilyController:_callback(...)
	local handler = self._handler
	local handlerObj = self._handlerObj

	self._handler = nil
	self._handlerObj = nil

	if handler then
		if handlerObj then
			self._handler(handlerObj, ...)
		else
			handler(...)
		end
	end
end

function FamilyController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function FamilyController:_checkIsReqing()
	if self._handler then
		print("_checkIsReqing")
		print(debug.traceback())
		FloatWordMgr.instance:show("家族协议重复请求")

		return true
	else
		return false
	end
end

function FamilyController:checkCanApply(createOrApply)
	local leftTime = FamilyModel.instance:getApplyCdEndTime() - ServerTime.now()

	if leftTime > 0 then
		local tip = createOrApply and "创建" or "申请"
		local content = string.format("您刚刚离开家族，请%s后再来%s！", FamilyController.getTimeFormat(leftTime), tip)

		FloatWordMgr.instance:show(content)

		return false
	else
		return true
	end
end

function FamilyController.getTimeFormat(leftTime)
	if leftTime <= 0 then
		return ""
	elseif leftTime >= 691200 then
		return os.date("%m %d", leftTime)
	elseif leftTime >= 86400 then
		return string.format("%d天", math.ceil(leftTime / 86400))
	elseif leftTime >= 3600 then
		return string.format("%d小时", math.ceil(leftTime / 3600))
	elseif leftTime >= 60 then
		return string.format("%d分钟", math.ceil(leftTime / 60))
	else
		return math.ceil(leftTime) .. "秒"
	end
end

function FamilyController:isHasFamily()
	if checknumber(self._familyId) > 0 then
		return true
	else
		return FamilyModel.instance:getMyFamilyInfo() ~= nil
	end
end

function FamilyController:getMyFamilySimpleInfoReq()
	FamilyAgent.instance:sendGetMyFamilySimpleInfoReq(self._onMyFamilySimpleDataRes, self, self._errorCall)
end

function FamilyController:_onMyFamilySimpleDataRes(msg)
	forcePrint("=====RoleDataRequestor:_loadFamilySimpleData===back")

	self._isDataInit = true
	self._familyId = msg.familyId
	self._level = msg.level

	if self._needOpen then
		self._needOpen = false

		self:openFamilyView()
	end

	local redPointId = RedPointModel.ID_FAMILY_MGR_PARTY

	RedPointController.instance:setRedPointInfo(redPointId, msg.scheduleRedPoint)
	GlobalDispatcher:dispatch(FamilyController.GetMyFamilySimpleDataRes, msg)
end

function FamilyController:getFamilyLv()
	local info = FamilyModel.instance:getMyFamilyInfo()

	if info then
		return FamilyModel.instance:getFamilyLv()
	else
		return checknumber(self._level)
	end
end

function FamilyController:getFamilyViewsReq(handler, handlerObj, skipCallback)
	if not self._canKeepOnReqing then
		if skipCallback then
			return
		else
			self._handler = handler
			self._handlerObj = handlerObj

			self:_callback()
		end
	end

	if not self:_checkIsReqing() then
		self._canKeepOnReqing = false
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendGetFamilyViewsReq(self._originIndex, self._endIndex, self._onFamilyViewDataRes, self, self._errorCall)
	end
end

function FamilyController:_onFamilyViewDataRes(msg)
	local needSort = self._originIndex == -1

	self._originIndex = msg.originIndex
	self._endIndex = msg.endIndex
	self._canKeepOnReqing = #msg.familyList >= FamilyConfig.instance:getApplyMaxNum()

	FamilyModel.instance:insertFamilyViews(msg.familyList, needSort)
	FamilyModel.instance:setApplyCdEndTime(msg.applyCdEndMillis)
	self:_callback()
end

function FamilyController:createFamilyReq(settingInfo, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendCreateFamilyReq(settingInfo, self._onCreateFamilyRes, self, self._errorCall)
	end
end

function FamilyController:_onCreateFamilyRes(msg)
	FamilyModel.instance:setMyFamilyInfo(msg.familyInfo)
	self:_callback()
end

function FamilyController:modifySettingReq(settingInfo, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendModifySettingsReq(settingInfo, self._onModifySettingRes, self, self._errorCall)
	end
end

function FamilyController:_onModifySettingRes(msg)
	FamilyModel.instance:setSettingInfo(msg.settings)
	self:_callback()
end

function FamilyController:getMyFamilyInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendGetMyFamilyInfoReq(self._onGetMyFamilyInfoRes, self, self._errorCall)
	end
end

function FamilyController:_onGetMyFamilyInfoRes(msg)
	FamilyModel.instance:setMyFamilyInfo(msg.familyInfo)
	self:_callback()
	GlobalDispatcher:dispatch(FamilyController.OnGetMyFamilyInfoRes)
end

function FamilyController:getFamilyEventLogsReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendGetFamilyEventLogsReq(self._onGetFamilyEventLogsRes, self, self._errorCall)
	end
end

function FamilyController:_onGetFamilyEventLogsRes(msg)
	FamilyModel.instance:setFamilyLogs(msg.logs)
	self:_callback()
end

function FamilyController:applyJoinFamilyReq(familyId, handler, handlerObj)
	if self:checkCanApply() and not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendApplyJoinFamilyReq(familyId, self.onApplyJoinFamilyRes, self, self._errorCall)
	end
end

function FamilyController:onApplyJoinFamilyRes(msg)
	FamilyModel.instance:setFamilyViewApplied(msg.familyId, true)
	self:_callback()
end

function FamilyController:cancelApplyJoinReq(familyId, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._cancledId = familyId
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendCancelApplyJoinReq(familyId, self.onCancelApplyJoinRes, self, self._errorCall)
	end
end

function FamilyController:onCancelApplyJoinRes(msg)
	FamilyModel.instance:setFamilyViewApplied(self._cancledId, false)
	self:_callback()
end

function FamilyController:getFamilyMemberListReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._cancledId = familyId
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendGetFamilyMemberListReq(self.onGetFamilyMemberListRes, self, self._errorCall)
	end
end

function FamilyController:onGetFamilyMemberListRes(msg)
	FamilyModel.instance:setMembers(msg.members)
	self:_callback()
end

function FamilyController:leaveFamilyReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._cancledId = familyId
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendLeaveFamilyReq(self.onLeaveFamilyRes, self, self._errorCall)
	end
end

function FamilyController:onLeaveFamilyRes(msg)
	FamilyModel.instance:setMyFamilyInfo(nil)
	FamilyModel.instance:setMembers(nil)
	self:_callback()
end

function FamilyController:kickUserOutFamilyReq(userIds, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendKickUserOutFamilyReq(userIds, self._onKickUserOutFamilyRes, self, self._errorCall)
	end
end

function FamilyController:_onKickUserOutFamilyRes(msg)
	FamilyModel.instance:setDailyKickCount(msg.dailyKickCount)
	FamilyModel.instance:removeMember(msg.kickUserId)
	GlobalDispatcher:dispatch(GlobalNotify.KickUserOut)
	self:_callback()
end

function FamilyController:getDonatePoolInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendGetDonatePoolInfoReq(self._onGetDonatePoolInfoRes, self, self._errorCall)
	end
end

function FamilyController:_onGetDonatePoolInfoRes(msg)
	FamilyModel.instance:setDonateInfo(msg.donatePoolInfo)
	FamilyModel.instance:addDonateRecord(msg.records)
	GlobalDispatcher:dispatch(FamilyController.GetDonatePoolInfoRes)
	self:_callback()
end

function FamilyController:familyDonateReq(donateCount, handler, handlerObj, errorHandler)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendFamilyDonateReq(donateCount, self._onFamilyDonateRes, self, function()
			self:_errorCall()

			if errorHandler then
				if handlerObj then
					errorHandler(handlerObj)
				else
					errorHandler()
				end
			end
		end)
	end
end

function FamilyController:_onFamilyDonateRes(msg)
	FamilyModel.instance:setDonateInfo(msg.donatePoolInfo, nil)
	FamilyModel.instance:addDonateRecord({
		msg.addRecord
	})
	FamilyModel.instance:setFamilyScore(msg.familyScore)
	self:_callback()
end

function FamilyController:changeFamilyRoleReq(memberId, newRole, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendChangeFamilyRoleReq(memberId, newRole, self._onChangeFamilyRoleRes, self, self._errorCall)
	end
end

function FamilyController:_onChangeFamilyRoleRes(msg)
	if not msg.affectRoles then
		for _, v in ipairs(msg.affectRoles) do
			FamilyModel.instance:setMemberRole(v.memberId, v.newRole)
		end

		self:_callback()
		GlobalDispatcher:dispatch(GlobalNotify.ChangeFamilyRole)
	end
end

function FamilyController:_onJoinLeaveFamilyRes(msg, status)
	FamilyPartyController.instance:closePartyInMainUI()

	local reason = checknumber(msg.reason)

	if reason == 0 then
		UIStateManager.instance:popByName(ViewName.FamilyList)
		FloatWordMgr.instance:show("您已经加入了一个新的家族")
		self.getMyFamilyInfoReq(self, self._onNotifyJoinFamily, self)
	else
		NewChatModel.instance:ClearChannelMsg(GameEnum.ChatChannel.League)

		self._familyId = 0
		self._level = 0

		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneType() == SceneType.Family then
			UIStateManager.instance:clear(false)
			FamilySceneController.instance:forceLeaveScene()
		end

		if ViewMgr.instance:isOpen(ViewName.Family) or ViewMgr.instance:isOpen(ViewName.FamilyContribution) or ViewMgr.instance:isOpen(ViewName.FamilyApply) then
			UIStateManager.instance:clear(true)
		end

		FamilyModel.instance:onReset()
		FloatWordMgr.instance:show("您已离开家族，重新寻找一个新的家族吧！")
	end
end

function FamilyController:_onNotifyJoinFamily()
	if ViewMgr.instance:isOpen(ViewName.FamilyList) then
		self:setFamilyViewTab(1)

		self._familyViewDonotNeedReq = true

		FamilySceneController.instance:enterScene()
	end
end

function FamilyController:getFamilyViewNeedReq()
	local val = self._familyViewDonotNeedReq

	self._familyViewDonotNeedReq = false

	return val ~= true
end

function FamilyController:oneKeyApplyJoinFamilyReq(handler, handlerObj)
	if not self:checkCanApply() then
		return
	end

	local list = FamilyModel.instance:getFamilyList()
	local t = {}
	local count = 0

	for _, v in ipairs(list) do
		local curLv = MofangModel.instance:getCurLv()
		local curPower = RoleModel.instance:getMaxPower()

		if v.needApproval ~= true and curLv >= checknumber(v.playerLevelLimit) and curPower >= checknumber(v.maxZdlLimit) then
			table.insert(t, v.familyId)

			count = count + 1
		end

		if count >= 10 then
			break
		end
	end

	if count == 0 then
		FloatWordMgr.instance:show("没有符合条件的家族，请稍后再试")
	elseif not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendOneKeyApplyJoinFamilyReq(t, self._onOneKeyApplyJoinFamilyRes, self, self._errorCall)
	end
end

function FamilyController:_onOneKeyApplyJoinFamilyRes(msg)
	FloatWordMgr.instance:show("一键加入成功")
end

function FamilyController:batchHandleFamilyApplyReq(userIdList, isAgree, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj
		self._cacheUserIds = userIdList
		self._cacheAgree = isAgree

		FamilyAgent.instance:sendBatchHandleFamilyApplyReq(self:getTop5UserIdsFromCache(), isAgree, self._onBatchHandleFamilyApplyRes, self, self._errorCall)
	end
end

function FamilyController:_onBatchHandleFamilyApplyRes(msg)
	FamilyModel.instance:setDailyJoinCount(msg.dailyJoinCount)

	if not msg.handledList then
		for _, userId in ipairs(msg.handledList) do
			FamilyModel.instance:removeApply(userId)
		end

		if #self._cacheUserIds == 0 then
			self:_callback()
		else
			FamilyAgent.instance:sendBatchHandleFamilyApplyReq(self:getTop5UserIdsFromCache(), self._cacheAgree, self._onBatchHandleFamilyApplyRes, self, self._errorCall)
		end
	end
end

function FamilyController:getTop5UserIdsFromCache()
	local len = math.min(5, #self._cacheUserIds)
	local t = {}

	for i = 1, len do
		table.insert(t, self._cacheUserIds[1])
		table.remove(self._cacheUserIds, 1)
	end

	local userIdStr = ""

	for _, v in ipairs(t) do
		userIdStr = userIdStr .. ".." .. v
	end

	printInfo("userIdStr = " .. userIdStr)

	return t
end

function FamilyController:handleFamilyApplyReq(userId, isAgree, handler, handlerObj)
	if isAgree then
		local dailyJoinCount = FamilyModel.instance:getDailyJoinCount()
		local joinLimit = FamilyConfig.instance:getCommonValue("DAILY_JOIN_LIMIT", true)

		if joinLimit > 0 and joinLimit <= dailyJoinCount then
			FloatWordMgr.instance:show("该家族今日新增成员已达上限")

			return
		end
	end

	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendHandleFamilyApplyReq(userId, isAgree, self._onHandleFamilyApplyRes, self, self._errorCall)
	end
end

function FamilyController:_onHandleFamilyApplyRes(msg)
	FamilyModel.instance:setDailyJoinCount(msg.dailyJoinCount)

	local extFailState = checknumber(msg.extFailState)

	FamilyModel.instance:removeApply(msg.handleUserId)
	self:_callback(msg.extFailState)
end

function FamilyController:getFamilyApplyListReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		FamilyAgent.instance:sendGetFamilyApplyListReq(self._onGetFamilyApplyListRes, self, self._errorCall)
	end
end

function FamilyController:_onGetFamilyApplyListRes(msg)
	FamilyModel.instance:setApplyList(msg.applyList)
	self:_callback()
end

function FamilyController:sendGetUnlockedBossInfosReq()
	local function handler(msg)
		FamilyModel.instance:setUnlockedBossInfos(msg.unlockedBossInfos)
		GlobalDispatcher:dispatch(FamilyModel.GetUnlockedBossInfosRes)
	end

	FamilyAgent.instance:sendGetUnlockedBossInfosReq(handler)
end

function FamilyController:sendChallengeBossReq(bossId)
	local function handler(msg)
		UIJumper.instance:pushOneStack(ViewName.FamilybossView, nil, bossId)
	end

	FamilyAgent.instance:sendChallengeBossReq(bossId, handler)
end

function FamilyController:sendSweepBossReq(bossId)
	local function handler(msg)
		FamilyModel.instance:sweepBossSuccessed(msg)
		GlobalDispatcher:dispatch(FamilyModel.SweepBossRes, msg.bossId)
	end

	FamilyAgent.instance:sendSweepBossReq(bossId, handler)
end

function FamilyController:handleBossClgEndRes(status, msg)
	if status == 0 then
		FamilyModel.instance:bossClgEnd(msg)
	end
end

function FamilyController:dismissFamily()
	FamilyAgent.instance:sendDismissFamilyReq(self._onDissmissFamilyRes, self)
end

function FamilyController:_onDissmissFamilyRes()
	FamilyModel.instance:setMyFamilyInfo(nil)
	FamilyModel.instance:setMembers(nil)
end

function FamilyController:csGetFamilyRedPacketGetTaskInfoReq()
	if self:checkFamilyOpen(true) then
		self:getMyFamilyInfoReq(function()
			FamilyRedPacketAgent.instance:sendPM_FamilyRedPacketGetTaskInfoReq()
		end)
	else
		FamilyRedPacketAgent.instance:sendPM_FamilyRedPacketGetTaskInfoReq()
	end
end

function FamilyController:csSendFamilyRedPacketGetTaskInfo(msg)
	FamilyModel.instance:csSendFamilyRedPacketGetTaskInfo(msg.taskInfos)
	GlobalDispatcher:dispatch(GlobalNotify.Family_UpdataTaskRedpackInfo)
end

function FamilyController:csGetFamilyRedPacketSendRedPacketReq(taskId)
	self._curSendTaskId = taskId

	FamilyRedPacketAgent.instance:sendPM_FamilyRedPacketSendRedPacketReq(taskId)
end

function FamilyController:csSendFamilyRedPacketSendRedPacket(msg)
	if self._curSendTaskId and checknumber(msg.packetId) > 0 then
		FamilyModel.instance:csSendFamilyRedPacketSendRedPacket(self._curSendTaskId)
		GlobalDispatcher:dispatch(GlobalNotify.Family_SetFamilyRedpackId, msg.packetId)

		if checknumber(self._curSendTaskId) <= 0 then
			self:csGetFamilyRedPacketGetListReq()

			return
		end

		local sendStr = string.format("{\"tpId\":%s,\"params\":{\"redpackId\":%s,\"redpackTaskId\":%s}}", 48, msg.packetId, self._curSendTaskId)

		ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.League, GameEnum.ChatType.System, sendStr, nil, nil, function()
			self:csGetFamilyRedPacketGetListReq()
		end)

		self._curSendTaskId = nil
	end
end

function FamilyController:csGetFamilyRedPacketGetListReq()
	FamilyRedPacketAgent.instance:sendPM_FamilyRedPacketGetListReq()
end

function FamilyController:csSendFamilyRedPacketGetList(msg)
	FamilyModel.instance:csSendFamilyRedPacketGetList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Family_UpdataFamilyRedpackInfo)
end

function FamilyController:csGetFamilyRedPacketGainReq(rpId, rpType)
	FamilyRedPacketAgent.instance:sendPM_FamilyRedPacketGainReq(rpId, rpType)
end

function FamilyController:csSendFamilyRedPacketGain(msg)
	FamilyModel.instance:csSendFamilyRedPacketGain(msg.redPacketList)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.Family_GainFamilyRedpackInfo, msg)
end

function FamilyController:csGetFamilyRedPacketGetGainRecordReq()
	FamilyRedPacketAgent.instance:sendPM_FamilyRedPacketGetGainRecordReq()
end

function FamilyController:csSendFamilyRedPacketGetGainRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Family_FailyRedpackRecordInfo, msg.gainRecords)
end

function FamilyController:openFamilyRedpackPopup(redpackId)
	if checknumber(redpackId) <= 0 or SceneMgr.instance.isGogingToEnterBattleScene then
		FloatWordMgr.instance:show("该状态不可进行此操作!")

		return
	end

	UIStateManager.instance:push(ViewName.FamilyRedpack, 1, redpackId)
end

function FamilyController:sendSearchFamilyReq(keyword, familyId, moreDetail, openSearchFamilyInChat)
	self._openSearchFamilyInChat = openSearchFamilyInChat

	FamilyAgent.instance:sendSearchFamilyReq(keyword, familyId, moreDetail)
end

function FamilyController:handleSearchFamilyRes(msg)
	FamilyModel.instance:setSearchFamilyInfo(msg)

	if self._openSearchFamilyInChat then
		if msg.searchResult and msg:HasField("searchResult") then
			UIStateManager.instance:push(ViewName.FamilysingleapplyView, msg.searchResult)
		else
			FloatWordMgr.instance:show("无此家族数据")
		end
	end

	self._openSearchFamilyInChat = false
end

function FamilyController:sendGetFamilyActivityPanelInfoReq()
	FamilyAgent.instance:sendGetFamilyActivityPanelInfoReq()
end

function FamilyController:handleGetFamilyActivityPanelInfoRes(msg)
	FamilyModel.instance:handleGetFamilyActivityPanelInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GetFamilyActivityPanelInfoRes)
end

function FamilyController:getFamilyActivityPanelInfoResMsg()
	return FamilyModel.instance:getFamilyActivityPanelInfoResMsg()
end

function FamilyController:openFamilyListView()
	self._originIndex = -1
	self._endIndex = -1
	self._canKeepOnReqing = true

	FamilyModel.instance:clearFamilyViews()
	UIStateManager.instance:push(ViewName.FamilyList)
end

function FamilyController:sendScheduleOpenPartyReq(schedule)
	self._cacheSchedule = schedule

	FamilyAgent.instance:sendScheduleOpenPartyReq(schedule)
end

function FamilyController:handleScheduleOpenPartyRes()
	FamilyModel.instance:onScheduleOpenPartyRes(self._cacheSchedule)

	self._cacheSchedule = nil
end

function FamilyController:sendGetFamilyTotemInfoReq()
	FamilyAgent.instance:sendGetFamilyTotemInfoReq()
end

function FamilyController:onGetFamilyTotemInfoReq(msg)
	FamilyModel.instance:onGetFamilyTotemInfoReq(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FamilyUpdateTotemInfo)
end

function FamilyController:sendInvokeFamilyTotemInfoReq(list, money)
	self._costMoney = money

	FamilyAgent.instance:sendInvokeFamilyTotemReq(list)
end

function FamilyController:onUpdateFamilyTotemInfoReq(msg)
	FamilyModel.instance:onUpdateFamilyTotemInfoReq(msg, self._costMoney)
	GlobalDispatcher:dispatch(GlobalNotify.FamilyUpdateTotemInfo)
end

FamilyController.instance = FamilyController.New()

return FamilyController
