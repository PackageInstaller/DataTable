-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeResetDlg.lua

local ResPetMazeNormalStage = require("ClientData/ResPetMazeNormalStage")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeQuality = require("ClientData/ResPetMazeQuality")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local EventConst = require("EventConst")
local AreaNode = Class("PetMazeResetDlg_AreaNode", UIControls.Child)

function AreaNode:ctor()
	self.btnReset = UIControls.Button(self, "FinishPanel/BtnReset")

	self.btnReset:addEventClick(self.onClickBtnReset)

	self.imgBg = UIControls.Image(self, "")
	self.imgMonster = UIControls.Image(self, "FinishPanel/MonsterInfoPanel/ImgMonster")
	self.imgSpecial = UIControls.Image(self, "FinishPanel/HeroPanel/ImgSpecial")
end

function AreaNode:setData(actData, data)
	self.actData = actData
	self.data = data

	local layer = actData.layer
	local stageConfig = ResPetMazeNormalStage[self.data.id]

	if stageConfig and stageConfig.icon_path and stageConfig.icon_name then
		self.imgMonster:setImage(stageConfig.icon_path, stageConfig.icon_name)
	end

	local heroList = self.data.selectHeroList
	local heroNum = #heroList
	local checkHaveSpecialHero = false

	if heroNum > 0 then
		checkHaveSpecialHero = heroList[1].id == self.data.specialHeroId
		self.heroNodeList = self.heroNodeList or {}

		local nodeNum = #self.heroNodeList

		for i = 1, heroNum do
			local node

			if i <= nodeNum then
				node = self.heroNodeList[i]
			else
				if i == 1 then
					node = GridHeroStarUp(self, "FinishPanel/HeroPanel/ImgBg", "System/StarUp/GridHeroStarUp")
				else
					node = GridHeroStarUp(self, "FinishPanel/HeroPanel/HeroList", "System/StarUp/GridHeroStarUp")
				end

				table.insert(self.heroNodeList, node)
			end

			node:setHero(heroList[i])
			node:setVisible(true)
		end

		if heroNum < nodeNum then
			for i = heroNum + 1, nodeNum do
				self.heroNodeList[i]:setVisible(false)
			end
		end
	end

	self.imgSpecial:setVisible(checkHaveSpecialHero)
	self.imgBg:setImage("Atlas/MazzPetAtlas/MazzPetAtlas14", "BgReset" .. self.data.quality)

	self.awardCellList = self.awardCellList or {}

	local awardList = {}
	local qualityConfig = ResPetMazeQuality[layer][self.data.quality]

	if checkHaveSpecialHero then
		local layerConfig = ResPetMazeLayer[layer]

		table.insert(awardList, layerConfig.spec_award)
		table.insert(awardList, qualityConfig.quality_award)
	else
		table.insert(awardList, qualityConfig.quality_award)
	end

	ClientUtils.CreatePreviewBonusSumGrid(self, self.awardCellList, "FinishPanel/AwardPanel/AwardList", awardList, nil, nil, true)
end

function AreaNode:onClickBtnReset()
	local ui = UIManager.getUI("petMazeResetConfirmDlg", true)

	ui:setData(self.actData, self.data)
end

local PetMazeResetDlg = Class("PetMazeResetDlg", UIControls.Window)

function PetMazeResetDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.txtTime = UIControls.Label(self, "BgPanel/TxtTime")
	self.emptyPanel = UIControls.Panel(self, "BgPanel/ImgNothing")
	self.slotOnActivityDataChange = Slot(self.refreshView, self)
	self.areaNodeList = {}
end

function PetMazeResetDlg:onOpen()
	PetMazeResetDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.ACTIVITY_DATA_CHANGE, self.slotOnActivityDataChange)
end

function PetMazeResetDlg:onClose()
	EventCenter.removeEventListener(EventConst.ACTIVITY_DATA_CHANGE, self.slotOnActivityDataChange)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	PetMazeResetDlg.super.onClose(self)
end

function PetMazeResetDlg:setData(actData)
	self.actData = actData

	self:refreshView()
end

function PetMazeResetDlg:refreshView()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actData:getSeasonLeftTime(), false, Lang.get(78801), Slot(self.timerOver, self))

	local dataList = self.actData.normalAreaDataList
	local showDataList = {}

	for i = 1, #dataList do
		local areaData = dataList[i]

		if areaData.is_pass then
			table.insert(showDataList, areaData)
		end
	end

	local dataNum = #showDataList
	local nodeNum = #self.areaNodeList

	for i = 1, dataNum do
		local node

		if i <= nodeNum then
			node = self.areaNodeList[i]
		else
			node = AreaNode(self, "BgPanel/AwardPreviewList/Content", "System/MazzPet/MazzPetAwardResetCell")

			table.insert(self.areaNodeList, node)
		end

		local data = showDataList[i]

		node:setData(self.actData, data)
		node:setVisible(true)
	end

	if dataNum < nodeNum then
		for i = dataNum + 1, nodeNum do
			self.areaNodeList[i]:setVisible(false)
		end
	end

	self.emptyPanel:setVisible(dataNum == 0)
end

function PetMazeResetDlg:timerOver()
	self.txtTime:setText("")
end

function PetMazeResetDlg:onClickBtnClose()
	self:setVisible(false)
end

return PetMazeResetDlg
