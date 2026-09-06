-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpedSelectNextLevelViewPresentor.lua

module("logic.extensions.expedition.view.ExpedSelectNextLevelViewPresentor", package.seeall)

local ExpedSelectNextLevelViewPresentor = class("ExpedSelectNextLevelViewPresentor", ViewPresentor)

function ExpedSelectNextLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpedSelectNextLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/expselnextlevelview.prefab"
	}
end

function ExpedSelectNextLevelViewPresentor:buildViews()
	return {
		ExpedSelectNextLevelView.New()
	}
end

function ExpedSelectNextLevelViewPresentor:getTempResources()
	local eventIndex = self._openParam[1]
	local effPath = eventIndex == 1 and UIEffectManager.instance:getEffectPath("fx_ui_shiluoyiji/fx_ui_chuansongmen_lan_shiluoyiji.prefab") or UIEffectManager.instance:getEffectPath("fx_ui_shiluoyiji/fx_ui_chuansongmen_hong_shiluoyiji.prefab")

	return {
		effPath
	}
end

return ExpedSelectNextLevelViewPresentor
