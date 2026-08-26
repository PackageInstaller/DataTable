-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_LineSegmentList.lua

local ti = table.insert
local sf = string.format
local string_rep = string.rep

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_LineSegmentList", package.seeall)

local V3a4_Chg_GameView_LineSegmentList = class("V3a4_Chg_GameView_LineSegmentList", RougeSimpleItemBase)

function V3a4_Chg_GameView_LineSegmentList:ctor(ctorParam)
	self:__onInit()
	V3a4_Chg_GameView_LineSegmentList.super.ctor(self, ctorParam)

	self._objItemList = {}
end

function V3a4_Chg_GameView_LineSegmentList:_Line_itemGo()
	local p = self:parent()

	return p:Line_itemGo()
end

function V3a4_Chg_GameView_LineSegmentList:_editableInitView()
	V3a4_Chg_GameView_LineSegmentList.super._editableInitView(self)

	local childCount = self:childCount()

	for i = 0, childCount - 1 do
		local childTr = self._trans:GetChild(i)
		local item = self:_create_V3a4_Chg_GameView_Line_item(childTr.gameObject)

		item:setActive(false)
		ti(self._objItemList, item)
	end

	self._used = 0
	self._using = 0
	self._lastSaved = 0
	self._lineGourp = {}
end

function V3a4_Chg_GameView_LineSegmentList:clear()
	for _, lineItem in ipairs(self._objItemList) do
		lineItem:clear()
	end

	self._used = 0
	self._using = 0
	self._lastSaved = 0
	self._lineGourp = {}
end

