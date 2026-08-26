-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianCollectViewContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianCollectViewContainer", package.seeall)

local YaXianCollectViewContainer = class("YaXianCollectViewContainer", BaseViewContainer)

function YaXianCollectViewContainer:buildViews()
	local views = {}

	table.insert(views, YaXianCollectView.New())

	return views
end

function YaXianCollectViewContainer:buildTabViews(tabContainerId)
	return
end

function YaXianCollectViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)
end

return YaXianCollectViewContainer
