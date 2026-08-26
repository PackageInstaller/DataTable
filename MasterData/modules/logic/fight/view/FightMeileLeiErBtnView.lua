-- chunkname: @modules/logic/fight/view/FightMeileLeiErBtnView.lua

module("modules.logic.fight.view.FightMeileLeiErBtnView", package.seeall)

local FightMeileLeiErBtnView = class("FightMeileLeiErBtnView", FightBaseView)

function FightMeileLeiErBtnView:onOpen()
	self.parentRoot = self.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.MeiLeiErExRound)
	self.value = 0
	self.trigger = 100
	self.limit = 100

	self:refreshData()
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)

	if FightDataHelper.stageMgr:isOperateStage() then
		self:onStageChanged(FightStageMgr.StageType.Operate)
	end

	self:onViewStart()
end

function FightMeileLeiErBtnView:refreshData()
	self.value = FightDataHelper.meiLeiErExRoundDataMgr.value
	self.limit = FightDataHelper.meiLeiErExRoundDataMgr.limit
	self.trigger = FightDataHelper.meiLeiErExRoundDataMgr.trigger
end

function FightMeileLeiErBtnView:onStageChanged(stage)
	if stage == FightStageMgr.StageType.Play then
		self.showing = false

		self.viewContainer.rightBottomElementLayoutView:hideElement(FightRightBottomElementEnum.Elements.MeiLeiErExRound)
	else
		self.value = 0

		self:refreshData()

		if self.value >= self.trigger then
			self.viewContainer.rightBottomElementLayoutView:showElement(FightRightBottomElementEnum.Elements.MeiLeiErExRound)

			if self.animator then
				self.animator:Play("open", nil, nil)
				AudioMgr.instance:trigger(370101)
			end

			if not self.btn then
				self.btn = true

				local url = "ui/viewres/fight/fightleimeierbtn.prefab"

				self:com_loadAsset(url, self.onBtnLoadFinish)
			end
		else
			self.viewContainer.rightBottomElementLayoutView:hideElement(FightRightBottomElementEnum.Elements.MeiLeiErExRound)
		end
	end
end

function FightMeileLeiErBtnView:onBtnLoadFinish(success, assetItem)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, self.parentRoot)

	self.btn = obj

	local click = gohelper.getClickWithDefaultAudio(obj)

	self:com_registClick(click, self.onClick)

	self.animator = SLFramework.AnimatorPlayer.Get(obj)
end

function FightMeileLeiErBtnView:onClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if self.showing then
		return
	end

	self.showing = true

	local flow = self:com_registFlowSequence()
	local parallel = flow:registWork(FightWorkFlowParallel)

	parallel:registWork(FightWorkSendMsg, FightMsgId.CancelOperateWhenMeiLeiErExRound)
	parallel:registWork(FightWorkPlayAnimator, self.animator.gameObject, "click")
	flow:registWork(FightWorkFunction, FightGameMgr.operateMgr.invokeCancelPlayerOperate, FightGameMgr.operateMgr)

	local fightStepData = FightStepData.New(FightDef_pb.FightStep())

	fightStepData.fromId = "0"
	fightStepData.toId = "0"
	fightStepData.actId = 0
	fightStepData.actType = FightEnum.ActType.SKILL
	fightStepData.stepUid = FightTLEventEntityVisible.latestStepUid or 0

	local work = FightGameMgr.entityMgr:getMyVertin().skill:registTimelineWork("xiaoruiannong_314601_special1", fightStepData)

	parallel:addWork(work)
	flow:registWork(FightWorkFunction, GameTimeMgr.instance.setTimeScale, GameTimeMgr.instance, GameTimeMgr.TimeScaleType.FightTLEventSpeed, 1)
	flow:registWork(FightWorkSendMsg, FightMsgId.StartMeiLeiErExRound)
	flow:registWork(FightWorkPlayAnimator, self.animator.gameObject, "close")
	flow:registWork(FightWorkFunction, FightRpc.instance.sendUseClothSkillRequest, FightRpc.instance, 0, FightDataHelper.meiLeiErExRoundDataMgr.fromId, "0", FightEnum.ClothSkillType.MeiLeiErExtraRound)
	flow:registWork(FightWorkSetValue, self, "showing", false)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.SendOperation2Server)
	flow:start()
end

function FightMeileLeiErBtnView:onViewStart()
	if not FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] then
		if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] == 1 then
			local fightStepData = FightStepData.New(FightDef_pb.FightStep())

			fightStepData.fromId = "0"
			fightStepData.toId = "0"
			fightStepData.actId = 0
			fightStepData.actType = FightEnum.ActType.SKILL
			fightStepData.stepUid = FightTLEventEntityVisible.latestStepUid or 0

			local flow = self:com_registFlowSequence()
			local work = FightGameMgr.entityMgr:getMyVertin().skill:registTimelineWork("xiaoruiannong_314601_special1", fightStepData)

			flow:addWork(work)
			flow:registWork(FightWorkFunction, GameTimeMgr.instance.setTimeScale, GameTimeMgr.instance, GameTimeMgr.TimeScaleType.FightTLEventSpeed, 1)
			flow:start()
		end
	end
end

return FightMeileLeiErBtnView
