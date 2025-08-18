-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeBattleResultFailDlg.lua

local HeroGridBloodCardChild = require("UI/Maze/HeroGridBloodCardChild")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local ResColor = require("ClientData/ResColor")
local strClassName = "MazeBattleResultFailDlg"
local MazeBattleResultFailDlg = Class(strClassName, UIControls.Window)
local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew"
local ICON_PATH1 = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew1"

MixinClass(MazeBattleResultFailDlg, BattleAwardMixin, true)

function MazeBattleResultFailDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function MazeBattleResultFailDlg:initUI(...)
	self.panelBgHero = UIControls.Panel(self, "BgPanel/HeroPanel")
	self.panelResultHero = UIControls.Panel(self, "ResultPanel/HeroPanel")
	self.imgResult = UIControls.Image(self, "BgPanel/InfoPanel/ImgVictory")
	self.imgBgVictory = UIControls.Image(self, "BgPanel/InfoPanel/BgVictory")
	self.txtTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.btnBattleData = UIControls.Button(self, "BgPanel/BtnPanel/BtnBattleData")

	self.btnBattleData:addEventClick(self.onBtnBattleDataClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.r = {}
	self.r.imgResult = UIControls.Image(self, "ResultPanel/ImgResult")
	self.r.imgBg = UIControls.Image(self, "ResultPanel/BgText")
	self.r.txt = UIControls.Label(self, "ResultPanel/Text")
	self.r.imgLineM = UIControls.Image(self, "ResultPanel/ImgLineM")
	self.r.imgLineL = UIControls.Image(self, "ResultPanel/ImgLineL")
	self.r.imgLineR = UIControls.Image(self, "ResultPanel/ImgLineR")
	self.r.imgLineLS = UIControls.Image(self, "ResultPanel/ImgLineLS")
	self.r.imgLineRS = UIControls.Image(self, "ResultPanel/ImgLineRS")
end

function MazeBattleResultFailDlg:show(battleType, bonus, itemBonus, heros, result)
	self.heros = heros
	self.battleState = GameFsm.getState(Const.STATE_BATTLE)
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

	if result == BattleConst.BATTLE_RESULT_SURRENDER or result == BattleConst.BATTLE_RESULT_LOSE then
		self.r.txt:setFontColor(ResColor.QUALITYBLUE)
		self.imgResult:setImage(ICON_PATH, "BgDefeated")
		self.r.imgResult:setImage(ICON_PATH, "BgDefeated")
		self.imgBgVictory:setImage(ICON_PATH, "BgDefeated1")
		self.r.imgBg:setImage(ICON_PATH1, "BgDefeatBigB")
		self.r.imgLineM:setImage(ICON_PATH1, "BgBlueBottom1")
		self.r.imgLineL:setImage(ICON_PATH1, "BgBlueBottom2")
		self.r.imgLineR:setImage(ICON_PATH1, "BgBlueBottom2")
		self.r.imgLineLS:setImage(ICON_PATH1, "BgBlueBottom3")
		self.r.imgLineRS:setImage(ICON_PATH1, "BgBlueBottom3")
		self:playAni("BattleResultFail", nil, true)
	else
		self.r.txt:setFontColor(ResColor.GREYMIDDLE)
		self.r.imgResult:setImage(ICON_PATH, "BgOvertime")
		self.imgResult:setImage(ICON_PATH, "BgOvertime")
		self.imgBgVictory:setImage(ICON_PATH, "BgOvertime1")
		self.r.imgBg:setImage(ICON_PATH1, "BgDefeatBigG")
		self.r.imgLineM:setImage(ICON_PATH1, "BgGreyBottom1")
		self.r.imgLineL:setImage(ICON_PATH1, "BgGreyBottom2")
		self.r.imgLineR:setImage(ICON_PATH1, "BgGreyBottom2")
		self.r.imgLineLS:setImage(ICON_PATH1, "BgGreyBottom3")
		self.r.imgLineRS:setImage(ICON_PATH1, "BgGreyBottom3")
		self:playAni("BattleResultFailTimeOut", nil, true)
	end
end

function MazeBattleResultFailDlg:initHeroPanel(path)
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

function MazeBattleResultFailDlg:getHeroBlood(battleHero)
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

function MazeBattleResultFailDlg:onBtnBattleDataClick(...)
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function MazeBattleResultFailDlg:onBtnConfirmClick(...)
	if CurAvatar.needResetMaze then
		CurAvatar:resetMazeTip(true)
	else
		if not GameFsm.isInState(Const.STATE_BATTLE) then
			return
		end

		if not self.noEnterMain then
			self:checkExitBattle(true)
		end
	end
end

function MazeBattleResultFailDlg:playNextAni()
	self:playAni("ChangeBattleResultMazzFail", nil)
end

return MazeBattleResultFailDlg
