-- chunkname: @modules/logic/fight/entity/FightEntityObject.lua

module("modules.logic.fight.entity.FightEntityObject", package.seeall)

local FightEntityObject = class("FightEntityObject", FightBaseClass)

function FightEntityObject:onConstructor(gameObjectName, entityData)
	self.go = gohelper.create3d(self.PARENT_ROOT_OBJECT._containerGO, gameObjectName)
	self.go.tag = self:getTag()
	self._compList = {}
	self.id = entityData.id
	self.entityId = entityData.id
	self.entityData = entityData
	self._isActive = true
	self.isDead = false
	self.deadBySkillId = nil
	self.createStage = FightEnum.EntityCreateStage.None

	self:initHangPointDict()
	FightRenderOrderMgr.instance:register(self.entityId)
	self:initComponents()
	self:registClasses()
end

function FightEntityObject:getCompList()
	return self._compList
end

function FightEntityObject:getTag()
	return SceneTag.Untagged
end

function FightEntityObject:addEntityComponent(compClass)
	local insComp = self.addComponent(self, compClass, self)

	table.insert(self._compList, insComp)

	return insComp
end

function FightEntityObject:setUseGoScaleReplaceSpineScale(active)
	if self.spine and self.spine.setUseGoScaleReplaceSpineScale then
		self.spine:setUseGoScaleReplaceSpineScale(active)
	end
end

function FightEntityObject:initComponents()
	self.spine = self:addEntityComponent(self:getSpineClass())
	self.skill = self:addEntityComponent(FightSkillComp)
	self.effect = self:addEntityComponent(FightEffectComp)
	self.buff = self:addEntityComponent(FightBuffComp)
	self.spineRenderer = self:addEntityComponent(self:getSpineRendererClass())
	self.moveComp = self:addEntityComponent(FightEntityMoveComp)
	self.skinSpineAction = self:addEntityComponent(FightSkinSpineAction)
	self.skinSpineEffect = self:addEntityComponent(FightSkinSpineEffect)
	self.totalDamage = self:addEntityComponent(FightTotalDamageComp)
	self.uniqueEffect = self:addEntityComponent(FightUniqueEffectComp)
	self.skinCustomComp = self:addEntityComponent(FightSkinCustomComp)
	self.spineScaleComp = self:addEntityComponent(FightSpineScaleComp)

	local mo = self.entityData

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		self.nameUI = self:addEntityComponent(BossRushFightNameUI)
	elseif mo:isAssistBoss() then
		-- block empty
	elseif mo:isAct191Boss() then
		-- block empty
	else
		self.nameUI = self:addEntityComponent(FightNameUI)
	end

	if self.entityData.modelId == 3092 then
		local skin = self.entityData.skin

		FightGameMgr.timelinePreLoaderMgr:preLoadTimeline("yigeer_309201_unique", self.entityData)

		if skin == 309203 then
			FightGameMgr.timelinePreLoaderMgr:preLoadTimeline("yigeer_309203_unique", self.entityData)
		end
	end
end

function FightEntityObject:getSpineRendererClass()
	local skin = self.entityData.skin

	if lua_fight_monster_3d.configDict[skin] then
		return Fight3DSpineRendererComp
	end

	return FightSpineRendererComp
end

function FightEntityObject:setCreateStage(stage)
	self.createStage = stage
end

function FightEntityObject:getCreateStage()
	return self.createStage
end

function FightEntityObject:getSpineClass()
	local skin = self.entityData.skin

	if lua_fight_monster_3d.configDict[skin] then
		return Fight3DSpineComp
	end

	return FightUnitSpine
end

function FightEntityObject:getMO()
	return FightDataHelper.entityMgr:getById(self.id)
end

function FightEntityObject:getSide()
	local mo = self.entityData

	if mo then
		return mo.side
	end

	return FightEnum.EntitySide.BothSide
end

function FightEntityObject:isMySide()
	return self:getSide() == FightEnum.EntitySide.MySide
end

function FightEntityObject:isEnemySide()
	return self:getSide() == FightEnum.EntitySide.EnemySide
end

function FightEntityObject:isActive()
	return self._isActive
end

function FightEntityObject:setRenderOrder(order)
	if self.spine then
		self.spine:setRenderOrder(order)
	end
end

function FightEntityObject:registLoadSpineWork(customUrl)
	if self.spine then
		if self.spine:getSpineGO() then
			self._hangPointDict = {}
		end

		local flow = self:com_registFlowSequence()

		flow:addWork(self.spine:registLoadSpineWork(customUrl, self._onSpineLoaded, self))

		return flow
	end
end

