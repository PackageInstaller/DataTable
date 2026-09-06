-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotussxgameViewPresentor.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotussxgameViewPresentor", package.seeall)

local RedlotussxgameViewPresentor = class("RedlotussxgameViewPresentor", ViewPresentor)

function RedlotussxgameViewPresentor:ctor()
	RedlotussxgameViewPresentor.super.ctor(self)
end

function RedlotussxgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RedlotussxgameViewPresentor:dependWhatResources()
	return {
		"ui/views/redlotusdinnerparty/redlotussxgameview.prefab",
		"ui/views/sxgame/item_mianfen.prefab",
		"ui/views/sxgame/item_rou.prefab",
		"ui/views/sxgame/item_qingcai.prefab",
		"ui/views/sxgame/item_lanmei.prefab",
		"ui/views/sxgame/itemflash.prefab",
		"ui/views/sxgame/itembloom.prefab",
		"ui/views/sxgame/itemshuflash.prefab",
		"ui/views/sxgame/item_jidan.prefab",
		"ui/views/sxgame/itemforward.prefab",
		"ui/views/sxgame/itemback.prefab",
		"ui/views/sxgame/itemblock.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_amazing.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_combo.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_zhadan.prefab",
		"effect/prefabs/ui/fx_ui_sanxiao/fx_ui_sanxiao_shandian_shu.prefab"
	}
end

function RedlotussxgameViewPresentor:buildViews()
	return {
		RedlotussxgameView.New()
	}
end

return RedlotussxgameViewPresentor
