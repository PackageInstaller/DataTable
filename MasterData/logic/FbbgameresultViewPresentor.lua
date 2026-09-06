-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbgameresultViewPresentor.lua

module("logic.extensions.fbbchallenge.view.FbbgameresultViewPresentor", package.seeall)

local FbbgameresultViewPresentor = class("FbbgameresultViewPresentor", ViewPresentor)

function FbbgameresultViewPresentor:ctor()
	FbbgameresultViewPresentor.super.ctor(self)
end

function FbbgameresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FbbgameresultViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbgameresultview.prefab"
	}
end

function FbbgameresultViewPresentor:buildViews()
	return {
		FbbgameresultView.New()
	}
end

function FbbgameresultViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return FbbgameresultViewPresentor
