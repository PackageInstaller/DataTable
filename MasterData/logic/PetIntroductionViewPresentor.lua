-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petintroduction/view/PetIntroductionViewPresentor.lua

module("logic.extensions.petintroduction.view.PetIntroductionViewPresentor", package.seeall)

local PetIntroductionViewPresentor = class("PetIntroductionViewPresentor", ViewPresentor)

function PetIntroductionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetIntroductionViewPresentor:dependWhatResources()
	return {
		"ui/views/petintroduction/petintroductionview.prefab"
	}
end

function PetIntroductionViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_chuchang/fx_ui_chuchuang_daiji_hou.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_chuchang/fx_ui_chuchuang_daiji_qian.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_chuchang/fx_ui_chuchang.prefab")
	}
end

function PetIntroductionViewPresentor:buildViews()
	return {
		PetIntroductionView.New()
	}
end

return PetIntroductionViewPresentor
