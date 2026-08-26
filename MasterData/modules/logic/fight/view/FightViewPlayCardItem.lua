-- chunkname: @modules/logic/fight/view/FightViewPlayCardItem.lua

module("modules.logic.fight.view.FightViewPlayCardItem", package.seeall)

local FightViewPlayCardItem = class("FightViewPlayCardItem", LuaCompBase)
local CardScale = 0.76

function FightViewPlayCardItem:init(go)
	self.go = go
	self.tr = go.transform
	self._emtpyGO = gohelper.findChild(go, "imgEmpty")
	self._emptyNormal = gohelper.findChild(go, "imgEmpty/emptyNormal")

	local cardSkin = FightCardDataHelper.getCardSkin()
	local normalImg = gohelper.findChildImage(go, "imgEmpty/emptyNormal")
	local moveSingleImg = gohelper.findChildSingleImage(go, "imgMove/Image")

	self.moveImage = gohelper.findChildImage(go, "imgMove/Image")

	local moveImgUrl = "singlebg_lang/txt_fight/change.png"

	if cardSkin then
		UISpriteSetMgr.instance:setFightSkillCardSprite(normalImg, "card_dz5", true)

		moveImgUrl = "singlebg_lang/txt_fight/change2.png"

		if cardSkin == 672802 then
			moveImgUrl = "singlebg_lang/txt_fight/change3.png"
		elseif cardSkin == 672803 then
			moveImgUrl = "singlebg_lang/txt_fight/change4.png"
		end

		local emptyDarkBg = gohelper.cloneInPlace(self._emptyNormal.gameObject, "emptyDarkBg")

		emptyDarkBg = emptyDarkBg and gohelper.onceAddComponent(emptyDarkBg, gohelper.Type_Image)

		if emptyDarkBg then
			UISpriteSetMgr.instance:setFightSkillCardSprite(emptyDarkBg, "card_dz6", true)
		end
	end

	moveSingleImg:UnLoadImage()
	moveSingleImg:LoadImage(moveImgUrl, self.onMoveImgLoaded, self)

	self._moveGO = gohelper.findChild(go, "imgMove")
	self._moveAnimComp = self._moveGO:GetComponent(typeof(UnityEngine.Animation))
	self._lockGO = gohelper.findChild(go, "lock")

	if cardSkin then
		FightViewHandCardItem.replaceLockBg(self._lockGO)
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)
	local path = viewContainer:getSetting().otherRes[1]

	self._innerGO = viewContainer:getResInst(path, self.go, "card")

	transformhelper.setLocalScale(self._innerGO.transform, CardScale, CardScale, CardScale)
	gohelper.setSiblingBefore(self._innerGO, self._lockGO)

	self._click = SLFramework.UGUI.UIClickListener.Get(self.go)
	self._goEffect1 = gohelper.create2d(self.go, "effect1")
	self._goEffect2 = gohelper.create2d(self.go, "effect2")
	self._goEffect3 = gohelper.create2d(self.go, "effect3")

	gohelper.setSiblingBefore(self._goEffect1, self._innerGO)
	gohelper.setSiblingAfter(self._goEffect2, self._innerGO)
	gohelper.setSiblingAfter(self._goEffect3, self._innerGO)
	transformhelper.setLocalScale(self._goEffect1.transform, CardScale, CardScale, CardScale)
	transformhelper.setLocalScale(self._goEffect2.transform, CardScale, CardScale, CardScale)
	transformhelper.setLocalScale(self._goEffect3.transform, CardScale, CardScale, CardScale)
	gohelper.setActive(self._goEffect1, false)
	gohelper.setActive(self._goEffect2, false)
	gohelper.setActive(self._goEffect3, false)

	self._effectLoader1 = nil
	self._effectLoader2 = nil
	self._effectLoader3 = nil
	self._conversionGO = gohelper.findChild(go, "conversion")
	self.rankChangeRoot = gohelper.findChild(go, "#go_Grade")
	self._seasonRoot = gohelper.findChild(go, "imgEmpty/SeasonRoot")
	self._seasonEmpty1 = gohelper.findChild(go, "imgEmpty/SeasonRoot/imgEmpty1")
	self._seasonEmpty2 = gohelper.findChild(go, "imgEmpty/SeasonRoot/imgEmpty2")
	self._seasonCurActIndex = gohelper.findChild(go, "imgEmpty/SeasonRoot/#go_Selected")
	self._seasonCurActArrow = gohelper.findChild(go, "imgEmpty/SeasonRoot/image_SelectedArrow")

	local isSeason = FightModel.instance:isSeason2()

	gohelper.setActive(self._seasonRoot, isSeason)
	gohelper.setActive(self._emptyNormal, not isSeason)

	self.goASFD = gohelper.findChild(go, "asfd_icon")
	self.asfdAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goASFD)
	self.txtASFDEnergy = gohelper.findChildText(go, "asfd_icon/#txt_Num")

	gohelper.setSiblingAfter(self.goASFD, self._innerGO)

	self.loaderComp = FightGameMgr.entityMgr:addComponent(FightLoaderComponent)
	self.timerComp = FightGameMgr.entityMgr:addComponent(FightTimerComponent)
	self.msgComp = FightGameMgr.entityMgr:addComponent(FightMsgComponent)

	self.msgComp:registMsg(FightMsgId.CancelOperateWhenMeiLeiErExRound, self.onCancelOperateWhenMeiLeiErExRound, self)
