-- chunkname: @modules/logic/explore/controller/ExploreAnimEnum.lua

module("modules.logic.explore.controller.ExploreAnimEnum", package.seeall)

local ExploreAnimEnum = _M

ExploreAnimEnum.AnimName = {
	unable = "unable",
	nToA = "nToA",
	count3to4 = "count3to4",
	count3 = "count3",
	uToN = "uToN",
	count1to2 = "count1to2",
	nToU = "nToU",
	count2 = "count2",
	count0to1 = "count0to1",
	count4to3 = "count4to3",
	count3to2 = "count3to2",
	count2to1 = "count2to1",
	aToN = "aToN",
	active2 = "active2",
	enter = "enter",
	normal = "normal",
	count2to3 = "count2to3",
	exit = "exit",
	count1 = "count1",
	count1to0 = "count1to0",
	active = "active"
}
ExploreAnimEnum.LoopAnims = {
	[ExploreAnimEnum.AnimName.unable] = true,
	[ExploreAnimEnum.AnimName.normal] = true,
	[ExploreAnimEnum.AnimName.active] = true,
	[ExploreAnimEnum.AnimName.active2] = true,
	[ExploreAnimEnum.AnimName.count1] = true,
	[ExploreAnimEnum.AnimName.count2] = true,
	[ExploreAnimEnum.AnimName.count3] = true
}
ExploreAnimEnum.AnimHashToName = {}
ExploreAnimEnum.AnimNameToHash = {}

for name in pairs(ExploreAnimEnum.AnimName) do
	local hash = UnityEngine.Animator.StringToHash(name)

	ExploreAnimEnum.AnimHashToName[hash] = name
	ExploreAnimEnum.AnimNameToHash[name] = hash
end

ExploreAnimEnum.NextAnimName = {
	enter = ExploreAnimEnum.AnimName.normal,
	uToN = ExploreAnimEnum.AnimName.normal,
	nToU = ExploreAnimEnum.AnimName.unable,
	nToA = ExploreAnimEnum.AnimName.active,
	aToN = ExploreAnimEnum.AnimName.normal,
	exit = ExploreAnimEnum.AnimName.exit
}
ExploreAnimEnum.RoleAnimName = {
	idle = "idle",
	move = "move_slow"
}
ExploreAnimEnum.RoleAnimKey = {
	IsIce = "isIce",
	MoveDir = "moveDir",
	MoveState = "moveState",
	Status = "status"
}
ExploreAnimEnum.RoleMoveState = {
	Idle = 0,
	Move = 1
}
ExploreAnimEnum.RoleAnimStatus = {
	MoveBack = 14,
	CreateUnit = 6,
	Fix = 11,
	Pull = 2,
	CarryPick = 12,
	Interact = 10,
	Carry = 1,
	RotateInteract = 16,
	Finish = 15,
	UseItem = 7,
	Glide = 4,
	Entry = 9,
	NoUseItem = 8,
	Fall = 3,
	OpenChest = 5,
	CarryPut = 13,
	None = 0
}
ExploreAnimEnum.RoleAnimLen = {
	[ExploreAnimEnum.RoleAnimStatus.Carry] = 1.067,
	[ExploreAnimEnum.RoleAnimStatus.Pull] = 0,
	[ExploreAnimEnum.RoleAnimStatus.Fall] = 0,
	[ExploreAnimEnum.RoleAnimStatus.Glide] = 0,
	[ExploreAnimEnum.RoleAnimStatus.OpenChest] = 1.167,
	[ExploreAnimEnum.RoleAnimStatus.CreateUnit] = 2,
	[ExploreAnimEnum.RoleAnimStatus.UseItem] = 1.333,
	[ExploreAnimEnum.RoleAnimStatus.NoUseItem] = 0.933,
	[ExploreAnimEnum.RoleAnimStatus.Entry] = 1.467,
	[ExploreAnimEnum.RoleAnimStatus.Interact] = 0.8,
	[ExploreAnimEnum.RoleAnimStatus.Fix] = 2.167,
	[ExploreAnimEnum.RoleAnimStatus.CarryPick] = 0.8,
	[ExploreAnimEnum.RoleAnimStatus.CarryPut] = 0.8,
	[ExploreAnimEnum.RoleAnimStatus.Finish] = 1.8,
	[ExploreAnimEnum.RoleAnimStatus.RotateInteract] = 0.4
}
ExploreAnimEnum.RoleHangPointType = {
	Hand_Right = 2,
	Hand_Left = 1
}
ExploreAnimEnum.RoleHangPointPath = {
	[ExploreAnimEnum.RoleHangPointType.Hand_Left] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand/hand_l",
	[ExploreAnimEnum.RoleHangPointType.Hand_Right] = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 R Clavicle/Bip001 R UpperArm/Bip001 R Forearm/Bip001 R Hand/hand_r"
}
ExploreAnimEnum.UseBatonAnim = {
	[ExploreAnimEnum.RoleAnimStatus.OpenChest] = ExploreAnimEnum.RoleHangPointType.Hand_Left,
	[ExploreAnimEnum.RoleAnimStatus.CreateUnit] = ExploreAnimEnum.RoleHangPointType.Hand_Right
}
ExploreAnimEnum.RoleSpeed = {
	walk = 0.6,
	run = 0.39
}

return ExploreAnimEnum
