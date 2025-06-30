-- chunkname: @IQIGame\\UI\\SoulMarryConfirmUI.lua

local SoulMarryConfirmUI = {
	activation = false,
	confirmRenderCells = {}
}

SoulMarryConfirmUI = Base:Extend("SoulMarryConfirmUI", "IQIGame.Onigao.UI.SoulMarryConfirmUI", SoulMarryConfirmUI)

local SoulMarryConfirmRenderCell = require("IQIGame.UI.SoulMarry.SoulMarryConfirm.SoulMarryConfirmRenderCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function SoulMarryConfirmUI:OnInit()
	self.RenderMould:SetActive(false)
	UGUIUtil.SetText(self.TextPanelTitle, SoulMarryConfirmUIApi:GetString("TextPanelTitle"))

	self.l2dBuilder = self.Live2D:GetComponent("L2DBuilderMainCity")
	self.cvFrame = CvUIFrame.New(self.CvFrame.transform:GetChild(0).gameObject, Constant.UIControllerName.SoulMarryConfirmUI)
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.Live2D)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnOaths()
		self:OnBtnOaths()
	end

	function self.delegateUpdateSoulWhisperUnlock()
		self:OnUpdateSoulWhisper()
	end

	function self.dgtOnDressWearSuccess(dressCid)
		self:OnDressWearSuccess(dressCid)
	end

	function self.delegateSoulOathSuccess(soulCid)
		self:OnSoulOathSuccess(soulCid)
	end

	self.confirmRenderCellPool = UIObjectPool.New(6, function()
		return SoulMarryConfirmRenderCell.New(UnityEngine.Object.Instantiate(self.RenderMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function SoulMarryConfirmUI:GetPreloadAssetPaths()
	return nil
end

function SoulMarryConfirmUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulMarryConfirmUI:IsManualShowOnOpen(userData)
	return false
end

function SoulMarryConfirmUI:GetBGM(userData)
	return nil
end

function SoulMarryConfirmUI:OnOpen(userData)
	UIModule.BugFixL2dUIList[self.name] = self
	self.soulCid = userData

	self:UpDateView()
	EventDispatcher.Dispatch(EventID.L2DPause)
end

function SoulMarryConfirmUI:OnClose(userData)
	UIModule.BugFixL2dUIList[self.name] = nil

	self.cvFrame:Dispose()
	EventDispatcher.Dispatch(EventID.L2DResume)
end

function SoulMarryConfirmUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnOaths:GetComponent("Button").onClick:AddListener(self.delegateBtnOaths)
	EventDispatcher.AddEventListener(EventID.UpdateSoulWhisperUnlock, self.delegateUpdateSoulWhisperUnlock)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
	EventDispatcher.AddEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
end

function SoulMarryConfirmUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnOaths:GetComponent("Button").onClick:RemoveListener(self.delegateBtnOaths)
	EventDispatcher.RemoveEventListener(EventID.UpdateSoulWhisperUnlock, self.delegateUpdateSoulWhisperUnlock)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
	EventDispatcher.RemoveEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
end

function SoulMarryConfirmUI:OnPause()
	return
end

function SoulMarryConfirmUI:OnResume()
	return
end

function SoulMarryConfirmUI:OnCover()
	return
end

function SoulMarryConfirmUI:OnReveal()
	return
end

function SoulMarryConfirmUI:OnRefocus(userData)
	return
end

function SoulMarryConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulMarryConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulMarryConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulMarryConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulMarryConfirmUI:OnDestroy()
	self.live2DHarmoniousMask:Dispose()

	for i, v in pairs(self.confirmRenderCells) do
		self.confirmRenderCellPool:Release(v)
	end

	self.confirmRenderCells = {}

	self.confirmRenderCellPool:Dispose()
end

function SoulMarryConfirmUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulMarryConfirmUI)
end

function SoulMarryConfirmUI:OnUpdateSoulWhisper()
	self:UpDateView()
end

function SoulMarryConfirmUI:UpDateView()
	local girlPOD = GirlModule.GetSoulGirlData(self.soulCid)

	if girlPOD then
		self:RefreshL2D()

		self.activation = girlPOD.activation

		local cfgSoulMarry = GirlModule.GetSoulOathData(self.soulCid)
		local soulData = SoulModule.GetSoulData(self.soulCid)

		UGUIUtil.SetText(self.TextName, soulData:GetCfgSoul().Name)
		UGUIUtil.SetText(self.BtnOathsLabel, SoulMarryConfirmUIApi:GetString("BtnOathsLabel", girlPOD.activation))
		UGUIUtil.SetText(self.TextTip, cfgSoulMarry.WhisperTitle)

		local costID = cfgSoulMarry.CostItem[1]
		local have = WarehouseModule.GetItemNumByCfgID(costID)
		local cost = cfgSoulMarry.CostItem[2]

		UGUIUtil.SetText(self.TextSpend, SoulMarryConfirmUIApi:GetString("TextSpend", CfgItemTable[costID].Name, cost, cost <= have))
		self.TextSpend:SetActive(not girlPOD.activation)

		local num = GirlModule.soulOathPOD.countData[2]

		if num == nil then
			num = 0
		end

		UGUIUtil.SetText(self.TextMsg, SoulMarryConfirmUIApi:GetString("TextMsg", num))

		for i, v in pairs(self.confirmRenderCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.confirmRenderCellPool:Release(v)
		end

		self.confirmRenderCells = {}

		for i = 1, 5 do
			local itemCell = self.confirmRenderCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.ScrollContent.transform, false)
			itemCell:SetData(cfgSoulMarry, i)
			table.insert(self.confirmRenderCells, itemCell)
		end
	end
end

function SoulMarryConfirmUI:OnDressWearSuccess(dressCid)
	self:RefreshL2D()
end

function SoulMarryConfirmUI:OnSoulOathSuccess(soulCid)
	if soulCid == self.soulCid then
		self:UpDateView()
	end
end

function SoulMarryConfirmUI:RefreshL2D()
	local soulData = SoulModule.GetSoulData(self.soulCid)

	if soulData ~= nil then
		local cfgSoulResRow = soulData:GetCfgSoulRes2D()

		SoulModule.BuildL2D(self.l2dBuilder, soulData, soulData:GetCfgDress2D())
		self:SetL2DModelProperty(cfgSoulResRow)

		self.l2dBuilder.onShowCvUI = self.cvFrame.dgtOnShowCVUI
		self.l2dBuilder.onHideCvUI = self.cvFrame.dgtOnHideCVUI

		self.cvFrame:RefreshView(Vector3.New(cfgSoulResRow.DatingDialoguePosition[1], cfgSoulResRow.DatingDialoguePosition[2], cfgSoulResRow.DatingDialoguePosition[3]))
	end

	self.Live2D.transform.anchoredPosition3D = Vector3.zero
end

function SoulMarryConfirmUI:SetL2DModelProperty(cfgSoulResRow)
	self.l2dBuilder:SetModelPositionInImage(cfgSoulResRow.Live2DDatingUIModelPosition[1], cfgSoulResRow.Live2DDatingUIModelPosition[2], cfgSoulResRow.Live2DDatingUIModelPosition[3])
end

function SoulMarryConfirmUI:OnBtnOaths()
	local cfgSoulMarry = GirlModule.GetSoulOathData(self.soulCid)
	local costID = cfgSoulMarry.CostItem[1]
	local have = WarehouseModule.GetItemNumByCfgID(costID)

	if not self.activation and have < cfgSoulMarry.CostItem[2] then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = 1010303007
		})

		return
	end

	UIModule.Open(Constant.UIControllerName.SoulMarryAvPlayUI, Constant.UILayer.UI, cfgSoulMarry)
end

return SoulMarryConfirmUI
