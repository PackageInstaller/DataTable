-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityMain\\FishingActivityMainFishView.lua

local m = {
	IsEnd = false,
	PlayerSkillPassTime = 0,
	FishPullPassTime = 0,
	PlayerSkillActionCD = 0,
	IsInitData = false,
	PlayerSkillFillAmount = 0,
	PlayerTensile = 0,
	FishTotalWeight = 0,
	PlayerSkillCD = 0,
	FishTensile = 0,
	PlayerSkillActionFillAmount = 0,
	PlayerSkillActionPassTime = 0,
	IsPause = false,
	FishingActivityDamageCellPool = {}
}
local FlightGameDamageCell = require("IQIGame.Scene.FlightChallenge.FlightGameDamageCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.FishingActivityDamageCellPool[FishingActivityConstant.DamageType.Player_Tensile] = {}
	self.FishingActivityDamageCellPool[FishingActivityConstant.DamageType.Player_Knocking] = {}

	function self.DelegateBtnCollectingRod()
		self:OnBtnCollectingRod()
	end

	function self.DelegateBtnFishingSkillAction()
		self:OnBtnFishingSkillAction()
	end

	function self.DelegatePlaySkillAction(isPlay, skillActionData)
		self:OnPlaySkillAction(isPlay, skillActionData)
	end
end

function m:AddListener()
	self.BtnCollectingRod:GetComponent("Button").onClick:AddListener(self.DelegateBtnCollectingRod)
	self.BtnFishingSkill:GetComponent("Button").onClick:AddListener(self.DelegateBtnFishingSkillAction)
	EventDispatcher.AddEventListener(EventID.FishingActivityPlaySkillActionEvent, self.DelegatePlaySkillAction)
end

function m:RemoveListener()
	self.BtnCollectingRod:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnCollectingRod)
	self.BtnFishingSkill:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnFishingSkillAction)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityPlaySkillActionEvent, self.DelegatePlaySkillAction)
end

function m:OnPlaySkillAction(isPlay, skillActionData)
	self.IsPause = isPlay

	if isPlay then
		UnityEngine.Time.timeScale = 0
	else
		UnityEngine.Time.timeScale = 1
	end

	if not isPlay and skillActionData then
		self:PlayerSkillActionResult(skillActionData)
	end
end

function m:GetFlightGameDamageCell(type)
	for i, v in pairs(self.FishingActivityDamageCellPool[type]) do
		if not v.active then
			return v
		end
	end

	local obj

	if type == FishingActivityConstant.DamageType.Player_Tensile then
		obj = self.DamageMould
	elseif type == FishingActivityConstant.DamageType.Player_Knocking then
		obj = self.knockingMould
	end

	local flightGameDamageCell = FlightGameDamageCell.New(UnityEngine.Object.Instantiate(obj), type)

	self.FishingActivityDamageCellPool[type][flightGameDamageCell.View:GetInstanceID()] = flightGameDamageCell

	return flightGameDamageCell
end

function m:RecycleFlightGameDamage(flightGameDamageCell)
	flightGameDamageCell.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	flightGameDamageCell:Reset()

	self.FishingActivityDamageCellPool[flightGameDamageCell.type][flightGameDamageCell.View:GetInstanceID()] = flightGameDamageCell
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.FishingActivityDamageCellPool) do
		for k, cell in pairs(v) do
			if cell:IsFinished() then
				self:RecycleFlightGameDamage(cell)
			end
		end
	end

	if not self.IsInitData then
		return
	end

	if self.IsEnd then
		return
	end

	if not self.IsPause then
		if self.CfgFish then
			self.FishPullPassTime = self.FishPullPassTime + elapseSeconds * 1000

			if self.FishPullPassTime >= self.CfgFish.AttackInterval then
				self.FishPullPassTime = 0

				self:FishAttack()
			end
		end

		self.PlayerSkillPassTime = self.PlayerSkillPassTime + elapseSeconds * 1000

		self:RefreshPlayerSkillCD()

		if FishingActivityModule.isOpenAutoAttack and FishingActivityModule.IsUnlockAutoAttack() and self.PlayerSkillFillAmount >= 1 then
			self:PlayerAttack()
		end

		self.PlayerSkillActionPassTime = self.PlayerSkillActionPassTime + elapseSeconds * 1000

		self:RefreshPlayerSkillActionCD()
	end
end

