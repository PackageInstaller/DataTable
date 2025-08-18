-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMainDlg.lua

local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ResActivityMainConfig = require("ClientData/ResActivityMainConfig")
local ResActivityMainTabConfig = require("ClientData/ResActivityMainTabConfig")
local ResActivityMainTabPageConfig = require("ClientData/ResActivityMainTabPageConfig")
local Analytics = require("SDK/Analytics")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local SDKCore = require("SDK/SDKCore")
local ActivityMainBannerTabBtn = Class("ActivityMainBannerTabBtn", UIControls.Child)

function ActivityMainBannerTabBtn:ctor()
	self.panelNml = UIControls.Panel(self, "TabActivity")
	self.imgNmlIcon = UIControls.Image(self, "TabActivity/Icon")
	self.textTabName = UIControls.Label(self, "TabActivity/Text")
	self.tabIconNew = UIControls.RedDot(self, "TabActivity/IconNew")
	self.tabNewOpen = UIControls.Panel(self, "TabActivity/IconNewOpen")
	self.btnSensor = UIControls.Button(self, "TabActivity")

	self.btnSensor:addEventClick(self.onTabBtnClick)

	self.panelSel = UIControls.Panel(self, "TabActivitySel")
	self.imgSelIcon = UIControls.Image(self, "TabActivitySel/Icon")
	self.seltextTabName = UIControls.Label(self, "TabActivitySel/Text")
	self.seltabIconNew = UIControls.RedDot(self, "TabActivitySel/IconNew")
	self.seltabNewOpen = UIControls.Panel(self, "TabActivitySel/IconNewOpen")
	self.selbtnSensor = UIControls.Button(self, "TabActivitySel")

	self.selbtnSensor:addEventClick(self.onTabBtnClick)
end

function ActivityMainBannerTabBtn:setData(tabData, allSubData)
	self.tabData = tabData
	self.tabId = tabData.page_id
	self.allSubData = allSubData

	self.textTabName:setText(tabData.page_name or "")
	self.seltextTabName:setText(tabData.page_name or "")

	if tabData.icon then
		self.imgNmlIcon:setImage(tabData.icon_path, tabData.icon)
		self.imgSelIcon:setImage(tabData.icon_path, tabData.icon)
	end
end

function ActivityMainBannerTabBtn:refreshTabBtnNew()
	local newOpen, rdIds = self.mParent:checkTabHasNew(self.tabId)

	self.tabIconNew:clearHint()
	self.tabIconNew:setVisible(false)
	self.seltabIconNew:clearHint()
	self.seltabIconNew:setVisible(false)

	if self.tabData.no_new == 1 then
		self.tabNewOpen:setVisible(false)
		self.seltabNewOpen:setVisible(false)
	elseif newOpen then
		self.tabNewOpen:setVisible(true)
		self.seltabNewOpen:setVisible(true)
	else
		self.tabNewOpen:setVisible(false)
		self.seltabNewOpen:setVisible(false)

		if #rdIds > 0 then
			self.tabIconNew:addHint(rdIds)
			self.seltabIconNew:addHint(rdIds)
		end
	end
end

function ActivityMainBannerTabBtn:setSelected(isSelected)
	if isSelected then
		self.panelNml:setVisible(false)
		self.panelSel:setVisible(true)
	else
		self.panelNml:setVisible(true)
		self.panelSel:setVisible(false)
	end
end

function ActivityMainBannerTabBtn:onTabBtnClick()
	self.mParent:onTabBtnClick(self.tabId)
end

local SHOW_TAB_ALL = 0
local SHOW_TAB_TIME_LIMIT = 101
local SHOW_TAB_RECOMMEND = 102
local strClassName = "ActivityMainDlg"
local ActivityMainDlg = Class(strClassName, UIControls.Window)
local MGR_DATA_REFRESH_TYPE = {
	[Const.ACT_TYPE_BUYGIFT_DRAW] = true
}

function ActivityMainDlg:ctor()
	self:initUI()

	self.pageData = {}

	self:initFakeActData()
end

