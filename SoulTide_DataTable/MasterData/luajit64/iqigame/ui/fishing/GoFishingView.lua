-- chunkname: @IQIGame\\UI\\Fishing\\GoFishingView.lua

local m = {
	lastRoleDirection = 1,
	fishBarWith = 0,
	roleControlMax = 0,
	roleControlBaseSpeed = 2,
	success = false,
	clickSpeed = 10,
	pressDown = false,
	successPer = 0,
	clickNum = 0,
	roleControlMinx = 0,
	EntityId = 0,
	isGiveUP = false,
	roleControlBackMaxSpeed = 5,
	roleControlBackSpeed = 1,
	roleControlMoveSpeed = 1,
	curRoleDirection = 1
}
local FishControlAI = require("IQIGame.UI.Fishing.FishControlAI")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.Root = root

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextTip1, HomeLandFishUIApi:GetString("TextTip1", false))
	UGUIUtil.SetText(self.TextTip2, HomeLandFishUIApi:GetString("TextTip2"))
	UGUIUtil.SetTextInChildren(self.BtnGiveUp, HomeLandFishUIApi:GetString("BtnGiveUpLabel"))

	self.progress = self.Progress:GetComponent("Image")
	self.LongBtnFishing:GetComponent("LongButton").OnPointerUpAction = function(go)
		self:OnPointerUp(go)
	end
	self.LongBtnFishing:GetComponent("LongButton").OnPointerDownAction = function(go)
		self:OnPointerDown(go)
	end

	function self.delegateLongButton()
		self:OnLongButton()
	end

	self.fishControlAI = FishControlAI.New(self.FishBar)

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateSpineThrowEnd()
		self:OnSpineThrowEnd()
	end

	function self.delegateSpineFinishEnd()
		self:OnSpineFinishEnd()
	end

	function self.delegateBtnGiveUp()
		self:OnBtnGiveUp()
	end

	self.roleControlTimer = Timer.New(function()
		self:RoleControlUpdate()
	end, 0.02, -1)

	local value = CfgDiscreteDataTable[6520081].Data[1] / 1000

	self.checkSuccessTimer = Timer.New(function()
		self:CheckSuccessUpdate()
	end, value, -1)
end

function m:AddListener()
	self.BtnGiveUp:GetComponent("Button").onClick:AddListener(self.delegateBtnGiveUp)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	self.BtnGiveUp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGiveUp)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:UpDateView()
	self:SetDefault()
end

function m:ShowRodElement(FishingRodSpine)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, FishingRodSpine, 0, self.FishingRodNode.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		GameEntry.Sound:PlaySound(10258, Constant.SoundGroup.UI)

		self.skeletonAnimation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState

		self.skeletonAnimation:SetEmptyAnimation(0, 0)
		self.skeletonAnimation:SetAnimation(0, "throw", false)

		self.skeletonAnimation.Complete = self.skeletonAnimation.Complete + self.delegateSpineThrowEnd
	end
end

function m:OnSpineThrowEnd()
	self.skeletonAnimation.Complete = self.skeletonAnimation.Complete - self.delegateSpineThrowEnd

	self.skeletonAnimation:SetEmptyAnimation(0, 0)
	self.skeletonAnimation:SetAnimation(0, "idle", true)
	self.Root:ShowBuoyEffect(1)

	local s = 2

	if self.waitTimer then
		self.waitTimer:Stop()

		self.waitTimer = nil
	end

	self.waitTimer = Timer.New(function()
		NoticeModule.ShowNotice(21042038)
		self.GoFishingNode:SetActive(true)
		self.LongBtnFishing:SetActive(true)
		self.BtnGiveUp:SetActive(true)
		self.TextTip1:SetActive(true)
		self:StartFishByRod()
		self:ShowSuccessMsg()
		self.Root:ShowBuoyEffect(2)
	end, s)

	self.waitTimer:Start()
end

