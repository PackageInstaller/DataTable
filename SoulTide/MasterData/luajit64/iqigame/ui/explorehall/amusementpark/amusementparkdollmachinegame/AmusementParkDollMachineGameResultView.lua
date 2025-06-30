-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineGameResultView.lua

local m = {
	IsLastIndex = false,
	EndRoleCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkDollMachineEndRoleCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineEndRoleCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self.RoleHeadMould:SetActive(false)

	self.EndRoleCellPool = UIObjectPool.New(20, function()
		local roleObj = UnityEngine.Object.Instantiate(self.RoleHeadMould)

		return AmusementParkDollMachineEndRoleCell.New(roleObj)
	end, function(currentCell)
		currentCell:Dispose()
	end)

	self.View:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:UpdateView(top)
	local apGameData = AmusementParkDollMachineGameModule.apDollMachineGameData
	local roles = {}

	if top then
		UGUIUtil.SetText(self.goScoreText1, AmusementParkGamePrizeClawUIApi:GetString("GameEndTotalRoles", #apGameData.totalRoles))
		UGUIUtil.SetText(self.goScoreText2, AmusementParkGamePrizeClawUIApi:GetString("GameEndTotalScore", apGameData.totalScore))

		roles = apGameData.totalRoles
	else
		UGUIUtil.SetText(self.goScoreText1, AmusementParkGamePrizeClawUIApi:GetString("GameEndRoles", #apGameData.currentRoles))
		UGUIUtil.SetText(self.goScoreText2, AmusementParkGamePrizeClawUIApi:GetString("GameEndScore", apGameData.currentScore))

		roles = apGameData.currentRoles
	end

	for i, v in pairs(self.EndRoleCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		self.EndRoleCellPool:Release(v)
	end

	self.EndRoleCells = {}

	for i = 1, #roles do
		local roleData = roles[i]
		local cell = self.EndRoleCellPool:Obtain()

		cell.View.transform:SetParent(self.RolesNode.transform, false)
		cell.View:SetActive(true)
		cell:SetData(roleData)
		table.insert(self.EndRoleCells, cell)
	end

	self.Empty:SetActive(#roles == 0)
	self.OnceInfo:SetActive(not top)
	self.TotalInfo:SetActive(top)
end

function m:OnBtnClose()
	if self.IsLastIndex then
		self:UpdateView(true)

		self.IsLastIndex = false
	else
		self:Close()
	end
end

function m:Open(isLastIndex)
	self.IsLastIndex = isLastIndex

	self.View:SetActive(true)
	self:UpdateView(false)
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.EndRoleCells) do
		self.EndRoleCellPool:Release(v)
	end

	self.EndRoleCells = nil

	self.EndRoleCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
