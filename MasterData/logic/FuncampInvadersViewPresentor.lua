-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampInvadersViewPresentor.lua

module("logic.extensions.funcamp.view.FuncampInvadersViewPresentor", package.seeall)

local FuncampInvadersViewPresentor = class("FuncampInvadersViewPresentor", ViewPresentor)

function FuncampInvadersViewPresentor:ctor()
	FuncampInvadersViewPresentor.super.ctor(self)
end

function FuncampInvadersViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncampInvadersViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampinvadersview.prefab"
	}
end

function FuncampInvadersViewPresentor:buildViews()
	return {
		FuncampInvadersView.New()
	}
end

return FuncampInvadersViewPresentor
