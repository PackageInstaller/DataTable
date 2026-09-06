-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/cutepet/CutePetTaskChildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.cutepet.CutePetTaskChildViewPresentor", package.seeall)

local CutePetTaskChildViewPresentor = class("CutePetTaskChildViewPresentor", ViewPresentor)

function CutePetTaskChildViewPresentor:ctor()
	CutePetTaskChildViewPresentor.super.ctor(self)
end

function CutePetTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutePetTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/cutepet/cutepettaskchildview.prefab"
	}
end

function CutePetTaskChildViewPresentor:buildViews()
	return {
		CutePetTaskChildView.New()
	}
end

function CutePetTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetTaskChildViewPresentor
