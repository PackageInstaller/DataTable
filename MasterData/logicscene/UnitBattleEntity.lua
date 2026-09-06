-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/battle/UnitBattleEntity.lua

module("logicscene.scene.unit.impl.battle.UnitBattleEntity", package.seeall)

local UnitBattleEntity = class("UnitBattleEntity", UnitBase)
local spineHeadPointBone = "shang_gensui"
local spineCenterPointBone = "zhong_gensui"
local spineFootPointBone = "xia_gensui"
local spineFrontPointBone = "qian_gensui"
local battleEffectOrderCtrl
local compMeshRenderer = typeof(UnityEngine.MeshRenderer)

function UnitBattleEntity:ctor(componetContainer)
	UnitBattleEntity.super.ctor(self, componetContainer)
	NotifyDispatcher.extend(self)

	self.radius = 0.5
	self._skillAnimDuration = 0
	self._isPlayingSkillAnim = nil
	self._onSpineLoadedCallback = nil
	self._onSpineLoadedTarget = nil
	self._spineIns = nil
	self._isTransparent = nil
	self._headFollowBoneExist = nil
	self._centerFollowBoneExist = nil
	self._footFollowBoneExist = nil
	self._frontFollowBoneExist = nil
	self._hagPointPos = nil
	battleEffectOrderCtrl = battleEffectOrderCtrl or BattleEffectOrderCtrl
	self._alpha = 1
	self._isVisible = true
end

function UnitBattleEntity:_initComponents()
	self:_addComponent("mountRoot", UnitCompMountRoot)
	self:_addComponent("spine", UnitCompSpineAnims)
	self:_addComponent("spineEvent", UnitCompSpineEvent)
	self:_addComponent("unitUI", UnitCompBattleUI)
	self:_addComponent("shadow", UnitCompShadow)
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("attrs", UnitCompAttrs)
	self:_addComponent("skillList", UnitCompSkillList)
	self:_addComponent("battleFlow", UnitCompBattleFlowCommon)
	self:_addComponent("skillPlayer", UnitCompSkillPlayer)
	self:_addComponent("buffList", UnitCompBuffList)
	self:_addComponent("spineMover", UnitCompSpineMoverWithCamera)
	self:_addComponent("battleEffects", UnitCompBattleEffect)
	self:_addComponent("buffPerform", UnitCompBuffPerform)
	self:_addComponent("spineEffect", UnitCompSpineEffect)
	self:_addComponent("buffEffects", UnitCompBuffEffects)
end

function UnitBattleEntity:setAlpha(alpha)
	self._alpha = alpha

	if alpha == 1 then
		self:_updateAlpha(true)
	end
end

function UnitBattleEntity:getAlpha()
	return self._alpha
end

function UnitBattleEntity:getTag()
	return UnitTag.Player
end

function UnitBattleEntity:getLayer()
	return SceneLayer.Unit_Value
end

function UnitBattleEntity:getMountPoint(mountType)
	if mountType == GameEnum.MountPointType.Head then
		return self.mountPointHead or self.go
	elseif mountType == GameEnum.MountPointType.Center then
		return self.mountPointCenter or self.go
	elseif mountType == GameEnum.MountPointType.Foot then
		return self.mountPointFoot or self.go
	elseif mountType == GameEnum.MountPointType.Front then
		return self.mountPointFront or self.go
	else
		return self.go
	end
end

function UnitBattleEntity:getHangPoint(mountName)
	if mountName == UnitConst.spineHeadPointPath then
		return self.mountPointHead or self.go
	elseif mountName == UnitConst.spineCenterPointPath then
		return self.mountPointCenter or self.go
	elseif mountName == UnitConst.spineFootPointPath then
		return self.mountPointFoot or self.go
	elseif mountName == UnitConst.effectPointPath then
		return self.effectPoint or self.go
	elseif mountName == UnitConst.spineFrontPointPath then
		return self.mountPointFront or self.go
	else
		return self.go
	end
end

function UnitBattleEntity:checkHasLodUrl(url)
	if not goutil.isNil(self._spineIns) and url == self.spine._url then
		return true
	else
		return false
	end
end

function UnitBattleEntity:load(url, onSpineLoaded, onSpineLoadedTarget)
	self._onSpineLoadedCallback = onSpineLoaded
	self._onSpineLoadedTarget = onSpineLoadedTarget

	if not goutil.isNil(self._spineIns) and url == self.spine._url then
		self:_callSpineLoadedCallback()

		return
	end

	self:_preSaveAllEffects()
	self.spineEffect:onDestroy()
	self.spine:clear()

	self._spineIns = nil
	self.mountPointHead = nil
	self.mountPointCenter = nil
	self.mountPointFoot = nil
	self.mountPointFront = nil

	self.spine:addListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	self.spine:setBody(url)
end

function UnitBattleEntity:onUnitDestroyed()
	self:stopSkillCameraMotion()
	self:stopSkill()
	self.buffList:removeAll(true)
	self.unitUI:onDestroy()
	self.spineEffect:onDestroy()
	self.spine:clear()
	self:OnDestroy()

	self._spineIns = nil
end

function UnitBattleEntity:setVisible(visible)
	self._isVisible = visible

	goutil.setActive(self.go, visible)

	if self.attrs:isDead() then
		self.unitUI:setVisible(false)
		self.shadow:setActive(false)
	else
		self.unitUI:setVisible(visible)
		self.shadow:setActive(visible)
		self.buffList:setVisible(visible)
	end
end

function UnitBattleEntity:hideUIAndShadow(hide)
	if self.attrs:isDead() then
		self.unitUI:setVisible(false)
		self.shadow:setActive(false)
		self.buffList:setVisible(false)
	elseif not hide then
		self.unitUI:setVisible(true)
		self.shadow:setActive(true)
		self.buffList:setVisible(true)
		self.unitUI:enabledFollowTargets(true)
	else
		self.unitUI:setVisible(false)
		self.shadow:setActive(false)
		self.buffList:setVisible(false)
		self.unitUI:enabledFollowTargets(false)
	end
end

function UnitBattleEntity:hideBuffEffects(hide)
	if hide then
		self.buffList:setVisible(false)
	else
		self.buffList:setVisible(true)
	end
end

function UnitBattleEntity:_onSpineLoaded()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onSpineLoaded, self)
	self:updateSpineAndMountPoints()
	self.unitUI:load()
	self:setVisible(self._isVisible)
	self:_callSpineLoadedCallback()
end

