-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCommonStoreDlg.lua

local ActivityShopPanel = require("UI/Welfare/ActivityShopPanel")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local ActivityLinkedShopPage = require("UI/OpActivity/Shop/ActivityLinkedShopPage")
local UIControls = UIControls
local CommonAndActShopPanel = require("UI/Welfare/CommonAndActShopPanel")
local strClassName = "ActivityCommonStoreDlg"
local ActivityCommonStoreDlg = Class(strClassName, UIControls.Window)

ActivityCommonStoreDlg.SubPanelTypeConfig = {
	CommonStoreDlg = {
		PanelClass = ActivityShopPanel
	},
	LinkedStoreDlg = {
		PanelClass = ActivityLinkedShopPage
	}
}

function ActivityCommonStoreDlg:ctor()
	self:initUI()
end

function ActivityCommonStoreDlg:initUI()
	self.closeBtn = UIControls.Button(self, "BtnClose", "Text")

	self.closeBtn:addEventClick(self._onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)
end

function ActivityCommonStoreDlg:_createRealSubPanel()
	if self.clientTemplateData then
		local panelName = self.clientTemplateData.template_path or "SpecialStoreSkinLotteryPanel"
		local templateType = "CommonStoreDlg"

		if self.clientTemplateData.sub_template_args and self.clientTemplateData.sub_template_args[1] then
			templateType = self.clientTemplateData.sub_template_args[1]
		end

		if templateType then
			local panelClass = ActivityCommonStoreDlg.SubPanelTypeConfig[templateType].PanelClass

			if panelClass then
				local subPanel = panelClass(self, "MainInfoPanel", "System/Activity/ActivitySpecialStore/" .. panelName, 0, 0, true)

				subPanel.panelFund = self.panelFund

				if subPanel.initPanelData then
					subPanel:initPanelData(nil, nil)
					subPanel:onOpenPanel(self.actObj.actId, self.clientTemplateData)
				elseif subPanel.onShowActivity then
					subPanel:onShowActivity({
						self.clientTemplateData,
						self.actObj
					})
				end

				self.subPanel = subPanel
			end
		end
	elseif self.panelConfigData then
		local panelName = self.panelConfigData.preName
		local subPanel = CommonAndActShopPanel(self, "MainInfoPanel", "System/Activity/ActivitySpecialStore/" .. panelName, 0, 0, true)

		subPanel.panelFund = self.panelFund

		if subPanel.initPanelData then
			subPanel:initPanelData(nil, self.panelConfigData)
			subPanel:openPanelData(nil, self.panelConfigData)
		end

		self.subPanel = subPanel
	end
end

function ActivityCommonStoreDlg:setData(actObj, subMallId)
	self.actObj = actObj
	self.subMallId = subMallId

	if self.actObj then
		self.clientTemplateData = self.actObj:getExtraClientTemplate("activityCommonStoreDlg")

		if self.clientTemplateData.template_name then
			self.closeBtn:setText(self.clientTemplateData.template_name)
		end
	elseif self.subMallId then
		self.panelConfigData = ResMallSubPanelConfig[self.subMallId]

		self.closeBtn:setText(self.panelConfigData.pageName)
	end

	self:_createRealSubPanel()

	if self.panelConfigData and self.panelConfigData.change_bgm then
		self:playLogicBGM(self.panelConfigData.change_bgm)
	end

	if self.subPanel and self.subPanel.openBgmId then
		self:playLogicBGM(self.subPanel.openBgmId)
	end
end

function ActivityCommonStoreDlg:updateRelatedActivityData()
	if self.subPanel then
		if self.subPanel.refreshData then
			self.subPanel:refreshData()
		elseif self.subPanel.updateRelatedActivityData then
			self.subPanel:updateRelatedActivityData()
		end
	end
end

function ActivityCommonStoreDlg:updateActivityData()
	if self.subPanel and self.subPanel.updateActivityData then
		self.subPanel:updateActivityData()
	end
end

function ActivityCommonStoreDlg:onShopEnterResp(shopID, shopItems)
	if self.subPanel and self.subPanel.onShopEnterResp then
		self.subPanel:onShopEnterResp(shopID, shopItems)
	end
end

function ActivityCommonStoreDlg:updateItem(serverItemInfo)
	if self.subPanel and self.subPanel.updateItem then
		self.subPanel:updateItem(serverItemInfo)
	end
end

function ActivityCommonStoreDlg:onShowActivity(pageData)
	self:setData(pageData[2])
end

function ActivityCommonStoreDlg:_onClickTips(...)
	local tipsId

	if self.actObj then
		if ResOpActivityTemplate[self.actObj.actId] then
			tipsId = ResOpActivityTemplate[self.actObj.actId].tips_id
		end
	elseif self.panelConfigData then
		tipsId = self.panelConfigData.tipId
	end

	if tipsId then
		UIManager.getUI("infoNotice", true):showSystemInfo(tipsId)
	end
end

function ActivityCommonStoreDlg:_onClickClose(...)
	self:setVisible(false)
end

return ActivityCommonStoreDlg
