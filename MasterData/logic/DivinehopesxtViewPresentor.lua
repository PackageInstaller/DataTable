-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopesxtViewPresentor.lua

module("logic.extensions.divinehope.view.DivinehopesxtViewPresentor", package.seeall)

local DivinehopesxtViewPresentor = class("DivinehopesxtViewPresentor", ViewPresentor)

function DivinehopesxtViewPresentor:ctor()
	DivinehopesxtViewPresentor.super.ctor(self)
end

function DivinehopesxtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinehopesxtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehope/divinehopesxtview.prefab"
	}
end

function DivinehopesxtViewPresentor:buildViews()
	return {
		DivinehopesxtView.New()
	}
end

return DivinehopesxtViewPresentor
