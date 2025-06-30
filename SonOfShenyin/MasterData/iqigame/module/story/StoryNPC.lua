-- chunkname: @IQIGame\\Module\\Story\\StoryNPC.lua

StoryNPC = class(nil, StoryCharacter)

function StoryNPC:InitNPC(characterInfo, uniqueEntityID, npcSetting)
	self:InitCharacter(characterInfo)
	self:InitNPCController(self.gameObject, npcSetting)

	if self.skeletonAnimation then
		self.type = Constant.StoryCharacterType.RoleNPC
	else
		self.type = Constant.StoryCharacterType.SceneObjectNPC
	end

	local collider = self.gameObject:AddComponent(typeof(UnityEngine.BoxCollider))

	collider.size = npcSetting.interactSetting.colliderSize
	collider.isTrigger = true
	self.uniqueEntityID = uniqueEntityID
	self.canShowName = true
	self.interActType = self.npcController.npcSetting.interActType

	setGameObjectLayers(self.transform, "StoryNPC")
	self:InitFSM()
end

function StoryNPC:InitFSM()
	self.storyFSMManager:AddState(StoryMoveState())
	self.storyFSMManager:AddState(StoryIdleState())
	self.storyFSMManager:AddState(StoryNullState())
	self:ChangeStateByName(StoryIdleState.Name)
end

function StoryNPC:InitNPCController(gameObject, npcSetting)
	for j = 0, npcSetting.triggerSettings.Count - 1 do
		local triggerSetting = npcSetting.triggerSettings[j]
		local behaviorTree = gameObject:AddComponent(typeof(BehaviorDesigner.Runtime.BehaviorTree))

		behaviorTree.StartWhenEnabled = false
		behaviorTree.PauseWhenDisabled = false
		behaviorTree.ExternalBehavior = triggerSetting.triggerExternalBehaviorTree

		if triggerSetting.triggerExternalBehaviorTree then
			behaviorTree.BehaviorName = triggerSetting.triggerExternalBehaviorTree.name
		end
	end

	self.npcController = self.gameObject:AddComponent(typeof(IQIGame.Onigao.Game.Story.NPCController))
	self.npcController.npcSetting = npcSetting
	self.stringShowClueFollower = npcSetting.stringShowClueFollower
	self.stringDialogueFollower = npcSetting.stringDialogueFollower
	self.NameFollower = self.transform:Find(npcSetting.stringNameFollower)
end

function StoryNPC:OnStartInteract()
	if self.NPCNameItem and self.NPCNameItem.isShow == true then
		self.NPCNameItem:PlayClickAnimation()
	end

	self:PlayRoleSparkle()
	self.npcController:TriggerInteractStart()
end

function StoryNPC:SetFlipX(isFacingRight)
	if self.skeletonAnimation then
		if CfgElementEntityTable[self.npcController.npcSetting.prefabEntityID] and not CfgElementEntityTable[self.npcController.npcSetting.prefabEntityID].IsPrefabFaceToRight then
			isFacingRight = not isFacingRight
		end

		local scaleX = isFacingRight and 1 or -1

		if self.skeletonAnimation.Skeleton.ScaleX ~= scaleX then
			self.skeletonAnimation.Skeleton.ScaleX = scaleX
		end
	else
		self.transform.localScale.x = isFacingRight
	end
end

function StoryNPC:StopInteract()
	self.npcController:TriggerInteractEnd()
end

function StoryNPC:GetInterActType()
	return self.interActType
end

function StoryNPC:SendTreeEvent(treeName, eventName)
	self.npcController:SendEventWithName(treeName, eventName)
end

function StoryNPC:Dispose()
	self:OnDestroy()
	self.autoMoveController:Dispose()
	EntityUtility.HideEntitySafelyByEntityID(self.uniqueEntityID)
end

return StoryNPC
