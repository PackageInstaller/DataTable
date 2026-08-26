-- chunkname: @modules/logic/fight/entity/comp/FightUnitSpine.lua

module("modules.logic.fight.entity.comp.FightUnitSpine", package.seeall)

local FightUnitSpine = class("FightUnitSpine", FightSpineComp)

function FightUnitSpine:_onResLoaded(loader)
	if gohelper.isNil(self._gameObj) then
		return
	end

	FightUnitSpine.super._onResLoaded(self, loader)
end

function FightUnitSpine:onConstructor()
	self:reInitDefaultAnimState()
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.SkillEditorRefreshBuff, self.detectRefreshAct)
end

function FightUnitSpine:reInitDefaultAnimState()
	local entityMo = self.unitSpawn:getMO()

	if not entityMo then
		return
	end

	if not entityMo:isMonster() then
		return
	end

	local skinCo = entityMo:getSpineSkinCO()

	if not skinCo then
		return
	end

	local monsterIdleMapCo = lua_fight_monster_skin_idle_map.configDict[skinCo.id]

	if not monsterIdleMapCo then
		return
	end

	self._defaultAnimState = monsterIdleMapCo.idleAnimName
end

function FightUnitSpine:play(animState, loop, reStart, donotProcess, fightStepData)
	if self.lockAct then
		return
	end

	animState = self:replaceAnimState(animState)

	if not donotProcess then
		animState = FightHelper.processEntityActionName(self.unitSpawn, animState, fightStepData)
	end

	if self:_cannotPlay(animState) then
		self:_onAnimCallback(animState, SpineAnimEvent.ActionComplete)

		return
	end

	if self._tran_to_ani == animState then
		return
	else
		self._tran_to_ani = nil
	end

	local need_transition, transition_ani = FightHelper.needPlayTransitionAni(self.unitSpawn, animState)

	if need_transition then
		if transition_ani == "0" then
			self:setAnimation(animState, loop)

			return
		elseif transition_ani == "-1" then
			self:_onAnimCallback(animState, SpineAnimEvent.ActionComplete)

			return
		else
			self._tran_to_ani = animState
			self._tran_loop = loop
			self._tran_reStart = reStart
			self._tran_ani = transition_ani

			self.addAnimEventCallback(self, self._onTransitionAnimEvent, self)
			FightUnitSpine.super.play(self, self._tran_ani, false, true)

			return
		end
	end

	self._tran_ani = nil

	FightUnitSpine.super.play(self, animState, loop, reStart)
end

function FightUnitSpine:replaceAnimState(animState)
	local skinCustomComp = self.unitSpawn.skinCustomComp
	local comp = skinCustomComp and skinCustomComp:getCustomComp()

	if comp then
		animState = comp:replaceAnimState(animState)
	end

	local entityMo = self.unitSpawn:getMO()

	if not entityMo then
		return animState
	end

	if not entityMo:isMonster() then
		return animState
	end

	local skinCo = entityMo:getSpineSkinCO()

	if not skinCo then
		return animState
	end

	local monsterAnimMapCo = lua_fight_monster_skin_idle_map.configDict[skinCo.id]

	if not monsterAnimMapCo then
		return animState
	end

	local configAnim = monsterAnimMapCo[animState .. "AnimName"]

	if string.nilorempty(configAnim) then
		return animState
	else
		return configAnim
	end
end

function FightUnitSpine:_onTransitionAnimEvent(actionName, eventName, eventArgs)
	if actionName == self._tran_ani and eventName == SpineAnimEvent.ActionComplete then
		self.removeAnimEventCallback(self, self._onTransitionAnimEvent, self)
		FightUnitSpine.super.play(self, self._tran_to_ani, self._tran_loop, self._tran_reStart)

		self._tran_to_ani = nil
	end
end

function FightUnitSpine:tryPlay(animState, loop, reStart)
	if not self:hasAnimation(animState) then
		return false
	end

	local buffDic = self.unitSpawn:getMO():getBuffDic()

	for i, v in pairs(buffDic) do
		local buff_id = v.buffId

		if FightBuffHelper.isStoneBuff(buff_id) then
			return
		end

		if FightBuffHelper.isDizzyBuff(buff_id) then
			return
		end

		if FightBuffHelper.isSleepBuff(buff_id) then
			return
		end

		if FightBuffHelper.isFrozenBuff(buff_id) then
			return
		end
	end

	self:play(animState, loop, reStart)

	return true
end

function FightUnitSpine:_cannotPlay(animState)
	if self.unitSpawn.buff then
		local buffTypeList = FightConfig.instance:getRejectActBuffTypeList(animState)

		if buffTypeList then
			for i, buffTypeId in ipairs(buffTypeList) do
				if self.unitSpawn.buff:haveBuffTypeId(buffTypeId) then
					return true
				end
			end
		end
	end

	if self.unitSpawn.buff and self.unitSpawn.buff:haveBuffId(2112031) and animState ~= "innate3" then
		return true
	end

	local skinCustomComp = self.unitSpawn.skinCustomComp
	local comp = skinCustomComp and skinCustomComp:getCustomComp()

	if comp then
		return not comp:canPlayAnimState(animState)
	end
