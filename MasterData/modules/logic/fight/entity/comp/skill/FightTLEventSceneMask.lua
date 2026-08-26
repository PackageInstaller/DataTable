-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSceneMask.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMask", package.seeall)

local FightTLEventSceneMask = class("FightTLEventSceneMask", FightTimelineTrackItem)

function FightTLEventSceneMask:onTrackStart(fightStepData, duration, paramsArr)
	local effectPath = ResUrl.getEffect(paramsArr[1])

	self._colorStr = paramsArr[2]

	local fadeTimeStr = paramsArr[3]

	if not string.nilorempty(fadeTimeStr) then
		local fadeTimes = string.split(fadeTimeStr, "#")

		if fadeTimes and #fadeTimes > 0 then
			self._fadeInTime = tonumber(fadeTimes[1]) or 0.15
			self._fadeOutTime = fadeTimes[2] and tonumber(fadeTimes[2]) or self._fadeInTime
		end
	end

	self._color = GameUtil.parseColor(self._colorStr)

	if self._fadeInTime and self._fadeInTime > 0 then
		self._fadeInId = ZProj.TweenHelper.DOTweenFloat(0, self._color.a, self._fadeInTime, self._tweenFrameCb, nil, self)
		self._color = Color.New(self._color.r, self._color.g, self._color.b, 0)
	end

	if self._fadeOutTime and self._fadeOutTime > 0 then
		TaskDispatcher.runDelay(self._fadeOut, self, duration - self._fadeOutTime)
	end

	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local sceneMaskGO = gohelper.findChild(mainCameraGO, "scenemask")

	self._effectWrap = FightEffectPool.getEffect(effectPath, FightEnum.EntitySide.BothSide, self._onEffectLoaded, self, sceneMaskGO)

	self._effectWrap:setLayer(UnityLayer.Unit)
end

function FightTLEventSceneMask:onTrackEnd()
	self:_clear()
end

function FightTLEventSceneMask:_fadeOut()
	if self._fadeInId then
		ZProj.TweenHelper.KillById(self._fadeInId)
	end

	self._fadeOutId = ZProj.TweenHelper.DOTweenFloat(self._color.a, 0, self._fadeOutTime, self._tweenFrameCb, nil, self)
end

function FightTLEventSceneMask:_tweenFrameCb(alpha)
	self._color.a = alpha

	self:_setMaskColor()
end

function FightTLEventSceneMask:onDestructor()
	self:_clear()
end

function FightTLEventSceneMask:_onEffectLoaded(effectWrap, success)
	if not success then
		return
	end

	local meshRenderer = effectWrap.effectGO:GetComponent("MeshRenderer")

	if meshRenderer then
		self._material = meshRenderer.material

		if self._material:HasProperty(MaterialUtil._MaskColorId) then
			self:_setMaskColor()
		end
	end
end

function FightTLEventSceneMask:_setMaskColor()
	if self._material then
		self._material:SetColor(MaterialUtil._MaskColorId, self._color)
	end
end

function FightTLEventSceneMask:_clear()
	TaskDispatcher.cancelTask(self._fadeOut, self)

	if self._fadeInId then
		ZProj.TweenHelper.KillById(self._fadeInId)

		self._fadeInId = nil
	end

	if self._fadeOutId then
		ZProj.TweenHelper.KillById(self._fadeOutId)

		self._fadeOutId = nil
	end

	if self._effectWrap then
		FightEffectPool.returnEffect(self._effectWrap)

		self._effectWrap = nil
	end

	self._material = nil
end

return FightTLEventSceneMask
