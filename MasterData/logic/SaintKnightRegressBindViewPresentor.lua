-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressBindViewPresentor.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressBindViewPresentor", package.seeall)

local SaintKnightRegressBindViewPresentor = class("SaintKnightRegressBindViewPresentor", ViewPresentor)

function SaintKnightRegressBindViewPresentor:ctor()
	SaintKnightRegressBindViewPresentor.super.ctor(self)
end

function SaintKnightRegressBindViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SaintKnightRegressBindViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightregress/saintknightregressbindview.prefab"
	}
end

function SaintKnightRegressBindViewPresentor:buildViews()
	return {
		SaintKnightRegressBindView.New()
	}
end

return SaintKnightRegressBindViewPresentor
