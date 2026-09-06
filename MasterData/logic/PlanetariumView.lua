-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumView.lua

module("logic.extensions.planetarium.view.PlanetariumView", package.seeall)

local PlanetariumView = class("PlanetariumView", PlanetariumGame)

function PlanetariumView:ctor()
	PlanetariumView.super.ctor(self)
end

function PlanetariumView:unbindEvents()
	PlanetariumView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnSuccessClose)
	GameUtil.rmClickHandler(self._btnPrizeDaily)
end

function PlanetariumView:bindEvents()
	PlanetariumView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
	GameUtil.addClickHandler(self._btnSuccessClose, self._onClickCloseTip, self)
	GameUtil.addClickHandler(self._btnPrizeDaily, self._onClickPrizeDaily, self)
end

function PlanetariumView:buildUI()
	PlanetariumView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReward = self:getBtn("btnReward")
	self._rewardRd = self:getGo("btnReward/redpoint")
	self._success = self:getGo("success")
	self._btnSuccessClose = self:getBtn("success/btnClose")
	self._lock = self:getGo("lock")
	self._info = self:getGo("info")
	self._petIcon = self:getGo("info/petHead/icon")
	self._txtBubbleDesc = self:getTxt("info/bubble/txtDesc")
	self._txtLucky = self:getTxt("info/lucky/txtDesc")
	self._txtAvoid = self:getTxt("info/avoid/txtDesc")
	self._page1 = self:getGo("info/lottery/page1")
	self._page2 = self:getGo("info/lottery/page2")
	self._btnPrizeDaily = self:getBtn("info/lottery/page1/btnPrizeDaily")
	self._txtDesc = self:getTxt("info/lottery/page2/txtDesc")
	self._con = self:getGo("info/lottery/page2/con")
end

function PlanetariumView:onExit()
	PlanetariumView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rewardRd)
	UIEffectManager.instance:stopEffect(self._effect)
	UIEffectManager.instance:stopEffect(self._passEffect)
	removetimer(self._showSucessTip, self)
	MaterialMgr.resetAll(self._petIcon)
end

function PlanetariumView:onEnter()
	PlanetariumView.super.onEnter(self)

	self._params = self:getOpenParam()

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Planetarium, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	RedPointController.instance:regRedPoint(self._rewardRd, RedPointModel.ID_PLANETARIUM_REWARD)
	GameUtil.SetActive(self._success, false)
	self:_initUI()
	self:_showMainEffect()
end

