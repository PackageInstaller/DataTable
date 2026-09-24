-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightElementItem.lua

module("modules.logic.matchgame.fight.view.MatchGameFightElementItem", package.seeall)

local MatchGameFightElementItem = class("MatchGameFightElementItem", LuaCompBase)

function MatchGameFightElementItem:ctor(initData)
	self.elementMapCo = initData.elementCo
	self.itemType = self.elementMapCo.itemType
	self.itemParam = self.elementMapCo.param
	self.itemRootMap = self:getUserDataTb_()
	self.boxBrokenIconList = self:getUserDataTb_()
	self.posXIndex = initData.posXIndex
	self.posYIndex = initData.posYIndex
	self.sceneView = initData.sceneView
	self.poisonState = false
	self.lockState = false
	self.feverState = false
	self.poisonDamageRate = 0
	self.curBuffType = MatchGameFightEnum.BuffType.None
	self.skillBuffMoMap = {}
	self.isRemoving = false
	self.matchEffectType = MatchGameFightEnum.ItemMatchEffect.MatchNormal
end

function MatchGameFightElementItem:init(go)
	self:__onInit()

	self.go = go
	self.imageBead = gohelper.findChildImage(self.go, "root/go_bead/image_bead")
	self.goLock = gohelper.findChild(self.go, "root/go_lock")
	self.goPoison = gohelper.findChild(self.go, "root/go_poison")
	self.goSelect = gohelper.findChild(self.go, "root/go_select")
	self.goFever = gohelper.findChild(self.go, "root/go_fever")
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))

	for type, rootName in pairs(MatchGameFightEnum.ItemRoot) do
		self.itemRootMap[type] = gohelper.findChild(self.go, "root/" .. rootName)
	end

	for index = 1, 3 do
		self.boxBrokenIconList[index] = gohelper.findChild(self.go, "root/go_box/go_brokenIcon" .. index)
	end

	self.selectState = false
	self.boxBrokenCount = nil

	gohelper.setActive(self.goPoison, false)
	gohelper.setActive(self.goLock, false)
	gohelper.setActive(self.goSelect, false)
	gohelper.setActive(self.goFever, false)

	if self.itemType == MatchGameFightEnum.ElementItemType.Empty and self.itemParam == 1 then
		self.itemType, self.itemParam = MatchGameFightModel.instance:getRandomBeadType(true)
	end

	self.elementId = MatchGameFightConfig.instance:getElementId(self.itemType, self.itemParam)
	self.elementConfig = MatchGameFightConfig.instance:getElementConfig(self.elementId)
	self.isRemoving = false
	self.feverAnim = self.goFever:GetComponent(typeof(UnityEngine.Animator))
	self.lockAnim = self.goLock:GetComponent(typeof(UnityEngine.Animator))
	self.poisonAnim = self.goPoison:GetComponent(typeof(UnityEngine.Animator))
end

function MatchGameFightElementItem:addEventListeners()
	return
end

function MatchGameFightElementItem:removeEventListeners()
	return
end

function MatchGameFightElementItem:refreshUI()
	if gohelper.isNil(self.go) then
		return
	end

	for itemType, rootGO in pairs(self.itemRootMap) do
		gohelper.setActive(rootGO, itemType == self.itemType)
	end

	if self.itemType == MatchGameFightEnum.ElementItemType.Box then
		self.boxBrokenCount = self.boxBrokenCount or self.itemParam

		for index, boxBrokenIcon in ipairs(self.boxBrokenIconList) do
			gohelper.setActive(boxBrokenIcon, self.boxBrokenCount == index)
		end
	elseif self.itemType == MatchGameFightEnum.ElementItemType.Bead then
		UISpriteSetMgr.instance:setMatchGameSprite(self.imageBead, self.elementConfig.icon)
	end
end

function MatchGameFightElementItem:reduceBoxBrokenCount(count, isAllBroken)
	self.boxBrokenCount = isAllBroken and 0 or Mathf.Max(0, self.boxBrokenCount - count)

	if self.boxBrokenCount > 0 then
		local elementId = MatchGameFightConfig.instance:getElementId(self.itemType, self.boxBrokenCount)

		self:convertToOtherElement(elementId)
	end

	local dropElementType

	if self.boxBrokenCount == 0 then
		dropElementType = MatchGameFightModel.instance:getBoxDropElement()

		if dropElementType == MatchGameFightEnum.ElementItemType.Empty then
			self:playRemoveElementAnim()
		elseif dropElementType == MatchGameFightEnum.ElementItemType.Cure or dropElementType == MatchGameFightEnum.ElementItemType.Bomb then
			MatchGameFightModel.instance:setMatchElementNum(self.itemType, self.itemParam)

			local elementId = MatchGameFightConfig.instance:getElementId(dropElementType, 0)

			self:convertToOtherElement(elementId)
		end
	end

	return dropElementType
