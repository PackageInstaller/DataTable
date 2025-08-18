-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\CustomPoolAwardDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local CustomPoolPreviewCell = Class("CustomPoolPreviewCell", UIControls.Child)

function CustomPoolPreviewCell:ctor(...)
	self:initUI()
end

function CustomPoolPreviewCell:initUI(...)
	self.descTxt = UIControls.Label(self, "TextDes")
	self.processTxt = UIControls.Label(self, "TextNum")
	self.nmlBg = UIControls.Image(self, "BgNml")
	self.disBg = UIControls.Image(self, "BgDis")
	self.highBg = UIControls.Image(self, "BgHigh")
end

function CustomPoolPreviewCell:setAwardInfo(count, award, desc, highLight)
	self.needProcess = count

	if self.mParent.needReduceNum then
		self.needProcess = self.needProcess - self.mParent.needReduceNum
	end

	self.descTxt:setText(desc or "")

	if highLight then
		self.nmlBg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas7", "BgAchievementNml")
		self.disBg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas7", "BgAchievementDis")
		self.highBg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas7", "BgAchievementSel")
	else
		self.nmlBg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas7", "BgAchievementNml2")
		self.disBg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas7", "BgAchievementDis2")
		self.highBg:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas7", "BgAchievementSel2")
	end

	self.awardGridList = {}

	for i, itemId in ipairs(ResRandClient[award].show_ids) do
		local itemNum = ResRandClient[award].show_nums[i]
		local fakeItem = BaseObject.GetObject(itemId, itemNum)
		local grid = UIControls.getGridAwardContainer(self, "GridAwardContainer")

		grid.mDisableWays = true

		grid:setObj(fakeItem)
		grid.imgGet:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas", "BgCompleted")
		grid:setVisible(true)

		self.awardGridList[i] = grid
	end
end

function CustomPoolPreviewCell:refreshState(state, nowProcess)
	local stateName, numStrSon
	local isGot = false

	if state == "Got" then
		stateName = "CellUPCardAwardDis"
		isGot = true
		numStrSon = self.needProcess
	elseif state == "Focus" then
		stateName = "CellUPCardAwardHigh"
		numStrSon = nowProcess
	elseif state == "Lock" then
		stateName = "CellUPCardAwardNml"
		numStrSon = nowProcess
	end

	self.processTxt:setText(numStrSon .. "/" .. self.needProcess)
	self:playStateAnimator(stateName)

	for i, awardGrid in ipairs(self.awardGridList) do
		awardGrid:setState(false, isGot, true)
	end
end

local CustomPoolAwardDlg = Class("CustomPoolAwardDlg", UIControls.Window)

function CustomPoolAwardDlg:ctor(...)
	self.cells = {}
	self.closeBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.closeBtn:addEventClick(self._onClickBlock)

	self.cellMountPath = "BgPanel/AwardList/Viewport/Content"
	self.contentPanel = UIControls.ScrollView(self, "BgPanel/AwardList")

	self.contentPanel:addEventValueChanged(self._onScrollValueChanged)

	self.processSlider = UIControls.Slider(self, "BgPanel/AwardList/Viewport/Content/Slider")
	self.focusAwardPanel = UIControls.Panel(self, "SpecialAwardPanel")
	self.focusAwardBtn = UIControls.Button(self, "BgPanel/SpecialAwardPanel/BtnAward")

	self.focusAwardBtn:addEventClick(self._onClickFocusAward)

	self.focusAwardGridPath = "BgPanel/SpecialAwardPanel/BtnAward/GridPanel"
end

