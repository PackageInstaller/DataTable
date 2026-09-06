-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRogueBuffLookViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingRogueBuffLookViewPresentor", package.seeall)

local ChopKingRogueBuffLookViewPresentor = class("ChopKingRogueBuffLookViewPresentor", ViewPresentor)

function ChopKingRogueBuffLookViewPresentor:ctor()
	ChopKingRogueBuffLookViewPresentor.super.ctor(self)
end

function ChopKingRogueBuffLookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingRogueBuffLookViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingroguebufflookview.prefab"
	}
end

function ChopKingRogueBuffLookViewPresentor:buildViews()
	return {
		ChopKingRogueBuffLookView.New()
	}
end

return ChopKingRogueBuffLookViewPresentor
