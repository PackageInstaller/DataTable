-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneStoreShowViewContainer.lua

module("modules.logic.mainsceneswitch.view.MainSceneStoreShowViewContainer", package.seeall)

local MainSceneStoreShowViewContainer = class("MainSceneStoreShowViewContainer", BaseViewContainer)

function MainSceneStoreShowViewContainer:buildViews()
	local views = {}

	table.insert(views, MainSceneStoreShowView.New())

	return views
end

return MainSceneStoreShowViewContainer
