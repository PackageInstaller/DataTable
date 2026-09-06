-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesGameCopyViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesGameCopyViewPresentor", package.seeall)

local TripleMacthesGameCopyViewPresentor = class("TripleMacthesGameCopyViewPresentor", ViewPresentor)

function TripleMacthesGameCopyViewPresentor:ctor()
	TripleMacthesGameCopyViewPresentor.super.ctor(self)
end

function TripleMacthesGameCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TripleMacthesGameCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesgamecopyview.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_zhadan.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"
	}
end

function TripleMacthesGameCopyViewPresentor:buildViews()
	return {
		TripleMacthesGameCopyView.New(),
		TripleMacthesGameFramkCopyView.New()
	}
end

return TripleMacthesGameCopyViewPresentor
