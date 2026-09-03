-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneWarConfig.lua

require("dm.gameplay.miniGame.model.plane.PlaneEnemy")
require("dm.gameplay.miniGame.model.plane.PlaneAction")

PlaneWarConfig = PlaneWarConfig or {}
PlaneActionType = {
	kBezier = "Bezier",
	kMove = "Move",
	kTrack = "Track"
}
PlaneMemberType = {
	kPlayerButtle = "PlayerButtle",
	kPlayer = "player",
	kEnemyPlane = "EnemyPlane",
	kEnemyButtle = "EnemyButtle"
}
PlaneBulletType = {
	kTrack = "Track",
	kMove = "Move",
	kSplit = "Split",
	kFixedTrack = "FixedTrack"
}
PlaneEnemyAppearType = {
	random = "ARRAYS",
	randomGroup = "RANDOMWAVE",
	item = "RANDOMREWARD",
	normal = "FIX"
}
PlaneEnemyType = {
	kGold = 9,
	kPlane3 = 3,
	kBomb = 8,
	kDiamond = 10,
	kPlane5 = 5,
	kPlane7 = 7,
	kPlane2 = 2,
	kPlane4 = 4,
	kPlane6 = 6,
	kPlane1 = 1,
	kPiece = 11
}
PlaneDrawDebugBox = true

local planeEnemyFlag = {
	[PlaneEnemyType.kPlane1] = true,
	[PlaneEnemyType.kPlane2] = true,
	[PlaneEnemyType.kPlane3] = true,
	[PlaneEnemyType.kPlane4] = true,
	[PlaneEnemyType.kPlane5] = true,
	[PlaneEnemyType.kPlane6] = true
}

function PlaneWarConfig:isPlaneEnemy(enemyType)
	return planeEnemyFlag[enemyType]
end

local bulletFlag = {
	[PlaneMemberType.kPlayerButtle] = true,
	[PlaneMemberType.kEnemyButtle] = true
}

function PlaneWarConfig:isBullet(enemyType)
	return bulletFlag[enemyType]
end

kPlaneEnemyConfig = {
	[PlaneEnemyType.kPlane1] = {
		planeClass = PlaneEnemyKind1
	},
	[PlaneEnemyType.kPlane2] = {
		planeClass = PlaneEnemyKind2
	},
	[PlaneEnemyType.kPlane3] = {
		planeClass = PlaneEnemyKind3
	},
	[PlaneEnemyType.kPlane4] = {
		planeClass = PlaneEnemyKind4
	},
	[PlaneEnemyType.kPlane5] = {
		planeClass = PlaneEnemyKind5
	},
	[PlaneEnemyType.kPlane6] = {
		planeClass = PlaneEnemyKind6
	},
	[PlaneEnemyType.kPlane7] = {
		planeClass = PlaneEnemyKind7
	},
	[PlaneEnemyType.kBomb] = {
		planeClass = BombPlaneEnemy
	},
	[PlaneEnemyType.kGold] = {
		planeClass = GoldPlaneEnemy
	},
	[PlaneEnemyType.kDiamond] = {
		planeClass = DiamondPlaneEnemy
	},
	[PlaneEnemyType.kPiece] = {
		planeClass = PiecePlaneEnemy
	}
}
PlaneWarConfig.fistEnemySleepTime = 0.1
PlaneWarConfig.playerZorder = 11
PlaneWarConfig.boomZorder = 20
PlaneWarConfig.enemyZorder = 9
PlaneWarConfig.bulletZorder = 8
PlaneWarConfig.BigBulletZorder = 10
PlaneWarConfig.bgZorder = 2
