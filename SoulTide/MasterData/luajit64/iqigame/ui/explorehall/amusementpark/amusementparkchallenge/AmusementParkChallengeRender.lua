-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkChallenge\\AmusementParkChallengeRender.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnEnterLock()
		self:OnBtnEnterLock()
	end

	function self.DelegateBtnEnter()
		self:OnBtnEnter()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnEnterLock:GetComponent("Button").onClick:AddListener(self.DelegateBtnEnterLock)
	self.BtnEnter:GetComponent("Button").onClick:AddListener(self.DelegateBtnEnter)
end

function m:RemoveListener()
	self.BtnEnterLock:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEnterLock)
	self.BtnEnter:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEnter)
end

function m:SetData(amusementParkEventData)
	self.amusementParkEventData = amusementParkEventData

	self:UpDateView()
end

function m:UpDateView()
	if self.amusementParkEventData then
		local isUnlock = self.amusementParkEventData:IsUnlock()
		local isPass, index = self.amusementParkEventData:KillProgress()

		self.Normal:SetActive(isUnlock)
		self.Lock:SetActive(not isUnlock)
		self.Tag:SetActive(isPass)
		UGUIUtil.SetText(self.TextBossNameLock, self.amusementParkEventData:GetCfgData().Name)
		UGUIUtil.SetText(self.TextBossName, self.amusementParkEventData:GetCfgData().Name)

		local path = UIGlobalApi.GetImagePath(self.amusementParkEventData:GetCfgData().BossImage)

		if isUnlock then
			AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))
		else
			AssetUtil.LoadImage(self, path, self.ImgBossLock:GetComponent("Image"))

			local conditionStr = ""
			local openLvStr = ""

			if self.amusementParkEventData:GetCfgData().UnlockCondition > 0 then
				local cfgConditionData = CfgConditionTable[self.amusementParkEventData:GetCfgData().UnlockCondition]

				conditionStr = cfgConditionData.Name
			end

			if #self.amusementParkEventData:GetCfgData().BattleBuildingLevel > 0 then
				openLvStr = AmusementParkChallengeUIApi:GetString("TextNeedLv", self.amusementParkEventData:GetCfgData().BattleBuildingLevel[2])
			end

			UGUIUtil.SetText(self.TextConditionLock, conditionStr)
			UGUIUtil.SetText(self.TextNeedLv, openLvStr)
		end
	end
end

function m:OnBtnEnterLock()
	NoticeModule.ShowNotice(21045116)
end

function m:OnBtnEnter()
	local isPass, index = self.amusementParkEventData:KillProgress()

	UIModule.Open(Constant.UIControllerName.AmusementParkChallengeDetailUI, Constant.UILayer.UI, {
		AmusementParkEventData = self.amusementParkEventData,
		Index = index
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
