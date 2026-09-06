-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/view/FoodCookingView.lua

module("logic.extensions.celebratebirthday.view.FoodCookingView", package.seeall)

local FoodCookingView = class("FoodCookingView", ViewComponent)

function FoodCookingView:buildUI()
	FoodCookingView.super.buildUI(self)

	local piclist = self:getGo("piclist")

	self._picNum = piclist.transform.childCount
	self._piclist = {}

	for i = 1, self._picNum do
		local cell = {}

		cell.go = goutil.findChild(piclist, "pic_" .. i)
		cell.mark = self:getGo("toglist/tog_" .. i .. "/mark")
		self._piclist[i] = cell
	end

	self._btnClose = self:getGo("btnClose")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtAmout = goutil.findChildTextComponent(playerRoot, "txtAmout")
	self._txtActTime = self:getTxt("actTime/txtTime")
	self._txtTimeLeft = self:getTxt("timeLeft/txt")
	self._totalTime = 0
	self._btnCooking = self:getGo("btnCooking")
	self._iconCooking = goutil.findChild(self._btnCooking, "icon")
	self._txtTip = self:getTxt("tip/txt")
	self._btnMenu = self:getBtn("btnMenu")
	self._txtBubble = self:getTxt("bubble/txt")
	self._markAllFinish = self:getGo("markAllFinish")
end

function FoodCookingView:bindEvents()
	FoodCookingView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, self.switchLeft, self)
	GameUtil.addClickHandler(self._btnRight, self.switchRight, self)
	GameUtil.addClickHandler(self._btnCooking, self._onClickCooking, self)
	GameUtil.addClickHandler(self._btnMenu, self._onClickMenu, self)
end

function FoodCookingView:unbindEvents()
	FoodCookingView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnCooking)
	GameUtil.rmClickHandler(self._btnMenu)
end

