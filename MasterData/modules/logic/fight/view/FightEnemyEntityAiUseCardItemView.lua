-- chunkname: @modules/logic/fight/view/FightEnemyEntityAiUseCardItemView.lua

module("modules.logic.fight.view.FightEnemyEntityAiUseCardItemView", package.seeall)

local FightEnemyEntityAiUseCardItemView = class("FightEnemyEntityAiUseCardItemView", FightBaseView)

function FightEnemyEntityAiUseCardItemView:onInitView()
	local go = self.viewGO

	self.go = go
	self.tr = self.viewGO.transform
	self._imgMat = gohelper.findChildImage(go, "imgMat")
	self._imgTag = gohelper.findChildImage(go, "imgTag")
	self._imgBgs = self:getUserDataTb_()
	self._imgBgGos = self:getUserDataTb_()

	for i = 0, 4 do
		self._imgBgs[i] = gohelper.findChildImage(go, "imgBg/" .. i)
		self._imgBgGos[i] = gohelper.findChild(go, "imgBg/" .. i)
	end

	self._imgBg2 = gohelper.findChildImage(go, "forbid/mask")

	if isDebugBuild then
		self._imgTag.raycastTarget = true
		self._click = gohelper.getClick(self.go)

		self:com_registClick(self._click, self._onClickOp)
	end

	self.topPosRectTr = gohelper.findChildComponent(go, "topPos", gohelper.Type_RectTransform)
	self.goEmitNormal = gohelper.findChild(go, "#emit_normal")
	self.goEmitUitimate = gohelper.findChild(go, "#emit_uitimate")
	self.animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function FightEnemyEntityAiUseCardItemView:addEvents()
	self:com_registMsg(FightMsgId.DiscardUnUsedEnemyAiCard, self.onDiscardUnUsedEnemyAiCard)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView)
	self:com_registFightEvent(FightEvent.OnSelectMonsterCardMo, self.onSelectMonsterCardMo)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnInvokeSkill, self.onInvokeSkill)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self.onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnExPointChange, self.onExPointChange)
	self:com_registFightEvent(FightEvent.InvalidEnemyUsedCard, self.onInvalidEnemyUsedCard)
end

function FightEnemyEntityAiUseCardItemView:onSelectMonsterCardMo(cardMo)
	local select = FightHelper.isSameCardMo(cardMo, self.cardData)

	gohelper.setActive(self.goEmitNormal, select and not self.isBigSkill)
	gohelper.setActive(self.goEmitUitimate, select and self.isBigSkill)
end

function FightEnemyEntityAiUseCardItemView:onCloseView(viewName)
	if viewName == ViewName.FightEnemyActionView then
		gohelper.setActive(self.goEmitNormal, false)
		gohelper.setActive(self.goEmitUitimate, false)
	end
end

function FightEnemyEntityAiUseCardItemView:onRefreshItemData(data)
	self.cardData = data
	self.entityId = self.cardData.uid
	self.skillId = self.cardData.skillId
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)
	self.isBigSkill = FightCardDataHelper.isBigSkill(self.skillId)

	if lua_skill_next.configDict[self.skillId] then
		self.isBigSkill = false
	end

	self:refreshCanUseCardState()

	local skillCO = lua_skill.configDict[data.skillId]

	gohelper.setActive(self.go, skillCO ~= nil)

	if not skillCO then
		return
	end

	local skillLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)

	skillLv = self.isBigSkill and FightEnum.UniqueSkillCardLv or skillLv == FightEnum.UniqueSkillCardLv and 1 or skillLv

	UISpriteSetMgr.instance:setFightSprite(self._imgTag, "jnk_gj" .. skillCO.showTag)

	for level, img in pairs(self._imgBgs) do
		gohelper.setActive(img.gameObject, level == skillLv)
	end

	if self._imgBg2 and self._imgBgs[skillLv] then
		self._imgBg2.sprite = self._imgBgs[skillLv].sprite
	end

	gohelper.setActive(self._imgTag.gameObject, skillLv ~= FightEnum.UniqueSkillCardLv)
	self.animator:Play(self.canUseCard and "fightname_op_in" or "fightname_forbid_in", 0, 0)
	self.animator:Update(0)
end

