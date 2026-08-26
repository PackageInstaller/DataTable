-- chunkname: @modules/logic/room/entity/comp/RoomCrossloadComp.lua

module("modules.logic.room.entity.comp.RoomCrossloadComp", package.seeall)

local RoomCrossloadComp = class("RoomCrossloadComp", LuaCompBase)

function RoomCrossloadComp:ctor(entity)
	self.entity = entity
end

function RoomCrossloadComp:init(go)
	self.go = go
	self._mo = self.entity:getMO()
	self._crossload = RoomBuildingEnum.Crossload[self._mo.buildingId]
	self._nextTime = 0
	self._durtion = 5
	self._isCanMove = true
	self._defaultAnimTime = 2.1
	self._animTime = 2.1

	self:reset()
end

function RoomCrossloadComp:getCurResId()
	return self._curResId
end

function RoomCrossloadComp:getCanMove()
	return self._isCanMove
end

function RoomCrossloadComp:reset()
	self._curResId = nil

	if self:_canWork() then
		self:_runDelayInitAnim(3)
	end
end

function RoomCrossloadComp:_canWork()
	return RoomController.instance:isObMode() or RoomController.instance:isVisitMode()
end

function RoomCrossloadComp:playAnim(resId)
	if not self:_canWork() then
		return
	end

	if resId == self._curResId then
		local tempNextTime = Time.time + self._durtion

		if tempNextTime > self._nextTime then
			self._nextTime = tempNextTime
		end

		return
	end

	if Time.time < self._nextTime then
		return
	end

	self:_playAnim(resId)
	self:_runDelayInitAnim(self._animTime + self._durtion)
end

function RoomCrossloadComp:_runDelayInitAnim(duration)
	TaskDispatcher.cancelTask(self._playInitAnim, self)
	TaskDispatcher.runDelay(self._playInitAnim, self, duration)
end

function RoomCrossloadComp:_playInitAnim()
	local resId = self:_getInitResId()

	if resId ~= self._curResId then
		self:_playAnim(resId, self._curResId == nil)
	end
end

function RoomCrossloadComp:_playAnim(resId, isOne)
	local animName, animTime, audioId = self:_findAninNameByResId(resId)

	if not animName then
		return
	end

	local anim = self:_getAnimator()

	if anim then
		self._isCanMove = self._curResId == resId
		self._curResId = resId
		self._animTime = animTime or self._defineAnimTime

		self._animator:Play(animName, 0, isOne and 1 or 0)
		TaskDispatcher.cancelTask(self._delayOpenOrClose, self)
		TaskDispatcher.runDelay(self._delayOpenOrClose, self, self._animTime)

		self._nextTime = Time.time + self._durtion

		if not isOne and audioId and audioId ~= 0 then
			self.entity:playAudio(audioId, self.go)
		end
	end
end

function RoomCrossloadComp:_delayOpenOrClose()
	if not RoomCrossLoadController.instance:isLock() then
		RoomCrossLoadController.instance:updatePathGraphic(self._mo.id)

		self._isCanMove = true
	else
		self._curResId = nil
	end
end

function RoomCrossloadComp:addEventListeners()
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._onSwitchModel, self)
end

function RoomCrossloadComp:removeEventListeners()
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self._onSwitchModel, self)
	TaskDispatcher.cancelTask(self._playInitAnim, self)
	TaskDispatcher.cancelTask(self._delayOpenOrClose, self)
end

function RoomCrossloadComp:_onSwitchModel()
	self:reset()
end

function RoomCrossloadComp:_findAninNameByResId(resId)
	if self._crossload and self._crossload.AnimStatus then
		local AnimStatus = self._crossload.AnimStatus

		for i, coss in ipairs(AnimStatus) do
			if coss.resId == resId then
				return coss.animName, coss.animTime, coss.audioId
			end
		end
	end
end

function RoomCrossloadComp:_getInitResId()
	if self._crossload and self._crossload.AnimStatus then
		return self._crossload.AnimStatus[1].resId
	end
end

function RoomCrossloadComp:_getAnimator()
	if not self._animator then
		local buildingGO = self.entity:getBuildingGO()

		if buildingGO then
			self._animator = buildingGO:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	return self._animator
end

function RoomCrossloadComp:beforeDestroy()
	self._animator = nil

	self:removeEventListeners()
end

return RoomCrossloadComp
