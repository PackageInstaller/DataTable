-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgresultViewPresentor.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgresultViewPresentor", package.seeall)

local DivineteshamuclgresultViewPresentor = class("DivineteshamuclgresultViewPresentor", ViewPresentor)

function DivineteshamuclgresultViewPresentor:ctor()
	DivineteshamuclgresultViewPresentor.super.ctor(self)
end

function DivineteshamuclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineteshamuclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineteshamuclg/divineteshamuclgresultview.prefab"
	}
end

function DivineteshamuclgresultViewPresentor:buildViews()
	return {
		DivineteshamuclgresultView.New()
	}
end

return DivineteshamuclgresultViewPresentor
