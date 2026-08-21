-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/preload/CommonResPath.lua

module("logic.starter.preload.CommonResPath", package.seeall)

local CommonResPath = {}

CommonResPath.PhotoMat_Additive = "shared/materials/comm/photoadditive.mat"
CommonResPath.BlurMat = "shared/materials/comm/mat_blur.mat"
CommonResPath.UIGray = "shared/materials/comm/ui_gray.mat"
CommonResPath.LoginStart = "ui/views/login/login_start_view.prefab"
CommonResPath.LoginSimulationSDK = "ui/views/login/login_simulation_sdk_view.prefab"
CommonResPath.LanguageImageText = "ui/allimagetext/imagetext.spriteatlas"
CommonResPath.UICommonBg = "shared/ui/views/common/ui_commonbg.prefab"
CommonResPath.RenderQualityData = "urpassets/renderqualitydata.asset"
CommonResPath.ShaderCacheCollection = "urpshaders/shader_cache_collection.asset"
CommonResPath.TextSettings = "ui/views/common/text_settings.asset"
CommonResPath.URPAssetMaxHigh = "urpassets/spacexurpasset_max_high.asset"
CommonResPath.URPAssetHigh = "urpassets/spacexurpasset_high.asset"
CommonResPath.URPAssetMedium = "urpassets/spacexurpasset_medium.asset"
CommonResPath.URPAssetLow = "urpassets/spacexurpasset_low.asset"
CommonResPath.FloatItem = "ui/views/common/float_newitem.prefab"
CommonResPath.Url_Currency_Item = "ui/views/common/currency_item.prefab"
CommonResPath.SkillIconMat = "shared/materials/comm/skill_other_mask.mat"
CommonResPath.SkillIconPassiveMat = "shared/materials/comm/skill_pas_mask.mat"
CommonResPath.TMPMaterialSetting = "ui/commonfont/tmpfont/tmpmaterialsetting.asset"
CommonResPath.ControlRoom = "scene/sx_scene-assets/sx-s202_control-room/scene_run/sx-s202_control-room_run.unity"
CommonResPath.Spacestation = "scene/sx_scene-assets/sx-s201_spacestation/scene_run/sx-s201_spacestation_run.unity"
CommonResPath.MainScene = "scene/sx_scene-assets/sx-s001_mainscene/scene_run/sx-s001_mainscene_run.unity"
CommonResPath.basicGroups = {
	"urpshaders",
	"urpassets",
	"materials_comm"
}
CommonResPath.loginGroups = {
	CommonResPath.LoginStart,
	CommonResPath.LoginSimulationSDK
}
CommonResPath.basic = {
	CommonResPath.FloatItem,
	CommonResPath.LanguageImageText,
	IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
	CommonResPath.UICommonBg,
	CommonResPath.RenderQualityData,
	CommonResPath.ShaderCacheCollection,
	CommonResPath.TextSettings,
	CommonResPath.TMPMaterialSetting,
	CommonResPath.URPAssetMaxHigh,
	CommonResPath.URPAssetHigh,
	CommonResPath.URPAssetMedium,
	CommonResPath.URPAssetLow
}
CommonResPath.mainScenePreloadRes = {
	CommonResPath.MainScene,
	CommonResPath.TMPMaterialSetting
}
CommonResPath.storyBasic = {
	CommonResPath.FloatItem,
	CommonResPath.RenderQualityData,
	CommonResPath.TextSettings,
	IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
	CommonResPath.TMPMaterialSetting
}
CommonResPath.additional = {}

return CommonResPath
