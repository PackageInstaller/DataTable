-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyBadLuckDlg.lua

local strClassName = "ActivityMonopolyBadLuckDlg"
local ActivityMonopolyBadLuckDlg = Class(strClassName, UIControls.Window)

function ActivityMonopolyBadLuckDlg:ctor()
	self.textDesc = UIControls.Label(self, "Bg/TextDes")
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.iconEvent = UIControls.Image(self, "Bg/Icon")
end

function ActivityMonopolyBadLuckDlg:onShow(eventData, desc, closeCb)
	self.textTitle:setText(eventData.title or "")

	if eventData.icon then
		self.iconEvent:setImage("Atlas/" .. eventData.icon_path, eventData.icon)
	end

	self.textDesc:setText(desc)

	self.eventClose = closeCb
end

return ActivityMonopolyBadLuckDlg
