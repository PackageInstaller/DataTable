-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPlayer\\AmusementParkPlayerCultivateMsgView.lua

local m = {
	LastLevelUpTime = 0,
	PlayerAttrPool = {},
	PlayerDescribeCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkAttrRender = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkAttrRender")
local AmusementParkPlayerDescribeCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkPlayer.AmusementParkPlayerDescribeCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnUpgrade()
		self:OnBtnUpgrade()
	end

	function self.DelegateBtnTalk()
		self:OnBtnTalk()
	end

	self.PlayerAttrPool = {}

	for i = 0, self.AttSort.transform.childCount - 1 do
		local obj = self.AttSort.transform:GetChild(i).gameObject
		local playerAttrCell = AmusementParkAttrRender.New(obj)
		local attrID = AmusementParkModule.ParkPlayerAttr[i + 1]

		self.PlayerAttrPool[attrID] = playerAttrCell
	end

	self.SoulDescribeMould:SetActive(false)

	self.PlayerDescribePool = UIObjectPool.New(5, function()
		local obj = UnityEngine.Object.Instantiate(self.SoulDescribeMould)

		return AmusementParkPlayerDescribeCell.New(obj)
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnUpgrade:GetComponent("Button").onClick:AddListener(self.DelegateBtnUpgrade)
	self.BtnTalk:GetComponent("Button").onClick:AddListener(self.DelegateBtnTalk)
end

function m:RemoveListener()
	self.BtnUpgrade:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUpgrade)
	self.BtnTalk:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnTalk)
end

function m:SetData(data)
	self.PlayerData = data

	self.View:SetActive(self.PlayerData ~= nil)
	self:UpdateView()
end

function m:UpdateView()
	if self.PlayerData then
		local path = UIGlobalApi.GetImagePath(self.PlayerData:GetCfgData().Bust)

		AssetUtil.LoadImage(self, path, self.ImgHead:GetComponent("Image"))
		UGUIUtil.SetText(self.TextSoulName, self.PlayerData:GetCfgData().Name)
		UGUIUtil.SetText(self.TextSoulLv, AmusementParkPlayerUIApi:GetString("TextSoulLv", self.PlayerData.parkRolePOD.level))

		for i, v in pairs(self.PlayerAttrPool) do
			local attrValue = self.PlayerData:GetRoleAttrByAttrID(i)

			v:SetData(i, attrValue)
		end

		for i, v in pairs(self.PlayerDescribeCells) do
			v.View:SetActive(false)
			v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
			self.PlayerDescribePool:Release(v)
		end

		self.PlayerDescribeCells = {}

		for i = 1, #self.PlayerData:GetCfgData().BackStoryUnlockLevel do
			local needLv = self.PlayerData:GetCfgData().BackStoryUnlockLevel[i]
			local unlock = needLv <= self.PlayerData.parkRolePOD.level
			local storyStr = self.PlayerData:GetCfgData().BackStory[i]
			local unlockStr = AmusementParkPlayerUIApi:GetString("BackStoryUnlockLevel", needLv)
			local cell = self.PlayerDescribePool:Obtain()

			cell.View.transform:SetParent(self.SoulDescribeNode.transform, false)
			cell.View:SetActive(true)
			cell:SetData(unlock, storyStr, unlockStr)
			table.insert(self.PlayerDescribeCells, cell)
		end

		local cfgParkRoleLevelData = self.PlayerData:GetCfgParkRoleLevelData()
		local needNum = 0

		if cfgParkRoleLevelData then
			needNum = cfgParkRoleLevelData.Cost[2]
		end

		UGUIUtil.SetText(self.TextUpgradeCost, needNum)

		local isFullLv = self.PlayerData:IsFullLevel()

		self.BtnUpgrade:SetActive(not isFullLv)
		self.TextUpgradeCost:SetActive(not isFullLv)

		local isOpenTalk = self.PlayerData:IsOpenPlot()

		self.BtnTalk:SetActive(isOpenTalk)
	end
end

function m:OnBtnUpgrade()
	if PlayerModule.GetServerTime() - self.LastLevelUpTime < 0.2 then
		return
	end

	self.LastLevelUpTime = PlayerModule.GetServerTime()

	if self.PlayerData:IsFullLevel() then
		return
	end

	local cfgParkRoleLevelData = self.PlayerData:GetCfgParkRoleLevelData()

	if cfgParkRoleLevelData then
		local needItemID = cfgParkRoleLevelData.Cost[1]
		local needNum = cfgParkRoleLevelData.Cost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

		if haveNum < needNum then
			NoticeModule.ShowNotice(21045119)

			return
		end
	end

	AmusementParkModule.RoleLevelUp(self.PlayerData.cid)
end

function m:OnBtnTalk()
	local plotID = self.PlayerData:GetCfgData().PlotId

	if plotID > 0 and self.PlayerData:IsOpenPlot() then
		DialogModule.OpenDialog(plotID, false, false)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.PlayerDescribeCells) do
		self.PlayerDescribePool:Release(v)
	end

	self.PlayerDescribeCells = nil

	self.PlayerDescribePool:Dispose()

	for i, v in pairs(self.PlayerAttrPool) do
		v:Dispose()
	end

	self.PlayerData = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
