-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeSkill.lua

module("modules.logic.fight.view.rouge.FightViewRougeSkill", package.seeall)

local FightViewRougeSkill = class("FightViewRougeSkill", BaseViewExtended)
local State = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}

FightViewRougeSkill.SkillSimpleItemWidth = 72
FightViewRougeSkill.BaseWidth = 156

function FightViewRougeSkill:onInitView()
	self._rougeStyleIcon = gohelper.findChildImage(self.viewGO, "heroSkill/#go_simple/faction/#image_faction")
	self._rougeStyleIconDetail = gohelper.findChildImage(self.viewGO, "heroSkill/#go_detail/faction/#image_faction")
	self._txtNum = gohelper.findChildText(self.viewGO, "heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "heroSkill/#go_detail/#txt_detailCurCount")
	self._txtmax = gohelper.findChildText(self.viewGO, "heroSkill/#go_simple/skillicon/max/txtmax")
	self._heroSkillGO = gohelper.findChild(self.viewGO, "heroSkill")
	self._state = State.Simple

	local clickGO = gohelper.findChild(self._heroSkillGO, "#go_simple")

	self._click = gohelper.getClick(clickGO)
	self._animator = self._heroSkillGO:GetComponent(typeof(UnityEngine.Animator))

	self:_onUpdateSpeed()

	self._detailClick = {}

	table.insert(self._detailClick, gohelper.getClick(gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1")))
	table.insert(self._detailClick, gohelper.getClick(gohelper.findChild(self._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2")))

	self._maxGO = gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillicon/max")
	self.rectTrSimpleBg = gohelper.findChildComponent(self.viewGO, "heroSkill/#go_simple/bg", gohelper.Type_RectTransform)
	self.goSimpleItem = gohelper.findChild(self.viewGO, "heroSkill/#go_simple/skillContent/skillitem")
	self.goDetailItem = gohelper.findChild(self.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem")

	gohelper.setActive(self.goSimpleItem, false)
	gohelper.setActive(self.goDetailItem, false)

	self.skillItemList = {}
end

function FightViewRougeSkill:addEvents()
	if not FightDataHelper.stateMgr.isReplay then
		self._click:AddClickListener(self._onClick, self)
		self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouch, self)
	end

	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.SimulateClickClothSkillIcon, self._simulateClickClothSkillIcon, self)
	self.addEventCb(self, FightController.instance, FightEvent.StartReplay, self._checkStartReplay, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeCoinChange, self._onRougeCoinChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeMagicChange, self._onRougeMagicChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeMagicLimitChange, self._onRougeMagicLimitChange, self)
end

function FightViewRougeSkill:removeEvents()
	TaskDispatcher.cancelTask(self._delayDealTouch, self)
	TaskDispatcher.cancelTask(self._sendUseClothSkillRequest, self)
	TaskDispatcher.cancelTask(self._setState, self)
	self._click:RemoveClickListener()

	for _, skillItem in ipairs(self.skillItemList) do
		skillItem.detailItem.click:RemoveClickListener()
	end
end

function FightViewRougeSkill:getSkillItem(index)
	if index <= #self.skillItemList then
		return self.skillItemList[index]
	end

	return self:createSkillItem(index)
end

function FightViewRougeSkill:createSkillItem(index)
	local skillItem = {}

	skillItem.simpleItem = self:createSimpleItem()
	skillItem.detailItem = self:createDetailItem(index)

	table.insert(self.skillItemList, skillItem)

	return skillItem
end

function FightViewRougeSkill:createSimpleItem()
	local simpleItem = self:getUserDataTb_()

	simpleItem.go = gohelper.cloneInPlace(self.goSimpleItem)
	simpleItem.imageNotCost = gohelper.findChildImage(simpleItem.go, "notcost")
	simpleItem.imageCanCost = gohelper.findChildImage(simpleItem.go, "cancost")
	simpleItem.goNotCost = simpleItem.imageNotCost.gameObject
	simpleItem.goCanCost = simpleItem.imageCanCost.gameObject

	gohelper.setActive(simpleItem.go, true)

	return simpleItem
end

function FightViewRougeSkill:createDetailItem(index)
	local detailItem = self:getUserDataTb_()

	detailItem.go = gohelper.cloneInPlace(self.goDetailItem)
	detailItem.txtDesc = gohelper.findChildText(detailItem.go, "desc")
	detailItem.imageNotCost = gohelper.findChildImage(detailItem.go, "skill/notcost")
	detailItem.imageCanCost = gohelper.findChildImage(detailItem.go, "skill/cancost")
	detailItem.goNotCost = detailItem.imageNotCost.gameObject
	detailItem.goCanCost = detailItem.imageCanCost.gameObject
	detailItem.click = gohelper.getClickWithDefaultAudio(detailItem.go)

	gohelper.setActive(detailItem.go, true)
	detailItem.click:AddClickListener(self._onClickSkillIcon, self, index)

	return detailItem
end

function FightViewRougeSkill:_onStartSequenceFinish()
	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
	self:_shrinkDetailUI()
end

function FightViewRougeSkill:_onRougeCoinChange()
	self:_updateUI()
end

function FightViewRougeSkill:_onRougeMagicChange()
	self:_updateUI()
end

function FightViewRougeSkill:_onRougeMagicLimitChange()
	self:_updateUI()
end

function FightViewRougeSkill:_onClick()
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if self._state == State.Simple then
		self._animator:Play("fight_heroskill_tips", 0, 0)
		self._animator:Update(0)

		self._state = State.Expanding

		TaskDispatcher.runDelay(self._setState, self, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
	end
end

function FightViewRougeSkill:_setState()
	if self._state == State.Expanding then
		self._state = State.Detail
	elseif self._state == State.Shrinking then
		self._state = State.Simple
	end
end

function FightViewRougeSkill:_onTouch()
	if self._state == State.Detail then
		TaskDispatcher.runDelay(self._delayDealTouch, self, 0.01)
	end
end

function FightViewRougeSkill:_delayDealTouch()
	if not self._hasClickDetailIcon then
		self:_shrinkDetailUI()
	end

	self._hasClickDetailIcon = nil
end

function FightViewRougeSkill:_shrinkDetailUI()
	self._animator:Play("fight_heroskill_out", 0, 0)
	self._animator:Update(0)

	self._state = State.Shrinking

	TaskDispatcher.runDelay(self._setState, self, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
end

function FightViewRougeSkill:onOpen()
	self:_updateUI()
	self:_checkStartReplay()
end

function FightViewRougeSkill:_onUpdateSpeed()
	self._animator.speed = FightModel.instance:getUISpeed()
end

function FightViewRougeSkill:_checkStartReplay()
	if FightDataHelper.stateMgr.isReplay then
		self._click:RemoveClickListener()

		for i, detailIconClick in ipairs(self._detailClick) do
			detailIconClick:RemoveClickListener()
		end

		self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
	end
end

function FightViewRougeSkill:_getClothLevelCO()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if not rougeInfo then
		return
	end

	local clothId = FightModel.instance.clothId

	if not clothId then
		return
	end

	if lua_rouge_style.configDict[rougeInfo.season] then
		return lua_rouge_style.configDict[rougeInfo.season][clothId]
	end
end

function FightViewRougeSkill:_onStartPlayClothSkill()
	gohelper.setActive(self.viewGO, false)
end

function FightViewRougeSkill:_onRoundSequenceFinish()
	self:_onClothSkillRoundSequenceFinish()
end

function FightViewRougeSkill:_onClothSkillRoundSequenceFinish()
	gohelper.setActive(self.viewGO, true)
	self:_updateUI()
	self:_checkPlayPowerMaxAudio()
	self:_shrinkDetailUI()
end

function FightViewRougeSkill:_canUseAnySkill()
	local skillList = FightModel.instance:getClothSkillList()

	for i = 1, 2 do
		local skillInfo = skillList and skillList[i]

		if skillInfo then
			return self:_canUseSkill(skillInfo)
		end
	end
end

function FightViewRougeSkill:_canUseSkill(skillInfo)
	local rougeSkillConfig = lua_rouge_active_skill.configDict[skillInfo.skillId]

	if rougeSkillConfig then
		local canUse = skillInfo.cd <= 0

		if self:_getMagic() < rougeSkillConfig.powerCost then
			canUse = false
		end

		local coin = self:_getCoint()

		return (coin < rougeSkillConfig.coinCost or nil) and false
	end
end

function FightViewRougeSkill:_getMagic()
	return FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Magic)
end

function FightViewRougeSkill:_getCoint()
	return FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)
end

function FightViewRougeSkill:_updateUI()
	local skillList = FightModel.instance:getClothSkillList()

	if not skillList or #skillList < 1 then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local rougeConfig = lua_rouge_style.configDict[RougeModel.instance:getSeason()]

	rougeConfig = rougeConfig and rougeConfig[FightModel.instance.clothId]

	if rougeConfig then
		UISpriteSetMgr.instance:setRouge2Sprite(self._rougeStyleIcon, rougeConfig.icon .. "_light")
		UISpriteSetMgr.instance:setRouge2Sprite(self._rougeStyleIconDetail, rougeConfig.icon .. "_light")
	end

	for index, skillInfo in ipairs(skillList) do
		local rougeSkillConfig = lua_rouge_active_skill.configDict[skillInfo.skillId]

		if rougeSkillConfig then
			local skillItem = self:getSkillItem(index)
			local iconName = rougeSkillConfig.icon

			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.simpleItem.imageNotCost, iconName)
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.simpleItem.imageCanCost, iconName)
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.detailItem.imageNotCost, iconName)
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.detailItem.imageCanCost, iconName)

			local canUse = self:_canUseSkill(skillInfo)

			gohelper.setActive(skillItem.simpleItem.goNotCost, not canUse)
			gohelper.setActive(skillItem.simpleItem.goCanCost, canUse)
			gohelper.setActive(skillItem.detailItem.goNotCost, not canUse)
			gohelper.setActive(skillItem.detailItem.goCanCost, canUse)

			local desc = rougeSkillConfig.desc

			skillItem.detailItem.txtDesc.text = desc .. "\nCOST<color=#FFA500>-" .. rougeSkillConfig.powerCost .. "</color>"
		else
			logError("流派技能配置不存在,技能id = " .. skillInfo.skillId)
		end
	end

	local bgWidth = FightViewRougeSkill.BaseWidth + #skillList * FightViewRougeSkill.SkillSimpleItemWidth

	recthelper.setWidth(self.rectTrSimpleBg, bgWidth)

	local power = self:_getMagic()
	local clothLevelCO = self:_getClothLevelCO()

	if clothLevelCO then
		local maxPower = clothLevelCO.powerLimit

		self._txtNum.text = power
		self._txtNum1.text = power
		self._txtmax.text = maxPower

		gohelper.setActive(self._maxGO, power > 0 and power == maxPower)
	else
		self._txtNum.text = power
		self._txtNum1.text = power
		self._txtmax.text = ""

		gohelper.setActive(self._maxGO, false)
	end
end

function FightViewRougeSkill:_checkPlayPowerMaxAudio()
	if not self._prevPower then
		local clothLevelCO = self:_getClothLevelCO()
		local curPower = self:_getMagic()

		if clothLevelCO then
			if not clothLevelCO.powerLimit then
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

function FightViewRougeSkill:_onClickSkillIcon(index, isReplay)
	if FightDataHelper.lockOperateMgr:isLock() and not isReplay then
		return
	end

	self._hasClickDetailIcon = true

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	local ops = FightDataHelper.operationDataMgr:getOpList()

	if #ops > 0 then
		GameFacade.showToast(ToastEnum.RougeSkillNeedCancelOperation)

		return
	end

	local skillList = FightModel.instance:getClothSkillList()
	local curPower = self:_getMagic()
	local toUseSkillInfo = skillList and skillList[index]

	self._toUseSkillId = toUseSkillInfo and toUseSkillInfo.skillId

	if toUseSkillInfo.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	local rougeSkillConfig = lua_rouge_active_skill.configDict[toUseSkillInfo.skillId]

	if not self._toUseSkillId or curPower < rougeSkillConfig.powerCost then
		GameFacade.showToast(ToastEnum.RougeSkillMagicNotEnough)

		return
	end

	local coin = self:_getCoint()

	if not self._toUseSkillId or coin < rougeSkillConfig.coinCost then
		GameFacade.showToast(ToastEnum.RougeSkillCoinNotEnough)

		return
	end

	local skillConfig = lua_skill.configDict[self._toUseSkillId]

	if skillConfig and FightEnum.ShowLogicTargetView[skillConfig.logicTarget] and skillConfig.targetLimit == FightEnum.TargetLimit.MySide then
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			skillId = self._toUseSkillId,
			callback = self._selectCallback,
			callbackObj = self
		})
	else
		self._fromId = nil
		self._toId = FightDataHelper.operationDataMgr.curSelectEntityId

		self:_sendUseClothSkill()
	end
end

function FightViewRougeSkill:_selectCallback(entityId)
	self._state = State.Simple
	self._fromId = nil
	self._toId = entityId

	self:_sendUseClothSkill()
end

function FightViewRougeSkill:_sendUseClothSkill()
	TaskDispatcher.runDelay(self._sendUseClothSkillRequest, self, 0.33)
	self:_blockClick()
end

function FightViewRougeSkill:_sendUseClothSkillRequest()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, self._fromId, self._toId, FightEnum.ClothSkillType.Rouge)
end

function FightViewRougeSkill:_blockClick()
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	self.addEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)
end

function FightViewRougeSkill:_cancelBlock()
	self.removeEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function FightViewRougeSkill:_simulateClickClothSkillIcon(clothSkillOp)
	local targetSkillId = clothSkillOp and clothSkillOp.skillId

	if targetSkillId then
		local skillList = FightModel.instance:getClothSkillList()

		for i, skillInfo in ipairs(skillList) do
			if skillInfo.skillId == targetSkillId then
				self:_onClickSkillIcon(i, true)

				return
			end
		end

		logError("主角技能不存在：" .. targetSkillId .. ", " .. cjson.encode(skillList))
	end
end

return FightViewRougeSkill
