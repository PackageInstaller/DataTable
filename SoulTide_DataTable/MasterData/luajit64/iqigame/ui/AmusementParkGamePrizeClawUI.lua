-- chunkname: @IQIGame\\UI\\AmusementParkGamePrizeClawUI.lua

local AmusementParkGamePrizeClawUI = {
	GameRoles = {}
}

AmusementParkGamePrizeClawUI = Base:Extend("AmusementParkGamePrizeClawUI", "IQIGame.Onigao.UI.AmusementParkGamePrizeClawUI", AmusementParkGamePrizeClawUI)

require("IQIGame.UIExternalApi.AmusementParkGamePrizeClawUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkDollMachineGameResultView = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineGameResultView")
local AmusementParkDollMachineArm = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineArm")
local AmusementParkDollMachineGameRole = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineGameRole")

function AmusementParkGamePrizeClawUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnRank()
		self:OnClickBtnRank()
	end

	function self.DelegateOnClickBtnRestGame()
		self:OnClickBtnRestGame()
	end

	function self.DelegateUpdateDollMachineGameRank()
		self:OnUpdateDollMachineGameRank()
	end

	self.BtnGrabIt:GetComponent("LongButton").OnPointerUpAction = function(go)
		self:OnBtnGrabItUp(go)
	end
	self.BtnGrabIt:GetComponent("LongButton").OnPointerDownAction = function(go)
		self:OnBtnGrabItDown(go)
	end
	self.GroundCollider = self.ArmBottomPos:GetComponent(typeof(UnityEngine.Collider2D))
	self.GameResultView = AmusementParkDollMachineGameResultView.New(self.ResultView)
	self.GameMachineArm = AmusementParkDollMachineArm.New(self.RobotArm, self)

	self.GameRoleMould:SetActive(false)

	self.GameRolePool = UIObjectPool.New(30, function()
		local roleObj = UnityEngine.Object.Instantiate(self.GameRoleMould)

		return AmusementParkDollMachineGameRole.New(roleObj)
	end, function(currentCell)
		currentCell:Dispose()
	end)
end

function AmusementParkGamePrizeClawUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkGamePrizeClawUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkGamePrizeClawUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkGamePrizeClawUI:GetBGM(userData)
	return nil
end

function AmusementParkGamePrizeClawUI:OnOpen(userData)
	AmusementParkDollMachineGameModule.GetDollMachineGameRank()
	self.GameMachineArm:ResetGame()
	self:UpdateView(true)
end

function AmusementParkGamePrizeClawUI:OnClose(userData)
	for i, v in pairs(self.GameRoles) do
		v:HideEntity()
	end
end

function AmusementParkGamePrizeClawUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRank)
	self.BtnRestGame:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRestGame)
	EventDispatcher.AddEventListener(EventID.APUpdateDollMachineGameRankEvent, self.DelegateUpdateDollMachineGameRank)
end

function AmusementParkGamePrizeClawUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRank)
	self.BtnRestGame:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRestGame)
	EventDispatcher.RemoveEventListener(EventID.APUpdateDollMachineGameRankEvent, self.DelegateUpdateDollMachineGameRank)
end

function AmusementParkGamePrizeClawUI:OnPause()
	return
end

function AmusementParkGamePrizeClawUI:OnResume()
	return
end

function AmusementParkGamePrizeClawUI:OnCover()
	return
end

function AmusementParkGamePrizeClawUI:OnReveal()
	return
end

function AmusementParkGamePrizeClawUI:OnRefocus(userData)
	return
end

function AmusementParkGamePrizeClawUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.GameRoles) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end

	self.GameMachineArm:OnUpdate(elapseSeconds, realElapseSeconds)
end

function AmusementParkGamePrizeClawUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	for i, v in pairs(self.GameRoles) do
		v:ChangeOrder()
	end
end

function AmusementParkGamePrizeClawUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkGamePrizeClawUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkGamePrizeClawUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.GameRoles) do
		self.GameRolePool:Release(v)
	end

	self.GameRoles = nil

	self.GameRolePool:Dispose()
	self.GameResultView:Dispose()
	self.GameMachineArm:Dispose()
end

function AmusementParkGamePrizeClawUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkGamePrizeClawUI:UpdateView(isCreateRole)
	if isCreateRole then
		self:CreateRoles()
	end

	local apDollMachineGameData = AmusementParkDollMachineGameModule.apDollMachineGameData
	local haveCount = apDollMachineGameData.totalCount - apDollMachineGameData.currentIndex

	UGUIUtil.SetText(self.TextLevel, AmusementParkGamePrizeClawUIApi:GetString("TextLevel", apDollMachineGameData.totalScore))
	UGUIUtil.SetText(self.TextMaxScore, AmusementParkGamePrizeClawUIApi:GetString("TextMaxScore", AmusementParkDollMachineGameModule.maxScore))
	UGUIUtil.SetText(self.TextGameLv, AmusementParkGamePrizeClawUIApi:GetString("TextGameLv", apDollMachineGameData:GetCfgData().Level))
	UGUIUtil.SetText(self.TextGameCount, AmusementParkGamePrizeClawUIApi:GetString("TextGameCount", haveCount))
	UGUIUtil.SetText(self.TextMaxLv, AmusementParkGamePrizeClawUIApi:GetString("TextMaxLv", AmusementParkDollMachineGameModule.maxLv))
	self.BtnGrabIt:SetActive(not apDollMachineGameData:IsGameEnd())
	self:OnUpdateDollMachineGameRank()
end

function AmusementParkGamePrizeClawUI:CreateRoles()
	for i, v in pairs(self.GameRoles) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.GameRolePool:Release(v)
	end

	self.GameRoles = {}

	for i = 1, #AmusementParkDollMachineGameModule.apDollMachineGameData.gameRoles do
		local roleData = AmusementParkDollMachineGameModule.apDollMachineGameData.gameRoles[i]
		local role = self.GameRolePool:Obtain()

		role.View.transform:SetParent(self.RoleNode.transform, false)
		role.View:SetActive(true)
		role:SetData(roleData)
		table.insert(self.GameRoles, role)
	end
end

function AmusementParkGamePrizeClawUI:CleanRoles(roles)
	for i, v in pairs(roles) do
		self:CleanRole(v.cid)
	end

	AmusementParkDollMachineGameModule.apDollMachineGameData:EndCatchRoles(roles)

	if AmusementParkDollMachineGameModule.apDollMachineGameData:IsGameEnd() then
		self.GameResultView:Open(true)
		GameEntry.Sound:PlaySound(10905, Constant.SoundGroup.UI)
	else
		self.GameResultView:Open(false)
		GameEntry.Sound:PlaySound(10906, Constant.SoundGroup.UI)
	end

	self:UpdateView(false)
	AmusementParkDollMachineGameModule.DollMachine()
end

function AmusementParkGamePrizeClawUI:CleanRole(cid)
	for i, v in pairs(self.GameRoles) do
		if v.RoleData.cid == cid then
			v.IsCatch = true

			v:HideEntity()
			v.View:SetActive(false)
			v.View.transform:SetParent(self.UIController.transform, false)
			self.GameRolePool:Release(v)

			self.GameRoles[i] = nil
		end
	end
end

function AmusementParkGamePrizeClawUI:OnUpdateDollMachineGameRank()
	local showMyRank = AmusementParkDollMachineGameModule.myRanking or 0

	self.RankTag:SetActive(false)

	if AmusementParkDollMachineGameModule.rankType == 2 then
		showMyRank = 999

		self.RankTag:SetActive(true)
	elseif showMyRank > 999 then
		showMyRank = 999

		self.RankTag:SetActive(true)
	end

	UGUIUtil.SetText(self.TextRankNum, AmusementParkGamePrizeClawUIApi:GetString("TextRankNum", showMyRank))
	UGUIUtil.SetText(self.TextMaxScore, AmusementParkGamePrizeClawUIApi:GetString("TextMaxScore", AmusementParkDollMachineGameModule.maxScore))
end

function AmusementParkGamePrizeClawUI:OnClickBtnRank()
	UIModule.Open(Constant.UIControllerName.AmusementParkGamePrizeClawRankUI, Constant.UILayer.UI)
end

function AmusementParkGamePrizeClawUI:OnClickBtnRestGame()
	AmusementParkDollMachineGameModule.CreateNewGame()
	self.GameMachineArm:ResetGame()
	self:UpdateView(true)
end

function AmusementParkGamePrizeClawUI:OnBtnGrabItDown()
	if AmusementParkDollMachineGameModule.apDollMachineGameData:IsGameEnd() then
		return
	end

	if self.GameMachineArm.IsCatching then
		return
	end

	AmusementParkDollMachineGameModule.apDollMachineGameData:StartCatchRoles()
	self.GameMachineArm:StartMoveArm()
end

function AmusementParkGamePrizeClawUI:OnBtnGrabItUp()
	if AmusementParkDollMachineGameModule.apDollMachineGameData:IsGameEnd() then
		return
	end

	if self.GameMachineArm.IsCatching then
		return
	end

	self.GameMachineArm:StopMoveAndStartCatch()
end

return AmusementParkGamePrizeClawUI