end

function MatchGameFightElementItem:setSelectState(state)
	if self.selectState == state then
		return
	end

	self.selectState = state

	gohelper.setActive(self.goSelect, self.selectState)
end

function MatchGameFightElementItem:updatePos(posXIndex, posYIndex)
	self.posXIndex = posXIndex
	self.posYIndex = posYIndex

	if gohelper.isNil(self.go) then
		return
	end

	self:setAnchorPos()

	self.go.name = "elementItem" .. posXIndex .. "_" .. posYIndex
end

function MatchGameFightElementItem:setAnchorPos()
	if gohelper.isNil(self.go) then
		return
	end

	local posX, posY = MatchGameFightModel.instance:getPlaneItemAnchorPos(self.posXIndex, self.posYIndex)

	recthelper.setAnchor(self.go.transform, posX, posY)
end

function MatchGameFightElementItem:setLockState(state)
	TaskDispatcher.cancelTask(self.hideLock, self)

	if self.lockState and not state then
		self.lockAnim:Play("close", 0, 0)
		self.lockAnim:Update(0)
		TaskDispatcher.runDelay(self.hideLock, self, 0.167)
	end

	if not self.lockState and state then
		gohelper.setActive(self.goLock, true)
		self.lockAnim:Play("open", 0, 0)
		self.lockAnim:Update(0)
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_seal)
	end

	self.lockState = state
end

function MatchGameFightElementItem:hideLock()
	gohelper.setActive(self.goLock, false)
end

function MatchGameFightElementItem:setPoisonState(state)
	TaskDispatcher.cancelTask(self.hidePoison, self)

	if self.poisonState and not state then
		self.poisonAnim:Play("close", 0, 0)
		self.poisonAnim:Update(0)
		TaskDispatcher.runDelay(self.hidePoison, self, 0.167)
	end

	if not self.poisonState and state then
		gohelper.setActive(self.goPoison, true)
		self.poisonAnim:Play("open", 0, 0)
		self.poisonAnim:Update(0)
		AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_sanxiao_poison)
	end

	self.poisonState = state

	if not self.poisonState then
		self:setPoisonDamageRate(0)
	end
end

function MatchGameFightElementItem:hidePoison()
	gohelper.setActive(self.goPoison, false)
end

function MatchGameFightElementItem:setCurBuffType(buffType)
	self.curBuffType = buffType

	local poisonState = self.curBuffType == MatchGameFightEnum.BuffType.Poison
	local lockState = self.curBuffType == MatchGameFightEnum.BuffType.Seal

	self:setLockState(lockState)
	self:setPoisonState(poisonState)
end

function MatchGameFightElementItem:setPoisonDamageRate(rate)
	self.poisonDamageRate = rate
end

function MatchGameFightElementItem:setFeverState(state)
	TaskDispatcher.cancelTask(self.hideFever, self)

	if not state then
		self.feverAnim:Play("close", 0, 0)
		self.feverAnim:Update(0)
		TaskDispatcher.runDelay(self.hideFever, self, 0.167)
	end

	if not self.feverState and state then
		gohelper.setActive(self.goFever, true)
		self.feverAnim:Play("open", 0, 0)
		self.feverAnim:Update(0)
	end

	self.feverState = state
end

function MatchGameFightElementItem:hideFever()
	gohelper.setActive(self.goFever, false)
end

function MatchGameFightElementItem:doItemAnchorPosMove(targetPosXIndex, targetPosYIndex, needArriveAnim)
	self.targetPosXIndex = targetPosXIndex
	self.targetPosYIndex = targetPosYIndex
	self.needArriveAnim = needArriveAnim

	if self.isRemoving or gohelper.isNil(self.go) then
		if self.sceneView then
			self.sceneView:onElementMoveStepDone()
		end

		return
	end

	if self.targetPosXIndex == self.posXIndex and self.targetPosYIndex == self.posYIndex then
		if self.sceneView then
			self.sceneView:onElementMoveStepDone()
		end

		return
	end

	local targetPosX, targetPosY = MatchGameFightModel.instance:getPlaneItemAnchorPos(targetPosXIndex, targetPosYIndex)
	local moveTime = MatchGameFightEnum.ElementMoveTime

	self.moveTweenId = ZProj.TweenHelper.DOAnchorPos(self.go.transform, targetPosX, targetPosY, moveTime, self.doItemAnchorPosMoveFinish, self)
