-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCommonAchieveDlg.lua

local UIControls = UIControls
local ActivityCommonAchievePage = require("UI/OpActivity/ActivityCommonAchievePage")
local strClassName = "ActivityCommonAchieveDlg"
local ActivityCommonAchieveDlg = Class(strClassName, UIControls.Window)

ActivityCommonAchieveDlg.SubPanelTypeConfig = {
	CommonAchievePage = {
		PanelClass = ActivityCommonAchievePage
	}
}

function ActivityCommonAchieveDlg:ctor()
	return
end

function ActivityCommonAchieveDlg:_createRealSubPanel()
	local panelName = self.clientTemplateData.template_path or "SpecialStoreSkinLotteryPanel"
	local templateType = "CommonAchievePage"

	if self.clientTemplateData.sub_template_args and self.clientTemplateData.sub_template_args[1] then
		templateType = self.clientTemplateData.sub_template_args[1]
	end

	if templateType then
		local panelClass = ActivityCommonAchieveDlg.SubPanelTypeConfig[templateType].PanelClass

		if panelClass then
			local subPanel = panelClass(self, "BgPanel", "System/Activity/" .. panelName, 0, 0, true)

			subPanel.panelFund = self.panelFund

			subPanel:onShowActivity({
				self.clientTemplateData,
				self.actObj
			})

			self.subPanel = subPanel
		end
	end
end

function ActivityCommonAchieveDlg:setData(actObj)
	self.actObj = actObj
	self.clientTemplateData = self.actObj:getExtraClientTemplate("activityCommonAchieveDlg")

	self:_createRealSubPanel()

	if self.subPanel and self.subPanel.openBgmId then
		self:playLogicBGM(self.subPanel.openBgmId)
	end
end

function ActivityCommonAchieveDlg:updateRelatedActivityData()
	if self.subPanel then
		if self.subPanel.refreshData then
			self.subPanel:refreshData()
		elseif self.subPanel.updateRelatedActivityData then
			self.subPanel:updateRelatedActivityData()
		end
	end
end

function ActivityCommonAchieveDlg:updateActivityData()
	if self.subPanel and self.subPanel.onActivityDataRefresh then
		self.subPanel:onActivityDataRefresh()
	end
end

function ActivityCommonAchieveDlg:onShowActivity(pageData)
	self:setData(pageData[2])
end

return ActivityCommonAchieveDlg
