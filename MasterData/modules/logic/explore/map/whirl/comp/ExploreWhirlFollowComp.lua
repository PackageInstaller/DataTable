-- chunkname: @modules/logic/explore/map/whirl/comp/ExploreWhirlFollowComp.lua

module("modules.logic.explore.map.whirl.comp.ExploreWhirlFollowComp", package.seeall)

local ExploreWhirlFollowComp = class("ExploreWhirlFollowComp", LuaCompBase)
local Dir = {
	Down = -1,
	Up = 1
}

function ExploreWhirlFollowComp:ctor(whirl)
	self._whirl = whirl
	self._isPause = false
end

function ExploreWhirlFollowComp:setup(go)
	self._go = go
	self._trans = go.transform
	self._minHeight = 0.6
	self._maxHeight = 0.8
	self._radius = 0.4
	self._upDownSpeed = 0.003
	self._moveSpeed = 0.05
	self._rotateSpeed = 1
	self._nowHeight = 0.7
	self._nowDir = Dir.Up
end

function ExploreWhirlFollowComp:start()
	self._isPause = false

	self:onUpdatePos()
end

function ExploreWhirlFollowComp:pause()
	self._isPause = true
end

function ExploreWhirlFollowComp:onUpdate()
	if not self._go or self._isPause then
		return
	end

	self:onUpdatePos()
end

function ExploreWhirlFollowComp:_getHero()
	return ExploreController.instance:getMap():getHero()
end

function ExploreWhirlFollowComp:onUpdatePos()
	local heroTrans = self:_getHero()._displayTr
	local heroPos = heroTrans.position
	local finalPos = -heroTrans.forward:Mul(self._radius) + heroPos

	if self._nowDir == Dir.Up then
		self._nowHeight = self._nowHeight + self._upDownSpeed

		if self._nowHeight >= self._maxHeight then
			self._nowDir = Dir.Down
		end
	else
		self._nowHeight = self._nowHeight - self._upDownSpeed

		if self._nowHeight <= self._minHeight then
			self._nowDir = Dir.Up
		end
	end

	finalPos.y = self._nowHeight

	self._trans:Rotate(0, self._rotateSpeed, 0)

	local nowPos = self._trans.position
	local dis = nowPos:Sub(finalPos):SqrMagnitude()

	if dis > self._moveSpeed * self._moveSpeed then
		finalPos = Vector3.Lerp(self._trans.position, finalPos, self._moveSpeed / math.sqrt(dis))

		local xzOffset = finalPos - heroPos

		xzOffset.y = 0

		local heroDis = xzOffset:SqrMagnitude()

		if heroDis > 1 then
			local pos = xzOffset:SetNormalize():Add(heroPos)

			pos.y = finalPos.y
			finalPos = pos
		end

		self._trans.position = finalPos
	else
		self._trans.position = finalPos
	end
end

function ExploreWhirlFollowComp:onDestroy()
	self._go = nil
	self._trans = nil
	self._whirl = nil
	self._isPause = false
end

return ExploreWhirlFollowComp
