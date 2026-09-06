-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/TimedPointRaceModeMainView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.TimedPointRaceModeMainView", package.seeall)

local TimedPointRaceModeMainView = class("TimedPointRaceModeMainView", TimeLimitedMainView)

function TimedPointRaceModeMainView:_setEffectUrls()
	self._effPaths = {}
end

function TimedPointRaceModeMainView:unbindEvents()
	TimedPointRaceModeMainView.super.unbindEvents(self)
	self._btnAddBossTime:RemoveClickListener()
	self._btnAddBuffTime:RemoveClickListener()
	self._btnMain:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function TimedPointRaceModeMainView:bindEvents()
	TimedPointRaceModeMainView.super.bindEvents(self)
	self._btnAddBossTime:AddClickListener(self._onClickAddBossTime, self)
	self._btnAddBuffTime:AddClickListener(self._onClickAddBuffTime, self)
	self._btnMain:AddClickListener(self._onClickBtnMain, self)
	self._btnLeft:AddClickListener(self._onClickBtnLeft, self)
	self._btnRight:AddClickListener(self._onClickBtnRight, self)
end

function TimedPointRaceModeMainView:buildUI()
	TimedPointRaceModeMainView.super.buildUI(self)

	self._slider = self:getGo("ScrollRect/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("ScrollRect/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._prizecontent = self:getGo("ScrollRect/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("ScrollRect/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self._contentView = self:getGo("ruleView"):GetComponent("ScrollRect")
	self._viewportSize = self._contentView.viewport.rect.height
	self._ruleContent = self._contentView.content
	self._txtRules = self:getTxt("ruleView/Viewport/Content/txtRules")
	self.con = self:getGo("con")
	self._btnMain = self:getBtn("btnMain")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._txtBossTime = self:getTxt("txtBossTime")
	self._btnAddBossTime = self:getBtn("txtBossTime/btnAdd")
	self._txtBuffTime = self:getTxt("txtBuffTime")
	self._btnAddBuffTime = self:getBtn("txtBuffTime/btnAdd")
	self._txtScore = self:getTxt("score/Text")
	self._txtHifhestSocre = self:getTxt("highestScore/txtScore")
	self._challengeId = 0
end

function TimedPointRaceModeMainView:onEnter()
	TimedPointRaceModeMainView.super.onEnter(self)

	if self._challengeId > 0 then
		self:_updateCurCfg()
		self:_updateViewFixedPart()
		self:_getInfoDaily()
	else
		printError("请在当前界面buildUI 重写当前挑战ID")
	end

	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeInfoUpdate, self._refreshInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeMainView:onExit()
	TimedPointRaceModeMainView.super.onExit(self)

	local go = self:getGo("ScrollRect/ViewPort/Content")

	UnityTweens.TweenSequence.StopTween(go)

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil

	self:clearBtnPetAwak()
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeDailyFresh, self._getInfoDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeInfoUpdate, self._refreshInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeMainView:_updateCurCfg()
	self._curChallengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	self._commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(self._challengeId)
	self._prizeCfgs = TimedPointRaceModeConfig.instance:getPrizeCfgs(self._challengeId)
end

function TimedPointRaceModeMainView:_updateViewFixedPart()
	return
end

function TimedPointRaceModeMainView:_getInfoDaily()
	TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreInfoReq(self._challengeId)
end

function TimedPointRaceModeMainView:_refreshInfo()
	self._curInfo = TimedPointRaceModeModel.instance:getInfo(self._challengeId)

	self:updateChallengeTime()
	self:updatePrizeView()
	self:popPrize()
end

function TimedPointRaceModeMainView:_onError(status)
	self:close()
end

function TimedPointRaceModeMainView:updateRuleView()
	self._txtRules.text = self._curChallengeCfg.desc

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._txtRules.transform, nil, nil)
	local preHeight = self._txtRules.preferredHeight
	local sizeDelta = self._ruleContent.sizeDelta

	sizeDelta.y = math.abs(y) * 2 + preHeight
	self._ruleContent.sizeDelta = sizeDelta
	self._contentView.enabled = sizeDelta.y > self._viewportSize

	Framework.TransformUtil.SetLocalPos(self._ruleContent.transform, 0, 0, 0)
end

function TimedPointRaceModeMainView:popPrize()
	if self._curInfo.CIList then
		local limit = self._commonCfg.dailyRankLimit
		local pirzeMat = self._commonCfg.dailyRankPrize
		local matName = MaterialMgr.getMaterialsNameByCfg(pirzeMat)
		local text = langPara("恭喜您曾荣登新晋榜前%s名，获得精灵%s", limit, matName)

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			TimedPointRaceModeModel.instance:showCI(self._challengeId)
		end)
	end
