-- chunkname: @IQIGame\\Scene\\Home\\Actor\\PlayerActor.lua

local SpineActor = require("IQIGame/Scene/Home/Actor/SpineActor")
local PlayerActor = Clone(SpineActor)

function PlayerActor:__GetLayerName()
	return "StoryPlayer"
end

function PlayerActor:GetSceneActorType()
	return Constant.HomeSceneActorType.Player
end

function PlayerActor:__OnInitSpine(gameObject)
	self.componentId = 0

	self:__SpineActor_InitSpine(gameObject)
	self:__InitRigidbody()

	self.transform = self.skinEntityGo.transform
	self.dialogMountPoint = self.transform:Find("story/StoryDialogue")
	self.tageMountPoint = self.transform:Find("fx_foot")
	self.name = PlayerModule.GetName()

	self:__OnActorPrepareReady()
end

function PlayerActor:__InitRigidbody()
	self.rigidbody = self.skinEntityGo:AddComponent(typeof(UnityEngine.Rigidbody))
	self.rigidbody.useGravity = false
	self.rigidbody.velocity = UnityEngine.Vector3.zero

	LuaUtility.SetRigidbodyConstraints_PosYAndRotate(self.rigidbody)
end

function PlayerActor:GetDialogMountPoint()
	return self.dialogMountPoint
end

function PlayerActor:GetSelectMountPoint()
	return self.dialogMountPoint
end

function PlayerActor:GetTagMountPoint()
	return self.tageMountPoint
end

function PlayerActor:GetName()
	return self.name
end

function PlayerActor:GetComponentId()
	return self.componentId
end

function PlayerActor:StartMove(endPos, callBack)
	self.controller.autoMoveController:StartMove(endPos, callBack)
end

function PlayerActor:StopMove()
	self.controller.autoMoveController:StopAutoMove()
end

function PlayerActor:StartTalk(args)
	self.controller:ChangeStateByName(Constant.RPGActorFSMState.Chat, args)
end

function PlayerActor:ChangeDirection(direction)
	self:SetFlipX(direction == 2)
end

function PlayerActor:GetRootGameObject()
	return self.skinEntityGo
end

function PlayerActor:Idle()
	self:PlayAnimation(self.controller.normalIdleAnimation, true)
end

function PlayerActor:__OnDispose()
	self:StopMove()

	if self.rigidbody ~= nil then
		GameObject.Destroy(self.rigidbody)

		self.rigidbody = nil
	end

	self:__SpineActor_OnDispose()

	self.transform = nil
	self.dialogMountPoint = nil
end

return PlayerActor