function FightEntityObject:_onSpineLoaded()
	local entity = self

	if entity.spineRenderer then
		entity.spineRenderer:setSpine(entity.spine)
	end

	local unitSpine = entity.spine
	local lookDir = FightHelper.getEntitySpineLookDir(self.entityData)

	unitSpine:changeLookDir(lookDir)

	local mat = unitSpine.unitSpawn.spineRenderer:getReplaceMat()

	FightGameMgr.entityMgr:adjustSpineLookRotation(unitSpine.unitSpawn)
	FightGameMgr.bloomMgr:addEntity(entity)
	FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, unitSpine)
	FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, unitSpine)
	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, entity.id, mat)
	self:setupLookAtCamera()
end

function FightEntityObject:setupLookAtCamera()
	if FightDataHelper.entityExMgr:getById(self.id).needLookCamera then
		local transformListener = ZProj.TransformListener.Get(self.go)

		transformListener:AddPositionCallback(self._onTransformChange, self)
	end
end

function FightEntityObject:_onTransformChange()
	local entityMgr = FightGameMgr.entityMgr

	entityMgr:adjustSpineLookRotation(self)
end

function FightEntityObject:setActive(isActive, isForce)
	if isForce or isActive ~= self._isActive then
		self._isActive = isActive

		gohelper.setActive(self.go, self._isActive)

		local compList = self:getCompList()

		if compList then
			for _, comp in ipairs(compList) do
				if comp.setActive then
					comp:setActive(isActive)
				end
			end
		end
	end
end

function FightEntityObject:setVisibleByPos(isVisible)
	if not self.go then
		logError("找不到entity实体GameObject~~~~~~~~~~~~~~~~~~~~~")

		return
	end

	if isVisible then
		self:resetStandPos()
	else
		transformhelper.setLocalPos(self.go.transform, 9999, 9999, 9999)
	end
end

function FightEntityObject:setAlpha(alpha, duration)
	self.marked_alpha = alpha

	if self.spineRenderer then
		self.spineRenderer:setAlpha(alpha, duration)
	end

	if self.buff then
		if alpha == 0 then
			self.buff:hideBuffEffects()
		elseif alpha == 1 then
			self.buff:showBuffEffects()
		end
	end

	if self.skinSpineEffect then
		if alpha == 0 then
			self.skinSpineEffect:hideEffects()
		else
			self.skinSpineEffect:showEffects()
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityAlpha, self.id, alpha ~= 0)
end

function FightEntityObject:resetEntity()
	if gohelper.isNil(self.go) then
		return
	end

	local mo = self:getMO()

	if not mo then
		return
	end

	if mo:isASFDEmitter() then
		return
	end

	if mo:isRouge2Music() then
		return
	end

	if mo:isVorpalith() then
		return
	end

	if FightEntityDataHelper.isPlayerUid(mo.id) then
		return
	end

	if self.skill and self.skill:sameSkillPlaying() then
		return
	end

	local lookDir = FightHelper.getEntitySpineLookDir(mo)

	if self.spine then
		self.spine:changeLookDir(lookDir)
	end

	self:resetAnimState()
	self:resetSpineMat()
	self:resetStandPos()
	self:resetSpineRotate()

	local _, _, _, scale = FightHelper.getEntityStandPos(mo)

	self:setScale(scale)
end

function FightEntityObject:resetAnimState()
	if self.isDead then
		return
	end

	local animName = self:getDefaultAnim()

	if not string.nilorempty(animName) and self.spine then
		self.spine:removeAnimEventCallback(self._onChange2AnimEvent, self)

		local change2 = SpineAnimState.change2

		if animName == SpineAnimState.idle1 and self.spine:getAnimState() == SpineAnimState.posture and self.spine:hasAnimation(change2) then
			self.spine:addAnimEventCallback(self._onChange2AnimEvent, self)
			self.spine:play(change2, false, true)
		elseif self.spine:hasAnimation(animName) then
			self.spine:play(animName, true, false)
		else
			self.spine:play(SpineAnimState.idle1, true, true)
		end
	end
end

function FightEntityObject:_onChange2AnimEvent(actionName, eventName, eventArgs)
	if self.spine then
		local curAniName = self.spine:getAnimState()

		if self.spine == actionName and actionName == SpineAnimState.change2 and eventName == SpineAnimEvent.ActionComplete then
			self.spine:removeAnimEventCallback(self._onChange2AnimEvent, self)
			self.spine:play(SpineAnimState.idle1, true, true)
		end
	end
end

function FightEntityObject:resetStandPos()
	local mo = self:getMO()

	if mo and not gohelper.isNil(self.go) then
		transformhelper.setLocalPos(self.go.transform, FightHelper.getEntityStandPos(mo))
	end
end

function FightEntityObject:resetSpineRotate()
	if self.spine then
		local spineTr = self.spine:getSpineTr()

		if not gohelper.isNil(self.spine) then
			transformhelper.setLocalRotation(self.spine, 0, 0, 0)
		end
	end
end