function FoodCookingView:onEnter()
	FoodCookingView.super.onEnter(self)
	GlobalDispatcher:addListener(CelebrateBirthdayController.PM_MakeGiftGetInfo, self._PM_MakeGiftGetInfo, self)
	GlobalDispatcher:addListener(CelebrateBirthdayController.PM_MakeGiftMake, self._PM_MakeGiftMake, self)
	GlobalDispatcher:addListener(CelebrateBirthdayController.PM_MakeGiftGainPrize, self._PM_MakeGiftGainPrize, self)

	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.MakeGift)

	if actTimeCfg then
		self._actId = actTimeCfg.activityId

		self:refreshViewByCfg()
		MakeGiftAgent.instance:sendPM_MakeGiftGetInfoReq(self._actId)
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	self._curPicId = 1
	self._curBubbleId = 0

	self:_onSwitch()
	self:switchBubble()
	settimer(5, self.switchRight, self)
	settimer(5, self.switchBubble, self)
	self:_initPlayerParams()

	self._mainEff = UIEffectManager.instance:playEffect(self, "20221028/xiunuo_xdqsl/fx_ui_xiuer_zjjh.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
	self._foodEff = UIEffectManager.instance:playEffect(self, "20221028/xiunuo_xdqsl/fx_ui_xiuer_zzms.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function FoodCookingView:onExit()
	FoodCookingView.super.onExit(self)
	GlobalDispatcher:removeListener(CelebrateBirthdayController.PM_MakeGiftGetInfo, self._PM_MakeGiftGetInfo, self)
	GlobalDispatcher:removeListener(CelebrateBirthdayController.PM_MakeGiftMake, self._PM_MakeGiftMake, self)
	GlobalDispatcher:removeListener(CelebrateBirthdayController.PM_MakeGiftGainPrize, self._PM_MakeGiftGainPrize, self)
	removetimer(self.switchRight, self)
	removetimer(self.switchBubble, self)
	removetimer(self._onTick, self)
	removetimer(self._onCdTimer, self)
	self._playerSliderMo:onExit()
	uGuiUtil.clearImage(self._iconCooking)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._foodEff then
		UIEffectManager.instance:stopEffect(self._foodEff)

		self._foodEff = nil
	end
end

function FoodCookingView:refreshViewByCfg()
	self._cfg = MakeGiftConfig.instance:getCfgById(self._actId)
	self._makeCfg = MakeGiftConfig.instance:getMakeByPlan(self._cfg.makePlanId)
	self._dailyLimit = #self._makeCfg
	self._prizeCfg = MakeGiftConfig.instance:getPrizeByPlan(self._cfg.prizePlanId)
	self._bubbleCfg = MakeGiftConfig.instance:getBubbleCfgs(self._cfg.bubblePlanId)
	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.MakeGift, self._actId)

	self:setActTime()
end

function FoodCookingView:_PM_MakeGiftGetInfo()
	self:_PM_MakeGiftMake()
end

function FoodCookingView:_PM_MakeGiftMake()
	self._foodEff:setActive(false)
	self:_PM_MakeGiftGainPrize()

	self._txtTimeLeft.text = langPara("今日剩余次数：%s", self._dailyLimit - self._dailyTime)
	self._isCurAllFinish = self._dailyTime + 1 > self._dailyLimit
	self._isCurAllFinishWeekly = self._weekTime + 1 > self._cfg.weeklyLimit

	if self._isCurAllFinish then
		self._curShowIconId = self._dailyTime or self._dailyTime + 1
	end

	self._earliestTime = CelebrateBirthdayModel.instance:getEarliesTime()

	local makeCfg = self._makeCfg[self._curShowIconId]
	local cdCfg = self._makeCfg[self._curShowIconId - 1]
	local iconPath = GameUrl.getItemIconUrl(makeCfg.iconRes)

	goutil.setActive(self._markAllFinish, self._isCurAllFinish or self._isCurAllFinishWeekly)

	if not string.nilorempty(iconPath) then
		uGuiUtil.clearImage(self._iconCooking)
		uGuiUtil.setSpriteToImage(self._iconCooking, uGuiUtil.SpriteType.BigBg, iconPath)
	end

	self._isAbleToCook = false

	removetimer(self._onCdTimer, self)

	if self._isCurAllFinishWeekly then
		self._txtTip.text = lang("本周已全部制作完成")

		return
	end

	if self._isCurAllFinish then
		self._txtTip.text = lang("今日份美食已制作完成，明天再来吧")
	else
		if not cdCfg then
			self._txtTip.text = lang("点击收集食材")
			self._isAbleToCook = true

			return
		end

		if cdCfg.cd == 0 then
			self._txtTip.text = lang("点击收集食材")
			self._isAbleToCook = true
		else
			self._nextCookTime = checkint(self._earliestTime)

			if self._nextCookTime < ServerTime.now() then
				self._isAbleToCook = true

				self._foodEff:setActive(true)

				self._txtTip.text = lang("点击立即制作")
			else
				self:_onCdTimer()
				settimer(1, self._onCdTimer, self)
			end
		end
	end
end

function FoodCookingView:_onCdTimer()
	local timeLeft = self._nextCookTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtTip.text = langPara("%s后可制作美食", GameUtil.FormatTimeSymbol(timeLeft))
	else
		self._isAbleToCook = true

		self._foodEff:setActive(true)

		self._txtTip.text = lang("点击立即制作")

		removetimer(self._onCdTimer, self)
	end
end

function FoodCookingView:_PM_MakeGiftGainPrize()
	self._dailyTime = CelebrateBirthdayModel.instance:getDailyTime()
	self._totalTime = CelebrateBirthdayModel.instance:getTotalTime()
	self._weekTime = CelebrateBirthdayModel.instance:getWeeklyTime()

	self._playerSliderMo:updatePlayerReward()

	self._txtAmout.text = langPara("累计制作\n<color=#F25A25FF>%s</color>次", self._totalTime)
end

function FoodCookingView:switchBubble()
	if not self._bubbleCfg then
		return
	end

	self._curBubbleId = self._curBubbleId + 1

	if self._curBubbleId > #self._bubbleCfg then
		self._curBubbleId = 1
	end

	self._txtBubble.text = self._bubbleCfg[self._curBubbleId].showDes
end

function FoodCookingView:switchRight()
	self._curPicId = self._curPicId + 1

	self:_onSwitch()
end

function FoodCookingView:switchLeft()
	self._curPicId = self._curPicId - 1

	self:_onSwitch()
end

function FoodCookingView:_onSwitch()
	if self._curPicId > self._picNum then
		self._curPicId = 1
	elseif self._curPicId < 1 then
		self._curPicId = self._picNum
	end

	for k, v in ipairs(self._piclist) do
		goutil.setActive(v.mark, k == self._curPicId)
		goutil.setActive(v.go, k == self._curPicId)
	end

	self._piclist[self._curPicId].go.transform:SetAsLastSibling()
end

function FoodCookingView:_initPlayerParams()
	if not self._cfg then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._prizeCfg

	function playerParam.getPlayerProgress()
		return self._totalTime
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.time
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.time <= self._totalTime and not CelebrateBirthdayModel.instance:getHasGainPrize(rewardCfg.id)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return CelebrateBirthdayModel.instance:getHasGainPrize(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		CelebrateBirthdayController.instance:sendMsg(CelebrateBirthdayController.PM_MakeGiftGainPrize, self._actId, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function FoodCookingView:setActTime()
	self:_onTick()
	settimer(1, self._onTick, self)
end

function FoodCookingView:_onTick()
	local timeLeft = self._endTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtActTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

function FoodCookingView:_onClickCooking()
	if CelebrateBirthdayModel.instance:getWeeklyTime() >= self._cfg.weeklyLimit then
		FloatWordMgr.instance:show(lang("已达到每周最大制作次数"))

		return
	end

	if self._isCurAllFinish then
		FloatWordMgr.instance:show(lang("今日已全部制作完成"))

		return
	end

	if self._isAbleToCook then
		if self._foodEff.active then
			local animConfig = {
				animName = "story_songliwu_xiunuo",
				passable = false,
				animFinishCallback = function()
					CelebrateBirthdayController.instance:sendMsg(CelebrateBirthdayController.PM_MakeGiftMake, self._actId)
				end,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
		else
			CelebrateBirthdayController.instance:sendMsg(CelebrateBirthdayController.PM_MakeGiftMake, self._actId)
		end
	else
		FloatWordMgr.instance:show(lang("美食还没制作完成，晚点再来吧"))
	end
end

function FoodCookingView:_onClickMenu()
	UIStateManager.instance:push(ViewName.FoodCookingMenuView, self._makeCfg)
end

return FoodCookingView
