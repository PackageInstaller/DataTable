-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/copy/DivinefantianresultViewPresentor.lua

module("logic.extensions.femalepsychic.view.copy.DivinefantianresultViewPresentor", package.seeall)

local DivinefantianresultViewPresentor = class("DivinefantianresultViewPresentor", ViewPresentor)

function DivinefantianresultViewPresentor:ctor()
	DivinefantianresultViewPresentor.super.ctor(self)
end

function DivinefantianresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivinefantianresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/femalepsychic/copy/divinefantianresultview.prefab"
	}
end

function DivinefantianresultViewPresentor:buildViews()
	return {
		DivinefantianresultView.New()
	}
end

return DivinefantianresultViewPresentor
