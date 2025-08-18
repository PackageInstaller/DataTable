-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySpeGiftDlg.lua

local ActivitySkinLotteryGiftPanel = require("UI/OpActivity/ActivitySkinLotteryGiftPanel")
local BPReturnStorePanel = require("UI/OpActivity/BPReturn/BPReturnStorePanel")
local ActivitySnowOrNightBPGiftPanel = require("UI/OpActivity/SnowNightBP/ActivitySnowOrNightBPGiftPanel")
local UIControls = UIControls
local strClassName = "ActivitySpeGiftDlg"
local ActivitySpeGiftDlg = Class(strClassName, UIControls.Window)

ActivitySpeGiftDlg.SubPanelTypeConfig = {
	CommonGiftDlg = {
		FolderPath = "System/Activity/ActivitySpeGift/",
		PanelClass = ActivitySkinLotteryGiftPanel
	},
	BattlePassStoreDlg = {
		FolderPath = "System/Return/",
		PanelClass = BPReturnStorePanel
	},
	ActivitySnowOrNightBPDlg = {
		FolderPath = "",
		PanelClass = ActivitySnowOrNightBPGiftPanel
	}
}

function ActivitySpeGiftDlg:ctor()
	self:initUI()
end

function ActivitySpeGiftDlg:initUI()
	return
end

function ActivitySpeGiftDlg:_createRealSubPanel()
	local panelName = self.clientTemplateData.template_path or "SpeGiftSkinLotteryPanel"
	local templateType = self.clientTemplateData.template_type

	if templateType then
		local panelClass = self.SubPanelTypeConfig[templateType].PanelClass
		local folderPath = self.SubPanelTypeConfig[templateType].FolderPath

		if panelClass and folderPath then
			local subPanel = panelClass(self, "BgPanel", folderPath .. panelName, 0, 0, true)

			subPanel:onShowActivity({
				self.clientTemplateData,
				self.actObj
			})

			self.subPanel = subPanel
		end
	end
end

function ActivitySpeGiftDlg:setData(actObj, windowName)
	self.actObj = actObj
	self.clientTemplateData = self.actObj:getExtraClientTemplate(windowName) or {}

	self:_createRealSubPanel()
end

function ActivitySpeGiftDlg:onShowActivity(pageData)
	self.clientTemplateData = pageData[1]
	self.actObj = pageData[2]

	self:_createRealSubPanel()
end

function ActivitySpeGiftDlg:updateRelatedActivityData(actObj, relatedActId)
	if self.subPanel and self.subPanel._onShow then
		self.subPanel:_onShow()
	end

	if self.subPanel and self.subPanel.onActivityDataRefresh then
		self.subPanel:onActivityDataRefresh(actObj)
	end
end

function ActivitySpeGiftDlg:updateActivityData(actObj)
	if self.subPanel and self.subPanel.refreshActivityData then
		self.subPanel:refreshActivityData(actObj)
	end
end

return ActivitySpeGiftDlg
