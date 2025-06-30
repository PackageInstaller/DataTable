-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainBuild\\AmusementParkMainBuildFunctionView.lua

local m = {
	BuildPosDataList = {},
	ParkPlayerHeadCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkPlayerHeadCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayerHeadCell")

function m.New(view, RootUI)
	local obj = Clone(m)

	obj:Init(view, RootUI)

	return obj
end

function m:Init(view, RootUI)
	self.View = view
	self.RootUI = RootUI

	LuaCodeInterface.BindOutlet(self.View, self)
	self.BuildPosMould:SetActive(false)

	self.ParkPlayerHeadCellPool = UIObjectPool.New(3, function()
		local cell = AmusementParkPlayerHeadCell.New(UnityEngine.Object.Instantiate(self.BuildPosMould))

		function cell.ClickCallBack(parkPlayerData, buildID, posData)
			self:OnSelectPosCell(parkPlayerData, buildID, posData)
		end

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	function self.DelegateFunctionBtn()
		self:OnFunctionBtn()
	end

	self:AddListener()
end

function m:AddListener()
	self.FunctionBtn:GetComponent("Button").onClick:AddListener(self.DelegateFunctionBtn)
end

function m:RemoveListener()
	self.FunctionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFunctionBtn)
end

function m:UpdateView()
	self.BuildPosDataList = self.BuildData:GetBuildPostData()

	for i, v in pairs(self.ParkPlayerHeadCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.ParkPlayerHeadCellPool:Release(v)
	end

	self.ParkPlayerHeadCells = {}

	for i = 1, #self.BuildPosDataList do
		local posData = self.BuildPosDataList[i]
		local cell = self.ParkPlayerHeadCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.BuildPosList.transform, false)
		cell:IsUnlock(posData.unLock)
		cell:SetUnlockLv(posData.unlockLv)

		cell.View.name = posData.pos

		cell:SetData(posData.playerData, self.BuildData.cid, posData)
		table.insert(self.ParkPlayerHeadCells, cell)
	end

	local haveRole = #AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave

	UGUIUtil.SetText(self.PlayerNum, AmusementParkMainBuildUIApi:GetString("PlayerNum", haveRole))

	local cfgFunctionData = self.BuildData:GetBuildFunctionData()

	self.FunctionBtn:SetActive(cfgFunctionData ~= nil)

	if cfgFunctionData then
		UGUIUtil.SetText(self.FunctionName, cfgFunctionData.FunctionName)

		local path = UIGlobalApi.GetImagePath(cfgFunctionData.FunctionIcon)

		AssetUtil.LoadImage(self, path, self.FunctionIcon:GetComponent("Image"))
	end
end

function m:OnSelectPosCell(parkPlayerData, buildID, posData)
	if posData and posData.unLock then
		UIModule.Open(Constant.UIControllerName.AmusementParkPlayerUI, Constant.UILayer.UI, {
			Index = 3,
			SelectBuild = self.BuildData.cid
		})
	end
end

function m:OnFunctionBtn()
	AmusementParkModule.OpenBuildFunction(self.BuildData)
end

function m:Show(buildData)
	self.BuildData = buildData

	self.View:SetActive(true)
	self:UpdateView()
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.ParkPlayerHeadCells) do
		self.ParkPlayerHeadCellPool:Release(v)
	end

	self.ParkPlayerHeadCells = {}

	self.ParkPlayerHeadCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
