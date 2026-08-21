-- chunkname: @IQIGame\\UI\\MonsterAcademySettlementUI.lua

local MonsterAcademySettlementUI = {
	state = 0,
	rewards = {},
	towerRewardCells = {}
}

MonsterAcademySettlementUI = Base:Extend("MonsterAcademySettlementUI", "IQIGame.Onigao.UI.MonsterAcademySettlementUI", MonsterAcademySettlementUI)

require("IQIGame.UIExternalApi.MonsterAcademySettlementUIApi")

local MonsterAcademyTowerRewardCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyTower.MonsterAcademyTowerRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function MonsterAcademySettlementUI:OnInit()
	self.Module:SetActive(false)
	UGUIUtil.SetTextInChildren(self.BtnClose, MonsterAcademySettlementUIApi:GetString("BtnCloseLabel"))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.towerRewardCellPool = UIObjectPool.New(5, function()
		local obj = UnityEngine.Object.Instantiate(self.Module)
		local cell = MonsterAcademyTowerRewardCell.New(obj)

		return cell
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademySettlementUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademySettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademySettlementUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademySettlementUI:GetBGM(userData)
	return nil
end

function MonsterAcademySettlementUI:OnOpen(userData)
	self.state = userData.State
	self.rewards = userData.Rewards
	self.callBackFun = userData.CallBack

	self.Result:SetActive(false)
	self:UpdateView()
end

function MonsterAcademySettlementUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function MonsterAcademySettlementUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function MonsterAcademySettlementUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function MonsterAcademySettlementUI:OnPause()
	return
end

function MonsterAcademySettlementUI:OnResume()
	return
end

function MonsterAcademySettlementUI:OnCover()
	return
end

function MonsterAcademySettlementUI:OnReveal()
	return
end

function MonsterAcademySettlementUI:OnRefocus(userData)
	return
end

function MonsterAcademySettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademySettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademySettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademySettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademySettlementUI:OnDestroy()
	for i, v in pairs(self.towerRewardCells) do
		self.towerRewardCellPool:Release(v)
	end

	self.towerRewardCells = {}

	self.towerRewardCellPool:Dispose()
end

function MonsterAcademySettlementUI:OnClickBtnClose()
	if self.callBackFun then
		self.callBackFun()
	end

	self.callBackFun = nil

	UIModule.CloseSelf(self)
end

function MonsterAcademySettlementUI:UpdateView()
	self.Win:SetActive(self.state > 0)
	self.Fail:SetActive(self.state == 0)
	UGUIUtil.SetText(self.TextDes, MonsterAcademySettlementUIApi:GetString("TextDes", self.state))

	for i, v in pairs(self.towerRewardCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.towerRewardCellPool:Release(v)
	end

	self.towerRewardCells = {}

	for i, v in pairs(self.rewards) do
		local itemCell = self.towerRewardCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.Items.transform, false)
		itemCell:SetData(v)
		table.insert(self.towerRewardCells, itemCell)
	end

	local playerSkeletonGraphic = self.PlayerNode:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	local monsterSkeletonGraphic = self.MonsterNode:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if playerSkeletonGraphic then
		self.playerSkeletonAnimation = playerSkeletonGraphic.AnimationState

		if self.playerSkeletonAnimation then
			self.playerSkeletonAnimation:SetEmptyAnimation(0, 0)
			self.playerSkeletonAnimation:SetAnimation(0, "act1", true)
		end
	end

	if monsterSkeletonGraphic then
		self.monsterSkeletonAnimation = monsterSkeletonGraphic.AnimationState

		if self.monsterSkeletonAnimation then
			self.monsterSkeletonAnimation:SetEmptyAnimation(0, 0)
			self.monsterSkeletonAnimation:SetAnimation(0, "action", true)
		end
	end

	self.Effect:SetActive(true)

	self.timer = Timer.New(function()
		local playerActionName = "die"
		local monsterActionName = "idle"
		local top = self.state > 0

		if top then
			playerActionName = "idle"
			monsterActionName = "die"
		end

		if self.playerSkeletonAnimation then
			self.playerSkeletonAnimation:SetEmptyAnimation(0, 0)
			self.playerSkeletonAnimation:SetAnimation(0, playerActionName, top)
		end

		if self.monsterSkeletonAnimation then
			self.monsterSkeletonAnimation:SetEmptyAnimation(0, 0)
			self.monsterSkeletonAnimation:SetAnimation(0, monsterActionName, not top)
		end

		self.Result:SetActive(true)
		self.Effect:SetActive(false)
	end, 4)

	self.timer:Start()
end

function MonsterAcademySettlementUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.rewards[luaIndex]
	local itemCell = self.towerRewardCellPool[insID]

	if itemCell == nil then
		itemCell = MonsterAcademyTowerRewardCell.New(cell.gameObject)
		self.towerRewardCellPool[insID] = itemCell
	end

	itemCell:SetData(data)
end

return MonsterAcademySettlementUI
