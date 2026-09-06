-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturefmtintroduceViewPresentor.lua

module("logic.extensions.lionculture.view.LionculturefmtintroduceViewPresentor", package.seeall)

local LionculturefmtintroduceViewPresentor = class("LionculturefmtintroduceViewPresentor", ViewPresentor)

function LionculturefmtintroduceViewPresentor:ctor()
	LionculturefmtintroduceViewPresentor.super.ctor(self)
end

function LionculturefmtintroduceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LionculturefmtintroduceViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lionculturefmtintroduceview.prefab"
	}
end

function LionculturefmtintroduceViewPresentor:buildViews()
	return {
		LionculturefmtintroduceView.New()
	}
end

return LionculturefmtintroduceViewPresentor
