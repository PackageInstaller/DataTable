-- chunkname: @modules/logic/activitywelfare/view/NewWelfarePanelContainer.lua

module("modules.logic.activitywelfare.view.NewWelfarePanelContainer", package.seeall)

local NewWelfarePanelContainer = class("NewWelfarePanelContainer", BaseViewContainer)

function NewWelfarePanelContainer:buildViews()
	local views = {}

	table.insert(views, NewWelfarePanel.New())

	return views
end

function NewWelfarePanelContainer:onContainerClickModalMask()
	self:closeThis()
end

return NewWelfarePanelContainer
