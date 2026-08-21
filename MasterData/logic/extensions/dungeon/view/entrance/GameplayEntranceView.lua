-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/GameplayEntranceView.lua

module("logic.extensions.dungeon.view.entrance.GameplayEntranceView", package.seeall)

local M = class("GameplayEntranceView", ViewComponent)

M.kViewUrls = {
	ResName.Fight_fight_entry_homepage_panel,
	ResName.Fight_fight_entry_mainline_panel,
	ResName.Fight_fight_entry_regulatory_panel,
	ResName.Fight_fight_entry_resources_panel,
	ResName.Fight_fight_challenge_panel
}
M.kViewClass = {
	GameplayHomeFragmentView,
	GameplayMainlineFragmentView,
	GameplayRegulatoryFragmentView,
	GameplayResourcesFragmentView,
	GameplayChallengeFragmentView
}
M.kSystemOpenEnumList = {}

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:buildUI()
	self._goDynPanelRoot = self:getGo("fight_entry_view_copy_-268489719")

	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(M.kViewUrls) do
		adapter:registerView(M.kViewUrls[index], M.kViewClass[index])
	end

	self._viewPager = ViewPager.New(self._goDynPanelRoot)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self.setPage, self)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("left_tab_content_-399612422"), LeftTabComp)

	self._tabComp:setActiveTabIndexLst({
		1,
		2,
		3,
		4,
		5
	})
	self._tabComp:setSystemOpenLst(M.kSystemOpenEnumList)
	self._tabComp:setRedPointTypeWeakly()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:setTabCheckFunc(M._tabCheckFunc)
	self._toggleTabControl:setSystemOpen(M.kSystemOpenEnumList)
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_1", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_2", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_3", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_4", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_5", UIComponentType.SpaceXToggle))

	self._txtAirtightTime = goutil.findChildTextComponent(self.mainGO, "left_tab_content/rightTabList/tab_3/objTime/txtPart")
	self._goAirtightTime = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_3/objTime")
	self._mainlineDoubleHint = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_2/doubleHint")
	self._penetraliumDoubleHint = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_3/doubleHint")
	self._resourcesDoubleHint = goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_4/doubleHint")
end

function M:destroyUI()
	self._viewPager:clear()
	self._viewPager:destroy()

	self._viewPager = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:onEnter(openReasonType)
	self._isEnter = true

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Fight)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)

	local info = self:getFirstParam()

	self._defaultTabIndex = info and info.tabIndex or self._activeIndex or CommEnum.CharacterSystemTab.Detail
	self._defaultTabData = info and info.data or {}
	self._isNormal = not self._viewPresentor:getIsBackOpen() and openReasonType ~= WindowType.WindowOpenReasonType.QuickOpenType

	self:_setMultipleDrop()
	self:setEvent(true)
	AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()
	settimer(0, self._onEnterNextFrame, self, false)
end

function M:_onEnterNextFrame()
	local isNormal = self._isNormal
	local data = self._defaultTabData

	data.isNormal = isNormal

	local defaultTabIndex = self._defaultTabIndex
	local orgTabIndex

	if not isNormal then
		orgTabIndex = defaultTabIndex
	end

	self._tabComp:onEnter()
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:playGuiAniTab(true, isNormal, defaultTabIndex)
	self._viewPager:setPageChangeCallBack(nil, nil)
	self._viewPager:clear()
	self._toggleTabControl:selectTab(defaultTabIndex, data)
	self._viewPager:setPageChangeCallBack(self.setPage, self)
	self:_updatePageData(orgTabIndex, defaultTabIndex, false, true)

	self._activeIndex = defaultTabIndex
end

function M:onEnterFinished()
	return
end

function M:onExit(closeReasonType)
	self._isEnter = false

	self:setEvent(false)

	local isNormalClose = closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Fight)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	self._tabComp:playGuiAniTab(false, isNormalClose)
	self._viewPager:clear()
end

function M:onExitFinished()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._checkAirtightTime, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._checkAirtightTime, self)
	end
end

function M._tabCheckFunc(index)
	return true
end

function M:setPage(tabIndex)
	local openParam = self:getOpenParam()

	if openParam and openParam[1] then
		openParam[1].tabIndex = tabIndex
	end

	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_updatePageData(orgIndex, tabIndex, true)
	end
end

function M:_updatePageData(orgIndex, tabIndex, isForceRestart, callOnEnter)
	self:_dealLeftTabComp(orgIndex, tabIndex, callOnEnter)
end

function M:_dealLeftTabComp(orgIndex, tabIndex, callOnEnter)
	local samePage = orgIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = orgIndex and math.abs(orgIndex - tabIndex) <= 1 and 0.2 or duration

	self._tabComp:setCanvasGroupShow(false, 1, 0.1)

	if not callOnEnter then
		self._tabComp:MoveSelectMark(tabIndex, duration)
	end
end

function M:_updateClock()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo()

	return inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS
end

function formatNumber(num)
	if num < 10 then
		return string.format("0%s", num)
	end

	return num
end

function M:_checkAirtightTime()
	if not self._isEnter then
		return
	end

	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime, true, true, false)
	local timestr

	if inSpTime then
		timestr = "--:--:--"
	else
		if inTimeByItem then
			local offsetTs = airtightEndTS - nowTime

			hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct(offsetTs)
		end

		timestr = string.format("%s:%s:%s", formatNumber(hour), formatNumber(minute), formatNumber(second))
	end

	self._txtAirtightTime.text = timestr

	goutil.setActive(self._goAirtightTime, AirtightRoomUtil.isSystemOpen())

	if inAirtightTime ~= self._isAirtightTime then
		self._isAirtightTime = inAirtightTime
	end
end

function M:_setMultipleDrop()
	local resourcesIsShow = MultipleDropController.instance:getAnDinIsOpen() or MultipleDropController.instance:equipIsOpen()
	local mainlineIsShow = MultipleDropController.instance:mainLineIsOpen()
	local prisonIsShow = MultipleDropController.instance:prisonIsOpen()

	goutil.setActive(self._penetraliumDoubleHint.gameObject, prisonIsShow)
	goutil.setActive(self._mainlineDoubleHint.gameObject, mainlineIsShow)
	goutil.setActive(self._resourcesDoubleHint.gameObject, resourcesIsShow)
end

return M
