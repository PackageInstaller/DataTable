-- chunkname: @modules/logic/fight/system/work/FightWorkChangeEntitySpine.lua

module("modules.logic.fight.system.work.FightWorkChangeEntitySpine", package.seeall)

local FightWorkChangeEntitySpine = class("FightWorkChangeEntitySpine", BaseWork)

function FightWorkChangeEntitySpine:ctor(entity, url)
	self._entity = entity
	self._url = url
end

function FightWorkChangeEntitySpine:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 10)

	if not self._entity.spine then
		self:onDone(true)

		return
	end

	self._lastSpineObj = self._entity.spine:getSpineGO()

	local work = self._entity:registLoadSpineWork(self._url)

	work:registFinishCallback(self._onLoaded, self)
	work:start()
end

function FightWorkChangeEntitySpine:_onLoaded()
	if self._entity then
		self._entity:initHangPointDict()

		if self._entity.spineRenderer then
			self._entity.spineRenderer:setSpine(self._entity.spine)
		end

		FightRenderOrderMgr.instance:_resetRenderOrder(self._entity.id)

		local effects = self._entity.effect:getHangEffect()

		if effects then
			for k, v in pairs(effects) do
				local effectWrap = v.effectWrap
				local hangPoint = v.hangPoint
				local x, y, z = transformhelper.getLocalPos(effectWrap.containerTr)
				local hangObj = self._entity:getHangPoint(hangPoint)

				gohelper.addChild(hangObj, effectWrap.containerGO)
				transformhelper.setLocalPos(effectWrap.containerTr, x, y, z)
			end
		end

		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, self._entity.spine)
	end

	gohelper.destroy(self._lastSpineObj)
	self:onDone(true)
end

function FightWorkChangeEntitySpine:_delayDone()
	self:onDone(true)
end

function FightWorkChangeEntitySpine:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkChangeEntitySpine
