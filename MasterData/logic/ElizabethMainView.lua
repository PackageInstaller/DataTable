-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/elizabeth/ElizabethMainView.lua

module("logic.extensions.timelimitedchallenge.view.elizabeth.ElizabethMainView", package.seeall)

local ElizabethMainView = class("ElizabethMainView", TimeLimitedMainView)

function ElizabethMainView:unbindEvents()
	ElizabethMainView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
	self._btnGift:RemoveClickListener()
end

function ElizabethMainView:bindEvents()
	ElizabethMainView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnAddTimes:AddClickListener(self._onClickAddTimes, self)
	self._btnGift:AddClickListener(self._onClickGift, self)
end

function ElizabethMainView:onExit()
	ElizabethMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliBuyTimesRes, self._onBuyTimesRes, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._buyItemRes, self)
	removetimer(self._updateLihuiStateReward, self)
	self:_clearLihui()
	self:_stopRoleAnims()

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil

	local go = self:getGo("ScrollRect/ViewPort/Content")

	UnityTweens.TweenSequence.StopTween(go)
	uGuiUtil.clearImage(self._itemGift)
end

function ElizabethMainView:_onBuyTimesRes()
	self:_updateTimes()
end

function ElizabethMainView:buildUI()
	ElizabethMainView.super.buildUI(self)

	self._challengeId = ElizabethConfig.instance:getConstantValue("CHALLENGE_ID", true)
	self._donotLoadRole = true
	self._slider = self:getGo("ScrollRect/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("ScrollRect/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("ScrollRect/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("ScrollRect/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._scrollRect.enabled = false
	self._txtCurScore = self:getTxt("score/Text")
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self._btnStart = self:getBtn("Button")
	self._btnAddTimes = self:getBtn("remaining/btnAdd")
	self._txtRemainingTimes = self:getTxt("remaining/txtCount")
	self._model = self:getGo("model")
	self._redImgPoint = self:getGo("Button/imgPoint")
	self._shopGo = self:getGo("shop")
	self._btnGift = self:getBtn("shop/btnShop")
	self._itemGift = self:getGo("shop/item")
	self._roleGo = self:getGo("role")
	self._roleCons = {}
	self._roleCons[1] = self:getGo("role/con_1")
	self._roleCons[2] = self:getGo("role/con_2")
	self._roleCanvasGroup = self._roleGo:GetComponent(ComponentType.CanvasGroup)
	self._petEffs = {}
end

function ElizabethMainView:onEnter()
	ElizabethMainView.super.onEnter(self)

	self._elisLimitBuyGoodId = 526
	self._maxReward = 0

	self:_updateProgressBar()
	GlobalDispatcher:addListener(GlobalNotify.EliGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EliGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EliBuyTimesRes, self._onBuyTimesRes, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._buyItemRes, self)
	ElizabethChallengeAgent.instance:sendPM_ElizabethClgGetInfoReq()
	self._redImgPoint:SetActive(false)

	self._scrollRect.enabled = false

	ElizabethModel.instance:setDailyFirstIn(false)

	if self:_canBuyGift() then
		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._elisLimitBuyGoodId)

		uGuiUtil.setSpriteToImage(self._itemGift, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon))
	else
		self._shopGo:SetActive(false)
	end

	self:_activeTipTry(false)

	local info = self:getGo("info")

	GameUtil.SetActive(info, false)

	local imgSlogan = self:getGo("imgSlogan")

	GameUtil.SetActive(imgSlogan, false)
	self:_startRoleAnims()
end

function ElizabethMainView:onEnterFinished()
	ElizabethMainView.super.onEnterFinished(self)
	self:_tweenContent()
end

function ElizabethMainView:_buyItemRes(status, msg)
	if self:_canBuyGift() then
		self._shopGo:SetActive(true)
	else
		self._shopGo:SetActive(false)
	end
end

function ElizabethMainView:_canBuyGift()
	local _elizLevelGiftId_1 = 4007
	local _elizLevelGift_1 = PayShopModel.instance:getMibaoBuyTimesById(_elizLevelGiftId_1)
	local cfg_1 = PayShopConfig.instance:getPayShopGoodsCfgById(_elizLevelGiftId_1)

	self._isElizLevelGiftCanBuy_1 = PayShopModel.instance:getPayShopGoodsCanBuyById(_elizLevelGiftId_1)

	local _elizLevelGiftId_100 = 4008
	local _elizLevelGift_100 = PayShopModel.instance:getMibaoBuyTimesById(_elizLevelGiftId_100)
	local cfg_100 = PayShopConfig.instance:getPayShopGoodsCfgById(_elizLevelGiftId_100)

	self._isElizLevelGiftCanBuy_100 = PayShopModel.instance:getPayShopGoodsCanBuyById(_elizLevelGiftId_100)

	if cfg_1 and self._isElizLevelGiftCanBuy_1 or cfg_100 and self._isElizLevelGiftCanBuy_100 then
		return true
	end

	return false
