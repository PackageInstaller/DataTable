-- chunkname: @modules/logic/fight/entity/comp/FightNameUI.lua

module("modules.logic.fight.entity.comp.FightNameUI", package.seeall)

local FightNameUI = class("FightNameUI", FightBaseClass)

function FightNameUI:onConstructor(entity)
	self.entity = entity
	self._entity = entity
	self._nameUIActive = true
	self._nameUIVisible = true
	self.buffMgr = FightNameUIBuffMgr.New()
	self._power = FightNameUIPower.New(self, 1)
	self._hpKillLineComp = FightHpKillLineComp.New(FightHpKillLineComp.KillLineType.NameUiHp)

	if FightDataHelper.fieldMgr:isRouge2() then
		self.rouge2RevivalComp = FightRouge2RevivalComp.New()
	end

	self.hideKeyDict = {}
end

function FightNameUI:load(url)
	if self.entity.isTempEntity then
		return
	end

	if self._uiLoader then
		self._uiLoader:dispose()
	end

	self._containerGO = gohelper.create2d(FightNameMgr.instance:getNameParent(), self.entity:getMO():getIdName())
	self._floatContainerGO = gohelper.create2d(self._containerGO, "float")

	FightNameMgr.instance:register(self)

	self._uiLoader = PrefabInstantiate.Create(self._containerGO)

	self._uiLoader:startLoad(url, self._onLoaded, self)
	self:checkLoadHealth()
end

function FightNameUI:checkLoadHealth()
	local curHealth = FightHelper.getSurvivalEntityHealth(self.entity.id)

	if not curHealth then
		return
	end

	self.healthComp = FightNameUIHealthComp.Create(self.entity, self._containerGO)
end

function FightNameUI:setActive(isActive, key)
	self:buildKey(isActive, key)

	if self._curHp and self._curHp <= 0 then
		self._nameUIActive = false
	else
		self._nameUIActive = true

		for _, _ in pairs(self.hideKeyDict) do
			self._nameUIActive = false

			break
		end
	end

	self:_doSetActive()
end

function FightNameUI:buildKey(isActive, key)
	key = key or FightNameActiveKey.DefaultKey

	if isActive then
		if self.hideKeyDict[key] then
			self.hideKeyDict[key] = nil
		end
	else
		self.hideKeyDict[key] = true
	end
end

function FightNameUI:playDeadEffect()
	self:_playAni("die")
end

function FightNameUI:playOpenEffect()
	self:_playAni(UIAnimationName.Open)
end

function FightNameUI:playCloseEffect()
	self:_playAni("close")
end

function FightNameUI:_playAni(name)
	if self._ani then
		self._ani:Play(name, 0, 0)

		self._ani.speed = FightModel.instance:getSpeed()
	end
end

function FightNameUI:_setIsShowNameUI(isVisible, entitys)
	local isTarget = false

	if not entitys then
		isTarget = true
	else
		for i, entity in ipairs(entitys) do
			if entity.id == self.entity.id then
				isTarget = true

				break
			end
		end
	end

	if isTarget then
		self._nameUIVisible = isVisible

		self:_doSetActive()
	end
end

function FightNameUI:_doSetActive()
	local uiObj = self:getUIGO()

	if gohelper.isNil(uiObj) then
		return
	end

	if self._nameUIActive then
		local active = self._nameUIVisible

		if self.entity:getMO():hasBuffFeature(FightEnum.BuffType_HideLife) then
			active = false
		end

		if FightDataHelper.tempMgr.hideNameUIByTimeline then
			active = false
		end

		if not gohelper.isNil(self._uiCanvasGroup) then
			if active then
				recthelper.setAnchor(self:getUIGO().transform, self._originPosOffsetX or 0, self._originPosOffsetY or 0)
			else
				recthelper.setAnchor(self:getUIGO().transform, 20000, 20000)
			end
		end

		if active and self._uiFollower then
			self._uiFollower:ForceUpdate()
		end
	end
end

function FightNameUI:getAnchorXY()
	if self._uiTransform then
		local x, y = recthelper.getAnchor(self._uiTransform, 0, 0)

		return recthelper.getAnchor(self._uiTransform, 0, 0)
	end

	return 0, 0
end

