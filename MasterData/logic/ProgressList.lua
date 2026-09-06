-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ProgressList.lua

module("logic.extensions.operationsummary.view.ProgressList", package.seeall)

local ProgressList = class("ProgressList")

function ProgressList:ctor()
	self._updateCellHandler = nil
	self._clearCellHandler = nil
	self._exParams = {}
	self._cellList = {}
	self._isHorizontal = true
end

function ProgressList.create(scrollerview, scrollercell, updateCellHandler, clearCellHandler, exParams)
	if scrollerview == nil then
		printError("传入的“scrollerview”实例为空")

		return nil
	end

	if scrollercell == nil then
		printError("传入的“scrollercell”实例为空")

		return nil
	end

	if updateCellHandler == nil or clearCellHandler == nil then
		printError("不能没有更新回调或清理回调")

		return nil
	end

	local instance = ProgressList.New()

	instance:_init(scrollerview, scrollercell, updateCellHandler, clearCellHandler, exParams)

	return instance
end

function ProgressList:reloadDataList(dataList)
	if dataList == nil or #dataList == 0 then
		printError("dataList不能为nil 或 长度为0")

		return
	end

	local goNum = #dataList
	local goSize = 0

	goSize = self._isHorizontal and GameUtil.getWidth(self._scrollercell) or GameUtil.getHeight(self._scrollercell)

	if not self._exParams.goSpacing then
		local goSpacing = goSize * 1.3820000000000001
		local sliderLength = goNum * goSpacing
		local contentLength = sliderLength + goSize

		if self._isHorizontal then
			GameUtil.setWidth(self._content, contentLength)
			GameUtil.setWidth(self._progressBar, sliderLength)
		else
			GameUtil.setHeight(self._content, contentLength)
			GameUtil.setHeight(self._progressBar, sliderLength)
		end

		local childList = GameUtil.getChildren(self._cellGroup)

		for _, go in ipairs(childList) do
			GameUtil.SetActive(go, false)
		end

		self._cellList = {}

		for idx, data in ipairs(dataList) do
			local cell = {}

			cell._go = childList[idx] or goutil.cloneAndSetParent(self._scrollercell, self._cellGroup.transform)
			cell._data = data
			cell._idx = idx

			if self._isHorizontal then
				local posX = idx * goSpacing

				GameUtil.setLocalPos(cell._go, posX, 0, 0)
			else
				local posY = idx * goSpacing

				GameUtil.setLocalPos(cell._go, 0, posY, 0)
			end

			GameUtil.SetActive(cell._go, true)
			table.insert(self._cellList, cell)
		end
	end
end

function ProgressList:update(percentage)
	self:updateCell()
	self:updateProgress(percentage)
end

function ProgressList:updateCell()
	for idx, cell in ipairs(self._cellList) do
		GameUtil.callBack(self._updateCellHandler, cell._go, cell._data, cell._idx)
	end
end

function ProgressList:updateProgress(percentage)
	self._progressBar:GetComponent(ComponentType.Slider).value = math.min(percentage, 1)
end

function ProgressList:updateProgressByList(list, curTimes)
	local curCellIdx = 0
	local totalCellIdx = #list
	local cellPercentage = 1 / totalCellIdx

	for idx, needTimes in ipairs(list) do
		if curTimes < needTimes then
			break
		end

		curCellIdx = idx
	end

	local nextCellIdx = math.min(curCellIdx + 1, totalCellIdx)

	if not list[curCellIdx] then
		local nextCellNeedTimes = list[nextCellIdx]

		self:updateProgress(curCellIdx / totalCellIdx + (curTimes - list[curCellIdx]) / (nextCellNeedTimes - list[curCellIdx]) * cellPercentage)
	end
end

function ProgressList:rollToIdx(index)
	index = index or 1

	local cellNum = #self._cellList
	local value = index / cellNum

	value = math.min(value, 1)

	if self._isHorizontal then
		self._scrollerview:GetComponent(ComponentType.ScrollRect).horizontalNormalizedPosition = value
	else
		self._scrollerview:GetComponent(ComponentType.ScrollRect).verticalNormalizedPosition = value
	end
end

function ProgressList:rollToIdxNewest(list, curTimes)
	local curCellIdx = 0

	for idx, needTimes in ipairs(list) do
		if curTimes < needTimes then
			break
		end

		curCellIdx = idx
	end

	self:rollToIdx(curCellIdx)
end

function ProgressList:dispose()
	for idx, cell in ipairs(self._cellList) do
		GameUtil.callBack(self._clearCellHandler, cell._go, cell._data, cell._idx)
	end
end

function ProgressList:_init(scrollerview, scrollercell, updateCellHandler, clearCellHandler, exParams)
	self._exParams = exParams or {}

	self:_registerHandler(updateCellHandler, clearCellHandler)

	local Content = exParams.Content
	local cellGroup = exParams.cellGroup
	local progressBar = exParams.progressBar

	self:_buildScrollerUi(scrollerview, scrollercell, Content, cellGroup, progressBar)

	self._isHorizontal = self._exParams.isHorizontal ~= false
end

function ProgressList:_registerHandler(updateCellHandler, clearCellHandler)
	self._updateCellHandler = updateCellHandler
	self._clearCellHandler = clearCellHandler
end

function ProgressList:_buildScrollerUi(scrollerview, scrollercell, Content, cellGroup, progressBar)
	self._scrollerview = scrollerview
	self._scrollercell = scrollercell
	self._content = Content or goutil.findChild(self._scrollerview, "ViewPort/Content")
	self._cellGroup = cellGroup or goutil.findChild(self._scrollerview, "ViewPort/Content/cellGroup")
	self._progressBar = progressBar or goutil.findChild(self._scrollerview, "ViewPort/Content/progressBar")

	GameUtil.SetActive(self._scrollercell, false)

	local cellGroupPos = GameUtil.getLocalPos(self._cellGroup)

	GameUtil.setLocalPos(self._cellGroup, 0, cellGroupPos.y, cellGroupPos.z)
end

return ProgressList
