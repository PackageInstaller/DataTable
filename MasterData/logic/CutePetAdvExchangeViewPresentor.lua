-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdvExchangeViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetAdvExchangeViewPresentor", package.seeall)

local CutePetAdvExchangeViewPresentor = class("CutePetAdvExchangeViewPresentor", ViewPresentor)

function CutePetAdvExchangeViewPresentor:ctor()
	CutePetAdvExchangeViewPresentor.super.ctor(self)
end

function CutePetAdvExchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetAdvExchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetadvexchangeview.prefab"
	}
end

function CutePetAdvExchangeViewPresentor:buildViews()
	return {
		CutePetAdvExchangeView.New()
	}
end

return CutePetAdvExchangeViewPresentor
