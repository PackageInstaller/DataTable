-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoopairViewPresentor.lua

module("logic.extensions.zoo.view.ZoopairViewPresentor", package.seeall)

local ZoopairViewPresentor = class("ZoopairViewPresentor", ViewPresentor)

function ZoopairViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoopairViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoopairview.prefab"
	}
end

function ZoopairViewPresentor:buildViews()
	return {
		ZoopairView.New()
	}
end

return ZoopairViewPresentor
