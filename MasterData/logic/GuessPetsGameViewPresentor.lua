-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsGameViewPresentor.lua

module("logic.extensions.guesspets.view.GuessPetsGameViewPresentor", package.seeall)

local GuessPetsGameViewPresentor = class("GuessPetsGameViewPresentor", ViewPresentor)

GuessPetsGameViewPresentor.startQusetionEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_kaishidati_cjl.prefab"
GuessPetsGameViewPresentor.numberQusetionEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_kaishidati_dijiti.prefab"
GuessPetsGameViewPresentor.firstlyAnswerEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_qiangda_cjl.prefab"
GuessPetsGameViewPresentor.wrongAnswerEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_cuo_cjl.prefab"
GuessPetsGameViewPresentor.rightAnswerEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_dui_cjl.prefab"
GuessPetsGameViewPresentor.progressTrailEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_jindu_trail_cjl.prefab"
GuessPetsGameViewPresentor.progressTrailHitEff = "effect/prefabs/ui/20220401/caijingling/fx_ui_jindu_trail_hit_cjl.prefab"

function GuessPetsGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessPetsGameViewPresentor:dependWhatResources()
	return {
		"ui/views/guesspets/guesspetsgameview.prefab"
	}
end

function GuessPetsGameViewPresentor:getTempResources()
	return {
		GuessPetModel.instance:getMainImage(),
		GuessPetsGameViewPresentor.startQusetionEff,
		GuessPetsGameViewPresentor.numberQusetionEff,
		GuessPetsGameViewPresentor.firstlyAnswerEff,
		GuessPetsGameViewPresentor.wrongAnswerEff,
		GuessPetsGameViewPresentor.rightAnswerEff,
		GuessPetsGameViewPresentor.progressTrailEff,
		GuessPetsGameViewPresentor.progressTrailHitEff
	}
end

function GuessPetsGameViewPresentor:buildViews()
	return {
		GuessPetsGameView.New()
	}
end

return GuessPetsGameViewPresentor