function m:SetDefault()
	self.isGiveUP = false

	self.EffectCompleteNormal:SetActive(false)
	self.EffectCompleteGood:SetActive(false)
	self.EffectFailNormal:SetActive(false)
	self.EffectFailGood:SetActive(false)
	self.GoFishingNode:SetActive(false)
	self.LongBtnFishing:SetActive(false)
	self.BtnGiveUp:SetActive(false)
	self.TextTip1:SetActive(false)

	local cfgFish = CfgFishListTable[self.fishID]

	self.fishBarWith = self.Bar.transform.sizeDelta.x

	local roleV2 = self.RoleBar.transform.sizeDelta
	local length = CfgDiscreteDataTable[6520079].Data[1]
	local addBuoyEffectValue = FishingModule.GetFishGearAddEffectValue(self.selectRod, Constant.FishEffectType.Fish_Buoy_length)

	roleV2.x = length + length * addBuoyEffectValue / 100
	self.RoleBar.transform.sizeDelta = roleV2
	self.RoleBar.transform.anchoredPosition = Vector2.New(0, 0)
	self.roleControlMinx = -self.fishBarWith / 2 + roleV2.x / 2
	self.roleControlMax = self.fishBarWith / 2 - roleV2.x / 2

	local fishV2 = self.FishBar.transform.sizeDelta

	fishV2.x = CfgDiscreteDataTable[6520080].Data[1]
	self.FishBar.transform.sizeDelta = fishV2
	self.FishBar.transform.anchoredPosition = Vector2.New(0, 0)

	local fishMinx = -self.fishBarWith / 2 + fishV2.x / 2
	local fishMax = self.fishBarWith / 2 - fishV2.x / 2
	local speed = CfgDiscreteDataTable[6520085].Data[1]
	local addSpeedEffectValue = FishingModule.GetFishGearAddEffectValue(self.selectRod, Constant.FishEffectType.Fish_Reduce_Speed)

	speed = speed - speed * addSpeedEffectValue / 100
	speed = speed + speed * cfgFish.Speed / 100

	self.fishControlAI:SetDefault(self.fishID, self.selectRod, fishMinx, fishMax, speed)

	local addCfgEffectValue = FishingModule.GetFishGearAddEffectValue(self.selectRod, Constant.FishEffectType.Fish_Completion)

	self.successPer = cfgFish.InitialCompletion + cfgFish.InitialCompletion * addCfgEffectValue / 100

	self:ShowRodElement(self.selectRod.FishingRodSpine)
end

function m:StartFishByRod()
	self.clickNum = 0
	self.pressDown = false
	self.clickSpeed = CfgDiscreteDataTable[6520082].Data[1]
	self.roleControlBaseSpeed = CfgDiscreteDataTable[6520083].Data[1]
	self.roleControlBackSpeed = self.roleControlBaseSpeed
	self.roleControlMoveSpeed = self.roleControlBaseSpeed
	self.roleControlBackMaxSpeed = CfgDiscreteDataTable[6520084].Data[1]
	self.lastRoleDirection = -1
	self.curRoleDirection = -1

	self.RoleBarOut:SetActive(false)
	self.RoleBarIn:SetActive(true)
	self.fishControlAI:SetSuccess(true)
	self.roleControlTimer:Start()
	self.checkSuccessTimer:Start()
	self.fishControlAI:StartAI()
	self.skeletonAnimation:SetEmptyAnimation(0, 0)
	self.skeletonAnimation:SetAnimation(0, "shake", true)
end

function m:EndFish(success)
	self.success = success

	self.roleControlTimer:Stop()
	self.checkSuccessTimer:Stop()
	self.fishControlAI:StopAI()

	local effectTimer = Timer.New(function()
		GameEntry.Sound:PlaySound(10261, Constant.SoundGroup.UI)
		self.GoFishingNode:SetActive(false)
		self.LongBtnFishing:SetActive(false)
		self.BtnGiveUp:SetActive(false)
		self.TextTip1:SetActive(false)
		self.skeletonAnimation:SetEmptyAnimation(0, 0)
		self.skeletonAnimation:SetAnimation(0, "Finish", false)

		self.skeletonAnimation.Complete = self.skeletonAnimation.Complete + self.delegateSpineFinishEnd
	end, 1.5)

	effectTimer:Start()

	local cfgFish = CfgFishListTable[self.fishID]

	if success then
		if cfgFish.Quality == 5 then
			self.EffectCompleteGood:SetActive(true)
		else
			self.EffectCompleteNormal:SetActive(true)
		end
	elseif cfgFish.Quality == 5 then
		self.EffectFailGood:SetActive(true)
	else
		self.EffectFailNormal:SetActive(true)
	end
end

function m:OnSpineFinishEnd()
	self.skeletonAnimation.Complete = self.skeletonAnimation.Complete - self.delegateSpineFinishEnd

	FishingModule.FishingConfirm(self.success)
	self.Root:HideAllBuoyEffect()

	self.success = false

	self:Close()
end