function UnitBattleEntity:_callSpineLoadedCallback()
	if self._onSpineLoadedCallback then
		if self._onSpineLoadedTarget then
			self._onSpineLoadedCallback(self._onSpineLoadedTarget)
		else
			self._onSpineLoadedCallback()
		end

		self._onSpineLoadedCallback = nil
		self._onSpineLoadedTarget = nil
	end
end

function UnitBattleEntity:updateSpineAndMountPoints()
	local spineIns = self.spine:getInst()

	self._spineIns = spineIns
	self.mountPointHead = goutil.findChild(spineIns, UnitConst.spineHeadPointPath)
	self.mountPointCenter = goutil.findChild(spineIns, UnitConst.spineCenterPointPath)
	self.mountPointFoot = goutil.findChild(spineIns, UnitConst.spineFootPointPath)
	self.mountPointFront = goutil.findChild(spineIns, UnitConst.spineFrontPointPath)
	self.effectPoint = goutil.findChild(self.go, UnitConst.effectPointPath)
	self._headFollowBoneExist = GoUtil.IsBoneExist(spineIns, spineHeadPointBone)
	self._centerFollowBoneExist = GoUtil.IsBoneExist(spineIns, spineCenterPointBone)
	self._footFollowBoneExist = GoUtil.IsBoneExist(spineIns, spineFootPointBone)
	self._frontFollowBoneExist = GoUtil.IsBoneExist(spineIns, spineFrontPointBone)

	self:_createFrontHagPoint()
	self:_updateHagPointsRotate()
	self:_updateHagPointsScale()
	self:setCurrLayer(SceneLayer.Unit_Value)

	if self.attrs:isInvisible() then
		Framework.GameObjectUtil.SetLayerRecursively(spineIns, SceneLayer.Invisible_Value)
	else
		Framework.GameObjectUtil.SetLayerRecursively(spineIns, SceneLayer.Unit_Value)
	end

	Framework.TransformUtil.SetLocalPos(spineIns.transform, 0, 0, 0)
	Billboard.Get(spineIns)
	self.spine:play("idle", true)
	self:_handlePreSaveEffects()

	self._sortingOrder = 0

	self:updateSortingOrder()

	local spineSkel = self.spine:getSkeletonAnimation()

	if spineSkel then
		spineSkel:Update(0)
		spineSkel:LateUpdate()

		self._meshRenderer = spineSkel:GetComponent(compMeshRenderer)
	end

	if self._isFollowingBone then
		self:onHagPointFollowBone(true)
	end

	if self.attrs:isFrozen() then
		self.spine:setPlaySpeed(0)
	else
		self.spine:setPlaySpeed(1)
	end

	if self.attrs:isTransrent() then
		self:_updateAlpha(true)
	end
end

function UnitBattleEntity:_onSpineEvent(actionName, eventName, eventParam)
	return
end

function UnitBattleEntity:_updateHagPointsRotate()
	local rotX = BattleSceneCamera.cameraRotX
	local rotY = BattleSceneCamera.cameraRotY
	local rotZ = BattleSceneCamera.cameraRotZ

	Framework.TransformUtil.SetLocalRotation(self.mountPointHead.transform, -rotX, -rotY, -rotZ)
	Framework.TransformUtil.SetLocalRotation(self.mountPointCenter.transform, -rotX, -rotY, -rotZ)
	Framework.TransformUtil.SetLocalRotation(self.mountPointFoot.transform, -rotX, -rotY, -rotZ)
	Framework.TransformUtil.SetLocalRotation(self.mountPointFront.transform, -rotX, -rotY, -rotZ)
end

function UnitBattleEntity:_updateHagPointsScale()
	GoUtil.SetUnitScale(self.mountPointHead)
	GoUtil.SetUnitScale(self.mountPointCenter)
	GoUtil.SetUnitScale(self.mountPointFoot)
	GoUtil.SetUnitScale(self.mountPointFront)
end

function UnitBattleEntity:_createFrontHagPoint()
	if not self.mountPointFront then
		local posX, posY, posZ

		if self._frontFollowBoneExist then
			posX, posY = GoUtil.GetBonePos(self._spineIns, spineFrontPointBone, nil, nil)
			posZ = 0
		elseif self.mountPointCenter then
			posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self.mountPointCenter.transform, nil, nil, nil)
			posX = 4
		end

		local parent = self.mountPointCenter.transform.parent

		self.mountPointFront = UnityEngine.GameObject.New("front")

		self.mountPointFront.transform:SetParent(parent)

		local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

		if dirTeamId == GameEnum.BattleTeam.Right then
			posX = -posX
		end

		Framework.TransformUtil.SetLocalPos(self.mountPointFront.transform, posX, posY, posZ)
	end
end

function UnitBattleEntity:updateHagPointFront()
	if self.mountPointFront then
		local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self.mountPointFront.transform, nil, nil, nil)
		local spineDir = self.spine:getDirection()

		posX = spineDir == UnitSpineDir.Right and math.abs(posX) or -math.abs(posX)

		Framework.TransformUtil.SetLocalPos(self.mountPointFront.transform, posX, posY, posZ)
	end
end

function UnitBattleEntity:invertDirection()
	local spineDir
	local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

	self.spine:setDirection(dirTeamId == GameEnum.BattleTeam.Left and UnitSpineDir.Left or UnitSpineDir.Right)
	self:updateHagPointFront()
	self:updateBuffsEffRotate()
end

function UnitBattleEntity:getDirection()
	local spineDir
	local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

	return dirTeamId == GameEnum.BattleTeam.Left and UnitSpineDir.Right or UnitSpineDir.Left
end

function UnitBattleEntity:updateBuffsEffRotate()
	local buffs = self.buffList:getBuffs()

	if not buffs then
		return
	end

	for i = 1, #buffs do
		if buffs[i].sustainEffectCo then
			local eff = buffs[i]:getSustainEffect()

			if eff and eff.effGo then
				self.battleEffects:updateRotation(eff, buffs[i].sustainEffectCo)
			end
		end
	end
end

function UnitBattleEntity:resumeDirection()
	local spineDir
	local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

	self.spine:setDirection(dirTeamId == GameEnum.BattleTeam.Left and UnitSpineDir.Right or UnitSpineDir.Left)
	self:updateHagPointFront()
	self:updateBuffsEffRotate()
end

