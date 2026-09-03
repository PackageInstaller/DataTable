-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceEnum.lua

K_WORLD_MEMBER_TYPE = {
	Boss = 1,
	Member = 0
}
K_WORLD_MEMBER_SATGE = {
	Protecting = 7,
	Attacking = 5,
	Dieing = 8,
	Died = 9,
	Idleing = 3,
	Preparing = 1,
	Protect = 6,
	Attack = 4,
	Idle = 2,
	Prepare = 0
}
K_RENDER_GROUP_LAYER = {
	UI02 = 1,
	UI03 = 2,
	UI01 = 0
}
K_RENDER_DISPLAYMODE = {
	ALL = 1,
	WORLDBOSS = 6,
	SIMPLE = 7,
	MULTILEVEL = 5,
	CLUBBOSSSTAGEONE = 3,
	MIDSIPLE = 2,
	CLUBBOSSSTAGETWO = 4
}
k_MULTILEVEL0_1 = 1.2
k_MULTILEVEL01 = 1.6
k_MULTILEVEL02 = 2.1
k_EFFECT_SCALE = 0.8
k_XULI_EFFECT_SCALE = 0.8
k_BOLLEFFECT_PROP = 0.8

local director = cc.Director:getInstance()
local winSize = director:getWinSize()

k_VIEW_PORT = {
	x = -50,
	y = -50,
	width = winSize.width + 50,
	height = winSize.height + 50
}
k_IGNOR_VIEWPORT_LOAD = false
k_TEAM_STATE = {
	REST = 0,
	PROTECTING = 2,
	OWING = 3,
	BATTLEING = 1
}
k_CAMP_COLOR = {
	cc.c3b(229, 76, 247),
	cc.c3b(241, 193, 32),
	cc.c3b(38, 164, 249)
}
K_CAMP_BOSS_SCALE = {
	0.6,
	0.7,
	0.8
}
K_MATH_PIOVER2 = 1.5707963267948966
K_Oval_Times = 30
K_Oval_V = {
	140,
	90
}
K_Oval_V1 = {
	180,
	100
}
K_Oval_Dt = -0.04
K_Round_Times = 60
