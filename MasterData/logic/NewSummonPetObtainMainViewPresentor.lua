-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/NewSummonPetObtainMainViewPresentor.lua

module("logic.extensions.newsummonpetobtain.view.NewSummonPetObtainMainViewPresentor", package.seeall)

local NewSummonPetObtainMainViewPresentor = class("NewSummonPetObtainMainViewPresentor", ViewPresentor)

function NewSummonPetObtainMainViewPresentor:ctor()
	NewSummonPetObtainMainViewPresentor.super.ctor(self)
end

function NewSummonPetObtainMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewSummonPetObtainMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newsummonpetobtain/newsummonpetobtainmainview.prefab"
	}
end

function NewSummonPetObtainMainViewPresentor:buildViews()
	return {
		NewSummonPetObtainMainView.New()
	}
end

return NewSummonPetObtainMainViewPresentor
