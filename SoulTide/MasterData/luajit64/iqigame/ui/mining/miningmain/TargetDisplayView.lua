-- chunkname: @IQIGame\\UI\\Mining\\MiningMain\\TargetDisplayView.lua

local m = {
	isShow = true,
	showElementType = {},
	targetElementCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local TargetElementRender = require("IQIGame.UI.Mining.MiningMain.TargetElementRender")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tweenPos = self.View:GetComponent("TweenPosition")

	UGUIUtil.SetText(self.TextDisplayTitle, MiningMainUIApi:GetString("TextDisplayTitle"))

	function self.delegateBtnHide()
		self:OnBtnHide()
	end

	function self.delegateBtnShow()
		self:OnBtnShow()
	end

	function self.DelegateMiningPlantEvent(gridId)
		self:OnMiningPlantEvent(gridId)
	end

	function self.DelegateAutoMiningPlantEvent()
		self:OnAutoMiningPlant()
	end

	self.showElementType = {
		Constant.MiningElementType.MiningElementType_Treasure_Chest,
		Constant.MiningElementType.MiningElementType_Gold_Mine,
		Constant.MiningElementType.MiningElementType_Silver_Ore,
		Constant.MiningElementType.MiningElementType_Copper_Mine,
		Constant.MiningElementType.MiningElementType_Iron_Ore,
		Constant.MiningElementType.MiningElementType_Coin,
		Constant.MiningElementType.MiningElementType_Monster,
		Constant.MiningElementType.MiningElementType_Plot
	}

	self.TargetMould:SetActive(false)

	self.targetElementPool = UIObjectPool.New(10, function()
		local cell = TargetElementRender.New(UnityEngine.Object.Instantiate(self.TargetMould))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnHide:GetComponent("Button").onClick:AddListener(self.delegateBtnHide)
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.delegateBtnShow)
	EventDispatcher.AddEventListener(EventID.UpdateMiningPlantEvent, self.DelegateMiningPlantEvent)
	EventDispatcher.AddEventListener(EventID.UpdateAutoMiningPlantEvent, self.DelegateAutoMiningPlantEvent)
end

function m:RemoveListener()
	self.BtnHide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHide)
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShow)
	EventDispatcher.RemoveEventListener(EventID.UpdateMiningPlantEvent, self.DelegateMiningPlantEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateAutoMiningPlantEvent, self.DelegateAutoMiningPlantEvent)
end

function m:OnBtnHide()
	self.isShow = false

	self.tweenPos:PlayReverse()
	self.BtnHide:SetActive(self.isShow)
	self.BtnShow:SetActive(not self.isShow)
end

function m:OnBtnShow()
	self.isShow = true

	self.tweenPos:PlayForward()
	self.BtnHide:SetActive(self.isShow)
	self.BtnShow:SetActive(not self.isShow)
end

function m:OnMiningPlantEvent(gridId)
	self:UpdateView()
end

function m:OnAutoMiningPlant()
	self:UpdateView()
end

function m:UpdateView()
	for i, v in pairs(self.targetElementCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.targetElementPool:Release(v)
	end

	self.targetElementCells = {}

	for i = 1, #self.showElementType do
		local type = self.showElementType[i]
		local data = MiningModule.miningPlantTypeDataDic[type]

		if data then
			local cell = self.targetElementPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.List.transform, false)
			cell:SetData(data)
			table.insert(self.targetElementCells, cell)
		end
	end
end

function m:Open()
	self.View:SetActive(true)
	self.BtnHide:SetActive(self.isShow)
	self.BtnShow:SetActive(not self.isShow)
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.targetElementCells) do
		self.targetElementPool:Release(v)
	end

	self.targetElementCells = {}

	self.targetElementPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
