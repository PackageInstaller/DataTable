-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeCleanAwardDlg.lua

local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local ResPetMazeStep = require("ClientData/ResPetMazeStep")
local PetMazeCleanAwardDlg = Class("PetMazeCleanAwardDlg", UIControls.Window)

function PetMazeCleanAwardDlg:ctor()
	self.txtStarNum = UIControls.Label(self, "BgPanel/TextTitleStar/TextNum")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm, 0.5)
end

function PetMazeCleanAwardDlg:setData(actObj, layer)
	self.actObj = actObj
	self.actData = self.actObj.actData
	self.layer = layer

	self:refreshView()
end

function PetMazeCleanAwardDlg:refreshView()
	local layerConfig = ResPetMazeLayer[self.layer]

	self.nmlAwardCellList = self.nmlAwardCellList or {}

	local nmlAwardIdList = {}

	for i = 1, self.actData.totalAwardTimes do
		table.insert(nmlAwardIdList, layerConfig.normal_award)
	end

	ClientUtils.CreatePreviewBonusSumGrid(self, self.nmlAwardCellList, "BgPanel/AwardPanel/AwardNmlPanel/AwardList", nmlAwardIdList)

	local starNum = 0

	self.areaAwardCellList = self.areaAwardCellList or {}

	local areaAwardIdList = {}
	local areaNum = self.actData.needFinishNormalAreaCount
	local qualityNumList = self.actData.miscConfig.quality_num

	for i = #qualityNumList, 1, -1 do
		local quality = i
		local qualityNum = qualityNumList[i]
		local tmp = math.min(areaNum, qualityNum)

		for j = 1, tmp do
			local qualityConfig = ResPetMazeQuality[self.layer][quality]

			table.insert(areaAwardIdList, layerConfig.spec_award)
			table.insert(areaAwardIdList, qualityConfig.quality_award)

			starNum = starNum + qualityConfig.star_award[2]
		end

		areaNum = areaNum - tmp

		if areaNum <= 0 then
			break
		end
	end

	ClientUtils.CreatePreviewBonusSumGrid(self, self.areaAwardCellList, "BgPanel/AwardPanel/AwardAreaPanel/AwardList", areaAwardIdList)
	self.txtStarNum:setText("×" .. starNum)

	self.scoreAwardCellList = self.scoreAwardCellList or {}

	local scoreAwardIdList = {}
	local bossId = self.actData.bossAreaData.id
	local maxScore = self.actData:getBossMaxScore(self.layer, bossId)
	local scoreConfigDic = ResPetMazeStep[bossId]

	for k, v in pairs(scoreConfigDic) do
		if k <= maxScore then
			table.insert(scoreAwardIdList, v.awardid)
		end
	end

	ClientUtils.CreatePreviewBonusSumGrid(self, self.scoreAwardCellList, "BgPanel/AwardPanel/AwardBossPanel/AwardList", scoreAwardIdList)
end

function PetMazeCleanAwardDlg:onClickBtnConfirm()
	self:setVisible(false)
end

return PetMazeCleanAwardDlg
