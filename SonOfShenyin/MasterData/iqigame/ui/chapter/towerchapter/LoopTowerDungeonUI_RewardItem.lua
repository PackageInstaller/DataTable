-- chunkname: @IQIGame\\UI\\Chapter\\TowerChapter\\LoopTowerDungeonUI_RewardItem.lua

local LoopTowerDungeonUI_RewardItem = {}

function LoopTowerDungeonUI_RewardItem.New(go, mainView)
	local o = Clone(LoopTowerDungeonUI_RewardItem)

	o:Initialize(go, mainView)

	return o
end

function LoopTowerDungeonUI_RewardItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.itemCell = nil

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function LoopTowerDungeonUI_RewardItem:InitComponent()
	return
end

function LoopTowerDungeonUI_RewardItem:InitDelegate()
	return
end

function LoopTowerDungeonUI_RewardItem:AddListener()
	return
end

function LoopTowerDungeonUI_RewardItem:RemoveListener()
	return
end

function LoopTowerDungeonUI_RewardItem:OnDestroy()
	return
end

function LoopTowerDungeonUI_RewardItem:Refresh(Data)
	self.data = Data

	if not self.itemCell then
		self.itemCell = ItemCell.New(self.CommonSlotUI)
	end

	self.itemCell.showMoneyNum = true

	self.itemCell:SetItemByCid(self.data.id, self.data.num)
end

return LoopTowerDungeonUI_RewardItem