function FightNameUI:getFloatContainerGO()
	return self._floatContainerGO
end

function FightNameUI:getGO()
	return self._containerGO
end

function FightNameUI:getUIGO()
	return self._uiGO
end

function FightNameUI:_onLoaded()
	self:com_registMsg(FightMsgId.GetHpFillAmount, self.onGetHpFillAmount)
	gohelper.setAsLastSibling(self._floatContainerGO)

	self._uiGO = self._uiLoader:getInstGO()
	self.entityView = FightEntityView.New(self.entity.id, self._uiGO)
	self._uiTransform = self._uiGO.transform
	self._uiCanvasGroup = gohelper.onceAddComponent(self._uiGO, typeof(UnityEngine.CanvasGroup))
	self._txtName = gohelper.findChildText(self._uiGO, "layout/top/Text")

	self:_doSetActive()

	self._gohpbg = gohelper.findChild(self._uiGO, "layout/hp/container/bg")
	self._gochoushibg = gohelper.findChild(self._uiGO, "layout/hp/container/choushibg")
	self._imgHpMinus = gohelper.findChildImage(self._uiGO, "layout/hp/container/minus")

	local isMySide = self.entity:isMySide()
	local imgMyHp = gohelper.findChildImage(self._uiGO, "layout/hp/container/my")
	local imgEnemyHp = gohelper.findChildImage(self._uiGO, "layout/hp/container/enemy")

	gohelper.setActive(imgMyHp.gameObject, isMySide)
	gohelper.setActive(imgEnemyHp.gameObject, not isMySide)

	self.fictionHp = gohelper.findChildImage(self._uiGO, "layout/hp/container/xuxue")
	self.fakeHp = gohelper.findChildImage(self._uiGO, "layout/hp/container/fakehp")
	self._hpGo = gohelper.findChild(self._uiGO, "layout/hp")
	self._hp_ani = gohelper.findChild(self._uiGO, "layout/hp"):GetComponent(typeof(UnityEngine.Animator))
	self._hp_container_tran = gohelper.findChild(self._uiGO, "layout/hp/container").transform
	self._imgHp = isMySide and imgMyHp or imgEnemyHp
	self._imgHpShield = gohelper.findChildImage(self._uiGO, "layout/hp/container/shield")
	self._txtHp = gohelper.findChildText(self._uiGO, "layout/hp/Text")
	self._reduceHp = gohelper.findChild(self._uiGO, "layout/hp/container/reduce")
	self._reduceHpImage = self._reduceHp:GetComponent(gohelper.Type_Image)

	self:resetHp()

	self._imgCareerIcon = gohelper.findChildImage(self._uiGO, "layout/top/imgCareerIcon")
	self.careerTopRectTr = gohelper.findChildComponent(self._uiGO, "layout/top/imgCareerIcon/careertoppos", gohelper.Type_RectTransform)

	self:initExPointMgr()
	self:initStressMgr()
	self._hpKillLineComp:init(self.entity.id, self._hpGo)

	if self.rouge2RevivalComp then
		self.rouge2RevivalComp:init(self.entity.id, self._uiGO.transform.parent.gameObject)
	end

	self:initPowerMgr()
	self:initWeaknessMgr()
	self:initToughnessMgr()
	self:initToughnessIconMgr()
	self:initYaMiShieldMgr()
	self:initMeiLeiErMgr()

	self._opContainerGO = gohelper.findChild(self._uiGO, "layout/top/op")
	self._opContainerTr = self._opContainerGO.transform
	self._buffContainerGO = gohelper.findChild(self._uiGO, "layout/top/buffContainer")
	self._buffGO = gohelper.findChild(self._uiGO, "layout/top/buffContainer/buff")

	self.buffMgr:init(self.entity, self._buffGO, self._opContainerTr)
	gohelper.setActive(gohelper.findChild(self._uiGO, "#go_Shield"), false)

	if FightModel.instance:isSeason2() then
		local entityMo = self.entity:getMO()

		if entityMo.guard ~= -1 then
			self._seasonGuard = FightNameUISeasonGuard.New(self)

			self._seasonGuard:init(gohelper.findChild(self._uiGO, "#go_Shield"))
		end
	end

	self._ani = self._uiGO:GetComponent(typeof(UnityEngine.Animator))
	self._goBossFocusIcon = gohelper.findChild(self._uiGO, "go_bossfocusicon")

	gohelper.setActive(self._goBossFocusIcon, false)
	self:updateUI()
	self:_insteadSpecialHp()
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._updateFollow)
	self:com_registFightEvent(FightEvent.BeforePlayTimeline, self._beforePlaySkill)
	self:com_registFightEvent(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._updateUIPos)
	self:com_registFightEvent(FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish)
	self:com_registFightEvent(FightEvent.OnRoundSequenceStart, self.updateUI)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self.updateActive)
	self:com_registFightEvent(FightEvent.SetIsShowFloat, self._setIsShowFloat)
	self:com_registFightEvent(FightEvent.SetIsShowNameUI, self._setIsShowNameUI)
	self:com_registFightEvent(FightEvent.OnFloatEquipEffect, self._onFloatEquipEffect)
	self:com_registFightEvent(FightEvent.OnCameraFovChange, self._updateUIPos)
	self:com_registFightEvent(FightEvent.OnMaxHpChange, self._onMaxHpChange)
	self:com_registFightEvent(FightEvent.OnCurrentHpChange, self._onCurrentHpChange)
	self:com_registFightEvent(FightEvent.MultiHpChange, self._onMultiHpChange)
	self:com_registFightEvent(FightEvent.ChangeWaveEnd, self._onChangeWaveEnd)
	self:com_registFightEvent(FightEvent.CoverPerformanceEntityData, self.onCoverPerformanceEntityData)
	self:com_registFightEvent(FightEvent.ChangeCareer, self._onChangeCareer)
	self:com_registFightEvent(FightEvent.UpdateUIFollower, self._onUpdateUIFollower)
	self:com_registFightEvent(FightEvent.ChangeShield, self._onChangeShield)
	self:com_registFightEvent(FightEvent.StageChanged, self._onStageChange)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.OnLockHpChange, self._onLockHpChange)
	self:com_registFightEvent(FightEvent.OnFakeHpChange, self._onFakeHpChange)
	self:com_registFightEvent(FightEvent.AiJiAoFakeDecreaseHp, self.onAiJiAoFakeDecreaseHp)
	self._power:onOpen()
	self:_setPosOffset()
	self:updateInnerLayout()
