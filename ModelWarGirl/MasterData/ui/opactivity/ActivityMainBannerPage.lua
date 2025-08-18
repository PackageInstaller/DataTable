-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMainBannerPage.lua

local ResActivityMainTabConfig = require("ClientData/ResActivityMainTabConfig")
local VersionUtils = require("System/VersionUtils")
local ActivityMainBannerBtn = Class("ActivityMainBannerBtn", UIControls.Child)

function ActivityMainBannerBtn:ctor()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onTabBtnClick)

	self.imgBg = UIControls.RawImage(self, "Bg")
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textTime = UIControls.Label(self, "TextTime")
	self.panelNew = UIControls.Panel(self, "IconNewContainer")
	self.rdNew = UIControls.RedDot(self, "IconNewContainer/IconNew")
	self.iconNewOpen = UIControls.RedDot(self, "IconNewOpen")
	self.textOrder = UIControls.Label(self, "TextNum")
	self.panelFinish = UIControls.Panel(self, "ImgGet")
end

function ActivityMainBannerBtn:setData(order, tabConfig)
	self.textOrder:setText("0" .. order)

	self.tabConfig = tabConfig
	self.isNewOpened = false
	self.newHintId = nil

	if self.tabConfig then
		local actId = tabConfig.act_id
		local actObj = CurAvatar:getActivityObj(actId)
		local actGroupType = tabConfig.sub_type

		self.actObj = actObj
		self.actGroupType = actGroupType

		if actGroupType or actObj then
			self.imgBg:setImage("NoAlpha/Activity/MainPageBanner/" .. (tabConfig.icon or ""))
			self.textTitle:setText(tabConfig.title or "")

			local mainColor = tabConfig.main_color
			local titleColor = tabConfig.title_color

			if actObj then
				if self.tabConfig.time_desc and self.tabConfig.time_desc ~= "" then
					ClientTimerManager.RemoveSecondTickUI(self.textTime)
					self.textTime:setText(self.tabConfig.time_desc)
				elseif actObj.endTime <= 0 then
					ClientTimerManager.RemoveSecondTickUI(self.textTime)
					self.textTime:setText("")
				else
					ClientTimerManager.AddSecondFormatTickUI(self.textTime, actObj:getRemainOpenTime(), false, Lang.get(48655))
				end

				self.rdNew:clearHint()

				if not self.tabConfig.jump_id and not self.tabConfig.fixed_client_template then
					self.rdNew:addHint({
						actObj.redDotId
					})
				end

				local isFinish = actObj:isAllFinish() and tabConfig.no_finish ~= 1

				if isFinish then
					self.panelFinish:setVisible(true)
				else
					self.panelFinish:setVisible(false)
				end

				if actObj.limitId and ConditionLimitManager.inLimitState(actObj.limitId) or isFinish then
					self.btnSensor:setObjGray(true)

					mainColor = tabConfig.main_gray_color
					titleColor = tabConfig.title_gray_color

					self.panelNew:setVisible(false)
					self.iconNewOpen:setVisible(false)
				else
					self.btnSensor:setObjGray(false)

					if actObj:isNewOpened() then
						self.panelNew:setVisible(false)
						self.iconNewOpen:setVisible(true)

						self.isNewOpened = true
					else
						self.newHintId = actObj.redDotId

						self.panelNew:setVisible(true)
						self.iconNewOpen:setVisible(false)
					end
				end
			elseif actGroupType then
				ClientTimerManager.RemoveSecondTickUI(self.textTime)
				self.textTime:setText("")
				self.panelFinish:setVisible(false)
				self.btnSensor:setObjGray(false)
				self.panelNew:setVisible(false)

				local isNewOpened = CurAvatar:checkActGroupNewOpen(actGroupType)

				self.iconNewOpen:setVisible(isNewOpened)

				self.isNewOpened = isNewOpened
				self.isNewShowGroupOpen = isNewOpened
			end

			if mainColor then
				self.textTime:setColorByRGBA(mainColor[1] / 255, mainColor[2] / 255, mainColor[3] / 255, 1)
			end

			if titleColor then
				self.textTitle:setColorByRGBA(titleColor[1] / 255, titleColor[2] / 255, titleColor[3] / 255, 1)
			end
		end
	end
end

function ActivityMainBannerBtn:onTabBtnClick()
	if self.actObj and self.actObj.limitId and ConditionLimitManager.inLimitState(self.actObj.limitId) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(self.actObj.limitId))
	else
		if self.mWindow and self.mWindow.coInit then
			MsgManager.notice(Lang.get(85727))

			return
		end

		self.mParent:onTabClick(self.tabConfig)

		if self.actObj and self.actObj:isNewOpened() then
			RPC.opActSetFocus(self.actObj.opId, 1)
		elseif self.actGroupType and self.isNewShowGroupOpen then
			-- block empty
		end
	end
end

function ActivityMainBannerBtn:onClear()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self.rdNew:clearHint()
end

local classNameStr = "ActivityMainBannerPage"
local ActivityMainBannerPage = Class(classNameStr, UIControls.Child)

function ActivityMainBannerPage:ctor()
	self.textDesc = UIControls.Label(self, "TextDes")
	self.subBtns = {}
end

function ActivityMainBannerPage:onRefreshBanner()
	if self.tabId then
		self:setTabId(self.tabId)
	end
end

