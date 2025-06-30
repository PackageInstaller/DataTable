-- chunkname: @IQIGame\\UI\\EndlessPlusMazeDetailUI.lua

require("IQIGame.UIExternalApi.EndlessPlusMazeDetailUIApi")

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local EndlessPlusMazeDetailUI = {
	MazeCid = 0,
	LevelCid = 0
}

EndlessPlusMazeDetailUI = Base:Extend("EndlessPlusMazeDetailUI", "IQIGame.Onigao.UI.EndlessPlusMazeDetailUI", EndlessPlusMazeDetailUI)

function EndlessPlusMazeDetailUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnPlayerNumAttrsChange(itemCid, value)
		self:OnPlayerNumAttrsChange(itemCid, value)
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(Constant.ItemID.MONEY)
	self:AddCurrencyCell(Constant.ItemID.TREASURE)

	self.FormationPanelController = FormationPanelController.New(self.FormationNode, function()
		self:OnUpdateFormation()
	end)

	UGUIUtil.SetText(self.TitleText, EndlessPlusMazeDetailUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EndlessPlusMazeDetailUIApi:GetString("ConfirmBtnText"))
end

function EndlessPlusMazeDetailUI:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould"))

	return paths
end

function EndlessPlusMazeDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessPlusMazeDetailUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusMazeDetailUI:GetBGM(userData)
	return nil
end

function EndlessPlusMazeDetailUI:OnOpen(userData)
	self:UpdateView(userData.levelCid)
end

function EndlessPlusMazeDetailUI:OnClose(userData)
	return
end

function EndlessPlusMazeDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function EndlessPlusMazeDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function EndlessPlusMazeDetailUI:OnPause()
	return
end

function EndlessPlusMazeDetailUI:OnResume()
	return
end

function EndlessPlusMazeDetailUI:OnCover()
	return
end

function EndlessPlusMazeDetailUI:OnReveal()
	return
end

function EndlessPlusMazeDetailUI:OnRefocus(userData)
	return
end

function EndlessPlusMazeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessPlusMazeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessPlusMazeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessPlusMazeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessPlusMazeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self.FormationPanelController:Dispose()
end

function EndlessPlusMazeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessPlusMazeDetailUI:OnClickConfirmBtn()
	local isUnlock = EndlessPlusMazeModule.IsPreviousLevelPassed(self.LevelCid)

	if not isUnlock then
		logError("上一个关卡未通关")

		return
	end

	local validate, noticeCid, formationPOD = self:CheckMazeValidation()

	if validate then
		if noticeCid ~= 0 then
			SoulInteractionUIdule.ShowNotice(noticeCid, function()
				self:EnterMaze(formationPOD.id)
			end)
		else
			self:EnterMaze(formationPOD.id)
		end
	end
end

function EndlessPlusMazeDetailUI:EnterMaze(formationId)
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	if cfgChapterData.Type == Constant.Maze.ChapterTypeEndlessPlus then
		EndlessPlusMazeModule.SendEnterLevel(self.LevelCid, formationId)
	else
		logError("迷宫类型错误：" .. cfgChapterData.Type)
	end
end

function EndlessPlusMazeDetailUI:CheckMazeValidation()
	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not valid then
		return false, 0, nil
	end

	local valid2, noticeCid = MazeModule.CheckCanEnterMaze(self.MazeCid, formationPOD, false)

	return valid2, noticeCid, formationPOD
end

function EndlessPlusMazeDetailUI:UpdateView(levelCid)
	self.LevelCid = levelCid

	local cfgEndlessPlusLevelData = CfgEndlessPlusLevelTable[levelCid]

	self.MazeCid = cfgEndlessPlusLevelData.MazeInstanceID

	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]

	UGUIUtil.SetText(self.MazeNameText, cfgMazeInstanceData.Name)
	UGUIUtil.SetText(self.MazeDescText, cfgMazeInstanceData.Desc)

	local cfgRecommendPowerData = CfgRecommendPowerTable[cfgMazeInstanceData.RecommendPowerId]

	UGUIUtil.SetText(self.RecommendPowerText, EndlessPlusMazeDetailUIApi:GetString("RecommendPowerText", cfgRecommendPowerData.RecommendPower))
	self:UpdateCost()
	self.FormationPanelController:UpdateView()
end

function EndlessPlusMazeDetailUI:UpdateCost()
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))

	local cost = cfgMazeInstanceData.Cost
	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.MazeCid]

	if mazeInfoPOD == nil then
		cost = cfgMazeInstanceData.FirstCost
	end

	UGUIUtil.SetText(self.CostItemNumText, EndlessPlusMazeDetailUIApi:GetString("CostItemNumText", cost, cost > WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)))
end

function EndlessPlusMazeDetailUI:OnUpdateFormation()
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgRecommendPowerData = CfgRecommendPowerTable[cfgMazeInstanceData.RecommendPowerId]

	UGUIUtil.SetText(self.FormationPowerText, EndlessPlusMazeDetailUIApi:GetString("FormationPowerText", self.FormationPanelController:GetPower(), cfgRecommendPowerData.RecommendPower))
end

function EndlessPlusMazeDetailUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function EndlessPlusMazeDetailUI:OnPlayerNumAttrsChange(itemCid, value)
	if itemCid == Constant.ItemID.ENERGY then
		self:UpdateCost()
	end
end

return EndlessPlusMazeDetailUI
