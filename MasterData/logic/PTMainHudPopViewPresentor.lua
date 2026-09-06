-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/PTMainHudPopViewPresentor.lua

module("logic.extensions.peaktournament.view.common.PTMainHudPopViewPresentor", package.seeall)

local PTMainHudPopViewPresentor = class("PTMainHudPopViewPresentor", ViewPresentor)

function PTMainHudPopViewPresentor:ctor()
	PTMainHudPopViewPresentor.super.ctor(self)
end

function PTMainHudPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PTMainHudPopViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/common/ptmainhudpopview.prefab"
	}
end

function PTMainHudPopViewPresentor:buildViews()
	return {
		PTMainHudPopView.New()
	}
end

return PTMainHudPopViewPresentor
