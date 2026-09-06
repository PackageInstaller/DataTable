-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleextViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattleextViewPresentor", package.seeall)

local GlorybattleextViewPresentor = class("GlorybattleextViewPresentor", ViewPresentor)

function GlorybattleextViewPresentor:ctor()
	GlorybattleextViewPresentor.super.ctor(self)
end

function GlorybattleextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattleextViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattleextview.prefab"
	}
end

function GlorybattleextViewPresentor:buildViews()
	return {
		GlorybattleextView.New()
	}
end

return GlorybattleextViewPresentor
