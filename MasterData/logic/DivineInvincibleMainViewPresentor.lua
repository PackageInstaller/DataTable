-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleMainViewPresentor.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleMainViewPresentor", package.seeall)

local DivineInvincibleMainViewPresentor = class("DivineInvincibleMainViewPresentor", ViewPresentor)

function DivineInvincibleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineInvincibleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinvincible/divineinvinciblemainview.prefab"
	}
end

function DivineInvincibleMainViewPresentor:buildViews()
	return {
		DivineInvincibleMainView.New()
	}
end

return DivineInvincibleMainViewPresentor