end

function FightNameUI:_onStageChange()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage == FightStageMgr.StageType.Operate then
		local roundData = FightDataHelper.roundMgr:getRoundData()
		local cardList = roundData and roundData:getAIUseCardMOList()

		self:refreshBossFocusIcon(cardList)
	end
end

function FightNameUI:refreshBossFocusIcon(aiCardMoList)
	if not aiCardMoList then
		gohelper.setActive(self._goBossFocusIcon, false)

		return
	end

	if self.entity then
		local entityMo = self.entity:getMO()
		local isMark = false

		if entityMo and entityMo.side == FightEnum.EntitySide.MySide then
			for _, cardMo in ipairs(aiCardMoList) do
				if self:_checkCanMark(cardMo) then
					isMark = true

					break
				end
			end
		end

		gohelper.setActive(self._goBossFocusIcon, isMark)
	end
end

function FightNameUI:_onSkillPlayFinish()
	local roundDataMgr = FightDataHelper.roundMgr
	local roundData = roundDataMgr:getPreRoundData()
	local cardList = roundData and roundData:getAIUseCardMOList()

	self:refreshBossFocusIcon(cardList)
end

function FightNameUI:_checkCanMark(cardMo)
	if not cardMo then
		return false
	end

	if cardMo.targetUid ~= self.entity.id then
		return false
	end

	local cardEntityMo = FightDataHelper.entityMgr:getById(cardMo.uid)

	if not cardEntityMo or cardEntityMo:isStatusDead() then
		return false
	end

	local aiMarkSkillCo = lua_ai_mark_skill.configDict[cardMo.skillId]

	if not aiMarkSkillCo then
		return false
	end

	return true
end

function FightNameUI:initExPointMgr()
	self._expointCtrl = FightExPointView.New(self.entity.id, self._uiGO)
end

function FightNameUI:initPowerMgr()
	self.powerView = FightNamePowerInfoView.New(self.entity.id, self._uiGO)
end

