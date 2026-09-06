-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/GryoImageComponent.lua

module("logiccommon.common.components.GryoImageComponent", package.seeall)

local GryoImageComponent = class("GryoImageComponent")

GryoImageComponent.PROGRESS_TYPE_X = 1
GryoImageComponent.PROGRESS_TYPE_Y = 2
GryoImageComponent.PROGRESS_TYPE_DIR = 3

function GryoImageComponent:ctor(go)
	self._imgGo = go
	self._blendChange = ImageTexBlendChangeComponent.New(self._imgGo)

	self._blendChange:setBlendFactor(0)
end

function GryoImageComponent:setEffectByRaceIds(raceId1, raceId2)
	self._blendChange:setRenderTextureWithRaceId(raceId1, raceId2)
end

function GryoImageComponent:setEffectTex(tex1, tex2)
	self._blendChange:setTexture(tex1, tex2)
end

function GryoImageComponent:setProgressType(type)
	self._progressType = type
end

function GryoImageComponent:startEffect()
	GyroUtil.enableGyroscope()

	local pos = GyroUtil.getTiltOffsetFromGroundUp()

	self._posLerpNum = Mathf.Sqrt(pos.x * pos.x + pos.y * pos.y)

	settimer(0.02, self._updateBlend, self, true)
end

function GryoImageComponent:_updateBlend()
	local start = 0.2
	local ranage = 0.2
	local pos = GyroUtil.getTiltOffsetFromGroundUp()
	local targetPos = 0

	if self._progressType then
		if self._progressType == GryoImageComponent.PROGRESS_TYPE_X then
			targetPos = pos.x
		elseif self._progressType == GryoImageComponent.PROGRESS_TYPE_Y then
			targetPos = pos.y
		elseif self._progressType == GryoImageComponent.PROGRESS_TYPE_DIR then
			targetPos = Mathf.Sqrt(pos.x * pos.x + pos.y * pos.y)
		end
	else
		targetPos = Mathf.Sqrt(pos.x * pos.x + pos.y * pos.y)
	end

	local change = math.abs(self._posLerpNum - pos.x)
	local changeRate = 0.02 / change

	if changeRate > 1 then
		changeRate = 1
	end

	changeRate = changeRate * 0.02
	self._posLerpNum = self:_lerp(self._posLerpNum, targetPos, changeRate)

	local angle = Mathf.Atan2(pos.y, pos.x)
	local roate = 180 * angle / Mathf.PI

	roate = roate % 360

	self._blendChange:setBlendRotate(roate)

	if start > math.abs(self._posLerpNum) then
		self._blendChange:setBlendFactor(0)
	elseif math.abs(self._posLerpNum) > start + ranage then
		self._blendChange:setBlendFactor(1)
	else
		local rate = (math.abs(self._posLerpNum) - start) / ranage

		self._blendChange:setBlendFactor(rate)
	end
end

function GryoImageComponent:_lerp(a, b, t)
	return a + (b - a) * t
end

function GryoImageComponent:dispose()
	self._blendChange:dispose()
	removetimer(self._updateBlend, self)
end

return GryoImageComponent