function ActivityMainBannerPage:onShowActivity(pageData)
	self.pageData = pageData
	self.pageMainConfig = pageData[1]
	self.pageSubTabs = {}

	local finishSubTabs = {}
	local subConfigData = {}

	for subId, subData in ipairs(ResActivityMainTabConfig) do
		table.insert(subConfigData, subData)
	end

	table.sort(subConfigData, utils.getSortingFunc("order", true))

	for _, subData in ipairs(subConfigData) do
		local subId = subData.sub_id
		local actId = subData.act_id

		if actId then
			local actObj = CurAvatar:getActivityObj(actId)

			if subData.unlock_hide == 1 then
				if actObj and actObj:isValid() then
					if actObj:isAllFinish() and subData.no_finish ~= 1 then
						table.insert(finishSubTabs, subId)
					else
						table.insert(self.pageSubTabs, subId)
					end
				end
			elseif actObj and actObj:isValidExceptCondition() then
				if actObj:isAllFinish() and subData.no_finish ~= 1 then
					table.insert(finishSubTabs, subId)
				else
					table.insert(self.pageSubTabs, subId)
				end
			end
		elseif subData.sub_type then
			local isOpen = CurAvatar:checkActGroupOpen(subData.sub_type)

			if isOpen then
				table.insert(self.pageSubTabs, subId)
			end
		end
	end

	for _, finishSubId in ipairs(finishSubTabs) do
		table.insert(self.pageSubTabs, finishSubId)
	end

	self.textDesc:setText(self.pageMainConfig.desc or "")

	for index = #self.subBtns, #self.pageSubTabs - 1 do
		if index % 2 == 1 then
			local newBtn = ActivityMainBannerBtn(self, "ContentList/Content", "System/Activity/ActivityContent01CellL")

			table.insert(self.subBtns, newBtn)
		else
			local newBtn = ActivityMainBannerBtn(self, "ContentList/Content", "System/Activity/ActivityContent01CellR")

			table.insert(self.subBtns, newBtn)
		end
	end
end

function ActivityMainBannerPage:onShow()
	return
end

function ActivityMainBannerPage:checkCellJumpReject(jump_id)
	if jump_id == 70 or jump_id == 71 or jump_id == 83 then
		local mallDlg = UIManager.tryGetUI("mallDlg")

		if mallDlg then
			mallDlg:setManualReject(self.mParent.mUIName, "openActivityGroupByTab", {
				self.mParent.showTab
			})
		end
	end

	self.mParent:setVisible(false)
end

function ActivityMainBannerPage:onTabClick(subConfig)
	if subConfig.jump_id then
		if self:tryReportBuriedPoint_JP(subConfig) then
			return
		end

		JumpGuideManager.jump(subConfig.jump_id)
		self:checkCellJumpReject(subConfig.jump_id)
	elseif subConfig.fixed_client_template then
		self.mParent:onClickOneActTab(subConfig.sub_id)
	else
		self.mParent:onChooseOneAct(subConfig.act_id)
	end
end

function ActivityMainBannerPage:tryReportBuriedPoint_JP(subConfig)
	if RegionUtils.isJP() and subConfig.act_id then
		local Analytics = require("SDK/Analytics")
		local data = Analytics.getByteSendLogPubParameter()

		if subConfig.act_id == 2995 then
			data.page_id = "https://figurestory.nvsgames.com/openday"

			Analytics.sendLogByted("page_flow", ClientUtils.table2String(data))
		elseif subConfig.act_id == 2992 then
			local SDKCore = require("SDK/SDKCore")

			data.event = "acv_patface_click"
			data.plan_id = 2992
			data.device_id = SDKCore.getUserValue("device_id")
			data.node_text = ""
			data.activity_id = 20411061
			data.process_type = "https://act.sgsnssdk.com/ugg/6177b9e841001b02?app_id=4255&orientation=landscape&hide_nav_bar=1"
			data.page_text = ""

			Analytics.sendLogByted("acv_patface_click", ClientUtils.table2String(data))
		end

		if (subConfig.act_id == 2995 or subConfig.act_id == 2992) and VersionUtils.getEngineVersion() < 163403 then
			MsgManager.notice("本イベントに参加するには、最新のバージョンが必要になります。アプリストアまでアップデートしてください。")

			return true
		end
	end

	return false
end

function ActivityMainBannerPage:changeBannerToAnotherAct(preActId, curActId)
	for index, banner in ipairs(self.subBtns) do
		if banner.tabConfig.act_id == preActId then
			-- block empty
		end
	end
end

function ActivityMainBannerPage:onDestroy()
	for index, btn in ipairs(self.subBtns) do
		btn:onClear()
	end

	ActivityMainBannerPage.super.onDestroy(self)
end

function ActivityMainBannerPage:resetUI()
	return
end

function ActivityMainBannerPage:onClosePanel()
	return
end

function ActivityMainBannerPage:onLeavePage()
	return
end

function ActivityMainBannerPage:setTabId(tabId)
	self.tabId = tabId
	self.showSubTabs = {}

	for index, subId in ipairs(self.pageSubTabs) do
		if not self.mParent:_notInTable(ResActivityMainTabConfig[subId], tabId) then
			table.insert(self.showSubTabs, subId)
		end
	end

	for index, btn in ipairs(self.subBtns) do
		local subId = self.showSubTabs[index]

		if subId then
			btn:setVisible(true)
			btn:setData(index, ResActivityMainTabConfig[subId])
		else
			btn:setVisible(false)
		end
	end
end

return ActivityMainBannerPage
