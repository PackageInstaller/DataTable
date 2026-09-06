-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseeventPresentor.lua

module("logic.extensions.pigraise.view.PigraiseeventPresentor", package.seeall)

local PigraiseeventPresentor = class("PigraiseeventPresentor", ViewWithGuidePresentor)

function PigraiseeventPresentor:ctor()
	PigraiseeventPresentor.super.ctor(self)
end

function PigraiseeventPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PigraiseeventPresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigraiseeventview.prefab"
	}
end

function PigraiseeventPresentor:buildViews()
	return {
		PigraiseeventView.New()
	}
end

return PigraiseeventPresentor
