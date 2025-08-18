-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivityNoLimitScoreAwardDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActTowerScoreAward = require("ClientData/ResOpActTowerScoreAward")
local ResRandClient = require("ClientData/ResRandClient")
local NoLimitScoreAwardCell = Class("NoLimitScoreAwardCell", UIControls.ScrollViewLoopCell)

function NoLimitScoreAwardCell:ctor()
	self.panelTop = UIControls.Panel(self, "AwardPanelT")
	self.imgTop = UIControls.Image(self, "AwardPanelT")
	self.textNumTop = UIControls.Label(self, "AwardPanelT/CodePanel/TxtCodeNum")
	self.normalAwardCellsTop = {}
	self.gridSpecialBonusTop = UIControls.getGridAwardContainer(self, "AwardPanelT/GridSpecialAwardPanel")
	self.imgArrowTop = UIControls.Image(self, "AwardPanelT/IconArrow")
	self.panelNmlAwardTop = UIControls.getGridAwardContainer(self, "AwardPanelT/GridAwardPanel")
	self.btnGetTop = UIControls.Button(self, "AwardPanelT/BtnGet")

	self.btnGetTop:addEventClick(self.onGetAwardClick)

	self.panelBottom = UIControls.Panel(self, "AwardPanelB")
	self.imgBottom = UIControls.Image(self, "AwardPanelB")
	self.textNumBottom = UIControls.Label(self, "AwardPanelB/CodePanel/TxtCodeNum")
	self.normalAwardCellsBottom = {}
	self.gridSpecialBonusBottom = UIControls.getGridAwardContainer(self, "AwardPanelB/GridSpecialAwardPanel")
	self.imgArrowBottom = UIControls.Image(self, "AwardPanelB/IconArrow")
	self.panelNmlAwardBottom = UIControls.getGridAwardContainer(self, "AwardPanelB/GridAwardPanel")
	self.btnGetBottom = UIControls.Button(self, "AwardPanelB/BtnGet")

	self.btnGetBottom:addEventClick(self.onGetAwardClick)

	self.sliderValue = UIControls.Slider(self, "Slider")
	self.imgSliderBg1 = UIControls.Image(self, "Slider/Icon")
	self.panelDescTop = UIControls.Panel(self, "AwardPanelT/ImgDec")
	self.panelNmlEfcTop = UIControls.Panel(self, "AwardPanelT/IconArrow/EfxArrow")
	self.panelSpeEfcTop = UIControls.Panel(self, "AwardPanelT/GridSpecialAwardPanel/EfxAward")
	self.panelDescBottom = UIControls.Panel(self, "AwardPanelB/ImgDec")
	self.panelNmlEfcBottom = UIControls.Panel(self, "AwardPanelB/IconArrow/EfxArrow")
	self.panelSpeEfcBottom = UIControls.Panel(self, "AwardPanelB/GridSpecialAwardPanel/EfxAward")
end

