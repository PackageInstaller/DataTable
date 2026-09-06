-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleteammgrViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattleteammgrViewPresentor", package.seeall)

local GlorybattleteammgrViewPresentor = class("GlorybattleteammgrViewPresentor", ViewPresentor)

function GlorybattleteammgrViewPresentor:ctor()
	GlorybattleteammgrViewPresentor.super.ctor(self)
end

function GlorybattleteammgrViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattleteammgrViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattleteammgrview.prefab"
	}
end

function GlorybattleteammgrViewPresentor:buildViews()
	return {
		GlorybattleteammgrView.New()
	}
end

return GlorybattleteammgrViewPresentor
