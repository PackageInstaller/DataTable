-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomaincultivateresetsureViewPresentor.lua

module("logic.extensions.domaincultivate.view.DomaincultivateresetsureViewPresentor", package.seeall)

local DomaincultivateresetsureViewPresentor = class("DomaincultivateresetsureViewPresentor", ViewPresentor)

function DomaincultivateresetsureViewPresentor:ctor()
	DomaincultivateresetsureViewPresentor.super.ctor(self)
end

function DomaincultivateresetsureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomaincultivateresetsureViewPresentor:dependWhatResources()
	return {
		"ui/views/domaincultivate/domaincultivateresetsureview.prefab"
	}
end

function DomaincultivateresetsureViewPresentor:buildViews()
	return {
		DomainCultivateResetSureView.New()
	}
end

return DomaincultivateresetsureViewPresentor
