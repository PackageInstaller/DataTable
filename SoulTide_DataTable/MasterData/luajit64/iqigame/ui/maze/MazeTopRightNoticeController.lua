-- chunkname: @IQIGame\\UI\\Maze\\MazeTopRightNoticeController.lua

local m = {
	Interval = 0,
	LastShowItemTime = 0,
	TYPE_BUFF = 1,
	TYPE_RUNE = 2
}
local MazeBuffEffectItemController = require("IQIGame.UI.Maze.MazeBuffEffectItemController")
local MazeTopRightRuneNoticeItemController = require("IQIGame.UI.Maze.MazeTopRightRuneNoticeItemController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeTopRightNoticeData = {
	cid = 0,
	type = 0
}

function MazeTopRightNoticeData.New(type, cid, subType, userData)
	local obj = Clone(MazeTopRightNoticeData)

	obj:Init(type, cid, subType, userData)

	return obj
end

function MazeTopRightNoticeData:Init(type, cid, subType, userData)
	self.type = type
	self.cid = cid
	self.subType = subType
	self.userData = userData
end

function m.New(view, mainUIRoot)
	local obj = Clone(m)

	obj:Init(view, mainUIRoot)

	return obj
end

function m:Init(view, mainUIRoot)
	self.View = view
	self.MainUIRoot = mainUIRoot

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnBuffTriggered(sender, args)
		self:OnBuffTriggered(sender, args)
	end

	function self.DelegateOnRecycleItem(item)
		self:OnRecycleItem(item)
	end

	function self.DelegateOnAddBuff(dollId, buffCid)
		self:OnAddBuff(dollId, buffCid)
	end

	function self.DelegateOnRemoveBuff(dollId, buffCid)
		self:OnRemoveBuff(dollId, buffCid)
	end

	function self.DelegateOnNoticeRune(cid, subType, userData)
		self:OnNoticeRune(cid, subType, userData)
	end

	self.NoticeDataList = {}
	self.NoticeItems = {}
	self.BuffNoticePool = UIObjectPool.New(5, function()
		local item = MazeBuffEffectItemController.New(UnityEngine.Object.Instantiate(self.BuffNoticeItemPrefab), self.DelegateOnRecycleItem)

		return item
	end, function(item)
		local itemView = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(itemView)
	end)
	self.RuneNoticePool = UIObjectPool.New(5, function()
		local item = MazeTopRightRuneNoticeItemController.New(UnityEngine.Object.Instantiate(self.RuneNoticeItemPrefab), self.DelegateOnRecycleItem)

		return item
	end, function(item)
		local itemView = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(itemView)
	end)
	self.Interval = self.BuffNoticeItemPrefab:GetComponentInChildren(typeof(TweenPosition), true).duration

	self:AddListeners()
end

function m:AddListeners()
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.NotifyBuffTriggerCommandEventId, self.DelegateOnBuffTriggered)
	EventDispatcher.AddEventListener(EventID.MazeBuffAdded, self.DelegateOnAddBuff)
	EventDispatcher.AddEventListener(EventID.MazeBuffRemoved, self.DelegateOnRemoveBuff)
	EventDispatcher.AddEventListener(EventID.MazeTopRightRuneNotice, self.DelegateOnNoticeRune)
end

function m:RemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.NotifyBuffTriggerCommandEventId, self.DelegateOnBuffTriggered)
	EventDispatcher.RemoveEventListener(EventID.MazeBuffAdded, self.DelegateOnAddBuff)
	EventDispatcher.RemoveEventListener(EventID.MazeBuffRemoved, self.DelegateOnRemoveBuff)
	EventDispatcher.RemoveEventListener(EventID.MazeTopRightRuneNotice, self.DelegateOnNoticeRune)
end

function m:OnNoticeRune(cid, subType, userData)
	table.insert(self.NoticeDataList, MazeTopRightNoticeData.New(m.TYPE_RUNE, cid, subType, userData))
end

function m:OnBuffTriggered(sender, args)
	local command = args:ToLuaTable()
	local cfgBuffData = CfgBuffTable[command.BuffCid]

	if cfgBuffData.IsNeedText then
		table.insert(self.NoticeDataList, MazeTopRightNoticeData.New(m.TYPE_BUFF, command.BuffCid, Constant.Maze.BuffNoticeTypeTrigger))
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if #self.NoticeDataList > 0 and UnityEngine.Time.time - self.LastShowItemTime > self.Interval then
		local hasPrevious = self:PopupItem()

		if hasPrevious then
			self.LastShowItemTime = UnityEngine.Time.time + MazeBuffEffectItemController.GO_UP_DURATION
		else
			self.LastShowItemTime = UnityEngine.Time.time
		end
	end

	for i = 1, #self.NoticeItems do
		local item = self.NoticeItems[i]

		item:Update(elapseSeconds, realElapseSeconds)
	end
end

function m:PopupItem()
	local noticeData = self.NoticeDataList[1]

	table.remove(self.NoticeDataList, 1)

	if noticeData.type == m.TYPE_BUFF then
		local item = self.BuffNoticePool:Obtain()

		item.View.transform:SetParent(self.NoticeGrid.transform, false)
		item:SetData(noticeData)
		table.insert(self.NoticeItems, item)
	elseif noticeData.type == m.TYPE_RUNE then
		local item = self.RuneNoticePool:Obtain()

		item.View.transform:SetParent(self.NoticeGrid.transform, false)
		item:SetData(noticeData)
		table.insert(self.NoticeItems, item)
	end

	local hasPrevious = #self.NoticeItems > 1

	for i = 1, #self.NoticeItems do
		local lItem = self.NoticeItems[i]

		lItem:StartMove(hasPrevious)
	end

	return hasPrevious
end

function m:OnRecycleItem(item, isDestroy)
	item:Reset()

	if not isDestroy then
		item.View.transform:SetParent(self.MainUIRoot.transform, false)
	end

	local index = table.indexOf(self.NoticeItems, item)

	table.remove(self.NoticeItems, index)

	if item.Type == m.TYPE_BUFF then
		self.BuffNoticePool:Release(item)
	elseif item.Type == m.TYPE_RUNE then
		self.RuneNoticePool:Release(item)
	end
end

function m:OnAddBuff(dollId, buffCid)
	local cfgBuffData = CfgBuffTable[buffCid]

	if cfgBuffData.IsNeedText then
		table.insert(self.NoticeDataList, MazeTopRightNoticeData.New(m.TYPE_BUFF, buffCid, Constant.Maze.BuffNoticeTypeAdd))
	end
end

function m:OnRemoveBuff(dollId, buffCid)
	local cfgBuffData = CfgBuffTable[buffCid]

	if cfgBuffData.IsNeedText then
		table.insert(self.NoticeDataList, MazeTopRightNoticeData.New(m.TYPE_BUFF, buffCid, Constant.Maze.BuffNoticeTypeRemove))
	end
end

function m:Dispose()
	self:RemoveListeners()

	for i = #self.NoticeItems, 1, -1 do
		self:OnRecycleItem(self.NoticeItems[i], true)
	end

	self.BuffNoticePool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.MainUIRoot = nil
end

return m
