-- chunkname: @IQIGame\\UI\\Common\\SoulSpineCell.lua

local SoulSpineCell = {
	entityId = 0
}

function SoulSpineCell.New(view)
	local obj = Clone(SoulSpineCell)

	obj:Init(view)

	return obj
end

function SoulSpineCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.cvFrame = CvUIFrame.New(self.goCvFrame)

	self.cvFrame:RefreshView()

	function self.onClickSpineDelegate()
		self:OnClickSpine()
	end

	function self.onSpineShowSuccessDelegate(sender, args)
		self:ShowSpineSuccess(sender, args)
	end

	function self.onUIOpenSuccessDelegate(sender, args)
		self:OnOpenUISuccess(sender, args)
	end

	function self.DelegateChangeResourcesEvent()
		self:RefreshHarmoniousMask()
	end
end

function SoulSpineCell:Show(soulCid, isInteractive)
	self:ShowPreview(SoulModule.GetSoulData(soulCid).dressCid2D, isInteractive, soulCid)
end

function SoulSpineCell:ShowPreview(dressCid, isInteractive, soulCid)
	self.cfgActionControlData = CfgSoulSpineActionControlTable[CfgSoulResTable[CfgDressTable[dressCid].SoulResID].SpineActionControl]
	self.isInteractive = isInteractive
	self.soulCid = soulCid

	self:OnAddListener()
	self:StopIdleTimer()
	self:StopCV()
	self:ShowSpine()
end

function SoulSpineCell:Close()
	self:OnHide()
end

function SoulSpineCell:OnUpdate()
	if self.curAnimName ~= nil then
		local isAllEnd = true

		for i, v in ipairs(self.curAnimList) do
			if v.AnimationState:GetCurrent(0) ~= nil and v.AnimationState:GetCurrent(0).Animation.Name == self.curAnimName and not v.AnimationState:GetCurrent(0).IsComplete then
				isAllEnd = false

				break
			end
		end

		if isAllEnd then
			self:OnAnimEnd()
		end
	end
end

function SoulSpineCell:OnHide()
	self:OnRemoveListener()
	self:StopIdleTimer()
	self:StopCV()
	self:StopEffect()
	self:HideEntity()
	self.cvFrame:Dispose()
end

function SoulSpineCell:OnDestroy()
	self:HideEntity()

	self.isDestroyed = true

	self.cvFrame:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulSpineCell:OnAddListener()
	self:OnRemoveListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onSpineShowSuccessDelegate)
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.onUIOpenSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.ChangeHarmoniousResourcesEvent, self.DelegateChangeResourcesEvent)
end

function SoulSpineCell:OnRemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onSpineShowSuccessDelegate)
	GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.onUIOpenSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.ChangeHarmoniousResourcesEvent, self.DelegateChangeResourcesEvent)

	if self.btnSpine ~= nil then
		self.btnSpine.onClick:RemoveListener(self.onClickSpineDelegate)
	end
end

function SoulSpineCell:OnOpenUISuccess(sender, args)
	for i, v in pairsCfg(CfgUIConfigurationTable) do
		if v.UIName == args.UIName and v.FullScreen then
			self:GotoIdleState()
			self:StopCV()

			break
		end
	end
end

function SoulSpineCell:OnClickSpine()
	self:GotoClickState()
end

function SoulSpineCell:OnAnimEnd()
	self.curAnimName = nil
	self.curActionID = nil

	if self.curState == 0 or self.curState == 2 or self.curState == 3 or self.curState == 4 then
		self:GotoIdleState()
	end
end

function SoulSpineCell:ShowSpine()
	self:HideEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()
	self.spinSerialId = GameEntry.Entity:ShowUIElement(self.entityId, self.cfgActionControlData.SoulAction, 0, self.goSpineRoot.transform, Vector3.zero)
end

