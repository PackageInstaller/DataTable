-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomaincultivateresetViewPresentor.lua

module("logic.extensions.domaincultivate.view.DomaincultivateresetViewPresentor", package.seeall)

local DomaincultivateresetViewPresentor = class("DomaincultivateresetViewPresentor", ViewPresentor)

function DomaincultivateresetViewPresentor:ctor()
	DomaincultivateresetViewPresentor.super.ctor(self)
end

function DomaincultivateresetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomaincultivateresetViewPresentor:dependWhatResources()
	return {
		"ui/views/domaincultivate/domaincultivateresetview.prefab"
	}
end

function DomaincultivateresetViewPresentor:buildViews()
	return {
		DomainCultivateResetView.New()
	}
end

return DomaincultivateresetViewPresentor