function FightNameUI:initWeaknessMgr()
	local obj = gohelper.findChild(self._uiGO, "layout/weekness")

	self.weaknessMgr = self:newClass(FightEntityWeaknessView, self.entity, obj)
end

function FightNameUI:initToughnessMgr()
	local obj = gohelper.findChild(self._uiGO, "layout/toughness")
	local monsterConfig = lua_monster.configDict[self.entity.entityData.modelId]

	if not monsterConfig then
		gohelper.setActive(obj, false)

		return
	end

	if string.nilorempty(monsterConfig.toughness) then
		gohelper.setActive(obj, false)

		return
	end

	gohelper.setActive(obj, true)

	self.toughnessMgr = self:newClass(FightNameUIToughnessView, self.entity, obj, monsterConfig)
end

function FightNameUI:initToughnessIconMgr()
	local obj = gohelper.findChild(self._uiGO, "toughnessReward")
	local monsterConfig = lua_monster.configDict[self.entity.entityData.modelId]

	if not monsterConfig then
		gohelper.setActive(obj, false)

		return
	end

	if string.nilorempty(monsterConfig.toughness) then
		gohelper.setActive(obj, false)

		return
	end

	self.toughnessIconMgr = self:newClass(FightNameUIToughnessIconMgr, self.entity, obj, monsterConfig)
end

function FightNameUI:initYaMiShieldMgr()
	self.yaMiShieldMgr = self:newClass(FightNameUIYaMiShieldMgr, self.entity, self._uiGO)
end

function FightNameUI:initMeiLeiErMgr()
	self.meiLeiErMgr = self:newClass(FightNameUIMeiLeiErMgr, self.entity, self._uiGO)
end

function FightNameUI:initStressMgr()
	local entityMo = self.entity:getMO()

	if not entityMo:hasStress() then
		return
	end

	self.stressMgr = FightNameUIStressMgr.New(self)
	self.stressGo = gohelper.findChild(self._uiGO, "#go_fightstressitem")

	self.stressMgr:initMgr(self.stressGo, self.entity)
end

function FightNameUI:onDestructor()
	self._power:releaseSelf()

	if self._seasonGuard then
		self._seasonGuard:releaseSelf()
	end

	if self.entityView then
		self.entityView:disposeSelf()
	end

	if self._expointCtrl then
		self._expointCtrl:disposeSelf()
	end

	if self.powerView then
		self.powerView:disposeSelf()
	end

	if self.stressMgr then
		self.stressMgr:beforeDestroy()
	end

	if self._enemyOperation then
		self._enemyOperation:disposeSelf()
	end

	if self.healthComp then
		self.healthComp:beforeDestroy()

		self.healthComp = nil
	end

	if self.rouge2RevivalComp then
		self.rouge2RevivalComp:beforeDestroy()

		self.rouge2RevivalComp = nil
	end

	self.buffMgr:beforeDestroy()
	self._hpKillLineComp:beforeDestroy()
	CameraMgr.instance:getCameraTrace():RemoveChangeActor(self._uiFollower)
	FightFloatMgr.instance:nameUIBeforeDestroy(self._floatContainerGO)
	self:_killHpTween()
	TaskDispatcher.cancelTask(self._onDelAniOver, self)
	FightNameMgr.instance:unregister(self)
	gohelper.destroy(self._containerGO)

	if self._uiLoader then
		self._uiLoader:dispose()

		self._uiLoader = nil
	end

	self._containerGO = nil
end

function FightNameUI:updateUI()
	local entityMO = self.entity:getMO()

	self._txtName.text = entityMO:getEntityName()

	self:_refreshCareer()
	self:_updateFollow()
	self:updateActive()
end

function FightNameUI:_refreshCareer()
	local entityMO = self.entity:getMO()
	local version = FightModel.instance:getVersion()

	if SkillEditorMgr.instance.inEditMode then
		local careerStr = "sx_icon_" .. tostring(entityMO:getCO().career)

		UISpriteSetMgr.instance:setCommonSprite(self._imgCareerIcon, careerStr, true)
	elseif version >= 2 and entityMO.career ~= 0 then
		local careerStr = "sx_icon_" .. tostring(entityMO.career)

		UISpriteSetMgr.instance:setCommonSprite(self._imgCareerIcon, careerStr, true)
	else
		local careerStr = "sx_icon_" .. tostring(entityMO:getCO().career)

		UISpriteSetMgr.instance:setCommonSprite(self._imgCareerIcon, careerStr, true)
	end