function UnitBattleEntity:_preSaveAllEffects()
	local preSpineIns = self._spineIns

	if not goutil.isNil(preSpineIns) then
		local mountPointHead = goutil.findChild(preSpineIns, UnitConst.spineHeadPointPath)
		local mountPointCenter = goutil.findChild(preSpineIns, UnitConst.spineCenterPointPath)
		local mountPointFoot = goutil.findChild(preSpineIns, UnitConst.spineFootPointPath)
		local mountPointFront = goutil.findChild(preSpineIns, UnitConst.spineFrontPointPath)

		self:_saveEffects(mountPointHead, UnitConst.spineHeadPointPath)
		self:_saveEffects(mountPointCenter, UnitConst.spineCenterPointPath)
		self:_saveEffects(mountPointFoot, UnitConst.spineFootPointPath)
		self:_saveEffects(mountPointFront, UnitConst.spineFrontPointPath)
	end
end

function UnitBattleEntity:_saveEffects(fromNode, nodeName)
	if fromNode then
		local childCnt = fromNode.transform.childCount - 1

		if childCnt >= 0 then
			self._preSaveEffects = self._preSaveEffects or {}

			local effects = self._preSaveEffects[nodeName]

			if not effects then
				effects = {}
				self._preSaveEffects[nodeName] = effects
			end

			for i = 0, childCnt do
				local child = fromNode.transform:GetChild(i)

				table.insert(effects, child.gameObject)
			end

			for i = 1, childCnt + 1 do
				effects[i].transform:SetParent(nil)
			end
		end
	end
end

function UnitBattleEntity:_handlePreSaveEffects()
	if self._preSaveEffects then
		self:_handlerEffects(self.mountPointHead, UnitConst.spineHeadPointPath)
		self:_handlerEffects(self.mountPointCenter, UnitConst.spineCenterPointPath)
		self:_handlerEffects(self.mountPointFoot, UnitConst.spineFootPointPath)
		self:_handlerEffects(self.mountPointFront, UnitConst.spineFrontPointPath)

		self._preSaveEffects = nil
	end
end

function UnitBattleEntity:_handlerEffects(toNode, nodeName)
	if toNode then
		local effects = self._preSaveEffects[nodeName]

		if effects then
			local cnt = #effects

			for i = 1, cnt do
				local child = effects[i]

				child.transform:SetParent(toNode.transform)
				Framework.TransformUtil.SetLocalPos(child.transform, 0, 0, 0)

				local rotX, rotY, rotZ = Framework.TransformUtil.GetLocalRotation(child.transform, nil, nil, nil)

				Framework.TransformUtil.SetLocalRotation(child.transform, 0, rotY, rotZ)
			end
		end
	end
end

function UnitBattleEntity:update(deltaTime)
	self.unitUI:update(deltaTime)
	self.buffList:update(deltaTime)
	self.skillList:update(deltaTime)

	if self._cameraMotions then
		for k, v in pairs(self._cameraMotions) do
			v:update(deltaTime)
		end
	end

	self.buffPerform:update()
	self.spineEffect:update()
	self:_updateUnitState(deltaTime)
	self.buffEffects:update(deltaTime)
end

function UnitBattleEntity:_updateUnitState(deltaTime)
	if self.attrs:getCurHp() == 0 and self.attrs:getCurTempHp() == 0 then
		if self.isBorn and not self.attrs:isDead() and not self.attrs:isCollisionLocking() and not self.buffPerform:hasBuffDamages() and (not self.attrs:isSummonedCharacter() or self.attrs:isHaveBeenSummoned()) and (not self.attrs:isTJSummonedCharacter() or self.attrs:isHaveBeenTJSummoned()) and (not self.attrs:isDoppelganger() or self.attrs:isHaveBeenDoppelgangerCreated()) and not self.attrs:isBeingSummoned() and not self.attrs:isBeingTJSummoned() and not self.attrs:isSkillLocking() and not self.attrs:isTransforming() and not self.attrs:isTriggerTransPosition() and not self.attrs:isTransPosition() and (not self.attrs:isUsingSkill() or self.battleFlow:isSkillWithDrawByUnit(self)) and BattleModel.instance:getStrickBackTimes(self.teamId, self.id) == 0 and not self.attrs:isCombineUnit() and not self.attrs:isPerformingAttackRound() then
			self:onDead()
		end
	else
		self:_updateIdle()
	end

	if self._isPlayingSkillAnim and not self.skillList:isPause() then
		self:_updatePlayingSkillAnim(deltaTime)
	end

	self:_updateAlpha()
end

function UnitBattleEntity:_updateAlpha(force)
	if (force or self._alpha < 0.9999) and not goutil.isNil(self._meshRenderer) then
		local mainColorId = MaterialUtils.mainColorId
		local color = self._meshRenderer.material:GetColor(mainColorId)

		if force or color.a > self._alpha then
			color.a = self._alpha

			MaterialUtils.SetColorRGBA(self._meshRenderer, mainColorId, color.r, color.g, color.b, color.a)
		end
	end
end

function UnitBattleEntity:_updatePlayingSkillAnim(deltaTime)
	self._skillAnimDuration = self._skillAnimDuration - deltaTime

	if self._skillAnimDuration <= 0 then
		self._isPlayingSkillAnim = nil

		if not self.attrs:isDead() then
			self.spine:play("idle", true)
		end
	end
end

function UnitBattleEntity:_updateIdle()
	if self.battleFlow:isIdle(self) then
		if self.battleFlow:isBackable(self) then
			self.buffList:onBack()
		elseif not self._isPlayingSkillAnim and not self.attrs:isTransforming() then
			self.spine:play("idle", true)
		end
	end
end

function UnitBattleEntity:updateSortingOrder()
	if self.posRow ~= -1 and not goutil.isNil(self._spineIns) then
		local order = battleEffectOrderCtrl.getOrderByPosIndex(self.posRow)

		self:setSortingOrder(order)
	end
end

function UnitBattleEntity:setSortingOrder(order)
	if order and self._sortingOrder ~= order and not goutil.isNil(self._spineIns) then
		self._sortingOrder = order

		GoUtil.SetSortingOrderGreatZero(self._spineIns, order, false)
	end
end

function UnitBattleEntity:getSortingOrder()
	if self._sortingOrder then
		return self._sortingOrder
	end

	self:updateSortingOrder()

	return self._sortingOrder or 0
end

function UnitBattleEntity:isDead()
	return self.attrs:isDead()
end

function UnitBattleEntity:isTransparent()
	return self._isTransparent
end

function UnitBattleEntity:adjustSortingOrderOnStartSkill()
	if self._sortingOrder and self._spineIns then
		-- block empty
	end
end

function UnitBattleEntity:resumeSortingOrderOnStopSkill()
	if self._sortingOrder and self._spineIns then
		-- block empty
	end
