-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIActBannerView.lua

module("logic.extensions.mainui.view.MainUIActBannerView", package.seeall)

local M = class("MainUIActBannerView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

local ScrollType = {
	change = 2,
	atuo = 3,
	original = 1
}

function M:getSystemKey()
	return GameEnum.SystemEnum.Welfare
end

function M:isSystemOpen(showToast)
	local systemKey = self:getSystemKey()

	return SystemOpenFacade.instance:isOpen(systemKey, showToast)
end

function M:buildUI()
	self._activityBannerContent = self:getGo("main_view_-2065262304")
	self._scrollGo = self:getGo("main_view_-52210283")
	self._scroll = self:getUIComponent("main_view_-52210283", UIComponentType.ScrollRect)
	self._content = self:getGo("main_view_1926248809")
	self._contentRectTransform = self:getUIComponent("main_view_1926248809", UIComponentType.RectTransform)
	self._onlyBanner = self:getGo("main_view_-340040317")

	local imageOnlyGo = goutil.findChild(self._onlyBanner.gameObject, "Image")

	self._onlyBannerImage = UIComponentType.ImageBigBG(imageOnlyGo.gameObject)
	self._onlyBannerButton = self:getBtn("main_view_-340040317")
	self._btnJumpAct = self:getBtn("main_view_-896616633")
	self._goRedPointJumpAct = goutil.findChild(self._btnJumpAct.gameObject, "red_point")

	RedDotModel.instance:createDotView({
		dotNode = self._goRedPointJumpAct.gameObject,
		keyList = {
			GameEnum.RedPointEnum.Activity,
			GameEnum.RedPointEnum.ActivityTask
		}
	})

	self._loopDotListGo = self:getGo("main_view_-974241113")
	self._childCount = self._loopDotListGo.gameObject.transform.childCount
	self._dotList = {}

	for i = 0, self._childCount - 1 do
		local tempGo = self._loopDotListGo.gameObject.transform:GetChild(i)
		local imageGo = goutil.findChild(tempGo.gameObject, "dot")
		local temp = {}

		temp._go = tempGo.gameObject
		temp._image = imageGo.gameObject
		self._dotList[i + 1] = temp
	end

	self._btnDrag = Astral.UIDragTrigger.Get(self._scrollGo)

	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	self._threshold = 0.1
	self._speed = 10
	self._bannerSpeed = ConstConfig.instance:getFloatValueByKey("MainUIActBannerSlipSpeed")
	self._bannerStopTime = ConstConfig.instance:getFloatValueByKey("MainUIActBannerStopTime")
	self._prefab = self:getGo("main_view_806083743")

	goutil.setActive(self._prefab.gameObject, false)
end

function M:destroyUI()
	self._scroll = nil
	self._contentRectTransform = nil
	self._bannerList = {}

	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()
end

function M:bindEvents()
	self._btnJumpAct:AddClickListener(self._onClickJumpAct, self)
	self._onlyBannerButton:AddClickListener(self._setButtonOnly, self)
end

function M:unbindEvents()
	self._btnJumpAct:RemoveClickListener()
	self._onlyBannerButton:RemoveClickListener()
end

function M:onEnter(reasonType)
	MainUIActBannerModel.instance:setRealShowList()

	self._realShowList = MainUIActBannerModel.instance:getRealShowList()
	self._length = #self._realShowList
	self._curNumber = self._length

	if self:_handleOnSystemOpen() then
		self:_initScroll()
		self:_initDotList()
		self:_refreshRedDot()
	end

	self:_setEvent(true)
end

function M:onExit(reasonType)
	if self._length > 1 then
		removetimer(self._setAtuoScroll, self)
	end

	self:_setEvent(false)
	self._onlyBannerImage:ClearImage()
	goutil.clearChildren(self._content.gameObject)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.ACTIVITY_ALL_REFRESH, self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
	end
end

function M:_handleOnSystemOpen()
	local showRoot = true
	local isOpen = self:isSystemOpen(false)
	local showOnLock = SystemOpenFacade.instance:isShowOnLock(self:getSystemKey())

	showRoot = isOpen or showOnLock and not isOpen

	local hasAct = true

	if not hasAct then
		showRoot = false
	end

	goutil.setActive(self._activityBannerContent.gameObject, showRoot)

	return showRoot
end

function M:_initScroll()
	goutil.setActive(self._scrollGo.gameObject, false)
	goutil.setActive(self._onlyBanner.gameObject, false)

	if self._length == 0 then
		goutil.setActive(self._onlyBanner.gameObject, true)

		local defaultMo = MainUIActBannerModel.instance:getDefaultMo()
		local image = defaultMo:getImage()

		self._onlyBannerImage:SetImage(GameUrl.getBigBgUrlMainBanner(image))
	elseif self._length == 1 then
		goutil.setActive(self._onlyBanner.gameObject, true)

		local image = self._realShowList[1]:getImage()

		self._onlyBannerImage:SetImage(GameUrl.getBigBgUrlMainBanner(image))
	else
		goutil.setActive(self._scrollGo.gameObject, true)

		self._multiple = self:setLength(self._length)
		self._realBannerLength = self._length * self._multiple
		self._nl = 1 / (self._realBannerLength - 1)

		self:clonePrefab()
		self:setDataList()

		self._canContinue = true

		settimer(self._bannerStopTime, self._setAtuoScroll, self, true)
	end
end

local lengthTable = {
	6,
	5,
	4,
	3
}

function M:setLength(number)
	if lengthTable[number - 1] then
		return lengthTable[number - 1]
	else
		return 2
	end
end

function M:clonePrefab()
	goutil.setActive(self._prefab.gameObject, true)

	for i = 1, self._realBannerLength do
		local tempP = goutil.clone(self._prefab.gameObject)

		goutil.addChildToParent(tempP, self._content.transform)
	end

	self._contentRectTransform.anchoredPosition = Vector2.New(-280 * self._length, 0)

	goutil.setActive(self._prefab.gameObject, false)
end

function M:setDataList()
	local class = MainUIActBannerItemCell

	for i = 0, self._realBannerLength - 1 do
		local childObj = self._content.transform:GetChild(i).gameObject
		local shower = Astral.LuaComponentContainer.Get(childObj, class)

		shower = shower or Astral.LuaComponentContainer.Add(childObj, class)

		local index = i % self._length + 1
		local rewardMo = self._realShowList[index]

		shower:updateData(rewardMo)
	end
end

function M:_initDotList()
	if self._length < 2 then
		goutil.setActive(self._loopDotListGo.gameObject, false)

		return
	end

	goutil.setActive(self._loopDotListGo.gameObject, true)

	for k, v in ipairs(self._dotList) do
		if k < self._length then
			goutil.setActive(v._go, true)
		elseif k == self._childCount then
			goutil.setActive(v._go, true)
		else
			goutil.setActive(v._go, false)
		end
	end

	self:_setWhiteDot(0)
end

function M:_setImage()
	if self._curNumber < 1 or self._curNumber > self._length then
		printError("主页Banner当前页码超范围")

		return
	end
end

function M:_setButtonOnly()
	if self._length == 0 then
		return
	elseif self._length == 1 then
		local tempID = self._realShowList[1]:getJumpId()

		self:_jump(tempID)
	end
end

function M:_jump(jumpId)
	if jumpId <= 0 then
		return
	end

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_setAtuoScroll()
	if self._curNumber == self._realBannerLength - 1 then
		self._curNumber = 0
	else
		self._curNumber = self._curNumber + 1
	end

	if self._coroutine then
		coroutine.stop(self._coroutine)
	end

	self._coroutine = coroutine.start(function()
		self:_lerpRoll(self:_getScrollPosition(self._curNumber), ScrollType.atuo)
	end)
end

function M:_onBeginDrag(eventData)
	removetimer(self._setAtuoScroll, self)

	self._beginPositionX = self._scroll.horizontalNormalizedPosition
	self._canContinue = false
end

function M:_onDrag(eventData)
	return
end

function M:_onEndDrag(eventData)
	self._canContinue = true

	if not self._scroll or self._length < 2 then
		return
	end

	local lastPosition = self:_getScrollPosition(self._curNumber)
	local currentPosition = self._scroll.horizontalNormalizedPosition

	if lastPosition < currentPosition then
		local thre = currentPosition - self._beginPositionX

		if thre > self._nl * self._threshold then
			if self._curNumber == self._realBannerLength - 1 then
				self._curNumber = 0
			else
				self._curNumber = self._curNumber + 1
			end

			if self._coroutine then
				coroutine.stop(self._coroutine)
			end

			self._coroutine = coroutine.start(function()
				self:_lerpRoll(self:_getScrollPosition(self._curNumber), ScrollType.change)
			end)
		else
			if self._coroutine then
				coroutine.stop(self._coroutine)
			end

			self._coroutine = coroutine.start(function()
				self:_lerpRoll(lastPosition, ScrollType.original)
			end)
		end
	else
		local thre = self._beginPositionX - currentPosition

		if thre > self._nl * self._threshold then
			if self._curNumber == 0 then
				self._curNumber = self._realBannerLength - 1
			else
				self._curNumber = self._curNumber - 1
			end

			if self._coroutine then
				coroutine.stop(self._coroutine)
			end

			self._coroutine = coroutine.start(function()
				self:_lerpRoll(self:_getScrollPosition(self._curNumber), ScrollType.change)
			end)
		else
			if self._coroutine then
				coroutine.stop(self._coroutine)
			end

			self._coroutine = coroutine.start(function()
				self:_lerpRoll(lastPosition, ScrollType.original)
			end)
		end
	end
end

function M:_getScrollPosition(number)
	local scrollPosition = Mathf.Clamp(self._nl * number, 0, 1)

	return scrollPosition
end

function M:_setContentAndList()
	self._contentRectTransform.anchoredPosition = Vector2.New(-560, 0)

	self:_setImage()
end

function M:_lerpRoll(position, type)
	while self._canContinue do
		if not self._scroll then
			break
		end

		if Mathf.Abs(self._scroll.horizontalNormalizedPosition - position) <= 0.001 then
			self._scroll.horizontalNormalizedPosition = position

			if type ~= ScrollType.original then
				self:_setWhiteDot(self._curNumber)
			end

			if type ~= ScrollType.atuo then
				settimer(self._bannerStopTime, self._setAtuoScroll, self, true)
			end

			break
		else
			self._scroll.horizontalNormalizedPosition = Mathf.Lerp(self._scroll.horizontalNormalizedPosition, position, Time.deltaTime * self._speed * self._bannerSpeed)
		end

		Yield(0)
	end
end

function M:_setWhiteDot(curNum)
	local curNumber = curNum % self._length + 1

	if curNumber == 1 then
		goutil.setActive(self._dotList[self._childCount]._image, true)

		for i = 1, self._length - 1 do
			goutil.setActive(self._dotList[i]._image, false)
		end
	elseif curNumber == self._length then
		goutil.setActive(self._dotList[1]._image, true)

		if self._length > 2 then
			for i = 2, self._length - 1 do
				goutil.setActive(self._dotList[i]._image, false)
			end
		end

		goutil.setActive(self._dotList[self._childCount]._image, false)
	else
		local num = curNumber - 1
		local count = 0

		for i = self._length - 1, 1, -1 do
			count = count + 1

			if count == num then
				goutil.setActive(self._dotList[i]._image, true)
			else
				goutil.setActive(self._dotList[i]._image, false)
			end
		end

		goutil.setActive(self._dotList[self._childCount]._image, false)
	end
end

function M:_onClickJumpAct()
	if not WelfareUtil.isSystemOpen(true) then
		return
	end

	if not WelfareUtil.canWelfareEntryActive() then
		FloatWordMgr.instance:show(lang("tip_activity_no_have"))

		return
	end

	ViewMgr.instance:open(ViewName.WelfareMainView)
end

function M:_refreshRedDot()
	return
end

return M
