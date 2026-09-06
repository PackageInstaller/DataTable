-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/stack/CardInfoStackPresentor.lua

module("logic.extensions.roleinfo.view.stack.CardInfoStackPresentor", package.seeall)

local CardInfoStackPresentor = class("CardInfoStackPresentor", ViewPresentor)

function CardInfoStackPresentor:ctor()
	CardInfoStackPresentor.super.ctor(self)
end

function CardInfoStackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CardInfoStackPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/cardinfostackview.prefab"
	}
end

function CardInfoStackPresentor:buildViews()
	return {
		CardInfoStackView.New()
	}
end

return CardInfoStackPresentor
