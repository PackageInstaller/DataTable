-- chunkname: @IQIGame\\UI\\LunaBattleLineAssistantUI.lua

local LunaBattleLineAssistantUI = {
	ZoneId = 0,
	AssistantItems = {}
}

LunaBattleLineAssistantUI = Base:Extend("LunaBattleLineAssistantUI", "IQIGame.Onigao.UI.LunaBattleLineAssistantUI", LunaBattleLineAssistantUI)

require("IQIGame.UIExternalApi.LunaBattleLineAssistantUIApi")

local LunaBattleAssistantListItem = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantListItem")
local LunaBattleAssistantSoulInfo = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantSoulInfo")
local LunaBattleAssistantSoulSkill = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantSoulSkill")
local LunaBattleAssistantSoulEquip = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantSoulEquip")
local LunaBattleAssistantPlayerInfo = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantPlayerInfo")

function LunaBattleLineAssistantUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFullScreenCloseBtn()
		self:OnClickFullScreenCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickChangeBtn()
		self:OnClickChangeBtn()
	end

	local scrollAreaList = self.AssistantScrollList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	self.SoulInfoController = LunaBattleAssistantSoulInfo.New(self.SoulInfoView)
	self.SoulSkillController = LunaBattleAssistantSoulSkill.New(self.SkillView)
	self.SoulEquipController = LunaBattleAssistantSoulEquip.New(self.EquipView)
	self.PlayerInfoController = LunaBattleAssistantPlayerInfo.New(self.PlayerView, self.UIController)

	UGUIUtil.SetText(self.TitleText, LunaBattleLineAssistantUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, LunaBattleLineAssistantUIApi:GetString("ConfirmBtnText"))
end

function LunaBattleLineAssistantUI:GetPreloadAssetPaths()
	return nil
end

function LunaBattleLineAssistantUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineAssistantUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineAssistantUI:GetBGM(userData)
	return nil
end

function LunaBattleLineAssistantUI:OnOpen(userData)
	self.ZoneId = userData.zoneId
	self.OnChooseCompleteCallback = userData.onChooseComplete

	self:UpdateView(userData.assistUnits)
end

function LunaBattleLineAssistantUI:OnClose(userData)
	return
end

function LunaBattleLineAssistantUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.ChangeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeBtn)
end

function LunaBattleLineAssistantUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.ChangeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeBtn)
end

function LunaBattleLineAssistantUI:OnPause()
	return
end

function LunaBattleLineAssistantUI:OnResume()
	return
end

function LunaBattleLineAssistantUI:OnCover()
	return
end

function LunaBattleLineAssistantUI:OnReveal()
	return
end

function LunaBattleLineAssistantUI:OnRefocus(userData)
	return
end

function LunaBattleLineAssistantUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.RefreshElapsedTime == nil or self.RefreshElapsedTime > 0.5 then
		self.RefreshElapsedTime = 0

		local cd = 0

		if LunaBattleLineModule.LastRequestAssistsTime ~= nil then
			cd = LunaBattleLineModule.AssistsCacheCD - (UnityEngine.Time.realtimeSinceStartup - LunaBattleLineModule.LastRequestAssistsTime)
		end

		if cd < 0 then
			cd = 0
		end

		cd = math.ceil(cd)

		UGUIUtil.SetTextInChildren(self.ChangeBtn, LunaBattleLineAssistantUIApi:GetString("ChangeBtnText", cd))
	end

	self.RefreshElapsedTime = self.RefreshElapsedTime + realElapseSeconds
end

function LunaBattleLineAssistantUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineAssistantUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineAssistantUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineAssistantUI:OnDestroy()
	self.SoulInfoController:Dispose()
	self.SoulSkillController:Dispose()
	self.SoulEquipController:Dispose()
	self.PlayerInfoController:Dispose()
end

function LunaBattleLineAssistantUI:UpdateView(assistUnits)
	self.AssistUnits = assistUnits

	local scrollAreaList = self.AssistantScrollList:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = 0

	scrollAreaList:Refresh(#self.AssistUnits)
	self.InfoNormalView:SetActive(#self.AssistUnits ~= 0)
	self.ChangeBtn:SetActive(#self.AssistUnits ~= 0)
	self.InfoEmptyView:SetActive(#self.AssistUnits == 0)
end

function LunaBattleLineAssistantUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineAssistantUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineAssistantUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)

	if self.OnChooseCompleteCallback ~= nil then
		self.OnChooseCompleteCallback(self.SelectedAssistant)

		self.OnChooseCompleteCallback = nil
	end
end

function LunaBattleLineAssistantUI:OnClickChangeBtn()
	if LunaBattleLineModule.IsRefreshCD() then
		return
	end

	LunaBattleLineModule.SendRefreshAssists(self.ZoneId, function(assistUnits)
		self:UpdateView(assistUnits)
	end)
end

function LunaBattleLineAssistantUI:OnRenderCell(cell)
	local item = self.AssistantItems[cell.gameObject]

	if item == nil then
		item = LunaBattleAssistantListItem.New(cell.gameObject)
		self.AssistantItems[cell.gameObject] = item
	end

	item:SetData(self.AssistUnits[cell.index + 1])
end

function LunaBattleLineAssistantUI:OnSelectCell(cell)
	local assistant = self.AssistUnits[cell.index + 1]

	self:ShowInfo(assistant)
end

function LunaBattleLineAssistantUI:ShowInfo(assistant)
	self.SelectedAssistant = assistant

	self.SoulInfoController:SetData(assistant.soulPrefab)
	self.SoulSkillController:SetData(assistant.soulPrefab)
	self.SoulEquipController:SetData(assistant.soulPrefab)
	self.PlayerInfoController:SetData(assistant.player)
end

return LunaBattleLineAssistantUI