end

function FightNameUI:_onChangeCareer(entityId)
	if entityId == self.entity.id then
		self:_refreshCareer()
	end
end

function FightNameUI:_beforePlaySkill()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.ClothSkill) then
		return
	end
end

function FightNameUI:_onMySideRoundEnd()
	return
end

function FightNameUI:_onStartSequenceFinish()
	self:updateUI()
end

function FightNameUI:_onRoundSequenceFinish()
	self:updateUI()
end

function FightNameUI:_updateFollow(unitSpine)
	if unitSpine and unitSpine.unitSpawn ~= self.entity then
		return
	end

	if self.entity.spine then
		local spineGO = self.entity.spine:getSpineGO()

		if not spineGO then
			recthelper.setAnchorX(self._containerGO.transform, 20000)

			return
		end

		local unitCamera = CameraMgr.instance:getUnitCamera()
		local uiCamera = CameraMgr.instance:getUICamera()
		local plane = ViewMgr.instance:getUIRoot().transform
		local skinCO = FightConfig.instance:getSkinCO(self.entity:getMO().skin)

		if skinCO then
			if not skinCO.topuiOffset then
				local uiOffset = {
					0,
					0,
					0,
					0
				}

				if uiOffset then
					if not uiOffset[1] then
						local uiOffsetX = 0

						if uiOffset then
							if not uiOffset[2] then
								local uiOffsetY = 0

								if uiOffset then
									if not uiOffset[3] then
										local worldOffsetX = 0

										if uiOffset then
											if not uiOffset[4] then
												local worldOffsetY = 0
												local hangPointGO = self.entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle, true)
												local size, offset = FightHelper.getEntityBoxSizeOffsetV2(self.entity)
												local boxHeight = size.y
												local _, middleY, _ = transformhelper.getPos(hangPointGO.transform)
												local _, spineY, _ = transformhelper.getPos(self.entity.go.transform)

												self._uiFollower = gohelper.onceAddComponent(self._containerGO, typeof(ZProj.UIFollower))

												self._uiFollower:SetCameraShake(CameraMgr.instance:getCameraShake())

												local root = gohelper.findChild(spineGO, ModuleEnum.SpineHangPointRoot)
												local hpRoot = root and gohelper.findChild(root, ModuleEnum.SpineHangPoint.mounthproot)

												if hpRoot then
													local scaleX, scaleY = transformhelper.getLocalScale(self.entity.go.transform)
													local numOffsetY = 0.5

													self._uiFollower:Set(unitCamera, uiCamera, plane, hpRoot.transform, worldOffsetX, (worldOffsetY + numOffsetY) * scaleY, 0, uiOffsetX, uiOffsetY)
												elseif isTypeOf(self.entity, FightEntityAssembledMonsterMain) or isTypeOf(self.entity, FightEntityAssembledMonsterSub) then
													local entityMO = self.entity:getMO()
													local assembledConfig = lua_fight_assembled_monster.configDict[entityMO.skin]

													self._uiFollower:Set(unitCamera, uiCamera, plane, hangPointGO.transform, assembledConfig.hpPos[1] or 0, assembledConfig.hpPos[2] or 0, 0, 0, 0)
												else
													local scaleX, scaleY = transformhelper.getLocalScale(self.entity.go.transform)
													local entityMO = self.entity:getMO()
													local config3d = entityMO and lua_fight_monster_3d.configDict[entityMO.skin]

													if config3d then
														self._uiFollower:Set(unitCamera, uiCamera, plane, self.entity.go.transform, 0 + worldOffsetX - 5, 0, 0, uiOffsetX, uiOffsetY + 15)
													else
														self._uiFollower:Set(unitCamera, uiCamera, plane, hangPointGO.transform, 0 + worldOffsetX, boxHeight + spineY - middleY + worldOffsetY * scaleY, 0, uiOffsetX, uiOffsetY + 15)
													end
												end

												self._uiFollower:SetEnable(true)
												CameraMgr.instance:getCameraTrace():AddChangeActor(self._uiFollower)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function FightNameUI:_updateUIPos()
	if self._uiFollower then
		self._uiFollower:ForceUpdate()
	end
