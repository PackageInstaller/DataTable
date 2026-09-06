-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooMainViewPresentor.lua

module("logic.extensions.zoo.view.ZooMainViewPresentor", package.seeall)

local ZooMainViewPresentor = class("ZooMainViewPresentor", ViewWithGuidePresentor)

function ZooMainViewPresentor:ctor()
	ZooMainViewPresentor.super.ctor(self)
end

function ZooMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZooMainViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoomainview.prefab"
	}
end

function ZooMainViewPresentor:buildViews()
	return {
		ZooMainView.New(),
		MainChatView.New()
	}
end

return ZooMainViewPresentor