end

function UnitBattleEntity:pause(pause)
	if pause then
		self.skillList:pause()

		if self._cameraMotions then
			for k, v in pairs(self._cameraMotions) do
				v:pause()
			end
		end
	else
		self.skillList:resume()

		if self._cameraMotions then
			for k, v in pairs(self._cameraMotions) do
				v:resume()
			end
		end
	end

	self.buffList:pause(pause)
end

function UnitBattleEntity:useSkill(skill, skillExecuteState, isStrickBack, attackCount)
	local charactor = BattleModel.instance:getCharactorById(self.teamId, self.id)

	if charactor and checkbool(charactor.isSpiritInvocationSummonPet) == true then
		self.attrs:setUsingSpiritInvocation(true)

		local masterCharactor = BattleModel.instance:getCharactorById(self.teamId, charactor.spiritInvocationMasterPetId)
		local callBack = GameUtil.handler(function()
			self.attrs:setUsingSpiritInvocation(false)
		end, self)
		local result = self.skillList:useSkill(skill, skillExecuteState, isStrickBack, attackCount)

		BattleController.instance:showStartUIBattleEffect(self, masterCharactor.curFaceId, callBack)

		return result
	else
		return self.skillList:useSkill(skill, skillExecuteState, isStrickBack, attackCount)
	end
end

function UnitBattleEntity:_checkUseSpiritInvocation()
	local unit = self.unit

	if unit then
		local charactor = BattleModel.instance:getCharactorById(unit.teamId, unit.id)

		if charactor and checkbool(charactor.isSpiritInvocationSummonPet) == true then
			unit.attrs:setUsingSpiritInvocation(true)
			unit:hideUIAndShadow(true)

			local masterCharactor = BattleModel.instance:getCharactorById(unit.teamId, charactor.spiritInvocationMasterPetId)

			GlobalDispatcher:dispatch(GlobalNotify.OnUseSpiritInvocationSkillStart, unit, masterCharactor.curFaceId)
		end
	end
end

function UnitBattleEntity:pauseSkill()
	if self._cameraMotions then
		for k, v in pairs(self._cameraMotions) do
			v:pause()
		end
	end

	self.skillList:pause()
end

function UnitBattleEntity:resumeSkill()
	if self._cameraMotions then
		for k, v in pairs(self._cameraMotions) do
			v:resume()
		end
	end

	self.skillList:resume()
end

function UnitBattleEntity:stopSkill()
	if self._cameraMotions then
		for k, v in pairs(self._cameraMotions) do
			v:stopSkill()
		end
	end

	return self.skillList:stopSkill()
end

function UnitBattleEntity:addBuff(buffId)
	self.buffList:addBuff(buffId)
	self.unitUI:addBuff(buffId)
end

function UnitBattleEntity:removeBuffById(buffId)
	self.buffList:removeBuffById(buffId)
	self.unitUI:removeBuffById(buffId)
end

function UnitBattleEntity:playAnimation(skill)
	self.skillPlayer:playAnimation(skill)
end

function UnitBattleEntity:stopAnimation()
	if self._cameraMotions then
		for k, v in pairs(self._cameraMotions) do
			v:stopSkill()
		end
	end

	self.skillPlayer:stopAnimation()
end

function UnitBattleEntity:onDamaged(damageEvt)
	self.buffPerform:invalidPerformeds()
	self.attrs:addCurHp(damageEvt.damage)
	self.attrs:addCurTempHp(damageEvt.damage)

	if not isCritical then
		self.unitUI:onDamaged(damageEvt)
	else
		self.unitUI:onCritialDamaged(damageEvt)
	end
end

function UnitBattleEntity:onDamagedTotal(damageEvt, treat)
	if not treat then
		self.unitUI:onDamagedTotal(damageEvt)
	else
		self.unitUI:onTreatedTotal(damageEvt)
	end
end

function UnitBattleEntity:onUpdateAwakenSkillStatus()
	self.unitUI:onUpdateAwakenSkillStatus()
end

function UnitBattleEntity:setVigour(vigour)
	self.attrs:setCurVigour(vigour)
	self.unitUI:onVigour(vigour)
	self:_checkVigour()
end

function UnitBattleEntity:onVigour(vigour)
	self.attrs:addCurVigour(vigour)
	self.unitUI:onVigour(vigour)
	self:_checkVigour()
end

function UnitBattleEntity:onShieldChange(changeValue, isAttack, isShow)
	self.attrs:addCurShield(changeValue)
	self.unitUI:onShieldChange(changeValue, isShow)
end

function UnitBattleEntity:onTreated(damageEvt)
	self.buffPerform:invalidPerformeds()

	if self:isDead() then
		self.buffList:onRelive()
	end

	local treat = damageEvt.damage
	local remain = self.attrs:getMaxHp() - self.attrs:getCurHp()

	if remain < treat then
		treat = remain
	end

	self.attrs:addCurHp(treat)
	self.attrs:addCurTempHp(treat)
	self.unitUI:onTreated(treat)
end

function UnitBattleEntity:updateBattleInfoType(type)
	self.unitUI:updateBattleInfoType(type)
end

function UnitBattleEntity:onBuffDamage(buffId, damage)
	if damage > 0 then
		if self:isDead() then
			self.buffList:onRelive()
		end

		local remain = self.attrs:getMaxHp() - self.attrs:getCurHp()

		if remain < damage then
			damage = remain
		end
	end

	self.attrs:addCurHp(damage)
	self.buffPerform:checkInvalidPerformeds(damage)
	self.buffPerform:onBuffToggle(buffId, damage)
end

function UnitBattleEntity:clearBuffDamages()
	self.buffPerform:clearBuffDamages()
end

function UnitBattleEntity:onBuffVigour(buffId, vigour)
	self.attrs:addCurVigour(vigour)
	self.unitUI:onBuffVigour(buffId, vigour)
	self:_checkVigour()
end

function UnitBattleEntity:onDodge()
	self.buffList:onDodge()

	local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

	if dirTeamId == GameEnum.BattleTeam.Left then
		self:onRepeling(10, 100, -1, 0, 0, false)
	else
		self:onRepeling(10, 100, 1, 0, 0, false)
	end
end

function UnitBattleEntity:onImmunity()
	self.buffList:onImmunity()
end

function UnitBattleEntity:onBlock()
	self.buffList:onBlock()
end

function UnitBattleEntity:onRepeling(repeling, repelingSpeed, repelingDX, repelingDY, repelingDZ, playHit)
	self.buffList:onRepeling(repeling, repelingSpeed, repelingDX, repelingDY, repelingDZ, playHit)