end

function FightViewPlayCardItem:onMoveImgLoaded()
	self.moveImage:SetNativeSize()
end

function FightViewPlayCardItem:refreshSeasonArrowShow(newActIndex)
	gohelper.setActive(self._seasonEmpty1, newActIndex)
	gohelper.setActive(self._seasonEmpty2, not newActIndex)
	gohelper.setActive(self._seasonCurActIndex, newActIndex)
	gohelper.setActive(self._seasonCurActArrow, newActIndex)
end

function FightViewPlayCardItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function FightViewPlayCardItem:removeEventListeners()
	self._click:RemoveClickListener()
	TaskDispatcher.cancelTask(self._delayHideEffect, self)
	TaskDispatcher.cancelTask(self._delayDisableMoveAnim, self)
end

function FightViewPlayCardItem:onDestroy()
	if self.msgComp then
		self.msgComp:disposeSelf()
	end

	if self.loaderComp then
		self.loaderComp:disposeSelf()
	end

	if self.timerComp then
		self.timerComp:disposeSelf()
	end

	if self._effectLoader1 then
		self._effectLoader1:dispose()

		self._effectLoader1 = nil
	end

	if self._effectLoader2 then
		self._effectLoader2:dispose()

		self._effectLoader2 = nil
	end

	if self._effectLoader3 then
		self._effectLoader3:dispose()

		self._effectLoader3 = nil
	end

	if self.rouge2MusicLoader then
		self.rouge2MusicLoader:dispose()

		self.rouge2MusicLoader = nil
	end

	self._tailEffectGO = nil
end

