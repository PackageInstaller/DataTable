-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleVictoryDlg.lua

local ResHero = require("ClientData/ResHero")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeHpGrade = require("ClientData/ResPetMazeHpGrade")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "BattleVictoryDlg"
local BattleVictoryDlg = Class(strClassName, UIControls.Window)

MixinClass(BattleVictoryDlg, BattleAwardMixin, true)

function BattleVictoryDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function BattleVictoryDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnBattleData")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnNext:addEventClick(self.onBtnNext)

	self.panelTips = UIControls.Panel(self, "BgPanel/TipsPanel")
	self.textTips = UIControls.Label(self, "BgPanel/TipsPanel/Text")

	if UIControls.checkControlFunc(self, "ResultPanel/AttackAwardPanel") then
		self.panelAttackAward = UIControls.Panel(self, "ResultPanel/AttackAwardPanel")
		self.txtAttackRatio = UIControls.Label(self, "ResultPanel/AttackAwardPanel/Text")
	end

	if UIControls.checkControlFunc(self, "ResultPanel/WorldBossPointPanel/TextPoint") then
		self.txtResultScore = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPoint")
	end

	if UIControls.checkControlFunc(self, "ResultPanel/WorldBossPointPanel/TextPointNext") then
		self.txtResultTotalScore = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPointNext")
	end

	if UIControls.checkControlFunc(self, "ResultPanel/WorldBossPointPanel/TextPoint/BgChange/TextPointChange") then
		self.txtResultChangeScore = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPoint/BgChange/TextPointChange")
	end

	if UIControls.checkControlFunc(self, "BgPanel/InfoPanel/TextAllHurtNum") then
		self.txtLayer = UIControls.Label(self, "BgPanel/InfoPanel/TextAllHurtNum")
	end

	if UIControls.checkControlFunc(self, "BgPanel/InfoPanel/WorldBossPointPanel/TextPoint") then
		self.txtScore = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossPointPanel/TextPoint")
	end

	if UIControls.checkControlFunc(self, "BgPanel/InfoPanel/WorldBossPointPanel/TextPointNext") then
		self.txtTotalScore = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossPointPanel/TextPointNext")
	end
end

function BattleVictoryDlg:onShow(battleType, bonus, itemBonus)
	local battleState = GameFsm.getCurState()

	self.battleType = battleType
	self.finish = bonus

	if battleState.stateName ~= Const.STATE_BATTLE_REPLAY then
		self.commonBonus = bonus.common
		self.itemBonus = itemBonus or {}
	end

	local tips

	if battleType == BattleConst.BATTLE_TYPE_STAGE then
		tips = CurAvatar:getNoticeTips(2)
	elseif battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
		tips = CurAvatar:getNoticeTips(7)
	end

	if tips then
		self.panelTips:setVisible(true)
		self.textTips:setText(tips.tips_desc or "")
	else
		self.panelTips:setVisible(false)
	end

	self:_startStageBattle(battleState:getBattleObjMgr())
	self:checkReplayRound()
	self:checkCircleBattle()
	self:checkPetMazeBattle()
end

function BattleVictoryDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BattleVictoryDlg:checkCircleBattle(...)
	if self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		local battleState = GameFsm.getCurState()

		if battleState and battleState.battlePreInfo and battleState.battlePreInfo.circleBattleData then
			local isBoss = battleState.battlePreInfo.circleBattleData.isBoss

			self.panelAttackAward:setVisible(isBoss)

			local desc = ClientUtils.getClientNotice(541)
			local s = utils.format(desc .. "%1:0.2f%%", (self.finish.spec.clan_battle.boss_lose_hp or 0) * 0.01)

			self.txtAttackRatio:setText(s)
		end
	end
end

function BattleVictoryDlg:checkReplayRound(...)
	if GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		local state = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		if state:hasNextRound() then
			self.btnNext:setText(Lang.get(30127))

			self.nextReplayRound = true
		else
			self.btnNext:setText(Lang.get(104))
		end
	end
end