end

function UnitBattleEntity:onHitFly(hitfly)
	self.buffList:onHitFly(hitfly)
end

function UnitBattleEntity:onHard()
	if self.attrs:isFrozen() then
		return
	end

	self.buffList:onHard()
end

function UnitBattleEntity:onAnimation(animation)
	self.buffList:onAnimation(animation)
end

function UnitBattleEntity:onItemUsable(itemId)
	self.buffList:onItemUsable(itemId)
end

function UnitBattleEntity:stopItemUsable()
	self.buffList:stopItemUsable()
end

function UnitBattleEntity:onWaitingItemUsing(itemId)
	return
end

function UnitBattleEntity:stopWaitingItemUsing()
	return
end

function UnitBattleEntity:onItemUseSuccess(itemId)
	self:stopWaitingItemUsing()
	self.buffList:onItemUseSuccess(itemId)
end

function UnitBattleEntity:onItemUseFailed(itemId)
	self:stopWaitingItemUsing()
	self.buffList:onItemUseFailed(itemId)
end

function UnitBattleEntity:onCatchedSuccess(itemId)
	self:stopWaitingItemUsing()
	self.buffList:removeAll(true)
	self.buffList:onCatchPerformed(itemId, true)
end

function UnitBattleEntity:onCatchedFailed(itemId)
	self:stopWaitingItemUsing()
	self.buffList:onCatchPerformed(itemId, false)
end

function UnitBattleEntity:resetBirthPos()
	local bx, by, bz = self.attrs:getBirthPoint()

	self.transform:setPos(bx, by, bz)
end

function UnitBattleEntity:onStartAttack()
	self.buffList:onStartAttack()
end

function UnitBattleEntity:onDead()
	self.buffList:onDead()
end

function UnitBattleEntity:onBirth()
	self.buffList:onBirth()
end

function UnitBattleEntity:onDomainChange(skillId, skillLevel)
	self.buffList:onDomainChange(skillId, skillLevel)
end

function UnitBattleEntity:onTriggerTransPosition(skillId, targetTeamId, changes)
	self.buffList:onTriggerTransPosition(skillId, targetTeamId, changes)
end

function UnitBattleEntity:onTransPosition(newX, newY)
	if newX == self.x and newY == self.y then
		return
	end

	self.buffList:onTransPosition(newX, newY)
end

function UnitBattleEntity:onTransPositionList(posArr)
	self.buffList:onTransPositionList(posArr)
end

function UnitBattleEntity:onTransform(modelId, raceId, norSkill, utlSkill, attrs, isPsychicTransform)
	local oldModelId = self.modelId

	self.modelId = modelId
	self.raceId = raceId
	self.isPsychicTransform = isPsychicTransform

	local skinName = PetSkinConfig.instance:getPetSkinName(modelId)

	self.attrs:setName(skinName)
	self.attrs:setAttributes(attrs)

	local infoType = BattleModel.instance:getBtlInfoType()

	self:updateBattleInfoType(infoType)

	local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(modelId, 1)

	if skillInfocfg == nil and enableDebug then
		printError(">>>>>>>>>>>>>>>>>>>>>>>>>>这个ID 找不到配置 ！！！： ", modelId)
	end

	local passiveSkillId = checknumber(skillInfocfg.passiveSkillId)
	local petCO = PetSkinConfig.instance:getPetSkinCfg(modelId)

	self.skillList:replcePassiveSkill(passiveSkillId)
	self.skillList:replceHeroSkill(petCO.heroSkillId)
	self.skillList:replceNormalSkill(norSkill)
	self.skillList:replceUtlSkill(utlSkill)

	local skillCfg = BattleConfig.instance:getSkillCo(utlSkill, modelId)

	if skillCfg then
		self.attrs:setMaxVigour(checknumber(skillCfg.needVigour))
		self:_checkVigour()
	end

	if oldModelId ~= self.modelId then
		self.buffList:onTransform(modelId)
	end
end

function UnitBattleEntity:onCarriedChange(modelId, raceId, target, carriedPetCharacterView)
	local oldModelId = self.modelId

	self.modelId = carriedPetCharacterView.curFaceId
	self.raceId = carriedPetCharacterView.raceId

	local infoType = BattleModel.instance:getBtlInfoType()

	self:updateBattleInfoType(infoType)

	local characterView = BattleModel.instance:getCharactorById(self.teamId, self.id)

	if characterView then
		characterView.isCarriedMaster = false
	end

	self.buffList:removeAllServerBuff()
	self.unitUI:removeAllBuff()

	local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(modelId, 1)
	local petCO = PetSkinConfig.instance:getPetSkinCfg(modelId)

	self.skillList:replcePassiveSkill(carriedPetCharacterView.passiveSkillId)
	self.skillList:replceHeroSkill(petCO.heroSkillId)
	self.skillList:replceNormalSkill(carriedPetCharacterView.normalSkillId)
	self.skillList:replceUtlSkill(carriedPetCharacterView.ultimateSkillId)
	self.skillList:replceCarriedSkill(checknumber(petCO.carriedSkillId))
	self.skillList:replceOracleSkillId(checknumber(petCO.oracleSkillId))

	local skillCfg = BattleConfig.instance:getSkillCo(carriedPetCharacterView.ultimateSkillId, modelId)

	if skillCfg then
		self.attrs:setMaxVigour(checknumber(skillCfg.needVigour))
		self:_checkVigour()
	end

	self.buffList:removeAllServerBuff()
	self.unitUI:removeAllBuff()

	if carriedPetCharacterView and carriedPetCharacterView.buffIds and #carriedPetCharacterView.buffIds > 0 then
		for i = 1, #carriedPetCharacterView.buffIds do
			self:addBuff(carriedPetCharacterView.buffIds[i])
		end
	end

	if oldModelId ~= self.modelId then
		local effId = checknumber(petCO.carriedBuffEffId)

		self.buffList:onTransform(modelId, effId)
	end

	if carriedPetCharacterView then
		self:updateAttrs(carriedPetCharacterView)
	end
end