end

function ElizabethMainView:_onClickGift()
	if self:_canBuyGift() then
		local _elizGiftViewOpenId = 281
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(_elizGiftViewOpenId)

		if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			UIStateManager.instance:open(cfg.view)
		else
			FloatWordMgr.instance:show(cfg.lockedTips)
		end
	else
		FloatWordMgr.instance:show("已购买")
	end
end

function ElizabethMainView:_onClickAddTimes()
	ElizabethController.instance:addTimes()
end

function ElizabethMainView:_updateTimes()
	local cur, total = ElizabethController.instance:getCurAndTotalTimes()

	self._txtRemainingTimes.text = string.format("今日剩余次数：%d/%d", cur, total)

	self._btnAddTimes.gameObject:SetActive(cur <= 0)
	self._redImgPoint:SetActive(false)
end

function ElizabethMainView:_onGetInfoRes()
	self:_updateProgressBar(true)
	self:_updateTimes()

	local petRankPrize = ElizabethConfig.instance:getConstantValue("PET_RANK_PRIZE")

	MaterialMgr.setCellByCfg(petRankPrize, self._pointRankItem)

	local petRankThreshold = 5999

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)
end

function ElizabethMainView:_onGainPrizeRes()
	self:_updateProgressBar()
	FloatWordMgr.instance:show("领取成功")

	if self._maxReward then
		if self._maxReward > 7 then
			self._maxReward = 7
		end

		if self._maxReward < 0 then
			self._maxReward = 0
		end

		self:_updateLihuiState("hua0" .. self._maxReward, false)
	end

	settimer(1, self._updateLihuiStateReward, self, false)
end

function ElizabethMainView:_updateLihuiStateReward()
	removetimer(self._updateLihuiStateReward, self)
	self:_updateLihuiStateByReward()
end

function ElizabethMainView:_updateProgressBar(needSetOffset)
	local totalScore = ElizabethModel.instance:getFlowerNums()
	local scores = {}
	local prizePlanId = ElizabethModel.instance:getCurPrizePlanId()
	local prizeCfgs = ElizabethConfig.instance:getPrizeCfgs(prizePlanId)

	for _, v in ipairs(prizeCfgs) do
		table.insert(scores, v.flowerNum)
	end

	local x = self._bar:setValue(scores, totalScore)

	self._content.sizeDelta = Vector2.New(x + 70, 100)
	self._txtCurScore.text = string.format("已收集<color=#20b376>%d</color>", totalScore)

	if self._canGainEffs then
		for _, v in ipairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = {}
	self._maxGainedId = 0

	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

	if needSetOffset then
		local viewPortSize = self._viewPort.rect.size.x
		local contentSize = self._content.sizeDelta.x
		local maxOffset = contentSize - viewPortSize

		Framework.TransformUtil.SetAnchoredPos(self._content, 0, 0)

		local x, y, z = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)
		local cellWidth = self._gridLayout.cellSize.x
		local spacingX = self._gridLayout.spacing.x

		x = x - math.min(maxOffset, cellWidth * self._maxGainedId + spacingX * self._maxGainedId)

		Framework.TransformUtil.SetLocalPos(self._content.transform, x, 0, 0)
	end
end

local firstInKey = "ElizabethMainView_FirstIn"

function ElizabethMainView:_tweenContent()
	local viewPortSize = self._viewPort.rect.size.x
	local isFirstIn = Framework.LocalStorage.Instance:GetInt(firstInKey, 0) == 0

	if not isFirstIn then
		self._scrollRect.enabled = true

		return
	end

	Framework.LocalStorage.Instance:SetInt(firstInKey, 1)
	Framework.TransformUtil.SetAnchoredPos(self._content, 0, 0)

	local x, _ = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)
	local startPos = Vector3.New(x, 0, 0)
	local endPos = Vector3.New(x - self._content.sizeDelta.x + viewPortSize, 0, 0)
	local go = self:getGo("ScrollRect/ViewPort/Content")
	local duration = 2.5
	local fadeIn = UnityTweens.TweenPosition.Create(go, startPos, endPos, duration, UnityTweens.EaseType.linear, 0.2)
	local fadeOut = UnityTweens.TweenPosition.Create(go, endPos, startPos, duration, UnityTweens.EaseType.linear, 0)
	local tweenSeq = UnityTweens.TweenSequence.StartTween(go, fadeIn, fadeOut)

	tweenSeq:AddListener(function()
		self._scrollRect.enabled = true
	end)
