-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffPlayAnimation.lua

module("modules.logic.fight.entity.comp.buff.FightBuffPlayAnimation", package.seeall)

local FightBuffPlayAnimation = class("FightBuffPlayAnimation", UserDataDispose)

function FightBuffPlayAnimation:ctor(entity, buff_mo, url)
	self:__onInit()

	self._entity = entity
	self._buff_mo = buff_mo
	self._url = url

	self:_beforePlayAni()

	self._loader = MultiAbLoader.New()

	self._loader:addPath(FightHelper.getEntityAniPath(url))
	self._loader:startLoad(self._onEntityAnimLoaded, self)
end

function FightBuffPlayAnimation:_beforePlayAni()
	return
end

function FightBuffPlayAnimation:_onEntityAnimLoaded()
	local animInst = self._loader:getFirstAssetItem():GetResource(ResUrl.getEntityAnim(self._url))

	animInst.legacy = true

	local animComp = gohelper.onceAddComponent(self._entity.spine:getSpineGO(), typeof(UnityEngine.Animation))

	self._animStateName = animInst.name
	self._animComp = animComp
	animComp.enabled = true
	animComp.clip = animInst

	animComp:AddClip(animInst, animInst.name)

	local state = animComp.this:get(animInst.name)

	if state then
		state.speed = FightModel.instance:getSpeed()
	end

	animComp:Play()
	TaskDispatcher.runDelay(self._animDone, self, animInst.length / FightModel.instance:getSpeed())
	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
end

function FightBuffPlayAnimation:_animDone()
	if not gohelper.isNil(self._animComp) then
		local anim_name = self._animStateName

		if self._animComp:GetClip(anim_name) then
			self._animComp:RemoveClip(anim_name)
		end

		if self._animComp.clip and self._animComp.clip.name == anim_name then
			self._animComp.clip = nil
		end

		self._animComp.enabled = false
	end

	ZProj.CharacterSetVariantHelper.Disable(self._entity.spine:getSpineGO())
end

function FightBuffPlayAnimation:_onUpdateSpeed()
	if not gohelper.isNil(self._animComp) then
		local state = self._animComp.this:get(self._animStateName)

		if state then
			state.speed = FightModel.instance:getSpeed()
		end
	end
end

function FightBuffPlayAnimation:releaseSelf()
	self:_animDone()
	TaskDispatcher.cancelTask(self._animDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._entity = nil
	self._buff_mo = nil
	self._url = nil

	self:__onDispose()
end

return FightBuffPlayAnimation
