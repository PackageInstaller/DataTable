-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiBuffDescViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiBuffDescViewPresentor", package.seeall)

local DivineJiBuffDescViewPresentor = class("DivineJiBuffDescViewPresentor", ViewPresentor)

function DivineJiBuffDescViewPresentor:ctor()
	DivineJiBuffDescViewPresentor.super.ctor(self)
end

function DivineJiBuffDescViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineJiBuffDescViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejibuffdescview.prefab"
	}
end

function DivineJiBuffDescViewPresentor:buildViews()
	return {
		DivineJiBuffDescView.New()
	}
end

return DivineJiBuffDescViewPresentor
