-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsMainView.lua

module("logic.extensions.goddessglory.view.GuessPetsMainView", package.seeall)

local GuessPetsMainView = class("GuessPetsMainView", ViewComponent)

function GuessPetsMainView:buildUI()
	GuessPetsMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._txtAcTime = self:getTxt("time/txtTime")
	self._imgNode = self:getGo("con")
	self._txtTitle = self:getTxt("txtTitle")
	self._bgImage = Framework.ImageBigBG.GetFrom(self.mainGO, "bg")
	self._bubbleNode = self:getGo("bubble")
	self._bubbleDesc = self:getTxt("bubble/txtDesc")
	self._txtPlayTimes = self:getTxt("txtNum")
	self._btnStart = self:getBtn("btnStart")

	self:_buildMyScoresRewardView()
end

function GuessPetsMainView:_buildMyScoresRewardView()
	self._txtMyScores = self:getTxt("sliderArea/txtSliderDesc")
	self._myScoresSlider = Framework.SliderAdapter.Get(self:getGo("sliderArea/ScrollRect/ViewPort/Content/progressBar"))
	self._myScoresViewContent = self:getGo("sliderArea/ScrollRect/ViewPort/Content").transform
	self._myScoresViewPort = self:getGo("sliderArea/ScrollRect/ViewPort").transform
	self._myScoresScrollRect = self:getGo("sliderArea/ScrollRect"):GetComponent(ComponentType.ScrollRect)
	self._myScoresScrollRect.enabled = false

	local scRewardCell = self:getGo("sliderArea/rewardCell")

	self._myScoresPrizes = self:getGo("sliderArea/ScrollRect/ViewPort/Content/prizes")

	scRewardCell.transform:SetParent(self._myScoresPrizes.transform, false)
end

function GuessPetsMainView:bindEvents()
	GuessPetsMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnStart:AddClickListener(self._onClickStartGame, self)
end

function GuessPetsMainView:unbindEvents()
	GuessPetsMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function GuessPetsMainView:onEnter()
	GuessPetsMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsAcInfo, self._onGuessPetsAcInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsPersonPrize, self._onGuessPetsPersonPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsGlobalPrize, self._onGuessPetsGlobalPrize, self)

	self._txtTitle.text = GuessPetModel.instance:getActivityName()

	self:_createMainImage()
	self:_refreshView()
	self:_refreshSurplusTimeNode()
	self:_refreshMyScoresView(true)
	self:_showBubble()
	GuessPetController.instance:requestActivityInfo()
end

function GuessPetsMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsGlobalPrize, self._onGuessPetsGlobalPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsPersonPrize, self._onGuessPetsPersonPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsAcInfo, self._onGuessPetsAcInfo, self)
	GuessPetsMainView.super.onExit(self)
	removetimer(self._tickSurplusTime, self)

	if self._goMainImage then
		goutil.destroy(self._goMainImage)

		self._goMainImage = nil
	end

	self._personScoresCfgs = nil
	self._worldScoresCfgs = nil

	self:_stopWorldPrizeEff()

	self._isShowingWorldRecords = nil

	self._bgImage:ClearImage()

	local prizeNodeCount = self._myScoresPrizes.transform.childCount

	for i = 1, prizeNodeCount do
		local go = self._myScoresPrizes.transform:GetChild(i - 1).gameObject
		local itemCell = goutil.findChild(go, "itemcell")
		local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

		btn:RemoveClickListener()
		MaterialMgr.resetAll(itemCell)
	end

	if self._myScoresEff then
		for k, v in pairs(self._myScoresEff) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._myScoresEff = nil
	end
end

function GuessPetsMainView:_showBubble()
	local bubbleTips, posX, posY = GuessPetModel.instance:getMainViewBubble()

	if string.nilorempty(bubbleTips) then
		self._bubbleNode:SetActive(false)
	else
		self._bubbleNode:SetActive(true)

		self._bubbleDesc.text = bubbleTips

		Framework.TransformUtil.SetLocalPos(self._bubbleNode.transform, posX, posY, 0)
	end
