-- chunkname: @modules/logic/fight/view/FightViewBossHp.lua

module("modules.logic.fight.view.FightViewBossHp", package.seeall)

local FightViewBossHp = class("FightViewBossHp", FightBaseView)

FightViewBossHp.VariantIdToMaterialPath = {
	"ui/materials/dynamic/ui_headicon_stylization_1.mat",
	"ui/materials/dynamic/ui_headicon_stylization_2.mat",
	"ui/materials/dynamic/ui_headicon_stylization_3.mat",
	"ui/materials/dynamic/ui_headicon_stylization_4.mat"
}

function FightViewBossHp:onInitView()
	self.viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._bossHpGO = gohelper.findChild(self.viewGO, "Alpha/bossHp")
	self._imgbossHpbg = gohelper.findChildImage(self.viewGO, "Alpha/bossHp")
	self.maskRoot = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask")
	self._hp_container_tran = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container").transform
	self._aniBossHp = self._bossHpGO:GetComponent(typeof(UnityEngine.Animator))
	self._imgHp = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/mask/container/imgHp")
	self._reduceHp = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container/reducehp")
	self._reduceHpImage = self._reduceHp:GetComponent(gohelper.Type_Image)
	self._gochoushi = gohelper.findChild(self.viewGO, "Alpha/bossHp/choushi")
	self._goHpShield = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container/imgProtect")

	gohelper.setActive(self._goHpShield, true)

	self._imgHpShield = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/mask/container/imgProtect/ani_idle/imgProtect")
	self._trsShieldPosUI = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container/imgProtect/ani_posui").transform
	self._rectMaskHpShield = self._goHpShield:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._aniHpShield = self._goHpShield:GetComponent(typeof(UnityEngine.Animator))
	self._txtHp = gohelper.findChildText(self.viewGO, "Alpha/bossHp/mask/container/imgHp/txtHp")
	self._goHpEffect = gohelper.findChild(self.viewGO, "Alpha/bossHp/#hpeffect")
	self._aniHpEffect = self._goHpEffect:GetComponent(typeof(UnityEngine.Animator))
	self._imgHead = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/headbg/imgHead")
	self._imgHeadIcon = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/headbg/imgHead")
	self._imgCareer = gohelper.findChildImage(self.viewGO, "Alpha/bossHp/headbg/imgCareer")
	self._passiveSkillPrefab = gohelper.findChild(self.viewGO, "Alpha/bossHp/passiveSkills/item")
	self._btnpassiveSkill = gohelper.findChildButtonWithAudio(self.viewGO, "Alpha/bossHp/passiveSkills/btn_passiveclick")
	self._exPointPrefab = gohelper.findChild(self.viewGO, "Alpha/bossHp/exPoint/item")
	self._imgSignHpContainer = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	self._imgSignHpItem = gohelper.findChild(self.viewGO, "Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")

	gohelper.setActive(self._passiveSkillPrefab, false)
	gohelper.setActive(self._exPointPrefab, false)

	self._specialSkillGOs = self:getUserDataTb_()
	self._passiveSkillImgs = self:getUserDataTb_()
	self._exPointFullList = self:getUserDataTb_()
	self.bossSkillInfos = {}
	self._multiHpRoot = gohelper.findChild(self.viewGO, "Alpha/bossHp/image_HPBG")
	self._multiHpItemContent = gohelper.findChild(self.viewGO, "Alpha/bossHp/image_HPBG/grid")
	self._multiHpItem = gohelper.findChild(self.viewGO, "Alpha/bossHp/image_HPBG/grid/image_HpItem")
	self._bossActionRoot = gohelper.findChild(self.viewGO, "Alpha/bossHp/actionbar")
	self._bossEnergyRoot = gohelper.findChild(self.viewGO, "Alpha/bossHp/#go_assisthpbar")
	self.killLineComp = FightBossHpKillLineComp.New(FightHpKillLineComp.KillLineType.BossHp)

	self.killLineComp:init(self._imgHp.gameObject)

	self.toughnessObj = gohelper.findChild(self.viewGO, "toughness")
	self.weakCareerObj = gohelper.findChild(self.viewGO, "Alpha/bossHp/weekness")
end

