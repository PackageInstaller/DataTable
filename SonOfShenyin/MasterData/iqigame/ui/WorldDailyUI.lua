-- chunkname: @IQIGame\\UI\\WorldDailyUI.lua

local WorldDailyUI = {}

WorldDailyUI = Base:Extend("WorldDailyUI", "IQIGame.Onigao.UI.WorldDailyUI", WorldDailyUI)

local openAnimation_Start = "Start"
local openAnimation_StartLoop = "Start_Loop"

function WorldDailyUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function WorldDailyUI:OnOpen(userData)
	self.actionId = userData.actionId
	self.invite = userData.invite
	self.isPlayOpenAnimation = false

	if not self.actionId then
		logError("【RPG日常】日常界面没有接收到参数 actionId = " .. self.actionId)

		return
	end

	self:Refresh()
end

function WorldDailyUI:OnClose(userData)
	return
end

function WorldDailyUI:InitMembers()
	return
end

function WorldDailyUI:InitComponent()
	return
end

function WorldDailyUI:InitDelegate()
	function self.delegateOnClickButtonNext()
		self:OnClickButtonNext()
	end
end

function WorldDailyUI:OnAddListeners()
	self.buttonNext:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonNext)
end

function WorldDailyUI:OnRemoveListeners()
	self.buttonNext:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonNext)
end

function WorldDailyUI:OnClickButtonNext()
	if not self.isLoadComplete then
		return
	end

	if not self.goNextReady then
		return
	end

	if self.isStepOver then
		self.goNextReady = false

		self:SetTextContinueShow(false)
		self:CheckRewardGet()
		coroutine.start(function()
			coroutine.wait(0.2)
			UIModule.CloseSelf(self)
		end)

		return
	end

	if self.isExecuteStep then
		return
	end

	self.currentStep = self.currentStep + 1

	self:ExecuteActionStep()
end

function WorldDailyUI:GetPreloadAssetPaths()
	return nil
end

function WorldDailyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WorldDailyUI:IsManualShowOnOpen(userData)
	return false
end

function WorldDailyUI:GetBGM(userData)
	return nil
end

function WorldDailyUI:OnPause()
	return
end

function WorldDailyUI:OnResume()
	return
end

function WorldDailyUI:OnCover()
	return
end

function WorldDailyUI:OnReveal()
	return
end

function WorldDailyUI:OnRefocus(userData)
	return
end

function WorldDailyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WorldDailyUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WorldDailyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WorldDailyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.isLoadComplete then
		self:CheckLoadComplete()

		return
	end

	if not self.isPlayOpenAnimation then
		self:PlayOpenAnimation()

		return
	end

	if self.isStepOver then
		return
	end

	if self.isExecuteStep then
		if not self.crrExecute.isComplete then
			return
		end

		self:ExecuteActionStepIndex()
	end
end

function WorldDailyUI:Refresh()
	local actionData = WorldMapModule.GetComponentActionDataWithId(self.actionId)

	if actionData:GetCfg().ActionType ~= Constant.WorldRoomActionType.DailyEater then
		logError(string.format("【RPG日常】actionId = %s类型错误", actionData.cid))

		return
	end

	local cfgId = tonumber(actionData:GetCfg().ActionParam[1])
	local cfgEat = CfgUtil.GetCfgWorldMapDailyEaterDataWithID(cfgId)

	self.executeQueue = {}

	for i = 1, #cfgEat.ExecuteActionStep do
		self.executeQueue[i] = {}

		for j = 1, #cfgEat.ExecuteActionStep[i] do
			if cfgEat.ExecuteActionStep[i][j] and cfgEat.ExecuteActionStep[i][j] ~= 0 then
				local data = {}

				data.executeType = cfgEat.ExecuteActionStep[i][j]
				data.executeParam = cfgEat.ExecuteActionParam[i][j]
				data.step = i
				data.index = j
				data.isComplete = false
				self.executeQueue[i][j] = data
			end
		end
	end

	LuaUtility.LoadImage(self, cfgEat.Background, self.Bg:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.inviteActorRoot, false)
	LuaUtility.SetGameObjectShow(self.textTips, false)
	LuaUtility.SetGameObjectShow(self.inviteSpeak, false)
	self:SetTextContinueShow(false)

	if actionData:CheckCanAct() and WarehouseModule.GetItemNumByCfgID(actionData:GetCfg().TriggerCost[1]) >= actionData:GetCfg().TriggerCost[2] then
		LuaUtility.SetText(self.textTips, cfgEat.RewardsTips)
	elseif not (WarehouseModule.GetItemNumByCfgID(actionData:GetCfg().TriggerCost[1]) >= actionData:GetCfg().TriggerCost[2]) then
		LuaUtility.SetText(self.textTips, CfgUtil.GetCfgTipsTextWithID(1300070))
		LuaUtility.SetGameObjectShow(self.textTips, true)
	elseif not actionData:CheckCanAct() then
		LuaUtility.SetText(self.textTips, CfgUtil.GetCfgTipsTextWithID(1300070))
	end

	self.isActorSpineLoadComplete = true

	if not LuaUtility.StrIsNullOrEmpty(cfgEat.SpineActor) then
		AssetUtil.LoadAsset(self, cfgEat.SpineActor, self.OnActorSpineLoadSuccess)

		self.isActorSpineLoadComplete = false
	end

	self.isRoleSpineLoadComplete = true

	if self.invite and self.invite ~= 0 then
		local path = SkinModule.GetHeroCurrentSkinImgPath(self.invite, Constant.SkinImageType.DialogSpine)

		if not LuaUtility.StrIsNullOrEmpty(path) then
			AssetUtil.LoadAsset(self, path, self.OnRoleSpineLoadSuccess)

			self.isRoleSpineLoadComplete = false
		end
	end

	self.isLoadComplete = false
	self.currentStep = 0
	self.crrStepIndex = 0
	self.isStepOver = false
	self.crrExecute = nil
	self.isExecuteStep = false
