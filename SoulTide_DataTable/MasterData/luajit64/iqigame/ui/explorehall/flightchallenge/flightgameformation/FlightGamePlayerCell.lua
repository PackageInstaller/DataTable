-- chunkname: @IQIGame\\UI\\ExploreHall\\FlightChallenge\\FlightGameFormation\\FlightGamePlayerCell.lua

local m = {
	needItemNum = 0,
	flightChallengePlayerAttrCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FlightGamePlayerAttrCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameFormation.FlightGamePlayerAttrCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnEnterGame()
		self:OnBtnEnterGame()
	end

	self.AttrModule:SetActive(false)

	self.flightChallengePlayerAttrPool = UIObjectPool.New(5, function()
		return FlightGamePlayerAttrCell.New(UnityEngine.Object.Instantiate(self.AttrModule))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnEnterGame:GetComponent("Button").onClick:AddListener(self.DelegateBtnEnterGame)
end

function m:RemoveListener()
	self.BtnEnterGame:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEnterGame)
end

function m:SetData(data)
	self.needItemCid = nil
	self.flightChallengePlayerData = data

	local path = UIGlobalApi.GetImagePath(self.flightChallengePlayerData:GetConfigData().MechaImage)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, self.flightChallengePlayerData:GetConfigData().Name)

	for i, v in pairs(self.flightChallengePlayerAttrCells) do
		self.flightChallengePlayerAttrPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.flightChallengePlayerAttrCells = {}

	if self.flightChallengePlayerData then
		UGUIUtil.SetText(self.TextSkill, self.flightChallengePlayerData:GetConfigData().Skill)

		for i, v in pairs(self.flightChallengePlayerData.flightChallengeMechaPOD.growthAttribute) do
			local playerAttrCell = self.flightChallengePlayerAttrPool:Obtain()

			playerAttrCell.View:SetActive(true)
			playerAttrCell.View.transform:SetParent(self.AttrNode.transform, false)
			playerAttrCell:SetData(i, v)
			table.insert(self.flightChallengePlayerAttrCells, playerAttrCell)
		end
	end

	local costTab = FlightChallengeModule.GetFlightGameCost()

	if #costTab > 0 then
		self.needItemCid = costTab[1]
		self.needItemNum = costTab[2]
	end

	if self.needItemCid then
		local iconPath = UIGlobalApi.GetIconPath(CfgItemTable[self.needItemCid].Icon)

		AssetUtil.LoadImage(self, iconPath, self.SpendIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.SpendValue, FlightGameFormationUIApi:GetString("SpendValue", self.needItemNum))
	end
end

function m:OnBtnEnterGame()
	if self.needItemCid and self.needItemCid == Constant.ItemID.ENERGY and PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY) < self.needItemNum then
		NoticeModule.ShowNotice(21045026)

		return
	end

	FlightChallengeModule.FlightChallengeStart(self.flightChallengePlayerData.cid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.flightChallengePlayerAttrCells) do
		self.flightChallengePlayerAttrPool:Release(v)
	end

	self.flightChallengePlayerAttrCells = {}

	self.flightChallengePlayerAttrPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
