-- chunkname: @IQIGame\\UI\\PassCheckFunctionInfoUI.lua

local PassCheckFunctionInfoUI = Base:Extend("PassCheckFunctionInfoUI", "IQIGame.Onigao.UI.PassCheckFunctionInfoUI", {
	ruleCellPool = {}
})

function PassCheckFunctionInfoUI:OnInit()
	self:Initialize()
end

function PassCheckFunctionInfoUI:GetPreloadAssetPaths()
	return nil
end

function PassCheckFunctionInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PassCheckFunctionInfoUI:IsManualShowOnOpen(userData)
	return false
end

function PassCheckFunctionInfoUI:GetBGM(userData)
	return nil
end

function PassCheckFunctionInfoUI:OnOpen(userData)
	self:Refresh(userData)
end

function PassCheckFunctionInfoUI:OnClose(userData)
	self:OnHide()
end

function PassCheckFunctionInfoUI:OnPause()
	return
end

function PassCheckFunctionInfoUI:OnResume()
	return
end

function PassCheckFunctionInfoUI:OnCover()
	return
end

function PassCheckFunctionInfoUI:OnReveal()
	return
end

function PassCheckFunctionInfoUI:OnRefocus(userData)
	return
end

function PassCheckFunctionInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PassCheckFunctionInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PassCheckFunctionInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PassCheckFunctionInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PassCheckFunctionInfoUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.ruleCellPool[1] = self.goRuleCell
	self.goTitle:GetComponent("Text").text = PassCheckFunctionInfoUIApi:GetString("title")
	self.goDesc:GetComponent("Text").text = PassCheckFunctionInfoUIApi:GetString("desc")
end

function PassCheckFunctionInfoUI:Refresh(userData)
	self:RefreshRule()
end

function PassCheckFunctionInfoUI:OnHide()
	return
end

function PassCheckFunctionInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function PassCheckFunctionInfoUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function PassCheckFunctionInfoUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function PassCheckFunctionInfoUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PassCheckFunctionInfoUI:RefreshRule()
	local cfgRuleDataList = {}

	for i, v in ipairs(CfgBattlePassTable[PassCheckModule.id].BattlePassRule) do
		cfgRuleDataList[#cfgRuleDataList + 1] = CfgBattlePassRuleTable[v]
	end

	for i, v in ipairs(self.ruleCellPool) do
		v:SetActive(i <= #cfgRuleDataList)
	end

	for i, v in ipairs(cfgRuleDataList) do
		local cell = self.ruleCellPool[i]

		if cell == nil then
			cell = UnityEngine.Object.Instantiate(self.goRuleCell)

			cell.transform:SetParent(self.goRuleCell.transform.parent, false)

			self.ruleCellPool[i] = cell
		end

		cell:SetActive(true)

		local icon = cell.transform:Find("Image_Icon"):GetComponent("Image")
		local tfDesc = cell.transform:Find("Text_01"):GetComponent("Text")

		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(v.Image), icon)

		tfDesc.text = PassCheckFunctionInfoUIApi:GetString("ruleDesc", v.Desc)
	end
end

return PassCheckFunctionInfoUI