function m:RefreshPlayerSkillCD()
	local per = self.PlayerSkillPassTime / self.PlayerSkillCD

	if per > 1 then
		per = 1
	end

	if self.PlayerSkillFillAmount == per then
		return
	end

	self.PlayerSkillFillAmount = per

	self.EffectCollectingRod:SetActive(per == 1)

	self.ImgCollectingRodSpeed:GetComponent("Image").fillAmount = self.PlayerSkillFillAmount
end

function m:RefreshPlayerSkillActionCD()
	local per = self.PlayerSkillActionPassTime / self.PlayerSkillActionCD

	if per > 1 then
		per = 1
	end

	if self.PlayerSkillActionFillAmount == per then
		return
	end

	self.PlayerSkillActionFillAmount = per

	self.EffectBtnFishingSkill:SetActive(per == 1)

	self.ImgFishingSkillSpeed:GetComponent("Image").fillAmount = self.PlayerSkillActionFillAmount
end

function m:SetData(data)
	self:RestDefaultData()

	self.FishData = data
	self.CfgFish = CfgFishActiveFishListTable[self.FishData.fishId]
	self.FishTotalWeight = 0

	for i = 1, #self.CfgFish.MagnificationPower do
		self.FishTotalWeight = self.FishTotalWeight + self.CfgFish.MagnificationPower[i]
	end

	self.PlayerSkillCD = FishingActivityModule.GetPlayerCfgLevelData().AttackInterval
	self.PlayerSkillActionCD = self:GetSkillActionCD()

	self:RefreshProgress()

	self.IsInitData = true
end

function m:GetSkillActionCD()
	local fishSkillData = FishingActivityModule.GetFishingSkillDataByGroup(FishingActivityConstant.SkillGroup.Skill_Reduce_CD)

	if fishSkillData then
		return fishSkillData:GetCfgLvData().SkillParams[2]
	end

	return 0
end

function m:FishAttack()
	local addTensile = self:GetRandomFishAttackValue()

	self.FishTensile = self.FishTensile + addTensile

	self:RefreshProgress()
end

function m:PlayerAttack()
	self.PlayerSkillPassTime = 0
	self.PlayerSkillFillAmount = 0

	local addTensile, isProbability = self:GetPlayerAttackValue()

	self.PlayerTensile = self.PlayerTensile + addTensile

	self:RefreshProgress()

	if isProbability then
		self:ShowPlayerAddKnocking(addTensile)
	end

	self:ShowPlayerAddTensile(addTensile)
	GameEntry.Sound:PlaySound(11103, Constant.SoundGroup.UI)
end

function m:PlayerSkillActionResult(skillActionData)
	local isProbability = false
	local addTensile = FishingActivityModule.GetPlayerCfgLevelData().Power
	local skillActionAddTensile = skillActionData:GetCfgLvData().AddPower + skillActionData:GetCfgLvData().AddTimes * addTensile

	self.PlayerTensile = self.PlayerTensile + skillActionAddTensile

	if isProbability then
		self:ShowPlayerAddKnocking(skillActionAddTensile)
	end

	self:ShowPlayerAddKnocking(skillActionAddTensile, skillActionData:GetCfgLvData().Name)
	self:RefreshProgress()
	self:ShowPlayerAddTensile(skillActionAddTensile)
	GameEntry.Sound:PlaySound(11104, Constant.SoundGroup.UI)
end

function m:ShowPlayerAddTensile(addTensile)
	local damageCell = self:GetFlightGameDamageCell(FishingActivityConstant.DamageType.Player_Tensile)

	damageCell.View.transform:SetParent(self.PlayerDamageNode.transform, false)
	damageCell.View:SetActive(true)

	damageCell.View.transform.localScale = Vector3.New(1, 1, 1)

	damageCell:SetData(FishingActivityMainUIApi:GetString("PlayerAddTensile", addTensile))
end

function m:ShowPlayerAddKnocking(value, name)
	local damageCell = self:GetFlightGameDamageCell(FishingActivityConstant.DamageType.Player_Knocking)

	if name then
		damageCell.View.transform:SetParent(self.PlayerKnockingNode.transform, false)
	else
		damageCell.View.transform:SetParent(self.PlayerProbabilityNode.transform, false)
	end

	damageCell.View:SetActive(true)

	damageCell.View.transform.localScale = Vector3.New(1, 1, 1)

	damageCell:SetData(FishingActivityMainUIApi:GetString("PlayerKnocking", value, name))
end

