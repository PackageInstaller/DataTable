-- chunkname: @IQIGame\\UI\\Dialog\\CommonDialogueActionUtil.lua

CommonDialogueActionUtil = {}

local this = CommonDialogueActionUtil
local ShowDialogActionClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ShowDialogue")
local EndDialogClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_EndDialogue")
local GetTaskClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_GetTask")
local EnterStoryClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_EnterStory")
local WorldMapComponentActionEndClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_WorldMapComponentActionEnd")
local PlayAnimationClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_PlayAnimation")
local SwitchTimeClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SwitchTime")
local ChangeRoleClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ChangeRole")
local ChangeBGMClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ChangeBGM")
local RefreshStandPaintClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_RefreshStandPaint")
local SetStandPaintPosClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SetStandPaintPos")
local ShowActionSelectClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ShowActionSelect")
local SetActorActiveClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SetActorActive")
local ActorMoveClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ActorMove")
local ShowFilterClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ShowFilter")
local SwitchVirtualCameraClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SwitchVirtualCamera")
local ChangeRoleDirectionClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ChangeRoleDirection")
local SetDialogueImageShowClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SetDialogueImageShow")
local PlayEffectClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_PlayEffect")
local RemoveEffectClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_RemoveEffect")
local CreateRoleClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_CreateRole")
local EnterRoomClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_EnterRoom")
local PlayStandPaintAnimationClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_PlayStandPaintAnimation")
local ShowLocationInfoClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ShowLocationInfo")
local CreateTempActorClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_CreateTempActor")
local ActorsMoveClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_ActorsMove")
local RefreshRoomActorClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_RefreshRoomActor")
local SetNpcPosClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SetNpcPos")
local OpenInteractionUIClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_OpenInteractionUI")
local SetHudOpenClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_SetHudOpen")
local OpenBoxClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_OpenBox")
local OpenHuntUIClass = require("IQIGame/UI/Dialog/DialogueAction/DialogueAction_OpenHuntUI")

this.EffectType = {
	UI = 2,
	Scene = 1
}

