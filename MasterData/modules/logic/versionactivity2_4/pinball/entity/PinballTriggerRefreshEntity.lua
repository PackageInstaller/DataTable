-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballTriggerRefreshEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerRefreshEntity", package.seeall)

local PinballTriggerRefreshEntity = class("PinballTriggerRefreshEntity", PinballTriggerEntity)

function PinballTriggerRefreshEntity:onInit()
	PinballTriggerRefreshEntity.super.onInit(self)

	self.curHitCount = 0
	self.totalRefresh = 0
end

function PinballTriggerRefreshEntity:init(go)
	PinballTriggerRefreshEntity.super.init(self, go)

	self._effectAnim = gohelper.findChildAnim(go, "vx_stonestatue")
end

function PinballTriggerRefreshEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity then
		return
	end

	if hitEntity:isMarblesType() then
		self:incHit()
	end
end

function PinballTriggerRefreshEntity:onCreateLinkEntity(linkEntity)
	linkEntity.curHitCount = self.curHitCount
	linkEntity.totalRefresh = self.totalRefresh

	linkEntity:playEffectAnim(true)
end

function PinballTriggerRefreshEntity:incHit()
	if self.isDead then
		return
	end

	self.curHitCount = self.curHitCount + 1

	if self.linkEntity then
		self.linkEntity.curHitCount = self.linkEntity.curHitCount + 1

		self.linkEntity:playEffectAnim()
	end

	self:playEffectAnim()

	if self.curHitCount >= self.hitCount then
		self.totalRefresh = self.totalRefresh + 1

		self:doRefresh()

		if self.totalRefresh >= self.limitNum then
			self._waitAnim = true

			TaskDispatcher.runDelay(self._delayDestory, self, 1.5)
			self:playAnim("disapper")
			self:markDead()
		end
	end
end

function PinballTriggerRefreshEntity:playEffectAnim(finish)
	if not self._effectAnim then
		return
	end

	if self.curHitCount == 0 then
		gohelper.setActive(self._effectAnim, false)
	else
		gohelper.setActive(self._effectAnim, true)
		self._effectAnim:Play(string.format("stonestatue_open_%02d", self.curHitCount), 0, finish and 1 or 0)
	end
end

function PinballTriggerRefreshEntity:doRefresh()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio19)
	PinballController.instance:dispatchEvent(PinballEvent.GameResRefresh)
end

function PinballTriggerRefreshEntity:onInitByCo()
	local arr = string.splitToNumber(self.spData, "#") or {}

	self.hitCount = arr[1] or 1
	self.limitNum = arr[2] or 1
end

function PinballTriggerRefreshEntity:_delayDestory()
	gohelper.destroy(self.go)
end

function PinballTriggerRefreshEntity:onDestroy()
	PinballTriggerRefreshEntity.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._delayDestory, self)
end

function PinballTriggerRefreshEntity:dispose()
	if not self._waitAnim then
		gohelper.destroy(self.go)
	end
end

return PinballTriggerRefreshEntity