function SoulSpineCell:HideEntity()
	self.goSpine = nil
	self.btnSpine = nil
	self.curAnimList = nil
	self.curAnimName = nil
	self.curActionID = nil

	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function SoulSpineCell:ShowSpineSuccess(sender, args)
	if self.isDestroyed then
		return
	end

	if self.entityId == args.Entity.Id then
		self.goSpine = args.Entity.gameObject

		if self.isInteractive then
			self.btnSpine = self.goSpine.transform:Find("SoulSpineHitArea"):GetChild(0):GetComponent("Button")

			self.btnSpine.onClick:RemoveListener(self.onClickSpineDelegate)
			self.btnSpine.onClick:AddListener(self.onClickSpineDelegate)

			if SoulModule.spineNeedGreet then
				self:GoToGreetState()
			else
				self:GotoIdleState()
			end
		else
			self:GotoIdleState()
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		local SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
		local sortingOrder = args.Entity.gameObject:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder

		if SpineRenderers ~= nil then
			for i = 0, SpineRenderers.Length - 1 do
				SpineRenderers[i].sortingOrder = sortingOrder
			end
		end

		self:RefreshHarmoniousMask()
	end
end

function SoulSpineCell:GoToGreetState()
	SoulModule.spineNeedGreet = false
	self.curState = 0

	local cfgActionData

	if self:CheckIsInTime(MiscApi:GetString("SoulSpine_MorningTime")) then
		cfgActionData = CfgSoulSpineActionTable[self.cfgActionControlData.MorningGreetings]
	elseif self:CheckIsInTime(MiscApi:GetString("SoulSpine_NoonTime")) then
		cfgActionData = CfgSoulSpineActionTable[self.cfgActionControlData.NoonGreetings]
	elseif self:CheckIsInTime(MiscApi:GetString("SoulSpine_NightTime")) then
		cfgActionData = CfgSoulSpineActionTable[self.cfgActionControlData.EveningGreetings]
	end

	self:PlayAction(cfgActionData)
end

function SoulSpineCell:GotoIdleState()
	self.curState = 1

	local isOath = self:IsOathActivation()

	if isOath and self.cfgActionControlData.IsChangeIdle then
		self:PlayAnim("idle_marry", true)
	else
		self:PlayAnim("idle", true)
	end

	if self.isInteractive then
		self:StartIdleTimer()
	end
end