function m:GetPlayerAttackValue()
	local basePower = FishingActivityModule.GetPlayerCfgLevelData().Power
	local isProbability = false
	local addPower = basePower
	local fishSkillData = FishingActivityModule.GetFishingSkillDataByGroup(FishingActivityConstant.SkillGroup.Skill_Critical_Chance)

	if fishSkillData then
		local probability = fishSkillData:GetCfgLvData().SkillParams[2]
		local maxProbability = fishSkillData:GetCfgLvData().SkillParams[3]
		local randomProbability = math.random(1, maxProbability)

		if randomProbability <= probability then
			isProbability = true
		end
	end

	if isProbability then
		fishSkillData = FishingActivityModule.GetFishingSkillDataByGroup(FishingActivityConstant.SkillGroup.Skill_Critical_Multiplier)

		if fishSkillData then
			local minMultiplier = fishSkillData:GetCfgLvData().SkillParams[2]
			local maxMultiplier = fishSkillData:GetCfgLvData().SkillParams[3]
			local multiplier = math.random(minMultiplier, maxMultiplier)

			addPower = math.floor(basePower * multiplier / 100)
		end
	end

	return addPower, isProbability
end

function m:GetRandomFishAttackValue()
	local randomValue = math.random() * self.FishTotalWeight
	local cumulative = 0
	local index = 1

	for i = 1, #self.CfgFish.MagnificationPower do
		cumulative = cumulative + self.CfgFish.MagnificationPower[i]

		if randomValue <= cumulative then
			index = i

			break
		end
	end

	local magnification = self.CfgFish.Magnification[index]

	return self.CfgFish.Power * magnification
end

function m:RefreshProgress()
	local playerProgress = math.floor(self.PlayerTensile / self.CfgFish.NeedPower * 100)

	playerProgress = playerProgress > 100 and 100 or playerProgress

	local fishProgress = math.floor(self.FishTensile / self.CfgFish.NeedPower * 100)

	fishProgress = fishProgress > 100 and 100 or fishProgress

	UGUIUtil.SetText(self.PlayerTensileValue, FishingActivityMainUIApi:GetString("PlayerTensileValue", self.CfgFish.NeedPower))
	UGUIUtil.SetText(self.FishTensileValue, FishingActivityMainUIApi:GetString("FishTensileValue", self.CfgFish.NeedPower))
	UGUIUtil.SetText(self.PlayerPercent, FishingActivityMainUIApi:GetString("PlayerPercent", playerProgress))
	UGUIUtil.SetText(self.FishPercent, FishingActivityMainUIApi:GetString("FishPercent", fishProgress))

	self.FishImgPercent:GetComponent("Image").fillAmount = fishProgress / 100
	self.PlayerImgPercent:GetComponent("Image").fillAmount = playerProgress / 100

	self:CheckResult(playerProgress, fishProgress)
end

function m:CheckResult(playerProgress, fishProgress)
	if self.IsEnd then
		return
	end

	if playerProgress >= 100 then
		self.IsEnd = true

		FishingActivityModule.FishingConfirm(true)

		return
	end

	if fishProgress >= 100 then
		self.IsEnd = true

		FishingActivityModule.FishingConfirm(false)
	end
end

function m:OnBtnCollectingRod()
	if self.PlayerSkillFillAmount < 1 then
		return
	end

	self:PlayerAttack()
end

function m:OnBtnFishingSkillAction()
	if self.IsEnd then
		return
	end

	if self.PlayerSkillActionFillAmount < 1 then
		return
	end

	self.PlayerSkillActionPassTime = 0
	self.PlayerSkillActionFillAmount = 0

	if self.OnFishingSkillActionCallBack then
		self.OnFishingSkillActionCallBack()
	end
end

function m:RestDefaultData()
	self.IsEnd = false
	self.PlayerTensile = 0
	self.FishTensile = 0
	self.IsPause = false
	self.FishPullPassTime = 0
	self.FishTotalWeight = 0
	self.PlayerSkillPassTime = 0
	self.PlayerSkillFillAmount = 0
	self.PlayerSkillActionPassTime = 0
	self.PlayerSkillActionFillAmount = 0
	self.IsInitData = false

	for i, v in pairs(self.FishingActivityDamageCellPool) do
		for k, value in pairs(v) do
			self:RecycleFlightGameDamage(value)
		end
	end
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
end

function m:Close()
	self.IsEnd = true

	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.FishingActivityDamageCellPool) do
		for k, value in pairs(v) do
			value:Dispose()
		end
	end

	self.OnFishingSkillActionCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
