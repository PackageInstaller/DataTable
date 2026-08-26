-- chunkname: @modules/logic/rouge/view/RougePageProgress.lua

module("modules.logic.rouge.view.RougePageProgress", package.seeall)

local RougePageProgress = class("RougePageProgress", LuaCompBase)

function RougePageProgress:ctor()
	self._highLightRange = {
		false,
		false
	}
	self._totalPage = 0
end

function RougePageProgress:init(go)
	self._itemList = self:getUserDataTb_()
	self._goLayout = gohelper.findChild(go, "Root/#go_Layout")

	local transform = self._goLayout.transform
	local n = transform.childCount

	for i = 0, n - 1 do
		local childTrans = transform:GetChild(i)
		local item = RougePageProgressItem.New(self)

		item:init(childTrans)
		item:setHighLight(false)

		if i == n - 1 then
			item:setLineActiveByState(nil)
		else
			item:setLineActiveByState(RougePageProgressItem.LineStateEnum.Done)
		end

		table.insert(self._itemList, item)
	end

	self._totalPage = n
end

function RougePageProgress:setHighLightRange(endIndex, startIndex)
	startIndex = startIndex or 1

	local lastSt = self._highLightRange[1]
	local lastEd = self._highLightRange[2]

	if lastSt == startIndex and lastEd == endIndex then
		return
	end

	local from = lastEd and math.max(lastEd, startIndex) or startIndex
	local to = lastSt and math.min(lastSt, endIndex) or endIndex

	for i = from, to do
		local item = self._itemList[i]

		item:setHighLight(true)
	end

	if lastSt then
		for i = lastSt, from - 1 do
			local item = self._itemList[i]

			item:setHighLight(false)
		end
	end

	if lastEd then
		for i = to + 1, lastEd do
			local item = self._itemList[i]

			item:setHighLight(false)
		end
	end

	self._highLightRange[1] = startIndex
	self._highLightRange[2] = endIndex
end

function RougePageProgress:onDestroyView()
	return
end

function RougePageProgress:initData(initTotalPage, curPageIndex)
	local totalPage = initTotalPage or 0

	assert(totalPage <= self:capacity(), "[RougePageProgress] initData: totalPage=" .. tostring(totalPage) .. " maxPage=" .. tostring(self:capacity()))

	for i, item in ipairs(self._itemList) do
		local isActive = i <= totalPage

		if curPageIndex then
			local lineState = RougePageProgressItem.LineStateEnum.Done

			if i == curPageIndex then
				lineState = RougePageProgressItem.LineStateEnum.Edit
			end

			if curPageIndex < i then
				lineState = RougePageProgressItem.LineStateEnum.Locked
			end

			if isActive then
				item:setLineActiveByState((i == initTotalPage or nil) and (curPageIndex == initTotalPage and RougePageProgressItem.LineStateEnum.Done or curPageIndex + 1 == initTotalPage and RougePageProgressItem.LineStateEnum.Edit or RougePageProgressItem.LineStateEnum.Locked))
			end
		end

		item:setActive(isActive)
	end

	self._totalPage = totalPage
end

function RougePageProgress:capacity()
	return (self._itemList or nil) and (#self._itemList or 0)
end

function RougePageProgress:count()
	return self._totalPage
end

function RougePageProgress:highLightRange()
	return self._highLightRange[1], self._highLightRange[2]
end

function RougePageProgress:_getCurStartProgress()
	local i = self:_getStartProgressCount()

	if ViewMgr.instance:isOpen(ViewName.RougeInitTeamView) then
		return i
	end

	i = i - 1

	if ViewMgr.instance:isOpen(ViewName.RougeFactionView) then
		return i
	end

	i = i - 1

	if RougeModel.instance:isCanSelectRewards() then
		if ViewMgr.instance:isOpen(ViewName.RougeCollectionGiftView) then
			return i
		end

		i = i - 1
	end

	if ViewMgr.instance:isOpen(ViewName.RougeDifficultyView) then
		return i
	end

	i = i - 1

	return i
end

function RougePageProgress:_getStartProgressCount()
	local defaultPageCount = 3

	if RougeModel.instance:isCanSelectRewards() then
		defaultPageCount = defaultPageCount + 1
	end

	return defaultPageCount
end

function RougePageProgress:setData()
	self:initData(self:_getStartProgressCount(), self:_getCurStartProgress())
	self:setHighLightRange(self:_getCurStartProgress())
end

return RougePageProgress
