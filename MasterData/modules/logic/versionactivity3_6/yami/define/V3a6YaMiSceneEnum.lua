-- chunkname: @modules/logic/versionactivity3_6/yami/define/V3a6YaMiSceneEnum.lua

module("modules.logic.versionactivity3_6.yami.define.V3a6YaMiSceneEnum", package.seeall)

local V3a6YaMiSceneEnum = _M

V3a6YaMiSceneEnum.MapCameraSize = 5
V3a6YaMiSceneEnum.SceneRootName = "YaMiSceneMapScene"
V3a6YaMiSceneEnum.SceneResPath = "v3a6_m_s08_hddt/scenes_prefab/v3a6_m_s08_hddt_ww_p"
V3a6YaMiSceneEnum.DeskResPaths = {
	"v3a6_m_s08_hddt/scenes_prefab/m_s08_hddt_obj_bangongshi_1",
	"v3a6_m_s08_hddt/scenes_prefab/m_s08_hddt_obj_bangongshi_2"
}
V3a6YaMiSceneEnum.MapLightUrl = "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab"
V3a6YaMiSceneEnum.DeskHeroCount = 4
V3a6YaMiSceneEnum.LoadScene = "V3a6YaMiSceneEnum_LoadScene"
V3a6YaMiSceneEnum.NeedLoadResTag = {
	HeroEntity = 1,
	TalkRes = 3,
	AttrRes = 2
}

return V3a6YaMiSceneEnum
