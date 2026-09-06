-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseprizePresentor.lua

module("logic.extensions.pigraise.view.PigraiseprizePresentor", package.seeall)

local PigraiseprizePresentor = class("PigraiseprizePresentor", ViewPresentor)

function PigraiseprizePresentor:ctor()
	PigraiseprizePresentor.super.ctor(self)
end

function PigraiseprizePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigraiseprizePresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigraiseprizeview.prefab"
	}
end

function PigraiseprizePresentor:buildViews()
	return {
		PigraiseprizeView.New()
	}
end

return PigraiseprizePresentor
