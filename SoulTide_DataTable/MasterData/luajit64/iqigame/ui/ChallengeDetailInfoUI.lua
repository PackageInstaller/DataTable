-- chunkname: @IQIGame\\UI\\ChallengeDetailInfoUI.lua

local ChallengeDetailInfoUI = Base:Extend("ChallengeDetailInfoUI", "IQIGame.Onigao.UI.ChallengeDetailInfoUI", {
	PanelViews = {}
})
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local ChallengeMaterialView = require("IQIGame.UI.Challenge.ChallengeMaterialView")
local views = {}

views[Constant.ChallengeType.ChallengeGold] = ChallengeMaterialView
views[Constant.ChallengeType.ChallengeMaterial] = ChallengeMaterialView

local panels = {}

panels[Constant.ChallengeType.ChallengeGold] = {
	"/_ChallengeDetailInfoUI/MaterialUpPanel_New",
	"/_ChallengeDetailInfoUI/MaterialDownPanel_New",
	"/_ChallengeDetailInfoUI/MaterialLeftPanel_New"
}
panels[Constant.ChallengeType.ChallengeMaterial] = {
	"/_ChallengeDetailInfoUI/MaterialUpPanel_New",
	"/_ChallengeDetailInfoUI/MaterialDownPanel_New",
	"/_ChallengeDetailInfoUI/MaterialLeftPanel_New"
}

function ChallengeDetailInfoUI:OnInit()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateUpdateDailyDup()
		self:OnUpdateDailyDupEvent()
	end
end

function ChallengeDetailInfoUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeDetailInfoUI:GetOpenPreloadAssetPaths(userData)
	self.prefabPath = {
		UIGlobalApi.GetUIPrefab(panels[userData.challengeData.cfgInfo.Type][1]),
		UIGlobalApi.GetUIPrefab(panels[userData.challengeData.cfgInfo.Type][2]),
		UIGlobalApi.GetUIPrefab(panels[userData.challengeData.cfgInfo.Type][3])
	}

	local getOpenPreloadAssetPaths = views[userData.challengeData.cfgInfo.Type].GetOpenPreloadAssetPaths

	if getOpenPreloadAssetPaths ~= nil then
		local subPaths = getOpenPreloadAssetPaths()

		for i = 1, #subPaths do
			if table.indexOf(self.prefabPath, subPaths[i]) == -1 then
				table.insert(self.prefabPath, subPaths[i])
			end
		end
	end

	return self.prefabPath
end

function ChallengeDetailInfoUI:OnOpen(userData)
	self.challengeData = userData.challengeData
	self.customData = userData.customData

	self:OpenChildPanel(userData.challengeData.cfgInfo.Type)
	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE
	})
	self:UpDateView()
end

function ChallengeDetailInfoUI:OnClose(userData)
	self.PanelViews[self.challengeData.cfgInfo.Type]:Close()
end

function ChallengeDetailInfoUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.FormationPanelController:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDup)
end

function ChallengeDetailInfoUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.FormationPanelController:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDup)
end

function ChallengeDetailInfoUI:OnPause()
	return
end

function ChallengeDetailInfoUI:OnResume()
	return
end

function ChallengeDetailInfoUI:OnCover()
	return
end

function ChallengeDetailInfoUI:OnReveal()
	return
end

function ChallengeDetailInfoUI:OnRefocus(userData)
	return
end

function ChallengeDetailInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeDetailInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeDetailInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeDetailInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeDetailInfoUI:OnDestroy()
	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil

	self.energyCell:Dispose()

	self.energyCell = nil

	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil

	self.FormationPanelController:Dispose()

	for type, panelView in pairs(self.PanelViews) do
		panelView:Dispose()
	end
end

function ChallengeDetailInfoUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeDetailInfoUI)
end

function ChallengeDetailInfoUI:OpenChildPanel(type)
	local panelView = self.PanelViews[type]

	if panelView == nil then
		local prefab1 = self.UIController:GetPreloadedAsset(self.prefabPath[3])
		local prefab2 = self.UIController:GetPreloadedAsset(self.prefabPath[2])
		local prefab3 = self.UIController:GetPreloadedAsset(self.prefabPath[1])
		local objLeft = UnityEngine.Object.Instantiate(prefab1)
		local objRightDown = UnityEngine.Object.Instantiate(prefab2)
		local objRightUp = UnityEngine.Object.Instantiate(prefab3)

		objLeft.transform:SetParent(self.PointLeft.transform, false)
		objRightDown.transform:SetParent(self.PointRightDown.transform, false)
		objRightUp.transform:SetParent(self.PointRightUp.transform, false)

		panelView = views[type].New(objLeft, objRightDown, objRightUp, self)

		if panelView.Open == nil or panelView.Close == nil or panelView.UpdateView == nil or panelView.Dispose == nil then
			logError("子面板必须包含Open, Close, UpdateView, Dispose方法")
		end

		self.PanelViews[type] = panelView
	end

	self.PanelViews[type]:Open()
end

function ChallengeDetailInfoUI:OnUpdateDailyDupEvent()
	if self.challengeData then
		self.challengeData = ChallengeModule.GetChallengeDataByID(self.challengeData.cfgID)

		self:UpDateView()
	end
end

function ChallengeDetailInfoUI:UpDateView()
	if self.challengeData then
		self.FormationPanelController:UpdateView()
		UGUIUtil.SetText(self.TitleName, self.challengeData.cfgInfo.Name)
		self.PanelViews[self.challengeData.cfgInfo.Type]:UpdateView(self.challengeData, self.customData)
	end
end

function ChallengeDetailInfoUI:OnUpdateFormation()
	if self.challengeData and self.PanelViews[self.challengeData.cfgInfo.Type].OnUpdateFormation then
		self.PanelViews[self.challengeData.cfgInfo.Type]:OnUpdateFormation()
	end
end

function ChallengeDetailInfoUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, MazeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, ChallengeUIApi:GetString("TextPower", power1, power2))
end

return ChallengeDetailInfoUI
