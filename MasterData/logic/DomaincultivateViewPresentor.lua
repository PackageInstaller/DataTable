-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomaincultivateViewPresentor.lua

module("logic.extensions.domaincultivate.view.DomaincultivateViewPresentor", package.seeall)

local DomaincultivateViewPresentor = class("DomaincultivateViewPresentor", ViewPresentor)

function DomaincultivateViewPresentor:ctor()
	DomaincultivateViewPresentor.super.ctor(self)
end

function DomaincultivateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomaincultivateViewPresentor:dependWhatResources()
	return {
		"ui/views/domaincultivate/domaincultivateview.prefab"
	}
end

function DomaincultivateViewPresentor:buildViews()
	return {
		DomainCultivateView.New()
	}
end

return DomaincultivateViewPresentor
