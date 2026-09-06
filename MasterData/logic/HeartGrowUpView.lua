-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartGrowUpView.lua

module("logic.extensions.growup.view.HeartGrowUpView", package.seeall)

local HeartGrowUpView = class("HeartGrowUpView", ViewComponent)

function HeartGrowUpView:unbindEvents()
	HeartGrowUpView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._fitBtn:RemoveClickListener()
	self._leftInviteBtn:RemoveClickListener()
	self._leftGrowBtn:RemoveClickListener()
	self._rightInviteBtn:RemoveClickListener()
	self._rightGrowBtn:RemoveClickListener()
	self._rightHelpBtn:RemoveClickListener()
	self._rightChallengeBtn:RemoveClickListener()
	self._finishTip:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
end

function HeartGrowUpView:bindEvents()
	HeartGrowUpView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
	self._fitBtn:AddClickListener(self._onClickFit, self)
	self._leftInviteBtn:AddClickListener(self._onClickLeftInvite, self)
	self._leftGrowBtn:AddClickListener(self._onClickLeftGrow, self)
	self._rightInviteBtn:AddClickListener(self._onClickRightInvite, self)
	self._rightGrowBtn:AddClickListener(self._onClickRightGrow, self)
	self._rightHelpBtn:AddClickListener(self._onClickHelp, self)
	self._rightChallengeBtn:AddClickListener(self._onClickRightChallenge, self)
	self._finishTip:AddClickListener(self._onClickFinishTip, self)
	self._shopBtn:AddClickListener(self._onClickShop, self)
end

function HeartGrowUpView:buildUI()
	HeartGrowUpView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._tipBtn = self:getBtn("topleft/btnTip")
	self._middle = self:getGo("middle/role")
	self._middleRole2 = self:getGo("middle/role2")
	self._middleTime = self:getTxt("middle/time")
	self._middleInfo = self:getGo("middle/info")
	self._middleTimeBg = goutil.findChildComponent(self.mainGO, "middle", goutil.Type_UIImage)
	self._fitBtn = self:getBtn("middle/fitBtn")
	self._fitBtnText = self:getTxt("middle/fitBtn/Text")
	self._fitBtnRed = self:getGo("middle/fitBtn/red")
	self._left = self:getGo("left/role")
	self._leftInviteBtn = self:getBtn("left/inviteBtn")
	self._leftGrowBtn = self:getBtn("left/growBtn")
	self._leftGrowBtnRed = self:getGo("left/growBtn/red")
	self._rightHelpBtn = self:getBtn("right/help")
	self._rightHelpBubble = self:getGo("right/help/bubble")
	self._right = self:getGo("right/role")
	self._rightInviteBtn = self:getBtn("right/inviteBtn")
	self._rightGrowBtn = self:getBtn("right/growBtn")
	self._rightGrowBtnRed = self:getGo("right/growBtn/red")
	self._rightHelp = self:getGo("right/info/help")
	self._rightTimeBg = self:getGo("right/timebg")
	self._rightTime = self:getTxt("right/time")
	self._rightChallengeBtn = self:getBtn("right/challengeBtn")
	self._finishTip = self:getBtn("finishTip")
	self._rightTip = self:getGo("right/tip")
	self._shopGoods = self:getGo("shopItemGo/shopGoods")
	self._shopBtn = self:getBtn("shopItemGo/shopBtn")
	self._mask = self:getGo("mask")
end

function HeartGrowUpView:onExit()
	HeartGrowUpView.super.onExit(self)
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathGainPetRes, self._updatePet, self)
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathGetInfoRes, self._updatePet, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICGetMainBoardInfoRes, self._PM_ICGetMainBoardInfoRes, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICIntegrateRes, self._PM_ICIntegrateRes, self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICBuyEndRes, self._PM_ICBuyEndRes, self)

	self._leftRole = RoleObjectPool.instance:removeRole(self._leftRole)
	self._rightRole = RoleObjectPool.instance:removeRole(self._rightRole)

	RedPointController.instance:unregRedPoint(self._leftGrowBtnRed)
	RedPointController.instance:unregRedPoint(self._rightGrowBtnRed)
	RedPointController.instance:unregRedPoint(self._fitBtnRed)
	MaterialMgr.resetAll(self._shopGoods)

	self._animPlay = nil

	removetimer(self._timer, self)
end

