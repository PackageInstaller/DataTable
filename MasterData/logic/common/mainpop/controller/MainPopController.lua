-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mainpop/controller/MainPopController.lua

module("logic.common.mainpop.controller.MainPopController", package.seeall)

local M = class("MainPopController", BaseController)

local function kSort_PopItem(popItemA, popItemB)
	return popItemA:getMainPopType() < popItemB:getMainPopType()
end

function M:onInit()
	self:onReset()

	self._popItemList = {}

	self:_registerMainPopItem(LoginPopUpsController.instance)
	self:_registerMainPopItem(BattleReconnectController.instance)
	self:_registerMainPopItem(SystemOpenController.instance)
	table.sort(self._popItemList, kSort_PopItem)
	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKDAY, self._timeUpdate, self)
	GlobalDispatcher:addEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
	GlobalDispatcher:addEventListener(EventType.ON_EXIT_MAIN_SCENE, self._handleExitMainScene, self)
end

function M:onReset()
	self._isPopShowing = false
	self._popItemIndex = -1
	self._isCrossDays = false
end

function M:_registerMainPopItem(popItemInstance)
	table.insert(self._popItemList, popItemInstance)
end

function M:_handleShowMainViewFinish(e, isEnter)
	if isEnter and not GuideController.instance:isGuiding() then
		self:showNextByGuide(true)
	end
end

function M:_handleExitMainScene(e)
	self:aboardPopShowing()
end

function M:_onTriggerPop()
	if self._isCrossDays then
		self._isCrossDays = false
	end

	self:show()
end

function M:_timeUpdate()
	self._isCrossDays = true
end

function M:getIsPopShowing()
	return self._isPopShowing
end

function M:_setPopShowing(showing, alwaysDispatch)
	local showingFinish = self._isPopShowing == true and showing == false

	self._isPopShowing = showing
	self._popItemIndex = showing and 1 or -1

	if showingFinish or alwaysDispatch then
		GlobalDispatcher:dispatchEvent(EventType.ON_MAIN_POP_UP_FINISH)
	end
end

function M:aboardPopShowing()
	self._isPopShowing = false
	self._popItemIndex = -1
end

function M:show()
	local popItem = self._popItemList[self._popItemIndex]

	popItem:onTriggerMainPop()

	if enableLog then
		printInfo("MainPopController::current triggerred MainPopItem is", popItem:getMainPopType())
	end
end

function M:showNext()
	if not self:increaseToNext() then
		return
	end

	if self:isPopFinished() then
		self:_setPopShowing(false)

		return
	end

	self:show()
end

function M:showNextByGuide(alwaysDispatch)
	if not ViewMgr.instance:isOpen(ViewName.MainUIView) then
		return
	end

	if self:getIsPopShowing() then
		if enableLog then
			local popItem = self._popItemList[self._popItemIndex]
			local popType = popItem and popItem:getMainPopType() or false

			printWarn(string.format("isShowing,index:%s popType:%s", self._popItemIndex, popType), debug.traceback())
		end

		return
	end

	if not self:hasPopUpData() then
		self:_setPopShowing(false, alwaysDispatch)

		return
	end

	self:_setPopShowing(true)
	self:_onTriggerPop()
end

function M:increaseToNext()
	if self._popItemIndex == nil or self._popItemIndex < 0 then
		return false
	end

	self._popItemIndex = self._popItemIndex + 1

	return true
end

function M:isPopFinished()
	return self._popItemIndex and self._popItemIndex > #self._popItemList
end

function M:hasPopUpData()
	local hasPopUpData = false

	for _, _instance in pairs(self._popItemList or {}) do
		if not hasPopUpData and _instance:hasPopUpData() then
			hasPopUpData = true
		end
	end

	return hasPopUpData
end

M.instance = M.New()

return M
