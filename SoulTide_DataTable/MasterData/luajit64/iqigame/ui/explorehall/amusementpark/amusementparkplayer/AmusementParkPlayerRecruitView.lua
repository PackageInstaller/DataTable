-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerRecruitView.lua

local m = {
	AmusementParkVoRoles = {},
	PlayerRecruitCellPool = {}
}
local AmusementParkPlayerRecruitCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerRecruitCell")

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.View = view
	self.RootUI = rootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnRandomSoul()
		self:OnBtnRandomSoul()
	end

	function self.DelegateUpdateRandomSoul()
		self:OnUpdateRandomSoul()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderPlayerCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnRandomSoul:GetComponent("Button").onClick:AddListener(self.DelegateBtnRandomSoul)
	EventDispatcher.AddEventListener(EventID.APUpdateRandomSoulEvent, self.DelegateUpdateRandomSoul)
end

function m:RemoveListener()
	self.BtnRandomSoul:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRandomSoul)
	EventDispatcher.RemoveEventListener(EventID.APUpdateRandomSoulEvent, self.DelegateUpdateRandomSoul)
end

function m:GetParkPlayerNums()
	local num = 0
	local maxNum = 0

	if AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave then
		num = #AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave
	end

	local cfgData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]

	for i = 1, #cfgData.RecruitLimit, 2 do
		local lv = cfgData.RecruitLimit[i]
		local playerNum = cfgData.RecruitLimit[i + 1]

		if lv == AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.level then
			maxNum = playerNum

			break
		end
	end

	return num, maxNum
end

function m:OnUpdateRandomSoul()
	self:UpdateView()
end

function m:UpdateView()
	self.AmusementParkVoRoles = AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRoles or {}

	self.EmptyNode:SetActive(#self.AmusementParkVoRoles == 0)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.AmusementParkVoRoles)

	local num, maxNum = self:GetParkPlayerNums()
	local buildLv = AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.level or 1
	local cfgData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]

	UGUIUtil.SetText(self.TextRecruitNum, AmusementParkPlayerUIApi:GetString("TextRecruitNum", buildLv, maxNum))
	UGUIUtil.SetText(self.TextSpend, AmusementParkPlayerUIApi:GetString("TextSpend", cfgData.RecruitCost[2]))
	UGUIUtil.SetText(self.TextBuildLv, buildLv)
end

function m:OnBtnRandomSoul()
	local num, maxNum = self:GetParkPlayerNums()

	if maxNum <= num then
		NoticeModule.ShowNotice(21045118)

		return
	end

	local cfgData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]

	if #cfgData.RecruitCost > 0 then
		local needID = cfgData.RecruitCost[1]
		local needNum = cfgData.RecruitCost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needID)

		if haveNum < needNum then
			return
		end
	end

	AmusementParkModule.RandomActionFigure()
end

function m:OnRenderPlayerCell(cell)
	local dataPod = self.AmusementParkVoRoles[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local playerRecruitCell = self.PlayerRecruitCellPool[instanceID]

	if playerRecruitCell == nil then
		playerRecruitCell = AmusementParkPlayerRecruitCell.New(cell.gameObject)
		self.PlayerRecruitCellPool[instanceID] = playerRecruitCell
	end

	playerRecruitCell:SetData(dataPod)
end

function m:Open()
	self.View:SetActive(true)
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.PlayerRecruitCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
