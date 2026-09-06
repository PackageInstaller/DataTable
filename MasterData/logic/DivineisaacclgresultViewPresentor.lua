-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgresultViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgresultViewPresentor", package.seeall)

local DivineisaacclgresultViewPresentor = class("DivineisaacclgresultViewPresentor", ViewPresentor)

function DivineisaacclgresultViewPresentor:ctor()
	DivineisaacclgresultViewPresentor.super.ctor(self)
end

function DivineisaacclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgresultview.prefab"
	}
end

function DivineisaacclgresultViewPresentor:buildViews()
	return {
		DivineisaacclgresultView.New()
	}
end

return DivineisaacclgresultViewPresentor
