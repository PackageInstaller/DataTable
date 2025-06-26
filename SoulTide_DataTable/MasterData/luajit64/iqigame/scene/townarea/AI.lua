-- chunkname: @IQIGame\\Scene\\TownArea\\AI.lua

local AI = {
	WALK_SPEED = 0.01,
	aiInterval = 5
}

function AI.New(walker)
	local obj = Clone(AI)

	obj:Init(walker)

	return obj
end

function AI:Init(walker)
	self.walker = walker

	LuaCodeInterface.BindOutlet(self.walker, self)

	self.aiTimer = Timer.New(function()
		self:OnAITimer()
	end, self.aiInterval, -1)
end

function AI:OnUpdate()
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

function AI:OnHide()
	self:StopAI()
	self:StopAITimer()
end

function AI:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.walker, self)

	self.walker = nil
end

function AI:StartAI(animation, walkArea)
	self.animation = animation
	self.walkArea = walkArea
	self.curState = nil

	self:RefreshAI()
	self:StartAITimer()
end

function AI:StopAI()
	self:StopWalk()
end

function AI:RefreshAI()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000))

	local nextState = math.random(1, 2)

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

function AI:StartWalk()
	self.enableWalk = true
	self.curState = 1

	self:RefreshWalk()
end

function AI:StopWalk()
	self.curState = nil
	self.enableWalk = false
end

function AI:RefreshWalk()
	self:RefreshWalkTargetPos()
	self:RefreshWalkFaceTo()
	self.animation.state:SetAnimation(0, "walk", true)
end

function AI:RefreshWalkTargetPos()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000))

	self.targetPos = self.walker.transform.localPosition
	self.targetPos.x = math.Random(self.walkArea[1].x, self.walkArea[2].x)

	if math.abs(self.targetPos.x - self.walker.transform.localPosition.x) < 3 then
		local temp = math.Random(-1, 1)

		if temp <= 0 then
			self.targetPos.x = self.targetPos.x + math.Random(-5, -3)
		else
			self.targetPos.x = self.targetPos.x + math.Random(3, 5)
		end
	end

	self.targetPos.x = math.min(self.targetPos.x, self.walkArea[2].x)
	self.targetPos.x = math.max(self.targetPos.x, self.walkArea[1].x)
end

function AI:RefreshWalkFaceTo()
	local checkRet = self.targetPos.x - self.walker.transform.localPosition.x
	local transRoot = self.goSpineRoot.transform
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

function AI:StartIdle()
	self.curState = 2

	self.animation.state:SetAnimation(0, "idle", true)
end

function AI:StopIdle()
	self.curState = nil
end

function AI:StartAITimer()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7) + math.random(-10000, 10000))

	local interval = math.random(2, 10)

	self.aiTimer:Reset(function()
		self:OnAITimer()
	end, interval, -1)
	self.aiTimer:Start()
end

function AI:StopAITimer()
	self.aiTimer:Stop()
end

function AI:OnAITimer()
	self:StopAITimer()
	self:RefreshAI()
	self:StartAITimer()
end

return AI