function SoulSpineCell:GotoClickState()
	if self.curState == 0 or self.curState == 2 then
		return
	end

	self.curState = 2

	local isOath = self:IsOathActivation()
	local randomData = self.cfgActionControlData.TouchFeedback

	if isOath then
		for i = 1, #self.cfgActionControlData.MarryAction do
			local actionGroupID = self.cfgActionControlData.MarryAction[i]

			if table.indexOf(randomData, actionGroupID) == -1 then
				table.insert(randomData, actionGroupID)
			end
		end
	end

	local randomIndex = math.random(1, #randomData)
	local cfgActionData = CfgSoulSpineActionTable[randomData[randomIndex]]

	self:PlayAction(cfgActionData)
end

function SoulSpineCell:GotoActiveState()
	self.curState = 3

	local cfgActionData = CfgSoulSpineActionTable[self.cfgActionControlData.StandbyAction]

	self:PlayAction(cfgActionData)
end

function SoulSpineCell:PlayActionCustom(cfgActionData)
	self.curState = 4

	self:PlayAction(cfgActionData)
end

function SoulSpineCell:PlayAction(cfgActionData)
	if self.curActionID ~= nil and self.curActionID == cfgActionData.Id then
		return
	end

	self.curActionID = cfgActionData.Id

	local isOath = self:IsOathActivation()

	if isOath and cfgActionData.MarryActionState ~= nil and cfgActionData.MarryActionState ~= "" then
		self:PlayEffect(cfgActionData.MarryEffectId, cfgActionData.MarryEffectOrder)
		self:PlayAnim(cfgActionData.MarryActionState, false)
	else
		self:PlayEffect(cfgActionData.EffectId, cfgActionData.EffectOrder)
		self:PlayAnim(cfgActionData.SoulActionState, false)
	end

	self:PlayCV(cfgActionData.CV)
end

function SoulSpineCell:PlayAnim(animName, loop)
	if self.goSpine == nil then
		return
	end

	if self.curAnimList == nil then
		self.curAnimList = {}

		local childCount = self.goSpine.transform.childCount

		for i = 0, childCount - 1 do
			local anim = self.goSpine.transform:GetChild(i):GetComponent(typeof(Spine.Unity.SkeletonAnimation))

			if anim ~= nil then
				self.curAnimList[#self.curAnimList + 1] = anim
			end
		end
	end

	for i, v in ipairs(self.curAnimList) do
		if v.AnimationState ~= nil then
			local animData = v.AnimationState.Data.SkeletonData:FindAnimation(animName)

			if animData ~= nil then
				v.AnimationState:SetAnimation(0, animName, loop)

				self.curAnimName = animName
			end
		end
	end

	if loop then
		self.curAnimName = nil
		self.curActionID = nil
	end
end

function SoulSpineCell:PlayCV(cvCid)
	if cvCid == 0 then
		return
	end

	local cfgCV = CfgCVTable[cvCid]

	self:StopCV()

	local uiCanvas = self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas")

	if not uiCanvas.enabled then
		return
	end

	self.soundSerialId = GameEntry.Sound:PlaySound(cfgCV.SoundID, Constant.SoundGroup.CHARACTER)

	self.cvFrame:Open(cvCid)
	self:StartCVTimer(cfgCV.TextTime)
end

function SoulSpineCell:StopCV()
	self:StopCVTimer()
	self.cvFrame:Close()

	if self.soundSerialId ~= nil then
		GameEntry.Sound:StopSound(self.soundSerialId)

		self.soundSerialId = nil
	end
end

function SoulSpineCell:StartIdleTimer()
	if self.idleTimer == nil then
		self.idleTimer = Timer.New(function()
			self:OnIdleTimer()
		end, MiscApi:GetString("SoulSpine_IdleInterval"), -1)
	else
		self.idleTimer:Reset(function()
			self:OnIdleTimer()
		end, MiscApi:GetString("SoulSpine_IdleInterval"), -1)
	end

	self.idleTimer:Start()
end

function SoulSpineCell:StopIdleTimer()
	if self.idleTimer == nil then
		return
	end

	self.idleTimer:Stop()
end

function SoulSpineCell:OnIdleTimer()
	self:StopIdleTimer()
	self:GotoActiveState()
end

function SoulSpineCell:StartCVTimer(interval)
	if self.cvTimer == nil then
		self.cvTimer = Timer.New(function()
			self:OnCVTimer()
		end, interval, 1)
	else
		self.cvTimer:Reset(function()
			self:OnCVTimer()
		end, interval, 1)
	end

	self.cvTimer:Start()
end

function SoulSpineCell:StopCVTimer()
	if self.cvTimer == nil then
		return
	end

	self.cvTimer:Stop()
end

function SoulSpineCell:OnCVTimer()
	self:StopCVTimer()
	self.cvFrame:Close()
end

function SoulSpineCell:PlayEffect(effectID, effectOrder)
	self:StopEffect()

	if effectID == 0 then
		return
	end

	local uiCanvas = self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas")

	if uiCanvas.enabled then
		self.effectOpID = GameEntry.Effect:PlayUIMountPointEffect(effectID, 50000, 0, self.goSpine, uiCanvas.sortingOrder + effectOrder)
	end
end

function SoulSpineCell:StopEffect()
	if self.effectOpID ~= nil then
		GameEntry.Effect:StopEffect(self.effectOpID)

		self.effectOpID = nil
	end
end

function SoulSpineCell:CheckIsInTime(timeTable)
	local serverTime = PlayerModule.GetServerTime()
	local dateTimeTable = getDateTimeTable(serverTime)
	local ymd = dateTimeTable.year .. "/" .. dateTimeTable.month .. "/" .. dateTimeTable.day

	for i, v in ipairs(timeTable) do
		if i % 2 ~= 0 then
			local startTime = cfgDateTimeToTimeStamp(ymd .. " " .. v, PlayerModule.TimeZone)
			local endTime = cfgDateTimeToTimeStamp(ymd .. " " .. timeTable[i + 1], PlayerModule.TimeZone)

			if startTime <= serverTime and serverTime < endTime then
				return true
			end
		end
	end

	return false
end

function SoulSpineCell:IsOathActivation()
	local soulData = SoulModule.GetSoulData(self.soulCid)

	return soulData.oathActivation
end

function SoulSpineCell:RefreshHarmoniousMask()
	if self.goSpine and not LuaCodeInterface.GameObjIsDestroy(self.goSpine) then
		local harmoniousMask = self.goSpine.transform:Find("HarmoniousMask")

		if harmoniousMask then
			local isShow = SettingModule.harmoniousResources == 0

			harmoniousMask.gameObject:SetActive(isShow)
		end
	end
end

return SoulSpineCell
