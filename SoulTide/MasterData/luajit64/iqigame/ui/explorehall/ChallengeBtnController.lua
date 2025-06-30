-- chunkname: @IQIGame\\UI\\ExploreHall\\ChallengeBtnController.lua

local m = {
	DupCid = 0
}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	local prefix = "Button_DupId_"
	local startIndex = string.find(self.View.name, prefix)

	if startIndex == 1 then
		self.DupCid = tonumber(string.sub(self.View.name, startIndex + #prefix))

		if self.DupCid == nil then
			logError("按钮没有按照Button_DupId_DailyDup.Id的规范命名")
		else
			local cfgDailyDupData = CfgDailyDupTable[self.DupCid]

			if cfgDailyDupData == nil then
				logError("找不到挑战id对应的配置(配表：DailyDup)。id: " .. self.DupCid .. ", 按钮: " .. self.View.name)
			end
		end
	else
		logError("按钮没有按照Button_DupId_DailyDup.Id的规范命名")
	end

	function self.delegateUpdateWoldBossRedPoint()
		self:UpdateRedPoint()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
	EventDispatcher.AddEventListener(EventID.UpdateWoldBossRedPoint, self.delegateUpdateWoldBossRedPoint)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
	EventDispatcher.RemoveEventListener(EventID.UpdateWoldBossRedPoint, self.delegateUpdateWoldBossRedPoint)
end

function m:UpdateRedPoint()
	if self.RedPoint and self.DailyDupPOD and self.DailyDupPOD.worldBossPOD then
		self.RedPoint:SetActive(ChallengeWorldBossModule.CheckRedPoint())
	end
end

function m:SetData(dailyDupPOD)
	self.DailyDupPOD = dailyDupPOD

	local isUnlock = DailyDupModule.IsFunctionOpen(self.DupCid)
	local isOpen = false

	if isUnlock then
		isOpen = DailyDupModule.IsOpenTime(self.DupCid)
	end

	self.NormalView:SetActive(isUnlock and isOpen)
	self.LockView:SetActive(isUnlock and not isOpen)
	self.FunctionLockView:SetActive(not isUnlock)

	local cfgDailyDupData = CfgDailyDupTable[self.DupCid]

	if isUnlock then
		UGUIUtil.SetText(self.NormalNameText, cfgDailyDupData.Name)

		if self.LockNameText ~= nil then
			UGUIUtil.SetText(self.LockNameText, cfgDailyDupData.Name)
		end

		if isOpen then
			local dailyDupPod = DailyDupModule.GetDailyDupPOD(dailyDupPOD.common.cid)

			if dailyDupPod then
				local totalNum = cfgDailyDupData.Times
				local currentNum = totalNum + dailyDupPod.buyCount - dailyDupPod.enterCount

				UGUIUtil.SetText(self.NormalNumText, ExploreHallUIApi:GetString("NormalNumText", currentNum, totalNum))
			else
				UGUIUtil.SetText(self.NormalNumText, ExploreHallUIApi:GetString("NormalNumText", 0, 0))
			end
		else
			UGUIUtil.SetText(self.OpenConditionText, cfgDailyDupData.Describe)
		end
	else
		UGUIUtil.SetText(self.FunctionLockNameText, cfgDailyDupData.Name)

		local cfgFunctionTypeData = CfgFunctionTypeTable[cfgDailyDupData.OpenFunction]

		UGUIUtil.SetText(self.FunctionUnlockConditionText, cfgFunctionTypeData.LockNotice)
	end

	self:UpdateRedPoint()
end

function m:OnClickSelf()
	local isUnlock = DailyDupModule.IsFunctionOpen(self.DupCid)

	if not isUnlock then
		return
	end

	if self.DailyDupPOD ~= nil then
		self.OnClickCallback(self.DailyDupPOD)
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.DailyDupPOD = nil
	self.OnClickCallback = nil
end

return m
