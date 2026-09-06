-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolammgameruleViewPresentor.lua

module("logic.extensions.duolamengmeng.view.DuolammgameruleViewPresentor", package.seeall)

local DuolammgameruleViewPresentor = class("DuolammgameruleViewPresentor", ViewPresentor)

function DuolammgameruleViewPresentor:ctor()
	DuolammgameruleViewPresentor.super.ctor(self)
end

function DuolammgameruleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DuolammgameruleViewPresentor:dependWhatResources()
	return {
		"ui/views/duolamengmeng/duolammgameruleview.prefab"
	}
end

function DuolammgameruleViewPresentor:buildViews()
	return {
		DuolaMMGameRuleView.New()
	}
end

return DuolammgameruleViewPresentor
