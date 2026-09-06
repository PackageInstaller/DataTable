-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/copy/NewerafantianchallengelevelViewPresentor.lua

module("logic.extensions.yuhuichallenge.view.copy.NewerafantianchallengelevelViewPresentor", package.seeall)

local NewerafantianchallengelevelViewPresentor = class("NewerafantianchallengelevelViewPresentor", ViewPresentor)

function NewerafantianchallengelevelViewPresentor:ctor()
	NewerafantianchallengelevelViewPresentor.super.ctor(self)
end

function NewerafantianchallengelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewerafantianchallengelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/yuhuichallenge/copy/newerafantianchallengelevelview.prefab"
	}
end

function NewerafantianchallengelevelViewPresentor:buildViews()
	return {
		NewerafantianchallengelevelView.New()
	}
end

return NewerafantianchallengelevelViewPresentor
