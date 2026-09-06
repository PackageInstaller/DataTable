-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureclassViewPresentor.lua

module("logic.extensions.lionculture.view.LioncultureclassViewPresentor", package.seeall)

local LioncultureclassViewPresentor = class("LioncultureclassViewPresentor", ViewPresentor)

function LioncultureclassViewPresentor:ctor()
	LioncultureclassViewPresentor.super.ctor(self)
end

function LioncultureclassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LioncultureclassViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lioncultureclassview.prefab"
	}
end

function LioncultureclassViewPresentor:buildViews()
	return {
		LioncultureclassView.New()
	}
end

return LioncultureclassViewPresentor
