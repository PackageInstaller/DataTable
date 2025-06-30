-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGConstant.lua

HorizontalRPGConstant = {}
HorizontalRPGConstant.ObjectTags = {
	HorizontalRPGTrap = "HorizontalRPGTrap",
	HorizontalRPGDeadZone = "HorizontalRPGDeadZone",
	HorizontalRPGArea = "HorizontalRPGArea",
	HorizontalRPGElementHead = "HorizontalRPGElementHead",
	HorizontalRPGPlatform = "HorizontalRPGPlatform"
}
HorizontalRPGConstant.ElementTriggerType = {
	ClickElementBtn = 2,
	CollisionElementHead = 3,
	CollisionElementByBullet = 5,
	CollisionElementBody = 4,
	EnterElementScope = 1
}
HorizontalRPGConstant.ObjectType = {
	HorizontalRPG_Element = 2,
	HorizontalRPG_Player = 1
}
HorizontalRPGConstant.ElementType = {
	HorizontalRPG_Annular_Move_Element = 4,
	HorizontalRPG_Element = 1,
	HorizontalRPG_Line_Move_Element = 3,
	HorizontalRPG_Case = 2
}
HorizontalRPGConstant.ChatType = {
	ChatType_Dialog = 1,
	ChatType_Notice = 2
}
HorizontalRPGConstant.ElementUpdateType = {
	Delete = 2,
	Update = 1,
	Add = 3
}
HorizontalRPGConstant.PlayerState = {
	jump = 5,
	jump2 = 9,
	idle = 4,
	shoot1 = 7,
	jump3 = 10,
	shoot3 = 11,
	die = 1,
	run = 6,
	fly = 2,
	hurt = 3,
	shoot2 = 8
}
HorizontalRPGConstant.PlayerEffect = {
	MaxLevelEffect = 4,
	ReduceBloodEffect = 2,
	UpgradeEffect = 6,
	SlidingEffect = 5,
	InvincibleEffect = 3
}
HorizontalRPGConstant.ElementState = {
	action = 4,
	born = 5,
	idle = 2,
	die = 1,
	move = 3
}
HorizontalRPGConstant.Sound = {
	AddMaxStar = 11007,
	ElementDie = 100,
	AddStar = 11006,
	PutOnBox = 11009,
	StepOnMonster = 10345,
	ChangeScene = 100,
	ShootMonster = 11005,
	Run = 100,
	Jump = 11003,
	Sliding = 11001,
	Shot = 11004
}
HorizontalRPGConstant.ChallengeType = {
	Type_Challenge = 2,
	Type_Plot = 1
}
HorizontalRPGConstant.PosStateType = {
	Type_plot = 1,
	Type_HorizontalMaze = 4,
	Type_HorizontalScene = 3,
	Type_flight = 2
}
HorizontalRPGConstant.ExecutionType = {
	Execution_Options = 4,
	Execution_RefreshMap = 8,
	Execution_ChangeMaxStars = 7,
	Execution_ChangeTask = 14,
	Execution_Drop = 10,
	Execution_Bubbles = 3,
	Execution_ChangeTaskObjective = 15,
	Execution_MoveCamera = 13,
	Execution_ChangeStars = 5,
	Execution_RemoveItem = 22,
	Execution_AddSoulsToTeam = 24,
	Execution_AddSkillStrengthen = 26,
	Execution_RemoveElement = 17,
	Execution_AddElementEffect = 16,
	Execution_PlaySound = 28,
	Execution_AddExp = 25,
	Execution_Prompt = 2,
	Execution_ChangeDay = 9,
	Execution_ElementFire = 21,
	Execution_UpdatePlayerParams = 27,
	Execution_File = 19,
	Execution_Settlement = 29,
	Execution_Delivery = 11,
	Execution_EnterMaze = 12,
	Execution_AddElement = 18,
	Execution_ClearItem = 23,
	Execution_Dialogue = 1
}
