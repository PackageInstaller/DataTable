-- chunkname: @modules/logic/room/entity/comp/RoomAlphaThresholdComp.lua

module("modules.logic.room.entity.comp.RoomAlphaThresholdComp", package.seeall)

local RoomAlphaThresholdComp = class("RoomAlphaThresholdComp", LuaCompBase)

function RoomAlphaThresholdComp:ctor(entity)
	self.entity = entity
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
	self.__willDestroy = false
	self._tweenAlphaParams = {}
end

function RoomAlphaThresholdComp:init(go)
	self.go = go
end

function RoomAlphaThresholdComp:setEffectKey(key)
	self._effectKey = key
end

function RoomAlphaThresholdComp:tweenAlphaThreshold(from, to, duration, finishCb, finishCbObj)
	if self.__willDestroy then
		return
	end

	self._tweenAlphaParams.hasWaitRun = true
	self._tweenAlphaParams.form = from
	self._tweenAlphaParams.to = to
	self._tweenAlphaParams.duration = duration
	self._finishCb = finishCb
	self._finishCbObj = finishCbObj
	self._scene = GameSceneMgr.instance:getCurScene()

	self:_runTweenAlpha()
end

function RoomAlphaThresholdComp:_runTweenAlpha()
	if self._tweenAlphaParams.hasWaitRun then
		self._tweenAlphaParams.hasWaitRun = false

		self:_killTweenAlpha()

		if self.entity.effect:isHasEffectGOByKey(self._effectKey) then
			self._tweenAlphaId = self._scene.tween:tweenFloat(0, 1, self._tweenAlphaParams.duration, self._frameAlphaCallback, self._finishAlphaTween, self, self._tweenAlphaParams)
		end
	end
end

function RoomAlphaThresholdComp:_killTweenAlpha()
	if self._tweenAlphaId then
		if self._scene and self._scene.tween then
			self._scene.tween:killById(self._tweenAlphaId)
		end

		self._tweenAlphaId = nil
	end
end

function RoomAlphaThresholdComp:_frameAlphaCallback(value, param)
	local alphaValue = param.form + (param.to - param.form) * value

	self.entity.effect:setMPB(self._effectKey, false, alphaValue > 0.01, alphaValue)
end

function RoomAlphaThresholdComp:_finishAlphaTween()
	if self.__willDestroy or not self._finishCb then
		return
	end

	self._tweenAlphaId = nil

	self._finishCb(self._finishCbObj)

	self._finishCb = nil
	self._finishCbObj = nil
end

function RoomAlphaThresholdComp:beforeDestroy()
	self.__willDestroy = true

	self:_killTweenAlpha()

	self._finishCb = nil
	self._finishCbObj = nil
end

function RoomAlphaThresholdComp:onEffectReturn(key, res)
	if self._tweenAlphaId and key == self._effectKey then
		self.entity.effect:setMPB(self._effectKey, false, false, 0)
	end
end

return RoomAlphaThresholdComp
