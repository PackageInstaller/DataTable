-- chunkname: @modules/logic/fight/view/FightViewClothSkill.lua

module("modules.logic.fight.view.FightViewClothSkill", package.seeall)

local FightViewClothSkill = class("FightViewClothSkill", BaseView)
local State = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}
local Behavior_ChangeSub = 60004
local NeedSelectTargetDict = {
	[Behavior_ChangeSub] = true
}

function FightViewClothSkill:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "root/heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "root/heroSkill/#go_detail/#txt_detailCurCount")
	self._txtmax = gohelper.findChildText(self.viewGO, "root/heroSkill/#go_simple/skillicon/max/txtmax")
	self._heroSkillGO = gohelper.findChild(self.viewGO, "root/heroSkill")
	self._pcSkillGO = gohelper.findChild(self.viewGO, "root/heroSkill/#go_pcbtn")
	self._pcSkill1 = gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/#go_pcbtn1")
	self._pcSkill2 = gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/#go_pcbtn2")
	self._pcSkillDetail = gohelper.findChild(self.viewGO, "root/heroSkill/#go_detail/#go_pcbtn3")
	self._simpleNotCost = self:getUserDataTb_()
	self._simpleCanCost = self:getUserDataTb_()
	self._detailNotCost = self:getUserDataTb_()
	self._detailCanCost = self:getUserDataTb_()
	self._detailTxtDesc = self:getUserDataTb_()

	table.insert(self._simpleNotCost, gohelper.findChild(self._heroSkillGO, "#go_simple/skillContent/skill1/notcost1"))
	table.insert(self._simpleNotCost, gohelper.findChild(self._heroSkillGO, "#go_simple/skillContent/skill2/notcost2"))
	table.insert(self._simpleCanCost, gohelper.findChild(self._heroSkillGO, "#go_simple/skillContent/skill1/cancost1"))
	table.insert(self._simpleCanCost, gohelper.findChild(self._heroSkillGO, "#go_simple/skillContent/skill2/cancost2"))
	table.insert(self._detailNotCost, gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/skill1/notcost1"))
	table.insert(self._detailNotCost, gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/skill2/notcost2"))
	table.insert(self._detailCanCost, gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/skill1/cancost1"))
	table.insert(self._detailCanCost, gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/skill2/cancost2"))
	table.insert(self._detailTxtDesc, gohelper.findChildText(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/desc1"))
	table.insert(self._detailTxtDesc, gohelper.findChildText(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/desc2"))

	self._state = State.Simple

	local clickGO = gohelper.findChild(self._heroSkillGO, "#go_simple")

	self._click = gohelper.getClick(clickGO)
	self._animator = self._heroSkillGO:GetComponent(typeof(UnityEngine.Animator))

	self:_onUpdateSpeed()

	self._detailClick = {}

	table.insert(self._detailClick, gohelper.getClick(gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1")))
	table.insert(self._detailClick, gohelper.getClick(gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2")))

	self._cardOpAddPower = 0

	local iconContainer = gohelper.findChild(self.viewGO, "root/heroSkill/#go_simple/skilliconnew")
	local iconGO = self:getResInst(self.viewContainer:getSetting().otherRes[2], iconContainer)

	for _, clothCO in ipairs(lua_cloth.configList) do
		local icon = gohelper.findChild(iconGO, tostring(clothCO.id))

		if not gohelper.isNil(icon) then
			gohelper.setActive(icon, clothCO.id == FightModel.instance.clothId)

			if clothCO.id == FightModel.instance.clothId then
				self._dnaAnim = icon:GetComponent(typeof(UnityEngine.Animator))
			end
		end
	end

	self._maxGO = gohelper.findChild(self.viewGO, "root/heroSkill/#go_simple/skillicon/max")

	self:showKeyTips()
end

function FightViewClothSkill:addEvents()
	if not FightDataHelper.stateMgr.isReplay then
		self._click:AddClickListener(self._onClick, self)

		for i, detailIconClick in ipairs(self._detailClick) do
			detailIconClick:AddClickListener(self._onClickSkillIcon, self, i)
		end

		self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	end

	self.addEventCb(self, FightController.instance, FightEvent.DistributeCards, self._updateUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillDataUpdate, self.onClothSkillDataUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnMoveHandCard, self._onMoveHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCombineOneCard, self._onCombineOneCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterPlayClothSkill, self._onAfterPlayClothSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelOperation, self._onCancelOperation, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.SimulateClickClothSkillIcon, self._simulateClickClothSkillIcon, self)
	self.addEventCb(self, FightController.instance, FightEvent.StartReplay, self._checkStartReplay, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	self.addEventCb(self, FightController.instance, FightEvent.MasterPowerChange, self._onMasterPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnDevice_DiscardDone, self.onDevice_DiscardDone, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSkillOpen, self._onSkillKeyClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSkillIndex, self._onSkillSelect, self)
end

function FightViewClothSkill:removeEvents()
	TaskDispatcher.cancelTask(self._delayDealTouch, self)
	TaskDispatcher.cancelTask(self._sendChangeSubRequest, self)
	TaskDispatcher.cancelTask(self._sendUseClothSkillRequest, self)
	TaskDispatcher.cancelTask(self._sendUseDeviceDiscardSkillRequest, self)
	TaskDispatcher.cancelTask(self._setState, self)
	TaskDispatcher.cancelTask(self._checkAnyKey, self)
	self._click:RemoveClickListener()

	for i, detailIconClick in ipairs(self._detailClick) do
		detailIconClick:RemoveClickListener()
	end

	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	self.removeEventCb(self, FightController.instance, FightEvent.DistributeCards, self._updateUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnMoveHandCard, self._onMoveHandCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnCombineOneCard, self._onCombineOneCard, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill, self)
	self.removeEventCb(self, FightController.instance, FightEvent.AfterPlayClothSkill, self._onAfterPlayClothSkill, self)
	self.removeEventCb(self, FightController.instance, FightEvent.CancelOperation, self._onCancelOperation, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SimulateClickClothSkillIcon, self._simulateClickClothSkillIcon, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StartReplay, self._checkStartReplay, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	self.removeEventCb(self, FightController.instance, FightEvent.MasterPowerChange, self._onMasterPowerChange, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSkillOpen, self._onSkillKeyClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSkillIndex, self._onSkillSelect, self)
end

function FightViewClothSkill:onClothSkillDataUpdate()
	self._clothSkillList = nil
end

function FightViewClothSkill:onDevice_DiscardDone(index)
	if self._dnaAnim then
		self._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		self._dnaAnim:Update(0)
	end

	self.discardIndex = index

	TaskDispatcher.cancelTask(self._sendUseDeviceDiscardSkillRequest, self)
	TaskDispatcher.runDelay(self._sendUseDeviceDiscardSkillRequest, self, 0.33)
	self:_blockClick()
end

function FightViewClothSkill:_sendUseDeviceDiscardSkillRequest()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, nil, self.discardIndex)
end

function FightViewClothSkill:_onClick()
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if self._state == State.Simple then
		self._animator:Play("fight_heroskill_tips", 0, 0)
		self._animator:Update(0)

		self._state = State.Expanding

		TaskDispatcher.runDelay(self._setState, self, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
		self._pcSkillGO:SetActive(false)
		self._pcSkillDetail:SetActive(true)

		if PCInputController.instance:getIsUse() then
			TaskDispatcher.runRepeat(self._checkAnyKey, self, 0.01)
		end
	end
end

function FightViewClothSkill:checkSkillKey()
	for i, v in ipairs(BattleActivityAdapter.skillSelectKey) do
		if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.battle, v) then
			return true
		end
	end

	return false
end

function FightViewClothSkill:_checkAnyKey()
	if UnityEngine.Input.anyKeyDown and not UnityEngine.Input.GetMouseButton(0) and not self:checkSkillKey() and self._state == State.Detail then
		logNormal("FightViewClothSkill:_checkAnyKey()" .. tostring(UnityEngine.Input.anyKeyDown))
		TaskDispatcher.cancelTask(self._checkAnyKey, self)

		self._hasClickDetailIcon = nil

		self:_onSkillKeyClick()
	end
end

function FightViewClothSkill:_onSkillKeyClick()
	if not FightDataHelper.stateMgr.isReplay then
		if self._state == State.Detail then
			self:_onTouch()
		elseif self._state == State.Simple then
			self:_onClick()
		end
	end
end

function FightViewClothSkill:_onSkillSelect(index)
	if not FightDataHelper.stateMgr.isReplay then
		local skillClick = self._detailClick[index]

		if skillClick and skillClick.gameObject.activeInHierarchy then
			self:_onClickSkillIcon(index)
		end
	end
end

function FightViewClothSkill:_setState()
	if self._state == State.Expanding then
		self._state = State.Detail
	elseif self._state == State.Shrinking then
		self._state = State.Simple
	end
end

function FightViewClothSkill:_onTouch()
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		local viewParam = GuideViewMgr.instance.viewParam
		local guideGOPath = viewParam and viewParam.goPath
		local go = gohelper.find(guideGOPath)

		if go then
			for _, detailClick in ipairs(self._detailClick) do
				if detailClick.gameObject == go then
					self._hasClickDetailIcon = nil

					return
				end
			end
		end
	end

	if self._state == State.Detail then
		local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

		if curOperateState == FightStageMgr.OperateStateType.DeviceDiscard then
			return
		end

		TaskDispatcher.runDelay(self._delayDealTouch, self, 0.01)
	end
end

function FightViewClothSkill:_delayDealTouch()
	if not self._hasClickDetailIcon then
		self:_shrinkDetailUI()
	end

	self._hasClickDetailIcon = nil
end

function FightViewClothSkill:showKeyTips()
	PCInputController.instance:showkeyTips(self._pcSkillGO, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.showSkill)
	PCInputController.instance:showkeyTips(self._pcSkillDetail, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.showSkill)
	PCInputController.instance:showkeyTips(self._pcSkill1, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.skillUp)
	PCInputController.instance:showkeyTips(self._pcSkill2, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.skillDown)
end

function FightViewClothSkill:_shrinkDetailUI()
	TaskDispatcher.cancelTask(self._checkAnyKey, self)
	self._animator:Play("fight_heroskill_out", 0, 0)
	self._animator:Update(0)

	self._state = State.Shrinking

	TaskDispatcher.runDelay(self._setState, self, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
	self._pcSkillGO:SetActive(true)
	self._pcSkillDetail:SetActive(false)
end

function FightViewClothSkill:onOpen()
	self:_updateUI()
	self:_checkStartReplay()
end

function FightViewClothSkill:_onUpdateSpeed()
	self._animator.speed = FightModel.instance:getUISpeed()
end

function FightViewClothSkill:_checkStartReplay()
	if FightDataHelper.stateMgr.isReplay then
		self._click:RemoveClickListener()

		for i, detailIconClick in ipairs(self._detailClick) do
			detailIconClick:RemoveClickListener()
		end

		self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
	end
end

function FightViewClothSkill:_getClothLevelCO()
	local clothId = FightModel.instance.clothId

	if not clothId then
		return
	end

	local clothMO = PlayerClothModel.instance:getById(clothId)

	if not clothMO then
		return
	end

	local levelCOList = lua_cloth_level.configDict[clothId]

	if not levelCOList then
		return
	end

	return levelCOList[clothMO.level]
end

function FightViewClothSkill:_onPlayHandCard(cardInfoMO)
	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self._cardOpAddPower = self._cardOpAddPower + clothLevelCO.use

		self:_updateUI()
		self:_checkPlayPowerMaxAudio(self._cardOpAddPower)
	end
end

function FightViewClothSkill:_onMoveHandCard(operation, cardInfoMO)
	if FightEnum.UniversalCard[cardInfoMO.skillId] then
		return
	end

	if operation.isUnlimitMoveOrExtraMove then
		return
	end

	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self._cardOpAddPower = self._cardOpAddPower + clothLevelCO.move

		self:_updateUI()
		self:_checkPlayPowerMaxAudio(self._cardOpAddPower)
	end
end

function FightViewClothSkill:_onCombineOneCard(cardInfoMO, isUniversalCombine)
	if not cardInfoMO.combineCanAddExpoint then
		return
	end

	if isUniversalCombine then
		return
	end

	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self._cardOpAddPower = self._cardOpAddPower + clothLevelCO.compose

		self:_updateUI()
		self:_checkPlayPowerMaxAudio(self._cardOpAddPower)
	end
end

function FightViewClothSkill:_onMasterPowerChange()
	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self:_updateUI()
		self:_checkPlayPowerMaxAudio(self._cardOpAddPower)
	end
end

function FightViewClothSkill:_onStartPlayClothSkill()
	self._lockSimulation = true
	self._cardOpAddPower = 0

	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
	self:_shrinkDetailUI()
end

function FightViewClothSkill:_onAfterPlayClothSkill()
	self._lockSimulation = false
	self._cardOpAddPower = 0
end

function FightViewClothSkill:_onCancelOperation()
	self._cardOpAddPower = 0

	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
end

function FightViewClothSkill:_onRoundSequenceFinish()
	self._cardOpAddPower = 0

	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
end

function FightViewClothSkill:_getClothSkillList()
	local var_29_0

	if self._clothSkillList then
		do return self._clothSkillList end

		var_29_0 = FightModel.instance:getClothSkillList() or {}
	end

	local skillList = tabletool.copy(var_29_0)

	for i = #skillList, 1, -1 do
		if skillList[i].type ~= FightEnum.ClothSkillPerformanceType.Normal then
			table.remove(skillList, i)
		end
	end

	self._clothSkillList = skillList

	return skillList
end

function FightViewClothSkill:_canUseAnySkill()
	local power = FightModel.instance.power
	local skillList = self:_getClothSkillList()

	for i = 1, 2 do
		local skillInfo = skillList and skillList[i]

		if skillInfo then
			local skillCO = lua_skill.configDict[skillInfo.skillId]

			if skillCO then
				local canUse = skillInfo.cd <= 0 and power >= skillInfo.needPower

				if canUse then
					return true
				end
			end
		end
	end
end

function FightViewClothSkill:_updateUI()
	local skillList = self:_getClothSkillList()
	local power = FightModel.instance.power
	local pcskill = {
		self._pcSkill1,
		self._pcSkill2
	}

	for i = 1, 2 do
		local skillInfo = skillList and skillList[i]

		if skillInfo then
			local skillCO = lua_skill.configDict[skillInfo.skillId]

			if skillCO then
				local canUse = skillInfo.cd <= 0 and power >= skillInfo.needPower

				gohelper.setActive(self._simpleNotCost[i], not canUse)
				gohelper.setActive(self._simpleCanCost[i], canUse)
				gohelper.setActive(self._detailNotCost[i], not canUse)
				gohelper.setActive(self._detailCanCost[i], canUse)
				gohelper.setActive(pcskill[i], canUse)

				local desc = FightConfig.instance:getSkillEffectDesc(nil, skillCO)

				self._detailTxtDesc[i].text = desc .. "\nCOST<color=#FFA500>-" .. skillInfo.needPower .. "</color>"
			else
				logError("主角技能配置不存在，技能id = " .. skillInfo.skillId)
			end
		end
	end

	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		local curPower = power

		if not self._lockSimulation then
			curPower = curPower + self._cardOpAddPower
		end

		local maxPower = clothLevelCO.maxPower

		curPower = Mathf.Clamp(curPower, 0, maxPower)

		local prevPower = tonumber(self._txtNum.text) or 0

		self._txtNum.text = curPower
		self._txtNum1.text = curPower
		self._txtmax.text = maxPower

		gohelper.setActive(self._maxGO, curPower > 0 and curPower == maxPower)
	else
		self._txtNum.text = power
		self._txtNum1.text = power
		self._txtmax.text = ""

		gohelper.setActive(self._maxGO, false)
	end
end

function FightViewClothSkill:_onStartSequenceFinish()
	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self._cardOpAddPower = 0

		local curPower = FightModel.instance.power

		if not self._lockSimulation then
			curPower = curPower + self._cardOpAddPower
		end

		local maxPower = clothLevelCO.maxPower

		curPower = Mathf.Clamp(curPower, 0, maxPower)
		FightModel.instance.power = curPower

		self:_updateUI()
	end
end

function FightViewClothSkill:_checkPlayPowerMaxAudio(cardOpAddPower)
	if not self._prevPower then
		local clothLevelCO = self:_getClothLevelCO()
		local curPower = FightModel.instance.power + (cardOpAddPower or 0)

		if clothLevelCO then
			if not clothLevelCO.maxPower then
				local maxPower = 0

				curPower = Mathf.Clamp(curPower, 0, maxPower)

				if self._prevPower < maxPower and curPower > 0 and curPower == maxPower then
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_clothskill_power_max)
				end

				self._prevPower = curPower
			end
		end
	end
end

function FightViewClothSkill:_onClickSkillIcon(index, isReplay)
	if FightDataHelper.lockOperateMgr:isLock() and not isReplay then
		return
	end

	local clothSkillOp = self._clothSkillOp

	self._clothSkillOp = nil
	self._hasClickDetailIcon = true

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	local ops = FightDataHelper.operationDataMgr:getOpList()

	if #ops > 0 then
		GameFacade.showToast(ToastEnum.FightCardOps)

		return
	end

	local skillList = self:_getClothSkillList()
	local curPower = FightModel.instance.power
	local toUseSkillInfo = skillList and skillList[index]

	self._toUseSkillId = toUseSkillInfo and toUseSkillInfo.skillId

	if toUseSkillInfo.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	if not self._toUseSkillId or curPower < toUseSkillInfo.needPower then
		GameFacade.showToast(ToastEnum.UseSkill1)

		return
	end

	local skillConfig = lua_skill.configDict[self._toUseSkillId]
	local behaviorId = self:_checkSelectSkillTarget()

	if self._toUseSkillId == FightEnum.DeviceDiscardSkillId then
		if not FightDataHelper.handCardMgr:hasDeviceCard() then
			GameFacade.showToast(ToastEnum.FightViewClothSkill_374001)

			return
		end

		FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.DeviceDiscard)

		return
	elseif self._toUseSkillId == FightEnum.GenerateOneLevelCardSkillId then
		if FightHelper.allIsDeviceEntity() then
			GameFacade.showToast(ToastEnum.FightViewClothSkill_379011)

			return
		end

		if clothSkillOp then
			self:_selectCallback(clothSkillOp.toId)
		else
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				skillId = self._toUseSkillId,
				callback = self._selectCallback,
				callbackObj = self
			})
		end
	elseif behaviorId and behaviorId == Behavior_ChangeSub then
		if clothSkillOp then
			self._fromId = clothSkillOp.fromId
			self._toId = clothSkillOp.toId

			self:_sendChangeSubRequest()
		else
			self:_selectChangeSub()
		end
	elseif skillConfig and FightEnum.ShowLogicTargetView[skillConfig.logicTarget] and skillConfig.targetLimit == FightEnum.TargetLimit.MySide then
		if clothSkillOp then
			self:_selectCallback(clothSkillOp.toId)
		else
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				skillId = self._toUseSkillId,
				callback = self._selectCallback,
				callbackObj = self
			})
		end
	else
		self:_sendUseClothSkill()
	end
end

function FightViewClothSkill:_selectCallback(entityId)
	self._fromId = nil
	self._toId = entityId

	self:_useSkillAfterSelect()
end

function FightViewClothSkill:_useSkillAfterSelect()
	if self._dnaAnim then
		self._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		self._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(self._useSkillAfterPerformance, self, 0.33)
	self:_blockClick()
end

function FightViewClothSkill:_useSkillAfterPerformance()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, self._fromId, self._toId)
end

function FightViewClothSkill:_checkSelectSkillTarget()
	local skillCO = lua_skill.configDict[self._toUseSkillId]
	local skillEffectCO = lua_skill_effect.configDict[skillCO.skillEffect]

	if skillEffectCO then
		for i = 1, FightEnum.MaxBehavior do
			local behaviorId = tonumber(skillEffectCO["behavior" .. i])

			if behaviorId and NeedSelectTargetDict[behaviorId] then
				return behaviorId
			end
		end
	end
end

function FightViewClothSkill:_selectChangeSub()
	local list = FightDataHelper.entityMgr:getMyNormalList()
	local subList = FightDataHelper.entityMgr:getMySubList()
	local entityIds = {}
	local subEntityIds = {}

	for _, entityMO in ipairs(list) do
		table.insert(entityIds, entityMO.id)
	end

	for _, entityMO in ipairs(subList) do
		table.insert(subEntityIds, entityMO.id)
	end

	if #subEntityIds == 0 then
		GameFacade.showToast(ToastEnum.ChangeSubIsNull)

		return
	end

	self:_changeSubSelect1(entityIds, subEntityIds)
end

function FightViewClothSkill:_changeSubSelect1(entityIds, subEntityIds)
	if #entityIds <= 1 then
		self._fromId = entityIds[1]

		self:_changeSubSelect2(subEntityIds)
	else
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			callback = function(entityId)
				self._fromId = entityId

				self:_changeSubSelect2(subEntityIds)
			end,
			targetLimit = entityIds,
			desc = luaLang("fight_select_change")
		})
	end
end

function FightViewClothSkill:_changeSubSelect2(subEntityIds)
	if #subEntityIds == 1 then
		self._toId = subEntityIds[1]

		self:_sendChangeSubEntity()
	else
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			callback = function(entityId)
				self._toId = entityId

				self:_sendChangeSubEntity()
			end,
			targetLimit = subEntityIds,
			desc = luaLang("fight_select_change_sub")
		})
	end
end

function FightViewClothSkill:_sendUseClothSkill()
	if self._dnaAnim then
		self._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		self._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(self._sendUseClothSkillRequest, self, 0.33)
	self:_blockClick()
end

function FightViewClothSkill:_sendUseClothSkillRequest()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, nil, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function FightViewClothSkill:_sendChangeSubEntity()
	if self._dnaAnim then
		self._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		self._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(self._sendChangeSubRequest, self, 0.33)
	self:_blockClick()
end

function FightViewClothSkill:_sendChangeSubRequest()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, self._fromId, self._toId)
end

function FightViewClothSkill:_blockClick()
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	self.addEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)
end

function FightViewClothSkill:_cancelBlock()
	self.removeEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function FightViewClothSkill:_simulateClickClothSkillIcon(clothSkillOp)
	local targetSkillId = clothSkillOp and clothSkillOp.skillId

	if targetSkillId then
		local skillList = self:_getClothSkillList()

		for i, skillInfo in ipairs(skillList) do
			if skillInfo.skillId == targetSkillId then
				self._clothSkillOp = clothSkillOp

				self:_onClickSkillIcon(i, true)

				return
			end
		end

		logError("主角技能不存在：" .. targetSkillId .. ", " .. cjson.encode(skillList))
	end
end

return FightViewClothSkill
