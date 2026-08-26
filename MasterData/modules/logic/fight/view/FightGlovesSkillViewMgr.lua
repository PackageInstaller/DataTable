-- chunkname: @modules/logic/fight/view/FightGlovesSkillViewMgr.lua

module("modules.logic.fight.view.FightGlovesSkillViewMgr", package.seeall)

local FightGlovesSkillViewMgr = class("FightGlovesSkillViewMgr", FightBaseView)
local State = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}

function FightGlovesSkillViewMgr:onInitView()
	self._state = State.Simple
	self._animator = gohelper.findChildComponent(self.viewGO, "heroSkill", gohelper.Type_Animator)
	self.clickShowSkill = gohelper.findChildClickWithDefaultAudio(self.viewGO, "heroSkill/clickArea")
	self._txtNum = gohelper.findChildText(self.viewGO, "heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	self._txtmax = gohelper.findChildText(self.viewGO, "heroSkill/#go_simple/skillicon/max/txtmax")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "heroSkill/#go_detail/#txt_detailCurCount")
	self._txtmax1 = gohelper.findChildText(self.viewGO, "heroSkill/#go_detail/faction/#txt_simpleCurCount")
	self._simpleNotCost = {}
	self._simpleCanCost = {}
	self._detailNotCost = {}
	self._detailCanCost = {}
	self._detailTxtDesc = {}
	self._simpleNotCostIcon = {}
	self._simpleCanCostIcon = {}
	self._detailNotCostIcon = {}
	self._detailCanCostIcon = {}
	self._simpleSkillBar = {}
	self._detailSkillBar = {}
	self.skillObjItem = {}
	self.skillDetailItem = {}

	table.insert(self.skillObjItem, gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem1"))
	table.insert(self.skillObjItem, gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem2"))
	table.insert(self._simpleNotCost, gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem1/notcost"))
	table.insert(self._simpleNotCost, gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem2/notcost"))
	table.insert(self._simpleCanCost, gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem1/cancost"))
	table.insert(self._simpleCanCost, gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem2/cancost"))
	table.insert(self._simpleNotCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem1/notcost/#simage_icon"))
	table.insert(self._simpleNotCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem2/notcost/#simage_icon"))
	table.insert(self._simpleSkillBar, gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem1/notcost/#simage_bar"))
	table.insert(self._simpleSkillBar, gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem2/notcost/#simage_bar"))
	table.insert(self._simpleCanCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem1/cancost/#simage_icon"))
	table.insert(self._simpleCanCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem2/cancost/#simage_icon"))
	table.insert(self.skillDetailItem, gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1"))
	table.insert(self.skillDetailItem, gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2"))
	table.insert(self._detailNotCost, gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/skill/notcost"))
	table.insert(self._detailNotCost, gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/skill/notcost"))
	table.insert(self._detailSkillBar, gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/skill/notcost/#simage_bar"))
	table.insert(self._detailSkillBar, gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/skill/notcost/#simage_bar"))
	table.insert(self._detailCanCost, gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/skill/cancost"))
	table.insert(self._detailCanCost, gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/skill/cancost"))
	table.insert(self._detailNotCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/skill/notcost/#simage_icon"))
	table.insert(self._detailNotCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/skill/notcost/#simage_icon"))
	table.insert(self._detailCanCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/skill/cancost/#simage_icon"))
	table.insert(self._detailCanCostIcon, gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/skill/cancost/#simage_icon"))

	self.skillClick1 = gohelper.findChildClickWithDefaultAudio(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/skill/clickarea")
	self.skillClick2 = gohelper.findChildClickWithDefaultAudio(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/skill/clickarea")

	table.insert(self._detailTxtDesc, gohelper.findChildText(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem1/desc"))
	table.insert(self._detailTxtDesc, gohelper.findChildText(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem2/desc"))
	self:_onUpdateSpeed()

	self._cardOpAddPower = 0
	self._maxGO = gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillicon/max")
end

function FightGlovesSkillViewMgr:addEvents()
	if not FightDataHelper.stateMgr.isReplay then
		self:com_registClick(self.clickShowSkill, self.onClickShowSkill)
		self:com_registEvent(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouch)
	end

	self:com_registFightEvent(FightEvent.DistributeCards, self._updateUI)
	self:com_registFightEvent(FightEvent.OnClothSkillDataUpdate, self.onClothSkillDataUpdate)
	self:com_registFightEvent(FightEvent.OnPlayHandCard, self._onPlayHandCard)
	self:com_registFightEvent(FightEvent.OnMoveHandCard, self._onMoveHandCard)
	self:com_registFightEvent(FightEvent.OnCombineOneCard, self._onCombineOneCard)
	self:com_registFightEvent(FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill)
	self:com_registFightEvent(FightEvent.AfterPlayClothSkill, self._onAfterPlayClothSkill)
	self:com_registFightEvent(FightEvent.CancelOperation, self._onCancelOperation)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.SimulateClickClothSkillIcon, self._simulateClickClothSkillIcon)
	self:com_registFightEvent(FightEvent.OnUpdateSpeed, self._onUpdateSpeed)
	self:com_registFightEvent(FightEvent.MasterPowerChange, self._onMasterPowerChange)
	self:com_registFightEvent(FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish)
end

function FightGlovesSkillViewMgr:removeEvents()
	return
end

function FightGlovesSkillViewMgr:onClothSkillDataUpdate()
	self._clothSkillList = nil
end

function FightGlovesSkillViewMgr:onClickShowSkill()
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

		self:com_registTimer(self._setState, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
	else
		self._animator:Play("fight_heroskill_out", 0, 0)
		self._animator:Update(0)

		self._state = State.Simple
	end
end

function FightGlovesSkillViewMgr:_setState()
	if self._state == State.Expanding then
		self._state = State.Detail
	elseif self._state == State.Shrinking then
		self._state = State.Simple
	end
end

function FightGlovesSkillViewMgr:_onTouch()
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

		self:com_registTimer(self._delayDealTouch, 0.01)
	end
end

function FightGlovesSkillViewMgr:_delayDealTouch()
	if not self._hasClickDetailIcon then
		self:_shrinkDetailUI()
	end

	self._hasClickDetailIcon = nil
end

function FightGlovesSkillViewMgr:_shrinkDetailUI()
	self._animator:Play("fight_heroskill_out", 0, 0)
	self._animator:Update(0)

	self._state = State.Shrinking

	self:com_registTimer(self._setState, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
end

function FightGlovesSkillViewMgr:onOpen()
	local skillList = self:_getClothSkillList()

	if #skillList == 0 then
		gohelper.setActive(self.viewGO, false)

		return
	end

	self:_updateUI()
end

function FightGlovesSkillViewMgr:_onUpdateSpeed()
	self._animator.speed = FightModel.instance:getUISpeed()
end

function FightGlovesSkillViewMgr:_getClothLevelCO()
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

function FightGlovesSkillViewMgr:_onPlayHandCard(cardInfoMO)
	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self._cardOpAddPower = self._cardOpAddPower + clothLevelCO.use

		self:_updateUI()
		self:_checkPlayPowerMaxAudio(self._cardOpAddPower)
	end
end

function FightGlovesSkillViewMgr:_onMoveHandCard(operation, cardInfoMO)
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

function FightGlovesSkillViewMgr:_onCombineOneCard(cardInfoMO, isUniversalCombine)
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

function FightGlovesSkillViewMgr:_onMasterPowerChange()
	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		self:_updateUI()
		self:_checkPlayPowerMaxAudio(self._cardOpAddPower)
	end
end

function FightGlovesSkillViewMgr:_onStartPlayClothSkill()
	self._lockSimulation = true
	self._cardOpAddPower = 0

	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
	self:_shrinkDetailUI()
end

function FightGlovesSkillViewMgr:_onAfterPlayClothSkill()
	self._lockSimulation = false
	self._cardOpAddPower = 0
end

function FightGlovesSkillViewMgr:_onCancelOperation()
	self._cardOpAddPower = 0

	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
end

function FightGlovesSkillViewMgr:_onRoundSequenceFinish()
	self._cardOpAddPower = 0

	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
end

function FightGlovesSkillViewMgr:_getClothSkillList()
	local var_21_0

	if self._clothSkillList then
		do return self._clothSkillList end

		var_21_0 = FightModel.instance:getClothSkillList() or {}
	end

	local skillList = tabletool.copy(var_21_0)

	for i = #skillList, 1, -1 do
		if skillList[i].type ~= FightEnum.ClothSkillPerformanceType.Normal then
			table.remove(skillList, i)
		end
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.ShowTaoFuBen]

	if customData then
		local tempList = {}
		local activeSkillIds = customData.activeSkillIds

		for i = 1, #activeSkillIds do
			for k, v in ipairs(skillList) do
				if v.skillId == activeSkillIds[i] then
					table.insert(tempList, v)
				end
			end
		end

		skillList = tempList
	end

	self._clothSkillList = skillList

	return skillList
end

function FightGlovesSkillViewMgr:_canUseAnySkill()
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

function FightGlovesSkillViewMgr:_updateUI()
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

				if i == 1 then
					self:com_registClick(self.skillClick1, self._onClickSkillIcon, i)
				else
					self:com_registClick(self.skillClick2, self._onClickSkillIcon, i)
				end

				local iconStr

				for k, v in pairs(lua_atomic_talent.configDict) do
					local configSkillId = tonumber(string.split(v.effect, "#")[2])

					if configSkillId == skillInfo.skillId then
						iconStr = v.icon

						break
					end
				end

				if iconStr then
					UISpriteSetMgr.instance:setSp02AtomicIconSprite(self._simpleNotCostIcon[i], iconStr)
					UISpriteSetMgr.instance:setSp02AtomicIconSprite(self._detailNotCostIcon[i], iconStr)
					UISpriteSetMgr.instance:setSp02AtomicIconSprite(self._simpleCanCostIcon[i], iconStr)
					UISpriteSetMgr.instance:setSp02AtomicIconSprite(self._detailCanCostIcon[i], iconStr)
					UISpriteSetMgr.instance:setSp02AtomicIconSprite(self._simpleSkillBar[i], iconStr)
					UISpriteSetMgr.instance:setSp02AtomicIconSprite(self._detailSkillBar[i], iconStr)
				end

				self._simpleSkillBar[i].fillAmount = power / skillInfo.needPower
				self._detailSkillBar[i].fillAmount = power / skillInfo.needPower
			else
				logError("主角技能配置不存在，技能id = " .. skillInfo.skillId)
			end
		else
			gohelper.setActive(self.skillObjItem[i], false)
			gohelper.setActive(self.skillDetailItem[i], false)
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
		self._txtmax1.text = curPower

		gohelper.setActive(self._maxGO, curPower > 0 and curPower == maxPower)
	else
		self._txtNum.text = power
		self._txtNum1.text = power
		self._txtmax.text = ""
		self._txtmax1.text = power

		gohelper.setActive(self._maxGO, false)
	end
end

function FightGlovesSkillViewMgr:_onStartSequenceFinish()
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

function FightGlovesSkillViewMgr:_checkPlayPowerMaxAudio(cardOpAddPower)
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

function FightGlovesSkillViewMgr:_onClickSkillIcon(index, isReplay)
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
		GameFacade.showToast(ToastEnum.NoShowTaoSkillPower)

		return
	end

	local skillConfig = lua_skill.configDict[self._toUseSkillId]

	if skillConfig and FightEnum.ShowLogicTargetView[skillConfig.logicTarget] and skillConfig.targetLimit == FightEnum.TargetLimit.MySide then
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

function FightGlovesSkillViewMgr:_selectCallback(entityId)
	self._fromId = nil
	self._toId = entityId

	self:_useSkillAfterSelect()
end

function FightGlovesSkillViewMgr:_useSkillAfterSelect()
	if self._animator then
		self._animator:Play("fight_heroskill_out", 0, 0)
		self._animator:Update(0)
	end

	self:com_registTimer(self._useSkillAfterPerformance, 0.33)
	self:_blockClick()
end

function FightGlovesSkillViewMgr:_useSkillAfterPerformance()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, self._fromId, self._toId)
end

function FightGlovesSkillViewMgr:_sendUseClothSkill()
	self:com_registTimer(self._sendUseClothSkillRequest, 0.33)
	self:_blockClick()
end

function FightGlovesSkillViewMgr:_sendUseClothSkillRequest()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, nil, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function FightGlovesSkillViewMgr:_blockClick()
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	self:com_registFightEvent(FightEvent.RespUseClothSkillFail, self._cancelBlock)
	self:com_registFightEvent(FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock)
end

function FightGlovesSkillViewMgr:_cancelBlock()
	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function FightGlovesSkillViewMgr:_simulateClickClothSkillIcon(clothSkillOp)
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

return FightGlovesSkillViewMgr