function HeartGrowUpView:onEnter()
	HeartGrowUpView.super.onEnter(self)

	self._activityInfo = GrowUpRoadController.instance:getActivityById(1)
	self._rightOpenTime = GameUtil.string2time(self._activityInfo[2].openTime)

	local openT = GameUtil.time2date(self._rightOpenTime)

	goutil.setActive(self._rightTimeBg, self._rightOpenTime > ServerTime.now())
	goutil.setActive(self._rightTime.gameObject, self._rightOpenTime > ServerTime.now())

	self._rightTime.text = string.format(lang("heart_grow_up_right_time"), openT.month, openT.day, openT.hour, openT.min, openT.sec)

	goutil.setActive(self._rightInviteBtn.gameObject, GameUtil.string2time(self._activityInfo[2].openTime) < ServerTime.now())

	local middleTime = GameUtil.string2time(GrowUpRoadConfig.instance:getCommonValue("HEART_OPENTIME"))
	local middleT = GameUtil.time2date(middleTime)

	self._middleTime.text = string.format(lang("heart_grow_up_right_time"), middleT.month, middleT.day, middleT.hour, middleT.min, middleT.sec)

	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathGainPetRes, self._updatePet, self)
	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathGetInfoRes, self._updatePet, self)
	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICGetMainBoardInfoRes, self._PM_ICGetMainBoardInfoRes, self)
	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICIntegrateRes, self._PM_ICIntegrateRes, self)
	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICBuyEndRes, self._PM_ICBuyEndRes, self)

	self._getInfo = false

	PetGrowthPathAgent.instance:sendPM_PetGrowthPathGetInfoReq(self._activityInfo[1].activityId)
	IntegrationChallengeAgent.instance:sendPM_ICGetMainBoardInfoReq(IntegrationChallengeModel.TwinDragon)

	self._leftRole = RoleObjectPool.instance:addRoleToParent(self._leftRole, self._activityInfo[1].raceId, self._left, nil, nil, true)
	self._rightRole = RoleObjectPool.instance:addRoleToParent(self._rightRole, self._activityInfo[2].raceId, self._right, nil, nil, true)

	if middleTime <= ServerTime.now() then
		goutil.setActive(self._middleTime.gameObject, false)

		self._middleTimeBg.enabled = false

		goutil.setActive(self._middleInfo, false)
		goutil.setActive(self._fitBtn.gameObject, true)
	else
		goutil.setActive(self._middleTime.gameObject, true)

		self._middleTimeBg.enabled = true

		goutil.setActive(self._middleInfo, true)
		goutil.setActive(self._fitBtn.gameObject, false)
	end

	RedPointController.instance:regRedPoint(self._leftGrowBtnRed, self._activityInfo[1].redPointId)
	RedPointController.instance:regRedPoint(self._rightGrowBtnRed, self._activityInfo[2].redPointId)
	RedPointController.instance:regRedPoint(self._fitBtnRed, RedPointModel.ID_TWINDRAGRONCHALLENGE)
	goutil.setActive(self._rightHelpBubble, false)
	goutil.setActive(self._finishTip.gameObject, IntegrationChallengeModel.instance:getFinishChallenge())
	IntegrationChallengeModel.instance:setFinishChallenge()

	local _challengeCfg = IntegrationChallengeConfig.instance:getChallengeById(IntegrationChallengeModel.TwinDragon)

	MaterialMgr.setCellByCfg(MatType.Pet .. ":" .. _challengeCfg.bossRaceId, self._shopGoods)
	goutil.setActive(self._mask, false)
end

function HeartGrowUpView:_updatePet()
	if not self._getInfo then
		PetGrowthPathAgent.instance:sendPM_PetGrowthPathGetInfoReq(self._activityInfo[2].activityId)

		self._getInfo = true
	end

	local flag = GrowUpRoadModel.instance:getHasGainPet(self._activityInfo[1].activityId)

	goutil.setActive(self._leftInviteBtn.gameObject, not flag)
	goutil.setActive(self._leftGrowBtn.gameObject, flag)

	flag = GrowUpRoadModel.instance:getHasGainPet(self._activityInfo[2].activityId)

	goutil.setActive(self._rightInviteBtn.gameObject, not flag and self._rightOpenTime <= ServerTime.now())
	goutil.setActive(self._rightChallengeBtn.gameObject, flag)
	goutil.setActive(self._rightGrowBtn.gameObject, flag)

	local petInfo = GrowUpRoadController.instance:getPetInfo(self._activityInfo[2].raceId)

	goutil.setActive(self._rightHelpBtn.gameObject, flag and petInfo.sham)
	goutil.setActive(self._rightTip, flag and petInfo.sham)
end