function FightViewPlayCardItem:updateItem(fightBeginRoundOp)
	self.fightBeginRoundOp = fightBeginRoundOp

	local op = fightBeginRoundOp
	local isEmpty = not op
	local isMove = op and (op:isMoveCard() or op:isMoveUniversal())
	local isSkill = FightCardDataHelper.checkOpAsPlayCardHandle(op)

	gohelper.setActive(self._emtpyGO, isEmpty)
	gohelper.setActive(self._moveGO, isMove)
	TaskDispatcher.cancelTask(self._delayDisableMoveAnim, self)

	if isMove then
		self._moveAnimComp.enabled = true

		TaskDispatcher.runDelay(self._delayDisableMoveAnim, self, 1)
	end

	gohelper.setActive(self._innerGO, isSkill)

	if isSkill then
		self._cardItem = self._cardItem or MonoHelper.addNoUpdateLuaComOnceToGo(self._innerGO, FightViewCardItem, FightEnum.CardShowType.Operation)

		self._cardItem:updateItem(op.belongToEntityId, op.skillId, op.cardInfoMO)

		local entityMO = FightDataHelper.entityMgr:getById(op.belongToEntityId)
		local buffList = FightBuffHelper.simulateBuffList(entityMO, op)

		FightViewHandCardItemLock.setCardLock(op and op.belongToEntityId, op and op.skillId, self._lockGO, false, buffList, op)
		self:_setCardPreRemove(op, buffList)
		self._cardItem:detectShowBlueStar()
		self._cardItem:updateResistanceByBeginRoundOp(fightBeginRoundOp)
		self._cardItem:_showRouge2EnchantsEffect(op.cardData)

		if op:isPlayerFinisherSkill() then
			gohelper.setActive(self._lockGO, false)
		end
	else
		gohelper.setActive(self._lockGO, false)
	end

	if self.fightBeginRoundOp then
		if self.PARENTVIEW and self.PARENTVIEW.refreshRankUpDown then
			self.PARENTVIEW:refreshRankUpDown()
		end
	else
		gohelper.setActive(self.rankChangeRoot, false)
	end

	self:refreshASFDEnergy()
	self:refreshRedAndBlueArea()
end

function FightViewPlayCardItem:refreshRedAndBlueArea()
	if not self._cardItem then
		return
	end

	if self.fightBeginRoundOp then
		local color = self.fightBeginRoundOp.cardColor

		self._cardItem:setActiveRed(color == FightEnum.CardColor.Red)
		self._cardItem:setActiveBlue(color == FightEnum.CardColor.Blue)
		self._cardItem:setActiveBoth(color == FightEnum.CardColor.Both)
	end
end

function FightViewPlayCardItem:refreshASFDEnergy()
	if self.fightBeginRoundOp then
		local cardInfoMo = self.fightBeginRoundOp.cardInfoMO
		local energy = cardInfoMo and cardInfoMo.energy
		local showASFDEnergy = energy and energy > 0
		local beforeActive = self.goASFD.activeSelf

		gohelper.setActive(self.goASFD, showASFDEnergy)

		if showASFDEnergy then
			self.txtASFDEnergy.text = energy

			if beforeActive then
				self.asfdAnimatorPlayer:Play("open", self.resetToASFDIdle, self)
			end
		end
	end
end

function FightViewPlayCardItem:resetToASFDIdle()
	self.asfdAnimatorPlayer:Play("idle")
end

function FightViewPlayCardItem:playASFDCloseAnim()
	self.asfdAnimatorPlayer:Play("close", self.hideASFD, self)
end

function FightViewPlayCardItem:hideASFD()
	gohelper.setActive(self.goASFD, false)
end

function FightViewPlayCardItem:setCopyCard()
	self._isCopyCard = true
end

function FightViewPlayCardItem:isCopyCard()
	return self._isCopyCard
end

local ColorPreRemove = Color.New(1, 1, 1, 0.5)

function FightViewPlayCardItem:_setCardPreRemove(op, buffList)
	if op == nil then
		return
	end

	local canUse = FightViewHandCardItemLock.canUseCardSkill(op.belongToEntityId, op.skillId, buffList)

	if canUse then
		return
	end

	local isPreRemove = FightViewHandCardItemLock.canPreRemove(op.belongToEntityId, op.skillId, op, buffList)

	if isPreRemove then
		FightViewHandCardItemLock.setCardPreRemove(op.belongToEntityId, op.skillId, self._lockGO, false)
	end
end

function FightViewPlayCardItem:showPlayCardEffect(cardInfoMO, tailEffectGO)
	gohelper.setActive(self._emtpyGO, false)
end

function FightViewPlayCardItem:_delayHideEffect()
	gohelper.setActive(self._goEffect1, false)
	gohelper.setActive(self._goEffect2, false)
	gohelper.setActive(self._goEffect3, false)
	gohelper.destroy(self._tailEffectGO)

	self._tailEffectGO = nil
end

function FightViewPlayCardItem:hideExtMoveEffect()
	gohelper.setActive(self._conversionGO, false)
end

