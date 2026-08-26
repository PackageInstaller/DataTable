-- chunkname: @modules/logic/fight/view/cardeffect/FightCardPlayFlyEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardPlayFlyEffect", package.seeall)

local FightCardPlayFlyEffect = class("FightCardPlayFlyEffect", UserDataDispose)
local TimeFactor = 1
local TimeFactor2 = 0.9
local TimeFactor3 = 0.9
local cardAnchor = Vector2.New(0.5, 0.5)

function FightCardPlayFlyEffect:ctor(parent_view, card_mo, card_obj, fightBeginRoundOp)
	self:__onInit()

	local dt = 0.033 * TimeFactor

	self._fly_speed = 1 / TimeFactor2 * FightModel.instance:getUISpeed() * 2
	self._dt = dt * TimeFactor3 / FightModel.instance:getUISpeed()
	self._parent_view = parent_view
	self._card_mo = card_mo
	self._show_index = FightDataHelper.operationDataMgr:getShowIndex(fightBeginRoundOp)
	self._card_obj = card_obj
	self._fightBeginRoundOp = fightBeginRoundOp
	self._card_transform = card_obj.transform
	self._fight_view_obj = self._parent_view.viewGO
	self.playcardTransform = gohelper.findChild(self._fight_view_obj, "root/playcards").transform

	local canvas = gohelper.onceAddComponent(self._card_obj, gohelper.Type_CanvasGroup)

	canvas.interactable = false
	canvas.blocksRaycasts = false

	self._card_transform:SetParent(self.playcardTransform, true)

	self._card_transform.anchorMin = cardAnchor
	self._card_transform.anchorMax = cardAnchor

	local offsetX = recthelper.getWidth(self.playcardTransform) / 2

	recthelper.setAnchorX(self._card_transform, recthelper.getAnchorX(self._card_transform) + offsetX)
end

function FightCardPlayFlyEffect:_delayDone()
	logError("出牌的飞行流程超过了10秒,可能卡住了,先强制结束")
	self:_onPlayFlyCardDone()
end

function FightCardPlayFlyEffect:_startFly()
	TaskDispatcher.runDelay(self._delayDone, self, 10 / FightModel.instance:getUISpeed())

	self._main_flow = self:_buildAniFlow_2_1()

	self._main_flow:registerDoneListener(self._onFlowDone, self)
	self._main_flow:start()
end

function FightCardPlayFlyEffect:_onFlowDone()
	self:_onPlayFlyCardDone()
end

function FightCardPlayFlyEffect:_onPlayFlyCardDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, self._fightBeginRoundOp)
	self:releaseSelf()
	self._parent_view:onFlyDone(self)
	FightController.instance:dispatchEvent(FightEvent.PlayCardFlayFinish, self._fightBeginRoundOp)
end

