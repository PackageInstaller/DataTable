-- chunkname: @modules/logic/fight/view/cardeffect/FightCardEndEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardEndEffect", package.seeall)

local FightCardEndEffect = class("FightCardEndEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033
local delay_frame = 2
local PlayCardInitFlyWaitDuration = 0.2

function FightCardEndEffect:ctor()
	return
end

function FightCardEndEffect:onStart(context)
	FightCardEndEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()

	local ops = FightDataHelper.operationDataMgr:getOpList()

	self._playCardCount = 0

	for _, op in ipairs(ops) do
		if FightCardDataHelper.checkOpAsPlayCardHandle(op) then
			self._playCardCount = self._playCardCount + 1
		end
	end

	FightViewPartVisible.set(true, true, true, false, false)

	self._flow = FlowParallel.New()

	self._flow:addWork(self:_handCardFlow())
	self._flow:addWork(self:_playCardFlow())

	if self.context.deviceContainer then
		self._flow:addWork(self:_deviceFlow())
	end

	self._flow:registerDoneListener(self._onWorkDone, self)
	self._flow:start()
end

function FightCardEndEffect:onStop()
	if self._flow then
		self._flow:stop()

		if self._cloneItemGOs then
			for _, go in ipairs(self._cloneItemGOs) do
				gohelper.destroy(go)
			end

			self._cloneItemGOs = nil
		end
	end

	FightCardEndEffect.super.onStop(self)
end

function FightCardEndEffect:_handCardFlow()
	local flow = FlowParallel.New()

	self._handCardItemGOs = {}

	if self._playCardCount > 0 then
		local handCardGO = self.context.handCardContainer
		local childCount = handCardGO.transform.childCount
		local count = 1

		for i = childCount, 1, -1 do
			local cardItemGO = gohelper.findChild(handCardGO, "cardItem" .. i)

			if cardItemGO and cardItemGO.activeInHierarchy then
				local sequence = FlowSequence.New()

				sequence:addWork(WorkWaitSeconds.New(self._dt * count * 2))
				sequence:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = 18,
					tr = cardItemGO.transform,
					t = self._dt * 6,
					ease = EaseType.InOutSine
				}))
				sequence:addWork(TweenWork.New({
					type = "DOAnchorPosY",
					to = -400,
					tr = cardItemGO.transform,
					t = self._dt * 8,
					ease = EaseType.InOutSine
				}))
				flow:addWork(sequence)

				count = count + 1

				table.insert(self._handCardItemGOs, cardItemGO)
			end
		end
	else
		local handCardContainer = FightViewHandCard.handCardContainer
		local scale = FightWorkEffectDistributeCard.handCardScale
		local time = FightWorkEffectDistributeCard.getHandCardScaleTime()

		ZProj.TweenHelper.DOScale(handCardContainer.transform, scale, scale, scale, time)
	end

	return flow
end

