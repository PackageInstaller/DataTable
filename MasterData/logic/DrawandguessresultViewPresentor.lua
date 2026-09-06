-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessresultViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessresultViewPresentor", package.seeall)

local DrawandguessresultViewPresentor = class("DrawandguessresultViewPresentor", ViewPresentor)

function DrawandguessresultViewPresentor:ctor()
	DrawandguessresultViewPresentor.super.ctor(self)
end

function DrawandguessresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DrawandguessresultViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessresultview.prefab"
	}
end

function DrawandguessresultViewPresentor:buildViews()
	return {
		DrawandguessresultView.New()
	}
end

function DrawandguessresultViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.DrawandguessresultView)
end

return DrawandguessresultViewPresentor
