-- chunkname: @modules/logic/sp02/atomic/model/AtomicDataBaseInfoViewModel.lua

module("modules.logic.sp02.atomic.model.AtomicDataBaseInfoViewModel", package.seeall)

local AtomicDataBaseInfoViewModel = class("AtomicDataBaseInfoViewModel", BaseModel)

function AtomicDataBaseInfoViewModel:onInit()
	self:reInit()
end

function AtomicDataBaseInfoViewModel:reInit()
	self.targetPageIndex = nil
end

function AtomicDataBaseInfoViewModel:initDatas(param)
	local dataId = param.id
	local dataList = param.dataList

	self.dataList = {}

	for i, v in ipairs(dataList) do
		if self:isLibraryUnlock(v.id) then
			table.insert(self.dataList, v)
		end
	end

	self:updatePage(dataId)
end

function AtomicDataBaseInfoViewModel:updatePage(dataId)
	self.page = 1
	self.totalPage = #self.dataList

	for i = 1, self.totalPage do
		local data = self.dataList[i]

		if data.id == dataId then
			self.page = i

			break
		end
	end
end

function AtomicDataBaseInfoViewModel:clear()
	self.targetPageIndex = nil

	AtomicDataBaseInfoViewModel.super.clear(self)
end

function AtomicDataBaseInfoViewModel:getData()
	local data = {}

	data.dataList = {}

	local prevPage = self:getPrevPage()
	local nextPage = self:getNextPage()
	local curPage = self.page

	table.insert(data.dataList, self.dataList[prevPage])
	table.insert(data.dataList, self.dataList[curPage])
	table.insert(data.dataList, self.dataList[nextPage])

	data.page = self.page
	data.totalPage = self.totalPage

	return data
end

function AtomicDataBaseInfoViewModel:getPrevPage()
	local page = self.page - 1

	if page < 1 then
		page = self.totalPage
	end

	return page
end

function AtomicDataBaseInfoViewModel:getNextPage()
	local page = self.page + 1

	if page > self.totalPage then
		page = 1
	end

	return page
end

function AtomicDataBaseInfoViewModel:tryPrevPage()
	local page = self.page - 1

	if page < 1 then
		page = self.totalPage
	end

	self.page = page

	return true
end

function AtomicDataBaseInfoViewModel:tryNextPage()
	local page = self.page + 1

	if page > self.totalPage then
		page = 1
	end

	self.page = page

	return true
end

function AtomicDataBaseInfoViewModel:isSinglePage()
	return self.totalPage == 1
end

function AtomicDataBaseInfoViewModel:setTargetPageIndex(targetPage)
	self.targetPageIndex = targetPage
end

function AtomicDataBaseInfoViewModel:getTargetPageIndex()
	return self.targetPageIndex
end

function AtomicDataBaseInfoViewModel:clearTargetPageIndex()
	self.targetPageIndex = nil
end

function AtomicDataBaseInfoViewModel:isLibraryUnlock(id)
	local data = AtomicModel.instance:getData()

	return data:isLibraryUnlock(id)
end

AtomicDataBaseInfoViewModel.instance = AtomicDataBaseInfoViewModel.New()

return AtomicDataBaseInfoViewModel
