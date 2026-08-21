-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomReportDetailNormalCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomReportDetailNormalCell", package.seeall)

local M = class("HoldingRoomReportDetailNormalCell", UIReusableLuaBehavior)

function M:buildUI()
	self._canvasGroup = goutil.findChildComponent(self.mainGO, "", ComponentType.CanvasGroup)
	self._rectTrans = goutil.findChildComponent(self.mainGO, "", UIComponentType.RectTransform)
	self._txtDate = goutil.findChildTextComponent(self.mainGO, "txtDate")
	self._goNoneHeroItem = goutil.findChild(self.mainGO, "top/headDi/none").gameObject
	self._goHeroItem = goutil.findChild(self.mainGO, "top/headDi/cell/hero_item").gameObject
	self._txtName = goutil.findChildTextComponent(self.mainGO, "top/txtName")
	self._goTouchWayRoot = goutil.findChild(self.mainGO, "top/prototype").gameObject
	self._goTouchWayItem = goutil.findChild(self.mainGO, "top/prototype/prototype_item").gameObject
	self._txtReportDesc = goutil.findChildTextComponent(self.mainGO, "top/descScroll/view/txtDesc")
	self._imgReportResult = goutil.findChildImageComponent(self.mainGO, "middle/imgHoldingResult")
	self._txtResearchPoint = goutil.findChildTextComponent(self.mainGO, "middle/num/txtValue")
	self._goPresureRoot = goutil.findChild(self.mainGO, "middle/pressure")
	self._goPresureItem = goutil.findChild(self.mainGO, "middle/pressure/pressure_item")
	self._goScrollReward = goutil.findChild(self.mainGO, "bottom/rewardScroll")
	self._goRewardItem = goutil.findChild(self.mainGO, "bottom/rewardScroll/view/content/backpack_item")
	self._loopListHelper = LoopListHelper.New(self._goScrollReward)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._canvasGroup = nil
	self._rectTrans = nil
	self._txtDate = nil
	self._goNoneHeroItem = nil
	self._goHeroItem = nil

	if self._heroItem then
		self._heroItem:destroyUI()
	end

	self._heroItem = nil
	self._txtName = nil
	self._goTouchWayRoot = nil
	self._goTouchWayItem = nil
	self._txtReportDesc = nil
	self._imgReportResult = nil
	self._txtResearchPoint = nil
	self._goPresureRoot = nil
	self._goPresureItem = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
	self._goScrollReward = nil
	self._goRewardItem = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	if self._heroItem then
		self._heroItem:unbindEvents()
	end
end

function M:onEnter()
	self._cellItem = {}
end

function M:onExit()
	self._rectTrans:DOKill()
	self._canvasGroup:DOKill()

	self._handler = nil

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._cellItem = nil

	self._loopListHelper:ClearCells()

	if self._heroItem then
		self._heroItem:onExit()
	end
end

function M:onClickHeroItem()
	return
end

function M:setPoolIndex(val)
	self._poolIndex = val
end

function M:getPoolIndex()
	return self._poolIndex
end

function M:getTyp()
	return self._typ
end

function M:getIndex()
	return self._index
end

function M:setHandler(val)
	self._handler = val
end

function M:setCellData(itemData, index, typ)
	self._index = index
	self._typ = typ

	local uuid = itemData:getUuid()
	local heroId = itemData:getHeroId()
	local protomerMo = ProtomerModel.instance:getProtomerInfo(itemData:getProtomerId())

	self._txtDate.text = itemData:getReportId()

	if heroId > 0 then
		self._txtName.text = ContainmentUtil.getHeroName(heroId)

		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		self._heroItem = Astral.LuaComponentContainer.Add(self._goHeroItem, HeroHeadItem)

		self._heroItem:setHandler(self)
		self._heroItem:showName(false)
		self._heroItem:setHeroMO(heroMO)
	else
		self._txtName.text = "NONE"
	end

	goutil.setActive(self._goHeroItem, heroId > 0)
	goutil.setActive(self._goNoneHeroItem, heroId <= 0)
	self:_updateTouchWay(itemData:getProtomerId(), itemData:getTouchWay())

	self._txtReportDesc.text = ContainmentConfig.instance:getReportDescById(itemData:getDescId())

	local resultImgCode = itemData:getScore()

	IconLoader.setSprite(self._imgReportResult, IconType.DynSpriteAtlas_Language, string.format("room_holding_result_%d", resultImgCode))

	self._txtResearchPoint.text = string.format("%d", itemData:getPoint())

	self:setPresureShow(itemData:getPresure(), protomerMo:getPressureLimitEnhance())
	self:_updateRewadShow(itemData:getRewards())
end

function M:setPresureShow(val, maxVal)
	local rootTrans = self._goPresureRoot.transform

	while maxVal > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goPresureItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < maxVal
		local active = i < val
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local activeGo = tempGo.transform:GetChild(0).gameObject

			goutil.setActive(activeGo, active)
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_updateRewadShow(rewardTable)
	self._rewards = {}

	for i, v in ipairs(rewardTable or {}) do
		if v.itemCount > 0 then
			local itemData = ItemUtil.createItemData({
				itemId = v.itemCode
			})

			itemData:setCount(v.itemCount)
			table.insert(self._rewards, itemData)
		end
	end

	table.sort(self._rewards, ItemUtil.sortItemsCompare)
	self._loopListHelper:SetListItemCount(#self._rewards, true)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_updateTouchWay(protomerId, touchWay)
	local name = ContainmentUtil.getTouchDefineName(touchWay, protomerId)
	local touchName = goutil.findChildTextComponent(self._goTouchWayItem, "Text1 (1)")

	touchName.text = name
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local itemData = self._rewards[curIndex]
	local item = self._loopListHelper:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)
	local itemCount = itemData:getCount()

	shower:setCellData(itemData, curIndex)
	shower:setNumShow(true, MathUtil.getCoinValue(itemCount))
	shower:setHandler(self)
	shower:setSignShow(CommEnum.BackPackItemSignTyp.None)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:_recycle()
	if self._handler then
		self._handler:reportCellReturn(self)
	end
end

function M:turnDown()
	return
end

function M:turnUp()
	return
end

function M:turnUpToBack()
	return
end

function M:SetAsFirstSibling()
	self._rectTrans:SetAsFirstSibling()
end

function M:SetAsLastSibling()
	self._rectTrans:SetAsLastSibling()
end

function M:setShow(show)
	goutil.setActive(self.mainGO, show)
end

function M:setAcnchorPos(x, y)
	self._rectTrans:DOKill()
	RectTransformUtils.SetAnchoredPosition(self._rectTrans, x, y)
end

function M:doAnchorPos(x, y, duration, callBack)
	self._moveCallback = callBack

	local endPos = Vector3.New(x, y, 0)

	self._rectTrans:DOKill()
	self._rectTrans:DOAnchorPos(endPos, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._tweenFinishCB, self)
end

function M:_tweenFinishCB()
	if self._moveCallback ~= nil then
		self._moveCallback()
	end

	self._moveCallback = nil
end

function M:setRotate(x, y, z)
	TransformUtils.SetEulerAngles(self._rectTrans, x, y, z)
end

function M:doRotateX(x, y, z, duration)
	local endVal = Vector3.New(x, y, z)

	self._rectTrans:DORotate(endVal, duration, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

function M:setCanvasGroupAlpha(val)
	self._canvasGroup.alpha = val
end

function M:doCanvasGroupAlpha(endVal, duration)
	self._canvasGroup:DOFade(endVal, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

return M
