-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GodcollcultivateView.lua

module("logic.extensions.goddesscollector.view.GodcollcultivateView", package.seeall)

local GodcollcultivateView = class("GodcollcultivateView", ViewComponent)

GodcollcultivateView.SliderAnim = "GodcollcultivateView.SliderAnim"

function GodcollcultivateView:ctor()
	GodcollcultivateView.super.ctor(self)

	self._unitPageWidth = 990
	self._prePageWidth = 50
	self._postPageWidth = 50
	self._cacheV2 = Vector2.New(0, 0)
	self._effectHandlers = {}
end

function GodcollcultivateView:unbindEvents()
	GodcollcultivateView.super.unbindEvents(self)
	self._btnVerify:RemoveClickListener()
end

function GodcollcultivateView:bindEvents()
	GodcollcultivateView.super.bindEvents(self)
	self._btnVerify:AddClickListener(self._onClickbtnVerify, self)
end

function GodcollcultivateView:buildUI()
	GodcollcultivateView.super.buildUI(self)

	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._btnVerify = self:getBtn("mid/btnVerify")
	self._txtIntegral = goutil.findChildTextComponent(self.mainGO, "mid/btnVerify/txtIntegral")
	self._txtMax = goutil.findChildTextComponent(self.mainGO, "mid/btnVerify/txtMax")
	self._tweenRotate = self:getGo("mid/lunpan/img"):GetComponent(UnityTweensType.TweenRotate)
	self._conGo = self:getGo("con")
	self._midGo = self:getGo("mid")
	self._petItems = {}

	for i = 1, 6 do
		local go = goutil.findChild(self._midGo, "pet_" .. i)

		self._petItems[i] = {
			fillComp = Framework.SliderAdapter.GetFrom(go, "effect"),
			itemCon = goutil.findChild(go, "con"),
			txtLevel = goutil.findChildTextComponent(go, "txtLevel"),
			txtScore = goutil.findChildTextComponent(go, "txtScore"),
			maskGo = goutil.findChild(go, "mask"),
			selectGo = goutil.findChild(go, "select"),
			effectVerify = goutil.findChild(go, "effect/effectVerify")
		}

		goutil.setActive(self._petItems[i].maskGo, true)
		goutil.setActive(self._petItems[i].selectGo, false)
		self._petItems[i].fillComp:SetValue(0)

		self._petItems[i].txtLevel.text = "无"
		self._petItems[i].txtScore.text = ""
	end

	self._rewardCell = self:getGo("scorollReward/ScrollRect/ViewPort/Content/prizes/cell")
	self._slider = self:getSlider("scorollReward/ScrollRect/ViewPort/Content/progressBar")
	self._progressBarRect = self:getGo("scorollReward/ScrollRect/ViewPort/Content/progressBar"):GetComponent(goutil.Type_RectTransform)
	self._content = self:getGo("scorollReward/ScrollRect/ViewPort/Content")
	self._contentRectTrans = self._content:GetComponent(goutil.Type_RectTransform)
	self._scrollRectTransform = self:getGo("scorollReward/ScrollRect"):GetComponent(goutil.Type_RectTransform)
	self._scrollRect = self:getGo("scorollReward/ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._sliderMask = self:getGo("scorollReward/ScrollRect/sliderMask")
	self._sliderStartPos = self._progressBarRect.anchoredPosition.x
	self._sliderWidth = self._progressBarRect.rect.width
	self._txtSliderDesc = self:getTxt("scorollReward/txtSliderDesc")

	goutil.setActive(self._rewardCell, false)

	self._effectGo = self:getGo("effect")
end

function GodcollcultivateView:onExit()
	GodcollcultivateView.super.onExit(self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes, self._PM_GoddessCollectorVerifyPetsRes, self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._PM_GoddessCollectorGainPrizeRes, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	removetimer(self._playAnim, self)
	GoddesscollectorModel.instance:resetVerify()
	self:_resetPetItems()
	self:_clearRewardCells()
	self:_removeTween()
	GoddesscollectorController.instance:setIsVerifyAnim(false)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	UIEffectManager.instance:stopEffect(self._effectHandlerVerify)

	for k, v in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlers = {}
	self._isVerifyRes = false
end

function GodcollcultivateView:onEnter()
	GodcollcultivateView.super.onEnter(self)

	self._isFirst = true

	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorVerifyPetsRes, self._PM_GoddessCollectorVerifyPetsRes, self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._PM_GoddessCollectorGainPrizeRes, self)

	self._activityId = GoddesscollectorModel.instance:getActivityId()
	self._acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)

	self:_initSliderAnimInfo()
	self:_initContentPageInfo()
	self:_setRule()
	self:_updateView(true)
	self:_setRole()
	self:_playEffect()
