-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\OnceTowerLevelDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResOnceTower = require("ClientData/ResOnceTower")
local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local Monster = require("Common/Object/Monster")
local OnceTowerLevelBtn = Class("OnceTowerLevelBtn", UIControls.Child)

function OnceTowerLevelBtn:ctor()
	self.btnChoose = UIControls.Button(self, "BtnLv", "TextLv")

	self.btnChoose:addEventClick(self.onChooseClick)

	self.textChooseNum = UIControls.Label(self, "BtnLv/TextNum")
	self.imgChooseSel = UIControls.Image(self, "BtnLv/ImgSel")
	self.btnDis = UIControls.Button(self, "BtnLvDis", "TextLv")

	self.btnDis:addEventClick(self.onDisClick)

	self.textChooseDisNum = UIControls.Label(self, "BtnLvDis/TextNum")
	self.imgChooseSelDis = UIControls.Image(self, "BtnLvDis/ImgSel")
	self.iconMark = UIControls.Image(self, "BtnLv/IconMark")
	self.iconMarkDis = UIControls.Image(self, "BtnLvDis/IconMark")
end

function OnceTowerLevelBtn:setData(level, passedLevel)
	self.level = level
	self.levelData = ResOnceTower[self.level]

	if self.levelData then
		if level <= passedLevel + 1 then
			self.btnChoose:setVisible(true)
			self.btnDis:setVisible(false)
			self.textChooseNum:setText(self.level)
			self.btnChoose:setText(self.levelData.name or "")
		else
			self.btnChoose:setVisible(false)
			self.btnDis:setVisible(true)
			self.textChooseDisNum:setText(self.level)
			self.btnDis:setText(self.levelData.name or "")
		end

		if self.levelData.is_key then
			self.iconMark:setVisible(true)
			self.iconMarkDis:setVisible(true)
		else
			self.iconMark:setVisible(false)
			self.iconMarkDis:setVisible(false)
		end
	end
end

function OnceTowerLevelBtn:onChooseClick()
	self.mParent:onSelectLevel(self)
end

function OnceTowerLevelBtn:onDisClick()
	self.mParent:onSelectLevel(self)
end

function OnceTowerLevelBtn:onSelected(selected)
	self.btnChoose:setEnable(not selected)
	self.btnDis:setEnable(not selected)
	self.imgChooseSel:setVisible(selected)
	self.imgChooseSelDis:setVisible(selected)
end

local OnceTowerLevelDlg = Class("OnceTowerLevelDlg", UIControls.Window)

function OnceTowerLevelDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onTipsClick)

	self.textName = UIControls.Label(self, "MainInfoPanel/LvInfoPanel/TextLv")
	self.textLevel = UIControls.Label(self, "MainInfoPanel/LvInfoPanel/TextLv/TextNum")
	self.textDesc = UIControls.Label(self, "MainInfoPanel/LvInfoPanel/TextDes")
	self.btnBattle = UIControls.Button(self, "MainInfoPanel/LvInfoPanel/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBattleClick)

	self.labelLock = UIControls.Label(self, "MainInfoPanel/LvInfoPanel/TextLock")

	self.labelLock:setVisible(true)

	self.panelPassed = UIControls.Panel(self, "MainInfoPanel/LvInfoPanel/ImgComplete")
	self.btnRanking = UIControls.Button(self, "MainInfoPanel/LvInfoPanel/BtnRanking")

	self.btnRanking:addEventClick(self.onBtnRankingClick)

	self.textRecommand = UIControls.Label(self, "MainInfoPanel/LvInfoPanel/TextSuggest")

	self.textRecommand:setVisible(false)

	self.btnVideo = UIControls.Button(self, "MainInfoPanel/LvInfoPanel/BtnVideo")

	self.btnVideo:addEventClick(self.onVideoClick)

	self.levelCells = {}
	self.monsterCells = {}

	for index = 1, 4 do
		local newCell = UIControls.MonsterCardChild(self, "MainInfoPanel/LvInfoPanel/MonsterPanel/MonsterList", "System/Common/Grid/GridMonster")

		table.insert(self.monsterCells, newCell)
	end

	self.titleAward = UIControls.Label(self, "MainInfoPanel/LvInfoPanel/AwardPanel/TextAwardTitle")
	self.panelAwardMark = UIControls.Panel(self, "MainInfoPanel/LvInfoPanel/AwardPanel/TextAwardTitle/MaskMark")
	self.awardGrids = {}
	self.btnMoreMonster = UIControls.Button(self, "MainInfoPanel/LvInfoPanel/MonsterPanel/MonsterList/BtnMoreMonster")

	self.btnMoreMonster:addEventClick(self.onMoreMonsterClick)
end

function OnceTowerLevelDlg:onBtnRankingClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_ONCETOWER)
end

function OnceTowerLevelDlg:onCloseClick()
	self:setVisible(false)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_CLOSE)
end

function OnceTowerLevelDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_ONCETOWER)
end

function OnceTowerLevelDlg:onOpen()
	OnceTowerLevelDlg.super.onOpen(self)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_OPEN)
	self:refreshData()
end

