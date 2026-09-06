-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Monthcardback2024ViewPresentor.lua

module("logic.extensions.monthcard.view.Monthcardback2024ViewPresentor", package.seeall)

local Monthcardback2024ViewPresentor = class("Monthcardback2024ViewPresentor", ViewPresentor)

function Monthcardback2024ViewPresentor:ctor()
	Monthcardback2024ViewPresentor.super.ctor(self)
end

function Monthcardback2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Monthcardback2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardback2024view.prefab"
	}
end

function Monthcardback2024ViewPresentor:buildViews()
	return {
		Monthcardback2024View.New()
	}
end

function Monthcardback2024ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Monthcardback2024ViewPresentor