function PlanetariumView:_initData()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Planetarium)
	self._rulePlanId = PlanetariumConfig.instance:getRulePlanId(self._activityId)

	if not GameUtil.getUserDayData(ViewName.PlanetariumView .. "_" .. self._activityId) then
		self:_onClickTip()
		GameUtil.saveUserDayData(ViewName.PlanetariumView .. "_" .. self._activityId, true)
	end

	self._stageCfg = PlanetariumConfig.instance:getStageCfgById(self._activityId)
	self._stageId = PlanetariumModel.instance:getStageId()

	if self._stageId <= 0 then
		local id = checknumber(GameUtil.getUserDayData(ViewName.PlanetariumView))

		if id <= 0 then
			math.randomseed(tostring(os.time()):reverse():sub(1, 7))

			local randomNum = math.random(1, #self._stageCfg)

			self._stageId = self._stageCfg[randomNum].stageId

			GameUtil.saveUserDayData(ViewName.PlanetariumView, self._stageId)
		end
	end
end

function PlanetariumView:_initUI()
	GameUtil.SetActive(self._lock, not self._isSuccess)
	GameUtil.SetActive(self._info, self._isSuccess)

	local isHasPrize = PlanetariumController.instance:isHasPrizeCanReceive(self._activityId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PLANETARIUM_REWARD, isHasPrize)
end

function PlanetariumView:_showMainEffect()
	local effectPath = "20230630/tianwenguanyouxi/fx_ui_tianwenguanyouxi_fw.prefab"

	self._effect = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._effect:setParent(self.mainGO.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
end

function PlanetariumView:_refresh()
	PlanetariumView.super._refresh(self)
	self:_initUI()

	if not self._isSuccess then
		self:_refreshStarMap()
		self:_startGame()
	else
		self:_initStarRingUI()
		self:_initStarRingAngle()
		self:_showDailyLuckInfo()
	end
end

function PlanetariumView:_passGameUI()
	PlanetariumView.super._passGameUI(self)

	local effectPath = "20230630/tianwenguanyouxi/fx_ui_tianwenguanyouxi_yuanpan.prefab"

	self._passEffect = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	self._passEffect:setParent(self.mainGO.transform)
	self._passEffect:setLocalPos(0, 0, 0)
	self._passEffect:setScale(1)
	settimer(3, self._showSucessTip, self, false)
	self:_showDailyLuckInfo()
end

function PlanetariumView:_showSucessTip()
	GameUtil.SetActive(self._success, true)
	removetimer(self._showSucessTip, self)
end

function PlanetariumView:_showDailyLuckInfo()
	local gameCfg = PlanetariumConfig.instance:getGameCfgByStageId(self._activityId, self._stageId)

	self._txtBubbleDesc.text = gameCfg.bubbleDesc
	self._txtLucky.text = gameCfg.lucky
	self._txtAvoid.text = gameCfg.avoid

	MaterialMgr.setIcon(self._petIcon, MatType.Pet, gameCfg.raceId)
end

function PlanetariumView:_onClickClose()
	self:_endGame(self._isSuccess)
	self:close()
end

function PlanetariumView:_onClickTip()
	local list = {}
	local cfgs = PlanetariumConfig.instance:getGameRuleCfg(self._rulePlanId)

	for i, v in ipairs(cfgs) do
		local info = {}

		info.url = string.format("ui/bigbg/planetarium/%s.png", v.picturePath)
		info.desc = v.txtRule

		table.insert(list, info)
	end

	TipsFacade.instance:openImageRuleView(list)
end

function PlanetariumView:_onClickReward()
	UIStateManager.instance:push(ViewName.PlanetariumprizeView)
end

function PlanetariumView:_onClickCloseTip()
	GameUtil.SetActive(self._success, false)
	self:_showDailyLuckInfo()
end

function PlanetariumView:_onClickPrizeDaily()
	if self._isSuccess then
		UIStateManager.instance:push(ViewName.PlanetariumLotteryView, self._lotteryActivityId)
	else
		FloatWordMgr.instance:show("完成小游戏后可抽签")
	end
end

function PlanetariumView:_initLottery()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.TunTianHelp)

	if cfg then
		self._lotteryActivityId = cfg.activityId or 290002
	end

	TunTianHelpController.instance:sendPM_TunTianHelpGetInfoReq(self._lotteryActivityId)
end

function PlanetariumView:_refreshLottery()
	if not self._isSuccess then
		GameUtil.SetActive(self._page1, false)
		GameUtil.SetActive(self._page2, false)
	else
		local isLottery = TunTianHelpModel.instance:isUsedAllLotteryTimes(self._lotteryActivityId)

		if not isLottery then
			GameUtil.SetActive(self._page1, true)
			GameUtil.SetActive(self._page2, false)
		else
			GameUtil.SetActive(self._page1, false)
			GameUtil.SetActive(self._page2, true)

			local prizeId = GameUtil.getUserDayData(ViewName.PlanetariumView .. self._lotteryActivityId)
			local cfgLotteryPrize = TunTianHelpConfig.instance:getTthPrizeData(self._lotteryActivityId, prizeId)

			if cfgLotteryPrize then
				MaterialMgr.setCellByCfg(cfgLotteryPrize.prize, self._con)

				self._txtDesc.text = cfgLotteryPrize.lotteryDesc
			end
		end
	end
end

function PlanetariumView:_onGetInfoRes()
	self:_refreshLottery()
end

function PlanetariumView:_onLotteryEnd()
	local prizeId = TunTianHelpModel.instance:getPrizeIdOfLottery()

	GameUtil.saveUserDayData(ViewName.PlanetariumView .. self._lotteryActivityId, prizeId)
	self:_refreshLottery()
end

function PlanetariumView:_sendGameStartReq()
	PlanetariumController.instance:sendPM_PlanetariumGameStartGameReq(self._activityId, self._clientKey)
end

function PlanetariumView:_sendGameEndReq()
	local severKey = PlanetariumModel.instance:getServerKey()
	local scoreNum = self._isSuccess and 1 or 0
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, severKey, {
		scoreNum
	})

	PlanetariumController.instance:sendPM_PlanetariumGameEndGameReq(self._activityId, self._isSuccess, encryptedKey)
end

function PlanetariumView:_sendGetInfoReq()
	PlanetariumController.instance:sendPM_PlanetariumGameInfoReq(self._activityId)
end

return PlanetariumView
