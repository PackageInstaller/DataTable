-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorfmtextViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorfmtextViewPresentor", package.seeall)

local SeniorfmtextViewPresentor = class("SeniorfmtextViewPresentor", ViewPresentor)

function SeniorfmtextViewPresentor:ctor()
	SeniorfmtextViewPresentor.super.ctor(self)
end

function SeniorfmtextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeniorfmtextViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorfmtextview.prefab"
	}
end

function SeniorfmtextViewPresentor:buildViews()
	return {
		SeniorfmtextView.New()
	}
end

return SeniorfmtextViewPresentor
