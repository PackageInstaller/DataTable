-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgWinResultViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgWinResultViewPresentor", package.seeall)

local OriginGodDragonClgWinResultViewPresentor = class("OriginGodDragonClgWinResultViewPresentor", ViewPresentor)

function OriginGodDragonClgWinResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginGodDragonClgWinResultViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgwinresultview.prefab"
	}
end

function OriginGodDragonClgWinResultViewPresentor:buildViews()
	return {
		OriginGodDragonClgWinResultView.New()
	}
end

return OriginGodDragonClgWinResultViewPresentor
