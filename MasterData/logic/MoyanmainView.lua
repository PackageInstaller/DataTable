-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/MoyanmainView.lua

module("logic.extensions.timelimitedchallenge.view.moyanmainview.MoyanmainView", package.seeall)

local MoyanmainView = class("MoyanmainView", TimeLimitedMainView)

function MoyanmainView:unbindEvents()
	MoyanmainView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnGift:RemoveClickListener()
	self._btnGift2:RemoveClickListener()
end

function MoyanmainView:bindEvents()
	MoyanmainView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnGift:AddClickListener(self._onClickJump, self)
	self._btnGift2:AddClickListener(self._onClickJump2, self)
end

function MoyanmainView:buildUI()
	MoyanmainView.super.buildUI(self)

	self._challengeId = 20
	self._slider = self:getGo("ScrollRect/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("ScrollRect/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("ScrollRect/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("ScrollRect/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._scrollRect.enabled = false
	self._txtCurScore = self:getTxt("total/txtNum")
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self._btnStart = self:getBtn("Button")
	self._model = self:getGo("model")
	self._redImgPoint = self:getGo("Button/imgPoint")

	GameUtil.SetActive(self._redImgPoint, false)

	self._shopGo = self:getGo("shop")
	self._btnGift = self:getBtn("shop/btnShop")
	self._itemGift = self:getGo("shop/item")
	self._shopGo2 = self:getGo("shop2")
	self._btnGift2 = self:getBtn("shop2/btnShop")
	self._itemGift2 = self:getGo("shop2/item")
	self.con = self:getGo("con")
end

function MoyanmainView:onExit()
	MoyanmainView.super.onExit(self)

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil

	local go = self:getGo("ScrollRect/ViewPort/Content")

	UnityTweens.TweenSequence.StopTween(go)
	MaterialMgr.resetAll(self._itemGift)
	MaterialMgr.resetAll(self._itemGift2)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
	UIEffectManager.instance:stopEffect(self._pmEff3)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.RULES_VIEW_EXIT, self._tweenContent, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._buyItemRes, self)
end

function MoyanmainView:onEnter()
	MoyanmainView.super.onEnter(self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._buyItemRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RULES_VIEW_EXIT, self._tweenContent, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	MoyanController.instance:sendGetInfo(self._challengeId)
	self:onRefreshUI()
	GameUtil.doCallbackWhenFirst("MoyanmainView_20210810", function()
		self:_onClickRule()
	end, function()
		self:_tweenContent()
	end)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_common.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_anniu.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 493.4, -283, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)

	local effPath = "fx_ui_moyantiaozhan/fx_ui_zhumianban_zi.prefab"

	self._pmEff3 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, -425, 150, true, nil, nil, nil, self)

	self._pmEff3:setParent(self.mainGO.transform)
	self._pmEff3:setScale(1)
end

function MoyanmainView:onEnterFinished()
	MoyanmainView.super.onEnterFinished(self)
end

function MoyanmainView:_onClickJump()
	UIStateManager.instance:push(ViewName.ContractEnterView)
end

function MoyanmainView:_onClickJump2()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}

	if checknumber(baseCfg.GOODS_ID) > 0 then
		PayShopController.instance:buyShopItemWithTips(baseCfg.GOODS_ID)
	end
end

function MoyanmainView:_buyItemRes(status, msg)
	return
end

function MoyanmainView:_canBuyGift()
	local _elizLevelGiftId_1 = 4501
	local _elizLevelGift_1 = PayShopModel.instance:getMibaoBuyTimesById(_elizLevelGiftId_1)
	local cfg_1 = PayShopConfig.instance:getPayShopGoodsCfgById(_elizLevelGiftId_1)

	self._isElizLevelGiftCanBuy_1 = PayShopModel.instance:getPayShopGoodsCanBuyById(_elizLevelGiftId_1)

	local _elizLevelGiftId_100 = 4502
	local _elizLevelGift_100 = PayShopModel.instance:getMibaoBuyTimesById(_elizLevelGiftId_100)
	local cfg_100 = PayShopConfig.instance:getPayShopGoodsCfgById(_elizLevelGiftId_100)

	self._isElizLevelGiftCanBuy_100 = PayShopModel.instance:getPayShopGoodsCanBuyById(_elizLevelGiftId_100)

	if cfg_1 and self._isElizLevelGiftCanBuy_1 or cfg_100 and self._isElizLevelGiftCanBuy_100 then
		return true
	end

	return false
