-- chunkname: @IQIGame\\UI\\EndlessMazeRuneSelectUI.lua

local EndlessMazeRuneSelectUI = Base:Extend("EndlessMazeRuneSelectUI", "IQIGame.Onigao.UI.EndlessMazeRuneSelectUI", {})
local EndlessMazeRuneSelectCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneSelectCell")

function EndlessMazeRuneSelectUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickAbortBtn()
		self:OnClickAbortBtn()
	end

	self.Cells = {}

	for i = 1, 4 do
		local cell = EndlessMazeRuneSelectCell.New(UnityEngine.Object.Instantiate(self.TogglePrefab), i)

		cell.View.transform:SetParent(self.ToggleGroup.transform, false)
		table.insert(self.Cells, cell)
	end

	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneSelectUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.AbortBtnLabel, EndlessMazeRuneSelectUIApi:GetString("AbortBtnLabel"))
	UGUIUtil.SetText(self.AbortRewardLabel, EndlessMazeRuneSelectUIApi:GetString("AbortRewardLabel"))
	UGUIUtil.SetTextInChildren(self.AbortNoRewardBtn, EndlessMazeRuneSelectUIApi:GetString("AbortNoRewardBtnText"))
end

function EndlessMazeRuneSelectUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneSelectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneSelectUI:OnOpen(userData)
	self:UpdateView(userData.runes, userData.crystal, userData.onConfirm)
end

function EndlessMazeRuneSelectUI:OnClose(userData)
	return
end

function EndlessMazeRuneSelectUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.AbortBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAbortBtn)
	self.AbortNoRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAbortBtn)
end

function EndlessMazeRuneSelectUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.AbortBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAbortBtn)
	self.AbortNoRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAbortBtn)
end

function EndlessMazeRuneSelectUI:OnPause()
	return
end

function EndlessMazeRuneSelectUI:OnResume()
	return
end

function EndlessMazeRuneSelectUI:OnCover()
	return
end

function EndlessMazeRuneSelectUI:OnReveal()
	return
end

function EndlessMazeRuneSelectUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneSelectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneSelectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneSelectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneSelectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneSelectUI:OnDestroy()
	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		cell:Dispose()
	end
end

function EndlessMazeRuneSelectUI:UpdateView(runes, crystal, onConfirm)
	self.OnConfirmCallback = onConfirm

	for i = 1, #self.Cells do
		local cell = self.Cells[i]
		local runeCid = runes[i]

		cell.Toggle.isOn = false

		cell:SetData(runeCid)
	end

	self.AbortBtn:SetActive(crystal ~= nil and crystal > 0)
	self.AbortNoRewardBtn:SetActive(crystal == nil or crystal == 0)

	if crystal ~= nil and crystal > 0 then
		UGUIUtil.SetText(self.AbortRewardNumText, crystal)
	end
end

function EndlessMazeRuneSelectUI:OnClickConfirmBtn()
	local targetCell
	local selectedIndex = 0

	for i = 1, #self.Cells do
		local cell = self.Cells[i]

		if cell.Toggle.isOn == true then
			targetCell = cell
			selectedIndex = i

			break
		end
	end

	if selectedIndex == 0 then
		NoticeModule.ShowNotice(21050002)

		return
	end

	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneSelectUI)
	self.OnConfirmCallback(selectedIndex)
	MazeModule.AddFlyRuneData({
		{
			runeCid = targetCell.RuneCell.CfgRuneData.Id,
			startPos = targetCell.RuneCell.View.transform.position
		}
	})
end

function EndlessMazeRuneSelectUI:OnClickAbortBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneSelectUI)
	self.OnConfirmCallback(-1)
end

return EndlessMazeRuneSelectUI