function FightViewBossHp:onOpen()
	self._btnpassiveSkill:AddClickListener(self._onClickPassiveSkill, self)
	self:com_registMsg(FightMsgId.GetBossHpRootAnimator, self.onGetBossHpRootAnimator)
	self:com_registFightEvent(FightEvent.RespBeginRound, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.OnChangeEntity, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.OnEntityDead, self._onEntityDead)
	self:com_registFightEvent(FightEvent.OnBeginWave, self._onBeginWave)
	self:com_registFightEvent(FightEvent.UpdateExPoint, self._updateExPoint)
	self:com_registFightEvent(FightEvent.OnHpChange, self._onHpChange)
	self:com_registFightEvent(FightEvent.OnShieldChange, self._onShieldChange)
	self:com_registFightEvent(FightEvent.OnMonsterChange, self._onMonsterChange)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._onRestartStage)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset)
	self:com_registFightEvent(FightEvent.GMHideFightView, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.OnMaxHpChange, self._onMaxHpChange)
	self:com_registFightEvent(FightEvent.OnCurrentHpChange, self._onCurrentHpChange)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.MultiHpChange, self._onMultiHpChange)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect)
	self:com_registFightEvent(FightEvent.PushTeamInfo, self._onMonsterChange)
	self:com_registFightEvent(FightEvent.OnSummon, self._checkBossAndUpdate)
	self:com_registFightEvent(FightEvent.CoverPerformanceEntityData, self.onCoverPerformanceEntityData)
	self:com_registFightEvent(FightEvent.ChangeCareer, self._onChangeCareer)
	self:com_registFightEvent(FightEvent.ChangeShield, self._onChangeShield)
	self:com_registFightEvent(FightEvent.SetFakeNuoDiKaDamageShield, self.onSetFakeNuoDiKaDamageShield)
	self:com_registFightEvent(FightEvent.AiJiAoFakeDecreaseHp, self.onAiJiAoFakeDecreaseHp)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self.onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.MultiHpTypeChange, self._detectBossMultiHp)

	self.sheildWidth = recthelper.getWidth(self._goHpShield.transform)

	self:_checkBossAndUpdate()

	if FightDataHelper.fieldMgr:isShelter() then
		self:com_openSubView(FightViewBossHpBossRushAction, "ui/viewres/fight/fightviewbosshpbossrushaction.prefab", self._bossActionRoot)
	end
end

function FightViewBossHp:onClose()
	self._btnpassiveSkill:RemoveClickListener()

	if self.killLineComp then
		self.killLineComp:destroy()

		self.killLineComp = nil
	end
end

function FightViewBossHp:_onBeginWave()
	self._bossHasDead = nil

	self:_checkBossAndUpdate()
end

function FightViewBossHp:_onEntityDead(entityId)
	if self._bossEntityMO and self._bossEntityMO.id == entityId then
		self._boss_hp_sign = nil
		self._bossHasDead = true

		self:_checkBossAndUpdate()
	end
end

function FightViewBossHp:_onBeforeDeadEffect(entityId)
	if self._bossEntityMO and self._bossEntityMO.id == entityId then
		self:_detectBossMultiHp()
	end
end

function FightViewBossHp:_checkBossAndUpdate()
	if self._bossHasDead then
		gohelper.setActive(self._bossHpGO, false)

		self._aniHpEffect.enabled = false
		self._bossEntityMO = nil

		self.killLineComp:refreshByEntityMo()

		return
	end

	if self._bossEntityMO and not FightDataHelper.entityMgr:getById(self._bossEntityMO.id) then
		self._bossEntityMO = nil
	end

	if not self._bossEntityMO then
		self._bossEntityMO = self:_getBossEntityMO()

		if self._bossEntityMO then
			self:newClass(FightBossHpToughness, self.toughnessObj, self._bossEntityMO)
			self:newClass(FightBossHpWeakCareers, self.weakCareerObj, self._bossEntityMO)
		end

		local battleCo = lua_battle.configDict[FightDataHelper.fieldMgr.battleId]
		local isBalance = battleCo and not string.nilorempty(battleCo.balance) or false

		if self._bossEntityMO and self._bossEntityMO.skin == 610414 and not self.bossHpFor610414 then
			self.lockHpBySkin = true

			gohelper.setActive(self.maskRoot, false)

			self.bossHpFor610414 = self.com_openSubView(self, FightMonsterBossHpFor610414, "ui/viewres/fight/fight3_7qteview.prefab", self._bossHpGO, self, self._bossHpGO, self._bossEntityMO)
		end

		if self._bossEntityMO and self._bossEntityMO.skin == 610416 and not self.bossHpFor610416 and isBalance then
			self.lockHpBySkin = true
			self.bossHpFor610416 = self.com_openSubView(self, FightMonsterBossHpFor610416, "ui/viewres/fight/fight3_7qteview.prefab", self._bossHpGO, self, self._bossHpGO, self._bossEntityMO)
		end
	end

	self.killLineComp:refreshByEntityMo(self._bossEntityMO)

	if not self._bossEntityMO or not GMFightShowState.bossHp then
		self._aniHpEffect.enabled = false
	end

	gohelper.setActive(self._bossHpGO, self._bossEntityMO and GMFightShowState.bossHp)

	if self._bossEntityMO then
		self:_refreshBossHpUI()
	end

	if self._bossEntityMO and self._bossEntityMO:getPowerInfo(FightEnum.PowerType.Energy) then
		self._bossEnergyView = self._bossEnergyView or self:com_openSubView(FightViewBossEnergy, "ui/viewres/fight/assisthpbar.prefab", self._bossEnergyRoot, self._bossEntityMO)

		gohelper.setActive(self._bossEnergyRoot, true)
	else
		gohelper.setActive(self._bossEnergyRoot, false)
	end