end

function FightUnitSpine:playAnim(animState, loop, reStart)
	FightUnitSpine.super.playAnim(self, animState, loop, reStart)

	if self._specialSpine then
		self._specialSpine:playAnim(animState, loop, reStart)
	end
end

function FightUnitSpine:setFreeze(isFreeze)
	FightUnitSpine.super.setFreeze(self, isFreeze)

	if self._specialSpine then
		self._specialSpine:setFreeze(isFreeze)
	end
end

function FightUnitSpine:setTimeScale(timeScale)
	FightUnitSpine.super.setTimeScale(self, timeScale)

	if self._specialSpine then
		self._specialSpine:setTimeScale(timeScale)
	end
end

function FightUnitSpine:setLayer(layer, recursive)
	FightUnitSpine.super.setLayer(self, layer, recursive)

	if self._specialSpine then
		self._specialSpine:setLayer(layer, recursive)
	end
end

function FightUnitSpine:setRenderOrder(order, force)
	FightUnitSpine.super.setRenderOrder(self, order, force)

	if self._specialSpine then
		self._specialSpine:setRenderOrder(order, force)
	end
end

function FightUnitSpine:changeLookDir(dir)
	FightUnitSpine.super.changeLookDir(self, dir)

	if self._specialSpine then
		self._specialSpine:changeLookDir(dir)
	end
end

function FightUnitSpine:_changeLookDir()
	FightUnitSpine.super._changeLookDir(self)

	if self._specialSpine then
		self._specialSpine:_changeLookDir()
	end
end

function FightUnitSpine:setActive(isActive)
	FightUnitSpine.super.setActive(self, isActive)

	if self._specialSpine then
		self._specialSpine:setActive(isActive)
	end
end

function FightUnitSpine:setAnimation(animState, loop, mixTime)
	if self._skeletonAnim then
		self._skeletonAnim.loop = loop
		self._skeletonAnim.CurAnimName = animState
	end

	FightUnitSpine.super.setAnimation(self, animState, loop, mixTime)

	if self._specialSpine then
		self._specialSpine:setAnimation(animState, loop, mixTime)
	end
end

function FightUnitSpine:_initSpine(spineGO)
	FightUnitSpine.super._initSpine(self, spineGO)
	self:_initSpecialSpine()
	self:detectDisplayInScreen()
end

function FightUnitSpine:_initSpecialSpine()
	if self.unitSpawn:getMO() then
		if self.LOCK_SPECIALSPINE then
			return
		end

		local specialClassName = "FightEntitySpecialSpine" .. self.unitSpawn:getMO().modelId

		if _G[specialClassName] then
			self._specialSpine = _G[specialClassName].New(self.unitSpawn)
		end
	end
end

function FightUnitSpine:detectDisplayInScreen()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return true
	end

	local transform = self:getSpineTr()

	if transform then
		local entityMO = FightDataHelper.entityMgr:getById(self.unitSpawn.id)

		if entityMO then
			local modelId = entityMO.modelId
			local config = lua_fight_monster_display_condition.configDict[modelId]

			if config then
				local inScreen = false
				local buffDic = entityMO:getBuffDic()

				for i, v in pairs(buffDic) do
					if v.buffId == config.buffId then
						inScreen = true

						break
					end
				end

				if inScreen then
					transformhelper.setLocalPos(transform, 0, 0, 0)
				else
					transformhelper.setLocalPos(transform, 20000, 0, 0)

					return false
				end
			end
		end
	end

	return true
end

function FightUnitSpine:detectRefreshAct(buffId)
	local entityMO = self.unitSpawn:getMO()

	if entityMO then
		local config = lua_fight_buff_replace_spine_act.configDict[entityMO.skin]

		if config and config[buffId] then
			self.unitSpawn:resetAnimState()
		end
	end
end

function FightUnitSpine:_onBuffUpdate(entityId, effectType, buffId)
	if entityId == self.unitSpawn.id then
		self:detectDisplayInScreen()
		self:detectRefreshAct(buffId)
	end
end

function FightUnitSpine:releaseSpecialSpine()
	if self._specialSpine then
		self._specialSpine:releaseSelf()

		self._specialSpine = nil
	end
end

function FightUnitSpine:_clear()
	self:releaseSpecialSpine()
	self.removeAnimEventCallback(self, self._onTransitionAnimEvent, self)
	FightUnitSpine.super._clear(self)
end

function FightUnitSpine:onDestructor()
	return
end

return FightUnitSpine
