-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/copy/NewerafantianchallengemainViewPresentor.lua

module("logic.extensions.yuhuichallenge.view.copy.NewerafantianchallengemainViewPresentor", package.seeall)

local NewerafantianchallengemainViewPresentor = class("NewerafantianchallengemainViewPresentor", ViewPresentor)

function NewerafantianchallengemainViewPresentor:ctor()
	NewerafantianchallengemainViewPresentor.super.ctor(self)
end

function NewerafantianchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewerafantianchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/yuhuichallenge/copy/newerafantianchallengemainview.prefab"
	}
end

function NewerafantianchallengemainViewPresentor:buildViews()
	return {
		NewerafantianchallengemainView.New()
	}
end

return NewerafantianchallengemainViewPresentor
