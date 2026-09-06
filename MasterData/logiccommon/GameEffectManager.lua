-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/GameEffectManager.lua

module("logiccommon.common.GameEffectManager", package.seeall)

local GameEffectManager = class("GameEffectManager", ResObjectCache)

function GameEffectManager:ctor()
	local effResObjectCache = UnityEngine.GameObject.New("GameEffResObjectCache")

	GameEffectManager.super.ctor(self, effResObjectCache)

	self._effCaches = nil
end

function GameEffectManager:newObject(resPath, loadedHandler, handlerTarget, resHandler)
	local unRet = true

	GameEffectManager.super.newObject(self, resPath, function(tgt, handerId, go)
		if not unRet then
			self:_onEffectResLoadedFinish(handerId, go)
		else
			self._loadedEffects = self._loadedEffects or {}
			self._loadedEffects[handerId] = go
		end
	end, self, resHandler)

	unRet = nil
end

function GameEffectManager:playEffect(path, loop, specifyTime, posX, posY, posZ, finishHandler, loadedHandler, handlerTarget)
	local eff = GameEffect.New()

	eff.effPath = path
	eff.finishHandler = finishHandler
	eff.finishHandlerTarget = handlerTarget
	eff.loop = loop
	eff.posX = posX
	eff.posY = posY
	eff.posZ = posZ
	eff.specifyTime = specifyTime
	eff.loadedHandler = loadedHandler
	self._effCaches = self._effCaches or {}
	self._effCaches[eff.handleId] = eff

	self.newObject(self, path, self._onEffectResLoadedFinish, self, eff)

	return eff
end

function GameEffectManager:stopEffect(handler)
	if self._effCaches then
		local eff = self._effCaches[handler.handleId]

		if eff then
			eff:onEffectDestroy()

			local effGo = eff.effGo

			if not effGo and self._loadedEffects then
				effGo = self._loadedEffects[handler.handleId]
			end

			if self._loadedEffects then
				self._loadedEffects[handler.handleId] = nil
			end

			self:recycleObject(eff.effPath, effGo, eff)

			self._effCaches[handler.handleId] = nil
		elseif self._loadedEffects then
			self._loadedEffects[handler.handleId] = nil
		end
	end
end

function GameEffectManager:clearAll()
	if self._effCaches then
		self._tempCaches = self._tempCaches or {}

		table.clear(self._tempCaches)
		table.merge(self._tempCaches, self._effCaches)

		for k, v in pairs(self._tempCaches) do
			self:stopEffect(k)
		end

		table.clear(self._tempCaches)
		table.clear(self._effCaches)
	end

	self._loadedEffects = nil
end

function GameEffectManager:_onEffectResLoadedFinish(handerId, go)
	local eff

	if self._effCaches then
		eff = self._effCaches[handerId]
	end

	if eff then
		eff.effGo = go

		go.transform:SetParent(self._objectParent.transform)

		if eff.posX and eff.posY and eff.posZ then
			Framework.TransformUtil.SetPos(go.transform, eff.posX, eff.posY, eff.posZ)
		end

		GoUtil.EnabledAMDelay(go)
		go:SetActive(eff.active)
		eff:onEffectStart()

		if eff.sortingOrder then
			GoUtil.SetSortingOrder(eff.effGo, eff.sortingOrder)
		end

		if eff.sortingOrderGreatZero then
			GoUtil.SetSortingOrderGreatZero(eff.effGo, eff.sortingOrderGreatZero)
		end

		if eff.loadedHandler then
			eff.loadedHandler(eff.finishHandlerTarget, eff)
		end
	elseif not goutil.isNil(go) then
		UnityEngine.GameObject.Destroy(go)
	end
end

function GameEffectManager:update(deltaTime)
	if self._effCaches then
		self._tempCaches = self._tempCaches or {}

		table.clear(self._tempCaches)
		table.merge(self._tempCaches, self._effCaches)

		for k, v in pairs(self._tempCaches) do
			v:update(deltaTime)
		end
	end
end

function GameEffectManager:lateUpdate()
	if self._loadedEffects then
		self._clearEffKeys = self._clearEffKeys or {}

		for k, v in pairs(self._loadedEffects) do
			self._clearEffKeys[k] = v
		end

		table.clear(self._loadedEffects)

		for k, v in pairs(self._clearEffKeys) do
			if k and v then
				self:_onEffectResLoadedFinish(k, v)
			end
		end

		table.clear(self._clearEffKeys)
	end
end

GameEffectManager.instance = GameEffectManager.New()

return GameEffectManager