function FightViewPlayCardItem:showExtMoveEffect()
	gohelper.setActive(self._conversionGO, true)
end

function FightViewPlayCardItem:showExtMoveEndEffect()
	gohelper.setActive(self._conversionGO, false)
end

function FightViewPlayCardItem:_delayDisableMoveAnim()
	self._moveAnimComp.enabled = false
end

function FightViewPlayCardItem:checkPlayAddRouge2MusicEffect()
	if not self.fightBeginRoundOp then
		gohelper.setActive(self.rouge2MusicAnimGo, false)

		return
	end

	if not self.fightBeginRoundOp:isRouge2MusicSkill() then
		gohelper.setActive(self.rouge2MusicAnimGo, false)

		return
	end

	self:_playAddRouge2MusicEffect()
end

local rouge2MusicEffectPath = "ui/viewres/fight/fight_rouge2/fight_rouge2_cardineffect.prefab"

function FightViewPlayCardItem:_playAddRouge2MusicEffect()
	if not self.rouge2MusicAnim then
		if self.rouge2MusicLoader then
			return
		end

		self.rouge2MusicLoader = MultiAbLoader.New()

		self.rouge2MusicLoader:addPath(rouge2MusicEffectPath)
		self.rouge2MusicLoader:startLoad(self.onLoadRouge2MusicEffectDone, self)

		return
	end

	gohelper.setActive(self.rouge2MusicAnimGo, true)
	self.rouge2MusicAnim:Play()
end

function FightViewPlayCardItem:onLoadRouge2MusicEffectDone(loader)
	local assetItem = self.rouge2MusicLoader:getFirstAssetItem()

	if not assetItem then
		return
	end

	local prefab = assetItem:GetResource()
	local go = gohelper.clone(prefab, self.go)

	self.rouge2MusicAnimGo = go
	self.rouge2MusicAnim = gohelper.findChildComponent(go, "ani", gohelper.Type_Animation)

	self.rouge2MusicAnim:Play()
end

local filterOperateState = {}

function FightViewPlayCardItem:_onClickThis()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

	if curOperateState == FightStageMgr.OperateStateType.Discard then
		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.Discard)

		return self:_resetRoundOp()
	elseif curOperateState == FightStageMgr.OperateStateType.RecordSkill then
		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.RecordSkill)

		return self:_resetRoundOp()
	elseif curOperateState == FightStageMgr.OperateStateType.DeviceDiscard then
		FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.DeviceDiscard)

		return self:_resetRoundOp()
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if not FightDataHelper.stageMgr:isFree(filterOperateState) then
		return
	end

	return self:_resetRoundOp()
end

function FightViewPlayCardItem:_resetRoundOp()
	FightGameMgr.operateMgr:invokeCancelPlayerOperate()
end

function FightViewPlayCardItem:setPreLv(lv)
	if self._cardItem then
		self._cardItem:setPreLv(lv)
	end
end

function FightViewPlayCardItem:onCancelOperateWhenMeiLeiErExRound()
	local effectUrl = "ui/viewres/fight/fightmeileierercard.prefab"

	self.loaderComp:loadAsset(effectUrl, self.onMeiLerErEffectLoaded, self)
end

function FightViewPlayCardItem:onMeiLerErEffectLoaded(success, assetItem)
	if not success then
		return
	end

	local prefab = assetItem:GetResource()
	local go = gohelper.clone(prefab, self.go)
	local normal = gohelper.findChild(go, "#nomal")
	local unique = gohelper.findChild(go, "ultimate")

	gohelper.setActive(normal, true)
	gohelper.setActive(unique, false)

	if self._cardItem and self._cardItem.isBigSkillShow then
		gohelper.setActive(normal, false)
		gohelper.setActive(unique, true)
	end

	transformhelper.setLocalScale(go.transform, 0.78, 0.78, 0.78)
	self.timerComp:registRepeatTimer(self.removeMeiLerErEffect, self, 1.2, 1, go)
end

function FightViewPlayCardItem:removeMeiLerErEffect(go)
	gohelper.destroy(go)
end

return FightViewPlayCardItem
