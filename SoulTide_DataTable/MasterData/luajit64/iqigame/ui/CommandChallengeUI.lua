-- chunkname: @IQIGame\\UI\\CommandChallengeUI.lua

local CommandChallengeUI = {
	listDataTab = {},
	challengeLayerCellPool = {},
	formationCellPool = {}
}

CommandChallengeUI = Base:Extend("CommandChallengeUI", "IQIGame.Onigao.UI.CommandChallengeUI", CommandChallengeUI)

local CommandChallengeLayerCell = require("IQIGame.UI.CommandChallenge.CommandChallengeLayerCell")
local CommandChallengeFormationCell = require("IQIGame.UI.CommandChallenge.CommandChallengeFormationCell")

function CommandChallengeUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.DelegateUpdateCommandChallenge(isFirst)
		self:OnUpdateCommandChallenge(isFirst)
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedCell(cell)
	end
	self.formationCellPool = {}

	for i = 1, 5 do
		local formationCell = CommandChallengeFormationCell.New(self["position" .. i])

		self.formationCellPool[i] = formationCell
	end
end

function CommandChallengeUI:GetPreloadAssetPaths()
	return nil
end

function CommandChallengeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommandChallengeUI:IsManualShowOnOpen(userData)
	return false
end

function CommandChallengeUI:GetBGM(userData)
	return nil
end

function CommandChallengeUI:OnOpen(userData)
	CommandChallengeModule.SaveOpenCommandChallengePrefs()
	self:UpdateView()
end

function CommandChallengeUI:OnClose(userData)
	return
end

function CommandChallengeUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.DelegateBtnChallenge)
	EventDispatcher.AddEventListener(EventID.UpdateCommandChallengeEvent, self.DelegateUpdateCommandChallenge)
end

function CommandChallengeUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnChallenge)
	EventDispatcher.RemoveEventListener(EventID.UpdateCommandChallengeEvent, self.DelegateUpdateCommandChallenge)
end

function CommandChallengeUI:OnPause()
	return
end

function CommandChallengeUI:OnResume()
	return
end

function CommandChallengeUI:OnCover()
	return
end

function CommandChallengeUI:OnReveal()
	return
end

function CommandChallengeUI:OnRefocus(userData)
	return
end

function CommandChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommandChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommandChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommandChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommandChallengeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.challengeLayerCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.formationCellPool) do
		v:Dispose()
	end
end

function CommandChallengeUI:OnUpdateCommandChallenge(isFirst)
	if isFirst then
		self.selectData = nil
	end

	self:UpdateView()
end

function CommandChallengeUI:UpdateView()
	self.listDataTab = CommandChallengeModule.commandChallengeDataTab

	table.sort(self.listDataTab, function(a, b)
		local aPass = a.pass and 1 or 0
		local bPass = b.pass and 1 or 0

		if aPass == bPass then
			return a:GetConfig().Sort < b:GetConfig().Sort
		end

		return aPass < bPass
	end)

	if self.selectData == nil then
		local isAllComplete = CommandChallengeModule.IsAllCompleted()

		if isAllComplete then
			self.selectData = self.listDataTab[#self.listDataTab]
		else
			self.selectData = self.listDataTab[1]
		end
	end

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.listDataTab)
	self:ShowSelect()
end

function CommandChallengeUI:OnRenderCell(cell)
	local commandChallengeData = self.listDataTab[cell.index + 1]

	if commandChallengeData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local challengeLayerCell = self.challengeLayerCellPool[insID]

	if challengeLayerCell == nil then
		challengeLayerCell = CommandChallengeLayerCell.New(cell.gameObject)
		self.challengeLayerCellPool[insID] = challengeLayerCell
	end

	challengeLayerCell:SetData(commandChallengeData)
	challengeLayerCell:SetSelect(commandChallengeData.cid == self.selectData.cid)
end

function CommandChallengeUI:OnSelectedCell(cell)
	self.selectData = self.listDataTab[cell.index + 1]

	for i, v in pairs(self.challengeLayerCellPool) do
		v:SetSelect(v.commandChallengeData.cid == self.selectData.cid)
	end

	self:ShowSelect()
end

function CommandChallengeUI:ShowSelect()
	if self.selectData then
		UGUIUtil.SetText(self.TextOrder, self.selectData:GetConfig().Lecture)
		UGUIUtil.SetText(self.TextName, self.selectData:GetConfig().Name)
		UGUIUtil.SetText(self.TextIntroduce, self.selectData:GetConfig().Des)

		for i, v in pairs(self.formationCellPool) do
			local formationID = self.selectData:GetConfig().FormationInfo[i]

			v:SetData(formationID)
		end
	end
end

function CommandChallengeUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function CommandChallengeUI:OnBtnChallenge()
	if self.selectData then
		CommandChallengeModule.StartDrill(self.selectData.cid)
	end
end

return CommandChallengeUI
