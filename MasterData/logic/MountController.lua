-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/controller/MountController.lua

module("logic.extensions.Mount.controller.MountController", package.seeall)

local MountController = class("MountController", BaseController)

function MountController:ctor()
	return
end

local MountItemId = {
	levelup = 901,
	breach = 902
}

function MountController:onInit()
	self:onReset()
	MountAgent.instance:addHandler(MountAgent.NotifyMountChangedRes, self.onAttChange, self)
	MountAgent.instance:addHandler(MountAgent.MountLevelUpRes, self.barrageShow, self)

	local allMountCfg = MountConfig.instance:getAllMounts()

	for k, v in pairs(allMountCfg) do
		local matId = v.activationItem
		local str = string.split(matId, ":")

		if str and #str > 0 then
			table.insert(MountItemId, checknumber(str[2]))
		end
	end
end

function MountController:onReset()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self._updateMatRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnNewFunctionOpen, self._updateFuncRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMainUIFuncs, self.checkEntranceRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self._updateMatRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNewFunctionOpen, self._updateFuncRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateMainUIFuncs, self.checkEntranceRedPoint, self)

	self.msgMap = {}
	self._NeedSyncEnterCity = false
end

function MountController:getMountInfo(callBack)
	if #MountModel.instance._lockmounts > 0 and MountModel.instance._curMountId then
		GameUtil.callBack(callBack)
	else
		self.callBackList = self.callBackList or {}

		table.insert(self.callBackList, callBack)
		MountAgent.instance:sendMountInfoReq(function(msg)
			forcePrint("=====RoleDataRequestor:_loadMountInfo===back")
			MountModel.instance:initMountInfo(msg)
			GlobalDispatcher:dispatch(GlobalNotify.TeamMountStatusChanged)

			for k, v in pairs(self.callBackList) do
				GameUtil.callBack(v)
			end

			self.callBackList = nil
		end)
	end
end

function MountController:mountUnlock(mountId, callBack)
	MountAgent.instance:sendMountUnlockReq(mountId, function(msg)
		GameUtil.callBack(callBack)
	end)
end

function MountController:mountChange(mountId)
	if MountModel.instance._curMountId ~= mountId then
		MountAgent.instance:sendMountChangeReq(mountId, function()
			if RoleModel.instance.curCardInfo ~= nil then
				RoleModel.instance.curCardInfo.mountId = mountId
			end
		end)
	end

	MountModel.instance:mountChange(mountId)
	GlobalDispatcher:dispatch(GlobalNotify.TeamMountStatusChanged)
end

function MountController:levelup(mountId, times, callBack)
	local realTimes = self:canCultivateTime(mountId)

	if times < realTimes then
		realTimes = times
	end

	if realTimes == 0 then
		local mo = MountModel.instance:getLockmountsById(mountId)

		if mo then
			local consume = MountModel.instance:getlevelUpConsume(mountId, mo.level)

			self:collectItem(consume)
		end
	else
		MountAgent.instance:sendMountLevelUpReq(mountId, realTimes, function(msg)
			GameUtil.callBack(callBack)
		end)
	end
end

function MountController:breach(mountId)
	local level = MountModel.instance:getLockmountsById(mountId).level
	local consume = MountModel.instance:getBreachConsume(mountId, level)
	local arr = string.split(consume, ":")
	local useNum = checknumber(arr[3])
	local has_num = MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))

	if useNum <= has_num then
		MountAgent.instance:sendMountBreachReq(mountId, function(msg)
			local data = {}
			local level = MountModel.instance:getLockmountsById(mountId).level

			data.att = MountModel.instance:getActiveAtt(mountId, level)
			data.lightup = level

			UIStateManager.instance:open(ViewName.MountbreachsuccessView, data)
		end)
	else
		self:collectItem(consume)
	end
end

function MountController:getAllMounts()
	return MountModel.instance:getAllMounts()
end

function MountController:getIfLock(mountId)
	local lockmounts = MountModel.instance:getLockmounts()

	if lockmounts ~= nil then
		for k, v in pairs(lockmounts) do
			if v.mountId == mountId then
				return true
			end
		end
	end

	return false
end

function MountController:onAttChange(msg)
	for k, v in ipairs(msg.mountInfo) do
		MountModel.instance:readMount(v)
	end

	BagPetsController.instance:calcAllMountAttr()
	self:notify(GlobalNotify.MountInfo)
