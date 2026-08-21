-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/datadef/SceneEnum.lua

module("logic.scene.datadef.SceneEnum", package.seeall)

NavMeshAreas = {
	Jump = 2,
	Elevator = 4,
	Room = 3,
	NotWalkable = 1,
	Link = 5,
	Walkable = 0
}
PlayerMoveStatus = {
	MoveLeft = 1,
	MoveStop = 0,
	MoveRight = 2,
	MoveDirent = 3
}
Elevator = {
	Lobby = 2,
	Level = 1
}
ElevatorAnim = {
	Close = "liftdoor_a_anim_close",
	Open = "liftdoor_a_anim_open"
}
ElevatorButton = {
	UpButton = 1,
	DownButton = 2
}
ElevatorMoveStatus = {
	Down = 2,
	Up = 1,
	Hold = 3
}
ElevatorMainPos = {
	MoveInElevator = 2,
	EnterElevator = 1
}
ElevatorHeroStatus = {
	PushBtn = 2,
	MoveInEleavtor = 3,
	Wait = 1,
	InEleavtor = 5,
	MoveOutEleavtor = 4,
	None = 0
}
BubbleType = {
	Emoji = 3,
	Talk = 1,
	Word = 2
}
TypeToPickerLayers = {
	[0] = {
		SceneLayer.Default_Value
	},
	[SceneType.Battle] = {
		SceneLayer.Raycast_Value
	},
	[SceneType.Dungeon] = {
		SceneLayer.Default_Value
	},
	[SceneType.House] = {
		SceneLayer.Default_Value,
		SceneLayer.Unit_Value
	},
	[SceneType.Room] = {
		SceneLayer.Default_Value,
		SceneLayer.Unit_Value
	},
	[SceneType.Team] = {
		SceneLayer.Default_Value,
		SceneLayer.Unit_Value
	},
	[SceneType.Lottery] = {
		SceneLayer.Default_Value
	},
	[SceneType.RunGroup] = {
		SceneLayer.Default_Value
	},
	[SceneType.RunGroupSecondary] = {
		SceneLayer.Default_Value
	},
	[SceneType.Story] = {
		SceneLayer.Default_Value
	},
	[SceneType.SpecialTraining] = {
		SceneLayer.Unit_Value
	},
	[SceneType.AirWorkShop] = {
		SceneLayer.Raycast_Value
	},
	[SceneType.ClawDoll] = {
		SceneLayer.Default_Value
	},
	[SceneType.CharacterPreview] = {
		SceneLayer.Default_Value
	},
	[SceneType.Retrieve] = {
		SceneLayer.Default_Value,
		SceneLayer.Unit_Value
	}
}
