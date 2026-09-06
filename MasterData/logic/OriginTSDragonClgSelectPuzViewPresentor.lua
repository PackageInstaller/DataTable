-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgSelectPuzViewPresentor.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgSelectPuzViewPresentor", package.seeall)

local OriginTSDragonClgSelectPuzViewPresentor = class("OriginTSDragonClgSelectPuzViewPresentor", ViewPresentor)

function OriginTSDragonClgSelectPuzViewPresentor:ctor()
	OriginTSDragonClgSelectPuzViewPresentor.super.ctor(self)
end

function OriginTSDragonClgSelectPuzViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginTSDragonClgSelectPuzViewPresentor:dependWhatResources()
	return {
		"ui/views/origintsdragonclg/origintsdragonclgselectpuzview.prefab"
	}
end

function OriginTSDragonClgSelectPuzViewPresentor:buildViews()
	return {
		OriginTSDragonClgSelectPuzView.New()
	}
end

return OriginTSDragonClgSelectPuzViewPresentor
