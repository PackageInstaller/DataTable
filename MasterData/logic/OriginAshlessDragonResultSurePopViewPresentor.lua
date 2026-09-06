-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonResultSurePopViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonResultSurePopViewPresentor", package.seeall)

local OriginAshlessDragonResultSurePopViewPresentor = class("OriginAshlessDragonResultSurePopViewPresentor", ViewPresentor)

function OriginAshlessDragonResultSurePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAshlessDragonResultSurePopViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonresultsurepopview.prefab"
	}
end

function OriginAshlessDragonResultSurePopViewPresentor:buildViews()
	return {
		OriginAshlessDragonResultSurePopView.New()
	}
end

return OriginAshlessDragonResultSurePopViewPresentor
