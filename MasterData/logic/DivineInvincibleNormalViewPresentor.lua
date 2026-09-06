-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleNormalViewPresentor.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleNormalViewPresentor", package.seeall)

local DivineInvincibleNormalViewPresentor = class("DivineInvincibleNormalViewPresentor", ViewPresentor)

function DivineInvincibleNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineInvincibleNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinvincible/divineinvinciblenormalview.prefab"
	}
end

function DivineInvincibleNormalViewPresentor:buildViews()
	return {
		DivineInvincibleNormalView.New()
	}
end

return DivineInvincibleNormalViewPresentor