end

function FightNameUI:changeHpWithChoushiBuff(state)
	local isMySide = self.entity:isMySide()

	if not isMySide then
		gohelper.setActive(self._gohpbg, not state)
		gohelper.setActive(self._gohpbg, state)

		if state then
			UISpriteSetMgr.instance:setFightSprite(self._imgHp, "bg_xt_choushi")
		else
			UISpriteSetMgr.instance:setFightSprite(self._imgHp, "bg_xt2")
		end
	end
end

function FightNameUI:getFollower()
	return self._uiFollower
end

function FightNameUI:updateActive(entityId, effectType, buffId, buff_uid, configEffect)
	if entityId and entityId ~= self.entity.id then
		return
	end

	if buffId then
		local buffConfig = lua_skill_buff.configDict[buffId]

		if buffConfig and buffConfig.typeId == 3120005 then
			self:_insteadSpecialHp(effectType)
		end

		if FightConfig.instance:hasBuffFeature(buffId, FightEnum.BuffType_HideLife) then
			self:_doSetActive()
		end
	else
		self:_doSetActive()
	end
end

function FightNameUI:_insteadSpecialHp(effectType)
	if effectType then
		if effectType == FightEnum.EffectType.BUFFADD then
			self:changeHpWithChoushiBuff(true)
		elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
			self:changeHpWithChoushiBuff(false)
		end
	else
		local buffDic = self.entity:getMO():getBuffDic()

		for i, v in pairs(buffDic) do
			local buffConfig = lua_skill_buff.configDict[v.buffId]

			if buffConfig and buffConfig.typeId == 3120005 then
				self:changeHpWithChoushiBuff(true)

				return
			end
		end
	end
end

function FightNameUI:getFloatItemStartY()
	local opItemList = FightMsgMgr.sendMsg(FightMsgId.GetEnemyAiUseCardItemList, self.entity.id)

	if opItemList then
		if not #opItemList then
			local opItemCount = 0
			local yamiShieldOffset = FightMsgMgr.sendMsg(FightMsgId.GetYaMiShieldUIOffset, self.entity.id) or 0

			return (self.buffMgr:getBuffLineCount() or 0) * 34.5 + (opItemCount > 0 and 42 or 0) + yamiShieldOffset
		end
	end
end

function FightNameUI:showPoisoningEffect(buffCO)
	self.buffMgr:showPoisoningEffect(buffCO)
end

function FightNameUI:_setIsShowFloat(isVisible)
	self._canvasGroup = self._canvasGroup or gohelper.onceAddComponent(self._floatContainerGO, typeof(UnityEngine.CanvasGroup))

	gohelper.setActiveCanvasGroup(self._canvasGroup, isVisible)
end

function FightNameUI:addHp(num)
	local entityMO = self.entity:getMO()
	local maxHp = entityMO.attrMO.hp

	self._curHp = self._curHp + num

	if self._curHp >= 0 then
		self._curHp = self._curHp or 0
	end

	if maxHp >= self._curHp then
		self._curHp = self._curHp or maxHp
	end

	self._txtHp.text = self._curHp

	self:_tweenFillAmount()
end

function FightNameUI:getHp()
	return self._curHp
end

function FightNameUI:setShield(num)
	self._curShield = num > 0 and num or 0

	self:_tweenFillAmount()
end

function FightNameUI:onGetHpFillAmount(entityId)
	if entityId and entityId ~= self.entity.id then
		return
	end

	FightMsgMgr.replyMsg(FightMsgId.GetHpFillAmount, self.curHpFillAmount)
end