function OnceTowerLevelDlg:refreshData()
	self.passedLevel = CurAvatar.onceTowerLevel or 0

	local maxLevel = #ResOnceTower
	local startLevel = math.max(1, self.passedLevel - 1)
	local showNum = math.min(10, maxLevel - startLevel + 1)

	for index = #self.levelCells, showNum - 1 do
		local newCell = OnceTowerLevelBtn(self, "MainInfoPanel/LvChooseList/Content", "System/OneTimeTower/OneTimeTowerLvCell")

		table.insert(self.levelCells, newCell)
	end

	for index, cell in ipairs(self.levelCells) do
		if index <= showNum then
			local nowLevel = index - 1 + startLevel

			cell:setVisible(true)
			cell:setData(nowLevel, self.passedLevel)
		else
			cell:setVisible(false)
		end
	end

	if maxLevel > startLevel + showNum - 1 then
		if not self.moreCell then
			self.moreCell = UIControls.Child(self, "MainInfoPanel/LvChooseList/Content", "System/OneTimeTower/OneTimeTowerLvMoreCell")
		end

		self.moreCell:setVisible(true)
	elseif self.moreCell then
		self.moreCell:setVisible(false)
	end

	if ResOnceTower[self.passedLevel + 1] then
		self:onSelectLevel(self.levelCells[self.passedLevel + 2 - startLevel])
	else
		self:onSelectLevel(self.levelCells[self.passedLevel + 1 - startLevel])
	end
end

function OnceTowerLevelDlg:onSelectLevel(sender)
	self.selectLevel = sender.level

	for index, cell in ipairs(self.levelCells) do
		cell:onSelected(cell == sender)
	end

	self.levelData = ResOnceTower[self.selectLevel] or {}
	self.checkCanEnter = false

	if self.selectLevel <= self.passedLevel then
		self.labelLock:setText("")
		self.btnBattle:setVisible(false)
		self.panelPassed:setVisible(true)
	elseif self.selectLevel == self.passedLevel + 1 then
		self.checkCanEnter = true

		self.labelLock:setText("")
		self.btnBattle:setVisible(true)
		self.panelPassed:setVisible(false)
	else
		if ResOnceTower[self.selectLevel - 1] then
			self.labelLock:setText(string.format(Lang.get(30505), ResOnceTower[self.selectLevel - 1].name or ""))
		end

		self.btnBattle:setVisible(false)
		self.panelPassed:setVisible(false)
	end

	if Const.REVIEW_VERSION then
		self.textName:setText("层 " .. (self.levelData.name or ""))
	else
		self.textName:setText("F " .. (self.levelData.name or ""))
	end

	self.textLevel:setText(self.selectLevel)
	self.textDesc:setText(self.levelData.desc or "")

	if self.levelData.is_key then
		self.titleAward:setText(Lang.get(30506))
		self.panelAwardMark:setVisible(true)
	else
		self.titleAward:setText(Lang.get(1513))
		self.panelAwardMark:setVisible(false)
	end

	local bonus = ResRandClient[self.levelData.award] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	for index = #self.awardGrids, #showIds - 1 do
		local newGrid = UIControls.getGridContainer(self, "MainInfoPanel/LvInfoPanel/AwardPanel/AwardList")

		table.insert(self.awardGrids, newGrid)
	end

	for index, grid in ipairs(self.awardGrids) do
		if showIds[index] then
			local clientItem = BaseObject.GetObject(showIds[index], showNums[index] or 1)

			grid:setObj(clientItem)

			grid.grid.mDisableWays = true

			grid:setVisible(true)
		else
			grid:setVisible(false)
		end
	end

	local battleConfig = ResBattleConfig[self.levelData.pve_id] or {}
	local monsters = battleConfig.monsters or {}

	self.monsterObjs = {}

	for pos, monsterId in ipairs(monsters) do
		if monsterId and monsterId ~= 0 then
			local newMonster = Monster(monsterId, battleConfig.monster_level or 1)

			table.insert(self.monsterObjs, newMonster)
		end
	end

	local showMore = #self.monsterObjs > 4

	for index, cell in ipairs(self.monsterCells) do
		if self.monsterObjs[index] and (not showMore or index < 4) then
			cell:setVisible(true)
			cell:setObj(self.monsterObjs[index])
		else
			cell:setVisible(false)
		end
	end

	if showMore then
		self.btnMoreMonster:setVisible(true)
	else
		self.btnMoreMonster:setVisible(false)
	end
end

function OnceTowerLevelDlg:onMoreMonsterClick()
	UIManager.getUI("onceTowerMonsterDlg", true):onShow(self.monsterObjs)
end

function OnceTowerLevelDlg:onBattleClick()
	if self.levelData and self.levelData.pve_id then
		local battleData = {}

		battleData.onceTowerData = {}
		battleData.onceTowerData.layerData = self.levelData

		CurAvatar:enterFormation(self.levelData.pve_id, BattleConst.BATTLE_TYPE_ONCETOWER, battleData)
	end
end

function OnceTowerLevelDlg:onVideoClick()
	if self.recordData and self.recordData[self.selectLevel] then
		self:onOnceTowerReplayRecordResp(self.selectLevel, self.recordData[self.selectLevel])
	else
		RPC.onceTowerReplayRecord(self.selectLevel)
	end
end

function OnceTowerLevelDlg:onOnceTowerReplayRecordResp(layer, data)
	if not self.recordData then
		self.recordData = {}
	end

	self.recordData[layer] = data

	local extra = {
		battleType = BattleConst.BATTLE_TYPE_ONCETOWER,
		checkCanEnter = self.checkCanEnter,
		onBattleClick = Slot(self.onBattleClick, self)
	}

	UIManager.getUI("onceTowerRecordDlg", true):setData(Const.BATTLE_REPLAY_ONCE_TOWER, data, layer, extra)
end

function OnceTowerLevelDlg:recoveryFromReplay(replayEnv)
	local layer = replayEnv.onceTowerLayer

	if layer then
		for index, cell in ipairs(self.levelCells) do
			if cell.level == layer then
				self:onSelectLevel(cell)
				self:onVideoClick()

				break
			end
		end
	end
end

return OnceTowerLevelDlg
