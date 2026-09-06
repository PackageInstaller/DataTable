-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectmainViewPresentor.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectmainViewPresentor", package.seeall)

local JigsawcollectmainViewPresentor = class("JigsawcollectmainViewPresentor", ViewPresentor)

function JigsawcollectmainViewPresentor:ctor()
	JigsawcollectmainViewPresentor.super.ctor(self)
end

function JigsawcollectmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JigsawcollectmainViewPresentor:dependWhatResources()
	return {
		"ui/views/jigsawcollect/jigsawcollectmainview.prefab"
	}
end

function JigsawcollectmainViewPresentor:buildViews()
	return {
		JigsawcollectmainView.New()
	}
end

return JigsawcollectmainViewPresentor
