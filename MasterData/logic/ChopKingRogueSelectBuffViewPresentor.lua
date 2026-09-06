-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRogueSelectBuffViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingRogueSelectBuffViewPresentor", package.seeall)

local ChopKingRogueSelectBuffViewPresentor = class("ChopKingRogueSelectBuffViewPresentor", ViewPresentor)

function ChopKingRogueSelectBuffViewPresentor:ctor()
	ChopKingRogueSelectBuffViewPresentor.super.ctor(self)
end

function ChopKingRogueSelectBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChopKingRogueSelectBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingrogueselectbuffview.prefab"
	}
end

function ChopKingRogueSelectBuffViewPresentor:buildViews()
	return {
		ChopKingRogueSelectBuffView.New()
	}
end

return ChopKingRogueSelectBuffViewPresentor
