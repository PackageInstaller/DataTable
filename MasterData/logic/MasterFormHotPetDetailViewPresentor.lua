-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormHotPetDetailViewPresentor.lua

module("logic.extensions.masterform.view.MasterFormHotPetDetailViewPresentor", package.seeall)

local MasterFormHotPetDetailViewPresentor = class("MasterFormHotPetDetailViewPresentor", ViewPresentor)

function MasterFormHotPetDetailViewPresentor:ctor()
	MasterFormHotPetDetailViewPresentor.super.ctor(self)
end

function MasterFormHotPetDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MasterFormHotPetDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/masterform/masterformhotpetdetailview.prefab"
	}
end

function MasterFormHotPetDetailViewPresentor:buildViews()
	return {
		MasterFormHotPetDetailView.New()
	}
end

return MasterFormHotPetDetailViewPresentor
