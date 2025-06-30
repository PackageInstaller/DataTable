-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkAnswerGame\\AmusementParkAnswerGameResultView.lua

local m = {
	itemCellPool = {},
	rewards = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderRewardCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView()
	UGUIUtil.SetText(self.TextRightNum, AmusementParkAnswerGameModule.rightCount)

	self.rewards = {}

	local cfgData = AmusementParkAnswerGameModule.cfgAnswerControlData

	for i = 1, #cfgData.Reward, 2 do
		local data = {}

		data.cid = cfgData.Reward[i]
		data.num = cfgData.Reward[i + 1] * AmusementParkAnswerGameModule.rightCount

		table.insert(self.rewards, data)
	end

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.rewards)
end

function m:OnRenderRewardCell(cell)
	local item = self.itemCellPool[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = ItemCell.New(cell.gameObject)
		self.itemCellPool[cell.gameObject:GetInstanceID()] = item
	end

	local data = self.rewards[cell.index + 1]

	item:SetItemByCID(data.cid, data.num)
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

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
