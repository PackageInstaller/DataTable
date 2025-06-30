-- chunkname: @IQIGame\\UI\\SettlementUI\\SettlementStatisticsView.lua

local SettlementStatisticsView = {}
local SettlementHeroItemViewClass = require("IQIGame/UI/SettlementUI/SettlementHeroItemView")

function SettlementStatisticsView.New(go, mainView)
	local o = Clone(SettlementStatisticsView)

	o:Initialize(go, mainView)

	return o
end

function SettlementStatisticsView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.heroItemArray = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SettlementStatisticsView:InitComponent()
	table.insert(self.heroItemArray, SettlementHeroItemViewClass.New(self.heroPrefab, self))
end

function SettlementStatisticsView:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.Close(Constant.UIControllerName.SettlementStatisticsUI)
	end
end

function SettlementStatisticsView:AddListener()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function SettlementStatisticsView:RemoveListener()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function SettlementStatisticsView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SettlementStatisticsView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SettlementStatisticsView:Refresh(data)
	self.data = data

	local attackFull = 0
	local defenceFull = 0
	local healthFull = 0
	local index = 1
	local len = #self.data

	for i = 1, len do
		local cell = self:_GetCell(index)

		cell:Refresh(self.data[i])
		cell:Show()

		attackFull = attackFull + self.data[i].record
		defenceFull = defenceFull + math.abs(self.data[i].injury)
		healthFull = healthFull + self.data[i].remedy
		index = index + 1
	end

	for i = 1, len do
		local cell = self:_GetCell(i)
		local at = attackFull == 0 and 0 or self.data[i].record / attackFull
		local dfs = defenceFull == 0 and 0 or math.abs(self.data[i].injury) / defenceFull
		local health = healthFull == 0 and 0 or self.data[i].remedy / healthFull

		cell:RefreshPercent(at, dfs, health)
	end

	len = #self.heroItemArray

	for i = index, len do
		self.heroItemArray[i]:Hide()
	end
end

function SettlementStatisticsView:_GetCell(index)
	if not self.heroItemArray[index] then
		local o = GameObject.Instantiate(self.heroPrefab, self.content.transform)

		self.heroItemArray[index] = SettlementHeroItemViewClass.New(o, self)
	end

	return self.heroItemArray[index]
end

function SettlementStatisticsView:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.heroItemArray) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return SettlementStatisticsView
