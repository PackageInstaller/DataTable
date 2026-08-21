-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleTopPvpResultFailDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "battleTopPvpResultFailDlg"
local BattleTopPvpResultFailDlg = Class(strClassName, UIControls.Window)

function BattleTopPvpResultFailDlg:ctor(...)
	self:initUI()
end

function BattleTopPvpResultFailDlg:initUI(...)
	self.txtScore2 = UIControls.Label(self, "ResultPanel/TextScore")
	self.txtMyName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/TextName")
	self.txtOtherName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/TextName")
	self.btnHeadMine = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadMine:setEnable(false)

	self.btnHeadOther = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadOther:setEnable(false)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.textTitle = UIControls.Label(self, "ChangeList/TextTitle")
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

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local isInGroupMatch = actData:checkTopPvpIsInGroupMatch()

		if isInGroupMatch then
			self.textTitle:setVisible(not isInGroupMatch)
		end
	end
end

function BattleTopPvpResultFailDlg:onOpen(...)
	BattleTopPvpResultFailDlg.super.onOpen(self)

	self.battleState = GameFsm.getState(Const.STATE_BATTLE)

	local winNum, loseNum = self.battleState:getRoundScore()

	self.txtScore2:setText(winNum .. ":" .. loseNum)

	self.isFightAll = winNum == 2 or loseNum == 2

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHeadMine:setCommInfo(commInfo, false, self)

	local name = utils.GetPlayerName(commInfo.name)

	self.txtMyName:setText(name)

	if ClientUtils.record.topPvpCacheData and ClientUtils.record.topPvpCacheData.comm then
		local otherComm = ClientUtils.record.topPvpCacheData.comm

		self.btnHeadOther:setCommInfo(otherComm, false, self)

		local name = utils.GetPlayerName(otherComm.name)

		self.txtOtherName:setText(name)
	end
end

function BattleTopPvpResultFailDlg:onOpenOver(...)
	BattleTopPvpResultFailDlg.super.onOpenOver(self)

	if self.isMiddleFight == true then
		self:playNextAni()
	end
end

function BattleTopPvpResultFailDlg:setMiddleFight(...)
	self.isMiddleFight = true
end

function BattleTopPvpResultFailDlg:show(battleType, teamResult, finish, itemBonus)
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
end

function BattleTopPvpResultFailDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultTopPVPFail", nil, true)
	else
		self:playAni("HideBattleResultSeniorPVPFailS", Functor(self._nextFight, self, false), true)
	end
end

function BattleTopPvpResultFailDlg:_nextFight(isLeaveBattle)
	if self.battleState then
		self.battleState:startFightNextTeam()
	end

	self:_close(isLeaveBattle)
end

function BattleTopPvpResultFailDlg:_close(isLeaveBattle)
	self.readyLeaveBattle = isLeaveBattle

	self:setVisible(false)
end

function BattleTopPvpResultFailDlg:destroy(...)
	BattleTopPvpResultFailDlg.super.destroy(self)

	if self.readyLeaveBattle == true and not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	if self.readyLeaveBattle then
		GameFsm.getCurState():exitBattle(true)
	end
end

function BattleTopPvpResultFailDlg:onBtnBattleDataClick(sender)
	local index = sender.index
	local objMgr = self.teamResult[index][2]

	UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
end

function BattleTopPvpResultFailDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultTopPVPFail", Functor(self._close, self, true), true)
end

return BattleTopPvpResultFailDlg
