-- chunkname: @IQIGame\\UI\\LunaBattleLineDetailUI.lua

local LunaBattleLineDetailUI = {}

LunaBattleLineDetailUI = Base:Extend("LunaBattleLineDetailUI", "IQIGame.Onigao.UI.LunaBattleLineDetailUI", LunaBattleLineDetailUI)

require("IQIGame.UIExternalApi.LunaBattleLineDetailUIApi")

local LunaBattleLineNoCampController = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleLineNoCampController")
local LunaBattleLineSetCampController = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleLineSetCampController")
local LunaBattleLineSealingController = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleLineSealingController")
local LunaBattleLineDetailController = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleLineDetailController")
local LunaBattleGarrisonNoticeController = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleGarrisonNoticeController")

function LunaBattleLineDetailUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.NoCampController = LunaBattleLineNoCampController.New(self.NoCampView, self)
	self.SetCampController = LunaBattleLineSetCampController.New(self.SetCampView, self)
	self.SealingController = LunaBattleLineSealingController.New(self.SealView, self)
	self.DetailController = LunaBattleLineDetailController.New(self.DetailView, self, function()
		self:ShowViewHideByDetail(true)
	end, function()
		self:ShowViewHideByDetail(false)
	end)
	self.NoticeController = LunaBattleGarrisonNoticeController.New(self.GarrisonNoticeView)
	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(203)
end

function LunaBattleLineDetailUI:GetPreloadAssetPaths()
	local paths = {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}

	return paths
end

function LunaBattleLineDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineDetailUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineDetailUI:GetBGM(userData)
	return nil
end

function LunaBattleLineDetailUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self:UpdateView(userData.zoneId)
end

function LunaBattleLineDetailUI:OnClose(userData)
	self.NoCampController:Hide()
	self.SetCampController:Hide()
	self.SealingController:Hide()
	self.DetailController:Hide()
	self.NoticeController:Hide()
end

function LunaBattleLineDetailUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LunaBattleLineDetailUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LunaBattleLineDetailUI:OnPause()
	return
end

function LunaBattleLineDetailUI:OnResume()
	return
end

function LunaBattleLineDetailUI:OnCover()
	return
end

function LunaBattleLineDetailUI:OnReveal()
	return
end

function LunaBattleLineDetailUI:OnRefocus(userData)
	return
end

function LunaBattleLineDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.NoticeController:OnUpdate()
end

function LunaBattleLineDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineDetailUI:OnDestroy()
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self.NoCampController:Dispose()
	self.SetCampController:Dispose()
	self.SealingController:Dispose()
	self.DetailController:Dispose()
	self.NoticeController:Dispose()
end

function LunaBattleLineDetailUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function LunaBattleLineDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineDetailUI:UpdateView(zoneId)
	local dailyDupPOD = LunaBattleLineModule.DailyDupPOD
	local zonePOD = dailyDupPOD.lunaBattleLineDataPOD.zones[zoneId]

	self.SealNum = dailyDupPOD.common.centerLunaBattleLineDataPOD.zoneSealPercentage[zoneId]

	if self.SealNum == nil then
		self.SealNum = 0
	end

	local maxSealNum = LunaBattleLineModule.MaxSealNum

	self.TitleView:SetActive(true)
	self.NoCampController:Hide()
	self.SetCampController:Hide()
	self.SealingController:Hide()
	self:HideZoneDetail()
	self.NoticeController:Show()

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zonePOD.zoneId]
	local isFortMazeFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, cfgLunaBattleLineZoneData.StationingLevel) ~= -1

	self.NoticeController:SetData(zonePOD, isFortMazeFinished)

	local step

	if not isFortMazeFinished then
		self.NoCampController:Show(zonePOD)

		step = 1
	elseif zonePOD.garrison == nil then
		self.SetCampController:Show(zonePOD)

		step = 2
	else
		self:RefreshSealingView(zonePOD.zoneId, zonePOD)

		local isSealMazeFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, cfgLunaBattleLineZoneData.SealedLevel) ~= -1

		step = isSealMazeFinished and maxSealNum <= self.SealNum and 4 or 3
	end

	self.SealProgressBar:GetComponent("Image").fillAmount = self.SealNum / maxSealNum

	UGUIUtil.SetText(self.SealProgressText, LunaBattleLineDetailUIApi:GetString("SealProgressText", self.SealNum, maxSealNum))
	UGUIUtil.SetText(self.SealProgressLabel, LunaBattleLineDetailUIApi:GetString("SealProgressLabel", self.SealNum, maxSealNum))
	UGUIUtil.SetText(self.TitleText, cfgLunaBattleLineZoneData.Name)
	UGUIUtil.SetText(self.ZoneNameText, cfgLunaBattleLineZoneData.StageName[step])
	UGUIUtil.SetText(self.ZoneDescText, cfgLunaBattleLineZoneData.StageDesc[step])
end

function LunaBattleLineDetailUI:ShowZoneDetail(mazeInstanceCid, zonePOD)
	self.DetailController:Show(zonePOD, mazeInstanceCid)
	self.ZoneDescText:SetActive(false)
	self.TitleView:SetActive(false)
end

function LunaBattleLineDetailUI:HideZoneDetail()
	self.DetailController:Hide()
	self.ZoneDescText:SetActive(true)
	self.TitleView:SetActive(true)
end

function LunaBattleLineDetailUI:ShowViewHideByDetail(isDetailViewShow)
	if self.NoCampController.OnShowDetail ~= nil then
		self.NoCampController:OnShowDetail(isDetailViewShow)
	end

	if self.SealingController.OnShowDetail ~= nil then
		self.SealingController:OnShowDetail(isDetailViewShow)
	end
end

function LunaBattleLineDetailUI:OnSetCampSuccess(zoneId, zonePOD)
	self.SetCampController:Hide()
	self:RefreshSealingView(zoneId, zonePOD, true)

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zonePOD.zoneId]

	UGUIUtil.SetText(self.ZoneNameText, cfgLunaBattleLineZoneData.StageName[3])
	UGUIUtil.SetText(self.ZoneDescText, cfgLunaBattleLineZoneData.StageDesc[3])
end

function LunaBattleLineDetailUI:RefreshSealingView(pZoneId, zonePOD, showOtherGarrisonNotice)
	LunaBattleLineModule.SendGetAssists(pZoneId, function(assistUnits)
		self.SealingController:Show(zonePOD, assistUnits, self.SealNum)

		if showOtherGarrisonNotice then
			for i = 1, #assistUnits do
				local assistUnit = assistUnits[i]

				EventDispatcher.Dispatch(EventID.LunaBattleLineGarrisonNotice, zonePOD.zoneId, assistUnit.player.pName, assistUnit.soulPrefab.soulCid)
			end
		end
	end)
end

return LunaBattleLineDetailUI