end

function FightViewBossHp:_refreshBossHpUI()
	self._boss_hp_sign = nil

	self:_insteadSpecialHp()
	self:_updateUI()
	self:_updatePassiveSkill()
	self:_updateExPoint()
end

function FightViewBossHp:_onRestartStage()
	gohelper.setActive(self._bossHpGO, false)

	self._bossEntityMO = nil
end

function FightViewBossHp:_onSwitchPlaneClearAsset()
	gohelper.setActive(self._bossHpGO, false)

	self._bossEntityMO = nil
end

function FightViewBossHp:_onMonsterChange(oldEntityMO, newEntityMO)
	self._bossEntityMO = nil

	self:_checkBossAndUpdate()
end

function FightViewBossHp:_getBossEntityMO()
	local bossId = self:_getBossId()

	if bossId then
		local enemyEntityMOList = FightDataHelper.entityMgr:getEnemyNormalList()

		for _, entityMO in ipairs(enemyEntityMOList) do
			if FightHelper.isBossId(bossId, entityMO.modelId) then
				return entityMO
			end
		end

		local changeBossId = self:_getChangeBossId(bossId)

		if changeBossId then
			for _, entityMO in ipairs(enemyEntityMOList) do
				if changeBossId == entityMO.modelId then
					return entityMO
				end
			end
		end
	end
end

function FightViewBossHp:_onBuffUpdate(entityId, effectType, buffId, buff_uid, configEffect)
	if not self._bossEntityMO then
		return
	end

	if self._bossEntityMO.id ~= entityId then
		return
	end

	if buffId then
		local buffConfig = lua_skill_buff.configDict[buffId]

		if buffConfig and buffConfig.typeId == 3120005 then
			self:_insteadSpecialHp(effectType)
		end
	end
end

function FightViewBossHp:_insteadSpecialHp(effectType)
	if effectType then
		if effectType == FightEnum.EffectType.BUFFADD then
			self:changeBossHpWithChouShiBuff(true)
		elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
			self:changeBossHpWithChouShiBuff(false)
		end
	elseif self._bossEntityMO then
		local buffDic = self._bossEntityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			local buffConfig = lua_skill_buff.configDict[v.buffId]

			if buffConfig and buffConfig.typeId == 3120005 then
				self:changeBossHpWithChouShiBuff(true)

				return
			end
		end
	end
end

function FightViewBossHp:changeBossHpWithChouShiBuff(state)
	if state then
		UISpriteSetMgr.instance:setFightSprite(self._imgbossHpbg, "bg_xuetiaobossdi2")
		UISpriteSetMgr.instance:setFightSprite(self._imgHp, "bg_xuetiaoboss_choushi")
		SLFramework.UGUI.GuiHelper.SetColor(self._imgHp, "#FFFFFF")
	else
		UISpriteSetMgr.instance:setFightSprite(self._imgbossHpbg, "bg_xtiaodi")
		UISpriteSetMgr.instance:setFightSprite(self._imgHp, "bosshp")
		SLFramework.UGUI.GuiHelper.SetColor(self._imgHp, "#873816")
	end

	gohelper.setActive(self._gochoushi, state)
end

