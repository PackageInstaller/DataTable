-- chunkname: @modules/logic/fight/view/cardeffect/FightCardCombineEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardCombineEffect", package.seeall)

local FightCardCombineEffect = class("FightCardCombineEffect", BaseWork)
local CombineUpEffectPath = "ui/viewres/fight/ui_effect_dna_d.prefab"
local TimeFactor = 1
local dt = 0.033 * TimeFactor

function FightCardCombineEffect:onStart(context)
	FightDataHelper.tempMgr.combineCount = FightDataHelper.tempMgr.combineCount + 1

	local speedOffset = FightDataHelper.tempMgr.combineCount * 0.2

	self._dt = dt / (FightModel.instance:getUISpeed() + speedOffset)

	local cards = context.cards
	local combineIndex = context.combineIndex

	self._sequence = FlowSequence.New()

	local item1 = context.handCardItemList[combineIndex]
	local item2 = context.handCardItemList[combineIndex + 1]

	item1:hideTopLayout()
	item2:hideTopLayout()

	self._universalCombineId = FightEnum.UniversalCard[item1.cardInfoMO.skillId] or FightEnum.UniversalCard[item2.cardInfoMO.skillId]

	local flow
	local containerGO = gohelper.create2d(item1.tr.parent.gameObject, "Combine")

	self._combineContainerGO = containerGO

	local posX1, posY, posZ = transformhelper.getPos(item1.tr)
	local posX2, _, _ = transformhelper.getPos(item2.tr)

	transformhelper.setPos(containerGO.transform, (posX1 + posX2) * 0.5, posY, posZ)

	local maskGO1 = gohelper.create2d(containerGO, "CombineMask1")
	local maskGO2 = gohelper.create2d(containerGO, "CombineMask2")

	transformhelper.setPos(maskGO1.transform, transformhelper.getPos(item1.tr))
	transformhelper.setPos(maskGO2.transform, transformhelper.getPos(item2.tr))
	recthelper.setSize(maskGO1.transform, 185, 272)
	recthelper.setSize(maskGO2.transform, 185, 272)
	gohelper.onceAddComponent(maskGO1, gohelper.Type_Image)
	gohelper.onceAddComponent(maskGO2, gohelper.Type_Image)

	gohelper.onceAddComponent(maskGO1, typeof(UnityEngine.UI.Mask)).showMaskGraphic = false
	gohelper.onceAddComponent(maskGO2, typeof(UnityEngine.UI.Mask)).showMaskGraphic = false

	local cloneItemGO1 = gohelper.clone(item1.go, maskGO1)
	local cloneItemGO2 = gohelper.clone(item2.go, maskGO2)
	local itemTr1 = cloneItemGO1.transform
	local itemTr2 = cloneItemGO2.transform

	gohelper.setActive(item1.go, false)
	gohelper.setActive(item2.go, false)

	cloneItemGO1.transform.anchorMin = Vector2.New(1, 0.5)
	cloneItemGO1.transform.anchorMax = Vector2.New(1, 0.5)
	cloneItemGO2.transform.anchorMin = Vector2.New(0, 0.5)
	cloneItemGO2.transform.anchorMax = Vector2.New(0, 0.5)

	recthelper.setAnchorX(itemTr1, -92.5)
	recthelper.setAnchorX(itemTr2, 92.5)
	FightCardCombineEffect._resetImages(cloneItemGO1)
	FightCardCombineEffect._resetImages(cloneItemGO2)

	local cardSkin = FightCardDataHelper.getCardSkin()
	local effectUrl = FightPreloadViewWork.ui_effect_dna_c

	if cardSkin == 672802 then
		effectUrl = FightPreloadViewWork.ui2_effect_dna_c
	elseif cardSkin == 672803 then
		effectUrl = FightPreloadViewWork.ui3_effect_dna_c
	end

	local effectGO = self:_createEffect(containerGO, effectUrl)

	effectGO.name = "CombineEffect"

	transformhelper.setPos(item1.tr, (posX1 + posX2) * 0.5, posY, posZ)
	gohelper.setActive(gohelper.findChild(cloneItemGO1, "foranim/restrain"), false)
	gohelper.setActive(gohelper.findChild(cloneItemGO2, "foranim/restrain"), false)
	gohelper.setActive(gohelper.findChild(cloneItemGO1, "foranim/spEffect"), false)
	gohelper.setActive(gohelper.findChild(cloneItemGO2, "foranim/spEffect"), false)
	gohelper.setActive(gohelper.findChild(cloneItemGO1, "foranim/lock"), false)
	gohelper.setActive(gohelper.findChild(cloneItemGO2, "foranim/lock"), false)

	local width = recthelper.getWidth(maskGO1.transform)

	flow = FlowParallel.New()

	flow:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr1,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr2,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr1,
		to = -width * 0.58,
		t = self._dt
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr2,
		to = width * 0.58,
		t = self._dt
	}))
	self._sequence:addWork(flow)

	flow = FlowParallel.New()

	flow:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr1,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr2,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr1,
		to = -width * 0.65,
		t = self._dt
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr2,
		to = width * 0.65,
		t = self._dt
	}))
	self._sequence:addWork(flow)

	flow = FlowParallel.New()

	flow:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr1,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr2,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr1,
		to = -width * 0.68,
		t = self._dt
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr2,
		to = width * 0.68,
		t = self._dt
	}))
	self._sequence:addWork(flow)

	flow = FlowParallel.New()

	flow:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr1,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr2,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr1,
		to = -width * 0.7,
		t = self._dt
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr2,
		to = width * 0.7,
		t = self._dt
	}))
	self._sequence:addWork(flow)

	flow = FlowParallel.New()

	flow:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr1,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr2,
		t = self._dt * 2
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr1,
		to = -width * 0.7,
		t = self._dt
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr2,
		to = width * 0.7,
		t = self._dt
	}))
	self._sequence:addWork(flow)
	self._sequence:addWork(FunctionWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FigthCombineCard)
	end))

	flow = FlowParallel.New()

	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr1,
		to = -width * 1.5,
		t = self._dt * 5
	}))
	flow:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = itemTr2,
		to = width * 1.5,
		t = self._dt * 5
	}))
	flow:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr1,
		t = self._dt * 5
	}))
	flow:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = itemTr2,
		t = self._dt * 5
	}))
	self._sequence:addWork(flow)

	local combine_can_add_expoint = FightCardDataHelper.combineCanAddExpoint(cards, cards[combineIndex], cards[combineIndex + 1])

	cards[combineIndex] = FightCardDataHelper.combineCardForPerformance(cards[combineIndex], cards[combineIndex + 1])
	cards[combineIndex].combineCanAddExpoint = combine_can_add_expoint

	table.remove(cards, combineIndex + 1)
	self._sequence:addWork(FunctionWork.New(function()
		local oldPosXList = FightCardCombineEffect.getCardPosXList(context.handCardItemList)

		FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, cards)

		for i = 1, #context.handCardItemList - 1 do
			local item = context.handCardItemList[i]
			local newIndex = i <= combineIndex and i or i + 1
			local posX = oldPosXList[newIndex]

			recthelper.setAnchorX(item.tr, posX)
		end

		effectGO.transform:SetParent(context.handCardItemList[combineIndex].tr.parent, true)
		gohelper.destroy(containerGO)

		local combineItemGO = context.handCardItemList[combineIndex].go
		local combineItemInnerCombineEffect = gohelper.findChild(combineItemGO, "foranim/cardeffect")

		gohelper.setActive(combineItemInnerCombineEffect, true)
	end))

	local hasNextCombine = FightCardDataHelper.canCombineCardListForPerformance(cards)
	local isDistributeStage = FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard)

	if not isDistributeStage or hasNextCombine then
		self._sequence:addWork(FightCardCombineEffect.buildCombineEndFlow(combineIndex, combineIndex, #cards, context.handCardItemList))
	end

	self._sequence:registerDoneListener(self._onCombineCardDone, self)
	self._sequence:start(context)
end

function FightCardCombineEffect:_onCombineCardDone()
	self._sequence:unregisterDoneListener(self._onCombineCardDone, self)

	local combineIndex = self.context.combineIndex
	local item1 = self.context.handCardItemList[combineIndex]
	local item2 = self.context.handCardItemList[combineIndex + 1]

	if item1 then
		item1:showTopLayout()
	end

	if item2 then
		item2:showTopLayout()
	end

	if self._universalCombineId then
		self:_createUniversalCombineEffect()
	else
		self:onDone(true)
	end
end

function FightCardCombineEffect:onStop()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
	end

	FightCardCombineEffect.super.onStop(self)
end

function FightCardCombineEffect.getCardPosXList(handCardItemList)
	local posXList = {}

	for i, item in ipairs(handCardItemList) do
		table.insert(posXList, recthelper.getAnchorX(item.tr))
	end

	return posXList
end

function FightCardCombineEffect.buildCombineEndFlow(combineIndex, moveStartIndex, moveEndIndex, items)
	local dt1 = dt / FightModel.instance:getUISpeed()
	local flow = FlowParallel.New()

	if combineIndex then
		local combineItem = items[combineIndex]

		if combineItem then
			local combineCardFlow = FlowSequence.New()
			local targetPosX = FightViewHandCard.calcCardPosX(combineIndex)

			combineCardFlow:addWork(FunctionWork.New(function()
				transformhelper.setLocalRotation(combineItem.tr, 0, -90, 0)
			end))
			combineCardFlow:addWork(TweenWork.New({
				toz = 0,
				type = "DORotate",
				tox = 0,
				toy = -45,
				tr = combineItem.tr,
				t = 1 * dt1
			}))
			combineCardFlow:addWork(TweenWork.New({
				toz = 0,
				type = "DORotate",
				tox = 0,
				toy = 0,
				tr = combineItem.tr,
				t = 1 * dt1
			}))
			combineCardFlow:addWork(TweenWork.New({
				type = "DOAnchorPos",
				toy = 0,
				tr = combineItem.tr,
				tox = targetPosX,
				t = dt1 * 4
			}))
			combineCardFlow:addWork(FunctionWork.New(function()
				local combineItemGO = combineItem.go
				local combineItemInnerCombineEffect = gohelper.findChild(combineItemGO, "foranim/cardeffect")

				gohelper.setActive(combineItemInnerCombineEffect, false)
				gohelper.destroy(gohelper.findChild(combineItem.tr.parent.gameObject, "CombineEffect"))
			end))
			flow:addWork(combineCardFlow)
		else
			logError("合牌位置错误：" .. combineIndex)
		end
	end

	if moveStartIndex > 0 then
		for i = moveStartIndex, moveEndIndex do
			if i ~= combineIndex then
				local item = items[i]
				local oneCardFlow = FlowSequence.New()
				local delay = (3 + i - moveStartIndex) * dt1

				if delay > 0 then
					oneCardFlow:addWork(WorkWaitSeconds.New(delay))
				end

				local targetPosX = FightViewHandCard.calcCardPosX(i)

				oneCardFlow:addWork(TweenWork.New({
					type = "DOAnchorPos",
					toy = 0,
					tr = item.tr,
					tox = targetPosX,
					t = dt1 * 4
				}))
				flow:addWork(oneCardFlow)
			end
		end
	end

	return flow
end

function FightCardCombineEffect:_createEffect(containerGO, effectPath)
	local effectGO = gohelper.create2d(containerGO, effectPath)

	self:_load(effectGO, effectPath)

	return effectGO
end

function FightCardCombineEffect:_load(effectGO, effectPath)
	local effectLoader = PrefabInstantiate.Create(effectGO)

	effectLoader:startLoad(effectPath, function()
		local effectOrderContainer = effectLoader:getInstGO():GetComponent(typeof(ZProj.EffectOrderContainer))

		if effectOrderContainer then
			effectOrderContainer:SetBaseOrder(2)
		end
	end)
end

function FightCardCombineEffect:_createUniversalCombineEffect()
	local handCardItem = self.context.handCardItemList[self.context.combineIndex]
	local combineUpEffectGO = gohelper.findChild(handCardItem.go, "combineUpEffect") or gohelper.create2d(handCardItem.go, "combineUpEffect")

	self._combineUpEffectLoader = PrefabInstantiate.Create(combineUpEffectGO)

	self._combineUpEffectLoader:startLoad(CombineUpEffectPath, function(loader)
		local cardLv = FightCardDataHelper.getSkillLv(handCardItem.cardInfoMO.uid, handCardItem.cardInfoMO.skillId)
		local effectGO = loader:getInstGO()
		local effectTimeScale = gohelper.onceAddComponent(effectGO, typeof(ZProj.EffectTimeScale))

		effectTimeScale:SetTimeScale(FightModel.instance:getUISpeed())
		gohelper.setActive(gohelper.findChild(effectGO, "ani/star02"), cardLv >= 2)
		gohelper.setActive(gohelper.findChild(effectGO, "ani/star03"), cardLv >= 3)
	end)
	TaskDispatcher.runDelay(self._combineUpEffectDone, self, 0.5 / FightModel.instance:getUISpeed())
end

function FightCardCombineEffect:_combineUpEffectDone()
	if self._combineUpEffectLoader then
		self._combineUpEffectLoader:dispose()
	end

	self._combineUpEffectLoader = nil

	self:onDone(true)
end

function FightCardCombineEffect:clearWork()
	if self._combineContainerGO then
		gohelper.destroy(self._combineContainerGO)

		self._combineContainerGO = nil
	end

	if self._combineUpEffectLoader then
		self._combineUpEffectLoader:dispose()
	end

	self._combineUpEffectLoader = nil

	TaskDispatcher.cancelTask(self._combineUpEffectDone, self)
end

function FightCardCombineEffect._resetImages(go)
	if not gohelper.isNil(go) then
		local images = go:GetComponentsInChildren(gohelper.Type_Image)

		for i = 0, images.Length - 1 do
			local img = images[i]

			img.maskable = true
		end
	end
end

return FightCardCombineEffect
