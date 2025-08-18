-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewYear\\ActivityNewYearLevelDlg.lua

local ActivityNewYearLevelCell = Class("ActivityNewYearLevelCell", UIControls.ScrollViewLoopCell)

function ActivityNewYearLevelCell:ctor()
	self.textTitle = UIControls.Label(self, "FunPanel/TxtTitle")
	self.textCookerDesc = UIControls.Label(self, "FunPanel/IconCook/TxtDes")
	self.textCDDesc = UIControls.Label(self, "FunPanel/IconCd/TxtDes")
	self.textQueueDesc = UIControls.Label(self, "FunPanel/IconQueue/TxtDes")
	self.rewardGrids = {}
	self.panelLock = UIControls.Panel(self, "ImgDis")
	self.textAwardTitle = UIControls.Label(self, "GiftPanel/TxtTitle")
	self.panelHook = UIControls.Image(self, "FunPanel/IconCook")
	self.panelCD = UIControls.Image(self, "FunPanel/IconCd")
	self.panelQueue = UIControls.Image(self, "FunPanel/IconQueue")
	self.imgBg = UIControls.Image(self, "Bg")
	self.panelSelf = UIControls.Panel(self, "")
end

function ActivityNewYearLevelCell:setData(levelData, nowLevel, actData)
	self.textTitle:setText(string.format(Lang.get(30633), levelData.level))

	local posNum = actData:getLevelPosNum(levelData.level)
	local miscData = actData.miscData

	self.textCookerDesc:setText(string.format(miscData.unlock_des1, posNum))

	if levelData.time_up and levelData.time_up > 0 then
		self.panelCD:setVisible(true)
		self.textCDDesc:setText(string.format(miscData.unlock_des2, math.floor((levelData.time_up or 0) / 100)))
	else
		self.panelCD:setVisible(false)
	end

	if actData:isQueueLocked(1, levelData.level) then
		self.panelQueue:setVisible(false)
	else
		self.panelQueue:setVisible(true)
		self.textQueueDesc:setText(miscData.unlock_des3)
	end

	if levelData.reward_id then
		ClientUtils.CreateBonusGrid(self, self.rewardGrids, "GiftPanel/GridPanel", levelData.reward_id, true, nil, true)

		for index, grid in ipairs(self.rewardGrids) do
			grid:setGet(nowLevel >= levelData.level)
		end
	else
		for _, grid in ipairs(self.rewardGrids) do
			grid:setVisible(false)
		end
	end

	self.panelLock:setVisible(nowLevel < levelData.level)

	local color = ResColor.REDEVE

	if nowLevel < levelData.level then
		color = ResColor.COLORRANK01

		self.imgBg:setImage(self.mParent.atlasPath, "BgNextLevel")
		self.panelSelf:setObjGray(true, true)
	elseif levelData.level == nowLevel then
		color = ResColor.COLORRANK06

		self.imgBg:setImage(self.mParent.atlasPath, "BgCurrent")
		self.panelSelf:setObjGray(false, true)
	else
		self.imgBg:setImage(self.mParent.atlasPath, "BgObtained")
		self.panelSelf:setObjGray(false, true)
	end
end

local strClassName = "ActivityNewYearLevelDlg"
local ActivityNewYearLevelDlg = Class(strClassName, UIControls.Window)

function ActivityNewYearLevelDlg:ctor()
	self:initUI()
end

function ActivityNewYearLevelDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.levelCells = {}
	self.view = UIControls.ScrollViewLoopV(self, "BgPanel/PrivilegeInfoPanel", 0, self.onCellChanged)
	self.textLevel = UIControls.Label(self, "BgPanel/CookLevelPanel/LevelPanel/TxtNum")
	self.textExp = UIControls.Label(self, "BgPanel/CookLevelPanel/LevelProgress/TxtNum")
	self.sliderExp = UIControls.Slider(self, "BgPanel/CookLevelPanel/LevelProgress")
end

function ActivityNewYearLevelDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityNewYearLevelCell(sender, self.cellPath .. "/EvePrivilegeCell", newIdx, 0, 0)
	else
		if targetCell.idx then
			self.levelCells[targetCell.idx] = nil
		end

		targetCell.idx = newIdx
	end

	self.levelCells[newIdx] = targetCell

	targetCell:setData(self.levelData[newIdx], self.nowLevel, self.actData)
end

function ActivityNewYearLevelDlg:onShow(actData)
	self.actData = actData
	self.levelData = actData.levelData
	self.nowLevel = actData.level

	self.textLevel:setText(self.nowLevel)

	if self.nowLevel == #self.levelData then
		self.textExp:setText(Lang.get(467))
		self.sliderExp:setValue(1)
	elseif self.nowLevel == 0 then
		self.textExp:setText("0/0")
		self.sliderExp:setValue(1)
	else
		local exp = actData.exp
		local data = self.levelData[self.nowLevel + 1]
		local nowExp = data.need_exp - self.levelData[self.nowLevel].need_exp

		self.textExp:setText(exp .. "/" .. nowExp)
		self.sliderExp:setValue(exp / nowExp)
	end

	self.cellPath = "System/Activity/ActivityNewYearEve"

	local clientTemplate = actData.actObject.clientTemplateData

	if clientTemplate and clientTemplate.src_replace and clientTemplate.src_replace[1] then
		self.cellPath = "System/Activity/" .. clientTemplate.src_replace[1]
	end

	self.atlasPath = "Atlas/ActivityAtlas/ActivityNewYearEveAtlas/ActivityEveCookInfoAtlas"

	if clientTemplate and clientTemplate.src_replace and clientTemplate.src_replace[2] then
		self.atlasPath = "Atlas/ActivityAtlas/" .. clientTemplate.src_replace[2]
	end

	self.view:setTotalCount(#self.levelData, self.nowLevel, false)
end

function ActivityNewYearLevelDlg:onCloseClick()
	self:setVisible(false)
end

return ActivityNewYearLevelDlg