function FightViewBossHp:_getBossId()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]

	if monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) then
		if not monsterGroupCO.bossId then
			local bossId

			return bossId
		end
	end
end

function FightViewBossHp:_getChangeBossId(bossId)
	local bossIds = string.splitToNumber(bossId)

	for index, monsterId in ipairs(bossIds) do
		local monsterCO = lua_monster.configDict[monsterId]

		if not monsterCO then
			logError("怪物表找不到id:" .. monsterId)
		end

		local skillIds = FightHelper._buildMonsterSkills(monsterCO)

		for _, skillId in ipairs(skillIds) do
			local skillCO = lua_skill.configDict[skillId]

			if not skillCO then
				logError("技能表找不到id: " .. skillId)
			end

			for i = 1, FightEnum.MaxBehavior do
				local behavior = skillCO["behavior" .. i]
				local sp = string.splitToNumber(behavior, "#")
				local behaviorId = sp[1]
				local behaviorCO = behaviorId and lua_skill_behavior.configDict[behaviorId]

				if behaviorCO and behaviorCO.type == "MonsterChange" then
					return sp[2]
				end
			end
		end
	end
end

function FightViewBossHp:_updateUI()
	if not self._bossEntityMO then
		return
	end

	local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]
	local skinCO = FightConfig.instance:getSkinCO(monsterCO.skinId)
	local maxHp = self._bossEntityMO.attrMO.hp
	local currentHp = self._bossEntityMO.currentHp

	self._curHp = currentHp
	self._curShield = self._bossEntityMO.shieldValue
	currentHp = currentHp > 0 and currentHp or 0

	self:_tweenFillAmount()

	self._txtHp.text = string.format("%d/%d", currentHp, maxHp)

	if not string.nilorempty(skinCO.headIcon) then
		gohelper.getSingleImage(self._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinCO.headIcon))

		if monsterCO.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(monsterCO.heartVariantId), self._imgHeadIcon)
		end
	else
		gohelper.setActive(self._imgHead.gameObject, false)
	end

	self:_refreshCareer()
	self:_detectBossHpSign()
	self:_detectBossMultiHp()
end

function FightViewBossHp:_refreshCareer()
	local version = FightModel.instance:getVersion()

	if version >= 2 then
		UISpriteSetMgr.instance:setCommonSprite(self._imgCareer, "sx_icon_" .. tostring(self._bossEntityMO.career))
	else
		local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]

		UISpriteSetMgr.instance:setCommonSprite(self._imgCareer, "sx_icon_" .. tostring(monsterCO.career))
	end
end

function FightViewBossHp:_onChangeCareer(entityId)
	if self._bossEntityMO and entityId == self._bossEntityMO.id then
		self:_refreshCareer()
	end
end

function FightViewBossHp:_onHpChange(defender, num)
	if num ~= 0 and self._bossEntityMO and defender.id == self._bossEntityMO.id then
		if num < 0 then
			gohelper.setActive(self._goHpEffect, true)

			self._aniHpEffect.enabled = true
			self._aniHpEffect.speed = 1

			self._aniHpEffect:Play("hpeffect", 0, 0)
			self._aniHpEffect:Update(0)
		end

		local maxHp = self._bossEntityMO.attrMO.hp

		self._curHp = self._curHp + num

		if self._curHp > 0 then
			self._curHp = self._curHp or 0
		end

		if maxHp >= self._curHp then
			self._curHp = self._curHp or maxHp
		end

		self._txtHp.text = self._curHp

		self:_tweenFillAmount()
	end

	if self.aiJiAoFakeHpBgImg then
		self.aiJiAoFakeHpBgImg.fillAmount = 0
	end
end

function FightViewBossHp:_playHpEffectAni()
	return
end

function FightViewBossHp:_detectBossHpSign()
	local config = self._bossEntityMO:getCO()

	if not string.nilorempty(config.hpSign) and not self._boss_hp_sign then
		self._boss_hp_sign = string.splitToNumber(config.hpSign, "#")
	end

	gohelper.setActive(self._imgSignHpContainer, self._boss_hp_sign)

	if self._boss_hp_sign then
		gohelper.CreateObjList(self, self._bossHpSignShow, self._boss_hp_sign, self._imgSignHpContainer, self._imgSignHpItem)
	end
end

function FightViewBossHp:_bossHpSignShow(obj, data, index)
	recthelper.setAnchorX(obj.transform, data / 1000 * recthelper.getWidth(obj.transform.parent.parent))
end