function NoLimitScoreAwardCell:setData(cellData, preCellData, nowScore, state, achieveState, preAchieveState)
	self.cellData = cellData

	local thisScore = cellData.score_need or 0
	local isTop = self.mIndex % 2 == 1
	local keyStr = "Bottom"
	local pathStr = "AwardPanelB"

	if isTop then
		keyStr = "Top"
		pathStr = "AwardPanelT"

		self.panelTop:setVisible(true)
		self.panelBottom:setVisible(false)
	else
		self.panelTop:setVisible(false)
		self.panelBottom:setVisible(true)
	end

	self["textNum" .. keyStr]:setText(thisScore)

	local preScore = 0

	if preCellData then
		preScore = preCellData.score_need or 0
	end

	local enough = false
	local got = false

	if state then
		self.sliderValue:setValue(1)

		got = true

		self["img" .. keyStr]:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "BgSeasonTowerGift01")
		self["imgArrow" .. keyStr]:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "IconArrow01")
		self.imgSliderBg1:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "IconGetDis")
		self["btnGet" .. keyStr]:setVisible(false)
		self["panelDesc" .. keyStr]:setVisible(false)
		self["panelNmlEfc" .. keyStr]:setVisible(false)
		self["panelSpeEfc" .. keyStr]:setVisible(false)
	elseif thisScore <= nowScore then
		self.sliderValue:setValue(1)
		self["img" .. keyStr]:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "BgSeasonTowerGift02")
		self["imgArrow" .. keyStr]:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "IconArrow02")
		self.imgSliderBg1:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "IconGetSel")
		self["btnGet" .. keyStr]:setVisible(true)
		self["panelDesc" .. keyStr]:setVisible(true)
		self["panelNmlEfc" .. keyStr]:setVisible(true)
		self["panelSpeEfc" .. keyStr]:setVisible(false)

		enough = true
	else
		self["img" .. keyStr]:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "BgSeasonTowerGift03")
		self["imgArrow" .. keyStr]:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "IconArrow03")
		self.imgSliderBg1:setImage("Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas08", "IconGetNml")

		local preScore = 0

		if preCellData then
			preScore = preCellData.score_need or 0
		end

		self.sliderValue:setValue(math.max(0, (nowScore - preScore) / (thisScore - preScore)))
		self["btnGet" .. keyStr]:setVisible(false)
		self["panelDesc" .. keyStr]:setVisible(false)
		self["panelNmlEfc" .. keyStr]:setVisible(false)
		self["panelSpeEfc" .. keyStr]:setVisible(false)
	end

	local bonus = {}
	local bigAwardId, bigAwardNum, secondBigAwardId, secondBigAwardNum

	if cellData.special_item_id then
		bigAwardId = cellData.special_item_id[1]
		secondBigAwardId = cellData.special_item_id[2]
	end

	local bonusData = ResRandClient[cellData.achieve_rand_id] or {}
	local bonusId = bonusData.show_ids or {}
	local bonusNum = bonusData.show_nums or {}

	if not preAchieveState then
		for index, iId in ipairs(bonusId) do
			local iNum = bonusNum[index] or 0

			if iId == bigAwardId then
				bigAwardNum = iNum
			elseif iId == secondBigAwardId then
				secondBigAwardNum = iNum
			else
				table.insert(bonus, {
					iId,
					iNum
				})
			end
		end
	end

	bonusData = ResRandClient[cellData.award_id] or {}
	bonusId = bonusData.show_ids or {}
	bonusNum = bonusData.show_nums or {}

	for index, iId in ipairs(bonusId) do
		local iNum = bonusNum[index] or 0

		if iId == bigAwardId then
			bigAwardNum = (bigAwardNum or 0) + iNum
		elseif iId == secondBigAwardId then
			secondBigAwardNum = (secondBigAwardNum or 0) + iNum
		else
			local hasAdd = false

			for _, info in ipairs(bonus) do
				if info[1] == iId then
					hasAdd = true
					iNum = info[2] + iNum
					info[2] = iNum

					break
				end
			end

			if not hasAdd then
				table.insert(bonus, {
					iId,
					iNum
				})
			end
		end
	end

	if bigAwardNum and secondBigAwardNum then
		table.insert(bonus, {
			secondBigAwardId,
			secondBigAwardNum
		})
	end

	local normalCells = self["normalAwardCells" .. keyStr]

	for index = #normalCells, #bonus - 1 do
		local newGrid = UIControls.getGridAwardContainer(self, pathStr .. "/GridAwardPanel")

		table.insert(normalCells, newGrid)
	end

	for index, grid in ipairs(normalCells) do
		if bonus[index] then
			local clientItem = BaseObject.GetObject(bonus[index][1], bonus[index][2])

			grid:setObj(clientItem)
			grid:setVisible(true)
			grid:setGet(got)
		else
			grid:setVisible(false)
		end
	end

	local width = 164 * #bonus + 30
	local bigBonus

	if bigAwardNum then
		bigBonus = BaseObject.GetObject(bigAwardId, bigAwardNum)
	elseif secondBigAwardNum then
		bigBonus = BaseObject.GetObject(secondBigAwardId, secondBigAwardNum)
	end

	local bigAwardGrid = self["gridSpecialBonus" .. keyStr]

	if bigBonus then
		width = width + 194

		bigAwardGrid:setObj(bigBonus)
		bigAwardGrid:setVisible(true)
		bigAwardGrid:setGet(got)

		if enough then
			self["panelSpeEfc" .. keyStr]:setVisible(true)
		end
	else
		bigAwardGrid:setVisible(false)
	end

	self["panel" .. keyStr]:setRectSize(width, 242)
	self["panelDesc" .. keyStr]:setRectSize(width + 25, 294)
