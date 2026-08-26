-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/model/ObserverBoxModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.model.ObserverBoxModel", package.seeall)

local ObserverBoxModel = class("ObserverBoxModel", BaseModel)

function ObserverBoxModel:onInit()
	self:reInit()
end

function ObserverBoxModel:reInit()
	self._pageInfos = {}
end

function ObserverBoxModel:getCurPage()
	if not self._curPage then
		if LuaUtil.tableNotEmpty(self._pageInfos) then
			for i = 1, #self._pageInfos do
				local allGet = self:isPageAllCardGet(i)

				if not allGet then
					self._curPage = i

					return self._curPage
				end

				if i == #self._pageInfos then
					self._curPage = i
				end
			end
		else
			self._curPage = 1
		end
	end

	return self._curPage
end

function ObserverBoxModel:setCurPage(page)
	self._curPage = page
end

function ObserverBoxModel:setPageInfos(infos)
	self._pageInfos = {}

	for _, info in ipairs(infos) do
		local infoMO = ObserverBoxPageMO.New()

		infoMO:init(info)

		self._pageInfos[info.page] = infoMO
	end
end

function ObserverBoxModel:updatePosInfo(posInfo)
	if self._pageInfos[self._curPage] then
		self._pageInfos[self._curPage]:updatePos(posInfo)
	end
end

function ObserverBoxModel:getPageInfo(pageIndex)
	local page = pageIndex or self:getCurPage()

	return self._pageInfos[page]
end

function ObserverBoxModel:getCardBonusId(pageIndex, rewardId)
	local pageInfo = self:getPageInfo(pageIndex)

	if not pageInfo then
		return 0
	end

	return pageInfo:getPosBonusId(rewardId)
end

function ObserverBoxModel:isCardRewardCouldGet(pageIndex, rewardId)
	local isGet = self:getCardBonusId(pageIndex, rewardId) > 0

	if isGet then
		return false
	end

	local isAllGet = self:isPageAllCardGet(pageIndex)

	if isAllGet then
		return false
	end

	if pageIndex > 1 then
		local isLastPageAllGet = self:isPageAllCardGet(pageIndex - 1)

		if not isLastPageAllGet then
			return false
		end
	end

	local bonusId = ObserverBoxModel.instance:getCardBonusId(pageIndex, rewardId)

	if bonusId and bonusId > 0 then
		return false
	end

	local couldGetCount = self:couldGetCardCount()

	return couldGetCount > 0
end

function ObserverBoxModel:couldGetCardCount()
	local itemCos = string.splitToNumber(ObserverBoxConfig.instance:getBoxCO().bonus, "#")
	local itemQuantity = ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2])

	return (math.floor(itemQuantity / itemCos[3]))
end

function ObserverBoxModel:getMaxPage()
	local boxListCos = ObserverBoxConfig.instance:getBoxListCos()

	return #boxListCos
end

function ObserverBoxModel:getLockCardCount(pageId)
	local pageCos = ObserverBoxConfig.instance:getBoxListPageCos(pageId)
	local count = 0

	for i = #pageCos, 1, -1 do
		local bonusId = self:getCardBonusId(pageCos[i].cardId, pageCos[i].id)

		if not bonusId or bonusId < 1 then
			count = count + 1
		end
	end

	return count
end

function ObserverBoxModel:isPageAllCardGet(pageId)
	local pageCos = ObserverBoxConfig.instance:getBoxListPageCos(pageId)

	for i = #pageCos, 1, -1 do
		local bonusId = self:getCardBonusId(pageCos[i].cardId, pageCos[i].id)

		if not bonusId or bonusId < 1 then
			return false
		end
	end

	return true
end

function ObserverBoxModel:isAllPageCardGet()
	local maxPage = self:getMaxPage()

	return (self:isPageAllCardGet(maxPage))
end

function ObserverBoxModel:getTaskList()
	local taskMos = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ObserverBox, VersionActivity3_4Enum.ActivityId.LaplaceObserverBox)
	local tasks = {}

	for _, taskMo in pairs(taskMos) do
		table.insert(tasks, taskMo)
	end

	return tasks
end

function ObserverBoxModel:isHasTaskNotGet()
	local taskList = self:getTaskList()

	for _, taskMo in pairs(taskList) do
		if taskMo.finishCount == 0 then
			return true
		end
	end

	return false
end

ObserverBoxModel.instance = ObserverBoxModel.New()

return ObserverBoxModel
