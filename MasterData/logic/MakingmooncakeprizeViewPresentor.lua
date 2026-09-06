-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingmooncakeprizeViewPresentor.lua

module("logic.extensions.makingmooncake.view.MakingmooncakeprizeViewPresentor", package.seeall)

local MakingmooncakeprizeViewPresentor = class("MakingmooncakeprizeViewPresentor", ViewPresentor)

function MakingmooncakeprizeViewPresentor:ctor()
	MakingmooncakeprizeViewPresentor.super.ctor(self)
end

function MakingmooncakeprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MakingmooncakeprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/makingmooncake/makingmooncakeprizeview.prefab"
	}
end

function MakingmooncakeprizeViewPresentor:buildViews()
	return {
		MakingMoonCakePrizeView.New()
	}
end

return MakingmooncakeprizeViewPresentor
