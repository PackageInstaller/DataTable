-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanprotocolViewPresentor.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanprotocolViewPresentor", package.seeall)

local DivinewatertianyanprotocolViewPresentor = class("DivinewatertianyanprotocolViewPresentor", ViewPresentor)

function DivinewatertianyanprotocolViewPresentor:ctor()
	DivinewatertianyanprotocolViewPresentor.super.ctor(self)
end

function DivinewatertianyanprotocolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinewatertianyanprotocolViewPresentor:dependWhatResources()
	return {
		"ui/views/divinewatertianyan/divinewatertianyanprotocolview.prefab"
	}
end

function DivinewatertianyanprotocolViewPresentor:buildViews()
	return {
		DivinewatertianyanprotocolView.New()
	}
end

return DivinewatertianyanprotocolViewPresentor
