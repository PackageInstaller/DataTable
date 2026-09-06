-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/view/InfiniteJigsawViewPresentor.lua

module("logic.extensions.infinitejigsaw.view.InfiniteJigsawViewPresentor", package.seeall)

local InfiniteJigsawViewPresentor = class("InfiniteJigsawViewPresentor", ViewPresentor)

function InfiniteJigsawViewPresentor:ctor()
	InfiniteJigsawViewPresentor.super.ctor(self)
end

function InfiniteJigsawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfiniteJigsawViewPresentor:dependWhatResources()
	return {
		"ui/views/infinitejigsaw/infinitejigsawview.prefab"
	}
end

function InfiniteJigsawViewPresentor:buildViews()
	return {
		InfiniteJigsawView.New()
	}
end

function InfiniteJigsawViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"),
		UIEffectManager.instance:getEffectPath("20220218/dianliangweilai/fx_ui_wxwl_daiji.prefab"),
		UIEffectManager.instance:getEffectPath("20220218/dianliangweilai/fx_ui_wxwl_dianliang.prefab")
	}
end

return InfiniteJigsawViewPresentor
