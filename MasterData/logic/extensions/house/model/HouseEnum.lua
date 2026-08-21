-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/HouseEnum.lua

module("logic.extensions.house.model.HouseEnum", package.seeall)

FURNITURE_COORD_SIZE = 0.5
DEFAULT_FOV = 32
SUPERVISOR_ROOM_ID = 1211
MANUFACTURE_ROOM_ID = 1207
TRADING_ROOM_ID = 1203
DEFAULT_CAMERA_MASK_MODE = 1
EDIT_FURNITURE_CAMERA_MASK_MODE = 101
FURNITURE_CARVING_TIME = 0.1
DEFAULT_SINGLE_PERFORM_ID = 9999998
DEFAULT_DOUBLE_PERFORM_ID = 9999999
LOWEST_NAVMESH_PRIORITY = 99
SLOWLY_SPEED_RATE = 0.1
ZoneType = {
	Extra = 9,
	Room = 1,
	Corridor = 2
}
RingType = {
	Third = 3,
	Second = 2,
	Fourth = 4,
	First = 1
}
WorkStatus = {
	Work = 3,
	Rest = 4,
	Eat = 2,
	Sleep = 1
}
WorkStatusMode = {
	End = 2,
	Start = 1,
	Normal = 3
}
WorkType = {
	Trading = 2,
	Shelter = 4,
	Manufacturing = 3,
	Supervisor = 1
}
RoomType = {
	Supervisor = 1,
	Manufacturing = 3,
	Living = 5,
	Trading = 2,
	Shelter = 4
}
RoomType2Name = {
	[0] = "任意收容室",
	"主管室",
	"贸易站",
	"制造厂",
	"收容室",
	"生活设施"
}
ManufactureType2Name = {
	"建筑",
	"养成",
	"家具"
}
Grade2Name = {
	"正常",
	"良好",
	"优秀",
	"完美"
}
RoomSize = {
	Big = 1,
	Small = 0
}
AI = {
	Default = "house_unit_default_ai"
}
BehaviorType = {
	RestBH_1 = 40002,
	WorkTradingBaseBH = 32001,
	EatBH_1 = 20002,
	SleepBH_2 = 10003,
	EatBH_2 = 20003,
	ShelterInvalid = 90002,
	WorkSupervisorBaseBH = 31001,
	SleepBaseBH = 10001,
	SleepBH_1 = 10002,
	WorkManufacturBaseBH = 33001,
	WorkManufacturBH_1 = 33002,
	WorkShelterBaseBH = 34001,
	WorkShelterBH_1 = 34002,
	SleepBH_3 = 10004,
	RestBaseBH = 40001,
	WorkTradingBH_1 = 32002,
	WorkTradingBH_3 = 32004,
	GotoTargetRoom = 90000,
	RandomWalk = 90003,
	WorkSupervisorBH_1 = 31002,
	WorkTradingBH_2 = 32003,
	EatBaseBH = 20001,
	WorkShelterBH_2 = 34003,
	BaseBehavior = 90001,
	None = 0
}
AnimationState = {
	Nod = "nod",
	Sad = "sad",
	CastOff = "cast_off",
	FoodHand = "food_hand",
	Work = "work",
	Idle2 = "idle2",
	Call = "call",
	PutDown2 = "putdown2",
	Disappear = "disappear",
	FoodTable = "food_table",
	Idle = "idle",
	Sleep = "sleep",
	PutDown = "putdown",
	Drama = "drama",
	Lose1 = "lose_1",
	Control3 = "control_3",
	Happy = "happy",
	Loss = "loss",
	Appear = "appear",
	Panic = "panic",
	Catch = "catch",
	Shake = "shake",
	Walk = "walk",
	PutDown3 = "putdown3",
	Shock = "shock",
	Control2 = "control_2",
	Think = "think",
	Control1 = "control_1",
	Idle3 = "idle3",
	Walk2 = "walk2",
	CastOn = "cast_on",
	Sit = "sit",
	Run = "run",
	Walk3 = "walk3",
	Play = "play",
	Jump = "jump",
	Speak = "speak",
	FoodTableTake = "food_table_take",
	FoodHandTake = "food_hand_take"
}
FurnitureAnimation = {
	Close = "close",
	Open = "open"
}
ReplaceSlotName = {
	Expression = "replace_bq",
	Face = "replace_face",
	Goods = "replace_goods",
	Food2 = "replace_food_2",
	Food = "replace_food"
}
SpineName = {
	ToolComputer = "104_computer_home",
	ToolBook = "104_book_home",
	ProtectiveSuit = "104_fanghuafu_home"
}
ModelName = {
	ToolComputer = "104_computer_home",
	ToolBook = "104_book_home"
}
PerformStatus = {
	Running = 3,
	Waiting = 2,
	CDing = 4,
	None = 1
}
ContactStatus = {
	Running = 2,
	CDing = 3,
	None = 1
}
PlayerStatus = {
	WaitingElevator = 4,
	Eating = 2,
	Sleeping = 5,
	Bathing = 6,
	Draging = 1,
	Elevator = 3,
	None = 0
}
BehaviorStatus = {
	Elevator = 7,
	Eat = 3,
	GoInShelter = 5,
	Sleep = 4,
	Work = 2,
	ShelterInvalid = 8,
	Base = 1,
	Shelter = 9,
	GoAwayShelter = 6,
	None = 0
}
PerformEffectType = {
	Universal = 2,
	Custom = 1
}
PerformCtrlType = {
	Furniture = 10,
	Single = 1,
	Double = 2
}
RoomResLoadType = {
	Static = 1,
	Dynamic = 3,
	ChangePos = 2
}
FurnitureOperaType = {
	Floor = 3,
	Ceiling = 6,
	FloorPaper = 1,
	Wall = 5,
	Carpet = 4,
	WallPaper = 2
}
WallType = {
	Right = 3,
	Middle = 1,
	Left = 2
}
FurnitureGridState = {
	Used = 2,
	Conflict = 3,
	Normal = 1
}
FurnitureRotaType = {
	Around = 1,
	Null = 0
}
PerformForbidKey = {
	ShowHello = "show_hello",
	HousePerform = "house_perform",
	EditFurniture = "edit_room_furniture"
}
UnitDirection = {
	Left = 270,
	Back = 0,
	Right = 90,
	Forward = 180
}
RoomType2SignRes = {
	[HouseEnum.RoomType.Supervisor] = "room_sign_1",
	[HouseEnum.RoomType.Trading] = "room_sign_3",
	[HouseEnum.RoomType.Manufacturing] = "room_sign_4",
	[HouseEnum.RoomType.Shelter] = "room_sign_2"
}
WorkStatus2SignRes = {
	[HouseEnum.WorkStatus.Sleep] = "worktype_sleep",
	[HouseEnum.WorkStatus.Eat] = "worktype_eat",
	[HouseEnum.WorkStatus.Work] = "worktype_work",
	[HouseEnum.WorkStatus.Rest] = "worktype_rest"
}
WorkStatus2SignRes1 = {
	[HouseEnum.WorkStatus.Sleep] = "worktype_sleep1",
	[HouseEnum.WorkStatus.Eat] = "worktype_eat1",
	[HouseEnum.WorkStatus.Work] = "worktype_work1",
	[HouseEnum.WorkStatus.Rest] = "worktype_rest1"
}
DormSexSignRes = {
	[1] = "rc_nan",
	[2] = "rc_nv"
}
WorkType2ToolUrl = {
	[HouseEnum.WorkType.Supervisor] = HouseEnum.ModelName.ToolComputer,
	[HouseEnum.WorkType.Trading] = HouseEnum.ModelName.ToolBook,
	[HouseEnum.WorkType.Manufacturing] = HouseEnum.ModelName.ToolBook,
	[HouseEnum.WorkType.Shelter] = HouseEnum.ModelName.ToolBook
}
WorkType2JobCodeList = {
	[HouseEnum.WorkType.Supervisor] = {
		1,
		2,
		3
	},
	[HouseEnum.WorkType.Trading] = {
		7,
		8,
		9
	},
	[HouseEnum.WorkType.Manufacturing] = {
		4,
		5,
		6
	}
}
WorkStatus2Text = {
	[HouseEnum.WorkStatus.Sleep] = "睡觉",
	[HouseEnum.WorkStatus.Eat] = "进食",
	[HouseEnum.WorkStatus.Work] = "工作",
	[HouseEnum.WorkStatus.Rest] = "休息"
}
BehaviorType2Text = {
	[HouseEnum.BehaviorType.SleepBaseBH] = "睡觉-基础行为",
	[HouseEnum.BehaviorType.SleepBH_1] = "睡觉-睡觉行为",
	[HouseEnum.BehaviorType.SleepBH_2] = "睡觉-洗漱行为",
	[HouseEnum.BehaviorType.SleepBH_3] = "睡觉-休息行为",
	[HouseEnum.BehaviorType.EatBaseBH] = "进食-基础行为",
	[HouseEnum.BehaviorType.EatBH_1] = "进食-吃饭行为",
	[HouseEnum.BehaviorType.EatBH_2] = "进食-休息行为",
	[HouseEnum.BehaviorType.WorkSupervisorBaseBH] = "主管室-基础行为",
	[HouseEnum.BehaviorType.WorkSupervisorBH_1] = "主管室-工作行为",
	[HouseEnum.BehaviorType.WorkTradingBaseBH] = "贸易站-基础行为",
	[HouseEnum.BehaviorType.WorkTradingBH_1] = "贸易站-工作行为",
	[HouseEnum.BehaviorType.WorkTradingBH_2] = "贸易站-交接主管室",
	[HouseEnum.BehaviorType.WorkTradingBH_3] = "贸易站-交接制造厂",
	[HouseEnum.BehaviorType.WorkManufacturBaseBH] = "制造厂-基础行为",
	[HouseEnum.BehaviorType.WorkManufacturBH_1] = "制造厂-工作行为",
	[HouseEnum.BehaviorType.WorkShelterBaseBH] = "收容室-基础行为",
	[HouseEnum.BehaviorType.WorkShelterBH_1] = "收容室-工作行为",
	[HouseEnum.BehaviorType.WorkShelterBH_2] = "收容室-搬运物资",
	[HouseEnum.BehaviorType.RestBaseBH] = "休息-基础行为",
	[HouseEnum.BehaviorType.RestBH_1] = "休息-休息行为"
}
FurnitureOperaType2CameraParam = {
	[0] = {
		rotaX = 6.8,
		rotaY = 0,
		rotaZ = 0,
		posY = 3.05,
		posZ = -12.1,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Floor] = {
		rotaX = 37,
		rotaY = 0,
		rotaZ = 0,
		fov = 42,
		posY = 7.2,
		posZ = -6.6,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Carpet] = {
		rotaX = 37,
		rotaY = 0,
		rotaZ = 0,
		fov = 42,
		posY = 7.2,
		posZ = -6.6,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Ceiling] = {
		rotaX = -18.88,
		rotaY = 0,
		rotaZ = 0,
		fov = 42,
		posY = -0.36,
		posZ = -6.02,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Wall] = {
		[HouseEnum.WallType.Middle] = {
			rotaX = 0,
			rotaY = 0,
			rotaZ = 0,
			posY = 2.4,
			posZ = -5,
			posX = 0
		},
		[HouseEnum.WallType.Left] = {
			rotaX = 0,
			rotaY = -81,
			rotaZ = 0,
			posY = 2.4,
			posZ = 3,
			posX = 5.6
		},
		[HouseEnum.WallType.Right] = {
			rotaX = 0,
			rotaY = 81,
			rotaZ = 0,
			posY = 2.4,
			posZ = 3,
			posX = -5.6
		}
	}
}
FurnitureOperaType2CameraParamBig = {
	[0] = {
		rotaX = 6.8,
		rotaY = 0,
		rotaZ = 0,
		posY = 3.05,
		posZ = -12.1,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Floor] = {
		rotaX = 37,
		rotaY = 0,
		rotaZ = 0,
		fov = 42,
		posY = 7.58,
		posZ = -5.48,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Carpet] = {
		rotaX = 37,
		rotaY = 0,
		rotaZ = 0,
		fov = 42,
		posY = 7.58,
		posZ = -5.48,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Ceiling] = {
		rotaX = -37,
		rotaY = 0,
		rotaZ = 0,
		fov = 42,
		posY = -1.57,
		posZ = -6.67,
		posX = 0
	},
	[HouseEnum.FurnitureOperaType.Wall] = {
		[HouseEnum.WallType.Middle] = {
			rotaX = 0,
			rotaY = 0,
			rotaZ = 0,
			posY = 3.63,
			posZ = -8.13,
			posX = 0
		},
		[HouseEnum.WallType.Left] = {
			rotaX = 0,
			rotaY = -81,
			rotaZ = 0,
			posY = 3.7,
			posZ = 4.62,
			posX = 5.85
		},
		[HouseEnum.WallType.Right] = {
			rotaX = 0,
			rotaY = 81,
			rotaZ = 0,
			posY = 3.7,
			posZ = 4.62,
			posX = -5.85
		}
	}
}
WallType2Angle = {
	[HouseEnum.WallType.Middle] = 0,
	[HouseEnum.WallType.Left] = 270,
	[HouseEnum.WallType.Right] = 90
}
FurnitureOperaType2GridRota = {
	[HouseEnum.FurnitureOperaType.Floor] = {
		z = 0,
		x = 0,
		y = 0
	},
	[HouseEnum.FurnitureOperaType.Carpet] = {
		z = 0,
		x = 0,
		y = 0
	},
	[HouseEnum.FurnitureOperaType.Ceiling] = {
		z = 0,
		x = 180,
		y = 0
	},
	[HouseEnum.FurnitureOperaType.Wall] = {
		[HouseEnum.WallType.Middle] = {
			z = 0,
			x = -90,
			y = 0
		},
		[HouseEnum.WallType.Left] = {
			z = -90,
			x = 0,
			y = 0
		},
		[HouseEnum.WallType.Right] = {
			z = 90,
			x = 0,
			y = 0
		}
	}
}
FurnitureGridState2Color = {
	[HouseEnum.FurnitureGridState.Normal] = "#D7D7D765",
	[HouseEnum.FurnitureGridState.Used] = "#2F7CF1FF",
	[HouseEnum.FurnitureGridState.Conflict] = "#F32A24FF"
}
MoodType2Desc = {
	"开心",
	"普通",
	"难过"
}
RingType2Radius = {
	[HouseEnum.RingType.First] = 33.7,
	[HouseEnum.RingType.Second] = 58.8,
	[HouseEnum.RingType.Third] = 75.04,
	[HouseEnum.RingType.Fourth] = 91.3
}
LivingFacilitiesSizeText = {
	[0] = "小",
	"大"
}
LivingFacilitiesAtmosphere = {
	SciTechnology = 3,
	Entertainment = 4,
	Life = 6,
	Inspiration = 5,
	Ecology = 2
}
LivingRoomType = {
	PrivateDormitory = 2,
	Mystery = 7,
	Dormitory = 1,
	Life = 4,
	Entertainment = 3,
	Technology = 5,
	SpecialDormitory = -99,
	Ecology = 6
}
FurnitureSubType = {
	Ground = 3,
	SmallItem = 5,
	BigItem = 4,
	Wall = 1,
	Ceil = 2
}
FurnitureRealSubType = {
	Ground = 5,
	SmallItem = 2,
	BigItem = 1,
	Wall = 3,
	Ceil = 4
}
FurnitureSubType2Name = {
	[FurnitureRealSubType.Wall] = "墙面",
	[FurnitureRealSubType.Ceil] = "天花板",
	[FurnitureRealSubType.Ground] = "地面",
	[FurnitureRealSubType.BigItem] = "大件",
	[FurnitureRealSubType.SmallItem] = "小件"
}
FurnitureWallEnum = {
	WallBody = 1,
	WallHanging = 3,
	WallDecorate = 2
}
FurnitureWallEnum2Name = {
	[FurnitureWallEnum.WallBody] = "墙体",
	[FurnitureWallEnum.WallDecorate] = "墙饰",
	[FurnitureWallEnum.WallHanging] = "壁挂"
}
FurnitureCeilEnum = {
	DroppedCeil = 1,
	CeilingLamp = 2
}
FurnitureCeilEnum2Name = {
	[FurnitureCeilEnum.DroppedCeil] = "吊顶",
	[FurnitureCeilEnum.CeilingLamp] = "吊灯"
}
FurnitureGroundEnum = {
	Floor = 1,
	Carpet = 2
}
FurnitureGroundEnum2Name = {
	[FurnitureGroundEnum.Floor] = "地板",
	[FurnitureGroundEnum.Carpet] = "地毯"
}
FurnitureBigItemEnum = {
	Desk = 4,
	Cabinet = 3,
	Stuff = 5,
	Bed = 1,
	Sofa = 2
}
FurnitureBigItemEnum2Name = {
	[FurnitureBigItemEnum.Bed] = "床",
	[FurnitureBigItemEnum.Sofa] = "沙发",
	[FurnitureBigItemEnum.Cabinet] = "柜子",
	[FurnitureBigItemEnum.Desk] = "桌子",
	[FurnitureBigItemEnum.Stuff] = "物件"
}
FurnitureSmallItemEnum = {
	LowCabinet = 3,
	Stuff = 4,
	Bench = 2,
	Chair = 1
}
FurnitureSmallItemEnum2Name = {
	[FurnitureSmallItemEnum.Chair] = "椅子",
	[FurnitureSmallItemEnum.Bench] = "板凳",
	[FurnitureSmallItemEnum.LowCabinet] = "矮柜",
	[FurnitureSmallItemEnum.Stuff] = "物件"
}
FurnitureSecondType2Name = {
	[FurnitureRealSubType.Wall] = FurnitureWallEnum2Name,
	[FurnitureRealSubType.Ceil] = FurnitureCeilEnum2Name,
	[FurnitureRealSubType.Ground] = FurnitureGroundEnum2Name,
	[FurnitureRealSubType.BigItem] = FurnitureBigItemEnum2Name,
	[FurnitureRealSubType.SmallItem] = FurnitureSmallItemEnum2Name
}
FurnitureSecondType2Enum = {
	[FurnitureRealSubType.Wall] = FurnitureWallEnum,
	[FurnitureRealSubType.Ceil] = FurnitureCeilEnum,
	[FurnitureRealSubType.Ground] = FurnitureGroundEnum,
	[FurnitureRealSubType.BigItem] = FurnitureBigItemEnum,
	[FurnitureRealSubType.SmallItem] = FurnitureSmallItemEnum
}
DormNumName = {
	[1] = "单人房间",
	[4] = "宿舍"
}
DormBedPosName = {
	"上铺",
	"下铺",
	"上铺",
	"下铺"
}
FurnitureSubTypeName = {
	[3] = {
		"墙体",
		"墙饰",
		"壁挂"
	},
	[4] = {
		[1] = "吊顶",
		[2] = "吊灯"
	},
	[5] = {
		[1] = "地板",
		[2] = "地毯"
	},
	{
		"床",
		"沙发",
		"柜子",
		"桌子",
		"物件"
	},
	{
		"椅子",
		"板凳",
		"矮柜",
		"物件"
	}
}
LivingFacilitiesMark = {
	GenderMark = 1,
	CampMark = 2
}
OpenType = {
	Dorm = "dorm",
	Job = "job"
}