end

function GodcollcultivateView:_setRule()
	local ruleCo = RulesConfig.instance:getRuleCo("godcollcultivateview")

	self._txtDesc.text = tostring((not ruleCo.title or nil) and 0)
end

function GodcollcultivateView:_onClickbtnVerify()
	if self._isPlayingAnim then
		FloatWordMgr.instance:show("验证中")

		return
	end

	GoddessCollectorAgent.instance:sendPM_GoddessCollectorVerifyPetsReq(self._activityId)
end

function GodcollcultivateView:_PM_GoddessCollectorVerifyPetsRes(status)
	if status == 0 then
		self._isVerifyRes = true

		self:_updateView()
	end
end

function GodcollcultivateView:_PM_GoddessCollectorGainPrizeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function GodcollcultivateView:_updateView()
	self:_setPets()
	self:_refreshRewardCells()
	self:_refreshScoreDesc()

	if self._isFirst then
		self._isFirst = false

		if self._isPlaySliderAnim then
			self:_playSliderAnimation()
		else
			self:_updateScrollRectPos()
		end
	end
end

function GodcollcultivateView:_setRole()
	local skinId = GoddesscollectorConfig.instance:getCommonValue("BLESS_SHOW_RACECID", true)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._conGo, 0.8, nil, true, 90, -160)
end

function GodcollcultivateView:_resetPetItems()
	for i, item in ipairs(self._petItems) do
		MaterialMgr.resetAll(item.itemCon)
		goutil.setActive(item.maskGo, true)
		goutil.setActive(item.selectGo, false)
		item.fillComp:SetValue(0)

		item.txtLevel.text = "无"
		item.txtScore.text = ""
	end
end

function GodcollcultivateView:_setPets(needReset)
	if not self._isVerifyRes then
		self:_setScore()

		return
	end

	self._isVerifyRes = false

	local needPlay = GoddesscollectorController.instance:needPlayVerifyAnim()

	if not needPlay then
		self:_setScore()

		return
	end

	local list = GoddesscollectorModel.instance:getVerifyPetInfos()

	if #list <= 0 then
		self:_setScore()

		return
	end

	self._petInfos = {}

	for i, v in ipairs(list) do
		table.insert(self._petInfos, v)
	end

	self:_resetPetItems()

	self._playAnimIndex = 1

	self:_playAnim()
end

function GodcollcultivateView:_playAnim()
	local item = self._petItems[self._playAnimIndex]

	if not item then
		self:_stopPlayAnim()

		return
	end

	local petInfo = self._petInfos[self._playAnimIndex]

	if not petInfo then
		self:_stopPlayAnim()

		return
	end

	self:_playVerifyEffect()
	self:_playFillEffect(item.effectVerify)

	self._isPlayingAnim = true

	GoddesscollectorController.instance:setIsVerifyAnim(true)
	goutil.setActive(item.maskGo, false)
	goutil.setActive(item.selectGo, true)

	local petMo = BagModel.instance:getPet(petInfo.petId)

	if petMo then
		MaterialMgr.setCellByCfg(MatType.Pet .. ":" .. petMo.curFaceId, item.itemCon)

		item.txtLevel.text = string.format("Lv.%s", petMo:getPetLv())
	end

	item.txtScore.text = string.format("积分：%s", petInfo.score)
	self._fillComp = item.fillComp
	self._effectVerifyTr = item.effectVerify.transform
	self._fillValue = 0

	settimer(0, self._fillMove, self, true)

	self._playAnimIndex = self._playAnimIndex + 1
end

function GodcollcultivateView:_fillMove()
	self._fillValue = self._fillValue + 0.05
	self._cacheV2.x = 10
	self._cacheV2.y = 80 * math.min(1, self._fillValue)
	self._effectVerifyTr.sizeDelta = self._cacheV2

	self._fillComp:SetValue(self._fillValue)

	if self._fillValue >= 1 then
		removetimer(self._fillMove, self)
		self:_playAnim()
	end
end

function GodcollcultivateView:_setScore()
	self._txtIntegral.text = string.format("当前积分：<color=#20B376FF>%s</color>", GoddesscollectorModel.instance:getVerifyCurrSore())
	self._txtMax.text = string.format("历史最高：<color=#EB4642FF>%s</color>", GoddesscollectorModel.instance:getVerifyHistoryBestScore())
end

function GodcollcultivateView:_stopPlayAnim()
	removetimer(self._fillMove, self)

	self._isPlayingAnim = false

	self:_setScore()
	GoddesscollectorController.instance:setIsVerifyAnim(false)
