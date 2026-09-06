-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petstrategy/view/PetstrategyViewPresentor.lua

module("logic.extensions.petstrategy.view.PetstrategyViewPresentor", package.seeall)

local PetstrategyViewPresentor = class("PetstrategyViewPresentor", ViewPresentor)

function PetstrategyViewPresentor:ctor()
	PetstrategyViewPresentor.super.ctor(self)
end

function PetstrategyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetstrategyViewPresentor:dependWhatResources()
	return {
		"ui/views/petstrategy/petstrategyview.prefab"
	}
end

function PetstrategyViewPresentor:buildViews()
	return {
		PetStrategyView.New()
	}
end

return PetstrategyViewPresentor
