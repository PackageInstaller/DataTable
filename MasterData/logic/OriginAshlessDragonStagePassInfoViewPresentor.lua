-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonStagePassInfoViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonStagePassInfoViewPresentor", package.seeall)

local OriginAshlessDragonStagePassInfoViewPresentor = class("OriginAshlessDragonStagePassInfoViewPresentor", ViewPresentor)

function OriginAshlessDragonStagePassInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAshlessDragonStagePassInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonstagepassinfoview.prefab"
	}
end

function OriginAshlessDragonStagePassInfoViewPresentor:buildViews()
	return {
		OriginAshlessDragonStagePassInfoView.New()
	}
end

return OriginAshlessDragonStagePassInfoViewPresentor
