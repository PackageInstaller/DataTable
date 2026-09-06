-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtremeViewPresentor.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtremeViewPresentor", package.seeall)

local DivineInvincibleExtremeViewPresentor = class("DivineInvincibleExtremeViewPresentor", ViewPresentor)

function DivineInvincibleExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineInvincibleExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinvincible/divineinvincibleextremeview.prefab"
	}
end

function DivineInvincibleExtremeViewPresentor:buildViews()
	return {
		DivineInvincibleExtremeView.New()
	}
end

return DivineInvincibleExtremeViewPresentor
