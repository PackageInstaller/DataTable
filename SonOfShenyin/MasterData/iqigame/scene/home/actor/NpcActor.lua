-- chunkname: @IQIGame\\Scene\\Home\\Actor\\NpcActor.lua

local SpineActor = require("IQIGame/Scene/Home/Actor/SpineActor")
local m = Clone(SpineActor)

function m:__GetLayerName()
	return "StoryNPC"
end

function m:GetSceneActorType()
	return Constant.HomeSceneActorType.Npc
end

function m:__OnInitSpine(gameObject)
	self:__SpineActor_InitSpine(gameObject)

	local componentData = WorldMapModule.GetComponentDataWithId(self:GetComponentId())

	if self.changeModelPos then
		LuaUtility.SetPositionWithGameObject(self.skinEntityGo, self.changeModelPos.x, self.changeModelPos.y, self.changeModelPos.z)

		self.changeModelPos = nil
	else
		LuaUtility.SetPositionWithGameObject(self.skinEntityGo, componentData.pos.x, componentData.pos.y, componentData.pos.z)
	end

	self.transform = gameObject.transform
	self.nameMountPoint = self.transform:Find("Ui/namePoint")
	self.dialogMountPoint = self.transform:Find("Ui/dialogPoint")
	self.selectMountPoint = self.transform:Find("Ui/selectPoint")
	self.tagMountPoint = self.transform:Find("Ui/tagPoint")
	gameObject.name = self:GetComponentId()
	self.name = componentData:GetCfg().Name
	self.boxCollider.isTrigger = true
	self.skinEntityGo.transform.parent = self.parentTrans

	self:__OnActorPrepareReady()
	EventDispatcher.Dispatch(EventID.CommonDialogControl_OnActionComplete, Constant.CommonDialogActionType.ChangeRole)
end

function m:GetNameMountPoint()
	return self.nameMountPoint
end

function m:GetDialogMountPoint()
	return self.dialogMountPoint
end

function m:GetSelectMountPoint()
	return self.selectMountPoint
end

function m:GetName()
	return self.name
end

function m:GetTagMountPoint()
	return self.tagMountPoint
end

function m:GetComponentId()
	return self.componentId
end

function m:GetRootGameObject()
	return self.skinEntityGo
end

function m:StartMove(endPos, callBack)
	self.controller.autoMoveController:StartMove(endPos, callBack)
end

function m:StopMove()
	self.controller.autoMoveController:StopAutoMove()
end

function m:StartTalk(args)
	self.controller:ChangeStateByName(Constant.RPGActorFSMState.Chat, args)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.skinEntityGo, true)
	self.controller:InitAction()
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.skinEntityGo, false)
	self.controller:ChangeStateByName(Constant.RPGActorFSMState.Idle)
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcTagEvent, self:GetTagMountPoint())
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcNameEvent, self:GetNameMountPoint())
end

function m:GetActive()
	return self.skinEntityGo.activeSelf
end

function m:ChangeModel(skinId)
	self.controller:ChangeStateByName(Constant.RPGActorFSMState.Idle)

	self.changeModelPos = self.transform.position
	self.skinEntityGo = nil
	self.skeletonAnimation = nil
	self.boxCollider = nil
	self.skeletonData = nil

	if self.actorComponent ~= nil then
		GameObject.Destroy(self.actorComponent)

		self.actorComponent = nil
	end

	GameEntry.Entity:HideEntity(self.uniqueEntityID)

	self.transform = nil
	self.nameMountPoint = nil
	self.dialogMountPoint = nil
	self.selectMountPoint = nil
	self.actorCid = skinId

	self:__SpineActor_LoadSpine(self.actorCid)
end

function m:ChangeDirection(direction)
	self:SetFlipX(direction == 2)
end

function m:Idle()
	self:PlayAnimation(self.controller.normalIdleAnimation, true)
end

function m:__OnDispose()
	self:StopMove()
	EventDispatcher.Dispatch(EventID.MainUI_FreeNpcNameEvent, self:GetNameMountPoint())
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcTagEvent, self:GetTagMountPoint())
	self:__SpineActor_OnDispose()

	self.transform = nil
	self.nameMountPoint = nil
	self.dialogMountPoint = nil
	self.selectMountPoint = nil
end

return m
