-- chunkname: @modules/logic/fight/entity/pool/FightEffectWrap.lua

module("modules.logic.fight.entity.pool.FightEffectWrap", package.seeall)

local FightEffectWrap = class("FightEffectWrap", LuaCompBase)

function FightEffectWrap:ctor()
	self.uniqueId = nil
	self.path = nil
	self.abPath = nil
	self.side = nil
	self.containerGO = nil
	self.containerTr = nil
	self.effectGO = nil
	self.hangPointGO = nil
	self._canDestroy = false
	self._layer = nil
	self._renderOrder = nil
	self._nonActiveKeyList = {}
	self._nonPosActiveKeyList = {}
	self.callback = nil
	self.callbackObj = nil
	self.dontPlay = nil
	self.cus_localPosX = nil
	self.cus_localPosY = nil
	self.cus_localPosZ = nil
end

function FightEffectWrap:init(go)
	self.containerGO = go
	self.containerTr = go.transform
end

function FightEffectWrap:play()
	if self.effectGO and not self.dontPlay then
		self:setActive(true)

		local effectShakeComp = self.effectGO:GetComponent(typeof(ZProj.EffectShakeComponent))

		if effectShakeComp then
			local speed = FightModel.instance:getSpeed()

			effectShakeComp:Play(CameraMgr.instance:getCameraShake(), speed, (speed > 1.4 or nil) and 1 - 0.3 * (speed - 1.4) / 1.4)
		end
	end
end

function FightEffectWrap:setUniqueId(uniqueId)
	self.uniqueId = uniqueId
end

function FightEffectWrap:setPath(path)
	self.path = path
	self.abPath = FightHelper.getEffectAbPath(path)
end

function FightEffectWrap:setEffectGO(effectGO)
	self.effectGO = effectGO

	if self._effectScale then
		transformhelper.setLocalScale(self.effectGO.transform, self._effectScale, self._effectScale, self._effectScale)
	end

	if self._renderOrder then
		self:setRenderOrder(self._renderOrder, true)
	end

	self.cus_localPosX, self.cus_localPosY, self.cus_localPosZ = transformhelper.getLocalPos(self.effectGO.transform)

	if self._nonPosActiveKeyList and #self._nonPosActiveKeyList > 0 then
		self:playActiveByPos(false)
	end
end

function FightEffectWrap:setLayer(layer)
	self._layer = layer

	gohelper.setLayer(self.effectGO, self._layer, true)
end

function FightEffectWrap:setHangPointGO(hangPointGO)
	if not gohelper.isNil(hangPointGO) and not gohelper.isNil(self.containerGO) and self.hangPointGO ~= hangPointGO then
		self.hangPointGO = hangPointGO

		self.containerGO.transform:SetParent(self.hangPointGO.transform, true)
		transformhelper.setLocalRotation(self.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(self.containerGO.transform, 1, 1, 1)
	end
end

function FightEffectWrap:setLocalPos(x, y, z)
	if self.containerTr then
		transformhelper.setLocalPos(self.containerTr, x, y, z)
		self:clearTrail()
	end
end

function FightEffectWrap:setWorldPos(x, y, z)
	if self.containerTr then
		transformhelper.setPos(self.containerTr, x, y, z)
		self:clearTrail()
	end
end

function FightEffectWrap:setCallback(callback, callbackObj)
	self.callback = callback
	self.callbackObj = callbackObj
end

function FightEffectWrap:setActive(isActive, nonActiveKey)
	nonActiveKey = nonActiveKey or "default"

	if self.containerGO then
		if isActive then
			tabletool.removeValue(self._nonActiveKeyList, nonActiveKey)
			gohelper.setActive(self.containerGO, #self._nonActiveKeyList == 0)
		else
			if not tabletool.indexOf(self._nonActiveKeyList, nonActiveKey) then
				table.insert(self._nonActiveKeyList, nonActiveKey)
			end

			gohelper.setActive(self.containerGO, false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. self.path)
	end
end

function FightEffectWrap:setActiveByPos(isActive, nonActiveKey)
	nonActiveKey = nonActiveKey or "default"

	if self.containerGO then
		if isActive then
			tabletool.removeValue(self._nonPosActiveKeyList, nonActiveKey)
			self:playActiveByPos(#self._nonPosActiveKeyList == 0)
		else
			if not tabletool.indexOf(self._nonPosActiveKeyList, nonActiveKey) then
				table.insert(self._nonPosActiveKeyList, nonActiveKey)
			end

			self:playActiveByPos(false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. self.path)
	end
end

function FightEffectWrap:playActiveByPos(state)
	if self.effectGO and self.cus_localPosX then
		if state then
			transformhelper.setLocalPos(self.effectGO.transform, self.cus_localPosX, self.cus_localPosY, self.cus_localPosZ)
		else
			transformhelper.setLocalPos(self.effectGO.transform, self.cus_localPosX + 20000, self.cus_localPosY + 20000, self.cus_localPosZ + 20000)
		end
	end
end

function FightEffectWrap:onReturnPool()
	self._nonActiveKeyList = {}
	self._nonPosActiveKeyList = {}

	self:playActiveByPos(true)
end

function FightEffectWrap:setRenderOrder(order, force)
	if not order then
		return
	end

	local oldOrder = self._renderOrder

	self._renderOrder = order

	if not force and order == oldOrder then
		return
	end

	if not gohelper.isNil(self.effectGO) then
		local effectOrderContainer = self.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer))

		if effectOrderContainer then
			effectOrderContainer:SetBaseOrder(order)
		end
	end
end

function FightEffectWrap:setTimeScale(timeScale)
	if self.effectGO then
		local effectTimeScale = gohelper.onceAddComponent(self.effectGO, typeof(ZProj.EffectTimeScale))

		effectTimeScale:SetTimeScale(timeScale)
	end
end

function FightEffectWrap:clearTrail()
	if self.effectGO then
		local effectTimeScale = gohelper.onceAddComponent(self.effectGO, typeof(ZProj.EffectTimeScale))

		effectTimeScale:ClearTrail()
	end
end

function FightEffectWrap:doCallback(success)
	if self.callback then
		if self.callbackObj then
			self.callback(self.callbackObj, self, success)
		else
			self:callback(success)
		end

		self.callback = nil
		self.callbackObj = nil
	end
end

function FightEffectWrap:setEffectScale(scale)
	self._effectScale = scale

	if self.effectGO then
		transformhelper.setLocalScale(self.effectGO.transform, self._effectScale, self._effectScale, self._effectScale)
	end
end

function FightEffectWrap:markCanDestroy()
	self._canDestroy = true
end

function FightEffectWrap:onDestroy()
	if not self._canDestroy then
		logError("Effect destroy unexpected: " .. self.path)
	end

	self.containerGO = nil
	self.effectGO = nil
	self.hangPointGO = nil
	self.callback = nil
	self.callbackObj = nil
end

return FightEffectWrap