function BattleVictoryDlg:checkPetMazeBattle()
	if self.battleType == BattleConst.BATTLE_TYPE_MAZE_PET and self.finish.spec and self.finish.spec.pet_maze and self.finish.spec.pet_maze.boss_id and self.finish.spec.pet_maze.boss_id > 0 then
		local mazeData = self.finish.spec.pet_maze
		local maxScore = self:getBossMaxScore(mazeData.level, mazeData.boss_id)

		if self.txtResultScore then
			local str = ClientUtils.getNumShortStr(mazeData.score)

			self.txtResultScore:setText(str)
		end

		if self.txtResultTotalScore then
			local str = ClientUtils.getNumShortStr(maxScore)

			self.txtResultTotalScore:setText(str)
		end

		if self.txtResultChangeScore then
			local str = ClientUtils.getNumShortStr(mazeData.score)

			self.txtResultChangeScore:setText(str)
		end

		if self.txtLayer then
			self.txtLayer:setText(mazeData.level)
		end

		if self.txtScore then
			local str = ClientUtils.getNumShortStr(mazeData.score)

			self.txtScore:setText(str)
		end

		if self.txtTotalScore then
			local str = ClientUtils.getNumShortStr(maxScore)

			self.txtTotalScore:setText(str)
		end
	end
end

function BattleVictoryDlg:getBossMaxScore(layer, bossId)
	local layerConfig = ResPetMazeLayer[layer]
	local maxScore = 0

	if layerConfig.hp_score_rate then
		maxScore = layerConfig.hp_score_rate * 1000
	else
		local configDic = ResPetMazeHpGrade[bossId]

		for k, v in pairs(configDic) do
			if v.score and maxScore < v.score then
				maxScore = v.score
			end
		end
	end

	return maxScore
end

function BattleVictoryDlg:onBtnRecord()
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function BattleVictoryDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		BattleVictoryDlg.super.bgmOn(self)
	end
end

function BattleVictoryDlg:setNoAward(...)
	self.noAward = true
end

function BattleVictoryDlg:onBtnNext()
	self:setVisible(false)

	local battleState = GameFsm.getCurState()

	if self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY or self.noAward == true then
		self:checkExitBattle(true)
	elseif battleState.stateName == Const.STATE_BATTLE_REPLAY then
		if self.nextReplayRound == true then
			battleState:playNextRound()
		else
			self:checkExitBattle()
		end
	else
		local isEquipTower = self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER

		if self.battleType == BattleConst.BATTLE_TYPE_ONCETOWER or isEquipTower or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER or self.battleType == BattleConst.BATTLE_TYPE_RENT or self.battleType == BattleConst.BATTLE_TYPE_CIRCLE or self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
			UIManager.getUI("pvpResultAwardDlg", true):show(self.itemBonus, self.battleType, self.finish)
		elseif self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
			UIManager.getUI("seasonTowerResultAwardDlg", true):show(self.itemBonus, self.battleType, self.finish)
		else
			if CurAvatar.cacheShowHeros and CurAvatar.cacheShowHeros[Const.HERO_GET_TYPE_STAGE_WIN] then
				local cachedHero = CurAvatar.cacheShowHeros[Const.HERO_GET_TYPE_STAGE_WIN]

				if cachedHero.star >= 3 then
					local getNewHeroDlg = UIManager.getUI("getNewHeroDlg", true)

					getNewHeroDlg:setHero(cachedHero)
				end

				CurAvatar.cacheShowHeros[Const.HERO_GET_TYPE_STAGE_WIN] = nil
			end

			UIManager.getUI("battleBonusDlg", true):onShow(self.commonBonus, self.itemBonus, self.battleType, self.finish)
		end
	end
end

function BattleVictoryDlg:playNextAni()
	local animName = "ChangeBattleResultMainWin"

	if self.battleType == BattleConst.BATTLE_TYPE_MAZE_PET and self.finish.spec and self.finish.spec.pet_maze and self.finish.spec.pet_maze.boss_id and self.finish.spec.pet_maze.boss_id > 0 then
		animName = self.finish.spec.pet_maze.is_pass and self.finish.spec.pet_maze.is_pass > 0 and "ChangeBattleResultBossPerfect" or "ChangeBattleResultBossWin"
	end

	self:playAni(animName, nil)
end

function BattleVictoryDlg:destroy()
	BattleVictoryDlg.super.destroy(self)
end

return BattleVictoryDlg