end

function GodcollcultivateView:_refreshRewardCells()
	local list = GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.verificationPrizePlanId)

	if not list or #list == 0 then
		return
	end

	self._rewardGoList = self._rewardGoList or {}
	self._rewardEffectList = self._rewardEffectList or {}

	if #self._rewardGoList > 0 then
		for i, v in ipairs(self._rewardGoList) do
			self:_updateRewardCell(i, v, list[i])
		end
	else
		local count = #list
		local interval = self._sliderWidth / count

		for i, v in ipairs(list) do
			local go = goutil.cloneAndSetParent(self._rewardCell, self._content.transform, "reward_" .. i)

			goutil.setActive(go, true)
			table.insert(self._rewardGoList, go)

			local rectTrans = go:GetComponent(goutil.Type_RectTransform)
			local x = self._sliderStartPos + i * interval

			Framework.TransformUtil.SetAnchoredPos(rectTrans, x, 0)
			self:_updateRewardCell(i, go, v)
		end
	end
end

function GodcollcultivateView:_updateRewardCell(index, go, cfg)
	local itemGo = goutil.findChild(go, "item/itemcell")
	local getedGo = goutil.findChild(go, "item/received")
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local canGet = goutil.findChild(go, "item/effect")
	local bestScore = GoddesscollectorModel.instance:getVerifyHistoryBestScore()
	local isGeted = GoddesscollectorModel.instance:isGainVerifyPrize(cfg.prizeId)
	local isCanGet = bestScore >= cfg.needScore

	local function onClick()
		if isGeted then
			FloatWordMgr.instance:show("奖励已领取")
		elseif isCanGet then
			GoddessCollectorAgent.instance:sendPM_GoddessCollectorGainPrizeReq(self._activityId, GameEnum.GoddessCollector_PrizeType.VERIFICATION_PRIZE, cfg.prizeId)
		else
			FloatWordMgr.instance:show(string.format("请先达到%d积分", cfg.needScore))
		end
	end

	btn:AddClickListener(onClick)

	txtNum.text = cfg.needScore

	goutil.setActive(getedGo, isGeted)
	goutil.setActive(canGet, not isGeted and isCanGet)
	goutil.setActive(btn.gameObject, not isGeted and isCanGet)
	MaterialMgr.setCellByCfg(cfg.prize, itemGo)

	if not self._rewardEffectList[index] then
		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", canGet.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._scrollRectTransform) then
				eff:setClipping(self._scrollRectTransform)
			end
		end)

		effect:setParent(canGet.transform)
		effect:setScale(1)

		self._rewardEffectList[index] = effect
	end
end

function GodcollcultivateView:_clearRewardCells()
	self._rewardGoList = self._rewardGoList or {}
	self._rewardEffectList = self._rewardEffectList or {}

	for i, go in ipairs(self._rewardGoList) do
		local itemGo = goutil.findChild(go, "item/itemcell")
		local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

		MaterialMgr.resetAll(itemGo)
		btn:RemoveClickListener()
	end

	if self._rewardEffectList then
		for k, v in pairs(self._rewardEffectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._rewardEffectList = nil
	end
end

function GodcollcultivateView:_refreshScoreDesc()
	local prizeList = GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.verificationPrizePlanId)
	local totalScore = 0

	for i, v in ipairs(prizeList) do
		totalScore = totalScore + v.needScore
	end

	local curScore = GoddesscollectorModel.instance:getVerifyHistoryBestScore()

	self:_setSlider(curScore, totalScore)

	if prizeList and #prizeList > 0 then
		local maxCount = #prizeList

		for i, v in ipairs(prizeList) do
			if curScore < v.needScore then
				self._txtSliderDesc.text = string.format("积分达到 %d/%d\n可领取奖励", curScore, v.needScore)

				break
			end

			if i == maxCount then
				self._txtSliderDesc.text = "已解锁全部奖励"
			end
		end
	end
end

function GodcollcultivateView:_setSlider(curScore, totalScore)
	local list = GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.verificationPrizePlanId)

	if not list or #list == 0 then
		return
	end

	local num = 0
	local count = #list
	local lastScore = 0
	local interval = 1 / count
	local sliderValue = 0

	for i, v in ipairs(list) do
		if curScore < v.needScore then
			sliderValue = num * interval + (curScore - lastScore) / (v.needScore - lastScore) * interval

			break
		elseif i ~= #list then
			lastScore = v.needScore
			num = num + 1
		else
			sliderValue = 1
		end
	end

	self._slider:SetValue(sliderValue)
end

