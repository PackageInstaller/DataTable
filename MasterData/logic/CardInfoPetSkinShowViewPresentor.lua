-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/CardInfoPetSkinShowViewPresentor.lua

module("logic.extensions.roleinfo.view.CardInfoPetSkinShowViewPresentor", package.seeall)

local CardInfoPetSkinShowViewPresentor = class("CardInfoPetSkinShowViewPresentor", ViewPresentor)

function CardInfoPetSkinShowViewPresentor:ctor()
	CardInfoPetSkinShowViewPresentor.super.ctor(self)
end

function CardInfoPetSkinShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CardInfoPetSkinShowViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/cardinfopetskinshowview.prefab"
	}
end

function CardInfoPetSkinShowViewPresentor:buildViews()
	return {
		CardInfoPetSkinShowView.New()
	}
end

return CardInfoPetSkinShowViewPresentor
