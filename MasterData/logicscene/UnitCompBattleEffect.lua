-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompBattleEffect.lua

module("logicscene.scene.unit.component.battle.UnitCompBattleEffect", package.seeall)

local UnitCompBattleEffect = class("UnitCompBattleEffect", UnitComponentBase)
local battleEffectOrderCtrl

function UnitCompBattleEffect:ctor(unit)
	UnitCompBattleEffect.super.ctor(self, unit)

	battleEffectOrderCtrl = battleEffectOrderCtrl or BattleEffectOrderCtrl
end

function UnitCompBattleEffect:playEffect(effectCo, finishHandler, loadedHandler, handlerTarget)
	if effectCo then
		if not effectCo.posX or not effectCo.posY or not effectCo.posZ then
			local posX, posY, posZ = self:getEffectPos(effectCo)

			effectCo.posX = posX
			effectCo.posY = posY
			effectCo.posZ = posZ
		end

		local effectIns = GameEffectManager.instance:playEffect(effectCo.path, effectCo.loop, effectCo.duration, effectCo.posX, effectCo.posY, effectCo.posZ, function(tgt, eff)
			eff.effectCo = effectCo

			if finishHandler then
				finishHandler(handlerTarget, eff)
			end
		end, function(tgt, eff)
			eff.effectCo = effectCo

			tgt:_onEffectLoaded(eff)

			if loadedHandler then
				loadedHandler(handlerTarget, eff)
			end
		end, self)

		effectIns.effectCo = effectCo

		return effectIns
	end
end

function UnitCompBattleEffect:stopEffect(handler)
	GameEffectManager.instance:stopEffect(handler)
end

function UnitCompBattleEffect:_onEffectLoaded(eff)
	self:updateEffectPosition(eff.effectCo, eff)
end

function UnitCompBattleEffect:updateEffectPosition(effectCo, eff)
	self:updateEffectLayer(eff.effGo, effectCo)

	if effectCo.follow == 1 then
		local mountPoint = self._unit:getHangPoint(effectCo.hagPoint)

		goutil.addChildToParent(eff.effGo, mountPoint)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalRotation(eff.effGo.transform, effectCo.rx or 0, effectCo.ry or 0, effectCo.rz or 0)
	else
		local posX, posY, posZ = self:getEffectPos(effectCo)

		Framework.TransformUtil.SetPos(eff.effGo.transform, posX, posY, posZ)

		if effectCo.rx and effectCo.ry and effectCo.rz then
			Framework.TransformUtil.SetLocalRotation(eff.effGo.transform, effectCo.rx or 0, effectCo.ry or 0, effectCo.rz or 0)
		end
	end

	self:updateEffectOrder(eff)
	self:updateRotation(eff, effectCo)
end

function UnitCompBattleEffect:updateRotation(eff, effectCo)
	if not effectCo.donotRotate then
		if effectCo.flipWithRotate then
			self:updateEffectRotateWithFlipX(eff.effGo, effectCo.isHit)
		else
			self:updateEffectScaleWithFlipX(eff.effGo, effectCo.isHit)
		end
	else
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalRotation(eff.effGo.transform, 0, 0, 0)
	end
end

function UnitCompBattleEffect:getEffectPos(effectCo)
	if effectCo.posX or effectCo.posY or effectCo.posZ then
		return effectCo.posX, effectCo.posY, effectCo.posZ
	end

	if effectCo.hagPoint then
		local mountPoint = self._unit:getHangPoint(effectCo.hagPoint)

		if not goutil.isNil(mountPoint) then
			local posX, posY, posZ = Framework.TransformUtil.GetPos(mountPoint.transform, nil, nil, nil)

			return posX, posY, posZ
		end
	end

	return 0, 0, 0
end

function UnitCompBattleEffect:updateEffectScaleWithFlipX(go, isHit)
	if goutil.isNil(go) then
		return
	end

	local spineDir = self._unit.spine:getDirection()
	local isDefault = spineDir == UnitSpineDir.Right
	local sx, sy, sz = Framework.TransformUtil.GetLocalScale(go.transform, nil, nil, nil)

	if isDefault then
		if isHit then
			if sx > 0 then
				sx = -sx
			end
		elseif sx < 0 then
			sx = -sx
		end
	elseif isHit then
		if sx < 0 then
			sx = -sx
		end
	elseif sx > 0 then
		sx = -sx
	end

	Framework.TransformUtil.SetLocalScale(go.transform, sx, sy, sz)
end

function UnitCompBattleEffect:updateEffectRotateWithFlipX(go, isHit)
	if goutil.isNil(go) then
		return
	end

	local spineDir = self._unit.spine:getDirection()
	local isDefault = spineDir == UnitSpineDir.Right
	local rx, ry, rz = Framework.TransformUtil.GetLocalRotation(go.transform, nil, nil, nil)

	ry = isDefault and (isHit and 180 or 0) or isHit and 0 or 180

	Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalRotation(go.transform, rx, ry, rz)
end

function UnitCompBattleEffect:updateEffectLayer(effGo, effectCo)
	if goutil.isNil(effGo) then
		return
	end

	if effectCo and effectCo.layer then
		if effGo.layer ~= effectCo.layer then
			Framework.GameObjectUtil.SetLayerRecursively(effGo, effectCo.layer)
		end
	elseif effGo and not goutil.isNil(self._unit.go) and effGo.layer ~= self._unit.go.layer and (effectCo and effectCo.isHit or effGo.layer ~= SceneLayer.SkillEffects_Value and effGo.layer ~= SceneLayer.SkillEffects_II_Value) then
		Framework.GameObjectUtil.SetLayerRecursively(effGo, self._unit.go.layer)
	end
end

function UnitCompBattleEffect:updateEffectOrder(eff)
	if eff and eff.effGo and self._unit.posRow ~= -1 then
		if not eff.effectCo.isGroundEff then
			local order = self._unit:getSortingOrder()

			if order then
				eff:setSortingOrderGreatZero(order + (eff.effectCo.showOrder or 0) * 100)
			end
		else
			eff:setSortingOrder(-1)
		end
	end
end

return UnitCompBattleEffect