end

function TimedPointRaceModeMainView:updateChallengeTime()
	self._curBuyBossTimes = checkint(self._curInfo.buyBossTimes)
	self._bossLeftTime = checkint(self._commonCfg.bossFreeTimes) - self._curInfo.useBossTimes + self._curBuyBossTimes
	self._txtBossTime.text = langPara("挑战次数：<color=#20b376>%s/%s</color>", self._bossLeftTime, self._commonCfg.bossFreeTimes)

	local isMatchVip = VipModel.instance:getCurVipLv() >= self._commonCfg.buyNeedVipLv
	local isTimeHasLeft = self._bossLeftTime > 0
	local isHasBuyTimeLeft = self._commonCfg.bossBuyTimes > self._curBuyBossTimes

	goutil.setActive(self._btnAddBossTime.gameObject, isMatchVip and not isTimeHasLeft and isHasBuyTimeLeft)

	self._curBuyBuffTimes = checkint(self._curInfo.buyBuffTimes)
	self._buffLeftTime = checkint(self._commonCfg.buffFreeTimes) - self._curInfo.useBuffTimes + self._curBuyBuffTimes
	self._txtBuffTime.text = langPara("秩序次数：<color=#20b376>%s/%s</color>", self._buffLeftTime, self._commonCfg.buffFreeTimes)

	local isMatchVip = VipModel.instance:getCurVipLv() >= self._commonCfg.buyNeedVipLv
	local isTimeHasLeft = self._buffLeftTime > 0
	local isHasBuyTimeLeft = self._commonCfg.buffBuyTimes > self._curBuyBuffTimes

	goutil.setActive(self._btnAddBuffTime.gameObject, isMatchVip and not isTimeHasLeft and isHasBuyTimeLeft)
end

function TimedPointRaceModeMainView:updatePrizeView()
	local totalScore = checknumber(self._curInfo.totalScore)
	local scores = {}

	for _, v in ipairs(self._prizeCfgs) do
		table.insert(scores, v.score)
	end

	local x = self._bar:setValue(scores, totalScore)

	self._prizecontent.sizeDelta = Vector2.New(x + 70, 100)

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = {}
	self._minGainedId = 0

	GameUtil.updateCellsWithCreate(self._gridLayout, self._prizeCfgs, self._updateOnePrize, self)

	local viewPortSize = self._viewPort.rect.size.x
	local contentSize = self._prizecontent.sizeDelta.x
	local maxOffset = contentSize - viewPortSize

	Framework.TransformUtil.SetAnchoredPos(self._prizecontent, 0, 0)

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._prizecontent.transform, 0, 0, 0)
	local cellWidth = self._gridLayout.cellSize.x
	local spacingX = self._gridLayout.spacing.x

	x = x - math.min(maxOffset, cellWidth * self._minGainedId + spacingX * self._minGainedId)

	Framework.TransformUtil.SetLocalPos(self._prizecontent.transform, x, 0, 0)

	self._txtScore.text = langPara("累计积分\n<color=#20b376>%s</color>", totalScore)
	self._txtHifhestSocre.text = langPara("今日最高分：<color=#20b376>%s</color>", self._curInfo.dailyMaxScore)
end