function FightCardPlayFlyEffect:_buildAniFlow_2_1()
	local main_sequence = FlowSequence.New()
	local startX, startY = recthelper.getAnchor(self._card_transform)
	local targetX, targetY = self:_getPlayTargetPos()
	local offset_pos = Vector3.New(targetX - startX, targetY - startY, 0)
	local rotation = Quaternion.FromToRotation(Vector3.up, offset_pos).eulerAngles.z

	if rotation > 180 then
		rotation = rotation - 360
	end

	rotation = Mathf.Clamp(rotation, -25, 25)

	local frame_num = 2

	main_sequence:addWork(TweenWork.New({
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = self._card_transform,
		toz = rotation,
		t = self._dt * frame_num,
		ease = EaseType.linear
	}))

	local flow_stage_1 = FlowParallel.New()
	local dist = Mathf.Sqrt(Mathf.Pow(startX - targetX, 2) + Mathf.Pow(startY - targetY, 2))
	local fly_speed = 2500
	local flyTime = dist / fly_speed / self._fly_speed

	self.startAnchorX = recthelper.getAnchorX(self._card_transform)
	self.startAnchorY = recthelper.getAnchorY(self._card_transform)

	local anchorWork = TweenWork.New({
		from = 0,
		type = "DOTweenFloat",
		to = 1,
		t = flyTime,
		frameCb = self.onAnchorTweenFrame,
		cbObj = self,
		ease = EaseType.OutQuart
	})

	flow_stage_1:addWork(anchorWork)

	local start_scale = 1.14
	local end_scale = 0.72

	flow_stage_1:addWork(TweenWork.New({
		type = "DOScale",
		tr = self._card_transform,
		from = start_scale,
		to = end_scale,
		t = flyTime,
		ease = EaseType.Linear
	}))

	local flow_stage_1_revert_rotation = FlowSequence.New()

	flow_stage_1_revert_rotation:addWork(WorkWaitSeconds.New(flyTime / 2))
	flow_stage_1_revert_rotation:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = self._card_transform,
		t = flyTime / 2,
		ease = EaseType.OutCubic
	}))
	flow_stage_1:addWork(flow_stage_1_revert_rotation)
	main_sequence:addWork(flow_stage_1)

	local flow_stage_3 = FlowParallel.New()
	local sequence = FlowSequence.New()
	local tar_scale = 0.5
	local frame_num = 3

	sequence:addWork(TweenWork.New({
		type = "DOScale",
		tr = self._card_transform,
		to = tar_scale,
		t = frame_num * self._dt,
		ease = EaseType.Linear
	}))

	local tar_scale = 0.623
	local frame_num = 3

	sequence:addWork(TweenWork.New({
		type = "DOScale",
		tr = self._card_transform,
		to = tar_scale,
		t = frame_num * self._dt,
		ease = EaseType.Linear
	}))
	flow_stage_3:addWork(sequence)

	local effect_flow = FlowSequence.New()

	effect_flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.OnPlayHandCard, self._card_mo, self._waitRemoveCard)

		if GMFightShowState.cards then
			local cardSkin = FightCardDataHelper.getCardSkin()
			local entityMO = FightDataHelper.entityMgr:getById(self._card_mo.uid)
			local isBigSkill = FightCardDataHelper.isBigSkill(self._card_mo.skillId)
			local skillLevel = FightConfig.instance:getSkillLv(self._card_mo.skillId)
			local url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_01)

			if cardSkin == 672801 then
				url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_skin01)
			elseif cardSkin == 672802 then
				url = "ui/viewres/fight/fightskin/0002/ui_chupai_01.prefab"
			elseif cardSkin == 672803 then
				url = "ui/viewres/fight/fightskin/0003/ui_chupai_01.prefab"
			end

			if skillLevel < FightEnum.UniqueSkillCardLv then
				url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02)

				if cardSkin == 672801 then
					url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_skin01)
				elseif cardSkin == 672802 then
					url = "ui/viewres/fight/fightskin/0002/ui_chupai_02.prefab"
				elseif cardSkin == 672803 then
					url = "ui/viewres/fight/fightskin/0003/ui_chupai_02.prefab"
				end
			else
				url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03)

				if cardSkin == 672801 then
					url = ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_skin03)
				elseif cardSkin == 672802 then
					url = "ui/viewres/fight/fightskin/0002/ui_chupai_03.prefab"
				elseif cardSkin == 672803 then
					url = "ui/viewres/fight/fightskin/0003/ui_chupai_03.prefab"
				end
			end

			local comp = FightGameMgr.playMgr:getComponent(FightLoaderComponent)

			comp:loadAsset(url, self.onPlayEffectLoaded, self)

			if cardSkin == 672802 then
				effect_flow:addWork(WorkWaitSeconds.New(0.3))
			end

			FightController.instance:dispatchEvent(FightEvent.ShowPlayCardEffect, self._card_mo, self._show_index)
		end
	end))
	flow_stage_3:addWork(effect_flow)
	main_sequence:addWork(flow_stage_3)
	main_sequence:addWork(WorkWaitSeconds.New(0.2 / FightModel.instance:getUISpeed()))

	return main_sequence
end

function FightCardPlayFlyEffect:onPlayEffectLoaded(success, assetItem)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self._card_transform.gameObject)
end

function FightCardPlayFlyEffect:onAnchorTweenFrame(value)
	local targetX, targetY = self:_getPlayTargetPos()
	local offset_x = 0
	local offset_y = 21
	local posX = LuaTween.tween(value, self.startAnchorX, targetX - self.startAnchorX, 1, EaseType.OutQuart)
	local posY = LuaTween.tween(value, self.startAnchorY, targetY - self.startAnchorY, 1, EaseType.OutQuart)

	recthelper.setAnchor(self._card_transform, posX + offset_x, posY + offset_y)
end

function FightCardPlayFlyEffect:_getPlayTargetPos()
	local count = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()
	local content = self._parent_view._playCardItemTransform
	local finalContentX = FightViewPlayCard.calContentPosX(self._show_index, count, recthelper.getAnchorX(self._parent_view._playCardItemTransform))
	local posX, posY = FightViewPlayCard.calcCardPosX(self._show_index, count)

	posX = posX + finalContentX
	posY = posY + recthelper.getAnchorY(content)
	posY = posY - 21

	return posX, posY
end

function FightCardPlayFlyEffect:_destroyCloneCard()
	gohelper.destroy(self._card_obj)
end

function FightCardPlayFlyEffect:releaseSelf()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._main_flow then
		self._main_flow:unregisterDoneListener(self._onFlowDone, self)
		self._main_flow:stop()

		self._main_flow = nil
	end

	self:_destroyCloneCard()
	self:__onDispose()
end

return FightCardPlayFlyEffect
