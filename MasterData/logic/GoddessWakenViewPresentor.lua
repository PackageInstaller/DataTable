-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/view/GoddessWakenViewPresentor.lua

module("logic.extensions.goddesswaken.view.GoddessWakenViewPresentor", package.seeall)

local GoddessWakenViewPresentor = class("GoddessWakenViewPresentor", ViewPresentor)

GoddessWakenViewPresentor.FenWei = "20220304/nvshenjuexing/fx_ui_nvshenjuexing_fenwei.prefab"
GoddessWakenViewPresentor.DianLiang = "20220304/nvshenjuexing/fx_ui_nvshenjuexing_dianliang.prefab"

function GoddessWakenViewPresentor:ctor()
	GoddessWakenViewPresentor.super.ctor(self)
end

function GoddessWakenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessWakenViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesswaken/goddesswakenview.prefab"
	}
end

function GoddessWakenViewPresentor:buildViews()
	return {
		GoddessWakenView.New()
	}
end

function GoddessWakenViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(GoddessWakenViewPresentor.FenWei),
		UIEffectManager.instance:getEffectPath(GoddessWakenViewPresentor.DianLiang)
	}
end

return GoddessWakenViewPresentor
