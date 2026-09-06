-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchViewPresentor.lua

module("logic.extensions.scratch.view.ScratchViewPresentor", package.seeall)

local ScratchViewPresentor = class("ScratchViewPresentor", ViewPresentor)

function ScratchViewPresentor:ctor()
	ScratchViewPresentor.super.ctor(self)
end

function ScratchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScratchViewPresentor:dependWhatResources()
	return {
		"ui/views/scratch/scratchview.prefab",
		"effect/prefabs/ui/fx_ui_baozangmiche/spine/10001_baozhang/10001_baozhang-ui_p.prefab"
	}
end

function ScratchViewPresentor:getTempResources()
	return {
		"ui/icon/items/icon_shizigao.png"
	}
end

function ScratchViewPresentor:buildViews()
	return {
		ScratchView.New()
	}
end

return ScratchViewPresentor
