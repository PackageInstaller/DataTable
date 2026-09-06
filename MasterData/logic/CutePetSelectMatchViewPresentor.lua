-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSelectMatchViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetSelectMatchViewPresentor", package.seeall)

local CutePetSelectMatchViewPresentor = class("CutePetSelectMatchViewPresentor", ViewPresentor)

function CutePetSelectMatchViewPresentor:ctor()
	CutePetSelectMatchViewPresentor.super.ctor(self)
end

function CutePetSelectMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetSelectMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetselectmatchview.prefab"
	}
end

function CutePetSelectMatchViewPresentor:buildViews()
	return {
		CutePetSelectMatchView.New()
	}
end

return CutePetSelectMatchViewPresentor
