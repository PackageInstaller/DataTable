-- chunkname: @modules/logic/explore/controller/ExploreConstValue.lua

module("modules.logic.explore.controller.ExploreConstValue", package.seeall)

local ExploreConstValue = _M

ExploreConstValue.TILE_SIZE = 1
ExploreConstValue.CameraTraceTime = 1
ExploreConstValue.Toast = {
	ExploreCantUseItem = 90101,
	ExploreChapterLock = 60301,
	ExploreCantPlacePot = 90103,
	CantUseItem = 1703,
	WayImpassable = 1701,
	ExploreCantTrigger = 90102,
	NoItem = 25,
	ExploreLock = 40402,
	UseWithFixPrism = 1702,
	CantTrigger = 40401
}
ExploreConstValue.MessageBoxId = {
	MapReset = 40701
}
ExploreConstValue.TrapAudioMaxDis = 5
ExploreConstValue.RTPCKey = {
	TrapDis = "ui_qiutu_trap_loop_attenuation"
}
ExploreConstValue.CHECK_INTERVAL = {
	MapShadowObjDestory = 4,
	MapSceneObjDestory = 4,
	UnitObjDestory = 4
}
ExploreConstValue.MapSceneObjEffectType = {
	OnlyEffect = 1,
	NoEffect = 0,
	Mix = 2
}
ExploreConstValue.MapSceneObjDestoryInterval = {
	[ExploreConstValue.MapSceneObjEffectType.NoEffect] = ExploreConstValue.CHECK_INTERVAL.MapSceneObjDestory,
	[ExploreConstValue.MapSceneObjEffectType.OnlyEffect] = 999,
	[ExploreConstValue.MapSceneObjEffectType.Mix] = ExploreConstValue.CHECK_INTERVAL.MapSceneObjDestory
}
ExploreConstValue.UseCSharpTree = true
ExploreConstValue.ClickEffect = "v1a4_dianjidimian"
ExploreConstValue.PlaceEffect = "v1a4_fangzhiyuanjian"
ExploreConstValue.MapLightEffect = "zj_03_jh_fglj_guangshu"
ExploreConstValue.MapPrefab = "modules/explore/prefabs/scene.prefab"
ExploreConstValue.MapConfigPath = "config/explore/lua_explore_map_%s.lua"
ExploreConstValue.EntryCameraCtrlPath = "modules/explore/camera_anim/msts_anim_entry_01.controller"
ExploreConstValue.MapNavMeshPath = "modules/explore/navigate/%s.mesh"
ExploreConstValue.MapSceneObjAlwaysShowEffectType = {
	[ExploreConstValue.MapSceneObjEffectType.OnlyEffect] = true
}

return ExploreConstValue
