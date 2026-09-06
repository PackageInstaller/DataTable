-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgNormalBuffViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgNormalBuffViewPresentor", package.seeall)

local DivineZhongFeiClgNormalBuffViewPresentor = class("DivineZhongFeiClgNormalBuffViewPresentor", ViewPresentor)

function DivineZhongFeiClgNormalBuffViewPresentor:ctor()
	DivineZhongFeiClgNormalBuffViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgNormalBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineZhongFeiClgNormalBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgnormalbuffview.prefab"
	}
end

function DivineZhongFeiClgNormalBuffViewPresentor:buildViews()
	return {
		DivineZhongFeiClgNormalBuffView.New()
	}
end

return DivineZhongFeiClgNormalBuffViewPresentor
