-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxactivityenterView.lua

module("logic.extensions.sxgame.view.SxactivityenterView", package.seeall)

local SxactivityenterView = class("SxactivityenterView", ViewComponent)

function SxactivityenterView:ctor()
	SxactivityenterView.super.ctor(self)
end

function SxactivityenterView:unbindEvents()
	SxactivityenterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnBack)
	GameUtil.rmClickHandler(self.btnStart)
	GameUtil.rmClickHandler(self.btnBuy)
end

function SxactivityenterView:bindEvents()
	SxactivityenterView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnBack, self.close, self)
	GameUtil.addClickHandler(self.btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self.btnBuy, self.onClickBuy, self)
end

function SxactivityenterView:buildUI()
	SxactivityenterView.super.buildUI(self)

	self.btnBack = self:getGo("btnBack")
	self.btnStart = self:getGo("btnStart")
	self.btnBuy = self:getGo("btnBuy")
	self.txtBuy = self:getTxt("btnBuy/txtBuy")
	self.txtCount = self:getTxt("txtCount")
	self.sliderArea = self:getGo("sliderArea")
	self.specialReward = self:getGo("sliderArea/specialReward")
	self.icon = self:getGo("sliderArea/specialReward/icon")
	self.txtDescReward = self:getTxt("sliderArea/specialReward/txtDesc")
	self.activityTime = self:getGo("sliderArea/activityTime")
	self.txtTime = self:getTxt("sliderArea/activityTime/txtTime")
	self.txtDesc = self:getTxt("sliderArea/txtDesc")
	self._slider = self:getGo("sliderArea/ScrollRect/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("sliderArea/ScrollRect/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("sliderArea/ScrollRect/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("sliderArea/ScrollRect/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("sliderArea/ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._scrollRect.enabled = false
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
end

function SxactivityenterView:onExit()
	SxactivityenterView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SxActInfoUpdate, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.onCheckBuy, self)
	GlobalDispatcher:removeListener(PayShopController.BuyItemRes, self.onCheckBuy, self)

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil
end

function SxactivityenterView:onEnter()
	SxactivityenterView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.SxActInfoUpdate, self.onRefreshUI, self)
	GlobalDispatcher:addListener(PayShopModel.GetAllPayShopBuyTimesRes, self.onCheckBuy, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.onCheckBuy, self)
	GlobalDispatcher:addListener(PayShopController.BuyItemRes, self.onCheckBuy, self)
	self:_reloadData()
	self:onRefreshUI()
end

function SxactivityenterView:_reloadData()
	SxGameController.instance:sendGetActInfo()
end

function SxactivityenterView:onCheckBuy()
	local goodsId = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_GIFT_BAG"))
	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(goodsId)

	GameUtil.SetActive(self.btnBuy, isCanBuy)
	print(">>>>>>>>>>>>>>>>  SxactivityenterView 更新 ")
end

function SxactivityenterView:onRefreshUI()
	local remainCnt = SxGameController.instance:getResiduePlayTimes()

	self.txtCount.text = ""
	self.txtCount.text = remainCnt > 0 and langPara("今天还剩下:<color=#78ff27>%d次</color>", remainCnt) or langPara("今天还剩下:<color=#eb4642>%d次</color>", 0)

	self:onCheckBuy()

	local gameInfo = SxGameController.instance.sxGameInfo

	GameUtil.SetActive(self.sliderArea, false)

	if gameInfo then
		local periodId = gameInfo.periodId

		self.periodId = periodId

		if checknumber(periodId) > 0 then
			GameUtil.SetActive(self.sliderArea, true)
			self:_updateProgressBar(true)
			self:_tweenContent()

			self.txtBuy.text = MiniGameCollectionConfig.instance:getParamValueByKey("SX_GIFT_BAG_TXT")

			local cfg = MiniGameCollectionConfig.instance:getBasePeriodConfig(self.periodId)
			local startTime, endTime = cfg.startTime, cfg.endTime
			local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			self.txtTime.text = langPara("FunArena_HallView_Tips_1", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

			local score = gameInfo.score
			local prizeCfgs = MiniGameCollectionConfig.instance:getPrizeCfgs(cfg.prizePlanId)
			local nextScore = -1

			for i = 1, #prizeCfgs do
				local tem = prizeCfgs[i]

				if score < tem.needScore then
					nextScore = tem.needScore

					break
				end
			end

			if nextScore > 0 then
				local award = MiniGameCollectionConfig.instance:getParamValueByKey("SX_AWARD_TXT")

				self.txtDesc.text = langPara(award, score, nextScore)
			else
				self.txtDesc.text = MiniGameCollectionConfig.instance:getParamValueByKey("SX_AWARD_LAST_TXT")
			end

			local award = MiniGameCollectionConfig.instance:getParamValueByKey("SX_SPECIAL_AWARD")
			local txt = MiniGameCollectionConfig.instance:getParamValueByKey("SX_SPECIAL_AWARDTXT")

			MaterialMgr.setCellByCfg(award, self.icon)

			self.txtDescReward.text = txt
		else
			GameUtil.SetActive(self.sliderArea, false)
		end
	end
end

function SxactivityenterView:onClickBuy()
	local goodsId = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_GIFT_BAG"))

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function SxactivityenterView:_onClickStart()
	local times = SxGameController.instance:getResiduePlayTimes()

	SxGameController.instance:openSxgameView(times)
end

function SxactivityenterView:_updateProgressBar(needSetOffset)
	local totalScore = checknumber(SxGameController.instance:getActScore())
	local scores = {}
	local baseCfg = MiniGameCollectionConfig.instance:getBasePeriodConfig(self.periodId) or {}

	if baseCfg then
		local prizeCfgs = MiniGameCollectionConfig.instance:getPrizeCfgs(baseCfg.prizePlanId)

		for _, v in ipairs(prizeCfgs) do
			table.insert(scores, v.needScore)
		end

		local x = self._bar:setValue(scores, totalScore)

		self._content.sizeDelta = Vector2.New(x + 70, 100)

		if self._canGainEffs then
			for _, v in ipairs(self._canGainEffs) do
				UIEffectManager.instance:stopEffect(v)
			end
		end

		self._canGainEffs = {}
		self._minGainedId = 0

		GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

		if needSetOffset then
			local viewPortSize = self._viewPort.rect.size.x
			local contentSize = self._content.sizeDelta.x
			local maxOffset = contentSize - viewPortSize

			Framework.TransformUtil.SetAnchoredPos(self._content, 0, 0)

			local x, y, z = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)
			local cellWidth = self._gridLayout.cellSize.x
			local spacingX = self._gridLayout.spacing.x

			x = x - math.min(maxOffset, cellWidth * self._minGainedId + spacingX * self._minGainedId)

			Framework.TransformUtil.SetLocalPos(self._content.transform, x, 0, 0)
		end
	end
end

function SxactivityenterView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.needScore

	local gainedPrizeIds = SxGameController.instance:getGainPrizeIds()
	local gained = table.indexof(gainedPrizeIds, cfg.prizeId) ~= false

	received:SetActive(gained)

	local canGain = cfg.needScore <= checknumber(SxGameController.instance:getActScore())

	if canGain and not gained then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
		local eff = self:_playEffect(url, go, 0.62, true)

		table.insert(self._canGainEffs, eff)
		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			self:_onClickPrize(self.periodId, cfg.prizeId)
		end)

		self._minGainedId = self._minGainedId == 0 and cfg.prizeId - 1 or math.min(self._minGainedId, cfg.prizeId - 1)
	else
		btn.gameObject:SetActive(false)
	end
