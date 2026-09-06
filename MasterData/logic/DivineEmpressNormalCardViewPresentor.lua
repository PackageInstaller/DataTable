-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressNormalCardViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressNormalCardViewPresentor", package.seeall)

local DivineEmpressNormalCardViewPresentor = class("DivineEmpressNormalCardViewPresentor", ViewPresentor)

function DivineEmpressNormalCardViewPresentor:ctor()
	DivineEmpressNormalCardViewPresentor.super.ctor(self)
end

function DivineEmpressNormalCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEmpressNormalCardViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressnormalcardview.prefab"
	}
end

function DivineEmpressNormalCardViewPresentor:buildViews()
	return {
		DivineEmpressNormalCardView.New()
	}
end

return DivineEmpressNormalCardViewPresentor
