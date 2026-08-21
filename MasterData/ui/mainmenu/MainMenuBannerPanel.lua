-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MainMenuBannerPanel.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResMainMenuBannerConfig = require("ClientData/ResMainMenuBannerConfig")
local ResActivityMainTabConfig = require("ClientData/ResActivityMainTabConfig")
local MainMenuBannerPage = Class("MainMenuBannerPage", UIControls.Child)

function MainMenuBannerPage:ctor()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBannerClick)

	self.imgBg = UIControls.RawImage(self, "Bg")
	self.textTitle = UIControls.Label(self, "BgTitle/TextTitle")
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.panelNew = UIControls.Panel(self, "IconNewContainer")
	self.hintNew = UIControls.RedDot(self, "IconNewContainer/IconNew")
	self.iconNewOpen = UIControls.RedDot(self, "IconNewOpen")
end

function MainMenuBannerPage:setData(bannerData)
	self.bannerData = bannerData

	self.imgBg:setImage("NoAlpha/Activity/MainMenuBanner/" .. bannerData.icon)
	self.textTitle:setText(bannerData.title)
	self.hintNew:clearHint()

	if bannerData.banner_type == Const.MENU_BANNER_TYPE_ACTIVITY then
		local actObj = CurAvatar:getActivityObj(bannerData.banner_arg)

		if actObj then
			local mainColor = bannerData.main_color

			if mainColor then
				self.textTime:setColorByRGBA(mainColor[1] / 255, mainColor[2] / 255, mainColor[3] / 255, 1)
			end

			if actObj.endTime and actObj.endTime > 0 then
				local remineTime = actObj.endTime - ClientUtils.getServerTime()

				ClientTimerManager.AddSecondFormatTickUI(self.textTime, remineTime, nil, Lang.get(48655))
			else
				ClientTimerManager.RemoveSecondTickUI(self.textTime)
				self.textTime:setText("")
			end
		end

		if self.bannerData.time_desc then
			ClientTimerManager.RemoveSecondTickUI(self.textTime)
			self.textTime:setText(self.bannerData.time_desc)
		end

		for _, actData in pairs(ResActivityMainTabConfig) do
			if actData.act_id == bannerData.banner_arg then
				self.hintNew:addHint({
					UIConst.ACTIVITY_GROUP_MAIN_RED_DOT
				})

				break
			end
		end

		if actObj:isNewOpened() then
			self.iconNewOpen:setVisible(true)
			self.panelNew:setVisible(false)
		else
			self.iconNewOpen:setVisible(false)
			self.panelNew:setVisible(true)
		end
	else
		ClientTimerManager.RemoveSecondTickUI(self.textTime)
		self.textTime:setText(self.bannerData.time_desc or "")

		if bannerData.banner_type == Const.MENU_BANNER_TYPE_ACTIVITY_GROUP then
			self.hintNew:addHint({
				UIConst.ACTIVITY_GROUP_MAIN_RED_DOT
			})

			if CurAvatar:isActivityGroupNewOpend() then
				self.iconNewOpen:setVisible(true)
				self.panelNew:setVisible(false)
			else
				self.iconNewOpen:setVisible(false)
				self.panelNew:setVisible(true)
			end
		end
	end
end

function MainMenuBannerPage:onBannerClick()
	if self.bannerData.guide_id then
		JumpGuideManager.jump(self.bannerData.guide_id)

		local activityMainDlg = UIManager.tryGetUI("activityMainDlg")

		if activityMainDlg then
			activityMainDlg:openWay("activity_center")
		end
	end
end

local MAX_SHOW_BANNER = 6
local MainMenuBannerPanel = Class("MainMenuBannerPanel", UIControls.Panel)

function MainMenuBannerPanel:ctor()
	self.dragPages = DragTwoPages(self, self.mPath .. "/ContentPanel1", self.mPath .. "/ContentPanel2", nil, nil, 5, self.mPath .. "/PagePanel/Page", true)
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}
end

function MainMenuBannerPanel:setDisPanel(panelDis)
	self.panelDis = panelDis
end

local function sortBannerFunc(a, b)
	return a.sort_id < b.sort_id
end

function MainMenuBannerPanel:onRefresh()
	self.bannerData = {}

	for _, info in pairs(ResMainMenuBannerConfig) do
		if self:_checkValid(info) then
			table.insert(self.bannerData, info)
		end
	end

	table.sort(self.bannerData, sortBannerFunc)

	if #self.bannerData == 0 then
		self:setVisible(false)
		self.panelDis:setVisible(true)
	else
		self:setVisible(true)
		self.panelDis:setVisible(false)
		self.dragPages:initPage(math.min(MAX_SHOW_BANNER, #self.bannerData), 1, MAX_SHOW_BANNER)
	end
end

function MainMenuBannerPanel:_checkValid(info)
	if info.condition_id and ConditionLimitManager.inLimitState(info.condition_id) then
		return false
	end

	if info.banner_type == Const.MENU_BANNER_TYPE_ACTIVITY then
		if not CurAvatar:isActivityValid(info.banner_arg) then
			return false
		end
	elseif info.banner_type == Const.MENU_BANNER_TYPE_ACTIVITY_GROUP then
		if not CurAvatar:isActivityGroupOpened(info.banner_arg) then
			return false
		end
	elseif info.banner_type == Const.MENU_BANNER_TYPE_ACTIVITY_NO_GROUP and not CurAvatar:noActivityGroupOpened() then
		return false
	end

	return true
end

function MainMenuBannerPanel:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	self.currentPageIndex = currentPageIndex
	self.currentPanelIndex = panelIndex

	local bannerData = self.bannerData[self.currentPageIndex]
	local page = self.pages[panelIndex]

	if not page or page.template_path ~= bannerData.template_path then
		if page then
			page:destroy()
		end

		local newPage = MainMenuBannerPage(self, self.mPath .. "/ContentPanel" .. panelIndex, "System/Activity/MainMenuBanner/" .. bannerData.template_path)

		newPage.template_path = bannerData.template_path

		newPage:setVisible(true)

		self.pages[panelIndex] = newPage
	end

	self.pages[panelIndex]:setData(bannerData)
end

function MainMenuBannerPanel:onMenuClose()
	self.dragPages:onPause()
end

function MainMenuBannerPanel:clear()
	self.dragPages:destroy()
end

return MainMenuBannerPanel
