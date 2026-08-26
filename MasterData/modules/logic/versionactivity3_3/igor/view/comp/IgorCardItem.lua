-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorCardItem.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorCardItem", package.seeall)

local IgorCardItem = class("IgorCardItem", LuaCompBase)

function IgorCardItem:init(go)
	self.go = go
	self.transform = self.go.transform
	self.tr = self.transform
	self.parentTransform = self.transform.parent
	self.imgMask = gohelper.findChildImage(self.go, "mask")
	self._inCDState = false

	self:onInit()
end

function IgorCardItem:onInit()
	self.txtCost = gohelper.findChildTextMesh(self.go, "Cost/txtcost")
	self.txtName = gohelper.findChildTextMesh(self.go, "txtname")
	self.imgBg = gohelper.findChildImage(self.go, "bg")
	self.imgBgLight = gohelper.findChildImage(self.go, "bg/bg_light")
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.goMask = gohelper.findChild(self.go, "mask")
	self.goCostNoEnough = gohelper.findChild(self.go, "CostNoEnough")
end

function IgorCardItem:setCardArea(cardArea)
	self.cardArea = cardArea
end

function IgorCardItem:addEventListeners()
	self:addDrag(self.go)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGamePause, self.onGamePause, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGameCostChange, self.onGameCostChange, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnCampAttrChange, self.onCampAttrChange, self)
end

function IgorCardItem:removeEventListeners()
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGamePause, self.onGamePause, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGameCostChange, self.onGameCostChange, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnCampAttrChange, self.onCampAttrChange, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self._click then
		self._click:RemoveClickListener()
	end
end

function IgorCardItem:addDrag(go)
	if self._drag then
		return
	end

	self._click = gohelper.getClickWithAudio(go)

	self._click:AddClickListener(self.onClickCard, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self, go.transform)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function IgorCardItem:onCampAttrChange(comp, skillType)
	if skillType ~= IgorEnum.SkillType.Transfer then
		return
	end

	self:updateCardAnim()
end

function IgorCardItem:onGamePause(isPaused)
	if isPaused then
		self:pauseCD()
	else
		self:restartCD()
	end
end

function IgorCardItem:updateParam(param)
	self.param = param

	self:onUpdateParam()
end

function IgorCardItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_checkpoint_playcards)
	IgorModel.instance:setPause(true)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.parentTransform)

	self.offsetX = self.srcPosX - anchorPos.x
	self.offsetY = self.srcPosY - anchorPos.y

	self:_tweenToPos(dragTransform, anchorPos, self.offsetX, self.offsetY)

	self.inDrag = true

	gohelper.setAsLastSibling(self.go)
	self:updateTempEntityPos()
end

function IgorCardItem:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local position = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(position, self.parentTransform)

	self:_tweenToPos(dragTransform, anchorPos, self.offsetX, self.offsetY)

	self.inDrag = true

	self:updateTempEntityPos()
end

function IgorCardItem:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false

	if not self:canDrag() then
		return
	end

	local position = pointerEventData.position

	IgorModel.instance:setPause(false)

	if not self:isInCardArea(dragTransform) then
		self:onUseCard(position)
	end

	self:_tweenToPos(dragTransform, Vector2(self.srcPosX, self.srcPosY))
	self:updateTempEntityPos()
end

function IgorCardItem:_tweenToPos(transform, anchorPos, offsetX, offsetY)
	self:clearPosTween()

	offsetX = offsetX or 0
	offsetY = offsetY or 0
	self.posTweenId = ZProj.TweenHelper.DOLocalMove(transform, anchorPos.x + offsetX, anchorPos.y + offsetY, 0, 0.05, self.onTweenFinish, self)
end

function IgorCardItem:setInitPos(posX, posY)
	recthelper.setAnchor(self.transform, posX, posY)

	self.srcPosX, self.srcPosY = transformhelper.getLocalPos(self.transform)
end

function IgorCardItem:onTweenFinish()
	self:clearPosTween()
end

function IgorCardItem:isInCardArea(dragTransform)
	return ZProj.UGUIHelper.Overlaps(dragTransform, self.cardArea, CameraMgr.instance:getUICamera())
end

function IgorCardItem:canDrag()
	return self:isUnlock() and not self:isInCD() and self:isCostEnough()
end

function IgorCardItem:isUnlock()
	local gameMO = IgorModel.instance:getCurGameMo()
	local unlockLevel = self.param.unlock
	local curLevel = gameMO:getCurLevel()

	return unlockLevel <= curLevel
end

function IgorCardItem:isCostEnough()
	local gameMO = IgorModel.instance:getCurGameMo()
	local curCost = gameMO:getGameCost()
	local cardCost = self:getCost()

	return cardCost <= curCost
end

function IgorCardItem:enterCD()
	local cd = self:getCd()

	if cd > 0 then
		self:clearCDTween()

		self._inCDState = true

		gohelper.setActive(self.goMask, self._inCDState)

		if not gohelper.isNil(self.imgMask) then
			self.imgMask.fillAmount = 1
			self.cdTweenId = ZProj.TweenHelper.DOFillAmount(self.imgMask, 0, cd, self.onCDComplete, self, nil, EaseType.Linear)
		end
	end