end

function GuessPetsMainView:_refreshView()
	local curPlayTimes = GuessPetModel.instance:getCurPlayTimes()
	local maxPlayTimes = GuessPetModel.instance:getMaxPlayTimes()

	self._txtPlayTimes.text = string.format("次数：%d/%d", maxPlayTimes - curPlayTimes, maxPlayTimes)
	self._txtMyScores.text = string.format("已累计积分：<color=#5EECF5FF>%d</color>", GuessPetModel.instance:getMyScores())
end

function GuessPetsMainView:_createMainImage()
	self._bgImage:SetImage(GuessPetModel.instance:getActivityMainBgImage())

	local imgPath = GuessPetModel.instance:getMainImage()

	if string.nilorempty(imgPath) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(imgPath)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._goMainImage = goutil.clone(mainAsset)

	self._goMainImage.transform:SetParent(self._imgNode.transform, false)

	local x, y, scale = GuessPetModel.instance:getMainImagePose()

	Framework.TransformUtil.SetLocalPos(self._imgNode.transform, x, y, 0)
	Framework.TransformUtil.SetLocalScale(self._imgNode.transform, scale, scale, scale)
end

function GuessPetsMainView:_refreshSurplusTimeNode()
	removetimer(self._tickSurplusTime, self)

	local endTime = GuessPetModel.instance:getActivityEndTimeStamp()

	if endTime > 0 then
		settimer(0, self._tickSurplusTime, self)
		self:_tickSurplusTime()
	else
		self:close()
	end
end

function GuessPetsMainView:_getPersonPrizeViewConfig()
	local spacingX = 180
	local margin = 80

	return spacingX, margin
end