function FightEnemyEntityAiUseCardItemView:refreshCanUseCardState()
	if self.forceCanNotUse then
		self.canUseCard = false

		return
	end

	self.canUseCard = self:checkCanUseCard()

	if self.isBigSkill then
		local exPoint = self.entityData.exPoint
		local uniqueSkillCost = self.entityData:getUniqueSkillPoint()

		if exPoint < uniqueSkillCost then
			self.canUseCard = false
		end
	end
end

function FightEnemyEntityAiUseCardItemView:checkCanUseCard()
	if not FightModel.instance:isSeason2() then
		return FightViewHandCardItemLock.canUseCardSkill(self.entityId, self.skillId)
	end

	local buffList = self.entityData:getBuffList()
	local needRemove832400103 = false
	local itemIndex = self:getSelfIndex()

	for i, buff in ipairs(buffList) do
		if buff.buffId == 832400103 then
			needRemove832400103 = true

			if itemIndex == 1 then
				return false
			end

			break
		end
	end

	if needRemove832400103 then
		buffList = FightDataUtil.coverData(buffList)

		for i = #buffList, 1, -1 do
			local buff = buffList[i]

			if buff.buffId == 832400103 then
				table.remove(buffList, i)
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(self.entityId, self.skillId, buffList)
end

function FightEnemyEntityAiUseCardItemView:onSkillPlayStart(entity, curSkillId, fightStepData)
	if entity.id ~= self.entityId then
		return
	end

	if fightStepData.cardIndex == self.cardData.clientData.custom_enemyCardIndex then
		self.animator:Play("fightname_op_play", 0, 0)
		self.animator:Update(0)
		self:com_registSingleTimer(self.onPlayEnd, 0.5)

		self.played = true
	end
end

function FightEnemyEntityAiUseCardItemView:onInvokeSkill(fightStepData)
	if fightStepData.fromId ~= self.entityId then
		return
	end

	if fightStepData.cardIndex == self.cardData.clientData.custom_enemyCardIndex then
		self.animator:Play("fightname_op_play", 0, 0)
		self.animator:Update(0)
		self:com_registSingleTimer(self.onPlayEnd, 0.5)

		self.played = true
	end
end

function FightEnemyEntityAiUseCardItemView:onPlayEnd()
	self:removeSelf()
end

function FightEnemyEntityAiUseCardItemView:onBuffUpdate(entityId, effectType, buffId)
	if entityId ~= self.entityId then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD or effectType == FightEnum.EffectType.BUFFDEL then
		self:refreshLockState()
	end
end

function FightEnemyEntityAiUseCardItemView:onDiscardUnUsedEnemyAiCard()
	if not self.played then
		local work = self:com_registWork(FightWorkPlayAnimator, self.viewGO, "fightname_forbid_imprison", FightModel.instance:getUISpeed())

		FightMsgMgr.replyMsg(FightMsgId.DiscardUnUsedEnemyAiCard, work)

		local skillLv = FightCardDataHelper.getSkillLv(self.entityId, self.skillId)
		local go = self._imgBgGos[skillLv]

		if go then
			local imgBgAnimation = go:GetComponent(typeof(UnityEngine.Animation))

			gohelper.onceAddComponent(go, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

			if imgBgAnimation then
				imgBgAnimation:Play("fightname_forbid_dissvelop")
			end

			self._imgBgs[skillLv].material = self._imgMat.material
		end
	end
end

function FightEnemyEntityAiUseCardItemView:onExPointChange(entityId, oldExPoint, newExPoint)
	if entityId == self.entityId then
		self:refreshLockState()
	end
end

function FightEnemyEntityAiUseCardItemView:refreshLockState()
	local oldCanUse = self.canUseCard

	self:refreshCanUseCardState()

	if oldCanUse ~= self.canUseCard then
		self.animator:Play(self.canUseCard and "fightname_forbid_unlock" or "fightname_forbid_in", 0, 0)
		self.animator:Update(0)
	end
end

function FightEnemyEntityAiUseCardItemView:onInvalidEnemyUsedCard(index)
	if index == self.cardData.clientData.custom_enemyCardIndex then
		self.forceCanNotUse = true

		self:refreshLockState()
	end
end

function FightEnemyEntityAiUseCardItemView:_onClickOp()
	if self.cardData then
		logNormal(self.cardData.skillId .. " " .. lua_skill.configDict[self.cardData.skillId].name)
	end
end

function FightEnemyEntityAiUseCardItemView:onDestructor()
	for level, img in pairs(self._imgBgs) do
		img.material = nil
	end
end

return FightEnemyEntityAiUseCardItemView
