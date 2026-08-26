-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianFindToothViewContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianFindToothViewContainer", package.seeall)

local YaXianFindToothViewContainer = class("YaXianFindToothViewContainer", BaseViewContainer)

function YaXianFindToothViewContainer:buildViews()
	local views = {}

	table.insert(views, YaXianFindToothView.New())

	return views
end

function YaXianFindToothViewContainer:buildTabViews(tabContainerId)
	return
end

function YaXianFindToothViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_multiple)
end

return YaXianFindToothViewContainer
