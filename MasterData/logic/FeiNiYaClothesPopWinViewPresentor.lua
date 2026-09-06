-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/feiniyaclothes/FeiNiYaClothesPopWinViewPresentor.lua

module("logic.extensions.spineinterface.view.feiniyaclothes.FeiNiYaClothesPopWinViewPresentor", package.seeall)

local FeiNiYaClothesPopWinViewPresentor = class("FeiNiYaClothesPopWinViewPresentor", ViewPresentor)

function FeiNiYaClothesPopWinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FeiNiYaClothesPopWinViewPresentor:dependWhatResources()
	return {
		"ui/views/spineinterface/feiniyaclothespopwinview.prefab"
	}
end

function FeiNiYaClothesPopWinViewPresentor:buildViews()
	return {
		FeiNiYaClothesPopWinView.New()
	}
end

function FeiNiYaClothesPopWinViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FeiNiYaClothesPopWinViewPresentor
