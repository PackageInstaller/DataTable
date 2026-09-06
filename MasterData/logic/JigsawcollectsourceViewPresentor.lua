-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectsourceViewPresentor.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectsourceViewPresentor", package.seeall)

local JigsawcollectsourceViewPresentor = class("JigsawcollectsourceViewPresentor", ViewPresentor)

function JigsawcollectsourceViewPresentor:ctor()
	JigsawcollectsourceViewPresentor.super.ctor(self)
end

function JigsawcollectsourceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JigsawcollectsourceViewPresentor:dependWhatResources()
	return {
		"ui/views/jigsawcollect/jigsawcollectsourceview.prefab"
	}
end

function JigsawcollectsourceViewPresentor:buildViews()
	return {
		JigsawcollectsourceView.New()
	}
end

return JigsawcollectsourceViewPresentor
