-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkroomViewPresentor.lua

module("logic.extensions.pk.view.PkroomViewPresentor", package.seeall)

local PkroomViewPresentor = class("PkroomViewPresentor", ViewPresentor)

function PkroomViewPresentor:ctor()
	PkroomViewPresentor.super.ctor(self)
end

function PkroomViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PkroomViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkroomview.prefab"
	}
end

function PkroomViewPresentor:buildViews()
	return {
		PkroomView.New(),
		PkRoomChatView.New()
	}
end

return PkroomViewPresentor