end

function NoLimitScoreAwardCell:onGetAwardClick()
	RPC.opActTowerGetScoreAward(self.mParent.actObj.opId, {
		self.cellData.id
	})
end

local strClassName = "ActivityNoLimitScoreAwardDlg"
local ActivityNoLimitScoreAwardDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityNoLimitScoreAwardDlg, ActivityPanelMixin)

function ActivityNoLimitScoreAwardDlg:initUI()
	self.textSelf = UIControls.Label(self, "BgPanel/Bg/InfoPanel/CodePanel/TxtCodeNum")
	self.textDepositDrop = UIControls.Label(self, "BgPanel/Bg/InfoPanel/CleanAwardPanel/TxtCodeNum")
	self.btnGetAll = UIControls.Button(self, "BgPanel/Bg/BtnGet")

	self.btnGetAll:addEventClick(self.onGetAllClick)

	self.panelAllGet = UIControls.Panel(self, "BgPanel/Bg/GotAllPanel")
	self.view = UIControls.ScrollViewLoopH(self, "BgPanel/Bg/TapAwardList", 0, self.onCellChanged)
	self.buffCells = {}
end

function ActivityNoLimitScoreAwardDlg:_setData()
	self.cellData = ResOpActTowerScoreAward[self.actObj.actId]

	self:_refreshData()
end

function ActivityNoLimitScoreAwardDlg:_refreshData(noRefreshScroll)
	local actData = self.actObj.actData

	self.awardState = actData.scoreAward or {}
	self.achieveState = actData.achieveAward or {}
	self.preAchieveState = actData.lastAchieveAward or {}
	self.nowScore = actData.score or 0

	self.textSelf:setText(self.nowScore)

	local showIndex = 1
	local canGet = false

	for index, aInfo in ipairs(self.cellData) do
		if self.awardState[index] then
			showIndex = index
		else
			if self.nowScore >= aInfo.score_need then
				canGet = true
			end

			break
		end
	end

	self.btnGetAll:setVisible(canGet)
	self.panelAllGet:setVisible(showIndex == #self.cellData)

	if noRefreshScroll then
		for newIdx, cell in pairs(self.buffCells) do
			cell:setData(self.cellData[newIdx], self.cellData[newIdx - 1], self.nowScore, self.awardState[newIdx], self.achieveState[newIdx], self.preAchieveState[self.cellData[newIdx].achieve_award_id])
		end
	else
		self.view:setTotalCount(#self.cellData, showIndex)
	end

	self.textDepositDrop:setText(actData:getDepositValue())
end

function ActivityNoLimitScoreAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = NoLimitScoreAwardCell(sender, "System/SeasonTower/SeasonTapAwardCell", newIdx)
	else
		self.buffCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.buffCells[newIdx] = targetCell

	if self.cellData[newIdx] ~= nil then
		targetCell:setData(self.cellData[newIdx], self.cellData[newIdx - 1], self.nowScore, self.awardState[newIdx], self.achieveState[newIdx], self.preAchieveState[self.cellData[newIdx].achieve_award_id])
	end
end

function ActivityNoLimitScoreAwardDlg:updateActivityData()
	self:_refreshData(true)
end

function ActivityNoLimitScoreAwardDlg:onGetAllClick()
	local toGetList = {}

	for index, aInfo in ipairs(self.cellData) do
		if self.nowScore >= (aInfo.score_need or 0) and not self.awardState[index] then
			table.insert(toGetList, index)
		end
	end

	if next(toGetList) then
		RPC.opActTowerGetScoreAward(self.actObj.opId, toGetList)
	end
end

return ActivityNoLimitScoreAwardDlg
