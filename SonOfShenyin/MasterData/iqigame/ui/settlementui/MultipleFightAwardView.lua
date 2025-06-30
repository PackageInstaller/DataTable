-- chunkname: @IQIGame\\UI\\SettlementUI\\MultipleFightAwardView.lua

local MultipleFightAwardView = {}
local UnitRewardPopupItem = require("IQIGame/UI/SettlementUI/MultipleFightAwardItemView")

function MultipleFightAwardView.New(go, mainView)
	local o = Clone(MultipleFightAwardView)

	o:Initialize(go, mainView)

	return o
end

function MultipleFightAwardView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.itemCells = {}

	self:InitDelegate()
	self:InitComponent()
	self:AddListener()
end

function MultipleFightAwardView:InitComponent()
	local scrollAreaList = self.scrollArea:GetComponent("ScrollAreaList")

	scrollAreaList.onRenderCell = self.delegateOnRenderCell
end

function MultipleFightAwardView:InitDelegate()
	function self.delegateOnRenderCell(cell)
		self:__OnRenderCell(cell)
	end

	function self.delegateOnClose()
		self:Hide()
	end
end

function MultipleFightAwardView:AddListener()
	self.bgButton:GetComponent("Button").onClick:AddListener(self.delegateOnClose)
end

function MultipleFightAwardView:RemoveListener()
	self.bgButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClose)
end

function MultipleFightAwardView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MultipleFightAwardView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MultipleFightAwardView:__OnRenderCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local item = self.itemCells[insID]

	if item == nil then
		item = UnitRewardPopupItem.New(cell.gameObject)
		self.itemCells[insID] = item
	end

	local index = cell.index + 1
	local itemData = self.awardsList[index]

	if itemData == nil then
		item:Hide()
	else
		item:Show(index, itemData)
	end
end

function MultipleFightAwardView:OnDestroy()
	self.bgButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClose)

	if self.itemCells ~= nil then
		for i = 1, #self.itemCells do
			self.itemCells[i]:Dispose()
		end
	end

	self.itemCells = nil
	self.awardsList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function MultipleFightAwardView:Refresh(everyTimeAwards)
	self.awardsList = {}

	for _fightIndex, _awards in pairs(everyTimeAwards) do
		table.insert(self.awardsList, _awards)
	end

	local wrapContent = self.scrollArea:GetComponent("ScrollAreaList")

	wrapContent:Refresh(#self.awardsList)
end

return MultipleFightAwardView
