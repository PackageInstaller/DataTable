-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethposViewPresentor.lua

module("logic.extensions.originelizabeth.view.OriginelizabethposViewPresentor", package.seeall)

local OriginelizabethposViewPresentor = class("OriginelizabethposViewPresentor", ViewPresentor)

function OriginelizabethposViewPresentor:ctor()
	OriginelizabethposViewPresentor.super.ctor(self)
end

function OriginelizabethposViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginelizabethposViewPresentor:dependWhatResources()
	return {
		"ui/views/originelizabeth/originelizabethposview.prefab"
	}
end

function OriginelizabethposViewPresentor:buildViews()
	return {
		OriginelizabethposView.New()
	}
end

function OriginelizabethposViewPresentor:setGrayMaskGO(grayMaskGO)
	OriginelizabethposViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return OriginelizabethposViewPresentor
