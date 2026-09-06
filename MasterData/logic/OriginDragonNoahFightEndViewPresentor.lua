-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahFightEndViewPresentor.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahFightEndViewPresentor", package.seeall)

local OriginDragonNoahFightEndViewPresentor = class("OriginDragonNoahFightEndViewPresentor", ViewPresentor)

function OriginDragonNoahFightEndViewPresentor:ctor()
	OriginDragonNoahFightEndViewPresentor.super.ctor(self)
end

function OriginDragonNoahFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDragonNoahFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/origindragonnoah/origindragonnoahfightendview.prefab"
	}
end

function OriginDragonNoahFightEndViewPresentor:buildViews()
	return {
		OriginDragonNoahFightEndView.New()
	}
end

return OriginDragonNoahFightEndViewPresentor
