-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyEventDlg.lua

local strClassName = "ActivityMonopolyEventDlg"
local ActivityMonopolyEventDlg = Class(strClassName, UIControls.Window)
local MAX_EVENT_NUM = 6

function ActivityMonopolyEventDlg:ctor()
	self.balls = {}

	for index = 1, MAX_EVENT_NUM do
		local newBall = UIControls.Panel(self, "ShowPanel/Bg/IconBall" .. index)

		table.insert(self.balls, newBall)
	end

	self.btnStart = UIControls.Button(self, "ShowPanel/Bg/BtnStart")

	self.btnStart:addEventClick(self.onBtnStart)

	self.iconBg = UIControls.Image(self, "BgPanel/Bg")
	self.textTitle = UIControls.Label(self, "BgPanel/Bg/TextTitle")
	self.textDesc = UIControls.Label(self, "BgPanel/Bg/TextContent")
	self.iconEvent = UIControls.Image(self, "BgPanel/Bg/IconEvent")
end

function ActivityMonopolyEventDlg:onShow(eventData, desc, eventNum, closeCb)
	self.textTitle:setText(eventData.title or "")

	if eventData.icon then
		self.iconEvent:setImage("Atlas/" .. eventData.icon_path, eventData.icon)
	end

	self.textDesc:setText(desc)

	self.eventClose = closeCb

	for index, ball in ipairs(self.balls) do
		ball:setVisible(index <= eventNum)
	end

	if eventData.bg_icon_path then
		self.iconBg:setImage("Atlas/" .. eventData.bg_icon_path, eventData.bg_icon)
	end
end

function ActivityMonopolyEventDlg:onBtnStart()
	self:playAni("ShowActivityMonopolyRandomResult", nil, true)
end

return ActivityMonopolyEventDlg
