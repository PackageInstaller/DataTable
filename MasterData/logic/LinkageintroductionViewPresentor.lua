-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkageintroductionViewPresentor.lua

module("logic.extensions.linkageintroduction.view.LinkageintroductionViewPresentor", package.seeall)

local LinkageintroductionViewPresentor = class("LinkageintroductionViewPresentor", ViewPresentor)

function LinkageintroductionViewPresentor:ctor()
	LinkageintroductionViewPresentor.super.ctor(self)
end

function LinkageintroductionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkageintroductionViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageintroduction/linkageintroductionview.prefab"
	}
end

function LinkageintroductionViewPresentor:buildViews()
	return {
		LinkageintroductionView.New()
	}
end

return LinkageintroductionViewPresentor
