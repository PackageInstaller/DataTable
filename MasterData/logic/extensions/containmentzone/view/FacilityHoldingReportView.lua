-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportView", package.seeall)

local M = class("FacilityHoldingReportView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._cellItem = {}
	self._goMiddle = self:getGo("facility_holding_report_view_840473759")
	self._goRight = self:getGo("facility_holding_report_view_684388180")
	self._goEmpty = self:getGo("facility_holding_report_view_-718082729")
	self._rectTRoomTabRoot = self:getRectTransform("facility_holding_report_view_1680512687")
	self._goRoomTabItem = self:getGo("facility_holding_report_view_1773902924")

	goutil.setActive(self._goRoomTabItem, false)

	self._infoCellCollection = LocalReusableCollection.New(HoldingRoomTabCell, 6)
	self._btnHeroToSchedule = self:getBtn("facility_holding_report_view_1840010751")
	self._imgHeroIcon = self:getImage("facility_holding_report_view_685862853")
	self._goMoodGreen = self:getGo("facility_holding_report_view_457335153")
	self._goMoodYellow = self:getGo("facility_holding_report_view_320564836")
	self._goMoodRed = self:getGo("facility_holding_report_view_1762320736")
	self._cellItem[self._goMoodGreen:GetInstanceID()] = Astral.LuaComponentContainer.Add(self._goMoodGreen, HoldingRoomMoodCell)
	self._cellItem[self._goMoodYellow:GetInstanceID()] = Astral.LuaComponentContainer.Add(self._goMoodYellow, HoldingRoomMoodCell)
	self._cellItem[self._goMoodRed:GetInstanceID()] = Astral.LuaComponentContainer.Add(self._goMoodRed, HoldingRoomMoodCell)
	self._goStatusRoot = self:getGo("facility_holding_report_view_2131130190")
	self._txtYieldBase = self:getText("facility_holding_report_view_1503725697")
	self._goYieldBlue = self:getGo("facility_holding_report_view_112648220")
	self._txtYieldBlue = self:getText("facility_holding_report_view_1824317230")
	self._goYieldRed = self:getGo("facility_holding_report_view_1532334896")
	self._txtYieldRed = self:getText("facility_holding_report_view_323610558")
	self._txtMoodBase = self:getText("facility_holding_report_view_1811843825")
	self._goMoodBlue = self:getGo("facility_holding_report_view_732623093")
	self._txtMoodBlue = self:getText("facility_holding_report_view_293711354")
	self._txtCanRecive = self:getText("facility_holding_report_view_1539209167")
	self._btnDetail = self:getBtn("facility_holding_report_view_1667702180")
	self._btnAcceptAll = self:getBtn("facility_holding_report_view_733496940")
	self._scrollReport = LoopGridViewHelper.New(self:getGo("facility_holding_report_view_2139351423"))

	self._scrollReport:InitGridView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._guiAnimation = nil
	self._goMiddle = nil
	self._goRight = nil
	self._goEmpty = nil
	self._rectTRoomTabRoot = nil
	self._goRoomTabItem = nil

	self._scrollReport:Dispose()

	self._scrollReport = nil
	self._infoCellCollection = nil
	self._btnHeroToSchedule = nil
	self._imgHeroIcon = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
	self._goMoodGreen = nil
	self._goMoodYellow = nil
	self._goMoodRed = nil
	self._goStatusRoot = nil
	self._txtYieldBase = nil
	self._goYieldBlue = nil
	self._txtYieldBlue = nil
	self._goYieldRed = nil
	self._txtYieldRed = nil
	self._txtMoodBase = nil
	self._goMoodBlue = nil
	self._txtMoodBlue = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._txtCanRecive = nil
	self._btnDetail = nil
	self._btnAcceptAll = nil
end

function M:bindEvents()
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._btnAcceptAll:AddClickListener(self._onClickAcceptAll, self)
	self._btnHeroToSchedule:AddClickListener(self._onClickHeroToSchedule, self)
end

function M:unbindEvents()
	self._btnDetail:RemoveClickListener()
	self._btnAcceptAll:RemoveClickListener()
	self._btnHeroToSchedule:RemoveClickListener()

	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	self._reportLst = {}

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	self:_setEventListener(true)

	self._maxReportCount = ContainmentConfig.instance:getConstByKey("MaxReportCount")

	local info = self:getFirstParam()
	local firstTab = 1

	if info.roomId then
		firstTab = info.roomId > 1100 and info.roomId - 1100 or info.roomId
	end

	self:_duelWithRoomTab()
	self:_duelReportLst()
	self:_updateRoomTabRedPointShow()

	self._needPlayQieHuanAni = false

	self._toggleTabControl:selectTab(firstTab)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	self:_setEventListener(false)

	self._activeIndex = nil

	self._infoCellCollection:clearAllInstance()

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._scrollReport:ClearCells()

	self._maxReportCount = nil
end

function M:_setEventListener(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HERO_MOOD_UPDATE, self._handleHeroMoodUpdate, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_REPORT_CHANGE, self._handleHouseHoldRoomReportChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_MOOD_UPDATE, self._handleHeroMoodUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_INFO_CHANGE, self._handleHouseHoldRoomInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_REPORT_CHANGE, self._handleHouseHoldRoomReportChange, self)
	end
end

function M:_onClickDetail()
	local roomId = self:getCurRoomId()
	local reprotLst = self._reportLst[roomId]
	local len = 0

	for key, value in pairs(self._reportLst[roomId] or {}) do
		if not value:getIsRunning() and value:getRecive() then
			len = len + 1
		end
	end

	if len > 0 then
		ContainmentFacade.instance:openReprotDetailView(roomId, reprotLst)
	else
		print(string.format("收容室[%d]没有已领取的报告，不需要弹出详情", roomId))
	end
end

function M:_onClickAcceptAll()
	local roomId = self:getCurRoomId()
	local totalReportCount = ContainmentReportModel.instance:getCanReceiveReportCount(roomId)

	if totalReportCount > 0 then
		ContainmentFacade.instance:openReportSettlementView(roomId)
	else
		print(string.format("收容室[%d]没有可领取的报告，不需要发送协议", roomId))
	end
end

function M:_onClickHeroToSchedule()
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(self:getCurRoomId())

	ViewMgr.instance:open(ViewName.JobDetail, {
		clickIndex = 1,
		roomIndex = jobConfigList[1].houseIndex
	})
end

function M:_handleHouseHoldRoomInfoChange()
	self:_updateRoomTabShow()
end

function M:_handleHouseHoldRoomReportChange()
	self:_duelReportLst()
	self:_refreshScrollViewShow()
	self:_updateRoomStatusShow()
	self:_updateRoomTabRedPointShow()
end

function M:_handleHeroMoodUpdate()
	self:_updateRoomStatusShow()
end

function M:_duelWithRoomTab()
	self._activeIndex = -1
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(_tabCheckFunc)

	if self._infoCellCollection then
		self._infoCellCollection:clearAllInstance()
	end

	for i = 1, ContainmentEnum.maxRoomCount do
		local roomId = i + 1100
		local shower = self._infoCellCollection:createInstance(self._goRoomTabItem)

		goutil.addChildToParent(shower.mainGO, self._rectTRoomTabRoot)

		shower.view = self

		shower:setRoomId(roomId)
		shower:setName(string.format(lang("tip_house_holdroom_idname"), i))
		goutil.setActive(shower.mainGO, true)
		self._toggleTabControl:addToggleTab(goutil.addComponentOnce(shower.mainGO, UIComponentType.SpaceXToggle))
	end

	self:_updateRoomTabShow()
end

function M:_updateRoomTabShow()
	for i = 1, ContainmentEnum.maxRoomCount do
		local roomId = i + 1100
		local _lock = not ContainmentModel.instance:getRoomInfoExist(roomId)
		local tempGo = self._rectTRoomTabRoot:GetChild(i).gameObject
		local shower = Astral.LuaComponentContainer.Add(tempGo, HoldingRoomTabCell)

		shower:setLockMarkShow(_lock)
	end
end

function M:setPage(tabIndex)
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_refreshScrollViewShow()
		self:_updateRoomStatusShow()

		if self._needPlayQieHuanAni then
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:PlayAniByName("qihuan")
		else
			self._needPlayQieHuanAni = true
		end
	end
end

function M:getCurRoomId()
	return self._activeIndex + 1100
end

function _tabCheckFunc(tabIndex)
	return ContainmentUtil.roomTabSelectCheckFunc(tabIndex)
end

function M:_updateRoomTabRedPointShow()
	for i = 1, ContainmentEnum.maxRoomCount do
		local roomId = i + 1100
		local reportInRoom = ContainmentModel.instance:getRoomReportCount(roomId)
		local tab = self._toggleTabControl:getTab(i)
		local shower = Astral.LuaComponentContainer.Get(tab.gameObject, HoldingRoomTabCell)

		shower:setRedPoint(reportInRoom)
	end
end

function M:_duelReportLst()
	self._reportLst = {}

	for i = 1, ContainmentEnum.maxRoomCount do
		local roomId = i + 1100

		if ContainmentModel.instance:getRoomInfoExist(roomId) then
			if not self._reportLst[roomId] then
				self._reportLst[roomId] = {}
			end

			local reportLstFromServer = ContainmentReportModel.instance:getReportLst(roomId)

			reportLstFromServer = ContainmentUtil.sortHoldRoomReport(reportLstFromServer)

			for _, value in pairs(reportLstFromServer) do
				table.insert(self._reportLst[roomId], value)
			end

			self:_tryAddCurrentReport(roomId)
		end
	end
end

function M:_tryAddCurrentReport(roomId)
	local reportRunning = ContainmentModel.instance:getRunningReport(roomId)

	if reportRunning:getIsVaild() then
		table.insert(self._reportLst[roomId], 1, reportRunning)
	end
end

function M:_refreshScrollViewShow()
	local roomId = self:getCurRoomId()
	local len = 0

	if self._reportLst[roomId] then
		len = self._reportLst[roomId] and #self._reportLst[roomId] or 0
	end

	goutil.setActive(self._goScrollView, len > 0)

	if len > 0 then
		self._scrollReport:SetListItemCount(len, true)
		self._scrollReport:RefreshAllShownItem()
	else
		self._scrollReport:ClearCells()
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local roomId = self:getCurRoomId()

	if not self._reportLst[roomId] then
		return
	end

	local itemData = self._reportLst[roomId][curIndex]
	local itemClass = HoldingRoomReportViewCell
	local itemPrefabName = "holding_report_item"
	local item = self._scrollReport:NewListViewItem(itemPrefabName)
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, itemClass)

	shower.view = self

	shower:setCellData(itemData, curIndex)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:_updateRoomStatusShow()
	local roomId = self:getCurRoomId()
	local roomMo = ContainmentModel.instance:getRoomInfoById(roomId)
	local showHeroRoot = false
	local reportInRoom = 0
	local heroId = 0
	local protomerId = 0

	if roomMo then
		reportInRoom = roomMo:getTotalReportCount()
		protomerId = roomMo:getProtomerId()
		heroId = roomMo:getHeroId()

		if heroId > 0 then
			showHeroRoot = true

			local iconName = ContainmentUtil.getHeroHeadIconSrc(heroId)

			IconLoader.setSprite(self._imgHeroIcon, IconType.HeadIcon, iconName)
		else
			showHeroRoot = false
		end

		if protomerId > 0 then
			local second_base = ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, true)

			self:_setYieldBase(second_base)

			local second_withHero = ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, false)
			local blueVal = math.floor((second_base - second_withHero) / second_base * 100)

			blueVal = blueVal * -1

			self:_setYieldBlue(blueVal ~= 0, string.format("%d%%", blueVal))

			local RedVal = 0

			self:_setYieldRed(RedVal ~= 0, string.format("-%d", RedVal))
		else
			self:_setYieldBase(0)
			self:_setYieldBlue(false)
			self:_setYieldRed(false)
		end

		self:_setMoodBase(ContainmentUtil.getRoomHeroMoodBaseCost())

		local MoodBlueVal = heroId > 0 and ContainmentUtil.getRoomHeroMoodSkillMinus(heroId) or 0

		MoodBlueVal = MoodBlueVal * -1

		self:_setMoodBlue(MoodBlueVal ~= 0, string.format("%d%%", MoodBlueVal))
		goutil.setActive(self._goStatusRoot, true)
	else
		goutil.setActive(self._goStatusRoot, false)
	end

	goutil.setActive(self._imgHeroIcon.gameObject, showHeroRoot)
	goutil.setActive(self._goMiddle, protomerId > 0)
	goutil.setActive(self._goRight, protomerId > 0)
	goutil.setActive(self._goEmpty, protomerId <= 0)
	self:_updateHeroMood(heroId)

	self._txtCanRecive.text = string.format("%d/%d", reportInRoom, self._maxReportCount)
