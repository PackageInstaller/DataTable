-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgresultViewPresentor.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgresultViewPresentor", package.seeall)

local OrigindarkmoyanclgresultViewPresentor = class("OrigindarkmoyanclgresultViewPresentor", ViewPresentor)

function OrigindarkmoyanclgresultViewPresentor:ctor()
	OrigindarkmoyanclgresultViewPresentor.super.ctor(self)
end

function OrigindarkmoyanclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrigindarkmoyanclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmoyanclg/origindarkmoyanclgresultview.prefab"
	}
end

function OrigindarkmoyanclgresultViewPresentor:buildViews()
	return {
		OrigindarkmoyanclgresultView.New()
	}
end

return OrigindarkmoyanclgresultViewPresentor
