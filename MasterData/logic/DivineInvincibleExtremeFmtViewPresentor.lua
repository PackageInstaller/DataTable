-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtremeFmtViewPresentor.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtremeFmtViewPresentor", package.seeall)

local DivineInvincibleExtremeFmtViewPresentor = class("DivineInvincibleExtremeFmtViewPresentor", ViewPresentor)

function DivineInvincibleExtremeFmtViewPresentor:ctor()
	DivineInvincibleExtremeFmtViewPresentor.super.ctor(self)
end

function DivineInvincibleExtremeFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineInvincibleExtremeFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinvincible/divineinvincibleextremefmtview.prefab"
	}
end

function DivineInvincibleExtremeFmtViewPresentor:buildViews()
	return {
		DivineInvincibleExtremeFmtView.New()
	}
end

return DivineInvincibleExtremeFmtViewPresentor
