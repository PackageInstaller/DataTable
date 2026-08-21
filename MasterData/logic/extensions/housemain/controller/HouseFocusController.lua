-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/controller/HouseFocusController.lua

module("logic.extensions.housemain.controller.HouseFocusController", package.seeall)

local M = class("HouseFocusController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	self:setEvent(true)
	self:onReset()
end

function M:onReset()
	self._focusFinishCBHandler = nil
	self._focusFinishCBFunc = nil
	self._waitForActiveMsg = nil

	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end
end

function M:setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onSceneCameraRefresh, self)
		HouseDispatcher:addEventListener(HouseEventType.TRY_FOCUS_ROOM, self._handleTryFocusRoom, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self.handleOnFocusRoomExist, self)
		HouseDispatcher:addEventListener(HouseEventType.TRY_ACTIVE_ROOM, self._handleTryActiveRoom, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self.handleHouseHoldRoomInfoChange, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._handleLiveZoneInfoRefresh, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onSceneCameraRefresh, self)
		HouseDispatcher:removeEventListener(HouseEventType.TRY_FOCUS_ROOM, self._handleTryFocusRoom, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FOCUS_ROOM_EXIST, self.handleOnFocusRoomExist, self)
		HouseDispatcher:removeEventListener(HouseEventType.TRY_ACTIVE_ROOM, self._handleTryActiveRoom, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self.handleHouseHoldRoomInfoChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_INFO_REFRESH, self._handleLiveZoneInfoRefresh, self)
	end
end

function M:dealHitRoomToFocus(hitGO)
	local canExcute = false
	local state = HouseMainStateModel.instance:getState()

	if state == HouseMainEnum.State.Normal or state == HouseMainEnum.State.ViewMode then
		local goName = ""
		local parentTrf

		if hitGO then
			parentTrf = hitGO.transform.parent
		end

		if parentTrf then
			goName = parentTrf.gameObject.name

			print(string.format("点击场景碰撞器[%s]", goName))
		end

		local strSplitLst = string.split(goName, "_")
		local storeyId = tonumber(strSplitLst[2])
		local roomId = tonumber(strSplitLst[3])

		if storeyId ~= nil and roomId ~= nil then
			local cfgRoomId = 1000 + storeyId * 100 + roomId
			local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)

			if HouseMainUtil.canFocusRoomById(cfgRoomId) and roomCO then
				canExcute = true

				HouseDispatcher:dispatchEvent(HouseEventType.READY_FOCUS_ROOM, true)
				HouseMainStateModel.instance:changeState(HouseMainEnum.State.FocusRoom)
				self:doFocusRoom(cfgRoomId, true)
			end

			if not roomCO then
				printError("无法找到[t_house_zone]小屋编号[%d]的配置", cfgRoomId)
			end
		end
	end

	return canExcute
end

function M:_onSceneCameraRefresh(e, ringType, camContrastAngle)
	HouseModel.instance:setLastHouseCamContrastAngle(camContrastAngle)
end

function M:_handleTryFocusRoom(e, cfgRoomId, cacheRoomCam, callBackFunc, callBackHandler)
	self:_tryFocusRoom(cfgRoomId, cacheRoomCam, callBackFunc, callBackHandler)
end

function M:handleOnFocusRoomExist(e)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.House then
		self:doFocusRoom(nil, false)
	else
		printWarn("非小屋场景，不响应退出房间镜头操作")
	end
end

function M:_handleTryActiveRoom(e, info)
	if self._waitForActiveMsg then
		printWarn(string.format("存在等待激活的房间[%d]", self._waitForActiveMsg.roomId))
	end

	self._waitForActiveMsg = info

	printWarn(string.format("tryActiveRoom[%d] focus[%s]", info.roomId, info.focus))
	LivingFacilitiesAgent.instance:sendActiveZoneRequest(info.roomId)
end

function M:handleHouseHoldRoomInfoChange()
	if self._waitForActiveMsg then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, self._waitForActiveMsg.roomId)

		if roomCO and roomCO.roomType == HouseEnum.RoomType.Shelter then
			if self._waitForActiveMsg.focus then
				self:_tryFocusRoom(self._waitForActiveMsg.roomId)
			end

			self._waitForActiveMsg = nil
		end
	end
