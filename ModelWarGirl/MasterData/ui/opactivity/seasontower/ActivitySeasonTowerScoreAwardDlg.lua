-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerScoreAwardDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActTowerScoreAward = require("ClientData/ResOpActTowerScoreAward")
local ResRandClient = require("ClientData/ResRandClient")
local SeasonTowerScoreAwardCell = Class("SeasonTowerScoreAwardCell", UIControls.ScrollViewLoopCell)

function SeasonTowerScoreAwardCell:ctor()
	self.imgBg = UIControls.Image(self, "")
	self.textNum = UIControls.Label(self, "ContentPanel/TextNum")
	self.btnGet = UIControls.Button(self, "ContentPanel/BtnAward")

	self.btnGet:addEventClick(self.onAwardGetClick)

	self.txtState = UIControls.Label(self, "ContentPanel/Text")
	self.gridsAward = {}
end

function SeasonTowerScoreAwardCell:setData(cellData, preCellData, nowScore, state, achieveState, preAchieveState)
	self.cellData = cellData

	local thisScore = cellData.score_need or 0

	self.textNum:setText(thisScore)

	local preScore = 0

	if preCellData then
		preScore = preCellData.score_need or 0
	end

	local got = false

	if state then
		self.txtState:setText(Lang.get(74))
		self.btnGet:setVisible(false)

		got = true
	elseif thisScore <= nowScore then
		self.txtState:setText("")
		self.btnGet:setVisible(true)
	else
		self.txtState:setText(Lang.get(99))
		self.btnGet:setVisible(false)
	end

	if preAchieveState then
		ClientUtils.CreateBonusGrid(self, self.gridsAward, "ContentPanel/AwardPanel", cellData.award_id, true, nil, true)
	else
		local bonus = {}
		local bonusData = ResRandClient[cellData.achieve_rand_id]
		local bonusId = bonusData.show_ids or {}
		local bonusNum = bonusData.show_nums or {}

		for index, iId in ipairs(bonusId) do
			local iNum = bonusNum[index] or 0

			table.insert(bonus, {
				iId,
				iNum
			})
		end

		bonusData = ResRandClient[cellData.award_id]
		bonusId = bonusData.show_ids
		bonusNum = bonusData.show_nums

		for index, iId in ipairs(bonusId) do
			local iNum = bonusNum[index] or 0
			local hasAdd = false

			for _, info in ipairs(bonus) do
				if info[1] == iId then
					hasAdd = true
					info[2] = info[2] + iNum

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

		for index = #self.gridsAward, #bonus - 1 do
			local newGrid = UIControls.getGridAwardContainer(self, "ContentPanel/AwardPanel")

			table.insert(self.gridsAward, newGrid)
		end

		for index, grid in ipairs(self.gridsAward) do
			if bonus[index] then
				local clientItem = BaseObject.GetObject(bonus[index][1], bonus[index][2])

				grid:setObj(clientItem)
				grid:setVisible(true)
				grid:setSpe(true, 1)
			else
				grid:setVisible(false)
			end
		end
	end

	for index, grid in ipairs(self.gridsAward) do
		grid:setGet(got)
	end
end

function SeasonTowerScoreAwardCell:onAwardGetClick(sender)
	RPC.opActTowerGetScoreAward(self.mParent.actObj.opId, {
		self.cellData.id
	})
end

local strClassName = "ActivitySeasonTowerScoreAwardDlg"
local ActivitySeasonTowerScoreAwardDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySeasonTowerScoreAwardDlg, ActivityPanelMixin)

function ActivitySeasonTowerScoreAwardDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/TextTime")
	self.textSelf = UIControls.Label(self, "BgPanel/TextSelf")
	self.view = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList", 0, self.onCellChanged)
	self.buffCells = {}
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.textDepositDrop = UIControls.Label(self, "BgPanel/SpecialAwardPanel/Text")
end

function ActivitySeasonTowerScoreAwardDlg:_setData()
	self.cellData = ResOpActTowerScoreAward[self.actObj.actId]

	self:_refreshData()
end

function ActivitySeasonTowerScoreAwardDlg:_refreshData(noRefreshScroll)
	local actData = self.actObj.actData

	self.awardState = actData.scoreAward or {}
	self.achieveState = actData.achieveAward or {}
	self.preAchieveState = actData.lastAchieveAward or {}
	self.nowScore = actData.score or 0

	self.textSelf:setText(string.format(Lang.get(30642), self.nowScore))

	local showIndex = 1

	for index, aInfo in ipairs(self.cellData) do
		if self.awardState[index] then
			showIndex = index
		else
			break
		end
	end

	if noRefreshScroll then
		for newIdx, cell in pairs(self.buffCells) do
			cell:setData(self.cellData[newIdx], self.cellData[newIdx - 1], self.nowScore, self.awardState[newIdx], self.achieveState[newIdx], self.preAchieveState[self.cellData[newIdx].achieve_award_id])
		end
	else
		self.view:setTotalCount(#self.cellData, showIndex)
	end

	self.textDepositDrop:setText(string.format(Lang.get(30636), actData:getDepositValue()))
end

function ActivitySeasonTowerScoreAwardDlg:onCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = SeasonTowerScoreAwardCell(sender, "System/SeasonTower/SeasonTowerAwardCell", newIdx)
	else
		self.buffCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.buffCells[newIdx] = targetCell

	if self.cellData[newIdx] ~= nil then
		targetCell:setData(self.cellData[newIdx], self.cellData[newIdx - 1], self.nowScore, self.awardState[newIdx], self.achieveState[newIdx], self.preAchieveState[self.cellData[newIdx].achieve_award_id])
	end
end

function ActivitySeasonTowerScoreAwardDlg:updateActivityData()
	self:_refreshData(true)
end

function ActivitySeasonTowerScoreAwardDlg:onCloseClick()
	self:setVisible(false)
end

return ActivitySeasonTowerScoreAwardDlg
