-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyGoodLuckDlg.lua

local strClassName = "ActivityMonopolyGoodLuckDlg"
local ActivityMonopolyGoodLuckDlg = Class(strClassName, UIControls.Window)
local MAX_EVENT_NUM = 6

function ActivityMonopolyGoodLuckDlg:ctor()
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.textDesc = UIControls.Label(self, "Bg/TextDes")
	self.iconEvent = UIControls.Image(self, "Bg/Icon")
end

function ActivityMonopolyGoodLuckDlg:onShow(eventData, desc, closeCb)
	self.textTitle:setText(eventData.title or "")

	if eventData.icon then
		self.iconEvent:setImage("Atlas/" .. eventData.icon_path, eventData.icon)
	end

	self.textDesc:setText(desc)

	self.eventClose = closeCb
end

return ActivityMonopolyGoodLuckDlg