end

function M:_handleLiveZoneInfoRefresh(e, zoneId)
	local info = self._waitForActiveMsg

	if info and info.roomId == zoneId then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

		if roomCO and roomCO.roomType == HouseEnum.RoomType.Living then
			LivingFacilitiesZoneController.instance:setCurrentZoneId(zoneId)
		end

		if info.focus then
			self:_tryFocusRoom(zoneId, false, info.callBackFunc, info.callBackHandler)
		else
			self._waitForActiveMsg = nil
		end
	end
end

function M:_tryFocusRoom(cfgRoomId, cacheRoomCam, callBackFunc, callBackHandler)
	self._focusFinishCBFunc = callBackFunc
	self._focusFinishCBHandler = callBackHandler

	local state = HouseMainStateModel.instance:getState()

	if state == HouseMainEnum.State.Normal or state == HouseMainEnum.State.ViewMode then
		if not HouseMainUtil.canFocusRoomById(cfgRoomId) then
			HouseDispatcher:dispatchEvent(HouseEventType.READY_FOCUS_ROOM, false)
			self:_excuteFocusRoomCB()

			return
		end

		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)

		if roomCO then
			printWarn(string.format("准备聚焦房间[%d]", cfgRoomId))
			HouseDispatcher:dispatchEvent(HouseEventType.READY_FOCUS_ROOM, true)
			HouseMainStateModel.instance:changeState(HouseMainEnum.State.FocusRoom)
			self:doFocusRoom(cfgRoomId, true, true, cacheRoomCam)
		else
			HouseDispatcher:dispatchEvent(HouseEventType.READY_FOCUS_ROOM, false)
			printError(string.format("无法找到[t_house_zone]小屋编号[%d]的配置", cfgRoomId))
			self:_excuteFocusRoomCB()
		end
	else
		HouseDispatcher:dispatchEvent(HouseEventType.READY_FOCUS_ROOM, false)
		printWarn(string.format("不能聚焦房间，state=>%d", state))
		self:_excuteFocusRoomCB()
	end
end

function M:_excuteFocusRoomCB()
	if self._focusFinishCBFunc then
		self._focusFinishCBFunc(self._focusFinishCBHandler)
	end

	self._focusFinishCBHandler = nil
	self._focusFinishCBFunc = nil
	self._waitForActiveMsg = nil
end

