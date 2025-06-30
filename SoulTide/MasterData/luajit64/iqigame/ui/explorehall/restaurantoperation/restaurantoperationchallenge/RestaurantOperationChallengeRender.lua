-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationChallenge\\RestaurantOperationChallengeRender.lua

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

function m:SetData(roEventMonsterData)
	self.roEventMonsterData = roEventMonsterData

	self:UpDateView()
end

function m:UpDateView()
	if self.roEventMonsterData then
		local isUnlock = self.roEventMonsterData:IsUnlock()
		local isPass, index = self.roEventMonsterData:KillProgress()

		self.Normal:SetActive(isUnlock)
		self.Lock:SetActive(not isUnlock)
		self.Tag:SetActive(isPass)
		UGUIUtil.SetText(self.TextBossNameLock, self.roEventMonsterData:GetCfgData().Name)
		UGUIUtil.SetText(self.TextBossName, self.roEventMonsterData:GetCfgData().Name)

		local path = UIGlobalApi.GetImagePath(self.roEventMonsterData:GetCfgData().BossImage)

		if isUnlock then
			AssetUtil.LoadImage(self, path, self.ImgBoss:GetComponent("Image"))
		else
			AssetUtil.LoadImage(self, path, self.ImgBossLock:GetComponent("Image"))

			local cfgConditionData = CfgConditionTable[self.roEventMonsterData:GetCfgData().UnlockCondition]

			UGUIUtil.SetText(self.TextConditionLock, cfgConditionData.Name)
		end
	end
end

function m:OnBtnEnterLock()
	NoticeModule.ShowNotice(21045088)
end

function m:OnBtnEnter()
	local isPass, index = self.roEventMonsterData:KillProgress()

	UIModule.Open(Constant.UIControllerName.RestaurantOperationChallengeDetailUI, Constant.UILayer.UI, {
		ROEventData = self.roEventMonsterData,
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
