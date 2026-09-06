-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwinDragonChallengeView.lua

module("logic.extensions.twindragonchallenge.view.TwinDragonChallengeView", package.seeall)

local TwinDragonChallengeView = class("TwinDragonChallengeView", ViewComponent)

function TwinDragonChallengeView:unbindEvents()
	TwinDragonChallengeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._leftChallengeBtn:RemoveClickListener()
	self._rightChallengeBtn:RemoveClickListener()
	self._oneKeyBtn:RemoveClickListener()
	self._middleChallengeBtn:RemoveClickListener()
	self._buffBtn:RemoveClickListener()
end

function TwinDragonChallengeView:bindEvents()
	TwinDragonChallengeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._leftChallengeBtn:AddClickListener(self._onClickLeftChallenge, self)
	self._rightChallengeBtn:AddClickListener(self._onClickRightChallenge, self)
	self._oneKeyBtn:AddClickListener(self._onClickOneKey, self)
	self._middleChallengeBtn:AddClickListener(self._onClickMiddleChallenge, self)
	self._buffBtn:AddClickListener(self._onClickBuff, self)
end

function TwinDragonChallengeView:buildUI()
	TwinDragonChallengeView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._tipBtn = self:getBtn("middle/tip/txtTip/btnTip")
	self._leftChallengeBtn = self:getBtn("left/challengeBtn")
	self._rightChallengeBtn = self:getBtn("right/challengeBtn")
	self._oneKeyBtn = self:getBtn("oneKeyBtn")
	self._middleRole = self:getGo("middle/role")
	self._middleChallengeBtn = self:getBtn("middle/challengeBtn")
	self._middlePower = goutil.findChildComponent(self.mainGO, "middle/PowerBg/TxtPower", "ImgNumber")
	self._leftRound = self:getTxt("left/txtRound")
	self._rightRound = self:getTxt("right/txtRound")
	self._middleTip = self:getTxt("middle/tip/txtTip")
	self._buffBtn = self:getBtn("buffBtn")
	self._buffBtnTxt = self:getTxt("buffBtn/txt")
	self._buffBtnRed = self:getGo("buffBtn/red")
	self._buffBubble = self:getGo("buffBtn/bubble")
	self._buffBubbleTxt = self:getTxt("buffBtn/bubble/Text")
end

function TwinDragonChallengeView:onExit()
	TwinDragonChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICGetMainBoardInfoRes, self._PM_ICGetMainBoardInfoRes, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICGetChallengeBoardInfoRes, self._PM_ICGetChallengeBoardInfoRes, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICBuyEndRes, self._PM_ICBuyEndRes, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICSetNewRoundsRes, self._PM_ICGetChallengeBoardInfoRes, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICAddBuffLevelRes, self._updateBuff, self)

	self._pet = RoleObjectPool.instance:removeRole(self._pet)

	removetimer(self._closeBubble, self)
end

function TwinDragonChallengeView:onEnter()
	TwinDragonChallengeView.super.onEnter(self)
	GameUtil.saveUserDayData("TwinDragonChallengeView", true)
	SurveyController.instance:reportBehavior(200498)

	self._challengeCfg = IntegrationChallengeConfig.instance:getChallengeById(IntegrationChallengeModel.TwinDragon)

	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICGetChallengeBoardInfoRes, self._PM_ICGetChallengeBoardInfoRes, self)
	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICBuyEndRes, self._PM_ICBuyEndRes, self)
	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICSetNewRoundsRes, self._PM_ICGetChallengeBoardInfoRes, self)
	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICAddBuffLevelRes, self._updateBuff, self)
	IntegrationChallengeAgent.instance:sendPM_ICGetChallengeBoardInfoReq(IntegrationChallengeModel.TwinDragon)

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("handbook", self._challengeCfg.bossRaceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._pet = RoleObjectPool.instance:addRoleToParent(self._pet, self._challengeCfg.bossRaceId, self._middleRole, scale, function(go)
		local graphic = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

		graphic.AnimationState:SetAnimation(0, "idle1", true)
		graphic:Update(0)
	end, false, x, y)

	local cfg = IntegrationChallengeConfig.instance:getStageByParam(self._challengeCfg.challengePlanId, 2, 1)

	self._middlePower:SetNum(cfg.power)

	self._openTime = GameUtil.string2time(cfg.openTime)

	if self._openTime < ServerTime.now() then
		uGuiUtil.setGoGrayState(self._oneKeyBtn.gameObject, false)

		self._middleTip.text = lang("twin_dragon_challenge_4")
	else
		uGuiUtil.setGoGrayState(self._oneKeyBtn.gameObject, true)

		local openT = GameUtil.time2date(self._openTime)

		self._middleTip.text = string.format(lang("heart_grow_up_right_time"), openT.month, openT.day, openT.hour, openT.min, openT.sec)
	end

	goutil.setActive(self._buffBubble, false)
end

function TwinDragonChallengeView:_PM_ICGetChallengeBoardInfoRes()
	local round = IntegrationChallengeModel.instance:getRound()

	self._leftRound.text = string.format(lang("twin_dragon_challenge_9"), round[1])
	self._rightRound.text = string.format(lang("twin_dragon_challenge_9"), round[2])

	self:_updateBuff()
	uGuiUtil.setGoGrayState(self._middleChallengeBtn.gameObject, round[1] == 0 or round[1] ~= round[2] or IntegrationChallengeModel.instance:getChallengeStatus() > 0)
end

function TwinDragonChallengeView:_PM_ICBuyEndRes()
	uGuiUtil.setGoGrayState(self._middleChallengeBtn.gameObject, true)
	self:close()
end

function TwinDragonChallengeView:_updateBuff()
	self._buffBtnTxt.text = "Lv " .. IntegrationChallengeModel.instance:getBuffLevel()

	local buffCfg = IntegrationChallengeConfig.instance:getBuffByPlan(self._challengeCfg.buffPlanId)

	goutil.setActive(self._buffBtnRed, not IntegrationChallengeModel.instance:getHasGainedBuff() and buffCfg[IntegrationChallengeModel.instance:getBuffLevel() + 1])
end

function TwinDragonChallengeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "twindragonchallenge")
end

