-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleOpactPvpResultFailDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "BattleOpactPvpResultFailDlg"
local BattleOpactPvpResultFailDlg = Class(strClassName, UIControls.Window)
local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew2"

function BattleOpactPvpResultFailDlg:ctor(...)
	self:initUI()
end

function BattleOpactPvpResultFailDlg:initUI(...)
	self.txtScore2 = UIControls.Label(self, "ResultPanel/TextScore")
	self.txtMyName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/TextName")
	self.txtOtherName = UIControls.Label(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/TextName")
	self.txtRank = UIControls.Label(self, "ChangeList/RankChangePanel/TextRank")
	self.txtScore = UIControls.Label(self, "ChangeList/ScoreChangePanel/TextScore")
	self.imgRankArrow = UIControls.Image(self, "ChangeList/RankChangePanel/ImgArrow")
	self.imgScoreArrow = UIControls.Image(self, "ChangeList/ScoreChangePanel/ImgArrow")
	self.btnHeadMine = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadMine:setEnable(false)

	self.btnHeadOther = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHeadOther:setEnable(false)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

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

function BattleOpactPvpResultFailDlg:onOpen(...)
	BattleOpactPvpResultFailDlg.super.onOpen(self)

	self.battleState = GameFsm.getState(Const.STATE_BATTLE)

	local winNum, loseNum = self.battleState:getRoundScore()

	self.txtScore2:setText(winNum .. ":" .. loseNum)

	self.isFightAll = winNum == 2 or loseNum == 2

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHeadMine:setCommInfo(commInfo, false, self)

	local name = utils.GetPlayerName(commInfo.name)

	self.txtMyName:setText(name)

	if ClientUtils.record.opactPvpCacheData and ClientUtils.record.opactPvpCacheData.comm then
		local otherComm = ClientUtils.record.opactPvpCacheData.comm

		self.btnHeadOther:setCommInfo(otherComm, false, self)

		local name = utils.GetPlayerName(otherComm.name)

		self.txtOtherName:setText(name)
	end
end

function BattleOpactPvpResultFailDlg:onOpenOver(...)
	BattleOpactPvpResultFailDlg.super.onOpenOver(self)

	if self.isMiddleFight == true then
		self:playNextAni()
	end
end

function BattleOpactPvpResultFailDlg:setMiddleFight(...)
	self.isMiddleFight = true
end

function BattleOpactPvpResultFailDlg:show(battleType, teamResult, finish, itemBonus)
	self.teamResult = teamResult
	self.itemBonus = itemBonus
	self.battleType = battleType
	self.finish = finish

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
					self.recordInfos[i].myFormation:setPet(myPet, not isWin)
					self.recordInfos[i].myFormation:setResultState(isWin)
					self.recordInfos[i].OtherFormation:setHeros(otherHeros, i, isWin)
					self.recordInfos[i].OtherFormation:setPet(otherPet, isWin)
					self.recordInfos[i].OtherFormation:setResultState(not isWin)
				end
			else
				self.recordInfos[i].btnBattleData:setVisible(false)
			end
		end
	end
end

function BattleOpactPvpResultFailDlg:setRankData()
	local preRank = ClientUtils.record.opactPvpCacheData.rank or 0
	local curRank = CurAvatar.opactPvpRank or 0

	self.txtRank:jumpTo(preRank, curRank, 1)

	local score = 0
	local actData = CurAvatar:getPVPArenaActivityData()

	if actData then
		score = actData.score
	end

	local preScore = ClientUtils.record.opactPvpCacheData.score

	self.txtScore:jumpTo(preScore, score, 1)

	if preRank == curRank then
		self.imgRankArrow:setVisible(false)
	elseif preRank < curRank then
		self.imgRankArrow:setImage(ICON_PATH, "IconReduce")
	else
		self.imgRankArrow:setImage(ICON_PATH, "IconPromote")
	end

	if preScore == score then
		self.imgScoreArrow:setVisible(false)
	elseif score < preScore then
		self.imgScoreArrow:setImage(ICON_PATH, "IconReduce")
	else
		self.imgScoreArrow:setImage(ICON_PATH, "IconPromote")
	end
end

function BattleOpactPvpResultFailDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultActivityPVPFail", nil, true)
		self:setRankData()
	else
		self:playAni("HideBattleResultSeniorPVPFailS", Functor(self._nextFight, self, false), true)
	end
end

function BattleOpactPvpResultFailDlg:_nextFight(isLeaveBattle)
	if self.battleState then
		self.battleState:startFightNextTeam()
	end

	self:_close(isLeaveBattle)
end

function BattleOpactPvpResultFailDlg:_close(isLeaveBattle)
	self.readyLeaveBattle = isLeaveBattle

	self:setVisible(false)
end

function BattleOpactPvpResultFailDlg:destroy(...)
	BattleOpactPvpResultFailDlg.super.destroy(self)

	if self.readyLeaveBattle == true then
		local actData = CurAvatar:getPVPArenaActivityData()

		if actData then
			local zoneInfo = PVPCommon.getZoneInfo(actData.league)

			if zoneInfo then
				self.itemBonus = ClientUtils.getObjectByRandId(zoneInfo.award)
			end
		end

		if self.itemBonus == nil then
			self.itemBonus = {}
		end

		UIManager.getUI("pvpResultAwardDlg", true):show(self.itemBonus, self.battleType, self.finish)
	end
end

function BattleOpactPvpResultFailDlg:onBtnBattleDataClick(sender)
	local index = sender.index
	local objMgr = self.teamResult[index][2]

	UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
end

function BattleOpactPvpResultFailDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultActivityPVPFail", Functor(self._close, self, true), true)
end

return BattleOpactPvpResultFailDlg
