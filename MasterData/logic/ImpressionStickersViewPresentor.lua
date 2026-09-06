-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/view/ImpressionStickersViewPresentor.lua

module("logic.extensions.impressionstickers.view.ImpressionStickersViewPresentor", package.seeall)

local ImpressionStickersViewPresentor = class("ImpressionStickersViewPresentor", ViewPresentor)

function ImpressionStickersViewPresentor:ctor()
	ImpressionStickersViewPresentor.super.ctor(self)
end

function ImpressionStickersViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImpressionStickersViewPresentor:dependWhatResources()
	return {
		"ui/views/impressionstickers/impressionstickersview.prefab"
	}
end

function ImpressionStickersViewPresentor:buildViews()
	return {
		ImpressionStickersView.New()
	}
end

return ImpressionStickersViewPresentor
