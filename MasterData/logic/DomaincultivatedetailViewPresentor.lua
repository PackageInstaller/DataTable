-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomaincultivatedetailViewPresentor.lua

module("logic.extensions.domaincultivate.view.DomaincultivatedetailViewPresentor", package.seeall)

local DomaincultivatedetailViewPresentor = class("DomaincultivatedetailViewPresentor", ViewPresentor)

function DomaincultivatedetailViewPresentor:ctor()
	DomaincultivatedetailViewPresentor.super.ctor(self)
end

function DomaincultivatedetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomaincultivatedetailViewPresentor:dependWhatResources()
	return {
		"ui/views/domaincultivate/domaincultivatedetailview.prefab"
	}
end

function DomaincultivatedetailViewPresentor:buildViews()
	return {
		DomainCultivateDetailView.New()
	}
end

return DomaincultivatedetailViewPresentor
