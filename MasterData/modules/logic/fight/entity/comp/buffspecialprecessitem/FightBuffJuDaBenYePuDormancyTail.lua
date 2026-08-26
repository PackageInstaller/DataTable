-- chunkname: @modules/logic/fight/entity/comp/buffspecialprecessitem/FightBuffJuDaBenYePuDormancyTail.lua

module("modules.logic.fight.entity.comp.buffspecialprecessitem.FightBuffJuDaBenYePuDormancyTail", package.seeall)

local FightBuffJuDaBenYePuDormancyTail = class("FightBuffJuDaBenYePuDormancyTail", FightBaseClass)

function FightBuffJuDaBenYePuDormancyTail:onLogicEnter(entity, buffId, buffUid)
	self._entity = entity
	self._buffUid = buffUid
	self._entityMat = self._entity.spineRenderer:getCloneOriginMat() or self._entity.spineRenderer:getSpineRenderMat()

	if not self._entityMat then
		return
	end

	self._entityMat:EnableKeyword("_STONE_ON")

	self._path = ResUrl.getRoleSpineMatTex("textures/stone_manual")

	self:com_loadAsset(self._path, self._onLoaded)
	self:com_registFightEvent(FightEvent.RemoveEntityBuff, self._onRemoveEntityBuff)
end

function FightBuffJuDaBenYePuDormancyTail:_onRemoveEntityBuff(entityId, buffMO)
	if entityId ~= self._entity.id then
		return
	end

	if buffMO.uid ~= self._buffUid then
		return
	end

	self:onBuffEnd()
end

function FightBuffJuDaBenYePuDormancyTail:_onLoaded(success, loader)
	if not success then
		return
	end

	local texture = loader:GetResource(self._path)

	self._entityMat:SetTexture("_NoiseMap4", texture)
	self:_playOpenTween()
end

function FightBuffJuDaBenYePuDormancyTail:_playOpenTween()
	self:_releaseTween()

	local frameValue
	local propertyId = UnityEngine.Shader.PropertyToID("_TempOffset3")

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, function(value)
		local startValue, endValue = self:getPlayValue()

		frameValue = MaterialUtil.getLerpValue("Vector4", startValue, endValue, value, frameValue)

		MaterialUtil.setPropValue(self._entityMat, propertyId, "Vector4", frameValue)
	end)
end

function FightBuffJuDaBenYePuDormancyTail:_playCloseTween()
	self:_releaseTween()

	local frameValue
	local propertyId = UnityEngine.Shader.PropertyToID("_TempOffset3")

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, function(value)
		local startValue, endValue = self:getCloseValue()

		frameValue = MaterialUtil.getLerpValue("Vector4", startValue, endValue, value, frameValue)

		MaterialUtil.setPropValue(self._entityMat, propertyId, "Vector4", frameValue)
	end)
end

function FightBuffJuDaBenYePuDormancyTail:getPlayValue()
	local oldValue = MaterialUtil.getPropValueFromMat(self._entityMat, "_TempOffset3", "Vector4")
	local startValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,0,0", oldValue.y))
	local endValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,1,0", oldValue.y))

	return startValue, endValue
end

function FightBuffJuDaBenYePuDormancyTail:getCloseValue()
	local oldValue = MaterialUtil.getPropValueFromMat(self._entityMat, "_TempOffset3", "Vector4")
	local startValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,1,0", oldValue.y))
	local endValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,0,0", oldValue.y))

	return startValue, endValue
end

function FightBuffJuDaBenYePuDormancyTail:onBuffEnd()
	if not self._entityMat then
		return
	end

	self:_playCloseTween()
	TaskDispatcher.runDelay(self._delayDone, self, 0.6)
end

function FightBuffJuDaBenYePuDormancyTail:_delayDone()
	local entityMO = self._entity:getMO()

	if entityMO and self._entity.spineRenderer then
		local buffDic = entityMO:getBuffDic()
		local dormancy = false

		for i, v in pairs(buffDic) do
			if v.buffId == 4150022 or v.buffId == 4150023 then
				dormancy = true
			end
		end

		if not dormancy and self._entityMat then
			self._entityMat:DisableKeyword("_STONE_ON")
		end
	end

	self:disposeSelf()
end

function FightBuffJuDaBenYePuDormancyTail:onLogicExit()
	self:_releaseTween()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightBuffJuDaBenYePuDormancyTail:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return FightBuffJuDaBenYePuDormancyTail