end

function WorldDailyUI:OnActorSpineLoadSuccess(assetName, asset, duration, userData)
	if self.currentActorSpine then
		GameObject.Destroy(self.currentActorSpine)
	end

	self.currentActorSpine = GameObject.Instantiate(asset, self.spineActorRoot.transform)
	self.isActorSpineLoadComplete = true
end

function WorldDailyUI:OnRoleSpineLoadSuccess(assetName, asset, duration, userData)
	if self.currentRoleSpine then
		GameObject.Destroy(self.currentRoleSpine)
	end

	self.currentRoleSpine = GameObject.Instantiate(asset, self.inviteActorRoot.transform)
	self.isRoleSpineLoadComplete = true

	LuaUtility.SetGameObjectShow(self.inviteActorRoot, true)
end

function WorldDailyUI:ExecuteActionStep()
	if self.currentStep > #self.executeQueue then
		self.isStepOver = true

		return
	end

	self.goNextReady = false
	self.crrStepIndex = 0

	self:SetTextContinueShow(false)
	self:ExecuteActionStepIndex()

	self.isExecuteStep = true
end

function WorldDailyUI:ExecuteActionStepIndex()
	self.crrStepIndex = self.crrStepIndex + 1

	if self.crrStepIndex > #self.executeQueue[self.currentStep] then
		self.goNextReady = true
		self.isExecuteStep = false

		self:SetTextContinueShow(true)

		return
	end

	local executeData = self.executeQueue[self.currentStep][self.crrStepIndex]

	if not executeData then
		logError(string.format("【日常】执行步骤错误，当前大步骤 step = %s,没有可执行子步骤 stepIndex = %s", self.currentStep, self.crrStepIndex))

		return
	end

	if executeData.executeType == Constant.WorldMapDailyActionType.PlayAnimation then
		self:_PlayAnimation(executeData)
	elseif executeData.executeType == Constant.WorldMapDailyActionType.InviteSpeak then
		self:SetInviteSpeak(executeData)
	end

	self.crrExecute = executeData
	self.goNextReady = false

	self:SetTextContinueShow(false)
end

function WorldDailyUI:CheckLoadComplete()
	if self.isActorSpineLoadComplete and self.isRoleSpineLoadComplete then
		self.isLoadComplete = true
	end
end

function WorldDailyUI:CheckRewardGet()
	local actionData = WorldMapModule.GetComponentActionDataWithId(self.actionId)

	if not actionData:CheckCanAct() then
		return
	end

	WorldMapModule.TriggerAction(self.actionId, 0, self.invite and tostring(self.invite) or "")
end

