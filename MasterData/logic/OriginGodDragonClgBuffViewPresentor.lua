-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgBuffViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgBuffViewPresentor", package.seeall)

local OriginGodDragonClgBuffViewPresentor = class("OriginGodDragonClgBuffViewPresentor", ViewPresentor)

function OriginGodDragonClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginGodDragonClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgbuffview.prefab"
	}
end

function OriginGodDragonClgBuffViewPresentor:buildViews()
	return {
		OriginGodDragonClgBuffView.New()
	}
end

return OriginGodDragonClgBuffViewPresentor