function GodcollcultivateView:_initContentPageInfo()
	local list = GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.verificationPrizePlanId)

	self._unitPageScore = 500
	self._unitScoreDiviveUnitWidth = self._unitPageScore / self._unitPageWidth
	self._sliderWidth = 150 * #list
	self._contentWidth = 150 * #list + 75

	goutil.setWidth(self._contentRectTrans, self._contentWidth)
	goutil.setWidth(self._progressBarRect, self._sliderWidth)
end

function GodcollcultivateView:_updateScrollRectPos()
	local list = GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.verificationPrizePlanId)

	if not list or #list == 0 then
		self._scrollRect.horizontalNormalizedPosition = 0

		return
	end

	local canGetIndex = 0
	local getedIndex = 0
	local curScore = GoddesscollectorModel.instance:getVerifyHistoryBestScore()

	for i, v in ipairs(list) do
		local isGeted = GoddesscollectorModel.instance:isGainVerifyPrize(v.prizeId)
		local isCanGet = curScore >= v.needScore

		if canGetIndex == 0 and not isGeted and isCanGet then
			canGetIndex = i

			break
		end

		if isGeted then
			getedIndex = i
		end
	end

	local pos = 0

	if self._contentWidth > self._unitPageWidth then
		if canGetIndex > 0 then
			pos = (self._sliderStartPos + list[canGetIndex].needScore * self._unitScoreDiviveUnitWidth) / (self._contentWidth - self._unitPageWidth)
		elseif getedIndex > 0 then
			pos = (self._sliderStartPos + list[getedIndex].needScore * self._unitScoreDiviveUnitWidth) / (self._contentWidth - self._unitPageWidth)
		end
	end

	pos = pos <= 1 and pos or 1
	self._scrollRect.horizontalNormalizedPosition = pos
end

function GodcollcultivateView:_initSliderAnimInfo()
	local isPlayed = GameUtil.getUserData(GodcollcultivateView.SliderAnim)

	self._isPlaySliderAnim = not isPlayed

	goutil.setActive(self._sliderMask, not isPlayed)
end

function GodcollcultivateView:_playSliderAnimation()
	local isPlayed = true
	local startPos = 0
	local endPos = 1
	local duration = 2
	local delay = 1

	GameUtil.saveUserData(GodcollcultivateView.SliderAnim, isPlayed)

	local function updateTween(num)
		if self._scrollRect then
			self._scrollRect.horizontalNormalizedPosition = num
		end
	end

	local function endTween()
		goutil.setActive(self._sliderMask, false)
		self:_updateScrollRectPos()
	end

	self._scrollRect.horizontalNormalizedPosition = 0

	goutil.setActive(self._sliderMask, true)

	self._sequence = DG.Tweening.DOTween.Sequence()

	self._sequence:SetDelay(delay)

	local tweener1 = TweenUtil.DOTweenNum(startPos, endPos, duration, updateTween, self)
	local tweener2 = TweenUtil.DOTweenNum(endPos, startPos, duration - 1, updateTween, self)
	local tweener3 = TweenUtil.DoDelay(1, endTween)

	self._sequence:Append(tweener1)
	self._sequence:Append(tweener2)
	self._sequence:Append(tweener3)
end

function GodcollcultivateView:_removeTween()
	if self._sequence then
		self._sequence:Kill(false)
	end
end

function GodcollcultivateView:_playEffect()
	local effName = "20220304/nvshenshougezhe/nvshenshougezhe_perfab/fx_ui_nvshenshougezhe_xunhuan.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function GodcollcultivateView:_playVerifyEffect()
	local effName = "20220304/nvshenshougezhe/nvshenshougezhe_perfab/fx_ui_nvshenshougezhe_yanzheng.prefab"

	self._effectHandlerVerify = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectHandlerVerify:setParent(self._effectGo.transform)
	self._effectHandlerVerify:setLocalPos(0, 0, 0)
	self._effectHandlerVerify:setScale(1)
end

function GodcollcultivateView:_playFillEffect(go)
	local handler = self._effectHandlers[go]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	local effName = "20220304/nvshenshougezhe/nvshenshougezhe_perfab/fx_ui_nvshenshougezhe_guangxiao1.prefab"

	handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, nil, function(ref, eff)
		handler:setClipping(go:GetComponent(goutil.Type_RectTransform))

		if eff.effGo then
			Framework.TransformUtil.SetAnchoredPos(eff.effGo.transform, 0, 0)
		end
	end)

	handler:setParent(go.transform)
	handler:setLocalPos(0, 0, 0)
	handler:setScale(1)
	handler:setLocalEulerAngle(0, 0, 0)

	self._effectHandlers[go] = handler
end

return GodcollcultivateView