function HeartGrowUpView:_PM_ICGetMainBoardInfoRes()
	goutil.setActive(self._middle, IntegrationChallengeModel.instance:getChallengeStatus() == 0)
	goutil.setActive(self._middleRole2, IntegrationChallengeModel.instance:getChallengeStatus() > 0)

	if IntegrationChallengeModel.instance:getChallengeStatus() == 0 then
		self._fitBtnText.text = lang("twin_dragon_challenge_10")
	elseif IntegrationChallengeModel.instance:getChallengeStatus() == 1 then
		self._fitBtnText.text = lang("twin_dragon_challenge_11")

		goutil.setActive(self._middleTime.gameObject, true)

		self._middleTimeBg.enabled = true
		self._middleTime.text = lang("twin_dragon_challenge_12")
	else
		self._fitBtnText.text = lang("twin_dragon_challenge_13")
	end
end

function HeartGrowUpView:_PM_ICIntegrateRes()
	self._fitBtnText.text = lang("twin_dragon_challenge_13")
end

function HeartGrowUpView:_PM_ICBuyEndRes()
	self._fitBtnText.text = lang("twin_dragon_challenge_11")

	goutil.setActive(self._middleTime.gameObject, true)

	self._middleTimeBg.enabled = true
	self._middleTime.text = lang("twin_dragon_challenge_12")
end

function HeartGrowUpView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "heartgrowup")
end

function HeartGrowUpView:_onClickFit()
	local petInfo1 = GrowUpRoadController.instance:getPetInfo(self._activityInfo[1].raceId)
	local petInfo2 = GrowUpRoadController.instance:getPetInfo(self._activityInfo[2].raceId)

	if IntegrationChallengeModel.instance:getChallengeStatus() == 0 then
		if petInfo1.sham or petInfo2.sham then
			FloatWordMgr.instance:show(lang("twin_dragon_challenge_2"))
		else
			UIStateManager.instance:push(ViewName.TwinDragonChallengeView)
		end
	elseif IntegrationChallengeModel.instance:getChallengeStatus() == 1 and not self._animPlay then
		if not petInfo2.sham and GrowUpRoadController.instance:isMaxPet(petInfo1) and GrowUpRoadController.instance:isMaxPet(petInfo2) then
			goutil.setActive(self._mask, true)
			AnimationPlayer.play("storyconfig/animations/xinxinniannian_heti.txt", function()
				self._animPlay = nil

				goutil.setActive(self._mask, false)
				IntegrationChallengeAgent.instance:sendPM_ICIntegrateReq(IntegrationChallengeModel.TwinDragon)
			end, nil, self, 1, true, true)
		else
			FloatWordMgr.instance:show(lang("twin_dragon_challenge_8"))
		end
	else
		PetbookController.instance:openPetinfoView(checknumber(GrowUpRoadConfig.instance:getCommonValue("HEART_RACEID")))
	end
end

function HeartGrowUpView:_onClickLeftInvite()
	UIStateManager.instance:push(ViewName.HeartGrowUpLetterView, true, self._activityInfo[1].activityId)
end

function HeartGrowUpView:_onClickLeftGrow()
	GrowUpRoadController.instance:openGrowRoadTask(self._activityInfo[1], GameEnum.GrowUpRoad.LeftTask)
end

function HeartGrowUpView:_onClickRightInvite()
	UIStateManager.instance:push(ViewName.HeartGrowUpLetterView, false, self._activityInfo[2].activityId)
end

function HeartGrowUpView:_onClickRightGrow()
	GrowUpRoadController.instance:openGrowRoadTask(self._activityInfo[2], GameEnum.GrowUpRoad.RightTask)
end

function HeartGrowUpView:_onClickHelp()
	goutil.setActive(self._rightHelpBubble, true)
	settimer(3, self._timer, self, false)
end

function HeartGrowUpView:_onClickRightChallenge()
	FuncOpenController.instance:openFunc(5019)
end

function HeartGrowUpView:_onClickFinishTip()
	goutil.setActive(self._finishTip.gameObject, false)
end

function HeartGrowUpView:_onClickShop()
	local _challengeCfg = IntegrationChallengeConfig.instance:getChallengeById(IntegrationChallengeModel.TwinDragon)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(_challengeCfg.shopId)
	local nowBuyTimes = PayShopModel.instance:getMibaoBuyTimesById(_challengeCfg.shopId)
	local allBuyTimes = PayShopModel.instance:getMibaoTotalBuyTimesById(_challengeCfg.shopId)
	local isSellOut = goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 and checknumber(nowBuyTimes) >= goodsCfg.limitTimes

	if isSellOut then
		FloatWordMgr.instance:show("已售罄")

		return
	end

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, {
		id = _challengeCfg.shopId,
		times = nowBuyTimes,
		totalBuyTimes = allBuyTimes
	})
end

function HeartGrowUpView:_timer()
	goutil.setActive(self._rightHelpBubble, false)
end

return HeartGrowUpView
