-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/DreamTeamViewPresentor.lua

module("logic.extensions.dreamteam.view.DreamTeamViewPresentor", package.seeall)

local DreamTeamViewPresentor = class("DreamTeamViewPresentor", ViewPresentor)

DreamTeamViewPresentor.DiZuoPath = "fx_ui_dianliangmengzhidui/fx_ui_bg_dlmzd.prefab"
DreamTeamViewPresentor.Dianliang = "fx_ui_dianliangmengzhidui/fx_ui_dianliang_dlmzd.prefab"
DreamTeamViewPresentor.TuoWei = "fx_ui_dianliangmengzhidui/fx_ui_trail_cheng_dlmzd.prefab"
DreamTeamViewPresentor.BaoKai = "fx_ui_dianliangmengzhidui/fx_ui_trail_cheng_hit_dlmzd.prefab"
DreamTeamViewPresentor.Shuijing = {
	"fx_ui_dianliangmengzhidui/fx_ui_shuijing_zi_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_shuijing_lv_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_shuijing_lan_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_shuijing_cheng_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_shuijing_bai_dlmzd.prefab"
}
DreamTeamViewPresentor.Card = {
	"fx_ui_dianliangmengzhidui/fx_ui_pai_zi_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_pai_lv_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_pai_lan_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_pai_cheng_dlmzd.prefab",
	"fx_ui_dianliangmengzhidui/fx_ui_pai_bai_dlmzd.prefab"
}

function DreamTeamViewPresentor:ctor()
	DreamTeamViewPresentor.super.ctor(self)
end

function DreamTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/dreamteamview.prefab"
	}
end

function DreamTeamViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.DiZuoPath),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.Dianliang),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.TuoWei),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.BaoKai),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.Shuijing[1]),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.Shuijing[2]),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.Shuijing[3]),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.Shuijing[4]),
		UIEffectManager.instance:getEffectPath(DreamTeamViewPresentor.Shuijing[5])
	}
end

function DreamTeamViewPresentor:buildViews()
	return {
		DreamTeamView.New()
	}
end

return DreamTeamViewPresentor
