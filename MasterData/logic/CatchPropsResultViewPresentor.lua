-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsResultViewPresentor.lua

module("logic.extensions.catchprops.view.CatchPropsResultViewPresentor", package.seeall)

local CatchPropsResultViewPresentor = class("CatchPropsResultViewPresentor", ViewPresentor)

function CatchPropsResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CatchPropsResultViewPresentor:dependWhatResources()
	return {
		"ui/views/catchprops/catchpropsresultview.prefab"
	}
end

function CatchPropsResultViewPresentor:buildViews()
	return {
		CatchPropsResultView.New()
	}
end

return CatchPropsResultViewPresentor
