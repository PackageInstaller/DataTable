-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/skills/SkillAnimationMotion.lua

module("logicscene.scene.battle.skills.skills.SkillAnimationMotion", package.seeall)

local amAMCameraShake = typeof(AMCameraShake)
local SkillAnimationMotion = class("SkillAnimationMotion")
local skeletonAnimationType = typeof(Spine.Unity.SkeletonAnimation)
local easeFuncsDict = {}
local vector3Temp = Vector3.New()

function SkillAnimationMotion:ctor(unit, go, param)
	self._unit = unit
	self._go = go
	self._action = GameUtil.json.decode(param)
end

function SkillAnimationMotion:playAnimation(targets)
	local startPos = Vector3.New(self._action.offsets[1].x, self._action.offsets[1].y, self._action.offsets[1].z)
	local destPos = Vector3.New(self._action.offsets[2].x, self._action.offsets[2].y, self._action.offsets[2].z)
	local spineDir = self._unit.spine:getDirection()
	local isDirFlipX = spineDir ~= UnitSpineDir.Right

	if self:_isTargetsEmpty() then
		local startTarget = self:_getTargetByName()
		local skelAnimStart = startTarget:GetComponentInChildren(skeletonAnimationType)
		local startFlipX = skelAnimStart.Skeleton.FlipX

		startPos = self:_localToWorld(self._unit.go, startPos, isDirFlipX, startFlipX)
		destPos = self:_localToWorld(self._unit.go, destPos, isFlipX, startFlipX)

		local var_2_0 = {
			time = 0,
			go = self._go,
			startPos = startPos,
			destPos = destPos,
			fadeTime = self._action.fadeTime
		}

		var_2_0.easeFunc = easeFuncsDict[self._action.easeType] or easeFuncsDict.linear
		self._sPathCfg = var_2_0

		self:update(0)

		return
	end

	local startTarget = self:_getTargetByName(self._action.targets[1], targets)
	local destTarget = self:_getTargetByName(self._action.targets[2], targets)
	local startFlipX = false
	local destFlipX = false

	if not goutil.isNil(startTarget) then
		local skelAnimStart = startTarget:GetComponentInChildren(skeletonAnimationType)

		if skelAnimStart then
			startFlipX = skelAnimStart.Skeleton.FlipX
		end
	else
		startPos = self._action.paths[1]
	end

	if not goutil.isNil(destTarget) then
		local skelAnimDest = destTarget:GetComponentInChildren(skeletonAnimationType)

		if skelAnimDest then
			destFlipX = skelAnimDest.Skeleton.FlipX
		end
	else
		destPos = self._action.paths[2]
	end

	startPos = self:_localToWorld(startTarget, startPos, isDirFlipX, startFlipX)
	destPos = self:_localToWorld(destTarget, destPos, isDirFlipX, destFlipX)

	local var_2_1 = {
		time = 0,
		go = self._go,
		startPos = startPos,
		destPos = destPos,
		fadeTime = self._action.fadeTime
	}

	var_2_1.easeFunc = easeFuncsDict[self._action.easeType] or easeFuncsDict.linear
	self._sPathCfg = var_2_1

	self:update(0)
end

function SkillAnimationMotion:stopSkill()
	if self._sPathCfg then
		self:update(self._sPathCfg.fadeTime - self._sPathCfg.time)

		self._sPathCfg = nil
	end
end

function SkillAnimationMotion:stop()
	self._sPathCfg = nil
end

function SkillAnimationMotion:update(deltaTime)
	if not self._sPathCfg or self._isPuased then
		return
	end

	self._sPathCfg.time = self._sPathCfg.time + deltaTime

	local percent = math.min(1, math.max(0, self._sPathCfg.time / self._sPathCfg.fadeTime))

	vector3Temp.x = self._sPathCfg.easeFunc(self._sPathCfg.startPos.x, self._sPathCfg.destPos.x, percent)
	vector3Temp.y = self._sPathCfg.easeFunc(self._sPathCfg.startPos.y, self._sPathCfg.destPos.y, percent)
	vector3Temp.z = self._sPathCfg.easeFunc(self._sPathCfg.startPos.z, self._sPathCfg.destPos.z, percent)
	self._sPathCfg.go.transform.position = vector3Temp

	local cameraShake = self._sPathCfg.go:GetComponent(amAMCameraShake)

	if cameraShake then
		cameraShake:SetShakeStartPosition(vector3Temp)
	end

	if self._sPathCfg.time >= self._sPathCfg.fadeTime then
		self._sPathCfg = nil
	end
end

function SkillAnimationMotion:pause()
	self._isPuased = true
end

function SkillAnimationMotion:resume()
	self._isPuased = nil
end

function SkillAnimationMotion:convertEaseType(easeType)
	return UnityTweens.EaseType[easeType]
end

function SkillAnimationMotion:_getTargetByName(name, targets)
	if string.nilorempty(name) or name == "AMPlayer" then
		return self._unit.go
	end

	if string.find(name, "Target") then
		local idx = math.min(#targets, checknumber(string.sub(name, 7)) + 1)
		local tgt = targets[idx]

		if tgt then
			return tgt.unit.go
		end
	end
end

function SkillAnimationMotion:_localToWorld(go, offset, isDirFlipX, isSpineFlipX)
	if goutil.isNil(go) then
		if isDirFlipX then
			offset.x = -offset.x
		end

		return offset
	end

	local pos = go.transform.position

	if isSpineFlipX then
		offset.x = -offset.x
	end

	return Vector3.New(pos.x + offset.x, pos.y + offset.y, pos.z + offset.z)
end

function SkillAnimationMotion:_isTargetsEmpty()
	return not self._action.targets or self._action.targets.Length == 0 or string.nilorempty(self._action.targets[1]) and string.nilorempty(self._action.targets[2])
end

function SkillAnimationMotion._easeLinear(start, dest, value)
	return start + (dest - start) * value
end

function SkillAnimationMotion._easeInQuad(start, dest, value)
	dest = dest - start

	return dest * value * value + start
end

function SkillAnimationMotion._easeOutQuad(start, dest, value)
	dest = dest - start

	return -dest * value * (value - 2) + start
end

function SkillAnimationMotion._easeInOutQuad(start, dest, value)
	value = value / 0.5
	dest = dest - start

	if value < 1 then
		return dest / 2 * value * value + start
	end

	value = value - 1

	return -dest / 2 * (value * (value - 2) - 1) + start
end

function SkillAnimationMotion._easeInCubic(start, dest, value)
	dest = dest - start

	return dest * value * value * value + start
end

function SkillAnimationMotion._easeOutCubic(start, dest, value)
	value = value - 1
	dest = dest - start

	return dest * (value * value * value + 1) + start
end

function SkillAnimationMotion._easeInOutCubic(start, dest, value)
	value = value / 0.5
	dest = dest - start

	if value < 1 then
		return dest / 2 * value * value * value + start
	end

	value = value - 1

	return dest / 2 * (value * value * value + 2) + start
end

easeFuncsDict.easeInQuad = SkillAnimationMotion._easeInQuad
easeFuncsDict.easeOutQuad = SkillAnimationMotion._easeOutQuad
easeFuncsDict.easeInOutQuad = SkillAnimationMotion._easeInOutQuad
easeFuncsDict.easeInCubic = SkillAnimationMotion._easeInCubic
easeFuncsDict.easeOutCubic = SkillAnimationMotion._easeOutCubic
easeFuncsDict.easeInOutCubic = SkillAnimationMotion._easeInOutCubic
easeFuncsDict.linear = SkillAnimationMotion._easeLinear

return SkillAnimationMotion
