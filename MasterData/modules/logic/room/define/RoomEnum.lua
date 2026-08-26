-- chunkname: @modules/logic/room/define/RoomEnum.lua

module("modules.logic.room.define.RoomEnum", package.seeall)

local RoomEnum = _M

RoomEnum.RoomSceneId = 601
RoomEnum.FSMEditState = {
	PlaceConfirm = "EditPlaceConfirm",
	BackConfirm = "EditBackConfirm",
	Idle = "EditIdle",
	WaterReform = "EditWaterReform",
	PlaceBuildingConfirm = "EditPlaceBuildingConfirm"
}
RoomEnum.FSMObState = {
	CharacterBuildingShowTime = "ObCharacterBuildingShowTime",
	PlaceCharacterConfirm = "ObPlaceCharacterConfirm",
	PlaceBuildingConfirm = "ObPlaceBuildingConfirm",
	Idle = "ObIdle"
}
RoomEnum.TouchTab = {
	RoomPartBuilding = 2,
	RoomCritter = 5,
	RoomTransportSite = 6,
	RoomBuilding = 3,
	RoomInitBuilding = 1,
	RoomCharacter = 4
}
RoomEnum.GameMode = {
	Ob = 1,
	DebugPackage = 6,
	VisitShare = 7,
	DebugNormal = 4,
	DebugInit = 5,
	Edit = 2,
	Visit = 3,
	FishingVisit = 9,
	Fishing = 8
}
RoomEnum.CameraState = {
	Character = 3,
	FirstPerson = 6,
	InteractionCharacterBuilding = 4,
	OverlookAll = 5,
	Manufacture = 9,
	InteractBuilding = 8,
	ThirdPerson = 7,
	Overlook = 1,
	Normal = 2
}
RoomEnum.ChangeCameraParamDict = {
	[RoomEnum.CameraState.InteractionCharacterBuilding] = true,
	[RoomEnum.CameraState.FirstPerson] = true,
	[RoomEnum.CameraState.ThirdPerson] = true,
	[RoomEnum.CameraState.Manufacture] = true,
	[RoomEnum.CameraState.InteractBuilding] = true
}
RoomEnum.CameraOverlooks = {
	RoomEnum.CameraState.Overlook,
	RoomEnum.CameraState.OverlookAll
}
RoomEnum.CameraCanScaleMap = {
	[RoomEnum.CameraState.Normal] = true,
	[RoomEnum.CameraState.Overlook] = true,
	[RoomEnum.CameraState.OverlookAll] = true
}
RoomEnum.CameraShowSpineMap = {
	[RoomEnum.CameraState.Overlook] = true,
	[RoomEnum.CameraState.Normal] = true,
	[RoomEnum.CameraState.Character] = true,
	[RoomEnum.CameraState.InteractionCharacterBuilding] = true,
	[RoomEnum.CameraState.FirstPerson] = true,
	[RoomEnum.CameraState.ThirdPerson] = true,
	[RoomEnum.CameraState.Manufacture] = true,
	[RoomEnum.CameraState.InteractBuilding] = true
}
RoomEnum.CameraFollowType = {
	FirstPerson = 2,
	Normal = 1
}
RoomEnum.IsShowUICharacterInteraction = false
RoomEnum.BlockPathEditor = "room/configs/json_block.json"
RoomEnum.InitMapConfigPathEditor = "room/configs/json_block_init.json"
RoomEnum.BlockPath = "configs/excel2json/json_block.json"
RoomEnum.InitMapConfigPath = "configs/excel2json/json_block_init.json"
RoomEnum.BlockPackageMapPath = "room/configs/json_block_package_map.json"
RoomEnum.BlockPackageDataPath = "configs/excel2json/json_block_package_data.json"
RoomEnum.FishingMapBlockPath = "configs/excel2json/json_fishing_map_block.json"
RoomEnum.FishingMapBuildingPath = "configs/excel2json/json_fishing_map_building.json"
RoomEnum.DefaultCameraParam = {
	Angle = 25,
	Height = 0,
	Distance = 2.72,
	Rotate = 0,
	fogDensity = 0.6,
	BendingAmount = 0,
	OffsetX = 0,
	Blur = 2,
	OffsetY = 0
}
RoomEnum.GuideForbidEscapeToast = 2634
RoomEnum.Toast = {
	LayoutPlanNotDelete = 2695,
	InventoryBlockUnBack = 2651,
	InventBlockMapPositionMax = 2644,
	NoSelectInventoryBlock = 2641,
	LayoutPlanMapNothing = 42605,
	RoomNeedProductionLevel = 2670,
	BuildingCannotInitBlock = 2664,
	LayoutPlanRename = 2696,
	RoomProductionLevelLock = 2681,
	TaskGoOBModeInEditMode = 2689,
	GainFaithFull = 2684,
	LayoutPlanSave = 2697,
	RoomTradeLowLevel = 230014,
	InventoryBlockMoreUnBack = 2652,
	LayoutPlanSaveAndUse = 42601,
	InventoryBlockInScreen = 2642,
	LayoutPlanUseShareCodeNotNum = 62602,
	InventoryCannotBackInitBlock = 2663,
	MaterialChangeByRoomProductLine_Base = 2674,
	SpecialBlockGain = 2686,
	LayoutPlanCopy = 42602,
	LayoutPlanNotCanCopy = 62604,
	LayoutPlanNotOpen = 2694,
	LayoutPlanShareCodeNotOpen = 62607,
	LayoutPlanShareCodeNotNum = 62601,
	RoomProductLineLockTips = 2671,
	LayoutPlanDelete = 42604,
	GainFaithSingleCharacter = 2683,
	InventoryCanelNoBackBlock = 2657,
	InventoryBlockMax = 2643,
	LayoutPlanMax = 2699,
	RoomConfirmRoomSuccess = 2672,
	RoomLockMaterialChangeTip = 2687,
	MaterialChangeByRoomProductLine = 2659,
	LayoutPlanNotCanShare = 62605,
	GainFaithMultipleCharacter = 2685,
	LayoutPlanCopyShareCodeTxt = 62603,
	LayoutShareCodeEmpty = 62606,
	InventoryConfirmNoBackBlock = 2658,
	LayoutRenameEmpty = 42603,
	NoRewards = 2669,
	RoomEditCanNotOpenProductionLevel = 2691,
	TaskAlreadyInEditMode = 2690,
	LayoutPlanUse = 2698,
	InventoryBlockOneBackMax = 2653
}
RoomEnum.ConstNum = {
	InventoryBlockOneBackMax = 20
}
RoomEnum.UseAStarPath = true
RoomEnum.AStarLayerTag = {
	Default = 0,
	Water = 2,
	AirVehicle = 11,
	Road12 = 12,
	Railway = 9,
	Road10 = 10,
	Muddyway = 4,
	Road = 3,
	Coast = 8,
	NoWalkRoad = 1
}
RoomEnum.ObtainReadState = {
	FristObtain = 1,
	ClickToView = 2,
	None = 0
}
RoomEnum.ComponentName = {
	BatchRendererEntity = "BatchRendererEntity",
	Renderer = "Renderer",
	BoxCollider = "BoxCollider",
	Transform = "Transform",
	MeshRenderer = "MeshRenderer",
	AnimationEventWrap = "AnimationEventWrap"
}
RoomEnum.ComponentType = {
	MeshRenderer = typeof(UnityEngine.MeshRenderer),
	Transform = typeof(UnityEngine.Transform),
	BatchRendererEntity = typeof(UrpCustom.BatchRendererEntity),
	BoxCollider = typeof(UnityEngine.BoxCollider),
	Renderer = typeof(UnityEngine.Renderer),
	LuaMonobehavier = typeof(SLFramework.LuaMonobehavier),
	Animator = typeof(UnityEngine.Animator),
	AnimationEventWrap = typeof(ZProj.AnimationEventWrap)
}
RoomEnum.EffectKey = {
	BuildingOccupyCanJudgeKey = "canJudgeOccupyEffect",
	CharacterFootPrintGOKey = "footprintGO",
	CharacterChatKey = "characterChatKey",
	BlockPackageEffectKey = "packageEffect",
	BlockRiverFloorKey = "riverfloor",
	PressingEffectKey = "pressingEffect",
	BuildingOccupyNotJudgeKey = "notJudgeOccupyEffect",
	BlockVxWaterKey = "vxWaterEffect",
	BuilidNotPlaceKey = "builidNotPlace",
	BlockCanPlaceKey = "canPlaceEffect",
	CharacterBirthdayEffKey = "characterBirthdayEff",
	CharacterFaithMaxKey = "characterFaithMaxKey",
	CharacterFaithNormalKey = "characterFaithNormalKey",
	BuildingGOKey = "buildingGO",
	BlockLandKey = "land",
	BuildingEquipSkinEffectKey = "changeRoomSkinEffect",
	FaithEffectKey = "faithEffect",
	BlockBackBuildingKey = "backBuildingEffect",
	BlockSmokeEffectKey = "smokeEffect",
	BuildingPressEffectKey = "pressEffect",
	BlockRiverKey = "river",
	VehicleGOKey = "vehicleGO",
	BlockTempPlaceKey = "tempPlaceEffect",
	BuilidCanPlaceKey = "builidCanPlace",
	BlockBackBlockKey = "backblockEffect",
	CharacterFaithFullKey = "characterFaithFullKey",
	ConfirmCharacterEffectKey = "confirmCharacterEffect",
	BlockKeys = {
		"block_1",
		"block_2",
		"block_3",
		"block_4",
		"block_5",
		"block_6"
	},
	BlockFloorKeys = {
		"blockfloor_1",
		"blockfloor_2",
		"blockfloor_3",
		"blockfloor_4",
		"blockfloor_5",
		"blockfloor_6"
	},
	BlockFloorBKeys = {
		"blockfloor_b1",
		"blockfloor_b2",
		"blockfloor_b3",
		"blockfloor_b4",
		"blockfloor_b5",
		"blockfloor_b6"
	},
	BlockWaveEffectKeys = {
		"waveEffect_1",
		"waveEffect_2",
		"waveEffect_3",
		"waveEffect_4",
		"waveEffect_5",
		"waveEffect_6"
	},
	BlockHalfLakeKeys = {
		"halflake_1",
		"halflake_2",
		"halflake_3",
		"halflake_4",
		"halflake_5",
		"halflake_6"
	},
	BuildingOccupyCanSideKeys = {
		"occupyCanSide_1",
		"occupyCanSide_2",
		"occupyCanSide_3",
		"occupyCanSide_4",
		"occupyCanSide_5",
		"occupyCanSide_6"
	},
	BuildingOccupyNotSideKeys = {
		"occupyNotSide_1",
		"occupyNotSide_2",
		"occupyNotSide_3",
		"occupyNotSide_4",
		"occupyNotSide_5",
		"occupyNotSide_6"
	}
}
RoomEnum.EffectPath = {
	PartWorkingPath = "anim/#job",
	LightMeshPath = "mesh/light",
	BuildingLevelPath = "1/#level_%s",
	PartFullPath = "anim/#full",
	ResourcePointLightPaths = {
		"1/light",
		"2/light",
		"3/light",
		"4/light",
		"5/light",
		"6/light"
	}
}
RoomEnum.EntityChildKey = {
	ProduceGOKey = "produce",
	BuildingLinkBlockGOKey = "#linkblock",
	BodyGOKey = "body",
	HeadGOKey = "head",
	ReflerctionGOKey = "#reflerction",
	SmokeGOKey = "#smoke",
	NightLightGOKey = "#night",
	BirthdayBlockGOKey = "v1a9_bxhy_terrain_role",
	WaterGradientGOKey = "waterGradient",
	InSideKey = "inSide",
	ContainerGOKey = "container",
	CritterPoint = "cititer_point_%s",
	InteractSpineNode = "building%s",
	WaterBlockEffectGOKey = "water_block_effect",
	OutSideKey = "outSide",
	PositionZeroKey = "positionzero",
	ThirdPersonCameraGOKey = "third_person_camera",
	StaticContainerGOKey = "staticContainer",
	FirstPersonCameraGOKey = "first_person_camera",
	CritterPointList = {
		"cititer_point_1",
		"cititer_point_2",
		"cititer_point_3",
		"cititer_point_4",
		"cititer_point_5",
		"cititer_point_6"
	},
	InteractStartPointList = {
		"interact_start_1",
		"interact_start_2",
		"interact_start_3",
		"interact_start_4",
		"interact_start_5",
		"interact_start_6"
	}
}
RoomEnum.InteractSpineAnimName = "interact"
RoomEnum.EffectRebuildCompNames = {
	"vehiclefollow",
	"nightlight",
	"buildingLinkBlockComp",
	"reflerctionComp",
	"buildingLevelComp",
	"animEventAudioComp",
	"skin",
	"alphaThresholdComp",
	"birthday",
	"cameraFollowTargetComp",
	"critter",
	"vehickleTransport",
	"atmosphere",
	"changeColorComp"
}
RoomEnum.AtmosphereCacheKey = "RoomAtmosphereCacheKey_v2a5"
RoomEnum.AtmosphereTriggerType = {
	IntegralPoint = 2,
	CDTime = 3,
	Disposable = 1,
	None = 0
}
RoomEnum.AtmosphereAudioFadeView = {
	RoomProductLineLevelUpView = true,
	RoomLevelUpTipsView = true,
	RoomLevelUpView = true
}
RoomEnum.RoomViewBlockOpMode = {
	WaterReform = 2,
	BackBlock = 1
}
RoomEnum.ReformMode = {
	Water = 1,
	Block = 2
}
RoomEnum.BlockColorReformSelectMode = {
	All = 1,
	Single = 2,
	Multiple = 3
}
RoomEnum.BlockColorReformSelectModeName = {
	[RoomEnum.BlockColorReformSelectMode.All] = "Room_block_reform_select_all",
	[RoomEnum.BlockColorReformSelectMode.Single] = "Room_block_reform_select_single",
	[RoomEnum.BlockColorReformSelectMode.Multiple] = "Room_block_reform_select_multiple"
}
RoomEnum.DialogSpeakerType = {
	Critter = 2,
	Hero = 1
}
RoomEnum.LayoutPlanDefaultNames = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"B",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z"
}
RoomEnum.LayoutCopyShowNameMaxCount = 5
RoomEnum.LayoutUsedPlanId = 0
RoomEnum.IsCloseLayouCopy = true
RoomEnum.IsBlockNeedConnInit = false
RoomEnum.LayoutPlanShareCodeLimit = 12
RoomEnum.MeshUseOptimize = true
RoomEnum.AStarMeshMaxWidthOrDepth = 500
RoomEnum.WorldPosToAStarMeshWidth = 20
RoomEnum.WorldPosToAStarMeshDepth = 19.5
RoomEnum.CameraParamId = {
	CritterTrainHeroFollow = 2251
}
RoomEnum.SourcesShowType = {
	Cobrand = 1,
	Normal = 0
}

return RoomEnum