function M:doFocusRoom(cfgRoomId, enter, aniZone, cacheRoomCam)
	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end

	if enter then
		local ringTyp = NavMeshUtil.getRingTypeByZoneId(cfgRoomId)

		if cacheRoomCam then
			self:_cacheCameraInfoFuncRoom(cfgRoomId)
		else
			self:_cacheCameraInfoFunc()
		end

		local duration = 0.3
		local tempAngle = Vector3.New()
		local tempPos = Vector3.New()
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)
		local angle = roomCO.angle

		self._camContrastAngle = angle

		tempAngle:Set(0, 0, angle)

		local pos = string.split(roomCO.focusPos, "#")

		tempPos:Set(pos[1] or 0, pos[2] or 0, pos[3] or 0)

		local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
		local camGO = houseCameraUnit:getMainGO()

		camGO.transform:DOKill(false)

		if aniZone then
			Astral.TransformUtil.SetLocalRotation(camGO.transform, 0, 0, tempAngle.z)
			HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, ringTyp, angle)
			houseCameraUnit:setPosition(tempPos.x, tempPos.y, tempPos.z - 10)
		end

		camGO.transform:DOLocalMove(tempPos, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		camGO.transform:DORotate(tempAngle, duration, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

		self._delayTween = DoTweenUtil.DelayedCall(duration, function()
			Astral.TransformUtil.SetLocalRotation(camGO.transform, 0, 0, tempAngle.z)
			HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_ENTER, cfgRoomId)
			HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, ringTyp, angle)
			HouseMainRoomModel.instance:setFocusRoomId(cfgRoomId)
			HouseModel.instance:setOnceEnterRoomId(cfgRoomId)

			local state = HouseMainStateModel.instance:getState()

			if state == HouseMainEnum.State.FocusRoom or state == HouseMainEnum.State.ViewMode then
				local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)
				local roomTyp = HouseEnum.RoomType

				if roomCO.roomType == roomTyp.Supervisor then
					if not ViewMgr.instance:isOpen(ViewName.SupervisorMain) then
						ViewMgr.instance:open(ViewName.SupervisorMain)
					end
				elseif roomCO.roomType == roomTyp.Trading then
					if not ViewMgr.instance:isOpen(ViewName.TradingEntrance) then
						ViewMgr.instance:open(ViewName.TradingEntrance)
					end
				elseif roomCO.roomType == roomTyp.Manufacturing then
					if not ViewMgr.instance:isOpen(ViewName.ManufactureMain) then
						ViewMgr.instance:open(ViewName.ManufactureMain)
					end
				elseif roomCO.roomType == roomTyp.Shelter then
					if not ViewMgr.instance:isOpen(ViewName.FacilityHoldingMainView) then
						ContainmentFacade.instance:openHoldingMainView(cfgRoomId)
					end
				elseif roomCO.roomType == roomTyp.Living and not ViewMgr.instance:isOpen(ViewName.LivingFacilitiesMain) then
					LivingFacilitiesFacade.instance:enterLivingFacilities(cfgRoomId)
				end
			else
				printWarn("当前不能跳转，state = ", state)
			end

			self:_excuteFocusRoomCB()
		end, self)
	else
		if self._cacheCameraInfo == nil then
			if cfgRoomId then
				self:_cacheCameraInfoFuncRoom(cfgRoomId)
			else
				return
			end
		end

		local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
		local camGO = houseCameraUnit:getMainGO()

		if camGO then
			local tempPos = self._cacheCameraInfo.pos
			local tempAngle = self._cacheCameraInfo.angle
			local ringType = self._cacheCameraInfo.ringType
			local angle = tempAngle.z
			local duration = 0.3

			camGO.transform:DOKill(false)
			camGO.transform:DOLocalMove(tempPos, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
			camGO.transform:DORotate(tempAngle, duration, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

			self._delayTween = DoTweenUtil.DelayedCall(duration, function()
				Astral.TransformUtil.SetLocalRotation(camGO.transform, 0, 0, angle)
				HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, ringType, angle)
			end, self)
		end

		self._cacheCameraInfo = nil
	end
end

function M:_cacheCameraInfoFuncRoom(cfgRoomId)
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, cfgRoomId)
	local angle = roomCO.angle
	local tempAngle = Vector3.New()

	tempAngle:Set(0, 0, angle)

	local tempPos = Vector3.New()
	local ringType = NavMeshUtil.getRingTypeByZoneId(cfgRoomId)
	local defaultScale = HouseModel.instance:getScaleNormal()
	local cameraParam = HouseConfig.instance:getConfigByKey(ConfigName.HouseRingCameraParam, ringType)
	local strList = string.split(cameraParam.rangePosZ, "#")
	local minVal, maxVal = tonumber(strList[1]), tonumber(strList[2])
	local posZ = (maxVal - minVal) * defaultScale + minVal
	local pos = string.split(roomCO.focusPos, "#")

	tempPos:Set(pos[1] or 0, pos[2] or 0, posZ)

	self._cacheCameraInfo = {
		roomId = cfgRoomId,
		ringType = ringType,
		pos = tempPos,
		angle = tempAngle
	}
end

function M:_cacheCameraInfoFunc()
	local scene = SceneMgr.instance:getCurScene()
	local houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	local camGO = houseCameraUnit:getMainGO()
	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(camGO.transform, 0, 0, 0)
	local tempAngle = Vector3.New()

	tempAngle:Set(rotaX, rotaY, rotaZ)

	self._cacheCameraInfo = {
		ringType = scene.pickerHandler:getRingType(),
		pos = houseCameraUnit:getPosition(),
		angle = tempAngle
	}
end

M.instance = M.New()

return M
