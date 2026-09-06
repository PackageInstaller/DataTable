-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/GameEffect.lua

module("logiccommon.common.effect.GameEffect", package.seeall)

local GameEffect = class("GameEffect")

function GameEffect:ctor()
	self.specifyTime = nil
	self.handleId = self
	self.effPath = nil
	self.time = nil
	self.effGo = nil
	self.posX = nil
	self.posY = nil
	self.posZ = nil
	self.localPosX = nil
	self.localPosY = nil
	self.localPosZ = nil
	self.scale = nil
	self.sortingOrder = nil
	self.sortingOrderGreatZero = nil
	self.finishHandler = nil
	self.loadedHandler = nil
	self.finishHandlerTarget = nil
	self.loop = nil
	self.autoDestroy = true
	self._visible = true
	self.active = true
	self.isPause = nil
	self._scaleX = nil
	self._scaleY = nil
	self._scaleZ = nil
	self._localEulerX = nil
	self._localEulerY = nil
	self._localEulerZ = nil
end

function GameEffect:setEffectGo(go)
	self.effGo = go
end

function GameEffect:setParent(parent)
	self.parent = parent

	if not goutil.isNil(self.effGo) and self.effGo.transform.parent ~= parent then
		self.effGo.transform:SetParent(parent)
	end
end

function GameEffect:setLocalPos(lx, ly, lz)
	self.localPosX = lx or 0
	self.localPosY = ly or 0
	self.localPosZ = lz or 0

	if not goutil.isNil(self.effGo) then
		Framework.TransformUtil.SetLocalPos(self.effGo.transform, self.localPosX, self.localPosY, self.localPosZ)
	end
end

function GameEffect:setPos(x, y, z)
	self.posX = x or 0
	self.posY = y or 0
	self.posZ = z or 0

	if not goutil.isNil(self.effGo) then
		Framework.TransformUtil.SetPos(self.effGo.transform, self.posX, self.posY, self.posZ)
	end
end

function GameEffect:setLocalEulerAngle(eulerX, eulerY, eulerZ)
	self._localEulerX = eulerX or 0
	self._localEulerY = eulerY or 0
	self._localEulerZ = eulerZ or 0

	if not goutil.isNil(self.effGo) then
		Framework.TransformUtil.SetLocalRotation(self.effGo.transform, self._localEulerX, self._localEulerY, self._localEulerZ)
	end
end

function GameEffect:setEffTime(time)
	self.specifyTime = time

	if not goutil.isNil(self.effGo) then
		self:_calcualteEffTime()
	end
end

function GameEffect:setSortingOrder(sortingLayer)
	if sortingLayer ~= self.sortingOrder then
		self.sortingOrder = sortingLayer

		if not goutil.isNil(self.effGo) then
			GoUtil.SetSortingOrder(self.effGo, self.sortingOrder)
		end
	end
end

function GameEffect:setSortingOrderGreatZero(sortingLayer)
	if sortingLayer ~= self.sortingOrderGreatZero then
		self.sortingOrderGreatZero = sortingLayer

		if not goutil.isNil(self.effGo) then
			GoUtil.SetSortingOrderGreatZero(self.effGo, self.sortingOrderGreatZero)
		end
	end
end

function GameEffect:setVisible(visible, force)
	if self._visible == visible and not force then
		return
	end

	self._visible = visible

	if not goutil.isNil(self.effGo) then
		GoUtil.SetVisible(self.effGo, visible)
	end
end

function GameEffect:setActive(active)
	self.active = active

	if not goutil.isNil(self.effGo) and self.effGo.activeSelf ~= active then
		self.effGo:SetActive(active)
	end
end

function GameEffect:pause()
	if self.isPause then
		return
	end

	self.isPause = true

	if not goutil.isNil(self.effGo) then
		GoUtil.PauseObject(self.effGo)
	end
end

function GameEffect:resume()
	if not self.isPause then
		return
	end

	self.isPause = nil

	if not goutil.isNil(self.effGo) then
		GoUtil.ResumeObject(self.effGo)
	end
end

function GameEffect:setScale(scale)
	self.scale = scale

	if not goutil.isNil(self.effGo) then
		Framework.TransformUtil.SetLocalScale(self.effGo.transform, self.scale, self.scale, self.scale)
	end
end

function GameEffect:setScaleXYZ(scaleX, scaleY, scaleZ)
	self._scaleX = scaleX or 1
	self._scaleY = scaleY or 1
	self._scaleZ = scaleZ or 1

	if not goutil.isNil(self.effGo) then
		Framework.TransformUtil.SetLocalScale(self.effGo.transform, self._scaleX, self._scaleY, self._scaleZ)
	end
end

function GameEffect:setLayer(layer)
	self.layer = layer

	if self.layer and not goutil.isNil(self.effGo) then
		Framework.GameObjectUtil.SetLayerRecursively(self.effGo, self.layer)
	end
end

function GameEffect:onEffectStart()
	self:_calcualteEffTime()
	self:setVisible(self._visible, true)

	if self.layer then
		Framework.GameObjectUtil.SetLayerRecursively(self.effGo, self.layer)
	end

	if self.isPause then
		GoUtil.PauseObject(self.effGo)
	end

	if self.parent and self.parent ~= self.effGo.transform.parent then
		self.effGo.transform:SetParent(self.parent)
	end

	if self.scale then
		self:setScale(self.scale)
	end

	if not self.localPosX and not self.localPosY then
		if self.localPosZ then
			Framework.TransformUtil.SetLocalPos(self.effGo.transform, self.localPosX or 0, self.localPosY or 0, self.localPosZ or 0)
		end

		if not self._scaleX and not self._scaleY then
			if self._scaleZ then
				Framework.TransformUtil.SetLocalScale(self.effGo.transform, self._scaleX or 1, self._scaleY or 1, self._scaleZ or 1)
			end

			if not self._localEulerX and not self._localEulerY then
				if self._localEulerZ then
					Framework.TransformUtil.SetLocalRotation(self.effGo.transform, self._localEulerX or 0, self._localEulerY or 0, self._localEulerZ or 0)
				end
			end
		end
	end
end

function GameEffect:_calcualteEffTime()
	if not self.loop then
		self.time = self:getEffectTime() or GoUtil.ComputeEffectLifeTime(self.effGo)

		if not self.time or self.time <= 0 then
			self.time = 3
		end
	else
		self.time = -1
	end

	self._timeCount = self.time > 0 and 0 or nil
end

function GameEffect:update(deltaTime)
	if not self.isPause and self._timeCount and self._timeCount < self.time then
		self._timeCount = self._timeCount + deltaTime

		if self._timeCount >= self.time then
			self._timeCount = nil

			self:_onEffectPlayFinish()
		end
	end
end

function GameEffect:onEffectDestroy()
	self:setScale(1)

	self.sortingOrder = nil
	self.sortingOrderGreatZero = nil

	if self.isPause and not goutil.isNil(self.effGo) then
		GoUtil.ResumeObject(self.effGo)
	end

	self.layer = nil
	self.isPause = nil
	self.loadedHandler = nil
end

function GameEffect:getEffectTime()
	if self.specifyTime and self.specifyTime > 0 then
		return self.specifyTime
	end
end

function GameEffect:_onEffectPlayFinish()
	if self.finishHandler then
		self.finishHandler(self.finishHandlerTarget, self)
	end

	if self.autoDestroy then
		GameEffectManager.instance:stopEffect(self)
	end
end

return GameEffect
