-- chunkname: @IQIGame\\UI\\DramaChallengeMainUI.lua

local DramaChallengeMainUI = {
	lastIndex = 0,
	index = 0,
	CurrencyControllers = {},
	plotCfgTab = {},
	plotCellPool = {}
}

DramaChallengeMainUI = Base:Extend("DramaChallengeMainUI", "IQIGame.Onigao.UI.DramaChallengeMainUI", DramaChallengeMainUI)

local PlotChallengePosCell = require("IQIGame.UI.ExploreHall.PlotChallenge.PlotChallengePosCell")

function DramaChallengeMainUI:OnInit()
	self.MoneyGridMould:SetActive(false)

	self.cfgPlotGlobalData = CfgPlotChallengeActivityGlobalTable[PlotChallengeModule.GlobalCid]
	self.EnergyCell = EnergyCell.New(self.EnergyCom)

	self:AddCurrencyCell(self.cfgPlotGlobalData.Ticket)
	self:AddCurrencyCell(self.cfgPlotGlobalData.ScoreID)

	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.delegateUpdateChallengeBoss()
		self:OnUpdateChallenge()
	end
end

function DramaChallengeMainUI:GetPreloadAssetPaths()
	return nil
end

function DramaChallengeMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DramaChallengeMainUI:IsManualShowOnOpen(userData)
	return false
end

function DramaChallengeMainUI:GetBGM(userData)
	return nil
end

function DramaChallengeMainUI:OnOpen(userData)
	self.openType = userData.openType

	UGUIUtil.SetText(self.TitleText, DramaChallengeMainUIApi:GetString("TitleText", self.openType))
	self:RefreshPointNode()
	self:UpdateView(false)
end

function DramaChallengeMainUI:OnClose(userData)
	self.lastIndex = 0

	for i, v in pairs(self.plotCellPool) do
		v:Dispose()
	end
end

function DramaChallengeMainUI:OnAddListeners()
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
end

function DramaChallengeMainUI:OnRemoveListeners()
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
end

function DramaChallengeMainUI:OnPause()
	return
end

function DramaChallengeMainUI:OnResume()
	return
end

function DramaChallengeMainUI:OnCover()
	return
end

function DramaChallengeMainUI:OnReveal()
	return
end

function DramaChallengeMainUI:OnRefocus(userData)
	return
end

function DramaChallengeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DramaChallengeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DramaChallengeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DramaChallengeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DramaChallengeMainUI:OnDestroy()
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function DramaChallengeMainUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.MoneyGridMould)

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	currencyModule:SetActive(true)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function DramaChallengeMainUI:RefreshPointNode()
	self.plotCfgTab = {}
	self.plotCellPool = {}

	for i = 1, #self.cfgPlotGlobalData.Group do
		local id = self.cfgPlotGlobalData.Group[i]
		local cfgData = CfgPlotChallengeActivityTable[id]

		if cfgData.Difficulty == self.openType then
			table.insert(self.plotCfgTab, cfgData)
		end
	end

	table.sort(self.plotCfgTab, function(a, b)
		return a.Order < b.Order
	end)

	for i = 1, #self.plotCfgTab do
		local cfgData = self.plotCfgTab[i]
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

				local PlotPosCell = PlotChallengePosCell.New(gameObj)

				PlotPosCell:SetCfgData(cfgData, i)

				self.plotCellPool[i] = PlotPosCell
			end
		else
			logError("没有找到位置为" .. i .. "的挂点")
		end
	end
end

function DramaChallengeMainUI:OnUpdateChallenge()
	if PlotChallengeModule.IsShow() then
		self:UpdateView(true)
	end
end

function DramaChallengeMainUI:UpdateView(playEffect)
	local passedNodeType = {}

	for i = 1, #PlotChallengeModule.DailyDupPOD.challengeDataPOD.passedNode do
		local id = PlotChallengeModule.DailyDupPOD.challengeDataPOD.passedNode[i]

		if CfgPlotChallengeActivityTable[id].Difficulty == self.openType then
			table.insert(passedNodeType, id)
		end
	end

	local openCount = #passedNodeType

	self.index = openCount + 1

	if self.lastIndex ~= self.index then
		self.lastIndex = self.index

		for i, v in pairs(self.plotCellPool) do
			if i == self.index then
				if playEffect then
					v:PlayLineEffect()
				else
					v:UpdateView(1)
				end

				local BGImgPath = UIGlobalApi.GetImagePath(CfgPlotChallengeActivityTable[v.cfgData.Id].BackgroundImg)

				AssetUtil.LoadImage(self, BGImgPath, self.BG:GetComponent("Image"))
			elseif i < self.index then
				v:UpdateView(2)
			else
				v:UpdateView(0)
			end
		end

		if self.index > #self.plotCellPool then
			self.index = #self.plotCellPool

			local BGImgPath = UIGlobalApi.GetImagePath(CfgPlotChallengeActivityTable[self.plotCellPool[self.index].cfgData.Id].BackgroundImg)

			AssetUtil.LoadImage(self, BGImgPath, self.BG:GetComponent("Image"))
		end

		self:SetScrollContentPos(playEffect)
	end
end

function DramaChallengeMainUI:SetScrollContentPos(playEffect)
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

function DramaChallengeMainUI:OnClickExitBtn()
	UIModule.Close(Constant.UIControllerName.DramaChallengeMainUI)
end

return DramaChallengeMainUI
