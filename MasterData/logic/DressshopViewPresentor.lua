-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressshopViewPresentor.lua

module("logic.extensions.dress.view.DressshopViewPresentor", package.seeall)

local DressshopViewPresentor = class("DressshopViewPresentor", ViewPresentor)

function DressshopViewPresentor:ctor()
	DressshopViewPresentor.super.ctor(self)
end

function DressshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DressshopViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/dressshopview.prefab"
	}
end

function DressshopViewPresentor:buildViews()
	return {
		DressshopView.New()
	}
end

function DressshopViewPresentor:getTempResources()
	local avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)

	return avatarMo:getAssetsList(AvatarUseType.UI)
end

function DressshopViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DressshopViewPresentor
