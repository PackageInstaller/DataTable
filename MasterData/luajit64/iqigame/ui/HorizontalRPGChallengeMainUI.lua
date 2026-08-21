-- chunkname: @IQIGame\\UI\\HorizontalRPGChallengeMainUI.lua

local HorizontalRPGChallengeMainUI = {
	lastIndex = 0,
	index = 0,
	CurrencyControllers = {},
	horizontalRPGListDataTab = {},
	horizontalRPGChallengePosCellPool = {}
}

HorizontalRPGChallengeMainUI = Base:Extend("HorizontalRPGChallengeMainUI", "IQIGame.Onigao.UI.HorizontalRPGChallengeMainUI", HorizontalRPGChallengeMainUI)

require("IQIGame.UIExternalApi.HorizontalRPGChallengeMainUIApi")

local HorizontalRPGChallengePosCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGChallengeMain.HorizontalRPGChallengePosCell")

function HorizontalRPGChallengeMainUI:OnInit()
	self.MoneyGridMould:SetActive(false)

	self.cfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]
	self.EnergyCell = EnergyCell.New(self.EnergyCom)

	self:AddCurrencyCell(self.cfgHorizontalRPGControlData.MoneyId)

	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateUpdateChallengeBoss()
		self:OnUpdateChallenge()
	end

	function self.DelegateUnLockLevels()
		self:OnUnLockLevels()
	end
end

function HorizontalRPGChallengeMainUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGChallengeMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGChallengeMainUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGChallengeMainUI:GetBGM(userData)
	return nil
end

function HorizontalRPGChallengeMainUI:OnOpen(userData)
	HorizontalRPGModule.CheckResumeDialog()

	self.openType = userData.openType

	UGUIUtil.SetText(self.TitleText, HorizontalRPGChallengeMainUIApi:GetString("TitleText", self.openType))
	self:RefreshPointNode()
	self:UpdateView(false)
end

function HorizontalRPGChallengeMainUI:OnClose(userData)
	self.lastIndex = 0

	for i, v in pairs(self.horizontalRPGChallengePosCellPool) do
		v:Dispose()
	end
end

function HorizontalRPGChallengeMainUI:OnAddListeners()
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGUnLockLevelsEvent, self.DelegateUnLockLevels)
end

function HorizontalRPGChallengeMainUI:OnRemoveListeners()
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGUnLockLevelsEvent, self.DelegateUnLockLevels)
end

function HorizontalRPGChallengeMainUI:OnPause()
	return
end

function HorizontalRPGChallengeMainUI:OnResume()
	return
end

function HorizontalRPGChallengeMainUI:OnCover()
	return
end

function HorizontalRPGChallengeMainUI:OnReveal()
	return
end

function HorizontalRPGChallengeMainUI:OnRefocus(userData)
	return
end

function HorizontalRPGChallengeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGChallengeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGChallengeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGChallengeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGChallengeMainUI:OnDestroy()
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function HorizontalRPGChallengeMainUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.MoneyGridMould)

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	currencyModule:SetActive(true)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function HorizontalRPGChallengeMainUI:RefreshPointNode()
	self.horizontalRPGListDataTab = {}
	self.horizontalRPGChallengePosCellPool = {}

	for i = 1, #self.cfgHorizontalRPGControlData.EventGroup do
		local id = self.cfgHorizontalRPGControlData.EventGroup[i]
		local cfgData = CfgHorizontalRPGListTable[id]

		if cfgData.Difficulty == self.openType then
			table.insert(self.horizontalRPGListDataTab, cfgData)
		end
	end

	table.sort(self.horizontalRPGListDataTab, function(a, b)
		return a.Order < b.Order
	end)

	for i = 1, #self.horizontalRPGListDataTab do
		local cfgData = self.horizontalRPGListDataTab[i]
		local pointRoot = self.Nodes.transform:Find("Point_" .. i)

		if pointRoot ~= nil then
			local gameObj

			if cfgData.LineDirection == 1 then
				gameObj = UnityEngine.Object.Instantiate(self.Model1)
			elseif cfgData.LineDirection == 2 then
				gameObj = UnityEngine.Object.Instantiate(self.Model2)
			end

			if gameObj then
				gameObj.transform:SetParent(pointRoot, false)
				gameObj:SetActive(true)

				local PlotPosCell = HorizontalRPGChallengePosCell.New(gameObj)

				PlotPosCell:SetCfgData(cfgData, i)

				self.horizontalRPGChallengePosCellPool[i] = PlotPosCell
			end
		else
			logError("没有找到位置为" .. i .. "的挂点")
		end
	end
end

function HorizontalRPGChallengeMainUI:OnUpdateChallenge()
	if HorizontalRPGModule.IsShow() then
		self:UpdateView(true)
	end
end

function HorizontalRPGChallengeMainUI:OnUnLockLevels()
	if HorizontalRPGModule.IsShow() then
		self:UpdateView(true)
	end
end

function HorizontalRPGChallengeMainUI:UpdateView(playEffect)
	local passedNodeType = {}
	local finnishLevels = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.finnishLevels or {}

	for i = 1, #finnishLevels do
		local id = finnishLevels[i]

		if CfgHorizontalRPGListTable[id].Difficulty == self.openType then
			table.insert(passedNodeType, id)
		end
	end

	local openCount = #passedNodeType

	self.index = openCount + 1

	if self.lastIndex ~= self.index then
		self.lastIndex = self.index

		for i, v in pairs(self.horizontalRPGChallengePosCellPool) do
			if i == self.index then
				if playEffect then
					v:PlayLineEffect()
				else
					v:UpdateView(1)
				end

				local BGImgPath = UIGlobalApi.GetImagePath(v.cfgData.BackgroundImg)

				AssetUtil.LoadImage(self, BGImgPath, self.BG:GetComponent("Image"))
			elseif i < self.index then
				v:UpdateView(2)
			else
				v:UpdateView(0)
			end
		end

		if #self.horizontalRPGChallengePosCellPool > 0 and self.index > #self.horizontalRPGChallengePosCellPool then
			self.index = #self.horizontalRPGChallengePosCellPool

			local BGImgPath = UIGlobalApi.GetImagePath(self.horizontalRPGChallengePosCellPool[self.index].cfgData.BackgroundImg)

			AssetUtil.LoadImage(self, BGImgPath, self.BG:GetComponent("Image"))
		end

		self:SetScrollContentPos(playEffect)
	end
end

function HorizontalRPGChallengeMainUI:SetScrollContentPos(playEffect)
	local minPox = self.UIController.gameObject.transform.sizeDelta.x - self.ScrollContent.transform.sizeDelta.x
	local maxPos = 0
	local itemPos = self.Nodes.transform:Find("Point_" .. self.index).position
	local canvas = self.UIController.gameObject:GetComponent("Canvas")
	local pos = inverseTransformPoint(canvas, itemPos)
	local anPox = self.ScrollContent.transform.anchoredPosition.x

	anPox = anPox - pos.x

	if anPox < minPox then
		anPox = minPox
	end

	if maxPos < anPox then
		anPox = maxPos
	end

	if playEffect then
		local tween = TweenPosition.Begin(self.ScrollContent.transform.gameObject, 1, Vector2(anPox, 0))

		tween:SetOnFinished(function()
			UnityEngine.GameObject.DestroyImmediate(tween)
		end)
	else
		self.ScrollContent.transform.anchoredPosition = Vector2.New(anPox, 0)
	end
end

function HorizontalRPGChallengeMainUI:OnClickExitBtn()
	UIModule.CloseSelf(self)
end

return HorizontalRPGChallengeMainUI
