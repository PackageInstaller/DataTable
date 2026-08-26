-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandGyroComp.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandGyroComp", package.seeall)

local FairyLandGyroComp = class("FairyLandGyroComp")
local Time = UnityEngine.Time

function FairyLandGyroComp:init(param)
	self.shakeCallback = param.callback
	self.shakeCallbackObj = param.callbackObj
	self.shakeGO = param.go
	self.isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	self._aniGoList = {}

	local shakeGOParam = {}
	local transform = self.shakeGO.transform
	local initPos = transform.localPosition

	shakeGOParam.posLimit = param.posLimit
	shakeGOParam.deltaPos = 5
	shakeGOParam.lerpPos = 10

	local goParam = {
		transform = transform,
		config = shakeGOParam,
		initPos = initPos
	}

	table.insert(self._aniGoList, goParam)

	local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	self._acceleration = Vector3.New(curX, curY, curZ)
	self._curAcceleration = Vector3.New(curX, curY, curZ)
	self._offsetPos = Vector3.zero
	self._tempPos = Vector3.zero

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._tick, self)
	end
end

function FairyLandGyroComp:checkInDrag()
	return self.shakeCallbackObj.inDrag
end

function FairyLandGyroComp:_tick()
	if self.isMobilePlayer and not self:checkInDrag() then
		local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

		self._curAcceleration:Set(curX, curY, curZ)

		local offsetPos = self._offsetPos
		local transform, config, pos, x, y

		if self._aniGoList then
			for i, v in ipairs(self._aniGoList) do
				offsetPos.x = self._curAcceleration.x - self._acceleration.x
				offsetPos.y = self._curAcceleration.y - self._acceleration.y
				x, y = transformhelper.getLocalPos(v.transform)
				pos = self:calcPos(v.initPos, offsetPos, v.config.deltaPos)
				pos = self:clampPos(pos, v.initPos, v.config.posLimit)

				transformhelper.setLocalLerp(v.transform, pos.x, pos.y, pos.z, Time.deltaTime * v.config.lerpPos)
			end
		end
	end

	self:doShake()
end

function FairyLandGyroComp:clampPos(position, initPos, limit)
	local distance = Vector3.Distance(initPos, position)

	if distance < limit then
		return position
	end

	local offsetPos = position - initPos

	return initPos + offsetPos.normalized * limit
end

function FairyLandGyroComp:calcPos(initPos, offsetPos, deltaPos)
	local temp = self._tempPos

	temp.x = initPos.x + offsetPos.x * deltaPos
	temp.y = initPos.y + offsetPos.y * deltaPos

	return temp
end

function FairyLandGyroComp:doShake()
	if self.shakeCallback then
		self.shakeCallback(self.shakeCallbackObj)
	end
end

function FairyLandGyroComp:closeGyro()
	if self._isRunning then
		self._isRunning = false

		LateUpdateBeat:Remove(self._tick, self)
	end
end

return FairyLandGyroComp