function ActivityMainDlg:initUI()
	self.scrollPage = UIControls.ScrollView(self, "MainInfoPanel/PageList")

	self.scrollPage:addScrollCorrectOnChanged(self.onCorrectEvent)

	self.pageBtns = {}

	for i = 1, 15 do
		local btnPage = UIControls.Button(self, "MainInfoPanel/PagePanel/Page" .. i)

		btnPage:addEventClick(self.onBtnPageClick)

		self.pageBtns[i] = btnPage

		if i == 1 then
			btnPage:setEnable(false)
		end
	end

	self.pages = {}
	self.btnStore = UIControls.Button(self, "BtnStore")

	self.btnStore:addEventClick(self.onStoreClick)

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_ACTIVITY_STORE) then
		self.btnStore:setVisible(false)
	end

	self.imgBg = UIControls.RawImage(self, "FrontPagePanel/ImgPage")
	self.panelBag = UIControls.Panel(self, "BagPanel")
	self.btnFirstPage = UIControls.Button(self, "MainInfoPanel/BtnBack")

	self.btnFirstPage:addEventClick(self.onFirstPage)

	self.panelTab = UIControls.Panel(self, "MainInfoPanel/TabList")

	self.panelTab:setVisible(true)
end

function ActivityMainDlg:onStoreClick()
	UIManager.getUI("activityMallDlg", true):onShow(50, 200)
end

function ActivityMainDlg:initFakeActData()
	CurAvatar:refreshFakeActs()
end

function ActivityMainDlg:openActivityGroup(pageId)
	self.pageId = CurAvatar:getValidActivityGroup()
	self.coInit = coroutine.start(self.initData, self)
end

function ActivityMainDlg:openActivityGroupByTab(tabId)
	self.pageId = CurAvatar:getValidActivityGroup()
	self.coInit = coroutine.start(self.initData, self, nil, tabId)
end

function ActivityMainDlg:openWay(way)
	if RegionUtils.isJP() then
		local data = Analytics.getByteSendLogPubParameter()

		data.event = "acv_patface_exposure"
		data.plan_id = 2992
		data.activity_id = 20411061
		data.source = way
		data.device_id = SDKCore.getUserValue("device_id")
		data.node_text = ""
		data.process_type = ""
		data.page_text = ""

		Analytics.sendLogByted("acv_patface_exposure", ClientUtils.table2String(data))
	end
end

function ActivityMainDlg:openActivity(showActId)
	self.pageId = CurAvatar:getValidActivityGroup()
	self.coInit = coroutine.start(self.initData, self, showActId)
end

function ActivityMainDlg:onOpen()
	ActivityMainDlg.super.onOpen(self)

	if self.inited and self.currentPageIndex and self.pages[self.currentPageIndex] and self.pages[self.currentPageIndex].onShow then
		self.pages[self.currentPageIndex]:onShow(true)
	end

	if GameFsm.isInState(Const.STATE_MAIN_STAGE) then
		CurAvatar:enterMainStage()
	end
end

