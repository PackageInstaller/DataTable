-- chunkname: @modules/logic/fight/entity/comp/specialspine/FightEntitySpecialSpine3072_Mask.lua

module("modules.logic.fight.entity.comp.specialspine.FightEntitySpecialSpine3072_Mask", package.seeall)

local FightEntitySpecialSpine3072_Mask = class("FightEntitySpecialSpine3072_Mask", UserDataDispose)
local maskBuffId = 30720101

function FightEntitySpecialSpine3072_Mask:ctor(entity)
	self:__onInit()

	self._entity = entity

	self:_initSpine()
	self.addEventCb(self, FightController.instance, FightEvent.SetEntityAlpha, self._onSetEntityAlpha, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork, self)
	self.addEventCb(self, FightController.instance, FightEvent.TimelinePlayEntityAni, self._onTimelinePlayEntityAni, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetSpinePosByTimeline, self.onSetSpinePosByTimeline, self)
end

function FightEntitySpecialSpine3072_Mask:_onBuffUpdate(targetId, effectType, buffId)
	if targetId ~= self._entity.id then
		return
	end

	if buffId ~= maskBuffId then
		return
	end

	self:_detectMaskBuff()
end

function FightEntitySpecialSpine3072_Mask:_detectMaskBuff()
	local showMask = false
	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			if v.buffId == maskBuffId then
				showMask = true

				break
			end
		end
	end

	self._showMask = showMask

	self:_refreshMaskVisible()
end

function FightEntitySpecialSpine3072_Mask:_refreshMaskVisible()
	if not gohelper.isNil(self._spineRoot) then
		local state = not not self._showMask

		if self._entity.marked_alpha == 0 then
			state = false
		end

		if self._playingSkill then
			state = false
		end

		if self._playingAni then
			state = false
		end

		transformhelper.setLocalPos(self._spineRootTransform, state and 0 or 20000, 0, 0)

		if state then
			self:_correctAniTime()
		end
	end
end

function FightEntitySpecialSpine3072_Mask:_onSetEntityAlpha(alpha)
	self:_refreshMaskVisible()
end

function FightEntitySpecialSpine3072_Mask:_initSpine()
	self._spineRoot = gohelper.create3d(self._entity.go, "specialSpine")
	self._spineRootTransform = self._spineRoot.transform
	self._spine = MonoHelper.addLuaComOnceToGo(self._spineRoot, UnitSpine, self._entity)

	local entityMO = self._entity:getMO()
	local path

	self._spine:setResPath(entityMO.skin == 307203 and "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab" or string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", entityMO.skin, entityMO.skin), self._onSpineLoaded, self)
end

function FightEntitySpecialSpine3072_Mask:onSetSpinePosByTimeline(entityId, posX, posY, posZ)
	if entityId == self._entity.id then
		local transform = self._spine:getSpineTr()

		if transform then
			transformhelper.setLocalPos(transform, posX, posY, posZ)
		end
	end
end

function FightEntitySpecialSpine3072_Mask:_onSpineLoaded(spine)
	if self._layer then
		self:setLayer(self._layer, self._recursive)
	end

	if self._order then
		self:setRenderOrder(self._order, true)
	end

	if self._isActive ~= nil then
		self:setActive(self._isActive)
	end

	self._spine._skeletonAnim.freeze = self._entity.spine._bFreeze
	self._spine._skeletonAnim.timeScale = self._entity.spine._timeScale

	local mainSpine = self._entity.spine
	local curTrack = mainSpine._skeletonAnim.state:GetCurrent(0)

	if curTrack and self._spine._skeletonAnim then
		self:playAnim(mainSpine:getAnimState(), mainSpine._isLoop, true)
	end

	self:_detectMaskBuff()
	self:_refreshMaskVisible()
end

function FightEntitySpecialSpine3072_Mask:_correctAniTime()
	local mainSpine = self._entity.spine
	local curTrack = mainSpine._skeletonAnim.state:GetCurrent(0)

	if curTrack and self._spine._skeletonAnim then
		self._spine._skeletonAnim:Jump2Time(curTrack.TrackTime)
	end
end

function FightEntitySpecialSpine3072_Mask:playAnim(animState, loop, reStart)
	if self._spine and self._spine._skeletonAnim and self._spine:hasAnimation(animState) then
		self._spine:playAnim(animState, loop, reStart)
	end
end

function FightEntitySpecialSpine3072_Mask:setFreeze(isFreeze)
	if self._spine then
		self._spine:setFreeze(isFreeze)
	end
end

function FightEntitySpecialSpine3072_Mask:setTimeScale(timeScale)
	if self._spine then
		self._spine:setTimeScale(timeScale)
	end
end

function FightEntitySpecialSpine3072_Mask:setLayer(layer, recursive)
	self._layer = layer
	self._recursive = recursive

	if self._spine and layer then
		self._spine:setLayer(layer, recursive)
	end
end

function FightEntitySpecialSpine3072_Mask:setRenderOrder(order, force)
	self._order = order

	if self._spine and order then
		self._spine:setRenderOrder(order + 1, force)
	end
end

function FightEntitySpecialSpine3072_Mask:changeLookDir(dir)
	if self._spine then
		self._spine:changeLookDir(dir)
	end
end

function FightEntitySpecialSpine3072_Mask:_changeLookDir()
	if self._spine then
		self._spine:_changeLookDir()
	end
end

function FightEntitySpecialSpine3072_Mask:setActive(isActive)
	self._isActive = isActive

	if self._spine then
		self._spine:setActive(isActive)
	end
end

function FightEntitySpecialSpine3072_Mask:setAnimation(animState, loop, mixTime)
	if self._spine then
		self._spine:setAnimation(animState, loop, mixTime)
	end
end

function FightEntitySpecialSpine3072_Mask:_onSkillPlayStart(entity, curSkillId)
	if entity.id == self._entity.id then
		self._playingSkill = true

		self:_refreshMaskVisible()
	end
end

function FightEntitySpecialSpine3072_Mask:_onSkillPlayFinish(entity, curSkillId)
	if entity.id == self._entity.id then
		self._playingSkill = false

		self:_refreshMaskVisible()
	end
end

function FightEntitySpecialSpine3072_Mask:_onTimelinePlayEntityAni(entityId, state)
	if entityId == self._entity.id then
		self._playingAni = state

		self:_refreshMaskVisible()
	end
end

function FightEntitySpecialSpine3072_Mask:_onFightReconnectLastWork()
	self:_onBuffUpdate(self._entity.id, nil, maskBuffId)
end

function FightEntitySpecialSpine3072_Mask:releaseSelf()
	if self._spineRoot then
		gohelper.destroy(self._spineRoot)
	end

	self._entity = nil

	self:__onDispose()
end

return FightEntitySpecialSpine3072_Mask
