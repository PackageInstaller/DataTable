-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/readyforwar/view/ReadyforwartreasureViewPresentor.lua

module("logic.extensions.readyforwar.view.ReadyforwartreasureViewPresentor", package.seeall)

local ReadyforwartreasureViewPresentor = class("ReadyforwartreasureViewPresentor", ViewPresentor)

function ReadyforwartreasureViewPresentor:ctor()
	ReadyforwartreasureViewPresentor.super.ctor(self)
end

function ReadyforwartreasureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ReadyforwartreasureViewPresentor:dependWhatResources()
	return {
		"ui/views/readyforwar/readyforwartreasureview.prefab"
	}
end

function ReadyforwartreasureViewPresentor:buildViews()
	return {
		ReadyforwartreasureView.New()
	}
end

return ReadyforwartreasureViewPresentor
