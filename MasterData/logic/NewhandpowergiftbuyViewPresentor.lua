-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandpowergiftbuyViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandpowergiftbuyViewPresentor", package.seeall)

local NewhandpowergiftbuyViewPresentor = class("NewhandpowergiftbuyViewPresentor", ViewPresentor)

function NewhandpowergiftbuyViewPresentor:ctor()
	NewhandpowergiftbuyViewPresentor.super.ctor(self)
end

function NewhandpowergiftbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandpowergiftbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandpowergiftbuyview.prefab"
	}
end

function NewhandpowergiftbuyViewPresentor:buildViews()
	return {
		NewhandpowergiftbuyView.New()
	}
end

return NewhandpowergiftbuyViewPresentor