end

function MatchGameFightElementItem:doItemAnchorPosMoveFinish()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end

	if not gohelper.isNil(self.go) then
		self:updatePos(self.targetPosXIndex, self.targetPosYIndex)

		if self.needArriveAnim then
			self.needArriveAnim = nil

			self:playAnim("rebound")
		end
	end

	if self.sceneView then
		self.sceneView:onElementMoveStepDone()
	end
end

function MatchGameFightElementItem:convertToOtherElement(elementId)
	if self.elementId == elementId then
		return
	end

	TaskDispatcher.cancelTask(self.refreshUI, self)
	self:playAnim("switch")

	self.elementId = elementId
	self.elementConfig = MatchGameFightConfig.instance:getElementConfig(self.elementId)
	self.itemType = self.elementConfig.type
	self.itemParam = tonumber(self.elementConfig.param)

	if self.itemType == MatchGameFightEnum.ElementItemType.Bomb or self.itemType == MatchGameFightEnum.ElementItemType.Cure then
		local viewContent = self.sceneView:getViewContent()

		MatchGameSkillBuffHandler.instance:removeTargetBuffByEffectType(self, MatchGameFightEnum.BuffEffectType.Poison, viewContent)
	end

	TaskDispatcher.runDelay(self.refreshUI, self, 0.167)
end

function MatchGameFightElementItem:getTargetBuffMoByBuffType(buffType)
	local targetSkillBuffList = {}

	for buffUid, skillBuffMo in pairs(self.skillBuffMoMap) do
		if skillBuffMo.buffConfig.buffType == buffType then
			table.insert(targetSkillBuffList, skillBuffMo)
		end
	end

	return targetSkillBuffList
end

function MatchGameFightElementItem:playRemoveElementAnim()
	if self.isRemoving then
		return
	end

	MatchGameFightModel.instance:setMatchElementNum(self.itemType, self.itemParam)
	self:doPlayRemoveElementAnim()
	AudioMgr.instance:trigger(MatchGameAudioEnum.play_ui_yingmen_xiaochu_ordinary)
end

function MatchGameFightElementItem:doPlayRemoveElementAnim()
	if self.isRemoving then
		return
	end

	self:setSelectState(false)

	self.isRemoving = true

	self:playAnim("close")

	if self:checkCanShowMatchEffect() then
		self.sceneView:showElementEffect(self.matchEffectType, self.posXIndex, self.posYIndex)
	end

	TaskDispatcher.runDelay(self.removeElementItem, self, MatchGameFightEnum.MatchTime)
end

function MatchGameFightElementItem:checkCanShowMatchEffect()
	local heroCareerMap = MatchGameFightModel.instance:getHeroCareerMap()

	if self.itemType == MatchGameFightEnum.ElementItemType.Bead and (not heroCareerMap or not heroCareerMap[self.itemParam]) and self.matchEffectType == MatchGameFightEnum.ItemMatchEffect.MatchNormal then
		return false
	end

	return true
end

function MatchGameFightElementItem:checkIsEmpty()
	return self.itemType == MatchGameFightEnum.ElementItemType.Empty and self.itemParam == 0
end

function MatchGameFightElementItem:playAnim(animName)
	if self.anim then
		self.anim:Play(animName, 0, 0)
		self.anim:Update(0)
	end
end

function MatchGameFightElementItem:setMatchEffectType(effectType)
	self.matchEffectType = effectType
end

function MatchGameFightElementItem:removeElementItem()
	self.sceneView:removeElementItem(self.posXIndex, self.posYIndex)
end

function MatchGameFightElementItem:cancelRemoveElementItem()
	self.isRemoving = false

	self:playAnim("idle")
	TaskDispatcher.cancelTask(self.removeElementItem, self)
end

function MatchGameFightElementItem:onDestroy()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end

	TaskDispatcher.cancelTask(self.removeElementItem, self)
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.cancelTask(self.hideLock, self)
	TaskDispatcher.cancelTask(self.hidePoison, self)
	TaskDispatcher.cancelTask(self.hideFever, self)
end

return MatchGameFightElementItem