function FightCardEndEffect:_playCardFlow()
	local main_sequence = FlowSequence.New()
	local playItemCount = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()

	if playItemCount > FightViewPlayCard.VisibleCount then
		main_sequence:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = self.context.playCardContainer,
			t = self._dt * 15
		}))

		return main_sequence
	end

	main_sequence:addWork(WorkWaitSeconds.New(PlayCardInitFlyWaitDuration))

	local flow = FlowParallel.New()
	local playCardGO = gohelper.findChild(self.context.playCardContainer, "#scroll_cards/Viewport/Content")
	local playCardTr = playCardGO.transform
	local childCount = playCardTr.childCount

	self._playCardItemGOs = {}
	self._cloneItemGOs = {}
	self._cloneOperateItemList = {}

	local clone_index = {}
	local ops = FightDataHelper.operationDataMgr:getOpList()
	local fightView = ViewMgr.instance:getContainer(ViewName.FightView)

	if fightView then
		local fightViewPlayCard = fightView.fightViewPlayCard

		if fightViewPlayCard then
			for _, op in ipairs(ops) do
				if FightCardDataHelper.checkOpAsPlayCardHandle(op) then
					local temp_index = FightDataHelper.operationDataMgr:getShowIndex(op)

					if temp_index then
						clone_index[temp_index] = {
							skillId = op.skillId,
							entityId = op.belongToEntityId
						}

						if op:needCopyCard() then
							clone_index[temp_index + 1] = {
								skillId = op.skillId,
								entityId = op.belongToEntityId
							}
						end
					else
						local temp_tab = {}

						for _, _op in ipairs(ops) do
							table.insert(temp_tab, string.format("{operType : %s, toId : %s, skillId : %s, belongToEntityId : %s, costActPoint: %s}", _op.operType, _op.toId, _op.skillId, _op.belongToEntityId, _op.costActPoint))
						end

						local ops_str = table.concat(temp_tab, "\n")

						tabletool.clear(temp_tab)

						for _, _op in ipairs(FightDataHelper.operationDataMgr:getBeginRoundOpList()) do
							table.insert(temp_tab, string.format("{operType : %s, toId : %s, skillId : %s, belongToEntityId : %s, costActPoint: %s}", _op.operType, _op.toId, _op.skillId, _op.belongToEntityId, _op.costActPoint))
						end

						local begin_round_ops_str = table.concat(temp_tab, "\n")

						logError(string.format("get temp_index fail : %s, \n ops : {%s},\n begin_round_ops : {%s}", tostring(temp_index), ops_str, begin_round_ops_str))
					end
				end
			end
		end
	end

	for i = 1, childCount do
		if clone_index[i] then
			local cardItemGO = gohelper.findChild(playCardGO, "cardItem" .. i)

			if cardItemGO then
				local cardGO = gohelper.findChild(cardItemGO, "card")

				gohelper.setActive(gohelper.findChild(cardItemGO, "#go_Grade"), false)
				table.insert(self._playCardItemGOs, cardGO)

				local cloneItemGO = gohelper.cloneInPlace(cardItemGO)

				table.insert(self._cloneItemGOs, cloneItemGO)
				cloneItemGO.transform:SetParent(self.context.handCardContainer.transform, true)
				gohelper.setActive(gohelper.findChild(cloneItemGO, "effect1"), false)
				gohelper.setActive(gohelper.findChild(cloneItemGO, "effect2"), false)
				gohelper.setActive(gohelper.findChild(cardItemGO, "lock"), false)

				local item = FightViewTempOperateCardItem.New()

				item:init(cloneItemGO, clone_index[i].skillId, clone_index[i].entityId)
				table.insert(self._cloneOperateItemList, item)
			end
		end
	end

	if fightView then
		::label_5_0::

		local var_5_0 = fightView.fightViewPlayCard

		if fightView.fightViewPlayCard then
			local lorentzRecordCardItem = fightView.fightViewPlayCard.lorenzRecordCardItem

			if lorentzRecordCardItem then
				flow:addWork(FunctionWork.New(function()
					lorentzRecordCardItem:playAnim("close")
				end))
			end

			local version = FightModel.instance:getVersion()

			for i, itemGO in ipairs(self._playCardItemGOs) do
				local itemTr = self._cloneItemGOs[i].transform
				local pos

				if version >= 1 then
					local calculatePosObj = self.context.goCalculatePosObj
					local calculatePosTr = calculatePosObj:GetComponent(gohelper.Type_RectTransform)
					local halfWidth = FightViewWaitingAreaVersion1.CardItemWidth * 0.5
					local anchorX = FightViewWaitingAreaVersion1.getCardPosByClientData(i)

					recthelper.setAnchorX(calculatePosTr, anchorX)

					pos = recthelper.rectToRelativeAnchorPos(calculatePosTr.position, itemTr.parent)
					pos.x = pos.x - halfWidth
				else
					local waitItemGO = gohelper.findChild(self.context.waitCardContainer, "cardItem" .. #self._playCardItemGOs - i + 1)

					pos = recthelper.rectToRelativeAnchorPos(waitItemGO.transform.position, itemTr.parent)
				end

				local sequence = FlowSequence.New()

				sequence:addWork(WorkWaitSeconds.New(self._dt * delay_frame * i))
				sequence:addWork(FunctionWork.New(function()
					gohelper.setActive(itemGO, false)
				end))

				local flyFlow1 = FlowParallel.New()
				local tar_scale = 1.32

				flyFlow1:addWork(TweenWork.New({
					type = "DOScale",
					tr = itemTr,
					to = tar_scale,
					t = self._dt * 5,
					ease = EaseType.easeOutQuad
				}))

				local rotate = 15

				flyFlow1:addWork(TweenWork.New({
					type = "DORotate",
					tox = 0,
					toy = 0,
					tr = itemTr,
					toz = rotate,
					t = self._dt * 5,
					ease = EaseType.easeOutQuad
				}))
				sequence:addWork(flyFlow1)

				local flyFlow2 = FlowParallel.New()
				local offset_y = -107

				flyFlow2:addWork(TweenWork.New({
					type = "DOAnchorPos",
					tr = itemTr,
					tox = pos.x,
					toy = pos.y + offset_y,
					t = self._dt * 10,
					ease = EaseType.OutCubic
				}))
				flyFlow2:addWork(TweenWork.New({
					toz = 0,
					type = "DORotate",
					tox = 0,
					toy = 0,
					tr = itemTr,
					t = self._dt * 10,
					ease = EaseType.OutCubic
				}))
				sequence:addWork(flyFlow2)
				flow:addWork(sequence)
			end

			if GMFightShowState.cards then
				flow:addWork(TweenWork.New({
					from = 1,
					type = "DOFadeCanvasGroup",
					to = 0,
					go = self.context.playCardContainer,
					t = self._dt * 15
				}))
			end

			main_sequence:addWork(flow)
			main_sequence:addWork(FightWork2Work.New(FightWorkDetectUseCardSkillId))
			main_sequence:addWork(FightWork2Work.New(FightWorkPlayHideCardCloseAnim, self))

			return main_sequence
		end
	end
end

function FightCardEndEffect:_deviceFlow()
	local main_sequence = FlowSequence.New()
	local deviceContainer = self.context.deviceContainer

	if not deviceContainer then
		return main_sequence
	end

	local playItemCount = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()

	if playItemCount > FightViewPlayCard.VisibleCount then
		main_sequence:addWork(WorkWaitSeconds.New(0.1))
	elseif self._playCardItemGOs then
		if not (#self._playCardItemGOs + 1) then
			local curFlyCount = 0
			local delay = self._dt * delay_frame * curFlyCount

			main_sequence:addWork(WorkWaitSeconds.New(delay + PlayCardInitFlyWaitDuration))
		end
	end

	main_sequence:addWork(FunctionWork.New(self.dispatchBeforeFlyDeviceArea, self))

	local rectDevice = deviceContainer:GetComponent(gohelper.Type_RectTransform)
	local anchorX = FightViewWaitingAreaVersion1.getDeviceAnchorXByClientData()
	local calculatePosObj = self.context.goCalculatePosObj
	local calculatePosTr = calculatePosObj:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorX(calculatePosTr, anchorX)

	local pos = recthelper.rectToRelativeAnchorPos(calculatePosTr.position, rectDevice.parent)
	local targetAnchorX, targetAnchorY = pos.x, pos.y
	local width = FightDeviceHelper.getDeviceAreaTotalWidth()

	width = width * 0.5

	local offsetY = FightViewDeviceAreaCardItem.DeviceOffsetY

	main_sequence:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tr = rectDevice,
		tox = targetAnchorX - width,
		toy = targetAnchorY + offsetY,
		t = self._dt * 15,
		ease = EaseType.OutCubic
	}))

	return main_sequence
