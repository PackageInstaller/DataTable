-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoUnitCompAni.lua

module("logic.common.photo.PhotoUnitCompAni", package.seeall)

local M = class("PhotoUnitCompAni", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._unitSpine = self._unit:getUnit()
	self._showAnimIndex = 1
	self._showAnims = {}
	self._randomTimes = 0
	self._showXiuXainAnim = false
	self._showEggAnim = false
	self._randomXxTimes = 0
	self._xxAnimaTimes = 0
end

function M:onDestroy()
	self._showAnimIndex = 1
	self._showAnims = {}
	self._randomTimes = 0
	self._showXiuXainAnim = false
	self._showEggAnim = false
	self._randomXxTimes = 0
	self._xxAnimaTimes = 0
end

function M:setAnimation()
	local skeAnim = self._unitSpine.spine:getSkeletonAnimation()

	if not skeAnim then
		return
	end

	if self._unit._isPlayNormalAnimation then
		return
	end

	local isNormalFace = false

	if string.find(self._unit._defaultFace, self._unit._faceResName) then
		isNormalFace = true
	end

	local xiuxianList = self:findAnima(UnitAnimState.XiuXian)
	local isShowAnim = #xiuxianList > 0 and self._unit._isShowEgg and isNormalFace
	local isEnterAnim = skeAnim:ContainsAnimation(UnitAnimState.Enter) and self._unit._isShowEnter
	local isShowXiuXian = #xiuxianList > 0 and self._unit._isShowXiuXian and isNormalFace

	table.clear(self._showAnims)

	if isShowAnim then
		self._showAnimIndex = 0
		self._showEggAnim = true
		self._randomXxTimes = math.random(1, 2)
		self._randomTimes = math.random(1, 2)
		self._xxAnimaTimes = 0

		if isEnterAnim then
			self:play(UnitAnimState.Enter)
		else
			self:play(UnitAnimState.Idle)
		end
	elseif isShowXiuXian then
		self._showAnimIndex = 0
		self._showXiuXainAnim = true
		self._randomTimes = math.random(2, 3)

		self:play(UnitAnimState.Idle)
	elseif isEnterAnim then
		self:play(UnitAnimState.Enter)
	else
		self:play(UnitAnimState.Idle, true)
	end
end

function M:_onSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	if self._unit._isPlayNormalAnimation then
		return
	end

	if eventName == SpineEventName.Complete then
		if self._unit._isShowEnter then
			self:play(UnitAnimState.Idle, not self._showEggAnim)

			self._unit._isShowEnter = false
		elseif self._showXiuXainAnim then
			if animationName == UnitAnimState.Idle then
				self._showAnimIndex = self._showAnimIndex + 1

				if self._randomTimes == self._showAnimIndex then
					self._randomTimes = math.random(2, 3)
					self._showAnimIndex = 0

					local tmpAnimList = self:findAnima(UnitAnimState.XiuXian)
					local aimaName = tmpAnimList[math.random(#tmpAnimList)]

					self:play(aimaName)
				else
					self:play(UnitAnimState.Idle)
				end
			else
				self:play(UnitAnimState.Idle)
			end
		elseif self._showEggAnim then
			if animationName == UnitAnimState.Idle then
				self._showAnimIndex = self._showAnimIndex + 1

				if self._randomTimes <= self._showAnimIndex then
					self._xxAnimaTimes = self._xxAnimaTimes + 1

					local tmpAnimList = self:findAnima(UnitAnimState.XiuXian)
					local aimaName = tmpAnimList[math.random(#tmpAnimList)]

					self:play(aimaName)
				else
					self:play(UnitAnimState.Idle)
				end
			elseif string.find(animationName, UnitAnimState.XiuXian) ~= nil then
				if self._xxAnimaTimes == self._randomXxTimes then
					self._xxAnimaTimes = 0
					self._showAnimIndex = 0
					self._randomTimes = math.random(1, 2)
					self._randomXxTimes = math.random(1, 2)

					local tmpAnimList = self:findAnima(UnitAnimState.Show)

					if #tmpAnimList > 0 then
						local aimaName = tmpAnimList[math.random(#tmpAnimList)]

						self:play(aimaName)
					else
						local tmpAnimList2 = self:findAnima(UnitAnimState.XiuXian)
						local aimaName = tmpAnimList2[math.random(#tmpAnimList2)]

						self:play(aimaName)
					end
				else
					self:play(UnitAnimState.Idle)
				end
			else
				self:play(UnitAnimState.Idle)
			end
		end
	end
end

function M:play(animState, isLoop)
	self._unit:play(animState, isLoop)
end

function M:findAnima(animationName)
	local result = {}
	local skeAnim = self._unitSpine.spine:getSkeletonAnimation()

	if not skeAnim then
		return
	end

	local hasFind = skeAnim:ContainsAnimation(animationName)

	if hasFind then
		table.insert(result, animationName)
	end

	for i = 1, 9 do
		local tempAimaName = animationName .. i
		local hasFind2 = skeAnim:ContainsAnimation(tempAimaName)

		if hasFind2 then
			table.insert(result, tempAimaName)
		end
	end

	return result
end

return M
