-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemRelieveViewPresentor.lua

module("logic.extensions.tutorsystem.view.TutorSystemRelieveViewPresentor", package.seeall)

local TutorSystemRelieveViewPresentor = class("TutorSystemRelieveViewPresentor", ViewPresentor)

function TutorSystemRelieveViewPresentor:ctor()
	TutorSystemRelieveViewPresentor.super.ctor(self)
end

function TutorSystemRelieveViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TutorSystemRelieveViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/tutorsystemrelieveview.prefab"
	}
end

function TutorSystemRelieveViewPresentor:buildViews()
	return {
		TutorSystemRelieveView.New()
	}
end

return TutorSystemRelieveViewPresentor