end

function IgorCardItem:onCDComplete()
	self._inCDState = false

	gohelper.setActive(self.goMask, self._inCDState)

	if not gohelper.isNil(self.imgMask) then
		self.imgMask.fillAmount = 0
	end

	self:clearCDTween()
	self.anim:Play("ready", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_hero_skill_fight)
end

function IgorCardItem:clearCDTween()
	if self.cdTweenId then
		ZProj.TweenHelper.KillById(self.cdTweenId)

		self.cdTweenId = nil
	end
end

function IgorCardItem:isInCD()
	return self._inCDState
end

function IgorCardItem:pauseCD()
	self:clearCDTween()
end

function IgorCardItem:restartCD()
	if self:isInCD() then
		self:clearCDTween()

		local cd = self:getCd()
		local curFillAmount = self.imgMask.fillAmount
		local remainCD = curFillAmount * cd

		self.cdTweenId = ZProj.TweenHelper.DOFillAmount(self.imgMask, 0, remainCD, self.onCDComplete, self, nil, EaseType.Linear)
	end
end

function IgorCardItem:setCardVisible(isVisible)
	if self._isVisible == isVisible then
		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.go, isVisible)
end

function IgorCardItem:dispose()
	gohelper.destroy(self.go)

	self.go = nil
end

function IgorCardItem:clearPosTween()
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end
end

function IgorCardItem:onDestroy()
	self:clearCDTween()
	self:clearPosTween()
end

function IgorCardItem:onUpdateParam()
	self:refreshCard()
	self:setCardVisible(true)
end

function IgorCardItem:onGameCostChange()
	self:refreshCost()
	self:refreshUnlock()
end

function IgorCardItem:onGameLevChange()
	self:refreshUnlock()
end

function IgorCardItem:refreshCard()
	local config = self.param

	self.txtName.text = config.name

	local resName = config.isHero == 1 and string.format("card_huang_%s", config.type) or string.format("card_lan_%s", config.type)

	UISpriteSetMgr.instance:setV3a3IgorSprite(self.imgBg, resName, true)
	UISpriteSetMgr.instance:setV3a3IgorSprite(self.imgBgLight, resName, true)
	self:refreshCost()
	self:refreshUnlock()
end

function IgorCardItem:refreshUnlock()
	local isUnlock = self:isUnlock()
	local isEnough = self:isCostEnough()

	gohelper.setActive(self.goCostNoEnough, not isUnlock or not isEnough)
end

function IgorCardItem:refreshCost()
	local gameMO = IgorModel.instance:getCurGameMo()
	local curCost = gameMO:getGameCost()
	local cost = self:getCost()
	local isEnough = cost <= curCost

	self.txtCost.text = isEnough and tostring(cost) or string.format("<color=#B24444>%s</color>", cost)
end

function IgorCardItem:onUseCard(position)
	local gameMO = IgorModel.instance:getCurGameMo()
	local oursideMo = gameMO:getOursideMo()
	local skillData = oursideMo:getSkillMO(IgorEnum.SkillType.Transfer)

	if skillData:isHasRemainTimes() then
		gameMO:createSoldier(self.param.id, IgorEnum.CampType.Ourside)
		self:enterCD()
	else
		local putX, putY = gameMO:getPutTempPos()

		if putX and putY then
			gameMO:createSoldier(self.param.id, IgorEnum.CampType.Ourside, putX, putY)
			self:enterCD()
			skillData:onTransfer()
			IgorController.instance:dispatchEvent(IgorEvent.OnUseTransferSkill)
		end
	end
end

function IgorCardItem:getCost()
	return self.param.cost
end

function IgorCardItem:getCd()
	return self.param.usecd
end

function IgorCardItem:onClickCard()
	if self.inDrag or self.posTweenId ~= nil then
		return
	end

	local datas = {}

	table.insert(datas, {
		title = self.param.name,
		desc = self.param.desc
	})

	local screenPos = recthelper.uiPosToScreenPos(self.transform)
	local offsetX = self._index == 1 and -200 or -20
	local offsetY = 200

	ViewMgr.instance:openView(ViewName.IgorTipsView, {
		list = datas,
		pivot = Vector2(0.5, 0),
		screenPos = screenPos,
		offsetX = offsetX,
		offsetY = offsetY
	})
end

function IgorCardItem:updateTempEntityPos()
	if self.inDrag then
		IgorController.instance:dispatchEvent(IgorEvent.OnUpdateTempEntityPos, self.transform)
	else
		IgorController.instance:dispatchEvent(IgorEvent.OnUpdateTempEntityPos)
	end

	self:updateCardAnim()
end

function IgorCardItem:updateCardAnim()
	if self.inDrag then
		self.anim:Play("select")
	else
		local gameMO = IgorModel.instance:getCurGameMo()
		local oursideMo = gameMO:getOursideMo()
		local skillData = oursideMo:getSkillMO(IgorEnum.SkillType.Transfer)

		if skillData:isHasRemainTimes() then
			self.anim:Play("idle")
		else
			self.anim:Play("tip")
		end
	end
end

return IgorCardItem
