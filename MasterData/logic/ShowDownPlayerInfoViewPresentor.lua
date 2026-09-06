-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownPlayerInfoViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownPlayerInfoViewPresentor", package.seeall)

local ShowDownPlayerInfoViewPresentor = class("ShowDownPlayerInfoViewPresentor", ViewPresentor)

function ShowDownPlayerInfoViewPresentor:ctor()
	ShowDownPlayerInfoViewPresentor.super.ctor(self)
end

function ShowDownPlayerInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownPlayerInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownplayerinfoview.prefab"
	}
end

function ShowDownPlayerInfoViewPresentor:buildViews()
	return {
		ShowDownPlayerInfoView.New()
	}
end

function ShowDownPlayerInfoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function ShowDownPlayerInfoViewPresentor:setGrayMaskGO(grayMaskGO)
	ShowDownPlayerInfoViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return ShowDownPlayerInfoViewPresentor