function CustomPoolAwardDlg:showPoolAwards(achieveData, nowProcess, gridConfigId, needReduceNum)
	if not achieveData then
		return
	end

	if not self.inited then
		self.cells = {}
		self.achieveData = achieveData
		self.needReduceNum = needReduceNum

		for i, awardInfo in ipairs(achieveData) do
			local count = awardInfo.count
			local award = awardInfo.award
			local desc = awardInfo.desc
			local highLight = awardInfo.high_light
			local cell = CustomPoolPreviewCell(self, self.cellMountPath, "System/HeroPool/CellUPCardAward")

			cell:setVisible(true)
			cell:setAwardInfo(count, award, desc, highLight)

			self.cells[i] = cell
		end

		if not self.focusAwardGrid then
			self.focusAwardGrid = UIControls.getGridAwardContainer(self, self.focusAwardGridPath)

			self.focusAwardGrid:setContainerConfig(gridConfigId)
		end

		self.inited = true
	end

	local isFocusIdx

	for i, cell in ipairs(self.cells) do
		if nowProcess >= cell.needProcess then
			cell:refreshState("Got")
		elseif not isFocusIdx then
			cell:refreshState("Focus", nowProcess)

			isFocusIdx = i
		else
			cell:refreshState("Lock", nowProcess)
		end
	end

	isFocusIdx = isFocusIdx or #self.cells
	self.nowFocusIdx = isFocusIdx

	self:_focusCellByIndex(isFocusIdx)
	self:_refresSlider(isFocusIdx, #self.cells)
	self:_refreshFocusAwardPanel()
end

CustomPoolAwardDlg.CELL_WIDTH = 150
CustomPoolAwardDlg.CELL_SPACE = 22.96
CustomPoolAwardDlg.CONTENT_WIDTH = 972.2

function CustomPoolAwardDlg:_focusCellByIndex(idx)
	local baseX = 0

	idx = math.max(1, idx - 2)

	local step = self.CELL_WIDTH + self.CELL_SPACE

	self.contentPanel:setContentX(baseX - (idx - 1) * step)
end

function CustomPoolAwardDlg:_refresSlider(idx, totalIdx)
	if not self.sliderInited then
		self.sliderTotalWidth = (totalIdx - 1) * (self.CELL_WIDTH + self.CELL_SPACE) + self.CELL_WIDTH / 2
		self.firstHalf = self.CELL_WIDTH / 2 / self.sliderTotalWidth
		self.stepValue = (self.CELL_WIDTH + self.CELL_SPACE) / self.sliderTotalWidth
		self.sliderInited = true
	end

	local value

	value = idx == totalIdx and 1 or self.firstHalf + (idx - 1) * self.stepValue

	self.processSlider:setValue(value)
end

function CustomPoolAwardDlg:_refreshFocusAwardPanel()
	self.nextHighLight = nil

	if self.nowFocusIdx < #self.achieveData then
		self:_refreshViewCells()

		for i = self.nowFocusIdx + 1, #self.achieveData do
			if self.achieveData[i].high_light and i > self.viewLastIdx then
				self.nextHighLight = i

				local awardId = self.achieveData[i].award
				local itemId = ResRandClient[awardId].show_ids[1]
				local awardItem = BaseObject.GetObject(itemId)

				self.focusAwardGrid:setObj(awardItem)

				self.focusAwardGrid.grid.mEnableTips = false

				self.focusAwardGrid:setVisible(true)

				break
			end
		end
	end

	self.focusAwardPanel:setVisible(self.nextHighLight ~= nil)
end

function CustomPoolAwardDlg:_onScrollValueChanged(sender, valueX, valueY)
	local barValue = self.contentPanel:getHorizontalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	self:_refreshFocusAwardPanel()
end

function CustomPoolAwardDlg:_refreshViewCells()
	local barValue = self.contentPanel:getHorizontalValue()
	local cellCount = #self.cells
	local contentTotalWidth = cellCount * (self.CELL_WIDTH + self.CELL_SPACE) - self.CELL_SPACE
	local barMapWidth = contentTotalWidth - self.CONTENT_WIDTH
	local slideWidth = barValue * barMapWidth

	self.viewLastIdx = math.floor((self.CONTENT_WIDTH + slideWidth) / (self.CELL_WIDTH + self.CELL_SPACE) + 0.5)
end

function CustomPoolAwardDlg:_onClickBlock(...)
	self:setVisible(false)
end

function CustomPoolAwardDlg:_onClickFocusAward(...)
	if self.nextHighLight then
		self:_focusCellByIndex(self.nextHighLight)
	end
end

return CustomPoolAwardDlg
