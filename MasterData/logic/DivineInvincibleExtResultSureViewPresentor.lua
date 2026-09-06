-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtResultSureViewPresentor.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtResultSureViewPresentor", package.seeall)

local DivineInvincibleExtResultSureViewPresentor = class("DivineInvincibleExtResultSureViewPresentor", ViewPresentor)

function DivineInvincibleExtResultSureViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineInvincibleExtResultSureViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinvincible/divineinvincibleextresultsureview.prefab"
	}
end

function DivineInvincibleExtResultSureViewPresentor:buildViews()
	return {
		DivineInvincibleExtResultSureView.New()
	}
end

return DivineInvincibleExtResultSureViewPresentor
