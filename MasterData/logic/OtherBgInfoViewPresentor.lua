-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/view/OtherBgInfoViewPresentor.lua

module("logic.extensions.battlestartanim.view.OtherBgInfoViewPresentor", package.seeall)

local OtherBgInfoViewPresentor = class("OtherBgInfoViewPresentor", ViewPresentor)

function OtherBgInfoViewPresentor:ctor()
	OtherBgInfoViewPresentor.super.ctor(self)
end

function OtherBgInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OtherBgInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/otherbginfoview.prefab"
	}
end

function OtherBgInfoViewPresentor:buildViews()
	return {
		OtherBgInfoView.New()
	}
end

return OtherBgInfoViewPresentor
