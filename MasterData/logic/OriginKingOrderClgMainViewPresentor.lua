-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgMainViewPresentor.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgMainViewPresentor", package.seeall)

local OriginKingOrderClgMainViewPresentor = class("OriginKingOrderClgMainViewPresentor", ViewPresentor)

function OriginKingOrderClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingOrderClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingorderclg/originkingorderclgmainview.prefab"
	}
end

function OriginKingOrderClgMainViewPresentor:buildViews()
	return {
		OriginKingOrderClgMainView.New()
	}
end

return OriginKingOrderClgMainViewPresentor