function FightNameUI:_tweenFillAmount(curHp, curShield)
	curHp = curHp or self._curHp
	curShield = curShield or self._curShield

	local hpFillAmount, shieldFillAmount, fictionHpPercent, fakeHpPercent = self:_getFillAmount(curHp, curShield)
	local hpBgFillAmount = hpFillAmount

	if FightDataHelper.tempMgr.aiJiAoFakeHpOffset[self.entity.id] then
		curHp, curShield = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(self.entity.id, curHp, curShield)
		hpFillAmount, shieldFillAmount, fictionHpPercent, fakeHpPercent = self:_getFillAmount(curHp, curShield)
	end

	self._imgHp.fillAmount = hpFillAmount
	self.curHpFillAmount = hpFillAmount

	ZProj.TweenHelper.KillByObj(self._imgHpMinus)
	ZProj.TweenHelper.DOFillAmount(self._imgHpMinus, hpBgFillAmount, 0.5)
	ZProj.TweenHelper.KillByObj(self._imgHpShield)
	ZProj.TweenHelper.DOFillAmount(self._imgHpShield, shieldFillAmount, 0.5)
	ZProj.TweenHelper.KillByObj(self.fictionHp)
	ZProj.TweenHelper.DOFillAmount(self.fictionHp, fictionHpPercent, 0.5)
	gohelper.setActive(self._imgHpMinus.gameObject, curShield <= 0)
	ZProj.TweenHelper.KillByObj(self.fakeHp)
	ZProj.TweenHelper.DOFillAmount(self.fakeHp, fakeHpPercent, 0.5)
	self:refreshReduceHp()
	FightMsgMgr.sendMsg(FightMsgId.UpdateYaMiSliderItem, self.entity.id)
end

function FightNameUI:resetHp()
	self._curHp = self.entity:getMO().currentHp

	if self._curHp > 0 then
		self._curHp = self._curHp or 0
	end

	self._curShield = self.entity:getMO().shieldValue

	self:_tweenFillAmount()
end

function FightNameUI:refreshReduceHp()
	local entityMo = self.entity:getMO()
	local rate = entityMo and entityMo:getLockMaxHpRate() or 1
	local showReduceHp = rate < 1

	gohelper.setActive(self._reduceHp, showReduceHp)

	if showReduceHp then
		self._reduceHpImage.fillAmount = Mathf.Clamp01(1 - rate)
	end
end

function FightNameUI:_getFillAmount(curHp, curShield)
	curHp = curHp or self._curHp
	curShield = curShield or self._curShield

	return FightNameUI.getHpFillAmount(curHp, curShield, self.entity.id)
end

