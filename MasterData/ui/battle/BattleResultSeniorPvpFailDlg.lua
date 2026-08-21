-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleResultSeniorPvpFailDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "BattleResultSeniorPvpFailDlg"
local BattleResultSeniorPvpFailDlg = Class(strClassName, UIControls.Window)

MixinClass(BattleResultSeniorPvpFailDlg, BattleAwardMixin, true)

function BattleResultSeniorPvpFailDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function BattleResultSeniorPvpFailDlg:initUI(...)
	self.txtScore2 = UIControls.Label(self, "ResultPanel/TextScore")
	self.txtMyName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/TextName")
	self.txtOtherName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/TextName")
	self.btnHeadMine = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadMine:setEnable(false)

	self.btnHeadOther = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadOther:setEnable(false)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.rankUIDataMine = {}
	self.rankUIDataOther = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BgPanel/PlayerInfoPanel/SelfInfoPanel"
	local pathOther = "BgPanel/PlayerInfoPanel/EnemyInfoPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIDataMine[i] = UIControls.Image(self, path .. name)
		self.rankUIDataOther[i] = UIControls.Image(self, pathOther .. name)
	end

	self.recordInfos = {}

	for i = 1, 3 do
		local info = {}
		local path = "BgPanel/RecordList/Content/Record" .. i

		info.myFormation = SeniorFormation(self, path .. "/SelfTeamPanel", "System/AsynPVP/SeniorPVPTeamInfoCell")
		info.OtherFormation = SeniorFormation(self, path .. "/EnemyTeamPanel", "System/AsynPVP/SeniorPVPTeamInfoCell")
		info.btnBattleData = UIControls.Button(self, path .. "/BtnBattleData")
		info.btnBattleData.index = i

		info.btnBattleData:addEventClick(self.onBtnBattleDataClick)

		self.recordInfos[i] = info
	end
end

function BattleResultSeniorPvpFailDlg:onOpen(...)
	BattleResultSeniorPvpFailDlg.super.onOpen(self)

	self.battleState = GameFsm.getCurState()

	local winNum, loseNum = self.battleState:getRoundScore()

	self.txtScore2:setText(winNum .. ":" .. loseNum)

	self.isFightAll = winNum == 2 or loseNum == 2

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHeadMine:setCommInfo(commInfo, false, self)

	local name = utils.GetPlayerName(commInfo.name)

	self.txtMyName:setText(name)

	if ClientUtils.record.seniorPvpCacheData and ClientUtils.record.seniorPvpCacheData.comm then
		local otherComm = ClientUtils.record.seniorPvpCacheData.comm

		self.btnHeadOther:setCommInfo(otherComm, false, self)

		local name = utils.GetPlayerName(otherComm.name)

		self.txtOtherName:setText(name)
	end
end

function BattleResultSeniorPvpFailDlg:onOpenOver(...)
	BattleResultSeniorPvpFailDlg.super.onOpenOver(self)

	if self.isMiddleFight == true then
		self:playNextAni()
	end
end

function BattleResultSeniorPvpFailDlg:setMiddleFight(...)
	self.isMiddleFight = true
end

function BattleResultSeniorPvpFailDlg:show(battleType, teamResult, finish, itemBonus)
	self.teamResult = teamResult

	local count = #teamResult

	self.filterMap = {}

	local pets = self.battleState.battleTeamPets or {}

	if self.battleState.battleTeamHeros then
		for i = 1, #self.recordInfos do
			if i <= count then
				self.filterMap[i] = {}

				local heros = self.battleState.battleTeamHeros[i]

				if heros then
					local myHeros, otherHeros = {}, {}

					for _, hero in ipairs(heros) do
						self.filterMap[i][hero.gid] = true

						if hero.camp == BattleConst.CAMP_PLAYER then
							table.insert(myHeros, hero.heroObj)
						else
							table.insert(otherHeros, hero.heroObj)
						end
					end

					local thisPets = pets[i] or {}
					local myPet, otherPet

					for _, pet in ipairs(thisPets) do
						if pet.camp == BattleConst.CAMP_PLAYER then
							myPet = pet.pet
						else
							otherPet = pet.pet
						end
					end

					local isWin = teamResult[i][1] == BattleConst.BATTLE_RESULT_WIN

					self.recordInfos[i].myFormation:setHeros(myHeros, i, not isWin)
					self.recordInfos[i].myFormation:setResultState(isWin)
					self.recordInfos[i].myFormation:setPet(myPet, not isWin, CurAvatar:petSystemEnable())
					self.recordInfos[i].OtherFormation:setHeros(otherHeros, i, isWin)
					self.recordInfos[i].OtherFormation:setPet(otherPet, isWin, CurAvatar:petSystemEnable())
					self.recordInfos[i].OtherFormation:setResultState(not isWin)
				end
			else
				self.recordInfos[i].btnBattleData:setVisible(false)
			end
		end
	end

	self:setRankData(finish)
end

function BattleResultSeniorPvpFailDlg:setRankData(finish)
	if finish then
		self.myRankNew = finish.spec.multi_pvp.self_rank
		self.otherRankNew = finish.spec.multi_pvp.target_rank
		self.myInfoNew = PVPCommon.getRankPartInfo(self.myRankNew)

		PVPCommon.setRankUI(self.rankUIDataMine, self.myInfoNew)

		self.otherInfoNew = PVPCommon.getRankPartInfo(self.otherRankNew)

		PVPCommon.setRankUI(self.rankUIDataOther, self.otherInfoNew)
	end
end

function BattleResultSeniorPvpFailDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultSeniorPVPFail", nil, true)
	else
		self:playAni("HideBattleResultSeniorPVPFailS", Functor(self._nextFight, self, false), true)
	end
end

function BattleResultSeniorPvpFailDlg:_nextFight(isLeaveBattle)
	if self.battleState then
		self.battleState:startFightNextTeam()
	end

	self:_close(isLeaveBattle)
end

function BattleResultSeniorPvpFailDlg:_close(isLeaveBattle)
	self.readyLeaveBattle = isLeaveBattle

	if self:getVisible() then
		self:setVisible(false)
	end
end

function BattleResultSeniorPvpFailDlg:destroy(...)
	BattleResultSeniorPvpFailDlg.super.destroy(self)

	if self.readyLeaveBattle == true then
		if not GameFsm.isInState(Const.STATE_BATTLE) and not GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
			return
		end

		self:checkExitBattle(true)
	end
end

function BattleResultSeniorPvpFailDlg:onBtnBattleDataClick(sender)
	local index = sender.index
	local objMgr = self.teamResult[index][2]

	UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
end

function BattleResultSeniorPvpFailDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultSeniorPVPFail", Functor(self._close, self, true), true)
end

return BattleResultSeniorPvpFailDlg
