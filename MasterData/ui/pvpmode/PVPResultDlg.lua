-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPResultDlg.lua

local strClassName = "PVPResultDlg"
local PVPResultDlg = Class(strClassName, UIControls.Window)
local ResultSidePanel = require("UI/PVPMode/ResultSidePanel")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")

MixinClass(PVPResultDlg, BattleAwardMixin, true)

function PVPResultDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function PVPResultDlg:initUI()
	self.imgResult = UIControls.Image(self, "BgPanel/ImgResult")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")
	self.btnBattleData = UIControls.Button(self, "BgPanel/BtnBattleData")

	self.btnBattleData:addEventClick(self.onBtnBattleDataClick)
	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.myInfo = ResultSidePanel(self, "BgPanel/SelfInfoPanel/")

	self.myInfo:exraUI()

	self.enemyInfo = ResultSidePanel(self, "BgPanel/EnemyInfoPanel/")
end

local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew"

function PVPResultDlg:show(battleType, result, finish, itemBonus)
	self.battleType = battleType
	self.finish = finish
	self.win = result == BattleConst.BATTLE_RESULT_WIN

	if self.win then
		self:playAni("StartAsynPVPWin", nil, true)
		self.imgResult:setImage(ICON_PATH, "BgSuccess2")
	else
		self:playAni("StartAsynPVPFail", nil, true)
		self.imgResult:setImage(ICON_PATH, "BgDefeated2")
	end

	self.itemBonus = itemBonus

	local data = finish.spec.async_pvp

	self.myData = {}
	self.myData.changeScore = data.score
	self.myData.score = CurAvatar:getPvpScore()
	self.myData.rank = data.rank
	self.myData.name = CurAvatar:getPlayerName()
	self.myData.level = CurAvatar:getLevel()
	self.myData.gender = CurAvatar.gender
	self.myData.head = CurAvatar.head
	self.myData.headFrameId = CurAvatar.headFrameId
	self.myData.uid = CurAvatar.uid
	self.enemyData = {}
	self.enemyData.score = data.opponent_score
	self.enemyData.rank = data.opponent_rank
	self.enemyData.level = data.opponent_comm.level
	self.enemyData.name = data.opponent_comm.name
	self.enemyData.gender = data.opponent_comm.gender
	self.enemyData.uid = data.opponent_comm.uid
	self.enemyData.head = data.opponent_comm.head
	self.enemyData.headFrameId = data.opponent_comm.head_frame_id

	if PVPResultDlg.cachedPvpResultData then
		local info = PVPResultDlg.cachedPvpResultData

		self:showData(info.attack, info.defend)
	end
end

function PVPResultDlg.setPvpResultData(data)
	PVPResultDlg.cachedPvpResultData = data
end

function PVPResultDlg:showData(attack, defend)
	self.myData.changeScore = attack.score - attack.old_score
	self.myData.score = attack.score
	self.myData.rank = attack.rank
	self.enemyData.score = defend.score
	self.enemyData.rank = defend.rank

	self:initData()

	PVPResultDlg.cachedPvpResultData = nil
end

function PVPResultDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		PVPResultDlg.super.bgmOn(self)
	end
end

function PVPResultDlg:initData()
	self.myInfo:initData(self.myData)
	self.enemyInfo:initData(self.enemyData)
end

function PVPResultDlg:onBtnBattleDataClick()
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function PVPResultDlg:onBtnConfirmClick()
	if self.win then
		UIManager.getUI("pvpResultAwardDlg", true):show(self.itemBonus, self.battleType, self.finish)
		self:setVisible(false)
	else
		if not GameFsm.isInState(Const.STATE_BATTLE) then
			return
		end

		self:checkExitBattle(true)
	end
end

function PVPResultDlg:playNextAni()
	if self.win then
		self:playAni("ChangeAsynPVPWin", nil, true)
	else
		self:playAni("ChangeAsynPVPFail", nil, true)
	end
end

function PVPResultDlg:destroy()
	PVPResultDlg.super.destroy(self)
end

return PVPResultDlg
