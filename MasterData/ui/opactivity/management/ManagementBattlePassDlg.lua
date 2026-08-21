-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Management\\ManagementBattlePassDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityBPListPanel = require("UI/OpActivity/ActivityBPListPanel")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local classNameStr = "ManagementBattlePassDlg"
local ManagementBattlePassDlg = Class(classNameStr, UIControls.Window)

MixinClass(ManagementBattlePassDlg, ActivityPanelMixin)

function ManagementBattlePassDlg:ctor()
	if UIControls.checkControlFunc(self, "BgPanel/Bg4") then
		self.imgBg4 = UIControls.Image(self, "BgPanel/Bg4")
	end

	if UIControls.checkControlFunc(self, "BgPanel/Bg5") then
		self.imgBg5 = UIControls.Image(self, "BgPanel/Bg5")
	end
end

function ManagementBattlePassDlg:onClose()
	ManagementBattlePassDlg.super.onClose(self)

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:refreshPermissionEffect()
	end
end

function ManagementBattlePassDlg:_setData()
	self.actId = self.actObj.actId
	self.tabData = {
		ResOpActivityClientTemplate[self.actId],
		self.actObj
	}

	local prefabPath = self.clientTemplateData.sub_template_args[1]

	self.page = ActivityBPListPanel(self, "InfoPanel", "System/Activity/" .. prefabPath, 0, 0, true)

	self.page:onShowActivity(self.tabData)

	if self.replaceableCellPath and self.replaceableCellPath[4] then
		local url = "Atlas/" .. self.replaceableCellPath[4]

		if self.imgBg4 then
			self.imgBg4:setImage(url, "BgDecorate")
		end

		if self.imgBg5 then
			self.imgBg5:setImage(url, "TxtTitle")
		end
	end
end

function ManagementBattlePassDlg:updateActivityData(actObj)
	self.page:onActivityDataRefresh(actObj)
end

function ManagementBattlePassDlg:setOnlyFastReceive(value)
	self.page:setOnlyFastReceive(true)
end

return ManagementBattlePassDlg