function WorldDailyUI:PlayOpenAnimation()
	local spineAni = LuaUtility.GetGraphicSpineAnimationDataWithGameObject(self.currentActorSpine, openAnimation_Start)

	LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.currentActorSpine, 0, openAnimation_Start, false)
	LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.currentActorSpine, 0, openAnimation_StartLoop, true)

	self.isPlayOpenAnimation = true
	self.goNextReady = false

	self:SetTextContinueShow(false)
	self:RoleOpenAnimation()
	coroutine.start(function()
		coroutine.wait(spineAni.Duration)

		if self.invite then
			local warlockData = WarlockModule.GetHeroData(self.invite)

			if WorldMapModule.GetFoodIsRoleFavor(self.actionId, self.invite) then
				if PlayerModule.GetSex() == Constant.PlayerSex.Man then
					LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterBeforelikeMAN)
				else
					LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterBeforelikeFEMALE)
				end
			elseif PlayerModule.GetSex() == Constant.PlayerSex.Man then
				LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterBeforeMAN)
			else
				LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterBeforeFEMALE)
			end

			LuaUtility.SetGameObjectShow(self.inviteSpeak, true)
			coroutine.wait(CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.RPGDailySpeakTime) / 1000)
		end

		self.goNextReady = true

		self:SetTextContinueShow(true)
		LuaUtility.SetGameObjectShow(self.inviteSpeak, false)
	end)
end

function WorldDailyUI:RoleOpenAnimation()
	local actionData = WorldMapModule.GetComponentActionDataWithId(self.actionId)
	local cfgId = tonumber(actionData:GetCfg().ActionParam[1])
	local cfgEat = CfgUtil.GetCfgWorldMapDailyEaterDataWithID(cfgId)

	for i = 1, #cfgEat.RoleAnimation do
		if not LuaUtility.StrIsNullOrEmpty(cfgEat.RoleAnimation[i]) then
			local strArray = string.split(cfgEat.RoleAnimation[i], ",")

			if strArray[1] and strArray[2] then
				local isLoop = tonumber(strArray[2]) == 1

				LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.currentRoleSpine, 0, strArray[1], isLoop)
			end
		end
	end
end

function WorldDailyUI:_PlayAnimation(executeData)
	local aniList = string.split(executeData.executeParam, "/")
	local duration = 0

	for i = 1, #aniList do
		local str = string.split(aniList[i], ",")
		local isLoop = tonumber(str[2]) == 1 and true or false

		if i == 1 then
			LuaUtility.SetSkeletonGraphicAnimationWithGameObject(self.currentActorSpine, 0, str[1], isLoop)
		else
			LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.currentActorSpine, 0, str[1], isLoop)
		end

		if not isLoop then
			local spineAni = LuaUtility.GetGraphicSpineAnimationDataWithGameObject(self.currentActorSpine, str[1])

			duration = duration + spineAni.Duration
		end
	end

	coroutine.start(function()
		coroutine.wait(duration)

		executeData.isComplete = true
	end)
end

function WorldDailyUI:SetTextContinueShow(show)
	if not self.isTextContinueShow then
		self.isTextContinueShow = show

		LuaUtility.SetGameObjectShow(self.textContinue, show)

		return
	end

	if self.isTextContinueShow == show then
		return
	end

	LuaUtility.SetGameObjectShow(self.textContinue, show)

	self.isTextContinueShow = show
end

function WorldDailyUI:SetInviteSpeak(executeData)
	if not self.invite then
		executeData.isComplete = true

		return
	end

	local warlockData = WarlockModule.GetHeroData(self.invite)

	if WorldMapModule.GetFoodIsRoleFavor(self.actionId, self.invite) then
		if PlayerModule.GetSex() == Constant.PlayerSex.Man then
			LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterLikeMAN)
		else
			LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterLikeFEMALE)
		end
	elseif warlockData.BaseData.MapDailyEaterSpecialID == self.actionId then
		if PlayerModule.GetSex() == Constant.PlayerSex.Man then
			LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterSpecialMAN)
		else
			LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterSpecialFEMALE)
		end
	elseif PlayerModule.GetSex() == Constant.PlayerSex.Man then
		LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterMAN)
	else
		LuaUtility.SetText(self.textInviteSpeak, warlockData.BaseData.MapDailyEaterFEMALE)
	end

	LuaUtility.SetGameObjectShow(self.inviteSpeak, true)
	coroutine.start(function()
		coroutine.wait(CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.RPGDailySpeakTime) / 1000)

		executeData.isComplete = true
	end)
end

function WorldDailyUI:OnDestroy()
	self.currentActorSpine = nil
	self.currentRoleSpine = nil

	AssetUtil.UnloadAsset(self)
end

return WorldDailyUI
