-- chunkname: @IQIGame\\UI\\EndlessMazeRuneReplaceUI.lua

local EndlessMazeRuneReplaceUI = Base:Extend("EndlessMazeRuneReplaceUI", "IQIGame.Onigao.UI.EndlessMazeRuneReplaceUI", {})
local EndlessMazeNamedRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeNamedRuneCell")

function EndlessMazeRuneReplaceUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	self.OldRuneCells = {}

	for i = 1, 2 do
		local cell = EndlessMazeNamedRuneCell.New(UnityEngine.Object.Instantiate(self.RuneCellPrefab))

		cell.View.transform:SetParent(self.OldRuneGrid.transform, false)

		self.OldRuneCells[i] = cell
	end

	self.NewRuneCells = {}

	for i = 1, 2 do
		local cell = EndlessMazeNamedRuneCell.New(UnityEngine.Object.Instantiate(self.RuneCellPrefab))

		cell.View.transform:SetParent(self.NewRuneGrid.transform, false)

		self.NewRuneCells[i] = cell
	end

	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneReplaceUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, EndlessMazeRuneReplaceUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EndlessMazeRuneReplaceUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, EndlessMazeRuneReplaceUIApi:GetString("CancelBtnText"))
end

function EndlessMazeRuneReplaceUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneReplaceUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneReplaceUI:OnOpen(userData)
	self:UpdateView(userData.oldRunes, userData.newRunes)
end

function EndlessMazeRuneReplaceUI:OnClose(userData)
	return
end

function EndlessMazeRuneReplaceUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
end

function EndlessMazeRuneReplaceUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
end

function EndlessMazeRuneReplaceUI:OnPause()
	return
end

function EndlessMazeRuneReplaceUI:OnResume()
	return
end

function EndlessMazeRuneReplaceUI:OnCover()
	return
end

function EndlessMazeRuneReplaceUI:OnReveal()
	return
end

function EndlessMazeRuneReplaceUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneReplaceUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneReplaceUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneReplaceUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneReplaceUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneReplaceUI:OnDestroy()
	for i = 1, #self.OldRuneCells do
		local cell = self.OldRuneCells[i]

		cell:Dispose()
	end

	for i = 1, #self.NewRuneCells do
		local cell = self.NewRuneCells[i]

		cell:Dispose()
	end
end

function EndlessMazeRuneReplaceUI:UpdateView(oldRunes, newRunes)
	for i = 1, #self.OldRuneCells do
		local cell = self.OldRuneCells[i]
		local runeCid = oldRunes[i]

		cell:SetDataByCID(runeCid)
	end

	for i = 1, #self.NewRuneCells do
		local cell = self.NewRuneCells[i]
		local runeCid = newRunes[i]

		cell:SetDataByCID(runeCid)
	end
end

function EndlessMazeRuneReplaceUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneReplaceUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REPLACE_RUNE, {
		Replace = false
	})
end

function EndlessMazeRuneReplaceUI:OnClickConfirmBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneReplaceUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REPLACE_RUNE, {
		Replace = true
	})
end

function EndlessMazeRuneReplaceUI:OnClickCancelBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneReplaceUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REPLACE_RUNE, {
		Replace = false
	})
end

return EndlessMazeRuneReplaceUI