function FightEntityObject:resetSpineMat()
	if not self.spine or not self.spine:getSpineGO() then
		return
	end

	local matName = self:getDefaultMatName()

	if matName then
		if not string.nilorempty(matName) and matName ~= self._curMatName then
			self._curMatName = matName

			local newMat = FightSpineMatPool.getMat(matName)

			if newMat then
				newMat.name = matName

				self.spineRenderer:replaceSpineMat(newMat)
			end
		end
	else
		self._curMatName = nil

		self.spineRenderer:resetSpineMat()
	end

	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, self.id, self.spineRenderer:getReplaceMat())
end

function FightEntityObject:getScale()
	local x, _, _ = transformhelper.getLocalScale(self.go.transform)

	return x
end

function FightEntityObject:setScale(scale)
	if gohelper.isNil(self.go) then
		return
	end

	transformhelper.setLocalScale(self.go.transform, scale, scale, scale)
end

function FightEntityObject:setSpeed(speed)
	if self.spine then
		self.spine:setTimeScale(speed)
	end

	if self.moveComp then
		self.moveComp:setTimeScale(speed)
	end

	if self.skill then
		self.skill:setTimeScale(speed)
	end

	if self.effect then
		self.effect:setTimeScale(speed)
	end
end

function FightEntityObject:getDefaultAnim()
	local buffAnim = self:getBuffAnim()

	if buffAnim then
		return buffAnim
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play and FightPlayCardModel.instance:isPlayerHasSkillToPlay(self.id) then
		return SpineAnimState.posture
	end

	return SpineAnimState.idle1
end

function FightEntityObject:getBuffAnim()
	if self.buff then
		local buffAnim = self.buff:getBuffAnim()

		if buffAnim then
			return buffAnim
		end
	end
end

function FightEntityObject:getDefaultMatName()
	if self.buff then
		return self.buff:getBuffMatName()
	end
end

function FightEntityObject:onLogicExit()
	if self._hasDestroy then
		return
	end

	self._hasDestroy = true

	if self.spine then
		self.spine:removeAnimEventCallback(self._onChange2AnimEvent, self)
	end

	FightRenderOrderMgr.instance:unregister(self.id)
	FightGameMgr.bloomMgr:removeEntity(self)

	if not gohelper.isNil(self.go) then
		local transformListener = ZProj.TransformListener.Get(self.go)

		transformListener:RemovePositionCallback()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeEntityDestroy, self)
end

function FightEntityObject:initHangPointDict()
	self._hangPointDict = {}
end

function FightEntityObject:getHangPoint(hangPointName, noProcess)
	local existHangPoint = self._hangPointDict[hangPointName]

	if existHangPoint then
		return existHangPoint
	elseif self.spine then
		local spineGO = self.spine:getSpineGO()

		if not spineGO then
			return self.go
		end

		local hangPointGO = self.go

		if not string.nilorempty(hangPointName) then
			local findHangPointGO
			local hangPointRootGO = gohelper.findChild(spineGO, ModuleEnum.SpineHangPointRoot)

			if hangPointName == ModuleEnum.SpineHangPointRoot then
				findHangPointGO = hangPointRootGO
			elseif string.find(hangPointName, ModuleEnum.SpineHangPoint.BodyStatic) then
				findHangPointGO = gohelper.create3d(hangPointRootGO, hangPointName)

				transformhelper.setLocalPos(findHangPointGO.transform, FightHelper.getEntityLocalCenterPos(self))
			elseif string.find(hangPointName, ModuleEnum.SpineHangPoint.HeadStatic) then
				findHangPointGO = gohelper.create3d(hangPointRootGO, hangPointName)

				transformhelper.setLocalPos(findHangPointGO.transform, FightHelper.getEntityLocalTopPos(self))
			else
				findHangPointGO = gohelper.findChild(hangPointRootGO, hangPointName)
			end

			if findHangPointGO then
				hangPointGO = findHangPointGO
			else
				hangPointGO = hangPointRootGO

				local begin = string.find(spineGO.name, "(Clone)", 1)
				local spineName = begin and string.sub(spineGO.name, 1, begin - 2) or spineGO.name

				if isDebugBuild then
					logError(spineName .. " 缺少挂点: " .. hangPointName)
				end
			end

			self._hangPointDict[hangPointName] = hangPointGO
		end

		return hangPointGO
	end
end

function FightEntityObject:registClasses()
	local entityMO = self:getMO()

	if not entityMO then
		return
	end

	if FightEntityDataHelper.isPlayerUid(entityMO.id) then
		return
	end

	self.newClass(self, FightEntitySummonedComp, self)
	self.newClass(self, FightEntityBuffSpecialPrecessComp, self)
end

function FightEntityObject:onDestructor()
	gohelper.destroy(self.go)
	FightMsgMgr.sendMsg(FightMsgId.AfterDestroyEntity, self.id)
end

return FightEntityObject
