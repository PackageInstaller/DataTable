-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/DoloresclgresultViewPresentor.lua

module("logic.extensions.doloresclg.view.DoloresclgresultViewPresentor", package.seeall)

local DoloresclgresultViewPresentor = class("DoloresclgresultViewPresentor", ViewPresentor)

function DoloresclgresultViewPresentor:ctor()
	DoloresclgresultViewPresentor.super.ctor(self)
end

function DoloresclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoloresclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/doloresclg/doloresclgresultview.prefab"
	}
end

function DoloresclgresultViewPresentor:buildViews()
	return {
		DoloresclgresultView.New()
	}
end

return DoloresclgresultViewPresentor
