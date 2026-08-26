-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianRewardViewContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardViewContainer", package.seeall)

local YaXianRewardViewContainer = class("YaXianRewardViewContainer", BaseViewContainer)

function YaXianRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, YaXianRewardView.New())

	return views
end

function YaXianRewardViewContainer:buildTabViews(tabContainerId)
	return
end

function YaXianRewardViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)
end

return YaXianRewardViewContainer
