-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddessCollectorNewPetsView.lua

module("logic.extensions.goddesscollector.view.GoddessCollectorNewPetsView", package.seeall)

local GoddessCollectorNewPetsView = class("GoddessCollectorNewPetsView", ViewComponent)

GoddessCollectorNewPetsView.SliderAnim = "GoddessCollectorNewPetsView.SliderAnim"
GoddessCollectorNewPetsView.ViewType = {
	PetSkins = 2,
	Pets = 1
}

function GoddessCollectorNewPetsView:ctor()
	GoddessCollectorNewPetsView.super.ctor(self)

	self._imgFillVector2 = Vector2.New(0, 10)
	self._viewType = GoddessCollectorNewPetsView.ViewType.PetSkins
	self._unitPageWidth = 990
	self._prePageWidth = 50
	self._postPageWidth = 50
end

function GoddessCollectorNewPetsView:unbindEvents()
	GoddessCollectorNewPetsView.super.unbindEvents(self)
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()

	if self._bookScript then
		self._bookScript:setReleaseCallBack(nil)
	end

	self._btnRank:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessCollectorNewPetsView:bindEvents()
	GoddessCollectorNewPetsView.super.bindEvents(self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnRank:AddClickListener(self._openRankView, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GoddessCollectorNewPetsView:buildUI()
	GoddessCollectorNewPetsView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._tablecell = self:getGo("tablecell")

	goutil.setActive(self._tablecell, false)

	self._tableviewLeft = self:getGo("tableviewLeft"):GetComponent(ComponentType.UITableview)

	self._tableviewLeft:RegisterCallback(self._numInViewLeft, self._cellSize, self._cellAtIndexLeft, self)
	self._tableviewLeft:RegisterUpdateCellCallback(self._onCellUpdateLeft)
	self._tableviewLeft:RegisterReloadFinishCallback(self._onReloadFinishLeft)

	self._tableviewRight = self:getGo("tableviewRight"):GetComponent(ComponentType.UITableview)

	self._tableviewRight:RegisterCallback(self._numInViewRight, self._cellSize, self._cellAtIndexRight, self)
	self._tableviewRight:RegisterUpdateCellCallback(self._onCellUpdateRight)
	self._tableviewRight:RegisterReloadFinishCallback(self._onReloadFinishRight)

	self._bgPetGo = self:getGo("bgPet")
	self._bgSkinGo = self:getGo("bgSkin")
	self._txtPageRight = goutil.findChildTextComponent(self.mainGO, "pageBgRight/txt")
	self._txtPageLeft = goutil.findChildTextComponent(self.mainGO, "pageBgLeft/txt")
	self._imgBook = self:getGo("Imgbook")
	self._pageBgLeftGo = self:getGo("pageBgLeft"):GetComponent(ComponentType.UIChangeGroup)
	self._pageBgRightGo = self:getGo("pageBgRight"):GetComponent(ComponentType.UIChangeGroup)
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
	self._btnRank = self:getBtn("btnRank")

	goutil.setActive(self._rewardCell, false)
end

function GoddessCollectorNewPetsView:onExit()
	GoddessCollectorNewPetsView.super.onExit(self)
	self._tableviewLeft:Travel(self._clearTableview, self)
	self._tableviewRight:Travel(self._clearTableview, self)
	self:_clearBookCanvas()
	self:_clearRewardCells()
	self:_removeTween()
end

function GoddessCollectorNewPetsView:onEnter()
	GoddessCollectorNewPetsView.super.onEnter(self)
	self.addGEvent(self, GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._PM_GoddessCollectorGainPrizeRes, self)
	self.addGEvent(self, GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._updateView, self)
	self.addGEvent(self, GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._refreshSliderDatas, self)

	self._activityType = GameEnum.ActivityType.GODDESS_COLLECTOR

	local cfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 and cfg then
		self._activityId = cfg.activityId
	end

	if self._activityId <= 0 then
		self:close()

		return
	end

	GoddesscollectorModel.instance:setActivityId(self._activityId)
	GoddessCollectorAgent.instance:sendPM_GoddessCollectorGetInfoReq(self._activityId)

	self._acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
	self._skinCfgs = self:_getSkinViewDatas()
	self._isFirst = true
	self._onePageNum = 4
	self._maxPage = math.ceil(#self._skinCfgs / self._onePageNum)
	self._minPage = 1
	self._curPage = GoddesscollectorModel.instance:getCurrPetPage(self._viewType, self._minPage)
	self._maxShowPage = self._maxPage - (self._maxPage % 2 == 0 and 1 or 0)

	self:_initSliderAnimInfo()
	self:_initContentPageInfo()
	self:_updateView()
	self:_setBgActive()
	self._pageBgLeftGo:SetState(self._viewType == GoddessCollectorNewPetsView.ViewType.Pets and 1 or 0)
	self._pageBgRightGo:SetState(self._viewType == GoddessCollectorNewPetsView.ViewType.Pets and 1 or 0)
end

function GoddessCollectorNewPetsView:_openRankView()
	UIStateManager.instance:push(ViewName.GoddesscollectorRankView)
end

function GoddessCollectorNewPetsView:_refreshSliderDatas()
	self:_loadBookCanvas()
	self:_pageChange()
end

function GoddessCollectorNewPetsView:_getSkinViewDatas()
	return GoddesscollectorConfig.instance:getSkinCfgs(self._acfg.skinPlanId)
end

function GoddessCollectorNewPetsView:_onClickbtnLeft()
	if self._turnPageFlag then
		return
	end

	self._turnPageFlag = true

	if self._autoFlipScript then
		self._autoFlipScript:FlipLeftPage()
	end

	self._curPage = self._curPage - 2

	if self._curPage < self._minPage then
		self._curPage = self._minPage
	end
end

function GoddessCollectorNewPetsView:_onClickbtnRight()
	if self._turnPageFlag then
		return
	end

	self._turnPageFlag = true

	if self._autoFlipScript then
		self._autoFlipScript:FlipRightPage()
	end

	self._curPage = self._curPage + 2

	if self._curPage > self._maxPage then
		self._curPage = self._curPage - 2
	end
end

function GoddessCollectorNewPetsView:_numInViewLeft()
	if not self._curViewDataLeft then
		return 0
	end

	return #self._curViewDataLeft
end

function GoddessCollectorNewPetsView:_numInViewRight()
	if not self._curViewDataRight then
		return 0
	end

	return #self._curViewDataRight
end

function GoddessCollectorNewPetsView:_cellSize(view, index)
	return 100, 100
end

function GoddessCollectorNewPetsView:_cellAtIndexLeft(view, idx)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tablecell)

	local data = self._curViewDataLeft[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function GoddessCollectorNewPetsView:_cellAtIndexRight(view, idx)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tablecell)

	local data = self._curViewDataRight[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function GoddessCollectorNewPetsView:_onCellUpdateLeft(view, cell)
	local idx = cell.index
	local data = self._curViewDataLeft[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)
end

function GoddessCollectorNewPetsView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local comp = GoddesscollectorPetShowCard.AddOnce(container)

	comp:setPetCfg(data, self._viewType)
	comp:setClickCallBack(function()
		self:_onClickPet(data)
	end)
end

function GoddessCollectorNewPetsView:_clearTableview(cell)
	local container = goutil.findChild(cell.gameObject, "container")

	GoddesscollectorPetShowCard.Remove(container)
end

function GoddessCollectorNewPetsView:_updateView(notRefreshReward)
	GoddesscollectorModel.instance:setCurrPetPage(self._viewType, self._curPage)
	goutil.setActive(self._btnLeft.gameObject, self._curPage > self._minPage)
	goutil.setActive(self._btnRight.gameObject, self._curPage < self._maxShowPage)
	self:_showCurrPage()

	self._curViewDataLeft = {}
	self._curViewDataRight = {}

	for i = (self._curPage - 1) * self._onePageNum + 1, self._curPage * self._onePageNum do
		if self._skinCfgs[i] then
			table.insert(self._curViewDataLeft, self._skinCfgs[i])
		end
	end

	for i = self._curPage * self._onePageNum + 1, (self._curPage + 1) * self._onePageNum do
		if self._skinCfgs[i] then
			table.insert(self._curViewDataRight, self._skinCfgs[i])
		end
	end

	self._tableviewLeft:ReloadData()
	self._tableviewRight:ReloadData()

	if not notRefreshReward then
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
end

function GoddessCollectorNewPetsView:_onClickPet(cfg)
	local skinIdCfg = PetSkinConfig.instance:getPetSkinCfg(cfg.skinId)

	if not string.nilorempty(skinIdCfg.showTime) and GameUtil.string2time(skinIdCfg.showTime) > ServerTime.now() then
		FloatWordMgr.instance:show(lang("精灵未达到开启时间"))

		return
	end

	local raceCfg = CharacterConfig.instance:getPetCo(skinIdCfg.raceId)

	if not string.nilorempty(raceCfg.manualOnlineTime) and GameUtil.string2time(raceCfg.manualOnlineTime) > ServerTime.now() then
		FloatWordMgr.instance:show(lang("精灵未达到开启时间"))

		return
	end

	ViewAutoShowController.instance:saveCurModalView()

	if cfg.popup == 0 then
		local list = PetbookModel.instance:getFilterPetList()

		PetbookModel.instance:setSelectedPet(cfg.skinId)
		UIStateManager.instance:push(ViewName.GoddesscollectorPetInfoView, cfg, list)
	else
		local list = PetbookModel.instance:getFilterSkinList()

		PetbookModel.instance:setSelectedPet(cfg.skinId)
		UIStateManager.instance:push(ViewName.GoddesscollectorSkinInfoView, cfg, list)
	end
end

function GoddessCollectorNewPetsView:_PM_GoddessCollectorGainPrizeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function GoddessCollectorNewPetsView:_setBgActive()
	goutil.setActive(self._bgPetGo, self._viewType == GoddesscollectorpetsView.ViewType.Pets)
	goutil.setActive(self._bgSkinGo, self._viewType == GoddesscollectorpetsView.ViewType.PetSkins)
end

function GoddessCollectorNewPetsView:_showCurrPage()
	self._txtPageLeft.text = string.format("第%s页", self._curPage)
	self._txtPageRight.text = string.format("第%s页", self._curPage + 1)
end

function GoddessCollectorNewPetsView:_isGainPrize(prizeId)
	return GoddesscollectorModel.instance:isGainSkinCollectPrize(prizeId)
end

function GoddessCollectorNewPetsView:_isCanGainPrize(prizeId)
	return GoddesscollectorModel.instance:isCanGainSkinCollectPrize(prizeId)
end

function GoddessCollectorNewPetsView:_getRewardCfgs()
	return GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.skinPrizePlanId)
end

function GoddessCollectorNewPetsView:_getCurrCollectScore()
	return GoddesscollectorModel.instance:getSkinCollectScore()
end

function GoddessCollectorNewPetsView:_loadBookCanvas()
	local prefab = self._viewPresentor:getPrefab(GoddessCollectorNewPetsViewPresentor.bookCanvasPath)
	local prefabGo = goutil.clone(prefab)

	self:_initBookCapture(prefabGo)
	self._booktestcanvas:SetActive(true)

	if self._bookScript then
		self._bookScript:setReleaseCallBack(function(_mode)
			self._turnPageFlag = false

			self:_pageChange(_mode, 2, true)
		end)

		self._bookScript.allFilpPage = self._maxPage
	end
end

function GoddessCollectorNewPetsView:_initBookCapture(booktestcanvas)
	if not booktestcanvas then
		return
	end

	self._booktestcanvas = booktestcanvas
	self._book = goutil.findChild(booktestcanvas, "book")
	self._bookScript = self._book:GetComponent("Book")
	self._autoFlipScript = self._book:GetComponent("AutoFlip")
	self._uiRootRect = goutil.find("UIROOT").gameObject:GetComponent("RectTransform")
	self._uiRootWidth = self._uiRootRect.sizeDelta.x
	self._uiRootHeight = self._uiRootRect.sizeDelta.y
	self._screenW, self._screenH = UnityEngine.Screen.width, UnityEngine.Screen.height
	self._pageBgCaptureW = 544
	self._pageBgCaptureH = 500

	local _curWidthRate = self._screenW * (self._pageBgCaptureH * 2) / self._uiRootWidth
	local _curHeightRate = self._screenH * self._pageBgCaptureW / self._uiRootHeight

	self._book.gameObject:GetComponent("RectTransform").sizeDelta = Vector2.New(_curWidthRate, _curHeightRate)

	local _ImgbookPos = GameUtil.getLocalPos(self._imgBook)
	local _ImgbookRectTra = self._imgBook.gameObject:GetComponent("RectTransform")
	local _ImgbookW = _ImgbookRectTra.rect.width
	local _ImgbookH = _ImgbookRectTra.rect.height
	local _wEdge = (self._uiRootWidth - _ImgbookW) / 2
	local _imgbookToPageBgH = 76

	self._bookScript.leftBeginWRate = (_wEdge + _imgbookToPageBgH) / self._uiRootWidth

	local _hEdge = (self._uiRootHeight - _ImgbookH) / 2 + _ImgbookPos.y
	local _imgbookToPageBgBottomV = 75

	self._bookScript.allbeginHRate = (_hEdge + _imgbookToPageBgBottomV) / self._uiRootHeight
	self._bookScript.rightBeginWRate = 0.51
	self._bookScript.heightRate = self._pageBgCaptureW / self._uiRootHeight
	self._bookScript.widthRate = self._pageBgCaptureH / self._uiRootWidth
	self._bookScript.filpPage = 1

	self._bookScript:InitOper()
	self._booktestcanvas:SetActive(false)
end

function GoddessCollectorNewPetsView:_pageChange(_mode, _step, notRefreshReward)
	if self._bookScript then
		self._bookScript.filpPage = self._curPage
	end

	self:_updateView(notRefreshReward)
end

function GoddessCollectorNewPetsView:_clearBookCanvas()
	if self._booktestcanvas then
		goutil.destroy(self._booktestcanvas)

		self._booktestcanvas = nil
	end
end

function GoddessCollectorNewPetsView:_refreshRewardCells()
	local list = self:_getRewardCfgs()

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

function GoddessCollectorNewPetsView:_updateRewardCell(index, go, cfg)
	local itemGo = goutil.findChild(go, "item/itemcell")
	local getedGo = goutil.findChild(go, "item/received")
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local canGet = goutil.findChild(go, "item/effect")
	local bestScore = self:_getCurrCollectScore()
	local isGeted = self:_isGainPrize(cfg.prizeId)
	local isCanGet = bestScore >= cfg.needScore

	local function onClick()
		if isGeted then
			FloatWordMgr.instance:show("奖励已领取")
		elseif isCanGet then
			GoddessCollectorAgent.instance:sendPM_GoddessCollectorGainPrizeReq(self._activityId, self:_getPrizeType(), cfg.prizeId)
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

function GoddessCollectorNewPetsView:_clearRewardCells()
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

function GoddessCollectorNewPetsView:_refreshScoreDesc()
	local prizeList = self:_getRewardCfgs()
	local totalScore = 0

	for i, v in ipairs(prizeList) do
		totalScore = totalScore + v.needScore
	end

	local curScore = self:_getCurrCollectScore()

	self:_setSlider(curScore, totalScore)

	if prizeList and #prizeList > 0 then
		local maxCount = #prizeList

		for i, v in ipairs(prizeList) do
			if curScore < v.needScore then
				self._txtSliderDesc.text = string.format("收集满<color=#ffe288>%d</color>只\n可领取下一级奖励", v.needScore)

				break
			end

			if i == maxCount then
				self._txtSliderDesc.text = "已解锁全部奖励"
			end
		end
	end
end

function GoddessCollectorNewPetsView:_setSlider(curScore, totalScore)
	local list = self:_getRewardCfgs()

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

function GoddessCollectorNewPetsView:_initContentPageInfo()
	local list = self:_getRewardCfgs()

	self._unitPageScore = 500
	self._unitScoreDiviveUnitWidth = self._unitPageScore / self._unitPageWidth
	self._sliderWidth = 150 * #list
	self._contentWidth = 150 * #list + 75

	goutil.setWidth(self._contentRectTrans, self._contentWidth)
	goutil.setWidth(self._progressBarRect, self._sliderWidth)
end

function GoddessCollectorNewPetsView:_updateScrollRectPos()
	local list = self:_getRewardCfgs()

	if not list or #list == 0 then
		self._scrollRect.horizontalNormalizedPosition = 0

		return
	end

	local canGetIndex = 0
	local getedIndex = 0
	local curScore = self:_getCurrCollectScore()

	for i, v in ipairs(list) do
		local isGeted = self:_isGainPrize(v.prizeId)
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

function GoddessCollectorNewPetsView:_initSliderAnimInfo()
	local isPlayed = GameUtil.getUserData(GoddessCollectorNewPetsView.SliderAnim .. self._viewType)

	self._isPlaySliderAnim = not isPlayed

	goutil.setActive(self._sliderMask, not isPlayed)
end

function GoddessCollectorNewPetsView:_playSliderAnimation()
	local isPlayed = true
	local startPos = 0
	local endPos = 1
	local duration = 2
	local delay = 1

	GameUtil.saveUserData(GoddessCollectorNewPetsView.SliderAnim .. self._viewType, isPlayed)

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

function GoddessCollectorNewPetsView:_removeTween()
	if self._sequence then
		self._sequence:Kill(false)
	end
end

function GoddessCollectorNewPetsView:_getPrizeType()
	return GameEnum.GoddessCollector_PrizeType.SKIN_PRIZE
end

return GoddessCollectorNewPetsView
