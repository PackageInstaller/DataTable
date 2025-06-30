-- chunkname: @IQIGame\\Module\\Story\\StoryPlayer.lua

StoryPlayer = class(nil, StoryCharacter)

function StoryPlayer:InitPlayer(characterInfo)
	self:InitCharacter(characterInfo)

	self.type = Constant.StoryCharacterType.Player
	self.lastAutoMoveTargetNPCIDByClickNPC = -1
	self.rigidbody = self.gameObject:AddComponent(typeof(UnityEngine.Rigidbody))
	self.rigidbody.useGravity = false
	self.rigidbody.velocity = UnityEngine.Vector3.zero

	LuaUtility.SetRigidbodyConstraints_PosYAndRotate(self.rigidbody)

	self.playerController = self.gameObject:AddComponent(typeof(IQIGame.Onigao.Game.Story.PlayerController))
	self.canAutoMoveByClickNPC = true
	self.autoMoveConfigForClickNPC = {}
	self.autoMoveConfigForClickNPC.IsFollowingMove = false
	self.autoMoveConfigForClickNPC.MoveSpeed = 5
	self.autoMoveConfigForClickNPC.StopDistance = 2
	self.autoMoveConfigForClickNPC.IdleAnimationName = self.idleAnimationName
	self.autoMoveConfigForClickNPC.WalkAnimationName = self.walkAnimationName
	self.canInteractionWithNPC = true

	setGameObjectLayers(self.transform, "StoryPlayer")
	self:InitFSM()

	self.currentAutoMoveAnimation = self.runAnimationName
	self.stringDialogueFollower = "fx_center"
	self.stringShowClueFollower = "fx_head"
	self.dMapMoveDistance = 0

	BehaviorTreeUtility.AddJoystickControl(self, true)
end

function StoryPlayer:InitFSM()
	self.storyFSMManager.storyCharacter = self

	self.storyFSMManager:AddState(StoryMoveState())
	self.storyFSMManager:AddState(StoryIdleState())
	self.storyFSMManager:AddState(StoryInteractState())
	self.storyFSMManager:AddState(StoryTimeLineState())
	self.storyFSMManager:AddState(StoryNullState())
	self:ChangeStateByName(StoryIdleState.Name)
end

function StoryPlayer:SetClickNPCAutoMoveConfig(newAutoMoveInfo)
	if newAutoMoveInfo ~= nil then
		self.autoMoveConfigForClickNPC = newAutoMoveInfo
	else
		logError("StoryPlayer:SetClickNPCAutoMoveConfig:  newAutoMoveInfo is nil.")
	end
end

function StoryPlayer:StartAutoMoveByClickNPC(moveTargetNPCID)
	if self.canAutoMoveByClickNPC and moveTargetNPCID ~= self.lastAutoMoveTargetNPCIDByClickNPC then
		local moveSuccess = self.autoMoveController:StartAutoMove(1, moveTargetNPCID, nil, self.autoMoveConfigForClickNPC)

		if moveSuccess then
			self.lastAutoMoveTargetNPCIDByClickNPC = moveTargetNPCID
		end

		log("剧情移动相关 - 点击触发Player移动到 NPC={0}", moveTargetNPCID)
	end
end

function StoryPlayer:StartAutoMoveToTarget(targetPosition, completeCallback, successCallback, moveInfo)
	self.autoMoveController:StartAutoMoveByTarget(targetPosition, completeCallback, successCallback, moveInfo)
end

function StoryPlayer:StopMove()
	self.joystickControl:StopMove()
end

function StoryPlayer:Dispose()
	if self.autoMoveController ~= nil then
		self.autoMoveController:Dispose()
	end

	self:OnDestroy()
	GameObject.Destroy(self.gameObject)
end

return StoryPlayer