function FightViewBossHp:_onMultiHpChange(entityId)
	if self._bossEntityMO and entityId == self._bossEntityMO.id then
		local hpFillAmount, shieldFillAmount = self:_getFillAmount()

		self._bossEntityMO = nil

		self:_checkBossAndUpdate()

		local curHp = self._curHp
		local curShield = self._curShield

		if self._bossEntityMO and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[self._bossEntityMO.id] then
			curHp, curShield = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(self._bossEntityMO.id, curHp, curShield)
			hpFillAmount, shieldFillAmount = self:_getFillAmount(curHp, curShield)
			hpFillAmount = Mathf.Clamp(hpFillAmount, 0.01, 1)
			shieldFillAmount = Mathf.Clamp(shieldFillAmount, 0.01, 1)
		end

		self._imgHp.fillAmount = hpFillAmount
		self._imgHpShield.fillAmount = shieldFillAmount

		self:_tweenFillAmount(0.8)
		self:refreshReduceHP()
	end
end

function FightViewBossHp:_detectBossMultiHp()
	local multiHpNum = self._bossEntityMO.attrMO.multiHpNum
	local multiHpIdx = self._bossEntityMO.attrMO:getCurMultiHpIndex()

	if not self._hpMultiAni or multiHpIdx == 0 then
		self._hpMultiAni = {}
	end

	gohelper.setActive(self._multiHpRoot, multiHpNum > 1)

	if multiHpNum > 1 then
		self:com_createObjList(self._onMultiHpItemShow, multiHpNum, self._multiHpItemContent, self._multiHpItem)
	end
end

local _multiHpAniIdle = "idle"
local _multiHpAniClose = "close"

function FightViewBossHp:_onMultiHpItemShow(obj, data, index)
	local multiHpNum = self._bossEntityMO.attrMO.multiHpNum
	local multiHpIdx = self._bossEntityMO.attrMO:getCurMultiHpIndex()
	local image_HPFG1 = gohelper.findChild(obj, "hp")
	local ani = gohelper.onceAddComponent(obj, typeof(UnityEngine.Animator))
	local showHp = index <= multiHpNum - multiHpIdx

	if not self._hpMultiAni[index] then
		gohelper.setActive(image_HPFG1, showHp)

		if showHp then
			self._hpMultiAni[index] = _multiHpAniIdle or _multiHpAniClose
		end
	elseif showHp then
		if not _multiHpAniIdle then
			local newAni = _multiHpAniClose

			if self._hpMultiAni[index] ~= newAni then
				self._hpMultiAni[index] = newAni

				ani:Play(self._hpMultiAni[index])
			end
		end
	end
end

function FightViewBossHp:_onShieldChange(defender, num)
	if self._bossEntityMO and defender.id == self._bossEntityMO.id then
		if num ~= 0 then
			self._curShield = self._curShield + num or self._bossEntityMO.shieldValue
		end

		local curHp = self._curHp
		local curShield = self._curShield
		local hpFillAmount, shieldFillAmount = self:_getFillAmount()

		if self._bossEntityMO and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[self._bossEntityMO.id] then
			curHp, curShield = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(self._bossEntityMO.id, curHp, curShield)

			local var_28_1, var_28_2 = self:_getFillAmount(curHp, curShield)

			hpFillAmount = var_28_1
			hpFillAmount = Mathf.Clamp(var_28_1, 0.01, 1)
			shieldFillAmount = Mathf.Clamp(var_28_2, 0.01, 1)
		end

		self:_changeShieldPos(hpFillAmount)

		if curShield <= 0 then
			if self:_checkShieldBreakAnim() then
				return
			end

			self._imgHp.fillAmount = hpFillAmount

			self._aniHpShield:Play(UIAnimationName.Open)
			self._aniBossHp:Play("shake", 0, 0)
		else
			self._aniHpShield:Play(UIAnimationName.Idle)
		end

		self:_tweenFillAmount()
		self:refreshReduceHP()
	end
end

function FightViewBossHp:_checkShieldBreakAnim()
	local stateInfo = self._aniHpShield:GetCurrentAnimatorStateInfo(0)
	local normalizedTime = stateInfo.normalizedTime

	if normalizedTime <= 1 then
		return true
	end

	return false
end