function V3a4_Chg_GameView_LineSegmentList:lastUsedAndUsing()
	local lastGroup

	if #self._lineGourp >= 1 then
		lastGroup = self._lineGourp[#self._lineGourp]
	end

	if lastGroup then
		if not lastGroup.ed then
			local used = self._used

			return used, self._using
		end
	end
end

function V3a4_Chg_GameView_LineSegmentList:_doRecycle()
	local function swap(arr, i, j)
		arr[i], arr[j] = arr[j], arr[i]
	end

	local st = self._lastSaved + 1
	local write = st
	local ed = self._using

	for read = st, ed do
		local isValid = not self._objItemList[read]:isZero()

		if isValid then
			if write ~= read then
				swap(self._objItemList, write, read)
			end

			write = write + 1
		end
	end

	local newUsing = math.max(st, write - 1)

	if newUsing ~= self._using then
		for i = self._used + 1, self._using do
			local lineItem = self._objItemList[i]

			lineItem:setIndex(i)
		end

		self._using = newUsing
	end

	return newUsing
end

function V3a4_Chg_GameView_LineSegmentList:_newGroup(newUsedIndex)
	local st = self._lastSaved + 1
	local ed = newUsedIndex

	ti(self._lineGourp, {
		st = st,
		ed = ed
	})

	self._lastSaved = ed

	local endLineItem = self._objItemList[ed]
	local endItem = endLineItem:endItem()
	local endKey = endItem:key()

	if isDebugBuild and not endItem:isEnd() then
		if ChgEnum.rDir then
			self:dumpLog()
		end

		assert(false, "_newGroup")
	end

	for i = st, ed do
		local lineItem = self._objItemList[i]
		local infoList = lineItem:getValidItemInfoList()
		local lineDir = lineItem:getDir()
		local itemCount = #infoList

		for j, info in ipairs(infoList) do
			local item = info.item
			local mapObj = item:mapObj()
			local key = mapObj:key()

			self:baseViewContainer():addVisitByLine(j, itemCount, lineDir, key)

			if mapObj:group() > 0 then
				local groupList = self:baseViewContainer():getGroupListByGroupId(mapObj:group())

				for _, gpMapObj in ipairs(groupList) do
					if gpMapObj:isCheckPoint() then
						gpMapObj:bindTargetKey(endKey)
					end
				end
			elseif item:isCheckPoint() then
				mapObj:bindTargetKey(endKey)
			end
		end

		lineItem:setActive_finish(true)
	end
end

function V3a4_Chg_GameView_LineSegmentList:_isDirty()
	return self._using ~= self._used
end

function V3a4_Chg_GameView_LineSegmentList:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_objItemList")
	self:__onDispose()
end

function V3a4_Chg_GameView_LineSegmentList:_lastFinalUsed()
	return self._objItemList[self._used]
end

function V3a4_Chg_GameView_LineSegmentList:_lastFinalUsedEndItem()
	local lineItem = self:_lastFinalUsed()

	if not lineItem then
		return
	end

	return lineItem:endItem()
end

function V3a4_Chg_GameView_LineSegmentList:current()
	if not self:_isDirty() then
		return nil
	end

	return self._objItemList[self._using]
end

function V3a4_Chg_GameView_LineSegmentList:currentDir()
	local lineItem = self:recentValidLineItem()

	return lineItem and lineItem:getDir() or ChgEnum.Dir.None
end

function V3a4_Chg_GameView_LineSegmentList:recentValidLineItem(depth, optSt, optEd)
	depth = depth or 1

	local used, using = self:lastUsedAndUsing()

	if optSt then
		used = optSt
	end

	if optEd then
		using = optEd
	end

	local lineItem = self._objItemList[using]

	while lineItem and used <= using do
		if not lineItem:isZero() then
			depth = depth - 1

			if depth == 0 then
				return lineItem
			end
		end

		using = using - 1
		lineItem = self._objItemList[using]
	end

	return nil
end

function V3a4_Chg_GameView_LineSegmentList:getValidLineItemListFromEnd(optSt, optEd, depth)
	depth = depth or 99999

	local list = {}
	local used, using = self:lastUsedAndUsing()

	if optSt then
		used = optSt
	end

	if optEd then
		using = optEd
	end

	local lineItem = self._objItemList[using]

	while lineItem and used <= using do
		if depth == 0 then
			break
		end

		if not lineItem:isZero() then
			depth = depth - 1

			ti(list, lineItem)
		end

		using = using - 1
		lineItem = self._objItemList[using]
	end

	return list
end

function V3a4_Chg_GameView_LineSegmentList:recentValidLineItemBySpecificEnd(targetEndItem)
	local lineItem = self._objItemList[self._using]
	local using = self._using
	local lastGroup = self._lineGourp[#self._lineGourp]

	if lastGroup then
		if not lastGroup.ed then
			local used = self._used

			while lineItem and used <= using do
				if not lineItem:isZero() and targetEndItem == lineItem:endItem() then
					return lineItem
				end

				using = using - 1
				lineItem = self._objItemList[using]
			end

			return nil
		end
	end
end

function V3a4_Chg_GameView_LineSegmentList:getOrCreateLineItem(optStartItem, optDir, optEnergy, optRefLineItem)
	local isReuseLastone = false

	if self:current() then
		if self:current():isZero() then
			isReuseLastone = true
		end
	end

	if not isReuseLastone then
		if self._using < #self._objItemList then
			self._using = self._using + 1
		else
			ti(self._objItemList, self:_create_V3a4_Chg_GameView_Line_item())

			self._using = #self._objItemList
		end
	end

	local lineItem = self:current()

	if not optStartItem and self:_lastFinalUsed() then
		local lastEndItem = self:_lastFinalUsed():endItem()

		if not lastEndItem:isEnd() then
			optStartItem = lastEndItem
		end
	end

	optStartItem = optStartItem or self:baseViewContainer():startItem()

	if not optRefLineItem and (optDir or optStartItem) then
		local recentLineItem = self:recentValidLineItem()

		if recentLineItem and optStartItem == recentLineItem:endItem() and recentLineItem:getDir() == optDir then
			optRefLineItem = recentLineItem
		end
	end

	lineItem:bindStart(optStartItem, optDir, optEnergy, optRefLineItem)

	return lineItem
end

function V3a4_Chg_GameView_LineSegmentList:resetToIdle()
	if not self:_isDirty() then
		return
	end

	self:_resetToIdleImpl()
end

function V3a4_Chg_GameView_LineSegmentList:_calcSaveEnergy(refLineItem, refinfoList, refValidLastItem)
	local totSubEnergy = 0

	for _, info in ipairs(refinfoList) do
		if info.item:isPoint() then
			totSubEnergy = totSubEnergy + 1
		end

		if info.item == refValidLastItem then
			break
		end
	end

	local savedEnergy = refLineItem:startEnergy() - (totSubEnergy - 1)

	refLineItem:bindEnd(refValidLastItem)

	return savedEnergy
end

function V3a4_Chg_GameView_LineSegmentList:_resetToIdleImpl()
	local i = self._using
	local savedEnergy, validLastItem

	while i > self._used do
		local lineItem = self._objItemList[i]
		local infoList, indexFromEnd = lineItem:calcValidSubLineInfo()
		local validEndInfo = infoList[indexFromEnd]

		validLastItem = validEndInfo and validEndInfo.item or nil

		if not validLastItem then
			lineItem:clear()
		elseif validLastItem == self:_lastFinalUsedEndItem() then
			lineItem:clear()
		else
			savedEnergy = self:_calcSaveEnergy(lineItem, infoList, validLastItem)

			if lineItem:endItem() then
				break
			end
		end

		i = i - 1
	end

	local newUsedIndex = i

	if validLastItem then
		local lastValidLineItem = self._objItemList[newUsedIndex]
		local endIndex = newUsedIndex - 1
		local lineItemList = self:getValidLineItemListFromEnd(nil, endIndex, 3)
		local found = false

		for j = #lineItemList, 1, -1 do
			local lineItem = lineItemList[j]

			if not found then
				local infoList, indexFromEnd = lineItem:calcValidSubLineInfo()
				local validEndInfo = infoList[indexFromEnd]

				if validEndInfo then
					if not validEndInfo.item then
						local tmpValidLastItem

						if tmpValidLastItem == validLastItem then
							savedEnergy = self:_calcSaveEnergy(lineItem, infoList, validLastItem)
							found = true

							lastValidLineItem:clear()

							newUsedIndex = lineItem:index()
						end
					end
				end
			else
				lineItem:clear()
			end
		end
	end

	if savedEnergy then
		local newUsing = self:_doRecycle()

		newUsedIndex = math.min(newUsedIndex, newUsing)

		self:baseViewContainer():setEnergy(savedEnergy)

		for j = self._used + 1, newUsedIndex do
			local lineItem = self._objItemList[j]
			local infoList = lineItem:getValidItemInfoList()
			local lineDir = lineItem:getDir()
			local itemCount = #infoList

			for kk, info in ipairs(infoList) do
				local item = info.item
				local key = item:key()
				local mapObj = item:mapObj()

				if mapObj:isSavable() then
					mapObj:setHasSaved(true)
				end

				self:baseViewContainer():addVisitByLine(kk, itemCount, lineDir, key)
			end
		end

		if validLastItem and validLastItem:isEnd() then
			self:_newGroup(newUsedIndex)
		end
	end

	self._used = newUsedIndex
	self._using = newUsedIndex
end

function V3a4_Chg_GameView_LineSegmentList:lineGourpStartEndList()
	local list = {}

	for _, lastGroup in ipairs(self._lineGourp) do
		local st = lastGroup.st
		local ed = lastGroup.ed

		ti(list, {
			startLineItem = self._objItemList[st],
			endLineItem = self._objItemList[ed]
		})
	end

	return list
end

function V3a4_Chg_GameView_LineSegmentList:getAllVisitedCheckpointItemList()
	local list = {}
	local set = {}

	local function _append(item)
		if set[item] then
			return
		end

		set[item] = true

		ti(list, item)
	end

	for _, lastGroup in ipairs(self._lineGourp) do
		local st = lastGroup.st
		local ed = lastGroup.ed

		for i = st, ed do
			local lineItem = self._objItemList[i]
			local infoList = lineItem:getValidItemInfoList()

			for _, info in ipairs(infoList) do
				local item = info.item
				local mapObj = item:mapObj()

				if mapObj:group() > 0 then
					local groupList = self:baseViewContainer():getGroupListByGroupId(mapObj:group())

					for _, gpMapObj in ipairs(groupList) do
						if gpMapObj:isCheckPoint() then
							local gpItem = self:baseViewContainer():getItemByKey(gpMapObj:key())

							_append(gpItem)
						end
					end
				elseif item:isCheckPoint() then
					_append(item)
				end
			end
		end
	end

	set = nil

	return list
end

function V3a4_Chg_GameView_LineSegmentList:checkIsCompleted()
	local endItemList = self:baseViewContainer():endItemList()

	if #endItemList == #self._lineGourp then
		return true
	end

	return false
end

function V3a4_Chg_GameView_LineSegmentList:_create_V3a4_Chg_GameView_Line_item(srcGo)
	srcGo = srcGo or self:_Line_itemGo()

	local item = self:newObject(V3a4_Chg_GameView_Line_item)
	local go = gohelper.clone(srcGo, self.viewGO)

	item:init(go)
	item:setIndex(#self._objItemList + 1)

	return item
end

function V3a4_Chg_GameView_LineSegmentList:dumpLog()
	local refStrBuf = {}

	self:dump(refStrBuf)
	logError(table.concat(refStrBuf, "\n"))
end

function V3a4_Chg_GameView_LineSegmentList:dump(refStrBuf, depth)
	if not ChgEnum.rDir then
		return
	end

	depth = depth or 0

	local tab = string_rep("\t", depth)
	local tab2 = string_rep("\t", depth + 1)
end

return V3a4_Chg_GameView_LineSegmentList
