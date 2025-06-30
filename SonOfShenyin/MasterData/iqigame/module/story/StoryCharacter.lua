-- chunkname: @IQIGame\\Module\\Story\\StoryCharacter.lua

StoryCharacter = class()

local StoryCharacterAutoMoveController = require("IQIGame.Module.Story.StoryCharacterAutoMoveController")

function StoryCharacter:ctor(npcID, name)
	self.npcID = npcID
	self.name = name
end

function StoryCharacter:InitCharacter(characterInfo)
	self.gameObject = characterInfo.gameObject

	GameObject.DontDestroyOnLoad(self.gameObject)
	self:InitAnimation()

	self.entityConfigID = characterInfo.entityConfigID
	self.gameObject.name = self.name
	self.transform = self.gameObject.transform
	self.skeletonAnimation = self.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

	if self.skeletonAnimation then
		self.skeletonAnimation:Initialize(true)

		self.meshRenderer = self.skeletonAnimation:GetComponent(typeof(UnityEngine.MeshRenderer))
		self.meshRenderer.sortingOrder = 0
		self.materialPropertyBlock = UnityEngine.MaterialPropertyBlock()

		self.meshRenderer:SetPropertyBlock(self.materialPropertyBlock)
	end

	self.timelineDirector = self.gameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

	if self.timelineDirector == nil then
		self.timelineDirector = self.gameObject:AddComponent(typeof(UnityEngine.Playables.PlayableDirector))
	end

	self.autoMoveController = StoryCharacterAutoMoveController.New(self.gameObject, self)
	self.storyFSMManager = StoryFSM(self)
	self.isPlayRoleSparkle = false
	self.handleUpdate = UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handleUpdate)

	self.soundList = {}
	self.moveToRunThreshold = 1.5
	self.StoryMount = self.transform:Find("story")

	if not LuaUtility.GameObjectIsNullOrEmpty(self.StoryMount) then
		self.DialogueMount = self.StoryMount:Find("StoryDialogue")
	end
end

function StoryCharacter:InitAnimation()
	self.idleAnimationName = StoryModule.DefaultIdleAnimationName
	self.walkAnimationName = StoryModule.DefaultWalkAnimationName
	self.runAnimationName = StoryModule.DefaultRunAnimationName
	self.autoMoveAnimation = StoryModule.DefaultWalkAnimationName
end

function StoryCharacter:Update()
	if self.storyFSMManager then
		self.storyFSMManager:Update()
	end

	if self.isPlayRoleSparkle then
		self:StartRoleSparkle()
	end
end

function StoryCharacter:PlayIdleAnimation()
	self:PlayAnimation(self.idleAnimationName, true)
end

function StoryCharacter:PlayAnimation(animationName, isLoop)
	if self.skeletonAnimation ~= nil and self.skeletonAnimation.state ~= nil and animationName then
		local animData = self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

		if animData ~= nil then
			if isLoop == nil then
				isLoop = false
			end

			if self.skeletonAnimation.AnimationName ~= animationName then
				self.skeletonAnimation.state:SetAnimation(0, animationName, isLoop)

				for i = #self.soundList, 1, -1 do
					if LuaUtility.StopSoundWithSerialId(self.soundList[i]) then
						self.soundList[i] = nil
					end
				end

				local CharacterId

				CharacterId = self.type == Constant.StoryCharacterType.Player and 0 or self.uniqueEntityID

				local cfgStorySoundData = CfgUtil.GetSoundIDByAnimationName(CharacterId, animationName)

				if cfgStorySoundData and cfgStorySoundData.SoundID then
					local soundID = LuaUtility.PlaySoundWithID(cfgStorySoundData.SoundID)

					if cfgStorySoundData.NeedStopOnChange then
						table.insert(self.soundList, soundID)
					end
				end
			else
				local trackEntry = self.skeletonAnimation.AnimationState:GetCurrent(0)

				if not trackEntry.Loop then
					self.skeletonAnimation.state:AddAnimation(0, animationName, isLoop, 0)
				end
			end
		end
	end
end

function StoryCharacter:AddAnimation(animationName, isLoop)
	if self.skeletonAnimation ~= nil then
		if self.skeletonAnimation.state ~= nil then
			local animData = self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

			if animData ~= nil then
				if isLoop == nil then
					isLoop = false
				end

				self.skeletonAnimation.state:AddAnimation(0, animationName, isLoop, 0)
			else
				logError(self.gameObject.name .. "找不到名为" .. animationName .. "的spine动画")
			end
		else
			logError("play spine animation error, state is null. Animation name: " .. animationName .. " gameObject: " .. self.gameObject.name)
		end
	end
end

function StoryCharacter:HasAnimation(animationName)
	if self.skeletonAnimation ~= nil and self.skeletonAnimation.state ~= nil and animationName then
		return self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)
	end
end

function StoryCharacter:SetFlipX(isFacingRight)
	if self.skeletonAnimation then
		local scaleX = isFacingRight and 1 or -1

		if self.skeletonAnimation.Skeleton.ScaleX ~= scaleX then
			self.skeletonAnimation.Skeleton.ScaleX = scaleX
		end
	else
		self.transform.localScale.x = isFacingRight
	end
end

