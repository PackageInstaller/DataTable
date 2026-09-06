-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/view/FuYaoPuzzlesViewPresentor.lua

module("logic.extensions.fuyao.view.FuYaoPuzzlesViewPresentor", package.seeall)

local FuYaoPuzzlesViewPresentor = class("FuYaoPuzzlesViewPresentor", ViewWithGuidePresentor)

function FuYaoPuzzlesViewPresentor:ctor()
	FuYaoPuzzlesViewPresentor.super.ctor(self)
end

function FuYaoPuzzlesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuYaoPuzzlesViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fuyao/fuyaopuzzlesview.prefab"
	}
end

function FuYaoPuzzlesViewPresentor:buildViews()
	return {
		FuYaoPuzzlesView.New()
	}
end

return FuYaoPuzzlesViewPresentor