function TwinDragonChallengeView:_onClickLeftChallenge()
	local round = IntegrationChallengeModel.instance:getRound()

	if round[1] ~= 0 and round[1] == round[2] then
		if IntegrationChallengeModel.instance:getChallengeStatus() == 0 then
			FloatWordMgr.instance:show(lang("twin_dragon_challenge_3"))
		elseif IntegrationChallengeModel.instance:getChallengeStatus() == 2 then
			FloatWordMgr.instance:show(lang("twin_dragon_challenge_5"))
		end
	else
		UIStateManager.instance:push(ViewName.TwinDragonChallengeEnterView, self._challengeCfg.challengePlanId, 1, 1)
	end
end

function TwinDragonChallengeView:_onClickRightChallenge()
	local round = IntegrationChallengeModel.instance:getRound()

	if round[1] ~= 0 and round[1] == round[2] then
		if IntegrationChallengeModel.instance:getChallengeStatus() == 0 then
			FloatWordMgr.instance:show(lang("twin_dragon_challenge_3"))
		elseif IntegrationChallengeModel.instance:getChallengeStatus() == 2 then
			-- block empty
		end
	else
		UIStateManager.instance:push(ViewName.TwinDragonChallengeEnterView, self._challengeCfg.challengePlanId, 1, 2)
	end
end

function TwinDragonChallengeView:_onClickOneKey()
	if self._openTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("twin_dragon_challenge_5"))

		return
	end

	local payCfg = IntegrationChallengeConfig.instance:getPayById(self._challengeCfg.payPlanId)

	PayController.instance:pay(payCfg.payGoodsId, GameEnum.PaySubGoodsType.IntegrationChallenge, IntegrationChallengeModel.TwinDragon)
end

function TwinDragonChallengeView:_onClickMiddleChallenge()
	if self._openTime > ServerTime.now() then
		FloatWordMgr.instance:show(lang("twin_dragon_challenge_5"))

		return
	end

	if IntegrationChallengeModel.instance:getChallengeStatus() == 0 then
		local round = IntegrationChallengeModel.instance:getRound()

		if round[1] ~= 0 and round[1] == round[2] then
			local stageCfg = IntegrationChallengeConfig.instance:getStageByParam(self._challengeCfg.challengePlanId, 2, 1)

			self:close()
			UIStateManager.instance:push(ViewName.TwinDragonChallengeMissionView, stageCfg)
		else
			FloatWordMgr.instance:show(lang("twin_dragon_challenge_1"))
		end
	elseif IntegrationChallengeModel.instance:getChallengeStatus() == 1 then
		-- block empty
	end
end

function TwinDragonChallengeView:_onClickBuff()
	local buffCfg = IntegrationChallengeConfig.instance:getBuffByPlan(self._challengeCfg.buffPlanId)

	if IntegrationChallengeModel.instance:getHasGainedBuff() or not buffCfg[IntegrationChallengeModel.instance:getBuffLevel() + 1] then
		goutil.setActive(self._buffBubble, true)

		self._buffBubbleTxt.text = buffCfg[IntegrationChallengeModel.instance:getBuffLevel()].desc

		settimer(3, self._closeBubble, self, false)
	else
		IntegrationChallengeAgent.instance:sendPM_ICAddBuffLevelReq(IntegrationChallengeModel.TwinDragon)
	end
end

function TwinDragonChallengeView:_closeBubble()
	goutil.setActive(self._buffBubble, false)
end

return TwinDragonChallengeView
