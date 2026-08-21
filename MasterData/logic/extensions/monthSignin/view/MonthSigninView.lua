-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/view/MonthSigninView.lua

module("logic.extensions.monthSignin.view.MonthSigninView", package.seeall)

local M = class("MonthSigninView", ViewComponent)

function M:buildUI()
	local info = self:getFirstParam()

	if info then
		self._isPop = info.isPop
	end

	self._maskGo = self:getGo("month_signin_tips_275414973")
	self._btnReturn = self:getBtn("4&btn_close_-260507684")
	self._loopList = LoopGridViewHelper.New(self:getGo("month_signin_tips_-283493606"))

	self._loopList:InitGridView(0, self._onCellUpdate, self)

	self._btnDetail = self:getBtn("month_signin_tips_136650860")
	self._dateTxt = self:getText("month_signin_tips_-1386292814")
	self._numberTxt = self:getText("month_signin_tips_-1900007143")
	self._iconImage = self:getImage("month_signin_tips_1848806279")
	self._nameTxt = self:getText("month_signin_tips_-471931022")
	self._blurView = self._viewPresentor:getBlurView()

	local anitemp = self:getGo("month_signin_tips_-398534680")

	self._canvasGroup = anitemp:GetComponent(ComponentType.CanvasGroup)
	self._aniSign = anitemp.gameObject:GetComponent(ComponentType.Animation)
	self._animEventListener = Astral.AnimationEventListener.Get(anitemp)
end

function M:destroyUI()
	self._btnReturn = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnDetail:AddClickListener(self._onClickExplain, self)
	self._animEventListener:AddListener(self._onAnimEvent, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._animEventListener:RemoveListener()
end

function M:onEnter()
	self._canvasGroup.interactable = true

	self:setEvent(true)
	self:_handerSignInfo()
	self:setView()

	local isBackOpen = self._viewPresentor:getIsBackOpen()

	self._blurView:setNoBlurOnEnter(isBackOpen)

	local isFinish = MonthSigninController.instance:getTodayIsFinish()

	if not isFinish then
		self._aniSign:Play()

		local curData = MonthSigninController.instance:getTodayRewardInfo()
		local item = self._itemCellList[curData:getID()]

		if item then
			item:animationPlay()
		end
	end
end

function M:_onAnimEvent(animEvent)
	if animEvent then
		local curIndex = animEvent.intParameter

		if curIndex == 1 then
			local isFinish = MonthSigninController.instance:getTodayIsFinish()

			if not isFinish then
				self:_signSuccess()
			end
		end
	end
end

function M:onExit()
	self._canvasGroup.interactable = false
	self._itemCellList = {}

	self:setEvent(false)

	if self._isPop then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_VIEW_EXIT)

		self._isPop = false
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MONTHSING_REFRESH_VIEW, self._handerSignInfo, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MONTHSING_REFRESH_VIEW, self._handerSignInfo, self)
	end
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		7116
	})
end

function M:_signSuccess()
	goutil.setActive(self._maskGo.gameObject, true)
	MonthSignInAgent.instance:sendSignInRequest()
end

function M:setView()
	local curData = MonthSigninController.instance:getTodayRewardInfo()

	if curData then
		self._nameTxt = self:getText("month_signin_tips_-471931022")
		self._dateTxt.text = MonthSigninController.instance:getCurrentMonth()
		self._numberTxt.text = curData:getRewardCount()

		local itemType = curData:getItemType()

		IconLoader.setSpriteByItemType(self._iconImage, itemType, curData:getRewardIcon())

		self._nameTxt.text = curData:getRewardName()
	end
end

function M:_handerSignInfo()
	goutil.setActive(self._maskGo.gameObject, false)
	self:_refreshAllDollLoopList()
end

function M:_refreshAllDollLoopList()
	self._loopList:ClearCells()

	self._cellList = MonthSigninController.instance:getList()

	local count = self._cellList and #self._cellList or 0

	self._itemCellList = {}

	self._loopList:SetListItemCount(count, false)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local class = MonthSignItemCell
	local item = self._loopList:NewListViewItem("signin_item")
	local rewardMo = self._cellList[curIndex]
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(rewardMo)

	self._itemCellList[curIndex] = shower

	return item
end

return M
