-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdPetChildRankViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdPetChildRankViewPresentor", package.seeall)

local YouthArenaThirdPetChildRankViewPresentor = class("YouthArenaThirdPetChildRankViewPresentor", ViewPresentor)

function YouthArenaThirdPetChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdPetChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/youtharenathirdpetchildrankview.prefab"
	}
end

function YouthArenaThirdPetChildRankViewPresentor:buildViews()
	return {
		YouthArenaThirdPetChildRankView.New()
	}
end

function YouthArenaThirdPetChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YouthArenaThirdPetChildRankViewPresentor