function StoryCharacter:SetOutline(isOn)
	if not StoryModule.showName and isOn then
		return
	end

	if self.type == Constant.StoryCharacterType.RoleNPC then
		self.meshRenderer.renderingLayerMask = isOn and LayerConstant.Layer4 or LayerConstant.Layer0
	elseif self.type == Constant.StoryCharacterType.SceneObjectNPC then
		if not self.sceneRealGameObject then
			local gameObjectPath = BehaviorTreeUtility.GetNPCVariable(self.npcID, "find")

			self.sceneRealGameObject = GameObject.Find(gameObjectPath)
		end

		if self.sceneRealGameObject then
			if not self.sceneRealMeshRender then
				self.sceneRealMeshRender = self.sceneRealGameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
			end

			if isOn then
				self.sceneRealMeshRender.renderingLayerMask = LayerConstant.Layer11
			else
				self.sceneRealMeshRender.renderingLayerMask = LayerConstant.Layer1
			end
		end
	end
end

function StoryCharacter:PlayRoleSparkle()
	self.isPlayRoleSparkle = true
	self.currentRoleSparkleTime = UnityEngine.Time.time
	self.roleSparkleCurveTime = LuaUtility.GetAnimationCurveHorizontalValue(StoryModule.roleSparkleAnimationCurve)
end

function StoryCharacter:StartRoleSparkle()
	if self.type == Constant.StoryCharacterType.RoleNPC and self.materialPropertyBlock then
		local value
		local curveTime = UnityEngine.Time.time - self.currentRoleSparkleTime

		value = StoryModule.roleSparkleAnimationCurve:Evaluate(curveTime)

		if value <= 0 then
			value = 0
		elseif value >= 1 then
			value = 1
		end

		if UnityEngine.Time.time - self.currentRoleSparkleTime > self.roleSparkleCurveTime then
			self.isPlayRoleSparkle = false
			value = 0
		end

		self.materialPropertyBlock:SetFloat("_Rolesparkle", value)
		self.meshRenderer:SetPropertyBlock(self.materialPropertyBlock)
	end
end

function StoryCharacter:SetIdleAnimationName(animationName)
	self.idleAnimationName = animationName
end

function StoryCharacter:SetWalkAnimationName(animationName)
	self.walkAnimationName = animationName
end

function StoryCharacter:SetRunAnimationName(animationName)
	self.runAnimationName = animationName
end

function StoryCharacter:SetAutoMoveAnimation(animationName)
	self.autoMoveAnimation = animationName
end

function StoryCharacter:ChangeStateByName(stateName, changeEvent)
	self.storyFSMManager:ChangeStateByName(stateName, changeEvent)
end

function StoryCharacter:GetCurrentStateName()
	return self.storyFSMManager:GetCurrentStateName()
end

function StoryCharacter:GetCurrentCanAct()
	return true
end

function StoryCharacter:ChangeSkeletonDataAsset(skeletonDataAsset)
	self.skeletonAnimation.skeletonDataAsset = skeletonDataAsset

	self.skeletonAnimation:Initialize(true)
end

function StoryCharacter:GetIsJoyStickControl()
	return self.joystickControl and self.joystickControl:GetIsControl()
end

function StoryCharacter:GetGameObject()
	local o

	if self.type == Constant.StoryCharacterType.Player or self.type == Constant.StoryCharacterType.RoleNPC then
		o = self.gameObject
	elseif self.type == Constant.StoryCharacterType.SceneObjectNPC then
		if LuaUtility.GameObjectIsNullOrEmpty(self.sceneRealGameObject) then
			local gameObjectPath = BehaviorTreeUtility.GetNPCVariable(self.npcID, "find")

			self.sceneRealGameObject = GameObject.Find(gameObjectPath)
		end

		o = self.sceneRealGameObject
	end

	return o
end

function StoryCharacter:GetPosition()
	return LuaUtility.GetPositionWithGameObject(self:GetGameObject())
end

function StoryCharacter:HideGameObject()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	if self.type == Constant.StoryCharacterType.Player then
		StoryModule.HideAllCloseOutLine()

		StoryModule.insideRangeNPCs = {}

		StoryModule.NPCNamesRefresh()
	else
		StoryModule.AwayFromNPC(self.npcID)
	end
end

function StoryCharacter:ShowGameObject()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function StoryCharacter:SetName(npcNameID)
	if npcNameID == 0 then
		self.name = PlayerModule.GetName()

		return
	end

	local name = CfgUtil.GetCfgStoryTextDataWithID(npcNameID)

	self.name = name
end

function StoryCharacter:GetName()
	if self.type == Constant.StoryCharacterType.Player then
		return PlayerModule.PlayerInfo.baseInfo.pName
	else
		return self.name
	end
end

function StoryCharacter:StopSpine()
	if not self.skeletonAnimation then
		return
	end

	self.skeletonAnimation.timeScale = 0
end

function StoryCharacter:RecoverySpine()
	if not self.skeletonAnimation then
		return
	end

	self.skeletonAnimation.timeScale = 1
end

function StoryCharacter:ChangeSpineTimeScale(v)
	if not self.skeletonAnimation then
		return
	end

	self.skeletonAnimation.timeScale = v
end

function StoryCharacter:OnDestroy()
	if self.handleUpdate then
		UpdateBeat:RemoveListener(self.handleUpdate)

		self.handleUpdate = nil
	end

	self.soundList = {}

	if self.walkSoundSerializeID then
		LuaUtility.StopSoundWithSerialId(self.walkSoundSerializeID)

		self.walkSoundSerializeID = nil
	end

	if self.runSoundSerializeID then
		LuaUtility.StopSoundWithSerialId(self.runSoundSerializeID)

		self.runSoundSerializeID = nil
	end

	if self.currentWalkSound then
		self.currentWalkSound = nil
	end

	if self.joystickControl then
		self.joystickControl:OnDestroy()

		self.joystickControl = nil
	end
end

return StoryCharacter