function ActivityMainDlg:initData(showActId, tabId)
	if not self.inited then
		self.inited = true
		self.pages = {}
		self.pageData = {}

		local initTabId
		local pageMainConfig = ResActivityMainConfig[self.pageId] or UIMiscConfig.NO_GROUP_ACTIVITY_CONFIG

		if pageMainConfig and pageMainConfig.front_icon then
			self.imgBg:setImage(pageMainConfig.front_icon_path .. "/" .. pageMainConfig.front_icon)
		end

		table.insert(self.pageData, {
			pageMainConfig
		})

		local subConfigData = {}

		for subId, subData in ipairs(ResActivityMainTabConfig) do
			table.insert(subConfigData, subData)

			if showActId and subData.act_id == showActId and subData.belong_page then
				initTabId = subData.belong_page[1]
			end
		end

		if tabId then
			initTabId = tabId
		end

		table.sort(subConfigData, utils.getSortingFunc("order", true))

		for _, subData in ipairs(subConfigData) do
			if subData.sub_type then
				local isOpen = CurAvatar:checkActGroupOpen(subData.sub_type)

				if isOpen and subData.fixed_client_template then
					table.insert(self.pageData, {
						ResOpActivityClientTemplate[subData.fixed_client_template],
						[3] = subData
					})
				end
			elseif not subData.jump_id then
				local actId = subData.act_id
				local actObj = CurAvatar:getActivityObj(actId)

				if actObj and actObj:isValid() then
					if subData.fixed_client_template then
						table.insert(self.pageData, {
							ResOpActivityClientTemplate[subData.fixed_client_template],
							actObj,
							subData
						})
					elseif actObj.clientTemplateData then
						local templateConfig = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[actObj.clientTemplateData.template_type]

						if templateConfig and templateConfig[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_BANNER then
							table.insert(self.pageData, {
								actObj.clientTemplateData,
								actObj,
								subData
							})
						end
					end
				end
			end
		end

		for i = #self.pageData + 1, #self.pageBtns do
			self.pageBtns[i]:setVisible(false)
		end

		for pageIndex, pageData in ipairs(self.pageData) do
			local templateConfig = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[pageData[1].template_type]

			if templateConfig then
				ClientUtils.trycall(self.createActivityBanner, self, pageIndex, pageData, templateConfig)

				if pageIndex == 1 then
					self:createTabBtns()
					self:onTabBtnClick(initTabId)
				end

				coroutine.wait(0.05)
			end
		end

		local lastPage = self.pages[#self.pages]

		if lastPage and not lastPage:getVisible() then
			lastPage:setPosition(630 + (self.nowShowLen - 1) * 1280, -430)
		end
	else
		coroutine.wait(0.3)
	end

	self.coInit = nil

	if not self.currentPageIndex then
		self.currentPageIndex = 1

		self.btnFirstPage:setEnable(false)
	end

	if showActId then
		self:onChooseOneAct(showActId)
	end

	self:onRefreshTabNew()
end

function ActivityMainDlg:getTabPageInfo()
	local tabData = {}
	local priorData = {}

	tabData[SHOW_TAB_ALL] = {}

	for index, subId in pairs(self.pages[1].pageSubTabs) do
		local subData = ResActivityMainTabConfig[subId]

		if subData then
			for _, bPage in ipairs(subData.belong_page or {}) do
				local needAdd = true

				if bPage == SHOW_TAB_TIME_LIMIT then
					local actObj = CurAvatar:getActivityObj(subData.act_id)

					if not actObj or not actObj:inOpenState() or not (actObj:getRemainOpenTime() < Const.TIME_ONE_DAY) or not not actObj:isAllFinish() then
						needAdd = false
					end
				end

				if needAdd then
					if not tabData[bPage] then
						tabData[bPage] = {}
					end

					table.insert(tabData[bPage], subData)

					if subData.default_page_prior and (priorData[bPage] == nil or priorData[bPage] > subData.default_page_prior) then
						priorData[bPage] = subData.default_page_prior
					end
				end
			end
		end
	end

	if tabData[SHOW_TAB_RECOMMEND] and #tabData[SHOW_TAB_RECOMMEND] <= 3 then
		tabData[SHOW_TAB_RECOMMEND] = nil
		priorData[SHOW_TAB_RECOMMEND] = nil
	end

	local defaultPage = SHOW_TAB_ALL
	local nowPrior = 9999

	for tabId, prior in pairs(priorData) do
		if prior and prior < nowPrior then
			defaultPage = tabId
			nowPrior = prior
		end
	end

	return tabData, defaultPage
end

function ActivityMainDlg:_notInTable(subData, showTab)
	if showTab == SHOW_TAB_ALL then
		return false
	end

	if not subData then
		return false
	end

	if showTab == SHOW_TAB_TIME_LIMIT then
		return not self.timeLimitShowData[subData.sub_id]
	end

	return not utils.isInTable(subData.belong_page, showTab)
end

function ActivityMainDlg:createActivityBanner(pageIndex, pageData, templateConfig)
	self.pages[pageIndex] = templateConfig[1](self, "MainInfoPanel/PageList/Content", "System/Activity/" .. pageData[1].template_path)

	self.pages[pageIndex]:onShowActivity(pageData)

	if self:_notInTable(pageData[3], self.showTab) then
		self.pages[pageIndex]:setVisible(false)

		if self.pageBtns[pageIndex] then
			self.pageBtns[pageIndex]:setVisible(false)
		end
	else
		self.pages[pageIndex]:setVisible(true)

		if self.pageBtns[pageIndex] then
			self.pageBtns[pageIndex]:setVisible(true)
		end

		if self.nowShowLen then
			self.nowShowLen = self.nowShowLen + 1
		end
	end
end

function ActivityMainDlg:onCorrectEvent(sender, currentPageIndex)
	if self.pages[currentPageIndex] and self.pages[currentPageIndex]:getVisible() then
		if self.currentPageIndex and self.pages[self.currentPageIndex] then
			self.pages[self.currentPageIndex]:onLeavePage()
		end

		self.currentPageIndex = currentPageIndex

		self.btnFirstPage:setEnable(currentPageIndex ~= 1)
		self.pages[currentPageIndex]:onShow(true)

		for i, btnPage in ipairs(self.pageBtns) do
			btnPage:setEnable(self.currentPageIndex ~= i)
		end
	end
end

function ActivityMainDlg:onBtnPageClick(sender)
	for i, btnPage in ipairs(self.pageBtns) do
		btnPage:setEnable(btnPage ~= sender)

		if btnPage == sender then
			self:_RealJumpToIndex(i)
		end
	end
end

function ActivityMainDlg:onRefreshBanner()
	for _, page in pairs(self.pages) do
		if page.onRefreshBanner then
			page:onRefreshBanner()
		end
	end

	self:onRefreshTabNew()
end

function ActivityMainDlg:onRefreshMainBanner()
	if self.pages[1] and self.pages[1].onRefreshBanner then
		self.pages[1]:onRefreshBanner()
	end

	self:onRefreshTabNew()
end

function ActivityMainDlg:updateActivityData(actObj)
	local page = self.pages[self.currentPageIndex]

	if page and page.actObj and page.actObj.actId == actObj.actId then
		page:onActivityDataRefresh(actObj)
	end
end

function ActivityMainDlg:updateRelatedActivityData(actObj, masterActId)
	local page = self.pages[self.currentPageIndex]

	if page and page.actObj and (page.actObj.actId == actObj.actId or page.actObj.actId == masterActId) then
		page:onActivityDataRefresh(actObj)
	elseif page and page.updateRelatedActivityData then
		page:updateRelatedActivityData(actObj, masterActId)
	end
end

function ActivityMainDlg:changePageToAnotherAct(preActId, curActId, UnJump)
	for pageIndex, pData in ipairs(self.pageData) do
		if pData[2] and pData[2].actId == preActId and self.pages[pageIndex] then
			local actObj = CurAvatar:getActivityObj(curActId)

			if actObj then
				self.pageData[pageIndex] = {
					actObj.clientTemplateData,
					actObj
				}
				self.pages[pageIndex].inited = false

				self.pages[pageIndex]:onShowActivity(self.pageData[pageIndex])
				self:onRefreshMainBanner()

				if not UnJump then
					self:_RealJumpToIndex(pageIndex)
				end
			end

			return
		end
	end
end

function ActivityMainDlg:onChooseOneAct(actId)
	local actObj = CurAvatar:getActivityObj(actId)

	if not actObj then
		return
	end

	local templateConfig = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[actObj.clientTemplateData.template_type]

	if templateConfig then
		if templateConfig[2] == UIConst.ACTIVITY_TEMPLATE_TYPE_WINDOW then
			actObj:checkWindowReplace()

			local targetUI = UIManager.getUI(templateConfig[1], true)

			targetUI:onShowActivity({
				actObj.clientTemplateData,
				actObj
			})
		else
			for pageIndex, pData in ipairs(self.pageData) do
				local pData = self.pageData[pageIndex]

				if pData[2] and pData[2].actId == actId then
					self:_RealJumpToIndex(pageIndex)

					return
				end
			end
		end
	end
end

function ActivityMainDlg:_RealJumpToIndex(jumpPage)
	local page = self.pages[jumpPage]

	if page and not page:getVisible() then
		local subConfig = page.subConfig

		if self:_notInTable(subConfig, self.showTab) then
			self:onTabBtnClick(subConfig.belong_page[1])
			coroutine.start(self.delayJump, self, jumpPage)

			return
		end
	end

	self.scrollPage:scrollToCorrectPage(jumpPage)
end

function ActivityMainDlg:delayJump(jumpPage)
	coroutine.wait(0.3)
	self.scrollPage:scrollToCorrectPage(jumpPage)
end

function ActivityMainDlg:onClickOneActTab(tabId)
	local tabData = ResActivityMainTabConfig[tabId]

	if not tabData then
		return
	end

	if tabData.fixed_client_template then
		for pageIndex, pData in ipairs(self.pageData) do
			if pData[1] and pData[1].template_id == tabData.fixed_client_template then
				self:_RealJumpToIndex(pageIndex)

				return
			end
		end
	else
		self:onChooseOneAct(tabData.act_id)
	end
end

function ActivityMainDlg:onFirstPage()
	self.scrollPage:scrollToCorrectPage(1)
end

function ActivityMainDlg:stopCoInit()
	if self.coInit then
		coroutine.stop(self.coInit)

		self.coInit = nil
	end
end

function ActivityMainDlg:activityStateShow(actObj, extraStateArgs)
	if actObj.actType == Const.ACT_TYPE_BUYGIFT_DRAW then
		for i, page in pairs(self.pages) do
			if page and page.actObj == actObj and page.jumpToLevelTab then
				page:jumpToLevelTab(extraStateArgs[1])
			end
		end
	end
end

function ActivityMainDlg:cacheDataRefresh(pageObj, args)
	local page = self.pages[self.currentPageIndex]

	if page and page == pageObj and page.cacheDataRefresh then
		page:cacheDataRefresh(args)
	end
end

function ActivityMainDlg:onClose()
	self:stopCoInit()

	for i, page in pairs(self.pages) do
		if self.currentPageIndex and self.currentPageIndex == i then
			page:onLeavePage()
		end

		page:onClosePanel()
	end

	ActivityMainDlg.super.onClose(self)
end

function ActivityMainDlg:destroy()
	ActivityMainDlg.super.destroy(self)

	local mainStageDlg = UIManager.tryGetUI("mainStageDlg")

	if mainStageDlg and mainStageDlg:isInShow() then
		mainStageDlg.panelPushGiftB:onRefresh()
	end

	local mainMenu = UIManager.tryGetUI("mainMenu")

	if mainMenu and mainMenu:isInShow() then
		mainMenu.panelPushGiftB:onRefresh()
	end
end

function ActivityMainDlg:onGetActivityBonus(actId, bonusFunc)
	local page = self.pages[self.currentPageIndex]

	if page and page.actObj and page.actObj.actId == actId and page.onGetActivityBonus then
		page:onGetActivityBonus(bonusFunc)
	else
		bonusFunc()
	end
end

local function getTabActivityOpenTime(tabPageData)
	local openTime = ClientUtils.getServerTime()

	for _, subData in ipairs(tabPageData) do
		if subData.act_id then
			local actObj = CurAvatar:getActivityObj(subData.act_id)

			if actObj and actObj.startTime and openTime > actObj.startTime then
				openTime = actObj.startTime
			end
		end
	end

	return openTime
end

local function SortTabData(a, b)
	if a.priority and b.priority then
		if a.priority ~= b.priority then
			return a.priority < b.priority
		else
			return a.openTime > b.openTime
		end
	elseif a.priority then
		return true
	end
end

function ActivityMainDlg:createTabBtns()
	if not self.tabBtns and self.pages[1] then
		self.tabBtns = {}

		local tabData, defaultPage = self:getTabPageInfo()

		self.defaultPageId = defaultPage
		self.timeLimitShowData = {}

		for _, subData in ipairs(tabData[SHOW_TAB_TIME_LIMIT] or {}) do
			self.timeLimitShowData[subData.sub_id] = true
		end

		local sortData = {}

		for tabId, allTabData in pairs(tabData) do
			local oneData = ResActivityMainTabPageConfig[tabId]

			oneData.openTime = getTabActivityOpenTime(allTabData)

			table.insert(sortData, oneData)
		end

		table.sort(sortData, SortTabData)

		for index = #self.tabBtns, #sortData - 1 do
			local newBtn = ActivityMainBannerTabBtn(self, "MainInfoPanel/TabList", "System/Activity/TabActivityMain")

			table.insert(self.tabBtns, newBtn)
		end

		for index, btn in ipairs(self.tabBtns) do
			if sortData[index] then
				btn:setVisible(true)
				btn:setData(sortData[index], tabData[sortData[index].page_id])
			else
				btn:setVisible(false)
			end
		end
	end
end

function ActivityMainDlg:onRefreshTabNew()
	for _, tabBtn in ipairs(self.tabBtns) do
		tabBtn:refreshTabBtnNew()
	end
end

function ActivityMainDlg:checkTabHasNew(tabId)
	local hasNewOpen = false
	local redDotIds = {}
	local firstPage = self.pages[1]

	if firstPage then
		for index, subId in pairs(firstPage.pageSubTabs) do
			local subData = ResActivityMainTabConfig[subId]

			if not self:_notInTable(subData, tabId) then
				local actId = subData.act_id
				local actObj = CurAvatar:getActivityObj(actId)
				local actGroupType = subData.sub_type

				if actObj and actObj:isValid() then
					if actObj:isNewOpened() then
						hasNewOpen = true
					elseif not subData.jump_id and not subData.fixed_client_template then
						table.insert(redDotIds, actObj.redDotId)
					end
				elseif actGroupType and CurAvatar:checkActGroupNewOpen(actGroupType) then
					hasNewOpen = true
				end
			end
		end
	end

	return hasNewOpen, redDotIds
end

function ActivityMainDlg:onTabBtnClick(tabId)
	tabId = tabId or self.defaultPageId
	self.nowShowLen = 0
	self.showTab = tabId

	for pageIndex, page in ipairs(self.pages) do
		if self:_notInTable(page.subConfig, self.showTab) then
			page:setVisible(false)
			page:setPosition(0, 0)

			if self.pageBtns[pageIndex] then
				self.pageBtns[pageIndex]:setVisible(false)
			end
		else
			self.nowShowLen = self.nowShowLen + 1

			page:setVisible(true)

			if self.pageBtns[pageIndex] then
				self.pageBtns[pageIndex]:setVisible(true)
			end
		end
	end

	for index, btn in ipairs(self.tabBtns) do
		btn:setSelected(tabId == btn.tabId)
	end

	self.scrollPage:scrollToCorrectPage(1)

	if self.pages[1] then
		self.pages[1]:setTabId(self.showTab)
	end

	local lastPage = self.pages[#self.pages]

	if lastPage and not lastPage:getVisible() then
		lastPage:setPosition(630 + (self.nowShowLen - 1) * 1280, -430)
	end
end

function ActivityMainDlg:checkActPageVisible(actObj)
	local page = self.pages[self.currentPageIndex]

	if page and page.actObj and page.actObj == actObj then
		return true
	end

	return false
end

function ActivityMainDlg:playSpecialShow(actObj, extraArgs)
	local page = self.pages[self.currentPageIndex]

	if page and page.actObj and page.actObj == actObj and page.playSpecialShow then
		page:playSpecialShow(extraArgs)
	end
end

function ActivityMainDlg:updateMgrDataRefreshBannerUI()
	for i, page in pairs(self.pages) do
		if page and page.actObj and MGR_DATA_REFRESH_TYPE[page.actObj.actType] and page.refreshUI then
			page:refreshUI()
		end
	end
end

return ActivityMainDlg
