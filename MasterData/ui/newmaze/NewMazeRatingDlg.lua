-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRatingDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "NewMazeRatingDlg"
local NewMazeRatingDlg = Class(strClassName, UIControls.Window)

function NewMazeRatingDlg:ctor(...)
	self:initUI()
end

function NewMazeRatingDlg:initUI()
	self.textDes = UIControls.Label(self, "BgPanel/TextDes")
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnPanel1/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnCloseClick)

	self.btnPanel1 = UIControls.Panel(self, "BgPanel/BtnPanel1")
	self.btnPanel2 = UIControls.Panel(self, "BgPanel/BtnPanel2")
	self.cellGrids = {}
	self.btnConfirm2 = UIControls.Button(self, "BgPanel/BtnPanel2/BtnConfirm", "Text")

	self.btnConfirm2:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "BgPanel/BtnPanel2/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnCloseClick)

	self.awardList = UIControls.ScrollView(self, "BgPanel/AwardList")
end

function NewMazeRatingDlg:setData(isFirstPass, isNewStage, hideDenyBtn)
	self.isFirstPass = isFirstPass
	self.isNewStage = isNewStage
	self.hideDenyBtn = hideDenyBtn
	self.newMazeData = CurAvatar:getNewMazeActData()

	if self.newMazeData == nil then
		return
	end

	self.heroId = self.newMazeData.heroId

	local miscLevelData = self.newMazeData.levelMiscData[self.newMazeData.ratingLevel]

	if self.isFirstPass then
		self.textTitle:setText(ResNewMazeDisplay[13060002].desc)
		self.btnPanel1:setVisible(false)
		self.btnPanel2:setVisible(true)

		if self.hideDenyBtn then
			self.btnDeny:setVisible(false)
		else
			self.btnDeny:setVisible(true)
		end

		if self.newMazeData.ratingLevel == #self.newMazeData.levelMiscData then
			self.btnConfirm2:setText(ResNewMazeDisplay[13060057].desc)
		end

		self.textDes:setText(miscLevelData.first_pass_desc or "")
		ClientUtils.CreateBonusGrid(self, self.cellGrids, "BgPanel/AwardList/Content", miscLevelData.first_pass_award_id, true, nil, true)

		if self.newMazeData.isFirstPassCurLevel == nil then
			for _, item in ipairs(self.cellGrids) do
				item:setGet(true)
			end
		else
			self.newMazeData.isFirstPassCurLevel = nil
		end

		if self.newMazeData.hasGotFirstPassAward[self.newMazeData.ratingLevel] then
			-- block empty
		end

		self.awardList:setVisible(true)
	else
		self.textTitle:setText(ResNewMazeDisplay[13060003].desc)
		self.btnPanel1:setVisible(true)
		self.btnPanel2:setVisible(false)

		self.firstPassChangeAward = self.newMazeData.firstPassChangeAward

		local notGotAward = {}

		if self.newMazeData.ratingLevel > 2 then
			for i = 2, self.newMazeData.ratingLevel - 1 do
				if self.firstPassChangeAward and self.firstPassChangeAward[i] then
					local award = self.newMazeData.levelMiscData[i].first_pass_award_id

					table.insert(notGotAward, award)
				end
			end
		end

		if #notGotAward == 0 then
			self.textDes:setText(miscLevelData.rating_desc)
			self.awardList:setVisible(false)
		else
			self.textDes:setText(miscLevelData.first_pass_sweep_award_desc)
			ClientUtils.CreatePreviewBonusSumGrid(self, self.cellGrids, "BgPanel/AwardList/Content", notGotAward, self.gridPrefabPath, nil, true)
			self.awardList:setVisible(true)
		end
	end

	self.btnConfirm2:setVisible(self.isFirstPass == true)
end

function NewMazeRatingDlg:onBtnCloseClick()
	self:setVisible(false)

	if self.isFirstPass then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:_realGoNextLayer()
		end
	end
end

function NewMazeRatingDlg:onBtnConfirmClick()
	if self.newMazeData.ratingLevel == #self.newMazeData.levelMiscData then
		if self.isFirstPass then
			local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

			if mainDlg then
				mainDlg:_realGoNextLayer()
			end
		end
	else
		local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

		settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Next, nil, true)
	end

	self:setVisible(false)
end

return NewMazeRatingDlg