function FightViewBossHp:_tweenFillAmount(duration, curHp, curShield)
	duration = duration or 0.5
	curHp = curHp or self._curHp
	curShield = curShield or self._curShield

	local hpFillAmount, shieldFillAmount = self:_getFillAmount(curHp, curShield)
	local hpBgFillAmount = hpFillAmount

	if self._bossEntityMO and FightDataHelper.tempMgr.aiJiAoFakeHpOffset[self._bossEntityMO.id] then
		curHp, curShield = FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(self._bossEntityMO.id, curHp, curShield)
		hpFillAmount, shieldFillAmount = self:_getFillAmount(curHp, curShield)
		hpFillAmount = Mathf.Clamp(hpFillAmount, 0.01, 1)
		shieldFillAmount = Mathf.Clamp(shieldFillAmount, 0.01, 1)
	end

	self:_changeShieldPos(hpFillAmount)
	ZProj.TweenHelper.KillByObj(self._imgHp)
	ZProj.TweenHelper.KillByObj(self._imgHpShield)

	if self.lockHpBySkin then
		hpFillAmount = 1
		shieldFillAmount = 0
	end

	ZProj.TweenHelper.DOFillAmount(self._imgHp, hpFillAmount, duration / FightModel.instance:getUISpeed())
	ZProj.TweenHelper.DOFillAmount(self._imgHpShield, shieldFillAmount, duration / FightModel.instance:getUISpeed())
	self:setAiJiAoFakeHp(hpBgFillAmount)
	self:refreshReduceHP()
end

function FightViewBossHp:refreshReduceHP()
	local entityMo = self._bossEntityMO

	if not entityMo then
		gohelper.setActive(self._reduceHp, false)

		return
	end

	local rate = entityMo and entityMo:getLockMaxHpRate() or 1
	local showReduceHp = rate < 1

	gohelper.setActive(self._reduceHp, showReduceHp)

	if showReduceHp then
		self._reduceHpImage.fillAmount = Mathf.Clamp01(1 - rate)
	end
end

function FightViewBossHp:_changeShieldPos(hpFillAmount)
	if self:_checkShieldBreakAnim() then
		return
	end

	recthelper.setAnchorX(self._trsShieldPosUI, hpFillAmount * self.sheildWidth)
end

function FightViewBossHp:_getFillAmount(curHp, curShield)
	if not self._bossEntityMO then
		return 0, 0
	end

	curHp = curHp or self._curHp
	curShield = curShield or self._curShield

	local entityMO = self._bossEntityMO
	local hpPercent, shieldPercent = entityMO:getHpAndShieldFillAmount(curHp, curShield)

	if entityMO.attrMO and entityMO.attrMO.hp > 0 then
		if not entityMO.attrMO.hp then
			return hpPercent, shieldPercent
		end
	end
end

function FightViewBossHp:_updatePassiveSkill()
	if not self._bossEntityMO then
		return
	end

	local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]
	local skills = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterCO.id)

	skills = FightConfig.instance:_filterSpeicalSkillIds(skills, true)
	self.bossSkillInfos = {}

	for i = 1, #skills do
		local skillId = skills[i]
		local specialCO = lua_skill_specialbuff.configDict[skillId]

		if specialCO then
			local specialSkillTable = self._specialSkillGOs[i]

			if not specialSkillTable then
				specialSkillTable = self:getUserDataTb_()
				specialSkillTable.go = gohelper.cloneInPlace(self._passiveSkillPrefab, "item" .. i)
				specialSkillTable._gotag = gohelper.findChild(specialSkillTable.go, "tag")
				specialSkillTable._txttag = gohelper.findChildText(specialSkillTable.go, "tag/#txt_tag")

				table.insert(self._specialSkillGOs, specialSkillTable)

				local img = gohelper.findChildImage(specialSkillTable.go, "icon")

				table.insert(self._passiveSkillImgs, img)
			end

			if not string.nilorempty(specialCO.lv) then
				gohelper.setActive(specialSkillTable._gotag, true)

				specialSkillTable._txttag.text = specialCO.lv
			else
				gohelper.setActive(specialSkillTable._gotag, false)
			end

			if specialCO.icon == 0 then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. specialCO.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(self._passiveSkillImgs[i], specialCO.icon)
			gohelper.setActive(specialSkillTable.go, true)
			table.insert(self.bossSkillInfos, {
				skillId = skillId,
				icon = specialCO.icon
			})
		end
	end

	gohelper.setAsLastSibling(self._btnpassiveSkill.gameObject)

	for i = #skills + 1, #self._specialSkillGOs do
		gohelper.setActive(self._specialSkillGOs[i].go, false)
	end
