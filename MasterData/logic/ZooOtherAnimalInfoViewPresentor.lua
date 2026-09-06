-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooOtherAnimalInfoViewPresentor.lua

module("logic.extensions.zoo.view.ZooOtherAnimalInfoViewPresentor", package.seeall)

local ZooOtherAnimalInfoViewPresentor = class("ZooOtherAnimalInfoViewPresentor", ViewPresentor)

function ZooOtherAnimalInfoViewPresentor:ctor()
	ZooOtherAnimalInfoViewPresentor.super.ctor(self)
end

function ZooOtherAnimalInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooOtherAnimalInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoootheranimalinfoview.prefab"
	}
end

function ZooOtherAnimalInfoViewPresentor:buildViews()
	return {
		ZooOtherAnimalInfoView.New()
	}
end

return ZooOtherAnimalInfoViewPresentor
