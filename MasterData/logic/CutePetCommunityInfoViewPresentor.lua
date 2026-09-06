-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/community/CutePetCommunityInfoViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetCommunityInfoViewPresentor", package.seeall)

local CutePetCommunityInfoViewPresentor = class("CutePetCommunityInfoViewPresentor", ViewPresentor)

function CutePetCommunityInfoViewPresentor:ctor()
	CutePetCommunityInfoViewPresentor.super.ctor(self)
end

function CutePetCommunityInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutePetCommunityInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetcommunityinfoview.prefab"
	}
end

function CutePetCommunityInfoViewPresentor:buildViews()
	return {
		CutePetCommunityInfoView.New()
	}
end

function CutePetCommunityInfoViewPresentor:onClickOutside()
	self:close()
end

return CutePetCommunityInfoViewPresentor