end

function MoyanmainView:onRefreshUI(cid)
	self.infoMo = MoyanModel.instance:getMoByChallengeId(self._challengeId) or {}

	local itemCount = checknumber(self.infoMo.score)

	self:_updateProgressBar(cid ~= nil)

	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local petRankPrize = baseCfg.rankPrize

	MaterialMgr.setCellByCfg(petRankPrize, self._pointRankItem)

	local petRankThreshold = baseCfg.rankSize
	local rankSize = checknumber(self.infoMo.rankPrize)

	self._tipRank.gameObject:SetActive(rankSize < petRankThreshold)

	self._txtTipRank.text = langPara("moyanmainview__3", petRankThreshold)

	if not string.nilorempty(baseCfg.extItem) then
		local arr = string.split(baseCfg.extItem, "#")

		MaterialMgr.setCellByCfg(arr[1], self._itemGift)
	end

	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}

	if checknumber(baseCfg.GOODS_ID) > 0 then
		GameUtil.SetActive(self._shopGo2, true)

		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(baseCfg.GOODS_ID)
		local arr = string.split(goodsCfg.content, "#")

		MaterialMgr.setCellByCfg(arr[1], self._itemGift2)
	else
		GameUtil.SetActive(self._shopGo2, false)
	end
end

function MoyanmainView:_onGainPrizeRes()
	self:_updateProgressBar()
	FloatWordMgr.instance:show(lang("moyanmainview__2"))
end

function MoyanmainView:_updateProgressBar(needSetOffset)
	local totalScore = checknumber(self.infoMo.score)
	local scores = {}
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}

	if baseCfg then
		local prizeCfgs = MoyanConfig.instance:getPrizeCfgs(baseCfg.challengePlan)

		for _, v in ipairs(prizeCfgs) do
			table.insert(scores, v.needScore)
		end

		local x = self._bar:setValue(scores, totalScore)

		self._content.sizeDelta = Vector2.New(x + 70, 100)
		self._txtCurScore.text = langPara("moyanmainview__4", totalScore)

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

local firstInKey = "MoyanmainView_FirstIn"

function MoyanmainView:_tweenContent()
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
	local go = self:getGo("ScrollRect/ViewPort/Content")
	local duration = 1
	local fadeIn = UnityTweens.TweenPosition.Create(go, startPos, endPos, duration, UnityTweens.EaseType.linear, 0.2)
	local fadeOut = UnityTweens.TweenPosition.Create(go, endPos, startPos, duration, UnityTweens.EaseType.linear, 0)
	local tweenSeq = UnityTweens.TweenSequence.StartTween(go, fadeIn, fadeOut)

	tweenSeq:AddListener(function()
		self._scrollRect.enabled = true
	end)
end

function MoyanmainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView, self._challengeId)
end

function MoyanmainView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.gain, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.needScore

	if not self.infoMo.gainedPrizeIds then
		local gainedPrizeIds = {}
		local gained = table.indexof(gainedPrizeIds, cfg.id) ~= false

		received:SetActive(gained)

		local canGain = cfg.needScore <= checknumber(self.infoMo.score)

		if canGain and not gained then
			local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
			local eff = self:_playEffect(url, go, 0.62, true)

			table.insert(self._canGainEffs, eff)
			btn.gameObject:SetActive(true)
			btn:AddClickListener(function()
				self:_onClickPrize(self._challengeId, cfg.id)
			end)

			self._minGainedId = self._minGainedId == 0 and cfg.id - 1 or math.min(self._minGainedId, cfg.id - 1)
		else
			btn.gameObject:SetActive(false)
		end
	end
end

function MoyanmainView:_playEffect(url, parent, scale, needSetClip)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function MoyanmainView:_onClickPrize(challengeId, prizeId)
	MoyanController.instance:sendGetProgressPrize(challengeId, prizeId)
end

function MoyanmainView:_onClickStart()
	UIStateManager.instance:push(ViewName.MoyanbattleView)
end

return MoyanmainView
