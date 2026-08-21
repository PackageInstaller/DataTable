-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\ConfirmNotice.lua

local strClassName = "ConfirmNotice"
local ResClientHardCode = require("ClientData/ResClientHardCode")
local UserData = require("Helper/UserData")
local VersionUtils = require("System/VersionUtils")
local ConfirmNotice = Class(strClassName, UIControls.Window)

function ConfirmNotice:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:setVisible(false)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.txtContent = UIControls.Label(self, "BgPanel/NoticeList/Content/TextContent")
	self.txtTitle = UIControls.Label(self, "BgPanel/NoticeList/Content/TextTitle")

	self.txtTitle:setVisible(false)

	self.confirmText = UIControls.Label(self, "BgPanel/BtnConfirm/Text")
end

function ConfirmNotice:show()
	local msg = ResClientHardCode[15] and ResClientHardCode[15].desc[1] or nil

	if VersionUtils.IsJPOpreateChangeVersion() then
		msg = RemoteConfig.getValue(Const.REMOTE_CONFIG_KEY_TIPS_TEXT)
	end

	self.txtContent:setText(msg)
	self.confirmText:setText(Lang.get(69997))

	if VersionUtils.IsReviewVersion() then
		self:setVisible(false)

		return
	end

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function ConfirmNotice:onConfirmClick(sender)
	local operateChangeTipsJP = UserData.loadCommonData("operateChangeTipsJP")

	if operateChangeTipsJP ~= "showed" then
		UserData.saveCommonData("operateChangeTipsJP", "showed")
	end

	self:setVisible(false)
end

return ConfirmNotice
