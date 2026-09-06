-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgMainViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgMainViewPresentor", package.seeall)

local OriginGodDragonClgMainViewPresentor = class("OriginGodDragonClgMainViewPresentor", ViewPresentor)

function OriginGodDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGodDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgmainview.prefab"
	}
end

function OriginGodDragonClgMainViewPresentor:buildViews()
	return {
		OriginGodDragonClgMainView.New()
	}
end

return OriginGodDragonClgMainViewPresentor
