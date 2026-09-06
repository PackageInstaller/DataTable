-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/FreeskinwelfareViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.FreeskinwelfareViewPresentor", package.seeall)

local FreeskinwelfareViewPresentor = class("FreeskinwelfareViewPresentor", ViewPresentor)

function FreeskinwelfareViewPresentor:ctor()
	FreeskinwelfareViewPresentor.super.ctor(self)
end

function FreeskinwelfareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeskinwelfareViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/freeskinwelfareview.prefab"
	}
end

function FreeskinwelfareViewPresentor:buildViews()
	return {
		FreeskinwelfareView.New()
	}
end

return FreeskinwelfareViewPresentor
