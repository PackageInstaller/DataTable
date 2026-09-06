-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/Duolalightmain2ViewPresentor.lua

module("logic.extensions.duolalight.view.Duolalightmain2ViewPresentor", package.seeall)

local Duolalightmain2ViewPresentor = class("Duolalightmain2ViewPresentor", ViewPresentor)

function Duolalightmain2ViewPresentor:ctor()
	Duolalightmain2ViewPresentor.super.ctor(self)
end

function Duolalightmain2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Duolalightmain2ViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/duolalightmain2view.prefab"
	}
end

function Duolalightmain2ViewPresentor:buildViews()
	return {
		Duolalightmain2View.New()
	}
end

return Duolalightmain2ViewPresentor
