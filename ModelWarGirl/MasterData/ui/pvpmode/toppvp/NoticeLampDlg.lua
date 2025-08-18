-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\NoticeLampDlg.lua

local ResMarquee = require("ClientData/ResMarquee")
local strClassName = "NoticeLampDlg"
local NoticeLampDlg = Class(strClassName, UIControls.Window)

function NoticeLampDlg:ctor()
	self:initUI()
end

function NoticeLampDlg:initUI()
	self.icon = UIControls.Image(self, "NoticePanel/Icon")
	self.bg = UIControls.Image(self, "NoticePanel/Bg")
	self.txtBroadcast = UIControls.Label(self, "NoticePanel/TextBroadcast")
end

function NoticeLampDlg:show(id)
	local item = ResMarquee[id]

	if item == nil then
		return
	end

	self.txtBroadcast:setText(item.desc)

	if item.bg_name and item.bg_path then
		self.bg:setImage(item.bg_path, item.bg_name)
	end

	if item.icon_name and item.icon_path then
		self.icon:setImage(item.icon_path, item.icon_name)
	end

	if item.animator_name then
		self:playAni(item.animator_name, self.onAnimitionEnd, true)
	end
end

function NoticeLampDlg:onAnimitionEnd(...)
	self:setVisible(false)
end

return NoticeLampDlg
