-- chunkname: @modules/logic/fight/view/FightBloodPoolView.lua

module("modules.logic.fight.view.FightBloodPoolView", package.seeall)

local FightBloodPoolView = class("FightBloodPoolView", FightBaseView)

function FightBloodPoolView:onConstructor(teamType)
	self.teamType = teamType
end

function FightBloodPoolView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "root")
	self.goPreTxt = gohelper.findChild(self.viewGO, "root/num/bottom/txt_preparation")
	self.bottomNumTxt = gohelper.findChildText(self.viewGO, "root/num/bottom/#txt_num")
	self.bottomPreNumTxt = gohelper.findChildText(self.viewGO, "root/num/bottom/txt_preparation/#txt_preparation")
	self.bottomNumAnimator = gohelper.findChildComponent(self.viewGO, "root/num/bottom", gohelper.Type_Animator)
	self.goLeft = gohelper.findChild(self.viewGO, "root/num/left")
	self.leftMaxTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1")
	self.leftCurTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1/#txt_num2")
	self.leftEffMaxTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1eff")
	self.leftEffCurTxt = gohelper.findChildText(self.viewGO, "root/num/left/#txt_num1eff/#txt_num2")
	self.heartAnimator = gohelper.findChildComponent(self.viewGO, "root/heart", gohelper.Type_Animator)
	self.imageHeart = gohelper.findChildImage(self.viewGO, "root/heart/unbroken/#image_heart")
	self.imageHeartPre = gohelper.findChildImage(self.viewGO, "root/heart/unbroken/#image_heart_broken")
	self.imageHeartMat = self.imageHeart.material
	self.imageHeartPreMat = self.imageHeartPre.material
	self.heightPropertyId = UnityEngine.Shader.PropertyToID("_LerpOffset")

	local goClick = gohelper.findChild(self.viewGO, "root/#btn_click")

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(goClick)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})

	self.preCostBloodValue = 0
	self.bloodPoolSkillId = FightHelper.getBloodPoolSkillId()

	gohelper.setActive(self.goPreTxt, false)
end

FightBloodPoolView.HeartTweenDuration = 0.5

function FightBloodPoolView:addEvents()
	self:com_registFightEvent(FightEvent.BloodPool_MaxValueChange, self.onMaxValueChange)
	self:com_registFightEvent(FightEvent.BloodPool_ValueChange, self.onValueChange)
	self:com_registFightEvent(FightEvent.BloodPool_OnPlayCard, self.onPlayBloodCard)
	self:com_registFightEvent(FightEvent.BloodPool_OnCancelPlayCard, self.onCancelPlayBloodCard)
	self:com_registFightEvent(FightEvent.RespBeginRound, self.onRespBeginRound)
	self:com_registFightEvent(FightEvent.BeforePlayHandCard, self.onPlayHandCard)
	self.longPress:AddClickListener(self.onClickBlood, self)
	self.longPress:AddLongPressListener(self.onLongPressBlood, self)
end

function FightBloodPoolView:onPlayHandCard(index)
	local cards = FightDataHelper.handCardMgr.handCard
	local cardInfoMO = cards and cards[index]

	if not cardInfoMO then
		return
	end

	self:calculateSkillPreCostBloodValue(cardInfoMO.skillId)
	self:refreshPreCostBloodValue()
end

FightBloodPoolView.BloodValueChangeBehaviorId = 60191

function FightBloodPoolView:calculateSkillPreCostBloodValue(skillId)
	local skillCo = skillId and lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	local skillEffectCo = lua_skill_effect.configDict[skillCo.skillEffect]

	if not skillEffectCo then
		return
	end

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillEffectCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local behaviorList = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, oneBehavior in ipairs(behaviorList) do
				local behaviorId = oneBehavior[1]

				if behaviorId == FightBloodPoolView.BloodValueChangeBehaviorId then
					self.preCostBloodValue = self.preCostBloodValue + oneBehavior[2]
				end
			end
		end
	end
end

function FightBloodPoolView:refreshPreCostBloodValue()
	local bloodPool = FightDataHelper.getBloodPool(self.teamType)
	local max = bloodPool.max
	local curValue = bloodPool.value

	curValue = curValue + self.preCostBloodValue
	curValue = math.max(math.min(max, curValue), 0)

	local txt = string.format("%s/%s", curValue, max)

	self.bottomNumTxt.text = txt
	self.bottomPreNumTxt.text = txt
	self.leftCurTxt.text = curValue
	self.leftEffCurTxt.text = curValue

	self.imageHeartPreMat:SetFloat(self.heightPropertyId, curValue / max)
	self:refreshPreTxtActive()
end

function FightBloodPoolView:refreshPreTxtActive()
	gohelper.setActive(self.goPreTxt, self.preCostBloodValue ~= 0)
end

function FightBloodPoolView:onPlayBloodCard()
	self.heartAnimator:Play("click", 0, 0)
	self:calculateSkillPreCostBloodValue(self.bloodPoolSkillId)
	self:refreshPreCostBloodValue()
