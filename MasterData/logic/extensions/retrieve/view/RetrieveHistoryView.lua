-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveHistoryView.lua

module("logic.extensions.retrieve.view.RetrieveHistoryView", package.seeall)

local M = class("RetrieveHistoryView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnBg = self:getBtn("0&middle_tips_common_bg_-1572128605")
	self._dropDown = self:getGo("retrieve_log_tips_1134117199"):GetComponent(UIComponentType.SpaceXDropDown)
	self._rectDropArrow = self:getUIComponent("retrieve_log_tips_40168993", UIComponentType.RectTransform)
	self._logScrollGo = self:getGo("retrieve_log_tips_2043695857")
	self._scrollLayerComp = self._logScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._dropDownText = self:getText("retrieve_log_tips_310077944")
end

function M:_initDropDown()
	self._isInit = true

	local dropDown = self._dropDown
	local lotteryLogDataList = RetrieveLogModel.instance:getLotteryLogData()

	self._lotteryList = {}

	for poolCode, lotteryLogData in pairs(lotteryLogDataList) do
		local co = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryPool, poolCode)
		local sortOrder = co.sortOrder

		table.insert(self._lotteryList, {
			poolCode = poolCode,
			sortOrder = sortOrder,
			name = co.name
		})
	end

	table.sort(self._lotteryList, function(lotteryA, lotteryB)
		local sortOrderA = lotteryA.sortOrder
		local sortOrderB = lotteryB.sortOrder
		local idA = lotteryA.poolCode
		local idB = lotteryB.poolCode

		if sortOrderA < sortOrderB then
			return true
		elseif sortOrderB < sortOrderA then
			return false
		end

		if idA < idB then
			return true
		end

		return false
	end)

	local nameLst = {}

	for i = 1, #self._lotteryList do
		table.insert(nameLst, self._lotteryList[i].name)
	end

	dropDown:UpdateDropDownList(nameLst)

	dropDown.value = 0

	local len = TableUtil.getLen(self._lotteryList)

	if len >= 1 then
		self._poolCode = self._lotteryList[1].poolCode
	end

	if self._poolCode then
		local co = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryPool, self._poolCode)

		self._dropDownText.text = co.name
	end
end

function M:destroyUI()
	self._btnClose = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	self._dropDown:AddOnValueChange(self._dealDropDown, self)
	self._dropDown:AddOnDropDownListShow(self._onDropDownShow, self)
	RetrieveDispatcher:addEventListener(RetrieveEventType.LOTTERY_LOG_FILTER, self._refreshScrollView, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._dropDown:RemoveAllListener()
	RetrieveDispatcher:removeEventListener(RetrieveEventType.LOTTERY_LOG_FILTER, self._refreshScrollView, self)
end

function M:onEnter()
	RetrieveAgent.instance:sendGetLotteryLogRequest()

	if self._listBinderView then
		self._listBinderView:onEnter()
	end
end

function M:onExit()
	if self._listBinderView then
		self._listBinderView:onExit()
	end
end

function M:_onClickClose()
	self:close()
end

function M:_dealDropDown(index)
	self._scrollLayerComp.verticalNormalizedPosition = 1

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click)

	self._poolCode = self._lotteryList[index + 1].poolCode

	RetrieveDispatcher:dispatchEvent(RetrieveEventType.LOTTERY_LOG_FILTER)
end

function M:_onDropDownShow(show)
	if show then
		local lstRoot = self._dropDown:GetDropDownListObj()
		local value = self._dropDown.value

		if lstRoot then
			local content = goutil.findChildComponent(lstRoot, "Viewport/Content", UIComponentType.RectTransform)

			for i = 1, content.childCount - 1 do
				local go = content:GetChild(i).gameObject

				if i == 1 then
					goutil.setActive(goutil.findChild(go, "Item Background (1)").gameObject, false)
				end
			end
		end
	end

	self:_setDropRectUp(show)
end

function M:_setDropRectUp(up)
	local y = up and 1 or -1

	RectTransformUtils.SetScale(self._rectDropArrow, 1, y, 1)
end

function M:_refreshScrollView()
	if not self._isInit then
		self:_initDropDown()
	end

	local logDataList = RetrieveLogModel.instance:filterLogData(self._poolCode)

	if self._listBinderView then
		self._listBinderView:refreshVisible()

		return
	end

	self._listBinderView = ListBinderView.New(logDataList, self._logScrollGo, self:getResInstance(ResName.RetrieveLogItem), RetrieveLogItemView)

	self._listBinderView:buildUI()
	self._listBinderView:setViewPresentor(self._viewPresentor)
	self._listBinderView:onEnter()
end

return M