end

function SxactivityenterView:_playEffect(url, parent, scale, needSetClip)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function SxactivityenterView:_onClickPrize(periodId, prizeId)
	SxGameController.instance:sendGetProgressPrize(periodId, prizeId)
end

local firstInKey = "SxactivityenterView_FirstIn"

function SxactivityenterView:_tweenContent()
	local viewPortSize = self._viewPort.rect.size.x
	local isFirstIn = checknumber(GameUtil.getUserData(firstInKey)) == 0

	if not isFirstIn then
		self._scrollRect.enabled = true

		return
	end

	self._scrollRect.enabled = false

	GameUtil.saveUserData(firstInKey, 1)
	Framework.TransformUtil.SetAnchoredPos(self._content, 0, 0)

	local x, _ = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)
	local startPos = Vector3.New(x, 0, 0)
	local endPos = Vector3.New(x - self._content.sizeDelta.x + viewPortSize, 0, 0)
	local go = self:getGo("sliderArea/ScrollRect/ViewPort/Content")
	local duration = 1
	local fadeIn = UnityTweens.TweenPosition.Create(go, startPos, endPos, duration, UnityTweens.EaseType.linear, 0.2)
	local fadeOut = UnityTweens.TweenPosition.Create(go, endPos, startPos, duration, UnityTweens.EaseType.linear, 0)
	local tweenSeq = UnityTweens.TweenSequence.StartTween(go, fadeIn, fadeOut)

	tweenSeq:AddListener(function()
		self._scrollRect.enabled = true
	end)
end

return SxactivityenterView
