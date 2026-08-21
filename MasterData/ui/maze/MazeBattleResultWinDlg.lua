-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeBattleResultWinDlg.lua

local HeroGridBloodCardChild = require("UI/Maze/HeroGridBloodCardChild")
local strClassName = "MazeBattleResultWinDlg"
local MazeBattleResultWinDlg = Class(strClassName, UIControls.Window)

function MazeBattleResultWinDlg:ctor(...)
	self:initUI()
end

function MazeBattleResultWinDlg:initUI(...)
	self.panelBgHero = UIControls.Panel(self, "BgPanel/HeroPanel")
	self.panelResultHero = UIControls.Panel(self, "ResultPanel/HeroPanel")
	self.txtTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.btnBattleData = UIControls.Button(self, "BgPanel/BtnBattleData")

	self.btnBattleData:addEventClick(self.onBtnBattleDataClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function MazeBattleResultWinDlg:show(battleType, bonus, itemBonus, heros)
	self.heros = heros
	self.battleState = GameFsm.getState(Const.STATE_BATTLE)
	self.battleType = battleType
	self.finish = bonus
	self.commonBonus = bonus.common
	self.itemBonus = itemBonus or {}

	local time = 0
	local bObjMgr = self.battleState:getBattleObjMgr()

	if bObjMgr then
		time = bObjMgr:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.txtTime:setText(utils.calcTimeTxt(timeSec))
	self:initHeroPanel("BgPanel")
	self:initHeroPanel("ResultPanel")
end

function MazeBattleResultWinDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		MazeBattleResultWinDlg.super.bgmOn(self)
	end
end

function MazeBattleResultWinDlg:initHeroPanel(path)
	for _, hero in ipairs(self.heros) do
		if CurAvatar.heroDic[hero.gid] then
			local cell = HeroGridBloodCardChild(self, path .. "/HeroPanel/Content", "System/Hero/GridHeroCardBlood", 0, 0, true)

			cell:setHero(CurAvatar.heroDic[hero.gid])

			local hpPercentValue = self:getHeroBlood(hero)

			cell:setHeroBlood(hpPercentValue)
		end
	end

	local scrollPanel = UIControls.ScrollView(self, path .. "/HeroPanel")
	local panelBlock = UIControls.Panel(self, path .. "/HeroBlock")

	if #self.heros <= 5 then
		scrollPanel:cancelScroll()
	else
		panelBlock:setVisible(false)
	end
end

function MazeBattleResultWinDlg:getHeroBlood(battleHero)
	local data = self.battleState.battlePreInfo.mazeData

	if data then
		if data.baseData.branchs[data.branchIndex].type == Const.MAZE_DIE_BATTLE_NODE then
			return battleHero.hp / battleHero.mhp * 10000
		else
			local hero = CurAvatar.heroDic[battleHero.gid]

			return hero.mazeHp
		end
	end

	return 0
end

function MazeBattleResultWinDlg:onBtnBattleDataClick(...)
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function MazeBattleResultWinDlg:onBtnConfirmClick(...)
	self:setVisible(false)
	UIManager.getUI("pvpResultAwardDlg", true):show(self.itemBonus, self.battleType, self.finish)
end

function MazeBattleResultWinDlg:playNextAni()
	self:playAni("ChangeBattleResultMazzWin", nil)
end

return MazeBattleResultWinDlg
