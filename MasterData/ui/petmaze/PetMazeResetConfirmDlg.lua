-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeResetConfirmDlg.lua

local ResPetMazeNormalStage = require("ClientData/ResPetMazeNormalStage")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local PetMazeResetConfirmDlg = Class("PetMazeResetConfirmDlg", UIControls.Window)

function PetMazeResetConfirmDlg:ctor()
	self.btnCancel = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnCancel:addEventClick(self.onClickBtnCancel)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm)
end

function PetMazeResetConfirmDlg:setData(actData, data)
	self.actData = actData
	self.actObj = self.actData.actObject
	self.data = data

	self:refreshView()
end

function PetMazeResetConfirmDlg:refreshView()
	self.heroNodeList = self.heroNodeList or {}
	self.awardNodeList = self.awardNodeList or {}
	self.buffNodeList = self.buffNodeList or {}

	local awardList = {}
	local heroList = {}
	local buffList = {}
	local dataList = {}

	if not self.data then
		local list = self.actData.normalAreaDataList

		for i = 1, #list do
			local areaData = list[i]

			if areaData.is_pass then
				table.insert(dataList, areaData)
			end
		end
	else
		table.insert(dataList, self.data)
	end

	local layer = self.actData.layer
	local layerConfig = ResPetMazeLayer[layer]
	local curStar = self.actData.seasonStar
	local newStar = curStar

	for i = 1, #dataList do
		local data = dataList[i]

		newStar = newStar - data.star

		for j = 1, #data.selectHeroList do
			table.insert(heroList, data.selectHeroList[j])
		end

		local qualityConfig = ResPetMazeQuality[layer][data.quality]
		local checkHaveSpecialHero = false

		if #data.selectHeroList > 0 then
			checkHaveSpecialHero = data.selectHeroList[1].id == data.specialHeroId
		end

		if checkHaveSpecialHero then
			table.insert(awardList, layerConfig.spec_award)
			table.insert(awardList, qualityConfig.quality_award)
		else
			table.insert(awardList, qualityConfig.quality_award)
		end
	end

	local bpConfig = self.actData:getBattlePassData(true)

	for k, v in pairs(bpConfig) do
		if newStar < v.star_need and curStar >= v.star_need then
			table.insert(buffList, v.free_award)
		end
	end

	ClientUtils.createHeroGrids(self, heroList, self.heroNodeList, "BgPanel/HeroPanel/HeroList/Content")
	ClientUtils.CreatePreviewBonusSumGrid(self, self.awardNodeList, "BgPanel/AwardPanel/AwardList/Content", awardList)
	ClientUtils.CreateBuffGrids(self, self.buffNodeList, "BgPanel/BuffPanel/BuffList/Content", buffList)
end

function PetMazeResetConfirmDlg:onClickBtnConfirm()
	local stageId = self.data and self.data.id or 0

	RPC.petMazeReset(self.actObj.opId, self.actData.layer, stageId)
	self:setVisible(false)
end

function PetMazeResetConfirmDlg:onClickBtnCancel()
	self:setVisible(false)
end

return PetMazeResetConfirmDlg
