-- chunkname: @modules/logic/scene/room/comp/RoomSceneTweenComp.lua

module("modules.logic.scene.room.comp.RoomSceneTweenComp", package.seeall)

local RoomSceneTweenComp = class("RoomSceneTweenComp", BaseSceneComp)

function RoomSceneTweenComp:onInit()
	self._initialized = false
end

function RoomSceneTweenComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._tweenId = 0
	self._tweenParamDict = {}
	self._toDeleteTweenIdDict = {}

	TaskDispatcher.runRepeat(self._onUpdate, self, 0)

	self._initialized = true
end

function RoomSceneTweenComp:getTweenId()
	self._tweenId = self._tweenId + 1

	return self._tweenId
end

function RoomSceneTweenComp:tweenFloat(from, to, duration, frameCallback, finishCallback, target, object, ease)
	local tweenId = self:getTweenId()

	self._tweenParamDict[tweenId] = {
		time = 0,
		from = from,
		to = to,
		duration = duration,
		frameCallback = frameCallback,
		finishCallback = finishCallback,
		target = target,
		object = object,
		ease = ease
	}

	return tweenId
end

function RoomSceneTweenComp:killById(tweenId)
	if not tweenId then
		return
	end

	self._toDeleteTweenIdDict[tweenId] = true
end

function RoomSceneTweenComp:_onUpdate()
	if not self._tweenParamDict or not self._initialized then
		return
	end

	for tweenId, param in pairs(self._tweenParamDict) do
		if not self._toDeleteTweenIdDict[tweenId] then
			param.time = param.time + Time.deltaTime

			if param.time > param.duration then
				self._toDeleteTweenIdDict[tweenId] = true

				if param.finishCallback then
					if param.target then
						param.finishCallback(param.target, param.object)
					else
						param.finishCallback(param.object)
					end
				end
			elseif param.frameCallback then
				local float = self:getFloat(param.from, param.to, param.duration, param.time, param.ease)

				if param.target then
					param.frameCallback(param.target, float, param.object)
				else
					param.frameCallback(float, param.object)
				end
			end
		end
	end

	local isHasDelete = false

	for tweenId, _ in pairs(self._toDeleteTweenIdDict) do
		self._tweenParamDict[tweenId] = nil
		isHasDelete = true
	end

	if isHasDelete then
		self._toDeleteTweenIdDict = {}
	end
end

function RoomSceneTweenComp:getFloat(from, to, duration, time, ease)
	if time < 0 then
		return from
	elseif duration < time then
		return to
	end

	if ease then
		return LuaTween.tween(time, from, to - from, duration, ease)
	else
		local lerp = time / duration

		return from * (1 - lerp) + to * lerp
	end
end

function RoomSceneTweenComp:onSceneClose()
	self._initialized = false

	TaskDispatcher.cancelTask(self._onUpdate, self)

	self._tweenId = 0
	self._tweenParamDict = {}
	self._toDeleteTweenIdDict = {}
	self._initialized = false
end

return RoomSceneTweenComp
