-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgFailViewPresentor.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgFailViewPresentor", package.seeall)

local OriginKingMoYanClgFailViewPresentor = class("OriginKingMoYanClgFailViewPresentor", ViewPresentor)

function OriginKingMoYanClgFailViewPresentor:ctor()
	OriginKingMoYanClgFailViewPresentor.super.ctor(self)
end

function OriginKingMoYanClgFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMoYanClgFailViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlesettlementsuccess.prefab"
	}
end

function OriginKingMoYanClgFailViewPresentor:buildViews()
	return {
		OriginKingMoYanClgFailView.New()
	}
end

return OriginKingMoYanClgFailViewPresentor
