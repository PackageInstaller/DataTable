-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\InfoNoticeBox.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local strClassName = "InfoNoticeBox"
local InfoNoticeBox = Class(strClassName, UIControls.Window)

function InfoNoticeBox:ctor()
	self:initUI()
end

function InfoNoticeBox:initUI()
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.textContent = UIControls.Label(self, "BgPanel/TextRule")
	self.panelScroll = UIControls.Panel(self, "BgPanel/ScrollView")
	self.textScroll = UIControls.Label(self, "BgPanel/ScrollView/Content/TextRule")
end

function InfoNoticeBox:showSystemInfo(noticeId)
	if ResInfoNotice[noticeId] then
		self:showNotice(ResInfoNotice[noticeId].title or Lang.get(147), ResInfoNotice[noticeId].content or Lang.get(5), ResInfoNotice[noticeId].isScroll)
	else
		self:setVisible(false)
	end
end

function InfoNoticeBox:showSystemInfoByArgs(noticeId, ...)
	if ResInfoNotice[noticeId] then
		local content = ResInfoNotice[noticeId].content or Lang.get(5)

		content = string.format(content, ...)

		self:showNotice(ResInfoNotice[noticeId].title or Lang.get(147), content, ResInfoNotice[noticeId].isScroll)
	else
		self:setVisible(false)
	end
end

function InfoNoticeBox:showNotice(title, content, showScroll)
	if not self:getVisible() then
		self:setVisible(true)
	end

	self.textTitle:setText(title)

	if showScroll == 1 then
		self.textContent:setVisible(false)
		self.panelScroll:setVisible(true)
		self.textScroll:setText(content)
	else
		self.textContent:setVisible(true)
		self.panelScroll:setVisible(false)
		self.textContent:setText(content)
	end
end

return InfoNoticeBox
