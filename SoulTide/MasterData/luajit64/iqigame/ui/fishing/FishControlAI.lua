-- chunkname: @IQIGame\\UI\\Fishing\\FishControlAI.lua

local m = {
	nextDirectionTime = 0,
	fishPosMax = 0,
	initialSpeed = 1,
	fishSkillID = 0,
	SkillTypeAddDirection = 2,
	direction = 1,
	SkillTypeAddSpeed = 1,
	fishSkillEndTime = 0,
	fishPosMinx = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.FishMoveTimer = Timer.New(function()
		self:FishMoveUpdate()
	end, 0.02, -1)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:FishMoveUpdate()
	local nowTime = PlayerModule.GetServerTime() * 1000
	local SkillEffectAdd = self:CheckSkillEffect(nowTime)

	if nowTime > self.nextDirectionTime then
		self:ChangeDirection(SkillEffectAdd[self.SkillTypeAddDirection])
	end

	local speed = self.initialSpeed

	if SkillEffectAdd[self.SkillTypeAddSpeed] ~= nil then
		speed = speed + speed * SkillEffectAdd[self.SkillTypeAddSpeed] / 100
	end

	if GameEntry.Base.DevMode then
		log("当前鱼的移动速度 " .. speed)
	end

	local offSetX = self.direction * speed
	local anPox = self.View.transform.anchoredPosition.x + offSetX

	if anPox < self.fishPosMinx then
		anPox = self.fishPosMinx
		self.direction = 1
	end

	if anPox > self.fishPosMax then
		anPox = self.fishPosMax
		self.direction = -1
	end

	self.View.transform.localScale = Vector3.New(self.direction, 1, 1)
	self.View.transform.anchoredPosition = Vector2.New(anPox, 0)
	self.clickNum = 0
end

function m:CheckSkillEffect(time)
	local tab = {}

	if self.fishSkillID > 0 and time < self.fishSkillEndTime then
		local cfgFishSkill = CfgFishSkillListTable[self.fishSkillID]

		for i = 1, #cfgFishSkill.SkillType do
			local type = cfgFishSkill.SkillType[i]
			local value = cfgFishSkill.Skillparameter[i]

			if tab[type] == nil then
				tab[type] = value
			else
				tab[type] = tab[type] + value
			end
		end
	end

	return tab
end

function m:FishSkillUpdate()
	local cfgFish = CfgFishListTable[self.fishID]

	self.fishSkillID = 0
	self.fishSkillEndTime = 0

	if #cfgFish.Skill > 0 then
		local randomIndex = math.random(1, #cfgFish.Skill)

		self.fishSkillID = cfgFish.Skill[randomIndex]

		local cfgFishSkill = CfgFishSkillListTable[self.fishSkillID]

		self.fishSkillEndTime = PlayerModule.GetServerTime() * 1000 + cfgFishSkill.SkillTime
	end
end

function m:SetDefault(fishID, cfgFishGear, minX, maxX, speed)
	self.fishID = fishID
	self.cfgFishGear = cfgFishGear
	self.fishPosMinx = minX
	self.fishPosMax = maxX
	self.initialSpeed = speed
	self.fishSkillID = 0
	self.fishSkillEndTime = 0
end

function m:ChangeDirection(addSkillEffect)
	local cfgFish = CfgFishListTable[self.fishID]
	local randomTime = math.Random(cfgFish.SteeringInterval[1], cfgFish.SteeringInterval[2])

	if addSkillEffect then
		randomTime = randomTime - randomTime * addSkillEffect / 100
	end

	self.nextDirectionTime = randomTime + PlayerModule.GetServerTime() * 1000

	local ranValue = math.random(0, 1)

	if ranValue > 0.5 then
		self.direction = 1
	else
		self.direction = -1
	end
end

function m:SetSuccess(top)
	self.OutState:SetActive(not top)
	self.InState:SetActive(top)
end

function m:StartAI()
	self:ChangeDirection()
	self.FishMoveTimer:Start()

	local duration = CfgFishListTable[self.fishID].SkillTimes / 1000

	if self.FishSkillTimer then
		self.FishSkillTimer:Stop()

		self.FishSkillTimer = nil
	end

	self.FishSkillTimer = Timer.New(function()
		self:FishSkillUpdate()
	end, duration, -1)

	self.FishSkillTimer:Start()
end

function m:StopAI()
	self.FishMoveTimer:Stop()

	if self.FishSkillTimer then
		self.FishSkillTimer:Stop()
	end
end

function m:Dispose()
	self:RemoveListener()
	self.FishMoveTimer:Stop()

	self.FishMoveTimer = nil

	if self.FishSkillTimer then
		self.FishSkillTimer:Stop()
	end

	self.FishSkillTimer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