function UnitBattleEntity:updateAttrs(playerView)
	self.attrs:setCurShield(checknumber(playerView.shield))
	self.attrs:setMaxHp(checknumber(playerView.maxHp))
	self.attrs:setCurHp(checknumber(playerView.curHp))
	self.attrs:setCurTempHp(checknumber(playerView.curHp))

	local petCO = CharacterConfig.instance:getPetCo(self.raceId)
	local skillCfg = BattleConfig.instance:getSkillCo(playerView.ultimateSkillId, self.modelId)

	self.attrs:setMaxVigour(checknumber(skillCfg.needVigour))
	self.attrs:setOriginSkinId(self.modelId)
	self.attrs:setFightingPower(checknumber(playerView.zdl))
	self:setVigour(checknumber(playerView.curVigour))
	self.attrs:setName(PetSkinConfig.instance:getPetSkinName(self.modelId))
	self.attrs:setCatchable(playerView.enableCatched)
	self.attrs:setLevel(checknumber(playerView.lv))
	self.attrs:setAwakenLv(checknumber(playerView.awakenLv))
	self.attrs:setAttributes(playerView.attributes)
	self.unitUI:setHpValue(checknumber(playerView.curHp), checknumber(playerView.maxHp))
end

function UnitBattleEntity:onMaxHpChange(oldCurValue, oldMaxValue, newCurValue, newMaxValue)
	self.buffPerform:invalidPerformeds()
	self.attrs:setMaxHp(newMaxValue)
	self.attrs:setCurHp(newCurValue)
	self.attrs:setCurTempHp(newCurValue)

	if oldCurValue < newCurValue then
		if self:isDead() then
			self.buffList:onRelive()
		end

		self.unitUI:onTreated(newCurValue - oldCurValue)
	end
end

function UnitBattleEntity:haveBeenSummoned()
	if self.attrs:isSummonedCharacter() and not self.attrs:isHaveBeenSummoned() then
		return false
	end

	return true
end

function UnitBattleEntity:haveBeenTJSummoned()
	if self.attrs:isTJSummonedCharacter() and not self.attrs:isHaveBeenTJSummoned() then
		return false
	end

	return true
end

function UnitBattleEntity:onTJSummonMonster()
	return
end

function UnitBattleEntity:onSummonMonster()
	return
end

function UnitBattleEntity:onSummoned(summoned, isBuff)
	self.attrs:setHaveBeenSummoned(summoned)

	if summoned then
		self:setVisible(true)
		self.buffList:onSummoned()
	else
		self:setVisible(false)
	end
end

function UnitBattleEntity:onUnitChataterCreate(playerView)
	self.isShowedEnterSkill = true
	self.isBorn = true

	if playerView.isSummonedCharacter then
		self:onSummoned(playerView.isHaveBeenSummoned)
	elseif playerView.oracleMasterId and playerView.oracleMasterId > 0 then
		-- block empty
	elseif playerView.isDoppelganger then
		self:onDoppelgangered(playerView.isHaveBeenDoppelgangerCreated)
	elseif playerView.isHeavenAwakenSummonedCharacter then
		self:onTJSummoned(playerView.isHeavenAwakenSummoned)
	elseif playerView.isSpiritInvocationSummonPet then
		-- block empty
	else
		self:setVisible(true)

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.modelId)

		if skinCfg and checknumber(skinCfg.enterSkillId) > 0 then
			local skip = false

			if self.teamId == GameEnum.BattleTeam.Right then
				skip = BattleModel.instance:getOnlyShowSelfShenHuaEnter()
			end

			local key = string.format("PJAQM_SH_SKILL_PLAYED_%s", self.modelId)
			local isPlayed = GameUtil.getUserDayData(key) ~= nil

			if BattleModel.instance:getAutoSkipShenHuaEnter() == true then
				skip = skip or isPlayed
			end

			if PetskinModel.instance:getUnEnableEnterEffect(self.modelId) == true then
				skip = true
			end

			self.isShowedEnterSkill = skip

			if not skip then
				self:setAlpha(0)
				self:_updateAlpha()
				self.unitUI:setVisible(false)
				self.shadow:setActive(false)
				self.buffList:setVisible(false)
			end

			if not skip and not isPlayed then
				local key = string.format("PJAQM_SH_SKILL_PLAYED_%s", self.modelId)

				GameUtil.saveUserDayData(key, true)
			end
		end
	end
end

function UnitBattleEntity:onTJSummoned(summoned)
	self.attrs:setHaveBeenTJSummoned(summoned)

	if summoned then
		self:setVisible(true)
		self.buffList:onTJSummoned()
	else
		self:setVisible(false)
	end
end

function UnitBattleEntity:onDoppelganger()
	return
end

function UnitBattleEntity:onDoppelgangered(isHaveBeenDoppelgangerCreated, isBuff)
	self.attrs:setHaveBeenDoppelgangerCreated(isHaveBeenDoppelgangerCreated)

	if isHaveBeenDoppelgangerCreated then
		self:setVisible(true)
		self.buffList:onDoppelgangered()
	else
		self:setVisible(false)
	end
end

function UnitBattleEntity:onPsychicSkillFight(newView)
	return
end

function UnitBattleEntity:onAttrTransform(curAttributes)
	self.attrs:setAttributes(curAttributes)
end

function UnitBattleEntity:onSkillLocking(skill)
	self.buffList:onSkillLocking(skill)
end

function UnitBattleEntity:removeSkillLocking()
	self.buffList:removeSkillLocking()
end

function UnitBattleEntity:onVigourMax()
	self.buffList:onVigourMax()
end

function UnitBattleEntity:removeVigourMax()
	self.buffList:removeVigourMax()
end

function UnitBattleEntity:onUseUtlSkill()
	self.buffList:onUseUtlSkill()
end

function UnitBattleEntity:removeUseUtlSkill()
	self.buffList:removeUseUtlSkill()
end

function UnitBattleEntity:onStrickBack()
	self.buffList:onStrickBack()
end

function UnitBattleEntity:removeStrickBack()
	self.buffList:removeStrickBack()
end

function UnitBattleEntity:onCantExecuteSkill()
	self.unitUI:onCantExecuteSkill()
end

function UnitBattleEntity:isPerformingHuds()
	return self.unitUI:isPerformingHuds() or self.buffPerform:hasBuffDamages()
end

function UnitBattleEntity:setCurrLayer(currLayer)
	self._currLayer = currLayer or self:getLayer()
end

function UnitBattleEntity:getCurrLayer()
	return self._currLayer or self:getLayer()
end

