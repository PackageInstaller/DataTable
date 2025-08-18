-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBPPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityBPListPanel = require("UI/OpActivity/ActivityBPListPanel")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ActivityBPTabBtn = Class("ActivityBPTabBtn", UIControls.Child)

function ActivityBPTabBtn:ctor()
	self:initUI()
end

function ActivityBPTabBtn:initUI()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onTabBtnClick)

	self.textBP = UIControls.Label(self, "TextBP")
	self.iconNewTask = UIControls.RedDot(self, "IconNew")
end

function ActivityBPTabBtn:setData(tabIndex, data)
	self.tabIndex = tabIndex

	self.textBP:setText(data[1] or "")
end

function ActivityBPTabBtn:onTabBtnClick()
	self.mParent:onTabClick(self.tabIndex)
end

local classNameStr = "ActivityBPPage"
local ActivityBPPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityBPPage, ActivityPanelMixin)

function ActivityBPPage:ctor()
	return
end

function ActivityBPPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.pages = {}
	self.currPage = 1
end

function ActivityBPPage:_setData()
	self.tabData = {}
	self.actId = self.actObj.actId

	table.insert(self.tabData, {
		ResOpActivityClientTemplate[self.actId],
		self.actObj
	})

	for i, actId in ipairs(self.actObj.templateData.relate_act or {}) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isValid() then
			CurAvatar:addActivityRelated(actId, "activityMainDlg", self.actId)
			table.insert(self.tabData, {
				ResOpActivityClientTemplate[actId],
				actObj
			})
		end
	end

	self.tabList = {}

	for tabIndex, tabData in ipairs(self.tabData) do
		local newTab = ActivityBPTabBtn(self, "TabPanel", "System/Activity/ActivityBP/ActivityBPBtnTab")

		newTab:setData(tabIndex, tabData[1].sub_args)

		if tabIndex == 1 then
			newTab.iconNewTask:setVisible(tabData[2].actData:checkNew())
		else
			newTab.iconNewTask:addHint({
				tabData[2].redDotId
			})
		end

		newTab:setVisible(true)
		table.insert(self.tabList, newTab)
	end

	for tabIndex, tabData in ipairs(self.tabData) do
		if tabIndex == 1 then
			local prefabPath = self.clientTemplateData.sub_template_args[1]

			self.pages[tabIndex] = ActivityBPListPanel(self, "InfoPanel", "System/Activity/" .. prefabPath, 0, 0, true)

			self.pages[tabIndex]:onShowActivity(tabData)
		else
			local templateConfig = UIConst.ACTIVITY_TEMPLATE_TYPE_CONFIG[tabData[1].sub_template_args[2]]

			if templateConfig then
				ClientUtils.trycall(self.createTabPanel, self, tabIndex, tabData, templateConfig)
			end
		end
	end

	self:onTabClick(self.currPage)
end

function ActivityBPPage:createTabPanel(tabIndex, tabData, templateConfig)
	local prefabPath = tabData[1].sub_template_args[1]

	self.pages[tabIndex] = templateConfig[1](self, "InfoPanel", "System/Activity/" .. prefabPath, 0, 0, true)

	self.pages[tabIndex]:onShowActivity(tabData)
end

function ActivityBPPage:onTabClick(tabIndex)
	self.currPage = tabIndex

	for i, page in pairs(self.pages) do
		page:setVisible(i == tabIndex)
	end

	for i, tab in pairs(self.tabList) do
		local btn = UIControls.Button(tab, "")

		btn:setEnable(i ~= tabIndex)
	end
end

function ActivityBPPage:onActivityDataRefresh(actObj)
	self.tabList[1].iconNewTask:setVisible(self.tabData[1][2].actData:checkNew())

	for i, page in ipairs(self.pages) do
		if page.actObj.actId == actObj.actId then
			page:onActivityDataRefresh(actObj)
		end
	end
end

function ActivityBPPage:updateRelatedActivityData(actObj, masterActId)
	return
end

function ActivityBPPage:_onShow()
	for i, page in ipairs(self.pages) do
		if page._onShow then
			page:_onShow()
		end
	end
end

return ActivityBPPage