end

function MountController:barrageShow(msg)
	self:notify(GlobalNotify.MountAttributeShow, msg.addProperty)
end

function MountController:getIfCanUnlock(mountId)
	local consume = MountModel.instance:getActivationItem(mountId)
	local arr = string.split(consume, ":")
	local useNum = checknumber(arr[3])
	local has_num = MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))

	if useNum <= has_num then
		return true
	else
		return false
	end
end

function MountController:getIfReachAttLimit(mountId)
	local lockMount = MountModel.instance:getLockmountsById(mountId)

	if lockMount then
		local level = lockMount.level
		local attMaxList = MountModel.instance:getAttMax(mountId, level)
		local canBreach = true
		local curAttrList = MountModel.instance:getCurAtt(mountId)

		for i = 1, #attMaxList do
			if curAttrList[i].value < attMaxList[i].value then
				canBreach = false
			end
		end

		return canBreach
	end

	return false
end

function MountController:canCultivateTime(mountId)
	local mo = MountModel.instance:getLockmountsById(mountId)

	if mo then
		local level = mo.level
		local attPlanId = MountModel.instance:getAttPlanId(mountId, level)
		local curAttrList = MountModel.instance:getCurAtt(mountId)
		local attMaxList = MountModel.instance:getAttMax(mountId, level)
		local left_num = 0

		for i = 1, #curAttrList do
			if curAttrList[i].value < attMaxList[i].value then
				local attrType = attMaxList[i].attrType
				local addValue = MountConfig.instance:getAttAddValue(attPlanId, attrType)
				local k = math.ceil((attMaxList[i].value - curAttrList[i].value) / addValue)

				left_num = left_num + k
			end

			if left_num > 10 then
				break
			end
		end

		local consume = MountModel.instance:getlevelUpConsume(mountId, level)
		local arr = string.split(consume, ":")
		local use_num = checknumber(arr[3])
		local has_num = MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))
		local can_num = math.floor(has_num / use_num)

		left_num = math.floor(left_num)

		if left_num < can_num then
			can_num = left_num
		end

		return can_num
	else
		return 0
	end
end

function MountController:collectItem(consume)
	MaterialMgr.openGetSourceByStr(consume)
end

function MountController:openMarkUp(mountId)
	UIStateManager.instance:open(ViewName.MountmarkupView, mountId)
end

function MountController:checkMatId(matId)
	for k, v in pairs(MountItemId) do
		if v == matId then
			return true
		end
	end

	return false
end

function MountController:checkEntranceRedPoint()
	local retUnlock = false
	local retCultivate = false
	local retBreach = false
	local allMounts = MountModel.instance:getAllMounts()

	for k, v in pairs(allMounts) do
		local data1, data2, data3 = self:checkMountRedpoint(v.id)

		retUnlock = retUnlock or data1
		retCultivate = retCultivate or data2
		retBreach = retBreach or data3
	end

	if retUnlock or retCultivate or retBreach then
		::label_24_0::

		local ret = FuncOpenModel.instance:getFuncIsOpen(101)

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_MOUNT_ENTRANCE, ret)
	end
end

function MountController:checkMountRedpoint(moundId)
	local retUnlock = false
	local retCultivate = false
	local retBreach = false
	local ifLock = MountController.instance:getIfLock(moundId)

	if MountController.instance:getIfLock(moundId) then
		local IfReachAttLimit = self:getIfReachAttLimit(moundId)
		local lockMo = MountModel.instance:getLockmountsById(moundId)

		if lockMo then
			if not lockMo.level then
				local level = 0

				if IfReachAttLimit then
					if level ~= MountModel.instance:getMaxLevel(moundId) then
						local hasNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.breach)
						local consume = MountModel.instance:getBreachConsume(moundId, level)

						if consume then
							local arr = string.split(consume, ":")
							local useNum = checknumber(arr[3])

							if useNum <= hasNum then
								retBreach = true
							end
						end
					end
				else
					local hasNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.levelup)
					local consume = MountModel.instance:getlevelUpConsume(moundId, level)
					local arr = string.split(consume, ":")
					local use_num = checknumber(arr[3])

					if use_num <= hasNum then
						retCultivate = true
					end
				end
			end
		end
	else
		retUnlock = self:getIfCanUnlock(moundId)
	end

	return retUnlock, retCultivate, retBreach