function this.CreateAction(actionType, actionParam, createParams)
	if actionType == Constant.CommonDialogActionType.ShowDialog then
		return this.newShowDialog(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.EndDialog then
		return this.newEndDialog(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.GetTask then
		return this.newGetTask(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.EnterRoom then
		return this.newEnterRoom(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.EnterStory then
		return this.newEnterStory(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.WorldMapComponentActionEnd then
		return this.newWorldMapComponentActionEnd(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.PlayAnimation then
		return this.newPlayAnimation(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.SwitchTime then
		return this.newSwitchTime(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.ChangeRole then
		return this.newChangeRole(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.ChangeBGM then
		return this.newChangeBGM(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.RefreshStandPaint then
		return this.newRefreshStandPaint(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.SetStandPaintPos then
		return this.newSetStandPaintPos(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.PlayStandPaintAnimation then
		return this.newPlayStandPaintAnimation(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.ShowActionSelect then
		return this.newShowActionSelect(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.SetActorActive then
		return this.newSetActorActive(actionType, actionParam)
	elseif actionType == Constant.CommonDialogActionType.ActorMove then
		return this.newActorMove(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.ShowFilter then
		return this.newShowFilter(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.SwitchVirtualCamera then
		return this.newSwitchVirtualCamera(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.ChangeRoleDirection then
		return this.newChangeRoleDirection(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.SetDialogueImageShow then
		return this.newSetDialogueImageShow(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.PlayEffect then
		return this.newPlayEffect(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.RemoveEffect then
		return this.newRemoveEffect(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.CreateActor then
		return this.newCreateActor(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.ShowLocationInfo then
		return this.newShowLocationInfo(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.CreateTempActor then
		return this.newCreateTempActor(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.ActorsMove then
		return this.newActorsMove(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.RefreshRoomActor then
		return this.newRefreshRoomActor(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.SetActorPos then
		return this.newSetActorPos(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.OpenInteractionUI then
		return this.newOpenInteractionUI(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.SetHudOpen then
		return this.newSetHudOpen(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.OpenBox then
		return this.newOpenBox(actionType, actionParam, createParams)
	elseif actionType == Constant.CommonDialogActionType.OpenHuntUI then
		return this.newOpenHuntUI(actionType, actionParam, createParams)
	else
		logError("【RPG】没有对话行为类型 = " .. actionType)
	end
end

function this.newOpenHuntUI(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType

	return OpenHuntUIClass.new(args)
end

function this.newOpenBox(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.actionCid = tonumber(actionParam[1])

	return OpenBoxClass.new(args)
end

function this.newSetHudOpen(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.open = tonumber(actionParam[1])

	return SetHudOpenClass.new(args)
end

function this.newOpenInteractionUI(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.actionId = tonumber(actionParam[1])

	return OpenInteractionUIClass.new(args)
end

function this.newSetActorPos(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.roleId = tonumber(actionParam[1])

	if actionParam[2] and actionParam[3] and actionParam[4] then
		args.pos = Vector3.New(tonumber(actionParam[2]), tonumber(actionParam[3]), tonumber(actionParam[4]))
	end

	return SetNpcPosClass.new(args)
end

function this.newRefreshRoomActor(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType

	return RefreshRoomActorClass.new(args)
end

function this.newActorsMove(actionType, actionParam, createParams)
	local moveData = {}
	local len = #actionParam

	for i = 1, len do
		local data = {}
		local paramArray = string.split(actionParam[i], ",")

		data.actionType = actionType
		data.cfgType = createParams.cfgType
		data.actorId = tonumber(paramArray[1])
		data.animationName = paramArray[2]
		data.moveSpeed = tonumber(paramArray[3])

		local posArray = string.split(paramArray[4], "/")

		data.endPos = Vector3.New(tonumber(posArray[1]), tonumber(posArray[2]), tonumber(posArray[3]))

		table.insert(moveData, data)
	end

	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.moveData = moveData

	return ActorsMoveClass.new(args)
end

function this.newCreateTempActor(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType

	local roleList = {}
	local len = #actionParam

	for i = 1, len do
		table.insert(roleList, tonumber(actionParam[i]))
	end

	args.roleIdList = roleList

	return CreateTempActorClass.new(args)
end

function this.newShowLocationInfo(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.timeId = tonumber(actionParam[1])
	args.mainSiteId = tonumber(actionParam[2])
	args.branchSiteId = tonumber(actionParam[3])

	return ShowLocationInfoClass.new(args)
end

function this.newPlayStandPaintAnimation(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.animationName = actionParam[1]
	args.isLoop = tonumber(actionParam[2]) == 1 and true or false

	return PlayStandPaintAnimationClass.new(args)
end

function this.newEnterRoom(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.roomId = tonumber(actionParam[1])

	local posArray = string.split(actionParam[2], ",")
	local x = tonumber(posArray[1])
	local y = tonumber(posArray[2])
	local z = tonumber(posArray[3])

	if x and y and z then
		args.playerPos = Vector3.New(x, y, z)
	end

	args.triggerActionId = tonumber(actionParam[3])

	return EnterRoomClass.new(args)
end

function this.newCreateActor(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.actionId = tonumber(actionParam[1])
	args.roleId = tonumber(actionParam[2])

	return CreateRoleClass.new(args)
end

function this.newRemoveEffect(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.roleId = tonumber(actionParam[1])
	args.effectId = tonumber(actionParam[2])

	return RemoveEffectClass.new(args)
end

function this.newPlayEffect(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.effectType = tonumber(actionParam[1])

	if args.effectType == this.EffectType.Scene then
		args.effectId = tonumber(actionParam[2])
		args.roleId = tonumber(actionParam[3])
		args.offset = LuaUtility.ActionParamToVector3(actionParam[4])
	elseif args.effectType == this.EffectType.UI then
		args.effectId = tonumber(actionParam[2])
		args.offset = LuaUtility.ActionParamToVector3(actionParam[3])
	end

	return PlayEffectClass.new(args)
end

function this.newSetDialogueImageShow(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.resourceId = tonumber(actionParam[1])

	return SetDialogueImageShowClass.new(args)
end

function this.newChangeRoleDirection(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.roleId = tonumber(actionParam[1])
	args.direction = tonumber(actionParam[2])

	return ChangeRoleDirectionClass.new(args)
end

function this.newSwitchVirtualCamera(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.cfgType = createParams.cfgType
	args.cameraId = tonumber(actionParam[1])

	return SwitchVirtualCameraClass.new(args)
end

function this.newShowFilter(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.filterType = tonumber(actionParam[1])
	args.isShow = tonumber(actionParam[2]) == 1
	args.cfgType = createParams.cfgType

	return ShowFilterClass.new(args)
end

function this.newActorMove(actionType, actionParam, createParams)
	local args = {}

	args.actionType = actionType
	args.actorId = tonumber(actionParam[1])
	args.animationName = actionParam[2]
	args.moveSpeed = tonumber(actionParam[3])

	local posArray = string.split(actionParam[4], ",")

	args.endPos = Vector3.New(tonumber(posArray[1]), tonumber(posArray[2]), tonumber(posArray[3]))
	args.cfgType = createParams.cfgType

	return ActorMoveClass.new(args)
end

function this.newSetActorActive(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.actorId = tonumber(actionParam[1])
	args.state = tonumber(actionParam[2])

	return SetActorActiveClass.new(args)
end

function this.newShowActionSelect(actionType, actionParam, params)
	local args = {}

	args.actionType = actionType
	args.actionParam = actionParam
	args.clickCallBack = params.clickCallBack

	return ShowActionSelectClass.new(args)
end

function this.newSetStandPaintPos(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.dir = tonumber(actionParam[1])

	return SetStandPaintPosClass.new(args)
end

function this.newRefreshStandPaint(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.resourceId = tonumber(actionParam[1])

	return RefreshStandPaintClass.new(args)
end

function this.newChangeBGM(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.soundId = tonumber(actionParam[1])

	return ChangeBGMClass.new(args)
end

function this.newChangeRole(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.actorId = tonumber(actionParam[1])
	args.skinId = tonumber(actionParam[2])

	return ChangeRoleClass.new(args)
end

function this.newSwitchTime(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.time = tonumber(actionParam[1])

	return SwitchTimeClass.new(args)
end

function this.newPlayAnimation(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.actorId = tonumber(actionParam[1])
	args.animationId = tonumber(actionParam[2])
	args.duration = actionParam[3] and tonumber(actionParam[3]) or 0

	return PlayAnimationClass.new(args)
end

function this.newWorldMapComponentActionEnd(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.actionId = tonumber(actionParam[1])

	return WorldMapComponentActionEndClass.new(args)
end

function this.newEnterStory(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.chapterPassType = tonumber(actionParam[1])
	args.chapterId = tonumber(actionParam[2])

	return EnterStoryClass.new(args)
end

function this.newGetTask(actionType, actionParam)
	local args = {}

	args.actionType = actionType
	args.taskId = tonumber(actionParam[1])

	return GetTaskClass.new(args)
end

function this.newShowDialog(actionType, actionParam, params)
	local args = {}

	args.actionType = actionType
	args.cfgType = params.cfgType
	args.dialogueController = params.dialogueController
	args.dialogId = tonumber(actionParam[2])
	args.roleId = tonumber(actionParam[1])

	return ShowDialogActionClass.new(args)
end

function this.newEndDialog(actionType, actionParam, params)
	local args = {}

	args.actionType = actionType
	args.cfgType = params.cfgType
	args.roleId = actionParam[1]

	return EndDialogClass.new(args)
end

function this.AddEffect(roleId, effectId, effect)
	if not this.actionEffectDic then
		this.actionEffectDic = {}
	end

	if not this.actionEffectDic[roleId] then
		this.actionEffectDic[roleId] = {}
	end

	local data = {}

	data.effectId = effectId
	data.gameObject = effect

	table.insert(this.actionEffectDic[roleId], data)
end

function this.RemoveEffect(roleId, effectId)
	if not this.actionEffectDic then
		this.actionEffectDic = {}
	end

	if not this.actionEffectDic[roleId] then
		return
	end

	local len = #this.actionEffectDic[roleId]

	for i = len, 1, -1 do
		if this.actionEffectDic[roleId][i].effectId == effectId then
			GameObject.Destroy(this.actionEffectDic[roleId][i].gameObject)
			table.remove(this.actionEffectDic[roleId], i)
		end
	end
end

function this.GetActorDataWithCfgType(cfgType, roleId)
	local actorData = {}

	if cfgType == Constant.CommonDialogCfgType.Main then
		local component = HomeModule.GetRoomComponentWithId(roleId)

		actorData.mountPoint = component:GetDialogMountPoint()
		actorData.nameString = component:GetName()
	end

	return actorData
end

function this.GetDialogCfgWithCfgType(cfgType, dialogueId)
	local cfgDialogue

	if cfgType == Constant.CommonDialogCfgType.Main then
		cfgDialogue = CfgUtil.GetCfgMainDialogueDataWithID(dialogueId)
	end

	if not cfgDialogue then
		logError("【公共对话】没有找到对话 id = " .. dialogueId .. "的配置")

		return
	end

	return cfgDialogue
end
