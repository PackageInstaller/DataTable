-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleGarrisonNoticeController.lua

local m = {
	IsFortMazeFinished = false,
	NoticeItems = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LunaBattleGarrisonNoticeItem = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleGarrisonNoticeItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnGarrisonNotice(zoneId, pName, soulCid)
		self:OnGarrisonNotice(zoneId, pName, soulCid)
	end

	self.NoticePool = UIObjectPool.New(8, function()
		return LunaBattleGarrisonNoticeItem.New(UnityEngine.Object.Instantiate(self.NoticeItemPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.NoticeDataQueue = Queue.New()
end

function m:OnUpdate()
	if self.NoticeDataQueue.Size > 0 then
		local canAdd = false

		if #self.NoticeItems == 0 then
			canAdd = true
		else
			local sampleItem = self.NoticeItems[1]

			if sampleItem:IsMoveComplete() then
				canAdd = true
			end
		end

		if canAdd then
			local data = self.NoticeDataQueue:Dequeue()

			self:AddNotice(data)
		end
	end

	for i = 1, #self.NoticeItems do
		local item = self.NoticeItems[i]

		item:OnUpdate()
	end

	for i = #self.NoticeItems, 1, -1 do
		local item = self.NoticeItems[i]

		if item:IsExpired() then
			self:ReleaseItem(item, i)
		end
	end
end

function m:Show()
	self:AddListeners()
end

function m:Hide()
	self:RemoveListeners()
	self:Clear()

	self.IsFortMazeFinished = false
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.LunaBattleLineGarrisonNotice, self.DelegateOnGarrisonNotice)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LunaBattleLineGarrisonNotice, self.DelegateOnGarrisonNotice)
end

function m:SetData(zonePOD, isFortMazeFinished)
	self.ZonePOD = zonePOD
	self.IsFortMazeFinished = isFortMazeFinished
end

function m:OnGarrisonNotice(zoneId, pName, soulCid)
	if not self.IsFortMazeFinished or self.ZonePOD.garrison == nil then
		return
	end

	if self.ZonePOD.zoneId == zoneId then
		self.NoticeDataQueue:Enqueue({
			pName = pName,
			soulCid = soulCid
		})
	end
end

function m:AddNotice(data)
	local item = self.NoticePool:Obtain()

	item.View:SetActive(true)
	item.View.transform:SetParent(self.NoticeRoot.transform, false)
	item:SetData(data.pName, data.soulCid)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(item.View.transform)

	local newItemSpace = item:GetHeight() + 15

	item:Play(0, -newItemSpace)

	for i = 1, #self.NoticeItems do
		local otherItem = self.NoticeItems[i]

		otherItem:Play(newItemSpace)
	end

	table.insert(self.NoticeItems, item)
end

function m:ReleaseItem(item, index)
	item.View:SetActive(false)
	item:Reset()
	self.NoticePool:Release(item)
	table.remove(self.NoticeItems, index)
end

function m:Clear()
	for i = #self.NoticeItems, 1, -1 do
		local item = self.NoticeItems[i]

		self:ReleaseItem(item, i)
	end

	self.NoticeDataQueue:Clear()
end

function m:Dispose()
	self:Clear()
	self.NoticePool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
