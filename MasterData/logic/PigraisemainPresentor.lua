-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraisemainPresentor.lua

module("logic.extensions.pigraise.view.PigraisemainPresentor", package.seeall)

local PigraisemainPresentor = class("PigraisemainPresentor", ViewWithGuidePresentor)

function PigraisemainPresentor:ctor()
	PigraisemainPresentor.super.ctor(self)
end

function PigraisemainPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigraisemainPresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigraisemainview.prefab"
	}
end

function PigraisemainPresentor:getTempResources()
	return {
		GameUrl.getSpineUrl("30003_pet_shoutao")
	}
end

function PigraisemainPresentor:buildViews()
	return {
		PigraisemainView.New()
	}
end

return PigraisemainPresentor