end

function M:_updateHeroMood(heroId)
	if heroId > 0 then
		local moodValue = ContainmentUtil.getHeroRoomMood(heroId)
		local moodTyp = HouseWorkerModel.instance:getMoodInterval(moodValue)
		local fillAmount = moodValue / HouseConfig.instance:getHouseConst("MoodMax").numValue
		local shower

		if moodTyp == 1 then
			goutil.setActive(self._goMoodGreen, true)
			goutil.setActive(self._goMoodYellow, false)
			goutil.setActive(self._goMoodRed, false)

			shower = self._cellItem[self._goMoodGreen:GetInstanceID()]
		elseif moodTyp == 2 then
			goutil.setActive(self._goMoodGreen, false)
			goutil.setActive(self._goMoodYellow, true)
			goutil.setActive(self._goMoodRed, false)

			shower = self._cellItem[self._goMoodYellow:GetInstanceID()]
		else
			goutil.setActive(self._goMoodGreen, false)
			goutil.setActive(self._goMoodYellow, false)
			goutil.setActive(self._goMoodRed, true)

			shower = self._cellItem[self._goMoodRed:GetInstanceID()]
		end

		shower:setImgFill(fillAmount)
	else
		goutil.setActive(self._goMoodGreen, false)
		goutil.setActive(self._goMoodYellow, false)
		goutil.setActive(self._goMoodRed, false)
	end
end

function M:_setYieldBase(sencond)
	local hour = sencond / 60 / 60

	self._txtYieldBase.text = string.format("%0.2f小时", hour)
end

function M:_setYieldBlue(show, content)
	if show then
		self._txtYieldBlue.text = content
	end

	goutil.setActive(self._goYieldBlue, show)
end

function M:_setYieldRed(show, content)
	if show then
		self._txtYieldRed.text = content
	end

	goutil.setActive(self._goYieldRed, show)
end

function M:_setMoodBase(content)
	self._txtMoodBase.text = string.format("%d", content)
end

function M:_setMoodBlue(show, num)
	if num == 0 then
		show = false
	end

	if show then
		self._txtMoodBlue.text = num
	end

	goutil.setActive(self._goMoodBlue, show)
end

return M
