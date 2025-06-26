-- chunkname: @IQIGame\\Module\\Main\\MainCityCharacter.lua

local m = {
	randomeAnimTime = 0,
	isMoving = false,
	randomeAnimTotalTime = 0,
	isPlayer = false
}
local PlayerSpineAnimations = {
	sitAnim = "xx_sit",
	idle = "S_stay",
	walk = "S_move"
}
local RandomeAnimations = {
	"xx_back_12",
	"win",
	"S_shy_1",
	"controlled",
	"diyshow"
}
local PlayerStateEnum = {
	RANDOMANIM = 4,
	IDLE = 2,
	DIALOGUE = 5,
	SIT = 3,
	MOVE = 1
}

function m.New(gameObject)
	local obj = Clone(m)

	obj:Init(gameObject)

	return obj
end

function m:Init(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.DelegateResetAnimationState()
		self:ResetAnimationState()
	end

	function self.DelegatePlayAnimationListFinish()
		self:PlayAnimationListFinish()
	end

	self.rigidbody = self.gameObject:AddComponent(typeof(UnityEngine.Rigidbody))
	self.rigidbody.useGravity = false
	self.rigidbody.velocity = UnityEngine.Vector3.zero

	LuaUtility.SetRigidbodyConstraints_PosYAndRotate(self.rigidbody)

	local skeletonAnim = self.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	local boxCollider = skeletonAnim.transform:GetComponent(typeof(UnityEngine.BoxCollider))

	if boxCollider == nil then
		boxCollider = skeletonAnim.gameObject:AddComponent(typeof(UnityEngine.BoxCollider))

		logError(skeletonAnim.gameObject.name .. "不存在BoxCollider")
	end

	boxCollider.isTrigger = false
	boxCollider.center = Vector3.New(0, 1, 0)
	boxCollider.size = Vector2.New(0.7, 1.9)
	self.skeletonAnimation = self.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

	if self.skeletonAnimation then
		self.skeletonAnimation:Initialize(true)

		self.meshRenderer = self.skeletonAnimation:GetComponent(typeof(UnityEngine.MeshRenderer))
		self.meshRenderer.sortingOrder = 0

		local materialPropertyBlock = UnityEngine.MaterialPropertyBlock()

		self.meshRenderer:SetPropertyBlock(materialPropertyBlock)
	end

	self.randomeAnimTotalTime = Mathf.Random(30, 60)

	self:StartRandomAnimationTimer()
end

function m:InitPlayerInfo(heroCid, pos, isPlayer)
	self.gameObject.name = isPlayer == true and "Default_" .. heroCid or "Special_" .. heroCid
	self.HeroCid = heroCid

	self:InitPlayerCharacter(isPlayer)
	self:InitPlayPos(pos)
	self:InitPlayerLayer()

	self.delay = coroutine.start(function()
		coroutine.wait(0.02)
		self:PlayIdleAnimation()
		coroutine.stop(self.delay)

		self.delay = nil
	end)
end

function m:InitPlayerCharacter(isPlayer)
	self.isPlayer = isPlayer

	if self.isPlayer == true then
		self:CreateSavePlayerInfomationTimer()
	end
end

function m:InitPlayPos(initPos)
	self.gameObject.transform.position = initPos
	self.lastTimePlayerPos = initPos
end

function m:InitPlayerLayer()
	setGameObjectLayers(self.gameObject.transform, "StoryNPC")
end

function m:PlayIdleAnimation()
	self.rigidbody.velocity = UnityEngine.Vector3.zero
	self.isMoving = false
	self.playerState = PlayerStateEnum.IDLE

	self:PlayAnimation(PlayerSpineAnimations.idle, true)
end

function m:PlayWalkAnimation()
	self.randomeAnimTime = 0
	self.isMoving = true
	self.playerState = PlayerStateEnum.MOVE

	self:PlayAnimation(PlayerSpineAnimations.walk, true)
end

function m:PlayAnimation(animationName, isLoop)
	if animationName == nil then
		animationName = PlayerSpineAnimations.idle
		isLoop = true
	end

	local animData = self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

	if animData ~= nil then
		if isLoop == nil then
			isLoop = false
		end

		if self.skeletonAnimation.AnimationName ~= animationName then
			self.skeletonAnimation.state:SetAnimation(0, animationName, isLoop)
		else
			local trackEntry = self.skeletonAnimation.AnimationState:GetCurrent(0)

			if not trackEntry.Loop then
				self.skeletonAnimation.state:AddAnimation(0, animationName, isLoop, 0)
			end
		end
	else
		logError(self.HeroCid .. "不存在" .. animationName .. "动画")
	end
end

function m:RefreshAnimationListData(animationNameList, animationLoopList, animationWhenNextList, animationWhenNextLoop)
	self.animationPlayIndex = 1
	self.animationNameList = animationNameList
	self.animationLoopList = animationLoopList
	self.animationWhenNextList = animationWhenNextList
	self.animationWhenNextLoop = animationWhenNextLoop

	self:PlayAnimationWithAnimationList(self.animationNameList, self.animationLoopList, self.animationWhenNextList, self.animationWhenNextLoop)
end

function m:PlayAnimationWithAnimationList(animationNameList, animationLoopList, animationWhenNextList, animationWhenNextLoop)
	if self.animationPlayIndex > #animationNameList then
		if animationWhenNextList[1] ~= "" then
			self:PlayAnimation(animationWhenNextList[1], animationWhenNextLoop[1])
		end

		return
	end

	local animationName = animationNameList[self.animationPlayIndex]
	local isLoop = animationLoopList[self.animationPlayIndex]
	local animData = self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

	if animData == nil then
		self.DelegatePlayAnimationListFinish()
	else
		self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.DelegatePlayAnimationListFinish

		self.skeletonAnimation.state:ClearTracks()
		self:PlayAnimation(animationName, isLoop)
	end
end

function m:PlayAnimationListFinish()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.DelegatePlayAnimationListFinish
	self.animationPlayIndex = self.animationPlayIndex + 1

	self:PlayAnimationWithAnimationList(self.animationNameList, self.animationLoopList, self.animationWhenNextList, self.animationWhenNextLoop)
end

function m:CreateSavePlayerInfomationTimer()
	self.saveInfomationTimer = Timer.New(function()
		self:SavePlayerInfomation()
	end, 3, -1)

	self.saveInfomationTimer:Start()
end

function m:StartRandomAnimationTimer()
	self.animTimer = Timer.New(function()
		self.randomeAnimTime = self.randomeAnimTime + 1

		if self.randomeAnimTime == self.randomeAnimTotalTime then
			if not self.isMoving and self.playerState == PlayerStateEnum.IDLE then
				self:SetPlayerRandomAnimation()
			end

			self.randomeAnimTime = 0
		end
	end, 1, -1)

	self.animTimer:Start()
end

function m:SetPlayerRandomAnimation()
	local index = math.random(1, #RandomeAnimations)
	local animationName = RandomeAnimations[index]
	local animData = self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

	if animData ~= nil then
		self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.DelegateResetAnimationState

		self.skeletonAnimation.state:ClearTracks()
		self:PlayAnimation(animationName, false)
	end
end

function m:ResetAnimationState()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.DelegateResetAnimationState

	self:PlayIdleAnimation()
end

function m:SetPlayerState(direction)
	if direction == Vector2.zero then
		-- block empty
	elseif direction.x ~= 0 then
		self:SetFlipX(direction.x > 0)
	end
end

function m:SetFlipX(isRight)
	if self.skeletonAnimation then
		local scaleX = isRight and 1 or -1

		if self.skeletonAnimation.Skeleton.ScaleX ~= scaleX then
			self.skeletonAnimation.Skeleton.ScaleX = scaleX
		end
	else
		self.transform.localScale.x = isRight
	end
end

function m:MoveToTarget(target)
	return
end

function m:SavePlayerInfomation()
	if self.gameObject.transform.position ~= self.lastTimePlayerPos then
		PlayerModule.SavePlayerPosAndStateC2S(self.gameObject.transform, PlayerStateEnum.IDLE)

		self.lastTimePlayerPos = self.gameObject.transform.position
	end
end

function m:SetCharacterDialogueState()
	self.playerState = PlayerStateEnum.DIALOGUE
end

function m:SetCharacterIdleState()
	self.playerState = PlayerStateEnum.IDLE
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function m:Dispose()
	if self.animTimer ~= nil then
		self.animTimer:Stop()

		self.animTimer = nil
	end

	if self.saveInfomationTimer ~= nil then
		self.saveInfomationTimer:Stop()

		self.saveInfomationTimer = nil
	end

	self.skeletonAnimation = nil
	self.meshRenderer = nil
	self.rigidbody = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	UnityEngine.Object.Destroy(self.gameObject)

	self.gameObject = nil
end

return m
