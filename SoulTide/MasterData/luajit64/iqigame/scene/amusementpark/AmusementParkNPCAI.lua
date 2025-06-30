-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkNPCAI.lua

local m = {
	WALK_SPEED = 0.2,
	enableWalk = false,
	aiInterval = 5
}

function m.New(root)
	local obj = Clone(m)

	obj:Init(root)

	return obj
end

function m:Init(root)
	self.walker = root
	self.aiTimer = Timer.New(function()
		self:OnAITimer()
	end, self.aiInterval, -1)
end

function m:OnUpdate()
	if self.enableWalk then
		local direction = self.targetPos - self.walker.View.transform.localPosition

		if direction.magnitude > 0.1 then
			self.walker.View.transform:Translate(direction.normalized * self.WALK_SPEED * UnityEngine.Time.deltaTime)
		else
			self:RefreshWalk()
		end
	end
end

function m:OnHide()
	self:StopAI()
	self:StopAITimer()
end

function m:OnDestroy()
	if self.aiTimer then
		self.aiTimer:Stop()
	end

	self.aiTimer = nil
end

function m:StartAI(animation, walkArea)
	self.animation = animation
	self.walkArea = walkArea
	self.curState = nil

	self:RefreshAI()
	self:StartAITimer()
end

function m:StopAI()
	self:StopWalk()
end

function m:RefreshAI()
	local seed = tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000)
	local aiRandom = Random.New(tonumber(seed))
	local nextState = aiRandom:Range(1, 3)

	if nextState == 1 then
		if self.curState == 1 then
			self:RefreshWalk()
		else
			self:StopIdle()
			self:StartWalk()
		end
	elseif nextState == 2 and self.curState ~= 2 then
		self:StopWalk()
		self:StartIdle()
	end
end

function m:StartWalk()
	self.enableWalk = true
	self.curState = 1

	self:RefreshWalk()
end

function m:StopWalk()
	self.curState = nil
	self.enableWalk = false
end

function m:RefreshWalk()
	self:RefreshWalkTargetPos()
	self:RefreshWalkFaceTo()
	self.animation.state:SetAnimation(0, "walk", true)
end

function m:RefreshWalkTargetPos()
	self.targetPos = self.walkArea:GetRandomPoint()
end

function m:RefreshWalkFaceTo()
	local checkRet = self.targetPos.x - self.walker.View.transform.localPosition.x
	local transRoot = self.walker.goSpineRoot.transform
	local localScale = transRoot.localScale

	if checkRet > 0 then
		self.dir = 1
		localScale.x = -math.abs(localScale.x)
	else
		self.dir = -1
		localScale.x = math.abs(localScale.x)
	end

	transRoot.localScale = localScale
end

function m:StartIdle()
	self.curState = 2

	self.animation.state:SetAnimation(0, "idle", true)
end

function m:StopIdle()
	self.curState = nil
end

function m:StartAITimer()
	local seed = tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000)
	local aiRandom = Random.New(tonumber(seed))
	local interval = aiRandom:Range(2, 10)

	self.aiTimer:Reset(function()
		self:OnAITimer()
	end, interval, -1)
	self.aiTimer:Start()
end

function m:StopAITimer()
	self.aiTimer:Stop()
end

function m:OnAITimer()
	self:StopAITimer()
	self:RefreshAI()
	self:StartAITimer()
end

return m
