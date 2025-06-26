-- chunkname: @IQIGame\\UI\\QuickChangeFormationUI.lua

local QuickChangeFormationUI = Base:Extend("QuickChangeFormationUI", "IQIGame.Onigao.UI.QuickChangeFormationUI", {
	FormationItems = {}
})
local QuickChangeFormationItem = require("IQIGame.UI.FormationUI.QuickChangeFormationItem")

function QuickChangeFormationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local scrollAreaList = self.FormationGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedFormationCell(cell)
	end

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderFormationCell(cell)
	end
end

function QuickChangeFormationUI:GetPreloadAssetPaths()
	return nil
end

function QuickChangeFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function QuickChangeFormationUI:IsManualShowOnOpen(userData)
	return false
end

function QuickChangeFormationUI:GetBGM(userData)
	return nil
end

function QuickChangeFormationUI:OnOpen(userData)
	self:UpdateView(userData.tabIndex, userData.onConfirm)
end

function QuickChangeFormationUI:OnClose(userData)
	return
end

function QuickChangeFormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function QuickChangeFormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function QuickChangeFormationUI:OnPause()
	return
end

function QuickChangeFormationUI:OnResume()
	return
end

function QuickChangeFormationUI:OnCover()
	return
end

function QuickChangeFormationUI:OnReveal()
	return
end

function QuickChangeFormationUI:OnRefocus(userData)
	return
end

function QuickChangeFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function QuickChangeFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function QuickChangeFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function QuickChangeFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function QuickChangeFormationUI:OnDestroy()
	for gameObject, item in pairs(self.FormationItems) do
		item:Dispose()
	end

	self.FormationItems = nil
end

function QuickChangeFormationUI:OnClickCloseBtn()
	self:CloseAndSave()
end

function QuickChangeFormationUI:CloseAndSave()
	UIModule.CloseSelf(self)
	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.FormationTeamIndex, self.FormationIndex)

	if self.OnConfirmCallback ~= nil then
		self.OnConfirmCallback(self.FormationIndex)
	end
end

function QuickChangeFormationUI:OnSelectedFormationCell(cell)
	self.FormationIndex = cell.index + 1
end

function QuickChangeFormationUI:OnRenderFormationCell(cell)
	local index = cell.index + 1
	local item = self.FormationItems[cell.gameObject]

	if item == nil then
		item = QuickChangeFormationItem.New(cell.gameObject, function(pIndex)
			self.FormationIndex = pIndex

			self:CloseAndSave()
		end)
		self.FormationItems[cell.gameObject] = item
	end

	local formationPOD = FormationModule.GetFormationByIndex(index)

	item:SetData(formationPOD, index, self.FormationIndex)
end

function QuickChangeFormationUI:UpdateView(index, onConfirm)
	self.OnConfirmCallback = onConfirm

	local scrollAreaList = self.FormationGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = index - 1
	self.FormationIndex = index

	scrollAreaList:Refresh(#PlayerModule.PlayerInfo.formations)
end

return QuickChangeFormationUI
