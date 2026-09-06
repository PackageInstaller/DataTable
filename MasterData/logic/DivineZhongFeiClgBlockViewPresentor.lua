-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgBlockViewPresentor.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgBlockViewPresentor", package.seeall)

local DivineZhongFeiClgBlockViewPresentor = class("DivineZhongFeiClgBlockViewPresentor", ViewPresentor)

function DivineZhongFeiClgBlockViewPresentor:ctor()
	DivineZhongFeiClgBlockViewPresentor.super.ctor(self)
end

function DivineZhongFeiClgBlockViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineZhongFeiClgBlockViewPresentor:dependWhatResources()
	return {
		"ui/views/divinezhongfeiclg/divinezhongfeiclgblockview.prefab"
	}
end

function DivineZhongFeiClgBlockViewPresentor:buildViews()
	return {
		DivineZhongFeiClgBlockView.New()
	}
end

return DivineZhongFeiClgBlockViewPresentor