end

function ElizabethMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView, self._challengeId)
end

function ElizabethMainView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.flowerNum

	local gained = ElizabethModel.instance:isPrizeGained(cfg.prizeId)

	received:SetActive(gained)

	local canGain = cfg.flowerNum <= ElizabethModel.instance:getFlowerNums()

	if canGain and not gained then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
		local eff = self:_playEffect(url, go, 0.62, true)

		table.insert(self._canGainEffs, eff)
		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			self:_onClickPrize(cfg.prizeId)
		end)
	else
		btn.gameObject:SetActive(false)
	end

	if gained then
		self._maxGainedId = math.max(self._maxGainedId, cfg.prizeId)
	end

	if cfg.prizeId > 0 and cfg.prizeId < 8 and gained then
		self._maxReward = cfg.prizeId
	end

	if self._maxReward > 7 then
		self._maxReward = 7
	end
end

function ElizabethMainView:_playEffect(url, parent, scale, needSetClip)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function ElizabethMainView:_onClickPrize(prizeId)
	ElizabethChallengeAgent.instance:sendPM_ElizabethClgGainPrizeReq(prizeId)
end

function ElizabethMainView:_onClickStart()
	local cur, total = ElizabethController.instance:getCurAndTotalTimes()
	local remainingBuyTimes = ElizabethController.instance:getRemaingBuyTimes()

	if cur <= 0 then
		if remainingBuyTimes <= 0 then
			FloatWordMgr.instance:show("今日次数用完，次日5点重置！ ")
		else
			ElizabethController.instance:addTimes(function()
				UIStateManager.instance:push(ViewName.ElizabethGameView)
			end)
		end
	else
		UIStateManager.instance:push(ViewName.ElizabethGameView)
	end
end

function ElizabethMainView:_createLihui()
	if not self._resLoader or not self._yilishabLihui then
		local path = "lihui_spine/10322_yilishabai_lihui/10322_yilishabai_lihui-ui_p.prefab"

		self._resLoader = MultiResLoader.New()

		self._resLoader:addResPath(path)
		self._resLoader:load(function()
			self._elizRes = self._resLoader:getResource(path)

			if self._elizRes then
				local main_asset = self._elizRes:GetMainAsset()

				if main_asset then
					self._yilishabLihui = goutil.cloneAndSetParent(main_asset, self._model.transform)

					GameUtil.setLocalPos(self._yilishabLihui, 0, -500, 0)
					self:_updateLihuiStateByReward()
				end
			end
		end)
	end
end

function ElizabethMainView:_updateLihuiStateByReward()
	if self._maxReward then
		if self._maxReward > 7 then
			self._maxReward = 7
		end

		if self._maxReward < 0 then
			self._maxReward = 0
		end

		if self._maxReward <= 0 then
			self:_updateLihuiState("hua0" .. self._maxReward, true)
		else
			self:_updateLihuiState("hua0" .. self._maxReward .. "_1", true)
		end
	end
end

function ElizabethMainView:_clearLihui()
	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	if self._elizRes then
		self._elizRes = nil
	end

	if self._yilishabLihui then
		goutil.destroy(self._yilishabLihui, true)

		self._yilishabLihui = nil
	end

	self._ylsbGraphic = nil
end

function ElizabethMainView:_updateLihuiState(_state, _loop)
	if not _state or not self._yilishabLihui then
		return
	end

	self._ylsbGraphic = self._yilishabLihui:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	self._ylsbGraphic.AnimationState:SetAnimation(0, _state, _loop)
	self._ylsbGraphic:Update(0)
end

function ElizabethMainView:_getSkinIdList()
	local value = ElizabethConfig.instance:getConstantValue("MAIN_VIEW_SKINID_LIST")

	return (not string.nilorempty(value) or nil) and string.split(value, "#")
end

function ElizabethMainView:_getPos(skinId)
	local x, y, scale = 0, 0, 1
	local modelCfg = CharactorFacade.instance:getElizabethUIPosAndScale(skinId)

	if modelCfg then
		scale = modelCfg[3] or 1
		y = modelCfg[2] or 0
		x = modelCfg[1] or 0
	end

	return x, y, scale
