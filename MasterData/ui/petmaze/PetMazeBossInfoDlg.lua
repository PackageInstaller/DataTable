-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeBossInfoDlg.lua

local ResPetMazeBossStage = require("ClientData/ResPetMazeBossStage")
local ResPetMazeStep = require("ClientData/ResPetMazeStep")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResBattleStateShow = require("ClientData/ResBattleStateShow")
local PetMazeBossInfoDlg = Class("PetMazeBossInfoDlg", UIControls.Window)

function PetMazeBossInfoDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnBattle = UIControls.Button(self, "BgPanel/BtnBattle")

	self.btnBattle:addEventClick(self.onClickBtnBattle)

	self.btnScoreAwardMore = UIControls.Button(self, "BgPanel/ScoreAwardPanel/AwardList/BtnMoreAward")

	self.btnScoreAwardMore:addEventClick(self.onClickBtnScoreAwardMore)

	self.btnBuffMore = UIControls.Button(self, "BgPanel/BossPreviewPanel/BtnBuff")

	self.btnBuffMore:addEventClick(self.onClickBtnBuffMore)

	self.txtName = UIControls.Label(self, "BgPanel/BossPreviewPanel/TextTitle")
	self.imgRole = UIControls.Role(self, "BgPanel/ImgBg1/MonsterMask/GridHeroPortrait", 0, 0)
	self.txtScore = UIControls.Label(self, "BgPanel/ScorePanel/TextScore")
	self.sliderScore = UIControls.Slider(self, "BgPanel/ScorePanel/Slider")
	self.finishPanel = UIControls.Panel(self, "BgPanel/TextFinish")
	self.btnMonsterMore = UIControls.Button(self, "BgPanel/MonsterPreviewPanel/MonsterPanel/MonsterList/BtnMoreMonster")

	self.btnMonsterMore:addEventClick(self.onClickBtnMonsterMore)

	self.lockPanel = UIControls.Panel(self, "BgPanel/TextLock")
	self.passAwardCellList = {}
end

function PetMazeBossInfoDlg:setData(actData, data)
	self.actData = actData
	self.data = data
	self.bossId = self.data.id
	self.layer = self.actData.layer
	self.buffList = self.data.buffList
	self.stageConfig = ResPetMazeBossStage[self.bossId]
	self.layerConfig = ResPetMazeLayer[self.layer]

	self:refreshView()
end

function PetMazeBossInfoDlg:refreshView()
	if self.stageConfig then
		if self.layer == self.actData.miscConfig.max_level then
			self.pveId = self.stageConfig.last_battle_id
		else
			self.pveId = self.stageConfig.battle_id
		end

		self.txtName:setText(self.stageConfig.name)
		self.imgRole:showRole(self.stageConfig.draw_id)
	end

	self.status = self.actData:getBossStatus()

	self.btnBattle:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_READY or self.status == UIConst.PET_MAZE_BOSS_STATE_BATTLEING)
	self.finishPanel:setVisible(self.data.is_pass)
	self.lockPanel:setVisible(self.status == UIConst.PET_MAZE_BOSS_STATE_LOCK)
	self:refreshPassAward()
	self:refreshScore()
	self:refreshMonster()
end

function PetMazeBossInfoDlg:refreshMonster()
	self.monsterObjList = {}
	self.monsterNodeList = self.monsterNodeList or {}

	ClientUtils.createMonsterGrids(self, self.pveId, self.monsterObjList, self.monsterNodeList, "BgPanel/MonsterPreviewPanel/MonsterPanel/MonsterList", 3, self.btnMonsterMore)
end

function PetMazeBossInfoDlg:refreshScore()
	self.maxScore = self.actData:getBossMaxScore(self.layer, self.bossId)

	local curScore = self.data.score

	self.txtScore:setText(curScore .. "/" .. self.maxScore)

	local rate = self.maxScore > 0 and curScore / self.maxScore or 0

	self.sliderScore:setValue(rate)

	self.awardNodeList = self.awardNodeList or {}
	self.scoreConfigDic = ResPetMazeStep[self.bossId]

	local nextScore, nextAward, realMaxScore, maxAward

	for k, v in pairs(self.scoreConfigDic) do
		if curScore < k and (not nextScore or k < nextScore) then
			nextScore = k
			nextAward = v.awardid
		end

		if k <= self.maxScore and (not realMaxScore or realMaxScore < k) then
			realMaxScore = k
			maxAward = v.awardid
		end
	end

	local award = nextAward or maxAward

	if award then
		ClientUtils.CreateBonusGrid(self, self.awardNodeList, "BgPanel/ScoreAwardPanel/AwardList", award, false, nil, true)
	end
end

function PetMazeBossInfoDlg:refreshPassAward()
	local checkGot = CurAvatar.petMazeData.max_level and CurAvatar.petMazeData.max_level >= self.actData.layer or false

	ClientUtils.CreateBonusGrid(self, self.passAwardCellList, "BgPanel/ClearAwardPanel/AwardList", self.layerConfig.pass_award, true, nil, true)

	for _, grid in pairs(self.passAwardCellList) do
		grid:setState(false, checkGot, true)
	end
end

function PetMazeBossInfoDlg:onClickBtnBattle()
	self.actData:startBattle(self.bossId, nil, self.pveId)
end

function PetMazeBossInfoDlg:onClickBtnScoreAwardMore()
	local ui = UIManager.getUI("petMazeBossAwardDlg", true)

	ui:setData(self.scoreConfigDic, self.data.score, self.maxScore)
end

function PetMazeBossInfoDlg:onClickBtnBuffMore()
	local ui = UIManager.getUI("simpleBuffDlg", true)

	ui:setData(self.buffList)
end

function PetMazeBossInfoDlg:onClickBtnMonsterMore()
	UIManager.getUI("onceTowerMonsterDlg", true):onShow(self.monsterObjList)
end

function PetMazeBossInfoDlg:onClickBtnClose()
	self:setVisible(false)
end

return PetMazeBossInfoDlg