function m:RoleControlUpdate()
	if self.pressDown or self.clickNum > 0 then
		self.curRoleDirection = 1
	else
		self.curRoleDirection = -1
	end

	local speed = self.roleControlBaseSpeed

	if self.lastRoleDirection == self.curRoleDirection then
		if self.curRoleDirection == -1 then
			if self.roleControlBackSpeed < self.roleControlBackMaxSpeed then
				self.roleControlBackSpeed = self.roleControlBackSpeed + 0.05
			end

			speed = self.roleControlBackSpeed
		else
			if self.roleControlMoveSpeed < self.roleControlBackMaxSpeed then
				self.roleControlMoveSpeed = self.roleControlMoveSpeed + 0.05
			end

			speed = self.roleControlMoveSpeed
		end
	else
		self.roleControlBackSpeed = self.roleControlBaseSpeed
		self.roleControlMoveSpeed = self.roleControlBaseSpeed
		self.lastRoleDirection = self.curRoleDirection
	end

	local offSetX = self.curRoleDirection * speed + self.clickNum * self.clickSpeed
	local anPox = self.RoleBar.transform.anchoredPosition.x + offSetX

	if anPox < self.roleControlMinx then
		anPox = self.roleControlMinx
	end

	if anPox > self.roleControlMax then
		anPox = self.roleControlMax
	end

	self.RoleBar.transform.anchoredPosition = Vector2.New(anPox, 0)
	self.clickNum = 0

	UGUIUtil.SetText(self.TextTip1, HomeLandFishUIApi:GetString("TextTip1", self.curRoleDirection == 1))
end

function m:CheckSuccessUpdate()
	local roleBarPosX = self.RoleBar.transform.anchoredPosition.x
	local roleBarWidth = self.RoleBar.transform.sizeDelta.x
	local fishBarPosX = self.FishBar.transform.anchoredPosition.x
	local fishBarWidth = self.FishBar.transform.sizeDelta.x
	local desX = math.abs(roleBarPosX - fishBarPosX)
	local isInside = false

	if desX < (roleBarWidth + fishBarWidth) / 2 then
		self.successPer = self.successPer + 2

		if self.successPer > 100 then
			self.successPer = 100
		end

		isInside = true
	else
		self.successPer = self.successPer - 2

		if self.successPer < 0 then
			self.successPer = 0
		end
	end

	self.RoleBarOut:SetActive(not isInside)
	self.RoleBarIn:SetActive(isInside)
	self.fishControlAI:SetSuccess(isInside)
	self:ShowSuccessMsg()

	if self.successPer == 0 then
		self:EndFish(false)
		GameEntry.Sound:PlaySound(10260, Constant.SoundGroup.UI)
	elseif self.successPer == 100 then
		self:EndFish(true)
		GameEntry.Sound:PlaySound(10259, Constant.SoundGroup.UI)
	end
end

function m:ShowSuccessMsg()
	UGUIUtil.SetText(self.ProgressValue, HomeLandFishUIApi:GetString("ProgressValue", self.successPer))

	self.progress.fillAmount = self.successPer / 100
end

function m:OnPointerUp()
	self.pressDown = false
end

function m:OnPointerDown()
	self.pressDown = true
end

function m:OnLongButton()
	self.clickNum = self.clickNum + 1
end

function m:OnBtnGiveUp()
	if self.successPer >= 100 then
		return
	end

	if self.isGiveUP == true then
		return
	end

	self.isGiveUP = true

	self.BtnGiveUp:SetActive(false)
	self:EndFish(false)
	GameEntry.Sound:PlaySound(10260, Constant.SoundGroup.UI)
end

function m:Open(fishRod, fishBait, fishID)
	self:AddListener()

	self.selectRod = fishRod
	self.selectBait = fishBait
	self.fishID = fishID

	self.View:SetActive(true)
	self:UpDateView()
	self.Root:ShowOrHideButtons(true)
end

function m:Close()
	self:RemoveListener()
	self.roleControlTimer:Stop()
	self.checkSuccessTimer:Stop()
	self.fishControlAI:StopAI()

	if self.waitTimer then
		self.waitTimer:Stop()
	end

	self.View:SetActive(false)
	self.Root:ShowOrHideButtons(false)
	self:HideEntity()
end

function m:Dispose()
	self.roleControlTimer:Stop()

	self.roleControlTimer = nil

	self.checkSuccessTimer:Stop()

	self.checkSuccessTimer = nil

	self.fishControlAI:Dispose()

	if self.waitTimer then
		self.waitTimer:Stop()

		self.waitTimer = nil
	end

	self:HideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