function UnitBattleEntity:onSkillCamera(isHide)
	if goutil.isNil(self.go) then
		return
	end

	local spine = self.spine:getInst()
	local billboard

	if not goutil.isNil(spine) then
		billboard = Billboard.Get(spine)
	end

	if isHide then
		self:setCurrLayer(SceneLayer.SkillAnimation_Value)
		Framework.GameObjectUtil.SetLayerRecursively(self.go, SceneLayer.SkillAnimation_Value)

		if billboard then
			billboard:SetFollowObject(GlobalModel.instance.skillCamera.gameObject)
		end
	else
		local goLayer = self.go.layer

		if goLayer == SceneLayer.SkillAnimation_Value or goLayer == SceneLayer.Invisible_Value and self.attrs:isInvisible() then
			self:setCurrLayer(self:getLayer())

			if goLayer ~= SceneLayer.Invisible_Value or not self.attrs:isInvisible() then
				Framework.GameObjectUtil.SetLayerRecursively(self.go, self:getLayer())
			end
		end

		if billboard then
			billboard:SetFollowObject(GlobalModel.instance.mainCamera.gameObject)
		end
	end

	self.unitUI:onSkillCamera(isHide)
end

function UnitBattleEntity:onTweenColor(hide, time)
	if not goutil.isNil(self._spineIns) then
		AMFadeObjectColor.StartSharedFade(self._spineIns)
	end

	self.unitUI:onFade(hide, time)
end

function UnitBattleEntity:startSkillCameraMotion(go, targets, param, disableRotationTrack)
	self:stopSkillCameraMotion(go.name)

	if not disableRotationTrack then
		self._cameraMotions = self._cameraMotions or {}

		local cameraMotion = SkillAnimationMotion.New(self, go, param)

		self._cameraMotions[go.name] = cameraMotion

		cameraMotion:playAnimation(targets)
	else
		Framework.TransformUtil.SetLocalPos(go.transform, BattleSceneCamera.cameraSkillPosX, BattleSceneCamera.cameraSkillPosY, BattleSceneCamera.cameraSkillPosZ)
		Framework.TransformUtil.SetLocalRotation(go.transform, BattleSceneCamera.cameraSkillRotX, 0, 0)
	end
end

function UnitBattleEntity:stopSkillCameraMotion(name)
	if self._cameraMotions then
		local mition = self._cameraMotions[name]

		if mition then
			mition:stop()

			self._cameraMotions[name] = nil
		end
	end
end

function UnitBattleEntity:onFadeSkillCameara(hide)
	if not goutil.isNil(self._spineIns) then
		AMFadeObject.StartSharedFade(self._spineIns)
	end

	self.unitUI:onFadeSkillCameara(hide)

	if hide then
		self._isTransparent = true

		self.buffList:setVisible(false)
		self.shadow:setActive(false)
	else
		self._isTransparent = nil

		self.buffList:setVisible(true)
		self.shadow:setActive(true)
	end
end

function UnitBattleEntity:onFadeColorHide(hide, time)
	if not goutil.isNil(self._spineIns) then
		AMFadeObject.StartSharedFade(self._spineIns)
	end

	self.unitUI:onFade(hide, time)

	if hide then
		self._isTransparent = true

		self.buffList:setVisible(false)
		self.shadow:setActive(false)
	else
		self._isTransparent = nil

		self.buffList:setVisible(true)
		self.shadow:setActive(true)
	end
end

function UnitBattleEntity:onPlaySkillAnim(duration)
	self._skillAnimDuration = duration
	self._isPlayingSkillAnim = self._skillAnimDuration > 0 and true or nil
end

function UnitBattleEntity:onPlaySkillAnimSkipToFrame(deltaTime)
	if self._isPlayingSkillAnim then
		self:_updatePlayingSkillAnim(deltaTime)
	end

	if self._cameraMotions then
		for k, v in pairs(self._cameraMotions) do
			v:update(deltaTime)
		end
	end
end

function UnitBattleEntity:notifyBulletHitFinished(idx)
	self.skillPlayer:notifyBulletHitFinished(idx)
end

function UnitBattleEntity:onStartFakeFmt(cam, x, y, z, scale, layer, flip)
	self.attrs:setFakingFmt(true)

	if goutil.isNil(self.go) then
		return
	end

	self.transform:setPos(x, y, z)
	Framework.TransformUtil.SetLocalScale(self.go.transform, scale, scale, scale)

	self._fakeSaveLayer = self._fakeSaveLayer or self.go.layer

	local cullingLayer = GoUtil.GetCameraCullingLayer(cam)

	Framework.GameObjectUtil.SetLayerRecursively(self.go, cullingLayer)
	self:setCurrLayer(cullingLayer)

	self._fakeLayer = cullingLayer

	local billboard
	local spine = self.spine:getInst()

	if not goutil.isNil(spine) then
		billboard = Billboard.Get(spine)
	end

	if billboard then
		billboard:SetFollowObject(cam.gameObject)
	end

	local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

	if flip and dirTeamId == GameEnum.BattleTeam.Left and (self.go.layer == SceneLayer.SkillEffects_Value or self.go.layer == SceneLayer.SkillEffects_II_Value) then
		self:invertDirection()
	end

	self.unitUI:onStartFakeFmt(cam)
end

function UnitBattleEntity:onStopFakeFmt()
	self.attrs:setFakingFmt(false)

	if goutil.isNil(self.go) then
		return
	end

	if self.fmtIndex ~= -1 then
		local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)
		local pos = BattleConfig.instance:getFormationPos(dirTeamId + 1, self.fmtIndex)

		self.transform:setPos(pos[1], pos[2], pos[3])
	else
		local bx, by, bz = self.attrs:getBirthPoint()

		self.transform:setPos(bx, by, bz)
	end

	Framework.TransformUtil.SetLocalScale(self.go.transform, 1, 1, 1)

	if self._fakeLayer == self.go.layer then
		local billboard
		local spine = self.spine:getInst()

		if not goutil.isNil(spine) then
			billboard = Billboard.Get(spine)
		end

		if billboard then
			billboard:SetFollowObject(GlobalModel.instance.mainCamera.gameObject)
		end

		self:setCurrLayer(self._fakeSaveLayer)
		Framework.GameObjectUtil.SetLayerRecursively(self.go, self._fakeSaveLayer)
	end

	self._fakeSaveLayer = nil
	self._fakeLayer = nil

	local dirTeamId = BattleModel.instance:getTeamDirection(self.teamId)

	if dirTeamId == GameEnum.BattleTeam.Left then
		self:resumeDirection()
	end

	self.unitUI:onStopFakeFmt()
end

