-- chunkname: @modules/logic/versionactivity2_2/eliminate/defines/EliminateLevelEnum.lua

module("modules.logic.versionactivity2_2.eliminate.defines.EliminateLevelEnum", package.seeall)

local EliminateLevelEnum = class("EliminateLevelEnum")

EliminateLevelEnum.levelType = {
	boss = "boss",
	elite = "elite",
	normal = "normal"
}
EliminateLevelEnum.scenePathToStrongLandImageName = {
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd1_p.prefab"] = "v2a2_eliminate_teamchess_platebg1",
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd_p.prefab"] = "v2a2_eliminate_teamchess_platebg3",
	["scenes/v2a2_m_s12_xdwf/scenes_prefab/v2a2_m_s12_xdwf_jd2_p.prefab"] = "v2a2_eliminate_teamchess_platebg2"
}
EliminateLevelEnum.resultStatUse = {
	lose = "失败",
	draw = "主动中断",
	win = "成功"
}
EliminateLevelEnum.skillShowType = {
	skill = 1,
	forecast = 2
}
EliminateLevelEnum.winColor = GameUtil.parseColor("#88CC66")
EliminateLevelEnum.loserColor = GameUtil.parseColor("#e5e0cf")
EliminateLevelEnum.winSize = 42
EliminateLevelEnum.loserSize = 34
EliminateLevelEnum.winImageName1 = "v2a2_eliminate_enemy_pointhpbg"
EliminateLevelEnum.loserImageName1 = "v2a2_eliminate_enemy_selfhpbg"
EliminateLevelEnum.winImageName2 = "v2a2_eliminate_enemy_pointhpbg3"
EliminateLevelEnum.loserImageName2 = "v2a2_eliminate_enemy_selfhpbg23"

return EliminateLevelEnum
