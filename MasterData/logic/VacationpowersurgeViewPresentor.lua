-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vacationpowersurge/view/VacationpowersurgeViewPresentor.lua

module("logic.extensions.vacationpowersurge.view.VacationpowersurgeViewPresentor", package.seeall)

local VacationpowersurgeViewPresentor = class("VacationpowersurgeViewPresentor", ViewPresentor)

VacationpowersurgeViewPresentor.RolePath = "effect/prefabs/ui/fx_ui_zhanlibiaosheng/dahaoqi-ui_p.prefab"

function VacationpowersurgeViewPresentor:ctor()
	VacationpowersurgeViewPresentor.super.ctor(self)
end

function VacationpowersurgeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VacationpowersurgeViewPresentor:dependWhatResources()
	return {
		"ui/views/vacationpowersurge/vacationpowersurgeview.prefab",
		VacationpowersurgeViewPresentor.RolePath
	}
end

function VacationpowersurgeViewPresentor:buildViews()
	return {
		VacationpowersurgeView.New()
	}
end

return VacationpowersurgeViewPresentor
