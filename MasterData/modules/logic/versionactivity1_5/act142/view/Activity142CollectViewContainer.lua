-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142CollectViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142CollectViewContainer", package.seeall)

local Activity142CollectViewContainer = class("Activity142CollectViewContainer", BaseViewContainer)

function Activity142CollectViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity142CollectView.New())

	return views
end

function Activity142CollectViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Activity142CollectViewContainer
