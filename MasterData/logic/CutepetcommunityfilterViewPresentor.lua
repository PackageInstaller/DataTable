-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetcommunityfilterViewPresentor.lua

module("logic.extensions.cutepet.view.CutepetcommunityfilterViewPresentor", package.seeall)

local CutepetcommunityfilterViewPresentor = class("CutepetcommunityfilterViewPresentor", ViewPresentor)

function CutepetcommunityfilterViewPresentor:ctor()
	CutepetcommunityfilterViewPresentor.super.ctor(self)
end

function CutepetcommunityfilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CutepetcommunityfilterViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetcommunityfilterview.prefab"
	}
end

function CutepetcommunityfilterViewPresentor:buildViews()
	return {
		CutepetcommunityfilterView.New()
	}
end

return CutepetcommunityfilterViewPresentor
