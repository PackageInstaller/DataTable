-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadbossgrassViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadbossgrassViewPresentor", package.seeall)

local ChuangjingroadbossgrassViewPresentor = class("ChuangjingroadbossgrassViewPresentor", ViewPresentor)

function ChuangjingroadbossgrassViewPresentor:ctor()
	ChuangjingroadbossgrassViewPresentor.super.ctor(self)
end

function ChuangjingroadbossgrassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadbossgrassViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadbossgrassview.prefab"
	}
end

function ChuangjingroadbossgrassViewPresentor:buildViews()
	return {
		ChuangjingroadbossgrassView.New()
	}
end

return ChuangjingroadbossgrassViewPresentor
