-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/NoteViewPresentor.lua

module("logic.extensions.timecapsule.view.NoteViewPresentor", package.seeall)

local NoteViewPresentor = class("NoteViewPresentor", ViewPresentor)

function NoteViewPresentor:ctor()
	NoteViewPresentor.super.ctor(self)
end

function NoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoteViewPresentor:dependWhatResources()
	return {
		"ui/views/timecapsule/noteview.prefab"
	}
end

function NoteViewPresentor:buildViews()
	return {
		NoteView.New()
	}
end

return NoteViewPresentor