function FightNameUI.getHpFillAmount(curHp, curShield, entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return 0, 0
	end

	local hpPercent, shieldPercent, fictionHpPercent, fakeHpPercent = entityMO:getHpAndShieldFillAmount(curHp, curShield)

	return hpPercent, shieldPercent, fictionHpPercent, fakeHpPercent
end

function FightNameUI:_onFloatEquipEffect(id, equip_skill_config)
	if id ~= self.entity.id then
		return
	end

	if not self._float_equip_time then
		self._float_equip_time = Time.time
	elseif Time.time - self._float_equip_time < 1 then
		return
	end

	self._float_equip_time = Time.time

	FightFloatMgr.instance:float(id, FightEnum.FloatType.equipeffect, "", equip_skill_config, false)
end

function FightNameUI:setFloatRootVisble(state)
	gohelper.setActive(self._floatContainerGO, state)
end

function FightNameUI:_onMaxHpChange(entity_id, old_num, new_num)
	if entity_id ~= self.entity.id then
		return
	end

	self:_killHpTween()

	self._hp_tweens = self._hp_tweens or {}

	if old_num < new_num then
		self._hp_ani:Play("up", 0, 0)

		local tween = ZProj.TweenHelper.DOAnchorPosX(self._hp_container_tran, 0, 0.3, self._hpTweenDone, self)

		table.insert(self._hp_tweens, tween)
	else
		local entityMO = self.entity:getMO()

		if entityMO.attrMO and entityMO.attrMO.hp > 0 then
			if not entityMO.attrMO.hp then
				local maxHp = 1

				if entityMO.attrMO then
					if not entityMO.attrMO.original_max_hp then
						local original_max_hp = 1

						if maxHp < original_max_hp then
							self._hp_ani:Play("down", 0, 0)
							self:resetHp()
						end
					end
				end
			end
		end
	end
end

function FightNameUI:_hpTweenDone()
	self:resetHp()
end

function FightNameUI:_killHpTween()
	if self._hp_tweens then
		for i, v in ipairs(self._hp_tweens) do
			ZProj.TweenHelper.KillById(v)
		end

		self._hp_tweens = {}
	end
end

function FightNameUI:_onChangeShield(entity_id)
	if entity_id ~= self.entity.id then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(entity_id)

	self._curShield = entityMO.shieldValue

	self:_tweenFillAmount()
end

function FightNameUI:_onCurrentHpChange(entity_id, old_num, new_num)
	if entity_id ~= self.entity.id then
		return
	end

	self:resetHp()
end

function FightNameUI:_onMultiHpChange(entityId)
	self:_onCurrentHpChange(entityId)
end

function FightNameUI:_onChangeWaveEnd()
	self:_setPosOffset()
end

function FightNameUI:onCoverPerformanceEntityData(entityId)
	if entityId ~= self.entity.id then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	self:setShield(entityMO.shieldValue)
	self:resetHp()
	self.buffMgr:refreshBuffList()
	self._power:_refreshUI()
end

function FightNameUI:_setPosOffset()
	local side = self.entity:getSide()

	if side == FightEnum.EntitySide.MySide then
		local stanceId = FightEnum.MySideDefaultStanceId
		local entityMO = self.entity:getMO()
		local fightParam = FightModel.instance:getFightParam()
		local battleId = fightParam and fightParam.battleId
		local battleCO = battleId and lua_battle.configDict[battleId]

		if battleCO and not string.nilorempty(battleCO.myStance) then
			stanceId = tonumber(battleCO.myStance)

			if not stanceId then
				local sp = string.splitToNumber(battleCO.myStance, "#")

				if #sp > 0 then
					local waveId = FightModel.instance:getCurWaveId() or 1
					local index = waveId <= #sp and waveId or #sp

					stanceId = sp[index]
				end
			end
		end

		local config = lua_stance_hp_offset.configDict[stanceId]

		if config then
			local arr = config["offsetPos" .. entityMO.position]

			if arr and #arr > 0 then
				recthelper.setAnchor(self._floatContainerGO.transform, arr[1], arr[2])
				recthelper.setAnchor(self._uiGO.transform, arr[1], arr[2])

				self._originPosOffsetX = arr[1]
				self._originPosOffsetY = arr[2]
			end
		end
	end
end

local InnerLayoutEnum = {
	NoExPoint_NoPower = 1,
	ExPoint_NoPower = 2,
	NoExPoint_Power = 3,
	ExPoint_Power = 4
}
local AnchorY = {
	[InnerLayoutEnum.NoExPoint_NoPower] = {
		imageCareer = 5,
		layout = 36
	},
	[InnerLayoutEnum.ExPoint_NoPower] = {
		imageCareer = -5,
		layout = 52
	},
	[InnerLayoutEnum.NoExPoint_Power] = {
		imageCareer = -5,
		layout = 40
	},
	[InnerLayoutEnum.ExPoint_Power] = {
		imageCareer = -12,
		layout = 52
	}
}

function FightNameUI:updateInnerLayout()
	local powerData = self._power:_getPowerData()
	local hadExPoint = FightMsgMgr.sendMsg(FightMsgId.GetExPointView, self.entity.id)
	local layoutEnum
	local anchor = AnchorY[powerData and hadExPoint and InnerLayoutEnum.ExPoint_Power or powerData and InnerLayoutEnum.NoExPoint_Power or hadExPoint and InnerLayoutEnum.ExPoint_NoPower or InnerLayoutEnum.NoExPoint_NoPower]
	local rectCareer = self._imgCareerIcon:GetComponent(gohelper.Type_RectTransform)
	local rectLayout = gohelper.findChildComponent(self._uiGO, "layout", gohelper.Type_RectTransform)

	recthelper.setAnchorY(rectCareer, anchor.imageCareer)
	recthelper.setAnchorY(rectLayout, anchor.layout)
end

function FightNameUI:_onUpdateUIFollower(entityId)
	if self._entity and entityId == self._entity.id then
		self:_updateFollow()
	end
end

function FightNameUI:_onLockHpChange()
	self:resetHp()
end

function FightNameUI:_onFakeHpChange()
	self:resetHp()
end

function FightNameUI:onAiJiAoFakeDecreaseHp(entityId)
	if entityId ~= self.entity.id then
		return
	end

	self:_tweenFillAmount()
end

return FightNameUI
