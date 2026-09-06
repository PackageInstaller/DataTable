-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectsecretctViewPresentor.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectsecretctViewPresentor", package.seeall)

local JigsawcollectsecretctViewPresentor = class("JigsawcollectsecretctViewPresentor", ViewPresentor)

function JigsawcollectsecretctViewPresentor:ctor()
	JigsawcollectsecretctViewPresentor.super.ctor(self)
end

function JigsawcollectsecretctViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JigsawcollectsecretctViewPresentor:dependWhatResources()
	return {
		"ui/views/jigsawcollect/jigsawcollectsecretctview.prefab"
	}
end

function JigsawcollectsecretctViewPresentor:buildViews()
	return {
		JigsawcollectsecretctView.New()
	}
end

return JigsawcollectsecretctViewPresentor