end

local RoleAnimPer = {
	Switch = 1,
	Stay = 2
}

function ElizabethMainView:_startRoleAnims()
	self._animSkinIdList = self:_getSkinIdList()
	self._curRoleIdx = 0
	self._curSkinListIdx = 0
	self._tickingDelta = 0.1
	self._totalStayDelta = 5
	self._curStayDelta = self._totalStayDelta
	self._roleAnimPer = RoleAnimPer.Stay

	if #self._animSkinIdList > 0 then
		settimer(self._tickingDelta, self._roleAnimTicking, self, true)
	end
end

function ElizabethMainView:_stopRoleAnims()
	removetimer(self._roleAnimTicking, self)
	self:_stopSwitchAnim()
	self:_clearAllRoleEff()
end

function ElizabethMainView:_roleAnimTicking()
	if self._roleAnimPer == RoleAnimPer.Switch then
		-- block empty
	elseif self._roleAnimPer == RoleAnimPer.Stay then
		self._curStayDelta = self._curStayDelta + self._tickingDelta

		if self._curStayDelta >= self._totalStayDelta then
			self._roleAnimPer = RoleAnimPer.Switch

			self:_playSwitchAnim()
		end
	end
end

function ElizabethMainView:_playSwitchAnim()
	self:_stopSwitchAnim()

	local oldGo = self._roleCons[self._curRoleIdx]

	self:_playAnimOfHideEff(oldGo)

	self._curRoleIdx = self._curRoleIdx % 2 + 1

	local newGo = self._roleCons[self._curRoleIdx]

	self._curSkinListIdx = self._curSkinListIdx % #self._animSkinIdList + 1

	local newSkinId = self._animSkinIdList[self._curSkinListIdx]

	self:_playAnimOfShowEff(newGo, newSkinId)
end

function ElizabethMainView:_stopSwitchAnim()
	self:_clearAnimOfShowEff()
	self:_clearAnimOfHideEff()
end

function ElizabethMainView:_loadRoleEff(go, skinId)
	skinId = checknumber(skinId)

	if skinId <= 0 then
		return
	end

	if goutil.isNil(go) then
		return
	end

	self._petEffs[go] = self._petEffs[go] or PetPhotoShow.Get(go)

	local eff = self._petEffs[go]
	local x, y, scale = self:_getPos(skinId)

	eff:showPetEffect(skinId, true, 3)
	eff:setPetLocalPosAndScale(x, y, scale)

	return eff
end

function ElizabethMainView:_clearRoleEff(go)
	if not goutil.isNil(go) and self._petEffs[go] then
		self._petEffs[go]:clear()

		self._petEffs[go] = nil
	end
end

function ElizabethMainView:_clearAllRoleEff()
	for _, go in ipairs(self._roleCons) do
		self:_clearRoleEff(go)
	end
end

function ElizabethMainView:_playAnimOfShowEff(go, skinId)
	local eff = self:_loadRoleEff(go, skinId)

	if eff == nil then
		return
	end

	local startVal = 0
	local endVal = 1
	local duration = 1.7
	local luaTarget = self
	local easeType = DG.Tweening.Ease.Linear

	local function updateHander(val)
		Game.ImageUtil.SetRawImageAlpha(eff._rawImg, val)
	end

	local function endHander()
		self._curStayDelta = 0
		self._roleAnimPer = RoleAnimPer.Stay
	end

	self._roleAlphaTweenOfShow = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
end

function ElizabethMainView:_clearAnimOfShowEff()
	if self._roleAlphaTweenOfShow == nil then
		return
	end

	self._roleAlphaTweenOfShow:Kill(true)

	self._roleAlphaTweenOfShow = nil
end

function ElizabethMainView:_playAnimOfHideEff(go)
	if self._petEffs then
		local eff = self._petEffs[go]

		if self._petEffs == nil then
			return
		end

		local startVal = 1
		local endVal = 0
		local duration = 1.7
		local luaTarget = self
		local easeType = DG.Tweening.Ease.Linear

		local function updateHander(val)
			Game.ImageUtil.SetRawImageAlpha(eff._rawImg, val)
		end

		local function endHander()
			self:_clearRoleEff(go)
		end

		self._roleAlphaTweenOfHide = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
	end
end

function ElizabethMainView:_clearAnimOfHideEff()
	if self._roleAlphaTweenOfHide == nil then
		return
	end

	self._roleAlphaTweenOfHide:Kill(true)

	self._roleAlphaTweenOfHide = nil
end

return ElizabethMainView
