-- chunkname: @IQIGame\\UI\\RandomSecretaryScreenUI.lua

local RandomSecretaryScreenUI = {
	souls = {},
	randomSecretarySoulCells = {}
}

RandomSecretaryScreenUI = Base:Extend("RandomSecretaryScreenUI", "IQIGame.Onigao.UI.RandomSecretaryScreenUI", RandomSecretaryScreenUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local RandomSecretarySoulCell = require("IQIGame.UI.Girl.RandomSecretary.RandomSecretarySoulCell")

function RandomSecretaryScreenUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateBtnBack()
		self:OnClickBtnClose()
	end

	function self.DelegateBtnSure()
		self:OnBtnSure()
	end

	function self.DelegateBtnRest()
		self:OnBtnRest()
	end

	self.SoulNameMould:SetActive(false)

	self.randomSecretarySoulCellPool = UIObjectPool.New(20, function()
		return RandomSecretarySoulCell.New(UnityEngine.Object.Instantiate(self.SoulNameMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function RandomSecretaryScreenUI:GetPreloadAssetPaths()
	return nil
end

function RandomSecretaryScreenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RandomSecretaryScreenUI:IsManualShowOnOpen(userData)
	return false
end

function RandomSecretaryScreenUI:GetBGM(userData)
	return nil
end

function RandomSecretaryScreenUI:OnOpen(userData)
	self:UpdateView()
end

function RandomSecretaryScreenUI:OnClose(userData)
	return
end

function RandomSecretaryScreenUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateBtnBack)
	self.BtnSure:GetComponent("Button").onClick:AddListener(self.DelegateBtnSure)
	self.BtnRest:GetComponent("Button").onClick:AddListener(self.DelegateBtnRest)
end

function RandomSecretaryScreenUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBack)
	self.BtnSure:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSure)
	self.BtnRest:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRest)
end

function RandomSecretaryScreenUI:OnPause()
	return
end

function RandomSecretaryScreenUI:OnResume()
	return
end

function RandomSecretaryScreenUI:OnCover()
	return
end

function RandomSecretaryScreenUI:OnReveal()
	return
end

function RandomSecretaryScreenUI:OnRefocus(userData)
	return
end

function RandomSecretaryScreenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RandomSecretaryScreenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RandomSecretaryScreenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RandomSecretaryScreenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RandomSecretaryScreenUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.randomSecretarySoulCells) do
		self.randomSecretarySoulCellPool:Release(v)
	end

	self.randomSecretarySoulCells = {}

	self.randomSecretarySoulCellPool:Dispose()
end

function RandomSecretaryScreenUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RandomSecretaryScreenUI:OnBtnSure()
	RandomSecretaryModule.selectSouls = {}

	for i, v in pairs(self.randomSecretarySoulCells) do
		if v.isSelect then
			table.insert(RandomSecretaryModule.selectSouls, v.soulID)
		end
	end

	EventDispatcher.Dispatch(EventID.RefreshRandomSecretarySelectSoul)
	self:OnClickBtnClose()
end

function RandomSecretaryScreenUI:OnBtnRest()
	for i, v in pairs(self.randomSecretarySoulCells) do
		v:SetSelect(false)
	end
end

function RandomSecretaryScreenUI:UpdateView()
	self.souls = RandomSecretaryModule.GetAllSouls()

	table.sort(self.souls, function(a, b)
		return a < b
	end)

	for i, v in pairs(self.randomSecretarySoulCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.randomSecretarySoulCellPool:Release(v)
	end

	self.randomSecretarySoulCells = {}

	for i, v in pairs(self.souls) do
		local top = table.indexOf(RandomSecretaryModule.selectSouls, v) ~= -1
		local renderCell = self.randomSecretarySoulCellPool:Obtain()

		renderCell.View:SetActive(true)
		renderCell.View.transform:SetParent(self.Content.transform, false)
		renderCell:SetData(v)
		renderCell:SetSelect(top)
		table.insert(self.randomSecretarySoulCells, renderCell)
	end
end

return RandomSecretaryScreenUI