function TimedPointRaceModeMainView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.score

	if not self._curInfo.gainPrizes then
		local gainedPrizeIds = {}
		local gained = gainedPrizeIds[cfg.prizeId]

		received:SetActive(gained)

		local canGain = cfg.score <= checknumber(self._curInfo.totalScore)

		if canGain and not gained then
			local url = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
			local eff = self:_playEffect(url, go, 0.62, true)

			table.insert(self._canGainEffs, eff)
			btn.gameObject:SetActive(true)
			btn:AddClickListener(function()
				self:_onClickPrize(cfg.challengeId, cfg.prizeId)
			end)

			self._minGainedId = self._minGainedId == 0 and cfg.prizeId - 1 or math.min(self._minGainedId, cfg.prizeId - 1)
		else
			btn.gameObject:SetActive(false)
		end
	end
end

function TimedPointRaceModeMainView:clearBtnPetAwak()
	if self._btnPetAwakRed then
		RedPointController.instance:unregRedPoint(self._btnPetAwakRed)
	end
end

function TimedPointRaceModeMainView:_playEffect(url, parent, scale, needSetClip)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function TimedPointRaceModeMainView:_onClickPrize(challengeId, prizeId)
	TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreGainPrizeReq(challengeId, prizeId)
end

function TimedPointRaceModeMainView:_onClickAddBossTime()
	if self._bossLeftTime <= 0 then
		local leftBuyBossTime = self._commonCfg.bossBuyTimes - self._curBuyBossTimes

		if leftBuyBossTime > 0 then
			local curcost = self._commonCfg.bossBuyTimesCost
			local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curcost)
			local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
			local content = langPara("确定花费<color=#ebad32>%s</color>%s购买挑战次数吗？\n每天最多可购买：<color=#ebad32>%s次</color>，还能购买<color=#ebad32>%s次</color>", curCostNum, curIcon, self._commonCfg.bossBuyTimes, leftBuyBossTime)

			TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
				TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreBuyBossTimesReq(self._challengeId)
			end)
		else
			FloatWordMgr.instance:show("今日购买已达上限，次日5点刷新购买次数")
		end
	end
end

function TimedPointRaceModeMainView:_onClickAddBuffTime()
	if self._buffLeftTime <= 0 then
		local leftBuyBuffTime = self._commonCfg.buffBuyTimes - self._curBuyBuffTimes

		if leftBuyBuffTime > 0 then
			local curcost = self._commonCfg.buffBuyTimesCost
			local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curcost)
			local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
			local content = langPara("确定花费<color=#ebad32>%s</color>%s购买挑战次数吗？\n每天最多可购买：<color=#ebad32>%s次</color>，还能购买<color=#ebad32>%s次</color>", curCostNum, curIcon, self._commonCfg.buffBuyTimes, leftBuyBuffTime)

			TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
				TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreBuyBuffTimesReq(self._challengeId)
			end)
		else
			FloatWordMgr.instance:show("今日购买已达上限，次日5点刷新购买次数")
		end
	end
end

function TimedPointRaceModeMainView:_onClickBtnMain()
	local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

	if isAble then
		if self._bossLeftTime <= 0 then
			TipsFacade.instance:openCommonTips("当前挑战Boss次数已耗尽")
		else
			UIStateManager.instance:push(self._commonCfg.bossEnterBattleView, self._challengeId)
		end
	elseif isDateAble then
		TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.closeRange))
	else
		TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
	end
end

function TimedPointRaceModeMainView:_onClickBtnLeft()
	local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

	if isAble then
		UIStateManager.instance:push(self._commonCfg.buffShowView, self._challengeId, 1)
	elseif isDateAble then
		TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.closeRange))
	else
		TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
	end
end

function TimedPointRaceModeMainView:_onClickBtnRight()
	local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

	if isAble then
		UIStateManager.instance:push(self._commonCfg.buffShowView, self._challengeId, 2)
	elseif isDateAble then
		TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.closeRange))
	else
		TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
	end
end

return TimedPointRaceModeMainView
