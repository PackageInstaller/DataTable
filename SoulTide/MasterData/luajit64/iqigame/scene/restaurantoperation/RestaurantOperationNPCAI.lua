-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationNPCAI.lua

local RestaurantOperationNPCAI = {
	WALK_SPEED = 0.01,
	aiInterval = 5
}

function RestaurantOperationNPCAI.New(walker)
	local obj = Clone(RestaurantOperationNPCAI)

	obj:Init(walker)

	return obj
end

function RestaurantOperationNPCAI:Init(walker)
	self.walker = walker

	LuaCodeInterface.BindOutlet(self.walker, self)

	self.aiTimer = Timer.New(function()
		self:OnAITimer()
	end, self.aiInterval, -1)
end

function RestaurantOperationNPCAI:OnUpdate()
	if not LuaCodeInterface.GameObjIsDestroy(self.walker.transform) and self.enableWalk then
		if self.dir == 1 then
			if self.walker.transform.localPosition.x >= self.targetPos.x then
				self:RefreshWalk()
			end
		elseif self.dir == -1 and self.walker.transform.localPosition.x < self.targetPos.x then
			self:RefreshWalk()
		end

		self.walker.transform:Translate(Vector3.New(self.WALK_SPEED * self.dir, 0, 0))
	end
end

function RestaurantOperationNPCAI:OnHide()
	self:StopAI()
	self:StopAITimer()
end

function RestaurantOperationNPCAI:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.walker, self)

	self.walker = nil
end

function RestaurantOperationNPCAI:StartAI(animation, walkArea)
	self.animation = animation
	self.walkArea = walkArea
	self.curState = nil

	self:RefreshAI()
	self:StartAITimer()
end

function RestaurantOperationNPCAI:StopAI()
	self:StopWalk()
end

function RestaurantOperationNPCAI:RefreshAI()
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

function RestaurantOperationNPCAI:StartWalk()
	self.enableWalk = true
	self.curState = 1

	self:RefreshWalk()
end

function RestaurantOperationNPCAI:StopWalk()
	self.curState = nil
	self.enableWalk = false
end

function RestaurantOperationNPCAI:RefreshWalk()
	self:RefreshWalkTargetPos()
	self:RefreshWalkFaceTo()
	self.animation.state:SetAnimation(0, "walk", true)
end

function RestaurantOperationNPCAI:RefreshWalkTargetPos()
	local seed = tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000)
	local aiRandom = Random.New(tonumber(seed))

	self.targetPos = self.walker.transform.localPosition
	self.targetPos.x = aiRandom:Range(self.walkArea.leftPos.x, self.walkArea.rightPos.x)

	if math.abs(self.targetPos.x - self.walker.transform.localPosition.x) < 3 then
		local temp = aiRandom:Range(-1, 1)

		if temp < 0 then
			self.targetPos.x = self.targetPos.x + aiRandom:Range(-5, -3)
		else
			self.targetPos.x = self.targetPos.x + aiRandom:Range(3, 5)
		end
	end

	self.targetPos.x = math.min(self.targetPos.x, self.walkArea.rightPos.x)
	self.targetPos.x = math.max(self.targetPos.x, self.walkArea.leftPos.x)
end

function RestaurantOperationNPCAI:RefreshWalkFaceTo()
	local checkRet = self.targetPos.x - self.walker.transform.localPosition.x
	local transRoot = self.goSpineRoot.transform
	local localScale = transRoot.localScale

	if checkRet > 0 then
		self.dir = 1
		localScale.x = math.abs(localScale.x)
	else
		self.dir = -1
		localScale.x = -math.abs(localScale.x)
	end

	transRoot.localScale = localScale
end

function RestaurantOperationNPCAI:StartIdle()
	self.curState = 2

	self.animation.state:SetAnimation(0, "idle", true)
end

function RestaurantOperationNPCAI:StopIdle()
	self.curState = nil
end

function RestaurantOperationNPCAI:StartAITimer()
	local seed = tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000)
	local aiRandom = Random.New(tonumber(seed))
	local interval = aiRandom:Range(2, 10)

	self.aiTimer:Reset(function()
		self:OnAITimer()
	end, interval, -1)
	self.aiTimer:Start()
end

function RestaurantOperationNPCAI:StopAITimer()
	self.aiTimer:Stop()
end

function RestaurantOperationNPCAI:OnAITimer()
	self:StopAITimer()
	self:RefreshAI()
	self:StartAITimer()
end

return RestaurantOperationNPCAI
