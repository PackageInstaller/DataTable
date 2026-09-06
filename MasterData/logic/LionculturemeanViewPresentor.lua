-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturemeanViewPresentor.lua

module("logic.extensions.lionculture.view.LionculturemeanViewPresentor", package.seeall)

local LionculturemeanViewPresentor = class("LionculturemeanViewPresentor", ViewPresentor)

function LionculturemeanViewPresentor:ctor()
	LionculturemeanViewPresentor.super.ctor(self)
end

function LionculturemeanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LionculturemeanViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lionculturemeanview.prefab"
	}
end

function LionculturemeanViewPresentor:buildViews()
	return {
		LionculturemeanView.New()
	}
end

return LionculturemeanViewPresentor
