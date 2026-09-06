-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarRuleViewPresentor.lua

module("logic.extensions.newfamily.view.war.GodStatuesWarRuleViewPresentor", package.seeall)

local GodStatuesWarRuleViewPresentor = class("GodStatuesWarRuleViewPresentor", ViewPresentor)

function GodStatuesWarRuleViewPresentor:ctor()
	GodStatuesWarRuleViewPresentor.super.ctor(self)
end

function GodStatuesWarRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarruleview.prefab"
	}
end

function GodStatuesWarRuleViewPresentor:buildViews()
	return {
		GodStatuesWarRuleView.New()
	}
end

return GodStatuesWarRuleViewPresentor
