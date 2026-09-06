-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgBuffViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgBuffViewPresentor", package.seeall)

local DivineZhongFeiClgBuffViewPresentor = class("DivineZhongFeiClgBuffViewPresentor", ViewPresentor)

function DivineZhongFeiClgBuffViewPresentor:ctor()
	DivineZhongFeiClgBuffViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineZhongFeiClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgbuffview.prefab"
	}
end

function DivineZhongFeiClgBuffViewPresentor:buildViews()
	return {
		DivineZhongFeiClgBuffView.New()
	}
end

return DivineZhongFeiClgBuffViewPresentor
