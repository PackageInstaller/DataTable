-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaohud/view/FuyaosigninbackupViewPresentor.lua

module("logic.extensions.fuyaohud.view.FuyaosigninbackupViewPresentor", package.seeall)

local FuyaosigninbackupViewPresentor = class("FuyaosigninbackupViewPresentor", ViewPresentor)

function FuyaosigninbackupViewPresentor:ctor()
	FuyaosigninbackupViewPresentor.super.ctor(self)
end

function FuyaosigninbackupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FuyaosigninbackupViewPresentor:dependWhatResources()
	return {
		"ui/views/fuyaohud/fuyaosigninbackupview.prefab"
	}
end

function FuyaosigninbackupViewPresentor:buildViews()
	return {
		FuyaosigninbackupView.New()
	}
end

return FuyaosigninbackupViewPresentor
