-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshViewPresentor.lua

module("logic.extensions.projectash.view.ProjectAshViewPresentor", package.seeall)

local ProjectAshViewPresentor = class("ProjectAshViewPresentor", ViewPresentor)

ProjectAshViewPresentor.EffectBg = "20230428/huijinjihua/fx_ui_huijinjihua_jiemian.prefab"
ProjectAshViewPresentor.EffectCircle = "20230428/huijinjihua/fx_ui_huijinjihua_huanquan.prefab"
ProjectAshViewPresentor.EffectShine = "20230428/huijinjihua/fx_ui_huijinjihua_jiaohuan.prefab"

function ProjectAshViewPresentor:ctor()
	ProjectAshViewPresentor.super.ctor(self)
end

function ProjectAshViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ProjectAshViewPresentor:dependWhatResources()
	return {
		"ui/views/projectash/projectashview.prefab"
	}
end

function ProjectAshViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(ProjectAshViewPresentor.EffectBg),
		UIEffectManager.instance:getEffectPath(ProjectAshViewPresentor.EffectCircle),
		UIEffectManager.instance:getEffectPath(ProjectAshViewPresentor.EffectShine)
	}
end

function ProjectAshViewPresentor:buildViews()
	return {
		ProjectAshView.New()
	}
end

return ProjectAshViewPresentor