function UnitBattleEntity:onHagPointFollowBone(follow)
	if follow then
		self:_saveHagPointLocalPos()

		if self._headFollowBoneExist then
			GoUtil.StartFollowBone(self.mountPointHead, self._spineIns, spineHeadPointBone)
		end

		if self._centerFollowBoneExist then
			GoUtil.StartFollowBone(self.mountPointCenter, self._spineIns, spineCenterPointBone)
		end

		if self._footFollowBoneExist then
			GoUtil.StartFollowBone(self.mountPointFoot, self._spineIns, spineFootPointBone)
			GoUtil.StartFollowBone(self.effectPoint, self._spineIns, spineFootPointBone)
		end

		if self._frontFollowBoneExist then
			GoUtil.StartFollowBone(self.mountPointFront, self._spineIns, spineFrontPointBone)
		end

		self._isFollowingBone = true
	else
		self._isFollowingBone = nil

		GoUtil.StopFollowBone(self.mountPointFoot)
		GoUtil.StopFollowBone(self.effectPoint)
		GoUtil.StopFollowBone(self.mountPointFoot)
		GoUtil.StopFollowBone(self.mountPointHead)
		GoUtil.StopFollowBone(self.mountPointFront)
		self:_resumeHagPointLocalPos()
	end
end

function UnitBattleEntity:isTouchHitTarget(bounds, deltaX, deltaY)
	if goutil.isNil(self.go) then
		return
	end

	local spineIns = self.spine:getInst()

	if goutil.isNil(spineIns) then
		return
	end

	local mainCamera = self:getUnitCamera()
	local posX, posY, posZ = Framework.TransformUtil.GetPos(self.go.transform, nil, nil, nil)
	local wx, wy, wz = UGUIToolHelper.ScreenToUnityPosition(mainCamera, posX, posY, posZ, nil, nil, nil)
	local collider = spineIns:GetComponent(typeof(UnityEngine.BoxCollider))

	if not collider then
		return false
	end

	local size = collider.size
	local center = collider.center
	local sizeX = math.min(10, size.x) * 0.5
	local sizeY = math.min(10, size.y) * 0.5
	local centerX = center.x + posX
	local centerY = center.y + posY

	deltaX = deltaX or 0
	deltaY = deltaY or 0

	GameUtil.getBounds(centerX - sizeX - deltaX, centerY - sizeY - deltaY, 0, centerX + sizeX + deltaX, centerY + sizeY + deltaY, 0, bounds)

	if GameUtil.isBoundsContains(bounds, wx, wy, 0) then
		return true
	end
end

function UnitBattleEntity:getUnitCamera()
	if goutil.isNil(self.go) then
		return
	end

	local unitLayer = self.go.layer
	local mainCamera

	if unitLayer == SceneLayer.SkillAnimation_Value then
		mainCamera = GlobalModel.instance.skillCamera
	elseif unitLayer == SceneLayer.SkillEffects_Value or unitLayer == SceneLayer.SkillEffects_II_Value then
		local cameras = AMMirrorCamera.mirrorCameras

		if cameras.Count > 0 then
			for i = 0, cameras.Count - 1 do
				mainCamera = cameras[i]:GetCamera()

				if mainCamera.gameObject.activeSelf then
					break
				end
			end
		end
	else
		mainCamera = GlobalModel.instance.mainCamera
	end

	return mainCamera
end

function UnitBattleEntity:getUnitScreenPos(mountName)
	local mountPoint = self:getHangPoint(mountName)
	local pos = mountPoint.transform.position
	local mainCamera = self:getUnitCamera()

	return (mainCamera:WorldToScreenPoint(pos))
end

function UnitBattleEntity:_saveHagPointLocalPos()
	local centerX, centerY, centerZ = Framework.TransformUtil.GetLocalPos(self.mountPointCenter, nil, nil, nil)
	local footX, footY, footZ = Framework.TransformUtil.GetLocalPos(self.mountPointFoot, nil, nil, nil)
	local headX, headY, headZ = Framework.TransformUtil.GetLocalPos(self.mountPointHead, nil, nil, nil)
	local effX, effY, effZ = Framework.TransformUtil.GetLocalPos(self.effectPoint, nil, nil, nil)
	local frontX, frontY, frontZ = Framework.TransformUtil.GetLocalPos(self.mountPointFront, nil, nil, nil)

	self._hagPointPos = {}
	self._hagPointPos[UnitConst.spineCenterPointPath] = {
		centerX,
		centerY,
		centerZ
	}
	self._hagPointPos[UnitConst.spineFootPointPath] = {
		footX,
		footY,
		footZ
	}
	self._hagPointPos[UnitConst.spineHeadPointPath] = {
		headX,
		headY,
		headZ
	}
	self._hagPointPos[UnitConst.effectPointPath] = {
		effX,
		effY,
		effZ
	}
	self._hagPointPos[UnitConst.spineFrontPointPath] = {
		frontX,
		frontY,
		frontZ
	}
end

function UnitBattleEntity:_resumeHagPointLocalPos()
	if self._hagPointPos then
		local centerPos = self._hagPointPos[UnitConst.spineCenterPointPath]
		local headPos = self._hagPointPos[UnitConst.spineHeadPointPath]
		local footPos = self._hagPointPos[UnitConst.spineFootPointPath]
		local frontPos = self._hagPointPos[UnitConst.spineFrontPointPath]
		local effPos = self._hagPointPos[UnitConst.effectPointPath]
		local centerX, centerY, centerZ = centerPos[1], centerPos[2], centerPos[3]
		local footX, footY, footZ = footPos[1], footPos[2], footPos[3]
		local headX, headY, headZ = headPos[1], headPos[2], headPos[3]
		local effX, effY, effZ = effPos[1], effPos[2], effPos[3]
		local frontX, frontY, frontZ = frontPos[1], frontPos[2], frontPos[3]

		Framework.TransformUtil.SetLocalPos(self.mountPointCenter.transform, centerX, centerY, centerZ)
		Framework.TransformUtil.SetLocalPos(self.mountPointFoot.transform, footX, footY, footZ)
		Framework.TransformUtil.SetLocalPos(self.mountPointHead.transform, headX, headY, headZ)
		Framework.TransformUtil.SetLocalPos(self.effectPoint.transform, effX, effY, effZ)
		Framework.TransformUtil.SetLocalPos(self.mountPointFront.transform, frontX, frontY, frontZ)

		self._hagPointPos = nil
	end
end

function UnitBattleEntity:_checkVigour()
	if self.attrs:getCurVigour() >= self.attrs:getMaxVigour() then
		self:onVigourMax()
		self.unitUI:playVigourMaxEffect()
	else
		self:removeVigourMax()
		self.unitUI:stopVigourMaxEffect()
	end
end

return UnitBattleEntity