end

function MountController:_updateFuncRedpoint(funcId)
	if checknumber(funcId) and funcId == 101 then
		self:checkEntranceRedPoint()
	end

	if GameUtil.isTable(funcId) then
		for k, v in pairs(funcId) do
			if v == 101 then
				self:checkEntranceRedPoint()
			end
		end
	end
end

function MountController:_updateMatRedpoint(mo)
	if mo then
		local matId = mo.id

		if self:checkMatId(matId) then
			self:checkEntranceRedPoint()
		end
	end
end

function MountController:handleOneClickDevelopMountRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("一键升级成功"))
	end
end

function MountController:sendMountInviteTeamReq(targetUserId)
	MountAgent.instance:sendMountInviteTeamReq(targetUserId)
end

function MountController:handleMountInviteTeamRes(msg)
	return
end

function MountController:sendMountAgreeTeamReq(targetUserId)
	self._NeedSyncEnterCity = true

	MountAgent.instance:sendMountAgreeTeamReq(targetUserId)
end

function MountController:handleMountAgreeTeamRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self._NeedSyncEnterCity = false
end

function MountController:sendMountLeaveTeamReq()
	MountAgent.instance:sendMountLeaveTeamReq()
end

function MountController:handleMountLeaveTeamRes(msg)
	return
end

function MountController:handleNotifyTeamMountInvitedRes(msg)
	if MountModel.instance:isTeamMountFull() then
		return
	end

	local targetUserId = checknumber(msg.targetUserId)
	local friendMo = FriendModel.instance:getFriendMo(targetUserId)

	if friendMo then
		self:_tryUnregPopupMsg(friendMo.headInfo.userId)

		self.msgMap[friendMo.headInfo.userId] = MainUIPopupMsgController.instance:regPopMsg({
			bTimeOutReject = true,
			showInitCD = 20,
			desc = "双人坐骑-邀请",
			acceptFunc = self._tryAcceptInvite,
			rejectFunc = function()
				return
			end,
			thisArg = self,
			headInfo = friendMo.headInfo
		})
	end
end

function MountController:_tryAcceptInvite(params)
	local info = params.info
	local headInfo = info.headInfo

	self:_tryUnregPopupMsg(headInfo.userId)

	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送")

		return
	end

	MountController.instance:sendMountAgreeTeamReq(headInfo.userId)
end

function MountController:_tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
end

function MountController:handleNotifyTeamMountChangedRes(msg)
	MountModel.instance:onNotifyTeamMountChangedRes(msg)

	self._NeedSyncEnterCity = false

	GlobalDispatcher:dispatch(GlobalNotify.TeamMountStatusChanged)
end

function MountController:handleTeamMountRoomSyncRes(msg)
	if not self._NeedSyncEnterCity and not MountModel.instance:isTeamMountMember() then
		return
	end

	local roomname = msg.roomName
	local targetSceneId = SceneConfig.instance:getSceneIdByEngSceneName(roomname)

	if CityModel.instance.toSceneId > 0 or targetSceneId and targetSceneId > 0 and CityModel.instance.curSceneId == targetSceneId then
		printInfo("CityModel.instance.toSceneId=" .. CityModel.instance.toSceneId .. ",targetSceneId:" .. targetSceneId)

		return
	end

	local curSceneId = CityModel.instance.curSceneId

	if targetSceneId and targetSceneId > 0 then
		CityModel.instance.toSceneId = targetSceneId
		CityModel.instance.fromSceneId = curSceneId
	end

	local sceneCo = SceneConfig.instance:getSceneCo(targetSceneId)

	if not sceneCo then
		printError("不存在的场景,sceneId=" .. targetSceneId)

		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.syncPos then
		mainPlayer.syncPos:disable(true)
		mainPlayer.syncPos:clear()
		mainPlayer.mover:disable(true)
	end

	local posX = CityModel.instance.toScenePosX
	local posY = CityModel.instance.toScenePosY

	if not posX or not posY then
		posX, posY = SceneConfig.instance:getBornPoint(targetSceneId, curSceneId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.LeaveCityDone)
end

MountController.instance = MountController.New()

return MountController