end

function FightCardEndEffect:dispatchBeforeFlyDeviceArea()
	FightController.instance:dispatchEvent(FightEvent.OnDevice_BeforeFly)
end

function FightCardEndEffect:_onWorkDone()
	self._flow:unregisterDoneListener(self._onWorkDone, self)
	gohelper.setActive(self.context.playCardContainer, false)
	gohelper.setActive(self.context.waitCardContainer, true)

	if GMFightShowState.cards then
		local canvasGroup = gohelper.onceAddComponent(self.context.playCardContainer, typeof(UnityEngine.CanvasGroup))

		canvasGroup.alpha = 1
	end

	FightViewPartVisible.set(false, false, false, false, true)

	for _, go in ipairs(self._handCardItemGOs) do
		recthelper.setAnchorY(go.transform, 0)
	end

	if self._playCardItemGOs then
		for _, go in ipairs(self._playCardItemGOs) do
			recthelper.setAnchor(go.transform, 0, 0)
		end
	end

	if self._cloneItemGOs then
		for _, go in ipairs(self._cloneItemGOs) do
			gohelper.destroy(go)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnDevice_HidePlayArea)

	if self._cloneOperateItemList then
		for _, item in ipairs(self._cloneOperateItemList) do
			item:onDispose()
		end
	end

	self._playCardItemGOs = nil
	self._cloneItemGOs = nil
	self._cloneOperateItemList = nil

	self:onDone(true)
end

return FightCardEndEffect
