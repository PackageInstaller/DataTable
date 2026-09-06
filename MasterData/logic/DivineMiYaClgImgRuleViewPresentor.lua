-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiYaClgImgRuleViewPresentor.lua

module("logic.extensions.divinemiyaclg.view.DivineMiYaClgImgRuleViewPresentor", package.seeall)

local DivineMiYaClgImgRuleViewPresentor = class("DivineMiYaClgImgRuleViewPresentor", ViewPresentor)

function DivineMiYaClgImgRuleViewPresentor:ctor()
	DivineMiYaClgImgRuleViewPresentor.super.ctor(self)
end

function DivineMiYaClgImgRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineMiYaClgImgRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiyaclg/divinemiyaclgimgruleview.prefab"
	}
end

function DivineMiYaClgImgRuleViewPresentor:buildViews()
	return {
		DivineMiYaClgImgRuleView.New()
	}
end

return DivineMiYaClgImgRuleViewPresentor
