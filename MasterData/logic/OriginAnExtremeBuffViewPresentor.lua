-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeBuffViewPresentor.lua

module("logic.extensions.originan.view.OriginAnExtremeBuffViewPresentor", package.seeall)

local OriginAnExtremeBuffViewPresentor = class("OriginAnExtremeBuffViewPresentor", ViewPresentor)

function OriginAnExtremeBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAnExtremeBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originanextremebuffview.prefab"
	}
end

function OriginAnExtremeBuffViewPresentor:buildViews()
	return {
		OriginAnExtremeBuffView.New()
	}
end

return OriginAnExtremeBuffViewPresentor
