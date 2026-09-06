-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorpetsView.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorpetsView", package.seeall)

local GoddesscollectorpetsView = class("GoddesscollectorpetsView", ViewComponent)

GoddesscollectorpetsView.SliderAnim = "GoddesscollectorpetsView.SliderAnim"
GoddesscollectorpetsView.ViewType = {
	PetSkins = 2,
	Pets = 1
}

function GoddesscollectorpetsView:ctor()
	GoddesscollectorpetsView.super.ctor(self)

	self._imgFillVector2 = Vector2.New(0, 10)
	self._viewType = GoddesscollectorpetsView.ViewType.Pets
	self._unitPageWidth = 990
	self._prePageWidth = 50
	self._postPageWidth = 50
end

function GoddesscollectorpetsView:unbindEvents()
	GoddesscollectorpetsView.super.unbindEvents(self)
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._bookScript:setReleaseCallBack(nil)
end

function GoddesscollectorpetsView:bindEvents()
	GoddesscollectorpetsView.super.bindEvents(self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
end

function GoddesscollectorpetsView:buildUI()
	GoddesscollectorpetsView.super.buildUI(self)

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

	goutil.setActive(self._rewardCell, false)
end

function GoddesscollectorpetsView:onExit()
	GoddesscollectorpetsView.super.onExit(self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._PM_GoddessCollectorGainPrizeRes, self)
	GlobalDispatcher:removeListener(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._updateView, self)
	self._tableviewLeft:Travel(self._clearTableview, self)
	self._tableviewRight:Travel(self._clearTableview, self)
	self:_clearBookCanvas()
	self:_clearRewardCells()
	self:_removeTween()
end

function GoddesscollectorpetsView:onEnter()
	GoddesscollectorpetsView.super.onEnter(self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGainPrizeRes, self._PM_GoddessCollectorGainPrizeRes, self)
	GlobalDispatcher:addListener(GoddesscollectorController.PM_GoddessCollectorGetInfoRes, self._updateView, self)

	self._activityId = GoddesscollectorModel.instance:getActivityId()
	self._acfg = GoddesscollectorConfig.instance:getActCfg(self._activityId)
	self._petCfgs = self:_getViewDatas()
	self._isFirst = true
	self._onePageNum = 4
	self._maxPage = math.ceil(#self._petCfgs / self._onePageNum)
	self._minPage = 1
	self._curPage = GoddesscollectorModel.instance:getCurrPetPage(self._viewType, self._minPage)
	self._maxShowPage = self._maxPage - (self._maxPage % 2 == 0 and 1 or 0)

	self:_initSliderAnimInfo()
	self:_initContentPageInfo()
	self:_updateView()
	self:_setBgActive()
	self:_loadBookCanvas()
	self:_pageChange()
	self._pageBgLeftGo:SetState(self._viewType == GoddesscollectorpetsView.ViewType.Pets and 1 or 0)
	self._pageBgRightGo:SetState(self._viewType == GoddesscollectorpetsView.ViewType.Pets and 1 or 0)
end

function GoddesscollectorpetsView:_getViewDatas()
	return GoddesscollectorConfig.instance:getPetCfg(self._acfg.petPlanId)
end

function GoddesscollectorpetsView:_onClickbtnLeft()
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

function GoddesscollectorpetsView:_onClickbtnRight()
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

function GoddesscollectorpetsView:_numInViewLeft()
	if not self._curViewDataLeft then
		return 0
	end

	return #self._curViewDataLeft
end

function GoddesscollectorpetsView:_numInViewRight()
	if not self._curViewDataRight then
		return 0
	end

	return #self._curViewDataRight
end

function GoddesscollectorpetsView:_cellSize(view, index)
	return 100, 100
end

function GoddesscollectorpetsView:_cellAtIndexLeft(view, idx)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tablecell)

	local data = self._curViewDataLeft[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function GoddesscollectorpetsView:_cellAtIndexRight(view, idx)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tablecell)

	local data = self._curViewDataRight[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function GoddesscollectorpetsView:_onCellUpdateLeft(view, cell)
	local idx = cell.index
	local data = self._curViewDataLeft[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)
end

function GoddesscollectorpetsView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local comp = GoddesscollectorPetShowCard.AddOnce(container)

	comp:setPetCfg(data, self._viewType)
	comp:setClickCallBack(function()
		self:_onClickPet(data)
	end)
end

function GoddesscollectorpetsView:_clearTableview(cell)
	local container = goutil.findChild(cell.gameObject, "container")

	GoddesscollectorPetShowCard.Remove(container)
end

function GoddesscollectorpetsView:_updateView(notRefreshReward)
	GoddesscollectorModel.instance:setCurrPetPage(self._viewType, self._curPage)
	goutil.setActive(self._btnLeft.gameObject, self._curPage > self._minPage)
	goutil.setActive(self._btnRight.gameObject, self._curPage < self._maxShowPage)
	self:_showCurrPage()

	self._curViewDataLeft = {}
	self._curViewDataRight = {}

	for i = (self._curPage - 1) * self._onePageNum + 1, self._curPage * self._onePageNum do
		if self._petCfgs[i] then
			table.insert(self._curViewDataLeft, self._petCfgs[i])
		end
	end

	for i = self._curPage * self._onePageNum + 1, (self._curPage + 1) * self._onePageNum do
		if self._petCfgs[i] then
			table.insert(self._curViewDataRight, self._petCfgs[i])
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

function GoddesscollectorpetsView:_onClickPet(cfg)
	UIStateManager.instance:open(ViewName.GoddesscollectorpetdetailView, cfg, self._viewType)
end

function GoddesscollectorpetsView:_PM_GoddessCollectorGainPrizeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function GoddesscollectorpetsView:_setBgActive()
	goutil.setActive(self._bgPetGo, self._viewType == GoddesscollectorpetsView.ViewType.Pets)
	goutil.setActive(self._bgSkinGo, self._viewType == GoddesscollectorpetsView.ViewType.PetSkins)
end

function GoddesscollectorpetsView:_showCurrPage()
	self._txtPageLeft.text = string.format("第%s页", self._curPage)
	self._txtPageRight.text = string.format("第%s页", self._curPage + 1)
end

function GoddesscollectorpetsView:_isGainPrize(prizeId)
	return GoddesscollectorModel.instance:isGainPetCollectPrize(prizeId)
end

function GoddesscollectorpetsView:_isCanGainPrize(prizeId)
	return GoddesscollectorModel.instance:isCanGainPetCollectPrize(prizeId)
end

function GoddesscollectorpetsView:_getRewardCfgs()
	return GoddesscollectorConfig.instance:getPrizeCfgs(self._acfg.petPrizePlanId)
end

function GoddesscollectorpetsView:_getCurrCollectScore()
	return GoddesscollectorModel.instance:getPetCollectScore()
end

function GoddesscollectorpetsView:_loadBookCanvas()
	local prefab = self._viewPresentor:getPrefab(GoddesscollectorpetsViewPresentor.bookCanvasPath)
	local prefabGo = goutil.clone(prefab)

	self:_initBookCapture(prefabGo)
	self._booktestcanvas:SetActive(true)
	self._bookScript:setReleaseCallBack(function(_mode)
		self._turnPageFlag = false

		self:_pageChange(_mode, 2, true)
	end)

	if self._bookScript then
		self._bookScript.allFilpPage = self._maxPage
	end
end

function GoddesscollectorpetsView:_initBookCapture(booktestcanvas)
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

	local _ImgbookPos = GameUtil.getLocalPos(self._imgBook)
	local _ImgbookRectTra = self._imgBook.gameObject:GetComponent("RectTransform")

	self._bookScript.filpPage = 1

	self._bookScript:InitOper()
	self._booktestcanvas:SetActive(false)
end

function GoddesscollectorpetsView:_pageChange(_mode, _step, notRefreshReward)
	if self._bookScript then
		self._bookScript.filpPage = self._curPage
	end

	self:_updateView(notRefreshReward)
end

function GoddesscollectorpetsView:_clearBookCanvas()
	if self._booktestcanvas then
		goutil.destroy(self._booktestcanvas)

		self._booktestcanvas = nil
	end
end

function GoddesscollectorpetsView:_refreshRewardCells()
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

function GoddesscollectorpetsView:_updateRewardCell(index, go, cfg)
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

function GoddesscollectorpetsView:_clearRewardCells()
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

function GoddesscollectorpetsView:_refreshScoreDesc()
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
				self._txtSliderDesc.text = string.format("积分达到 %d/%d\n可领取奖励", curScore, v.needScore)

				break
			end

			if i == maxCount then
				self._txtSliderDesc.text = "已解锁全部奖励"
			end
		end
	end
end

function GoddesscollectorpetsView:_setSlider(curScore, totalScore)
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

function GoddesscollectorpetsView:_initContentPageInfo()
	local list = self:_getRewardCfgs()

	self._unitPageScore = 500
	self._unitScoreDiviveUnitWidth = self._unitPageScore / self._unitPageWidth
	self._sliderWidth = 150 * #list
	self._contentWidth = 150 * #list + 75

	goutil.setWidth(self._contentRectTrans, self._contentWidth)
	goutil.setWidth(self._progressBarRect, self._sliderWidth)
end

function GoddesscollectorpetsView:_updateScrollRectPos()
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

function GoddesscollectorpetsView:_initSliderAnimInfo()
	local isPlayed = GameUtil.getUserData(GoddesscollectorpetsView.SliderAnim .. self._viewType)

	self._isPlaySliderAnim = not isPlayed

	goutil.setActive(self._sliderMask, not isPlayed)
end

function GoddesscollectorpetsView:_playSliderAnimation()
	local isPlayed = true
	local startPos = 0
	local endPos = 1
	local duration = 2
	local delay = 1

	GameUtil.saveUserData(GoddesscollectorpetsView.SliderAnim .. self._viewType, isPlayed)

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

function GoddesscollectorpetsView:_removeTween()
	if self._sequence then
		self._sequence:Kill(false)
	end
end

function GoddesscollectorpetsView:_getPrizeType()
	return GameEnum.GoddessCollector_PrizeType.PET_PRIZE
end

return GoddesscollectorpetsView
