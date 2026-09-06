-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectunlockViewPresentor.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectunlockViewPresentor", package.seeall)

local JigsawcollectunlockViewPresentor = class("JigsawcollectunlockViewPresentor", ViewPresentor)

function JigsawcollectunlockViewPresentor:ctor()
	JigsawcollectunlockViewPresentor.super.ctor(self)
end

function JigsawcollectunlockViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JigsawcollectunlockViewPresentor:dependWhatResources()
	return {
		"ui/views/jigsawcollect/jigsawcollectunlockview.prefab"
	}
end

function JigsawcollectunlockViewPresentor:buildViews()
	return {
		JigsawcollectunlockView.New()
	}
end

return JigsawcollectunlockViewPresentor
