-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/model/BuildingConfig.lua

KBuildingMapShowType = {
	kAll = 1,
	kInRoom = 2
}
KBuildingType = {
	kExpOre = "ExpOre",
	kCrystalOre = "CrystalOre",
	kGoldOre = "GoldOre",
	kCamp = "Camp",
	kMainCity = "MainCity",
	kDecorate = "Decorate",
	kCardAcademy = "CardAcademy"
}
KBuildingOperateType = {
	kRecycle = "kRecycle",
	kMove = "kMove",
	kBuy = "kBuy"
}
KBuildingHeroActionSta = {
	kIdel = "stand",
	kMove = "walk",
	kLife = "lift",
	kPray = "pray",
	kHappy = "win",
	kSleep = "lie",
	kSit = "sit"
}
KBuildingStatus = {
	kLvUp = 1,
	kNone = 0
}
KBuildingRoomLockState = {
	kLocked = 1,
	kUnlocked = 2
}
KBuildingComponentZOrder = {
	kTiledMap = 0,
	kMap = 1,
	kMain = 999,
	kLock = 3,
	kDecorate = 5,
	kFloor = 2
}
KBuildingMapResource = {
	kReduceThree = "asset/scene/building3/",
	kNormal = "asset/scene/building/"
}
KBUILDING_CHANGETEXTURE_SCALE = 0.6
KBUILDING_MAP_CELL_SIZE = cc.size(200, 200)
KBUILDING_FLOOR_CELL_SIZE = cc.size(100, 100)
KBUILDING_Tiled_CELL_SIZE = cc.size(172, 82)
KBUILDING_MAP_CELL_NUM = cc.size(30, 17)
KBUILDING_MAP_SHOWALL_ADD_SCALE = 0.05
KBUILDING_MAP_INROOM_SCALE = 0.65
KBUILDING_MAP_INROOM_SCALE_DIFF = 0.05
KBUILDING_MAP_INALL_SCALE_DIFF = 0.05
KBUILDING_BUILD_ANIM_PLAY_TIME = 1.5
KBUILDING_FADE_TIME = 0.4
KBUILDING_MAP_FIR_ROOF_OPEN_CONDITION = {
	"Room1",
	"Room2",
	"Room3"
}
KBuilding_TiledMap_Room_Pos = {
	Room1 = {
		cc.p(2910, 840),
		"asset/tiled/Building_Room_9_10.tmx",
		{}
	},
	Room2 = {
		cc.p(3815, 1260),
		"asset/tiled/Building_Room_11_10.tmx",
		{}
	},
	Room3 = {
		cc.p(4680, 1670),
		"asset/tiled/Building_Room_9_10.tmx",
		{}
	},
	Room4 = {
		cc.p(1275, 975),
		"asset/tiled/Building_Room_8_10.tmx",
		{
			"Room1",
			"Room2",
			"Room3"
		}
	},
	Room5 = {
		cc.p(2030, 1340),
		"asset/tiled/Building_Room_9_10.tmx",
		{
			"Room1",
			"Room2",
			"Room3"
		}
	},
	Room6 = {
		cc.p(2910, 1760),
		"asset/tiled/Building_Room_11_10.tmx",
		{
			"Room1",
			"Room2",
			"Room3"
		}
	}
}
KBuilding_TiledMap_Zorder = {
	Room6 = 50000,
	Room5 = 60000,
	Room1 = 100000,
	Room3 = 80000,
	Room4 = 70000,
	Room2 = 90000
}
KBuilding_TiledMap_Size = {
	Room1 = cc.size(9.5 * KBUILDING_Tiled_CELL_SIZE.width, 9.5 * KBUILDING_Tiled_CELL_SIZE.height),
	Room2 = cc.size(10.5 * KBUILDING_Tiled_CELL_SIZE.width, 10.5 * KBUILDING_Tiled_CELL_SIZE.height),
	Room3 = cc.size(9.5 * KBUILDING_Tiled_CELL_SIZE.width, 9.5 * KBUILDING_Tiled_CELL_SIZE.height),
	Room4 = cc.size(9 * KBUILDING_Tiled_CELL_SIZE.width, 9 * KBUILDING_Tiled_CELL_SIZE.height),
	Room5 = cc.size(9.5 * KBUILDING_Tiled_CELL_SIZE.width, 9.5 * KBUILDING_Tiled_CELL_SIZE.height),
	Room6 = cc.size(10.5 * KBUILDING_Tiled_CELL_SIZE.width, 10.5 * KBUILDING_Tiled_CELL_SIZE.height)
}
KBuilding_TiledMap_Offset = {
	Room1 = cc.size(-0.25 * KBUILDING_Tiled_CELL_SIZE.width, 0.25 * KBUILDING_Tiled_CELL_SIZE.height),
	Room2 = cc.size(0.25 * KBUILDING_Tiled_CELL_SIZE.width, -0.25 * KBUILDING_Tiled_CELL_SIZE.height),
	Room3 = cc.size(-0.25 * KBUILDING_Tiled_CELL_SIZE.width, 0.25 * KBUILDING_Tiled_CELL_SIZE.height),
	Room4 = cc.size(-0.5 * KBUILDING_Tiled_CELL_SIZE.width, 0.5 * KBUILDING_Tiled_CELL_SIZE.height),
	Room5 = cc.size(-0.25 * KBUILDING_Tiled_CELL_SIZE.width, 0.25 * KBUILDING_Tiled_CELL_SIZE.height),
	Room6 = cc.size(0.25 * KBUILDING_Tiled_CELL_SIZE.width, -0.25 * KBUILDING_Tiled_CELL_SIZE.height)
}
KBUILDING_CHANGE_SCALE_TIME = 0.38
KBUILDING_ROOF_FIRST_POS = cc.p(395, 400)
KBUILDING_TILEMAP_CELL_OFFSET = cc.p(86, 0)
KBUILDING_RANK_BTN_MAP_POS = cc.p(4350, 970)
KBUILDING_DECORATE_QUEUE_MAP_POS = cc.p(3265, 1500)
KBUILDING_BUFF_HERO_ADD_HP = false
KBUILDING_BUFF_MASTER_ADD_HP = false
KBuildingBuildType = {
	kResource = "kResource",
	kDecorate = "kDecorate"
}
