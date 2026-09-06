-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkFormationselectViewPresentor.lua

module("logic.extensions.pk.view.PkFormationselectViewPresentor", package.seeall)

local PkFormationselectViewPresentor = class("PkFormationselectViewPresentor", ViewPresentor)

function PkFormationselectViewPresentor:ctor()
	PkFormationselectViewPresentor.super.ctor(self)
end

function PkFormationselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PkFormationselectViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkformationselectview.prefab"
	}
end

function PkFormationselectViewPresentor:buildViews()
	return {
		PkFormationselectView.New()
	}
end

return PkFormationselectViewPresentor
