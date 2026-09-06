-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenTrainViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenTrainViewPresentor", package.seeall)

local DragonAwakenTrainViewPresentor = class("DragonAwakenTrainViewPresentor", ViewPresentor)

function DragonAwakenTrainViewPresentor:ctor()
	DragonAwakenTrainViewPresentor.super.ctor(self)
end

function DragonAwakenTrainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenTrainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakentrainview.prefab"
	}
end

function DragonAwakenTrainViewPresentor:buildViews()
	return {
		DragonAwakenTrainView.New()
	}
end

return DragonAwakenTrainViewPresentor
