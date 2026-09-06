-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderClgFormationExViewPresentor.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderClgFormationExViewPresentor", package.seeall)

local DivineKingOrderClgFormationExViewPresentor = class("DivineKingOrderClgFormationExViewPresentor", ViewPresentor)

function DivineKingOrderClgFormationExViewPresentor:ctor()
	DivineKingOrderClgFormationExViewPresentor.super.ctor(self)
end

function DivineKingOrderClgFormationExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingOrderClgFormationExViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingorder/divinekingorderclgformationexview.prefab"
	}
end

function DivineKingOrderClgFormationExViewPresentor:buildViews()
	return {
		DivineKingOrderClgFormationExView.New()
	}
end

return DivineKingOrderClgFormationExViewPresentor