end

function FightBloodPoolView:onCancelPlayBloodCard()
	self.heartAnimator:Play("idle", 0, 0)

	self.preCostBloodValue = 0

	self:directSetBloodValue()
end

function FightBloodPoolView:onRespBeginRound()
	FightDataHelper.bloodPoolDataMgr:onCancelOperation()
end

function FightBloodPoolView:onClickBlood()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	local bloodPool = FightDataHelper.getBloodPool(self.teamType)

	if not bloodPool then
		return
	end

	if bloodPool.value < 1 then
		GameFacade.showToast(ToastEnum.NotEnoughBlood)

		return
	end

	if FightDataHelper.bloodPoolDataMgr:checkPlayedCard() then
		return
	end

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playBloodPoolCard(self.bloodPoolSkillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, op)
	FightDataHelper.bloodPoolDataMgr:playBloodPoolCard()
	AudioMgr.instance:trigger(20270004)
end

function FightBloodPoolView:onLongPressBlood()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	local bloodPool = FightDataHelper.getBloodPool(self.teamType)

	if not bloodPool then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBloodPoolTipView)
end

function FightBloodPoolView:onMaxValueChange(teamType)
	if teamType ~= self.teamType then
		return
	end

	self:refreshTxt()
end

function FightBloodPoolView:onValueChange(teamType)
	if teamType ~= self.teamType then
		return
	end

	self:refreshTxt()
end

function FightBloodPoolView:onOpen()
	AudioMgr.instance:trigger(20270005)
	self:refreshTxt()
	self:showBengFaView()
end

function FightBloodPoolView:recordPreValue()
	local bloodPool = FightDataHelper.getBloodPool(self.teamType)

	self.preValue = bloodPool.value
	self.preMaxValue = bloodPool.max
end

function FightBloodPoolView:refreshTxt()
	if not self.inited then
		self:directSetBloodValue()
		self:recordPreValue()
		self.heartAnimator:Play("add", 0, 0)

		self.inited = true

		return
	end

	self:cleanHeartImageTween()

	local bloodPool = FightDataHelper.getBloodPool(self.teamType)
	local curValue = bloodPool.value
	local max = bloodPool.max

	self.valueChangeLen = curValue - self.preValue
	self.maxValueChangeLen = max - self.preMaxValue
	self.startValue = self.preValue
	self.startMaxValue = self.preMaxValue

	self:recordPreValue()

	self.heartTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightBloodPoolView.HeartTweenDuration, self.onHeartTweenFrame, self.onHeartTweenDone, self)

	self.bottomNumAnimator:Play("add", 0, 0)
	AudioMgr.instance:trigger(20270006)
	gohelper.setActive(self.goLeft, false)
	gohelper.setActive(self.goLeft, true)
end

function FightBloodPoolView:cleanHeartImageTween()
	if self.heartTweenId then
		ZProj.TweenHelper.KillById(self.heartTweenId)

		self.heartTweenId = nil
	end
end

function FightBloodPoolView:onHeartTweenFrame(value)
	local curValue = math.floor(LuaTween.linear(value, self.startValue, self.valueChangeLen, 1))
	local max = math.floor(LuaTween.linear(value, self.startMaxValue, self.maxValueChangeLen, 1))

	self:setNumAndImage(curValue, max)
end

function FightBloodPoolView:onHeartTweenDone()
	self:directSetBloodValue()
	self:recordPreValue()

	self.heartTweenId = nil
end

function FightBloodPoolView:directSetBloodValue()
	local bloodPool = FightDataHelper.getBloodPool(self.teamType)
	local curValue = bloodPool.value
	local max = bloodPool.max

	self:setNumAndImage(curValue, max)
end

local InitOffset = 0
local RealLen = 1 - InitOffset

function FightBloodPoolView:setNumAndImage(curValue, maxValue)
	local txt = string.format("%s/%s", curValue, maxValue)

	self.bottomNumTxt.text = txt
	self.bottomPreNumTxt.text = txt
	self.leftMaxTxt.text = maxValue
	self.leftCurTxt.text = curValue
	self.leftEffMaxTxt.text = maxValue
	self.leftEffCurTxt.text = curValue

	local rate = curValue / maxValue

	rate = rate * RealLen

	if rate > 0 then
		rate = rate + InitOffset
	end

	self.imageHeartMat:SetFloat(self.heightPropertyId, rate)
	self.imageHeartPreMat:SetFloat(self.heightPropertyId, rate)
	self:refreshPreTxtActive()
end

function FightBloodPoolView:showBengFaView()
	self.newClass(self, FightBengFaView, self)
end

function FightBloodPoolView:onDestroyView()
	self:cleanHeartImageTween()
	self.longPress:RemoveClickListener()
	self.longPress:RemoveLongPressListener()

	self.longPress = nil
end

return FightBloodPoolView
