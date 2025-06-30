-- chunkname: @IQIGame\\UI\\Lottery\\LotteryRewardCell.lua

local m = {
	Cid = 0,
	Type = 0
}

function m.PackageOrReuseView(ui, cellGo)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LotteryRewardCell == nil then
		ui.__SUB_UI_MAP_LotteryRewardCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LotteryRewardCell
	local itemCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		itemCell = m.__New(cellGo)
		subUIMap[cellGo:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[cellGo:GetInstanceID()]
	end

	return itemCell
end

function m.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LotteryRewardCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LotteryRewardCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LotteryRewardCell = nil
end

function m.__New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)
	self.SoulHeadCell = SoulHeadCell.New(self.CommonSoulHeadUI)

	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:SetData(type, cid, unlockConditionCid, probabilityText, upItems)
	self.Type = type
	self.Cid = cid

	self.View:SetActive(cid ~= nil)

	if cid == nil then
		return
	end

	local name, quality

	if type == 1 then
		local soulData = SoulData.New()

		soulData:Initialize(cid)
		self.SoulHeadCell:RefreshView(soulData)

		local cfgSoulData = CfgSoulTable[cid]

		name = cfgSoulData.Name
		quality = 0
	else
		self.ItemCell:SetItemByCID(cid, 1)

		local cfgItemData = CfgItemTable[cid]

		name = cfgItemData.Name
		quality = cfgItemData.Quality
	end

	self.SoulHeadCell.goView:SetActive(type == 1)
	self.ItemCell.ViewGo:SetActive(type ~= 1)

	self.ProbabilityText:GetComponent("Text").text = LotteryRewardListUIApi:GetString("ProbabilityText", probabilityText)

	local isUnlock = ConditionModule.Check(unlockConditionCid)

	self.NameText:GetComponent("Text").text = LotteryRewardListUIApi:GetString("RewardNameText", name, isUnlock, type, quality)

	local isUp = upItems ~= nil and table.indexOf(upItems, cid) ~= -1

	self.TagUpView:SetActive(isUp)
end

function m:OnClick()
	return
end

function m:Dispose()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	self.ItemCell:Dispose()
	self.SoulHeadCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
