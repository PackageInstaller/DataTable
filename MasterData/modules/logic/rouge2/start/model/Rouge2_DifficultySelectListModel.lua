-- chunkname: @modules/logic/rouge2/start/model/Rouge2_DifficultySelectListModel.lua

module("modules.logic.rouge2.start.model.Rouge2_DifficultySelectListModel", package.seeall)

local Rouge2_DifficultySelectListModel = class("Rouge2_DifficultySelectListModel", ListScrollModel)

function Rouge2_DifficultySelectListModel:init()
	local allPageList, diffMap = Rouge2_DifficultySelectListModel.getDifficultyList()

	self._diffMap = diffMap
	self._curPageIndex = 1
	self._selectDiff = nil

	self:setList(allPageList)
end

function Rouge2_DifficultySelectListModel:selectDifficulty(difficulty)
	if self._diffMap then
		if not self._diffMap or self._selectDiff == difficulty then
			return
		end

		self._selectDiff = difficulty

		Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectDifficulty, difficulty)
	end
end

function Rouge2_DifficultySelectListModel:getCurSelectDifficulty()
	return self._selectDiff
end

function Rouge2_DifficultySelectListModel:getCurSelectPageIndex()
	return self._curPageIndex
end

function Rouge2_DifficultySelectListModel:isPageUnlock(pageIndex)
	local pageNum = self:getCount()

	if pageIndex < 0 or pageNum < pageIndex then
		return false
	end

	local pageDiffList = self:getByIndex(pageIndex)

	if not pageDiffList then
		return false
	end

	for _, diffCo in ipairs(pageDiffList) do
		local diffId = diffCo.difficulty
		local isUnlock = Rouge2_OutsideModel.instance:isOpenedDifficulty(diffId)

		if isUnlock then
			return true
		end
	end

	return false, ToastEnum.Rouge2LockDifficulty
end

function Rouge2_DifficultySelectListModel:canSwitchPage(isNext)
	if isNext then
		if not (self._curPageIndex + 1) then
			local targetPageIndex = self._curPageIndex - 1

			return self:isPageUnlock(targetPageIndex)
		end
	end
end

function Rouge2_DifficultySelectListModel:switchPage(isNext)
	if isNext then
		if not (self._curPageIndex + 1) then
			local tagetPageIndex = self._curPageIndex - 1

			return self:switch2TargetPage(tagetPageIndex)
		end
	end
end

function Rouge2_DifficultySelectListModel:isIndexValid(isNext)
	if isNext then
		if not (self._curPageIndex + 1) then
			local index = self._curPageIndex - 1

			return index > 0 and index <= self:getCount()
		end
	end
end

function Rouge2_DifficultySelectListModel:switch2TargetPage(pageIndex)
	local canSwitch, toastId = self:isPageUnlock(pageIndex)

	if not canSwitch then
		return false, toastId
	end

	self._curPageIndex = pageIndex

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchDifficultyPage, self._curPageIndex)

	local diffList = self:getByIndex(pageIndex)
	local selectDiffCo = diffList and diffList[1]

	self:selectDifficulty(selectDiffCo.difficulty)

	return true
end

function Rouge2_DifficultySelectListModel:selectNewestDifficulty()
	local dataList = self:getList()
	local index, difficulty = Rouge2_DifficultySelectListModel.getNewestDifficulty(dataList)

	if index and difficulty then
		self:switch2TargetPage(index)
		self:selectDifficulty(difficulty)
	end
end

function Rouge2_DifficultySelectListModel.getDifficultyList()
	local difficultyList = Rouge2_Config.instance:getDifficultyCoList()
	local allPageList = {}
	local pageDiffList = {}
	local diffMap = {}

	for i, diffCo in ipairs(difficultyList) do
		local id = diffCo.difficulty

		diffMap[id] = diffCo

		table.insert(pageDiffList, diffCo)

		if #pageDiffList >= Rouge2_Enum.DifficultyPageNum then
			table.insert(allPageList, pageDiffList)

			pageDiffList = {}
		end
	end

	if #pageDiffList > 0 then
		table.insert(allPageList, pageDiffList)

		pageDiffList = {}
	end

	return allPageList, diffMap
end

function Rouge2_DifficultySelectListModel.getNewestDifficulty(allPageList)
	for i = #allPageList, 1, -1 do
		local pageMo = allPageList[i]

		if pageMo then
			if not #pageMo then
				local difficultyNum = 0

				for j = difficultyNum, 1, -1 do
					local diffCo = pageMo[j]
					local difficulty = diffCo.difficulty
					local isUnlock = Rouge2_OutsideModel.instance:isOpenedDifficulty(difficulty)

					if isUnlock then
						return i, difficulty
					end
				end
			end
		end
	end

	return nil, nil
end

Rouge2_DifficultySelectListModel.instance = Rouge2_DifficultySelectListModel.New()

return Rouge2_DifficultySelectListModel