function GuessPetsMainView:_getPersonPrizesConfig()
	if self._personScoresCfgs then
		return self._personScoresCfgs
	end

	self._personScoresCfgs = {}

	local personPrizePlanId = GuessPetModel.instance:getPersonPrizePlanId()
	local myScoresCfgs = GuessPetConfig.instance:getPersonPrizes(personPrizePlanId)
	local prizeCount = #myScoresCfgs
	local maxScores = myScoresCfgs[#myScoresCfgs].progress
	local spacing = maxScores / prizeCount

	for i = 1, prizeCount do
		table.insert(self._personScoresCfgs, {
			progress = spacing * i,
			config = myScoresCfgs[i]
		})
	end

	return self._personScoresCfgs
end

function GuessPetsMainView:_refreshMyScoresView(centeringCurrPrize)
	local myScoresCfgs = self:_getPersonPrizesConfig()
	local prizeCount = #myScoresCfgs
	local currMyScore = GuessPetModel.instance:getMyScores()
	local maxScores = myScoresCfgs[#myScoresCfgs].progress
	local spacingX, margin = self:_getPersonPrizeViewConfig()
	local vpSizeX = self._myScoresViewPort.sizeDelta.x
	local maxScoresLen = math.max(spacingX * prizeCount, vpSizeX)
	local myScoresPrizes = self._myScoresPrizes.transform
	local prizeNodeCount = myScoresPrizes.childCount

	while prizeNodeCount < prizeCount do
		UGUIToolHelper.AddChild(myScoresPrizes.gameObject, myScoresPrizes:GetChild(0).gameObject)

		prizeNodeCount = prizeNodeCount + 1
	end

	local currCfgIdx

	for i = 1, prizeCount do
		local go = myScoresPrizes:GetChild(i - 1).gameObject

		go:SetActive(true)
		self:_fillOnePersonRewardItem(go, myScoresCfgs[i], maxScores, maxScoresLen)

		if not currCfgIdx and currMyScore <= myScoresCfgs[i].config.progress then
			currCfgIdx = i
		end
	end

	for i = prizeCount + 1, prizeNodeCount do
		local go = myScoresPrizes:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self:_ajuestPersonVPSize(maxScores, maxScoresLen, margin)

	if centeringCurrPrize then
		self:_centeringCurrPersonPrize()
	end

	currCfgIdx = currCfgIdx or #myScoresCfgs

	if currCfgIdx > 1 then
		if not (currCfgIdx - 1) then
			local preCfgIdx = 0
			local currProgressScore = currMyScore
			local maxProgressScore = myScoresCfgs[currCfgIdx].config.progress

			if preCfgIdx > 0 then
				currProgressScore = currMyScore - myScoresCfgs[preCfgIdx].config.progress
				maxProgressScore = maxProgressScore - myScoresCfgs[preCfgIdx].config.progress
			end

			local progressDelta = 1 / prizeCount

			self._myScoresSlider:SetValue(progressDelta * preCfgIdx + currProgressScore / maxProgressScore * progressDelta)
		end
	end
end

function GuessPetsMainView:_centeringCurrPersonPrize()
	local myScoresCfgs = self:_getPersonPrizesConfig()
	local prizeCount = #myScoresCfgs
	local spacingX, margin = self:_getPersonPrizeViewConfig()
	local vpSizeX = self._myScoresViewPort.sizeDelta.x
	local maxScoresLen = math.max(spacingX * prizeCount, vpSizeX)
	local currMyScore = GuessPetModel.instance:getMyScores()
	local maxScores = myScoresCfgs[#myScoresCfgs].progress

	if vpSizeX >= maxScoresLen + margin then
		Framework.TransformUtil.SetLocalPos(self._myScoresViewContent, 0, 0, 0)
	else
		local prizeIdx

		for i = 1, prizeCount do
			local data = myScoresCfgs[i]

			if not GuessPetModel.instance:hasGainedPersonPrize(data.config.id) and currMyScore >= data.config.progress then
				prizeIdx = i

				break
			end
		end

		if prizeIdx then
			local posX = maxScoresLen * myScoresCfgs[prizeIdx].progress / maxScores - vpSizeX * 0.5
			local viewSize = maxScoresLen + margin

			if posX < 0 then
				posX = 0
			elseif posX > viewSize - vpSizeX then
				posX = viewSize - vpSizeX
			end

			Framework.TransformUtil.SetLocalPos(self._myScoresViewContent, -posX, 0, 0)
		end
	end
end

function GuessPetsMainView:_ajuestPersonVPSize(maxScores, maxScoresLen, margin)
	local vpSizeX = self._myScoresViewPort.sizeDelta.x
	local contentSizeDelta = self._myScoresViewContent.sizeDelta

	contentSizeDelta.x = maxScoresLen + margin
	self._myScoresViewContent.sizeDelta = contentSizeDelta
	self._myScoresScrollRect.enabled = vpSizeX < maxScoresLen + margin

	local sizeBar = self._myScoresSlider.transform.sizeDelta

	sizeBar.x = maxScoresLen
	self._myScoresSlider.transform.sizeDelta = sizeBar
end

function GuessPetsMainView:_fillOnePersonRewardItem(go, data, maxScores, maxScoresLen)
	local currMyScore = GuessPetModel.instance:getMyScores()
	local itemCell = goutil.findChild(go, "item/itemcell")
	local received = goutil.findChild(go, "item/received")
	local canGet = goutil.findChild(go, "item/canGet")
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")
	local progress = data.progress / maxScores
	local posX = maxScoresLen * progress

	Framework.TransformUtil.SetLocalPos(go.transform, posX, 0, 0)
	MaterialMgr.setCellByCfg(data.config.prize, itemCell)
	btn:RemoveClickListener()
	self:_stopPrizeEff(go)

	if GuessPetModel.instance:hasGainedPersonPrize(data.config.id) then
		received:SetActive(true)
		canGet:SetActive(false)
		btn.gameObject:SetActive(false)
	else
		received:SetActive(false)

		if currMyScore >= data.config.progress then
			canGet:SetActive(true)
			btn.gameObject:SetActive(true)
			self:_playPrizeEff(go, canGet, self._myScoresViewPort)
			btn:AddClickListener(function()
				GuessPetController.instance:requestGainPersonPrize(data.config.id)
			end)
		else
			btn.gameObject:SetActive(false)
			canGet:SetActive(false)
		end
	end

	local scoreNumTxt = goutil.findChildTextComponent(go, "txtNum")

	scoreNumTxt.text = tostring(data.config.progress)
end

function GuessPetsMainView:_playPrizeEff(go, canGet, scoresViewPort)
	local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

	self._myScoresEff = self._myScoresEff or {}
	self._myScoresEff[go] = UIEffectManager.instance:playEffect(self, url, canGet, 0, 0, true, nil, nil, function(self2, uiEffect)
		uiEffect:setClipping(scoresViewPort)
		uiEffect:setParent(canGet.transform)
		uiEffect:setScale(1)
	end)
end

function GuessPetsMainView:_stopPrizeEff(go)
	local eff

	if self._myScoresEff then
		eff = self._myScoresEff[go]
	end

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._myScoresEff[go] = nil
	end
end

function GuessPetsMainView:_stopWorldPrizeEff()
	if self._worldPrizeEff then
		UIEffectManager.instance:stopEffect(self._worldPrizeEff)

		self._worldPrizeEff = nil
	end
end

function GuessPetsMainView:_getWorldPrizeViewConfig()
	local spacingY = 148
	local marginBottom = 6
	local marginTop = 80

	return spacingY, marginBottom, marginTop
end

function GuessPetsMainView:_getWorldScoresCfgs()
	if self._worldScoresCfgs then
		return self._worldScoresCfgs
	end

	self._worldScoresCfgs = {}

	local globalPrizePlanId = GuessPetModel.instance:getGlobalPrizePlanId()
	local worldScoresCfgs = GuessPetConfig.instance:getGlobalPrizes(globalPrizePlanId)
	local prizeCount = #worldScoresCfgs
	local maxScores = worldScoresCfgs[#worldScoresCfgs].progress
	local spacing = maxScores / prizeCount

	for i = 1, prizeCount do
		table.insert(self._worldScoresCfgs, {
			progress = spacing * i,
			config = worldScoresCfgs[i]
		})
	end

	return self._worldScoresCfgs
end

function GuessPetsMainView:_tickSurplusTime()
	local supTime = GuessPetModel.instance:getActivityEndTimeStamp() - ServerTime.now()

	if supTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

		self._txtAcTime.text = day > 0 and "活动剩余时间：" .. string.format(lang("text_countdown_notips_min"), day, hour, min) or "活动剩余时间：" .. string.format(lang("text_countdown_notips_second"), hour, min, sec)
	else
		removetimer(self._tickSurplusTime, self)
		self:close()
	end
end

function GuessPetsMainView:_onClickClose()
	self:close()
end

function GuessPetsMainView:_onClickTips()
	TipsFacade.instance:openRulesView(GuessPetModel.instance:getTipsKey())
end

function GuessPetsMainView:_onClickStartGame()
	local curPlayTimes = GuessPetModel.instance:getCurPlayTimes()
	local maxPlayTimes = GuessPetModel.instance:getMaxPlayTimes()

	if maxPlayTimes <= curPlayTimes then
		FloatWordMgr.instance:show("今日游戏次数已经耗尽")

		return
	end

	local remainingTime = GuessPetController.instance:getMatchingRemainTime()

	if remainingTime > 0 then
		FloatWordMgr.instance:show(string.format("您的操作太快了，请%s秒后重试", math.floor(remainingTime)))

		return
	end

	ViewMgr.instance:open(ViewName.GuessPetsMatching)
end

function GuessPetsMainView:_onGuessPetsAcInfo()
	self:_refreshView()
	self:_refreshMyScoresView(true)
end

function GuessPetsMainView:_onGuessPetsPersonPrize()
	self:_refreshMyScoresView(true)
end

function GuessPetsMainView:_onGuessPetsGlobalPrize()
	return
end

return GuessPetsMainView
