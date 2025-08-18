-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleResultFailDlg.lua

local MazeBattleResultFailDlg = require("UI/Maze/MazeBattleResultFailDlg")
local SneakBattleResultFailDlg = Class("SneakBattleResultFailDlg", MazeBattleResultFailDlg)
local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew"
local ICON_PATH1 = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew1"

function SneakBattleResultFailDlg:ctor(...)
	return
end

function SneakBattleResultFailDlg:show(battleType, bonus, itemBonus, heros, result)
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

	local actData = CurAvatar:getSneakBattleActivityData()

	if actData then
		actData:checkNeedToLowerLevel()
	end
end

function SneakBattleResultFailDlg:onBtnConfirmClick(...)
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	self:checkExitBattle(true)
end

return SneakBattleResultFailDlg
