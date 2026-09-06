-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglibossViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglibossViewPresentor", package.seeall)

local MimenglibossViewPresentor = class("MimenglibossViewPresentor", ViewPresentor)

function MimenglibossViewPresentor:ctor()
	MimenglibossViewPresentor.super.ctor(self)
end

function MimenglibossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglibossViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglibossview.prefab"
	}
end

function MimenglibossViewPresentor:buildViews()
	return {
		MimenglibossView.New()
	}
end

function MimenglibossViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MimenglibossViewPresentor
