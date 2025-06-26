-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformanceHelper.lua

local m = {}
local ScreenHelper = require("IQIGame.UI.Dialog.DialogScreenPerformance")
local BackgroundHelper = require("IQIGame.UI.Dialog.DialogBackgroundPerformance")
local NPCHelper = require("IQIGame.UI.Dialog.DialogNPCPerformance")
local TextHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")

function m.New()
	local obj = Clone(m)

	obj.Screen = ScreenHelper.New()
	obj.Background = BackgroundHelper.New()
	obj.NPC = NPCHelper.New()
	obj.Text = TextHelper.New()

	return obj
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.Screen:Update(elapseSeconds, realElapseSeconds)
	self.Background:Update(elapseSeconds, realElapseSeconds)
	self.NPC:Update(elapseSeconds, realElapseSeconds)
	self.Text:Update(elapseSeconds, realElapseSeconds)
end

return m
