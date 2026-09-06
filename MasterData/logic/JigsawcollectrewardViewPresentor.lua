-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectrewardViewPresentor.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectrewardViewPresentor", package.seeall)

local JigsawcollectrewardViewPresentor = class("JigsawcollectrewardViewPresentor", ViewPresentor)

function JigsawcollectrewardViewPresentor:ctor()
	JigsawcollectrewardViewPresentor.super.ctor(self)
end

function JigsawcollectrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JigsawcollectrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/jigsawcollect/jigsawcollectrewardview.prefab"
	}
end

function JigsawcollectrewardViewPresentor:buildViews()
	return {
		JigsawcollectrewardView.New()
	}
end

return JigsawcollectrewardViewPresentor
