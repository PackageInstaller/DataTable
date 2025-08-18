-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ClanClear\\ClanClearEventsDlg.lua

local ResOpActClanBossEvent = require("ClientData/ResOpActClanBossEvent")
local ClanClearEventCell = Class("ClanClearEventCell", UIControls.Child)

function ClanClearEventCell:ctor()
	self.textDesc = UIControls.Label(self, "Text")
end

function ClanClearEventCell:setData(eventId)
	local eventData = ResOpActClanBossEvent[eventId] or {}

	self.textDesc:setText(eventData.desc or "")
end

local strClassName = "ClanClearEventsDlg"
local ClanClearEventsDlg = Class(strClassName, UIControls.Window)

function ClanClearEventsDlg:ctor()
	self:initUI()
end

function ClanClearEventsDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.textAddScore = UIControls.Label(self, "BgPanel/YesterdayEventPanel/TxtNum")
	self.clanEventsCells = {}
	self.panelNone = UIControls.Panel(self, "BgPanel/ImgNone")
end

function ClanClearEventsDlg:onCloseClick()
	self:setVisible(false)
end

function ClanClearEventsDlg:onShow(events, actObj)
	self.events = events
	self.cellPath = "System/Activity/ActMayDayEventCell"

	if actObj.clientTemplateData and actObj.clientTemplateData.src_replace and actObj.clientTemplateData.src_replace[1] then
		self.cellPath = "System/Activity/" .. actObj.clientTemplateData.src_replace[1] .. "/ActMayDayEventCell"
	end

	if events and #events > 0 then
		self.panelNone:setVisible(false)

		for index, eventId in ipairs(events) do
			local targetCell = ClanClearEventCell(self, "BgPanel/EventList/Viewport/Content", self.cellPath)

			table.insert(self.clanEventsCells, targetCell)
			targetCell:setData(eventId)
			targetCell:setVisible(true)
		end

		local score = 0

		for _, eId in ipairs(events) do
			local eData = ResOpActClanBossEvent[eId]

			if eData and eData.add_abs then
				score = score + eData.add_abs
			end
		end

		self.textAddScore:setText(score)
	else
		self.panelNone:setVisible(true)
		self.textAddScore:setText(0)
	end
end

return ClanClearEventsDlg
