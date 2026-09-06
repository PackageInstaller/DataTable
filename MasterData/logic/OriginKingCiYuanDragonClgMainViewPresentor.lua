-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/view/OriginKingCiYuanDragonClgMainViewPresentor.lua

module("logic.extensions.originkingciyuandragonclg.view.OriginKingCiYuanDragonClgMainViewPresentor", package.seeall)

local OriginKingCiYuanDragonClgMainViewPresentor = class("OriginKingCiYuanDragonClgMainViewPresentor", ViewPresentor)

function OriginKingCiYuanDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingCiYuanDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingciyuandragonclg/originkingciyuandragonclgmainview.prefab"
	}
end

function OriginKingCiYuanDragonClgMainViewPresentor:buildViews()
	return {
		OriginKingCiYuanDragonClgMainView.New()
	}
end

return OriginKingCiYuanDragonClgMainViewPresentor