end

function FightViewBossHp:_onClickPassiveSkill()
	if not FightModel.instance:isStartFinish() then
		return
	end

	if not self.bossSkillInfos then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnPassiveSkillClick, self.bossSkillInfos, self._btnpassiveSkill.transform, -509.5, -29, self._bossEntityMO.id)
end

function FightViewBossHp:_updateExPoint()
	if not self._bossEntityMO then
		return
	end

	local curExPoint = self._bossEntityMO.exPoint
	local maxExPoint = self._bossEntityMO:getMaxExPoint()

	for i = 1, maxExPoint do
		local exPointFullGO = self._exPointFullList[i]

		if not exPointFullGO then
			local cloneExPointGO = gohelper.cloneInPlace(self._exPointPrefab, self._exPointPrefab.name .. i)

			table.insert(self._exPointFullList, gohelper.findChild(cloneExPointGO, "full"))
			gohelper.setActive(cloneExPointGO, true)
		end

		gohelper.setActive(self._exPointFullList[i], i <= curExPoint)
	end

	for i = maxExPoint + 1, #self._exPointFullList do
		gohelper.setActive(self._exPointFullList[i], false)
	end
end

function FightViewBossHp:_onMaxHpChange(entity_id, old_num, new_num)
	if self._bossEntityMO and self._bossEntityMO.id == entity_id then
		self:_updateUI()
	end
end

function FightViewBossHp:_onCurrentHpChange(entity_id, old_num, new_num)
	if self._bossEntityMO and self._bossEntityMO.id == entity_id then
		self:_updateUI()
	end
end

function FightViewBossHp:_onChangeShield(entity_id)
	if self._bossEntityMO and self._bossEntityMO.id == entity_id then
		self:_updateUI()
	end
end

function FightViewBossHp:onSetFakeNuoDiKaDamageShield(entityId, num)
	if self._bossEntityMO and self._bossEntityMO.id == entityId then
		self._curShield = num > 0 and num or 0

		self:_tweenFillAmount()
	end
end

function FightViewBossHp:onCoverPerformanceEntityData(entityId)
	if not self._bossEntityMO or entityId ~= self._bossEntityMO.id then
		return
	end

	self._curHp = self._bossEntityMO.currentHp
	self._curShield = self._bossEntityMO.shieldValue

	self:_tweenFillAmount()
end

function FightViewBossHp:onAiJiAoFakeDecreaseHp(entityId)
	if self._bossEntityMO and entityId == self._bossEntityMO.id then
		local aiJiAoFakeHpOffset = FightDataHelper.tempMgr.aiJiAoFakeHpOffset[entityId]

		if aiJiAoFakeHpOffset then
			self:_tweenFillAmount()
		end
	end
end

function FightViewBossHp:setAiJiAoFakeHp(hpBgFillAmount)
	if not self.aiJiAoFakeHpBgImg then
		local gameObject = self._imgHp.gameObject

		self.aiJiAoFakeHpBgImg = gohelper.onceAddComponent(gohelper.cloneInPlace(gameObject, "aiJiAoFakeHpBgImg"), gohelper.Type_Image)

		gohelper.setAsLastSibling(gameObject)

		local transform = self.aiJiAoFakeHpBgImg.transform
		local count = transform.childCount

		for i = 1, count do
			local child = transform:GetChild(i - 1)

			gohelper.setActive(child.gameObject, false)
		end

		SLFramework.UGUI.GuiHelper.SetColor(self.aiJiAoFakeHpBgImg, "#E1C590")
	end

	if self._bossEntityMO and not FightDataHelper.tempMgr.aiJiAoFakeHpOffset[self._bossEntityMO.id] then
		hpBgFillAmount = 0
	end

	self.aiJiAoFakeHpBgImg.fillAmount = hpBgFillAmount
end

function FightViewBossHp:checkAiJiAoFakeDecreaseHp()
	if self._bossEntityMO then
		self:onAiJiAoFakeDecreaseHp(self._bossEntityMO.id)
	end
end

function FightViewBossHp:onFightReconnectLastWork()
	self:checkAiJiAoFakeDecreaseHp()
end

function FightViewBossHp:onGetBossHpRootAnimator()
	FightMsgMgr.replyMsg(FightMsgId.GetBossHpRootAnimator, self.viewAnimator)
end

return FightViewBossHp
